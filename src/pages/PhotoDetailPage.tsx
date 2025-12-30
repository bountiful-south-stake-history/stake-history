import { useParams, Link } from 'react-router-dom'
import { useState, useEffect } from 'react'
import { useAuth } from '../hooks/useAuth'
import { useUserProfile } from '../hooks/useUserProfile'
import { usePhotoLikes } from '../hooks/usePhotoLikes'
import { supabase } from '../lib/supabase'
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

export function PhotoDetailPage() {
  const { photoId } = useParams<{ photoId: string }>()
  const { user, loading: authLoading } = useAuth()
  const { profile: userProfile, loading: profileLoading } = useUserProfile()
  const { likesMap, fetchLikesForPhotos, likePhoto, unlikePhoto } = usePhotoLikes()
  const [photo, setPhoto] = useState<Photo | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [shareMemoryPhoto, setShareMemoryPhoto] = useState<Photo | null>(null)

  useEffect(() => {
    if (!photoId) return

    const fetchPhoto = async () => {
      if (!user || userProfile?.view_blocked) {
        setLoading(false)
        return
      }

      try {
        setLoading(true)
        setError(null)

        const { data: photoData, error: photoError } = await supabase
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
          .eq('id', photoId)
          .eq('status', 'approved')
          .single()

        if (photoError) throw photoError
        if (!photoData) {
          setError(new Error('Photo not found'))
          setLoading(false)
          return
        }

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
          .eq('photo_id', photoData.id)

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

        if (photoData.additional_people && Array.isArray(photoData.additional_people)) {
          additionalPeople = photoData.additional_people
        }

        setPhoto({
          id: photoData.id,
          photo_url: photoData.photo_url,
          caption: photoData.caption || '',
          approximate_date: photoData.approximate_date || undefined,
          event_context: photoData.event_context || undefined,
          submitter_name: photoData.submitter_name || undefined,
          submitted_at: photoData.submitted_at || undefined,
          taggedPeople,
          additionalPeople,
        })

        await fetchLikesForPhotos([photoData.id])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch photo'))
      } finally {
        setLoading(false)
      }
    }

    fetchPhoto()
  }, [photoId, user, userProfile, fetchLikesForPhotos])

  if (loading || authLoading || profileLoading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading...</div>
      </div>
    )
  }

  if (!user || userProfile?.view_blocked) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center">
          <div className="flex items-center justify-center gap-2 text-gray-600 mb-4">
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
              />
            </svg>
            <p className="text-lg">🔒 Sign in to view the Photo Album</p>
          </div>
          <Link
            to="/photos"
            className="inline-block px-6 py-2 border-2 border-primary-600 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors"
          >
            Back to Photo Album
          </Link>
        </div>
      </div>
    )
  }

  if (error || !photo) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center py-12">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">
            {error ? 'Error loading photo' : 'Photo not found'}
          </h1>
          <Link
            to="/photos"
            className="text-primary-600 hover:text-primary-700 underline"
          >
            Back to Photo Album
          </Link>
        </div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-6">
        <Link
          to="/photos"
          className="flex items-center gap-2 text-gray-600 hover:text-primary-700 transition-colors"
        >
          <svg
            className="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M15 19l-7-7 7-7"
            />
          </svg>
          <span>Back to Photo Album</span>
        </Link>
      </div>

      <div className="bg-white rounded-lg shadow-lg overflow-hidden border border-gray-200 mb-8">
        <div className="flex justify-center bg-gray-100 p-8">
          <img
            src={photo.photo_url}
            alt={photo.caption || 'Photo'}
            className="max-w-full max-h-[600px] object-contain"
          />
        </div>
        <div className="p-6">
          {photo.caption && (
            <h1 className="text-3xl font-bold text-gray-900 mb-4">{photo.caption}</h1>
          )}
          <div className="space-y-2 text-gray-700 mb-6">
            {photo.approximate_date && (
              <p>
                <span className="font-medium">Date:</span> {photo.approximate_date}
              </p>
            )}
            {photo.event_context && (
              <p>
                <span className="font-medium">Event:</span> {photo.event_context}
              </p>
            )}
            {(photo.taggedPeople.length > 0 || photo.additionalPeople.length > 0) && (
              <div>
                <span className="font-medium">Tagged:</span>{' '}
                <span className="space-x-2">
                  {photo.taggedPeople.map((person, idx) => (
                    <span key={person.id}>
                      <Link
                        to={`/person/${person.id}`}
                        className="text-primary-600 hover:text-primary-800 underline"
                      >
                        {person.display_name || person.full_name}
                      </Link>
                      {idx < photo.taggedPeople.length - 1 || photo.additionalPeople.length > 0 ? ', ' : ''}
                    </span>
                  ))}
                  {photo.additionalPeople.map((name, idx) => (
                    <span key={idx}>
                      {name}
                      {idx < photo.additionalPeople.length - 1 ? ', ' : ''}
                    </span>
                  ))}
                </span>
              </div>
            )}
            {photo.submitter_name && (
              <p>
                <span className="font-medium">Shared by:</span> {photo.submitter_name}
              </p>
            )}
          </div>
          <div className="flex items-center gap-4 pt-4 border-t border-gray-200">
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
                await fetchLikesForPhotos([photo.id])
              }}
              disabled={!user}
            />
            <button
              onClick={() => setShareMemoryPhoto(photo)}
              className="text-primary-600 hover:text-primary-800 underline"
            >
              Share Memory
            </button>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">
          Memories about this photo (0)
        </h2>
        <div className="text-center py-8">
          <p className="text-gray-600 mb-4">No memories yet. Be the first to share!</p>
          <button
            onClick={() => setShareMemoryPhoto(photo)}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
          >
            Share a Memory
          </button>
        </div>
      </div>

      {shareMemoryPhoto && (
        <ShareMemoryModal
          taggedPeople={shareMemoryPhoto.taggedPeople}
          onClose={() => setShareMemoryPhoto(null)}
        />
      )}
    </div>
  )
}

