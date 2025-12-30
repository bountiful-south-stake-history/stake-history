import { useState, useEffect, useMemo } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import { useUserProfile } from '../hooks/useUserProfile'
import { usePhotoLikes } from '../hooks/usePhotoLikes'
import { supabase } from '../lib/supabase'
import { AuthModal } from '../components/auth/AuthModal'
import { PhotoLightbox } from '../components/people/PhotoLightbox'
import { PhotoLikeButton } from '../components/people/PhotoLikeButton'
import { ShareMemoryModal } from '../components/people/ShareMemoryModal'

interface TaggedPerson {
  id: string
  display_name?: string
  full_name: string
}

interface Photo {
  id: string
  photo_url: string
  caption: string
  approximate_date?: string
  event_context?: string
  submitter_name?: string
  submitted_at?: string
  taggedPeople: TaggedPerson[]
  additionalPeople: string[]
}

export function PhotoAlbumPage() {
  const { user, loading: authLoading } = useAuth()
  const { profile: userProfile, loading: profileLoading } = useUserProfile()
  const { likesMap, fetchLikesForPhotos, likePhoto, unlikePhoto } = usePhotoLikes()
  const [photos, setPhotos] = useState<Photo[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [searchQuery, setSearchQuery] = useState('')
  const [debouncedSearchQuery, setDebouncedSearchQuery] = useState('')
  const [sortOption, setSortOption] = useState<'newest' | 'oldest' | 'caption'>('newest')
  const [selectedPhoto, setSelectedPhoto] = useState<Photo | null>(null)
  const [showAuthModal, setShowAuthModal] = useState(false)
  const [shareMemoryPhoto, setShareMemoryPhoto] = useState<Photo | null>(null)

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearchQuery(searchQuery)
    }, 300)
    return () => clearTimeout(timer)
  }, [searchQuery])

  useEffect(() => {
    const fetchPhotos = async () => {
      if (!user || userProfile?.view_blocked) {
        setLoading(false)
        return
      }

      try {
        setLoading(true)
        setError(null)

        const { data: photosData, error: photosError } = await supabase
          .from('photos')
          .select(`
            id,
            photo_url,
            caption,
            submitter_name,
            approximate_date,
            event_context,
            additional_people,
            submitted_at
          `)
          .eq('status', 'approved')
          .order('submitted_at', { ascending: false })

        if (photosError) throw photosError

        const photosWithPeople = await Promise.all(
          (photosData || []).map(async (photo: any) => {
            const { data: photoPeopleData } = await supabase
              .from('photo_people')
              .select(`
                person_id,
                people:person_id (
                  id,
                  display_name,
                  full_name
                )
              `)
              .eq('photo_id', photo.id)

            const taggedPeople: TaggedPerson[] = []
            let additionalPeople: string[] = []

            if (photoPeopleData && photoPeopleData.length > 0) {
              photoPeopleData.forEach((item: any) => {
                if (item.people) {
                  taggedPeople.push({
                    id: item.people.id,
                    display_name: item.people.display_name,
                    full_name: item.people.full_name,
                  })
                }
              })
            }

            try {
              if (photo.additional_people) {
                additionalPeople = typeof photo.additional_people === 'string'
                  ? JSON.parse(photo.additional_people)
                  : photo.additional_people
              }
            } catch (e) {
              console.error('Failed to parse additional_people:', e)
            }

            return {
              ...photo,
              taggedPeople,
              additionalPeople: additionalPeople || [],
            }
          })
        )

        setPhotos(photosWithPeople)

        // Fetch likes for all photos
        if (photosWithPeople.length > 0) {
          const photoIds = photosWithPeople.map((p) => p.id)
          await fetchLikesForPhotos(photoIds)
        }
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch photos'))
      } finally {
        setLoading(false)
      }
    }

    if (!authLoading && !profileLoading) {
      fetchPhotos()
    }
  }, [user, userProfile, authLoading, profileLoading, fetchLikesForPhotos])

  const filteredAndSortedPhotos = useMemo(() => {
    let result = [...photos]

    if (debouncedSearchQuery) {
      const query = debouncedSearchQuery.toLowerCase()
      result = result.filter((photo) => {
        const captionMatch = photo.caption?.toLowerCase().includes(query)
        const taggedNamesMatch = photo.taggedPeople.some(
          (person) =>
            person.display_name?.toLowerCase().includes(query) ||
            person.full_name.toLowerCase().includes(query)
        )
        const additionalNamesMatch = photo.additionalPeople.some((name) =>
          name.toLowerCase().includes(query)
        )
        return captionMatch || taggedNamesMatch || additionalNamesMatch
      })
    }

    switch (sortOption) {
      case 'newest':
        result.sort((a, b) => {
          const dateA = a.submitted_at ? new Date(a.submitted_at).getTime() : 0
          const dateB = b.submitted_at ? new Date(b.submitted_at).getTime() : 0
          return dateB - dateA
        })
        break
      case 'oldest':
        result.sort((a, b) => {
          const dateA = a.submitted_at ? new Date(a.submitted_at).getTime() : 0
          const dateB = b.submitted_at ? new Date(b.submitted_at).getTime() : 0
          return dateA - dateB
        })
        break
      case 'caption':
        result.sort((a, b) => {
          const captionA = (a.caption || '').toLowerCase()
          const captionB = (b.caption || '').toLowerCase()
          return captionA.localeCompare(captionB)
        })
        break
    }

    return result
  }, [photos, debouncedSearchQuery, sortOption])

  const canView = user && !userProfile?.view_blocked

  if (authLoading || profileLoading || loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading...</div>
      </div>
    )
  }

  if (!canView) {
    return (
      <div className="container mx-auto px-4 py-12">
        <div className="max-w-md mx-auto text-center">
          <div className="text-6xl mb-4">🔒</div>
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Sign in to view the Photo Album</h1>
          <p className="text-gray-600 mb-6">
            The Photo Album contains memories from our stake's history. Please sign in to view.
          </p>
          <button
            onClick={() => setShowAuthModal(true)}
            className="bg-primary-600 text-white px-6 py-3 rounded-lg hover:bg-primary-700 transition-colors"
          >
            Sign In
          </button>
        </div>
        {showAuthModal && (
          <AuthModal
            onClose={() => setShowAuthModal(false)}
            onSuccess={() => setShowAuthModal(false)}
          />
        )}
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-2 font-serif">Photo Album</h1>
        <p className="text-gray-600">Memories from our stake's history</p>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4">
          {error.message}
        </div>
      )}

      <div className="bg-white border border-gray-200 rounded-lg p-4 mb-6">
        <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div className="flex-1 relative">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg className="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search photos..."
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
            />
          </div>
          <div className="flex items-center gap-2">
            <label htmlFor="sort-select" className="text-sm font-medium text-gray-700 whitespace-nowrap">
              Sort:
            </label>
            <select
              id="sort-select"
              value={sortOption}
              onChange={(e) => setSortOption(e.target.value as typeof sortOption)}
              className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent text-sm"
            >
              <option value="newest">Newest</option>
              <option value="oldest">Oldest</option>
              <option value="caption">Alphabetical</option>
            </select>
            <span className="text-sm text-gray-600 whitespace-nowrap">
              {filteredAndSortedPhotos.length} {filteredAndSortedPhotos.length === 1 ? 'photo' : 'photos'}
            </span>
          </div>
        </div>
      </div>

      {filteredAndSortedPhotos.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-lg text-gray-600">
            {debouncedSearchQuery ? 'No photos match your search' : 'No photos available'}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {filteredAndSortedPhotos.map((photo) => (
            <div
              key={photo.id}
              className="bg-white border border-gray-200 rounded-lg overflow-hidden hover:shadow-lg transition-shadow cursor-pointer"
              onClick={() => setSelectedPhoto(photo)}
            >
              <div className="aspect-video bg-gray-100 overflow-hidden">
                <img
                  src={photo.photo_url}
                  alt={photo.caption || 'Photo'}
                  className="w-full h-full object-cover"
                  onError={(e) => {
                    const target = e.target as HTMLImageElement
                    target.style.display = 'none'
                  }}
                />
              </div>
              <div className="p-4">
                {photo.caption && (
                  <h3 className="font-semibold text-gray-900 mb-2 line-clamp-2">{photo.caption}</h3>
                )}
                {photo.approximate_date && (
                  <p className="text-sm text-gray-600 mb-1">{photo.approximate_date}</p>
                )}
                {photo.event_context && (
                  <p className="text-sm text-gray-600 mb-2">{photo.event_context}</p>
                )}
                {(photo.taggedPeople.length > 0 || photo.additionalPeople.length > 0) && (
                  <div className="mb-2">
                    <p className="text-xs text-gray-500 mb-1">Tagged:</p>
                    <div className="flex flex-wrap gap-1">
                      {photo.taggedPeople.map((person) => (
                        <Link
                          key={person.id}
                          to={`/person/${person.id}`}
                          onClick={(e) => e.stopPropagation()}
                          className="text-xs text-primary-600 hover:text-primary-800 underline"
                        >
                          {person.display_name || person.full_name}
                        </Link>
                      ))}
                      {photo.additionalPeople.map((name, idx) => (
                        <span key={idx} className="text-xs text-gray-600">
                          {name}
                        </span>
                      ))}
                    </div>
                  </div>
                )}
                <div className="flex items-center justify-between mt-3 pt-3 border-t border-gray-100">
                  {photo.submitter_name && (
                    <p className="text-xs text-gray-500">
                      Shared by: {photo.submitter_name}
                    </p>
                  )}
                  <div className="flex items-center gap-3">
                    <PhotoLikeButton
                      photoId={photo.id}
                      likeCount={likesMap.get(photo.id)?.likeCount || 0}
                      likedByUser={likesMap.get(photo.id)?.likedByUser || false}
                      likedByNames={likesMap.get(photo.id)?.likedByNames || []}
                      onToggleLike={async () => {
                        const likeData = likesMap.get(photo.id)
                        if (likeData?.likedByUser) {
                          await unlikePhoto(photo.id)
                        } else {
                          await likePhoto(photo.id)
                        }
                        // Refetch likes to get updated names
                        await fetchLikesForPhotos([photo.id])
                      }}
                      disabled={!user}
                    />
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        setShareMemoryPhoto(photo)
                      }}
                      className="text-xs text-primary-600 hover:text-primary-800 underline"
                    >
                      Share Memory
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {selectedPhoto && (
        <PhotoLightbox
          photo={selectedPhoto}
          onClose={() => setSelectedPhoto(null)}
          likeCount={likesMap.get(selectedPhoto.id)?.likeCount || 0}
          likedByUser={likesMap.get(selectedPhoto.id)?.likedByUser || false}
          likedByNames={likesMap.get(selectedPhoto.id)?.likedByNames || []}
          onToggleLike={async () => {
            const likeData = likesMap.get(selectedPhoto.id)
            if (likeData?.likedByUser) {
              await unlikePhoto(selectedPhoto.id)
            } else {
              await likePhoto(selectedPhoto.id)
            }
            // Refetch likes to get updated names
            await fetchLikesForPhotos([selectedPhoto.id])
          }}
          onShareMemory={() => setShareMemoryPhoto(selectedPhoto)}
        />
      )}

      {shareMemoryPhoto && (
        <ShareMemoryModal
          taggedPeople={shareMemoryPhoto.taggedPeople}
          onClose={() => setShareMemoryPhoto(null)}
        />
      )}
    </div>
  )
}

