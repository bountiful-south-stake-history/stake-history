import { useParams, Link, useNavigate } from 'react-router-dom'
import { useState } from 'react'
import { usePerson } from '../hooks/usePerson'
import { usePersonCallings } from '../hooks/usePersonCallings'
import { usePersonMemories } from '../hooks/usePersonMemories'
import { usePersonPhotos } from '../hooks/usePersonPhotos'
import { useAuth } from '../hooks/useAuth'
import { useUserProfile } from '../hooks/useUserProfile'
import { PortraitDisplay } from '../components/people/PortraitDisplay'
import { ContributionModal } from '../components/people/ContributionModal'
import { AuthModal } from '../components/auth/AuthModal'
import { formatCallingRange, parseLocalDate } from '../lib/utils'

const relationshipLabels: Record<string, string> = {
  family: 'Family Member',
  friend: 'Friend',
  served_together: 'Served Together',
  ward_member: 'Ward Member',
  other: 'Other',
}

export function PersonMemoriesPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { user, loading: authLoading } = useAuth()
  const { profile: userProfile, loading: profileLoading } = useUserProfile()
  const { person, loading: personLoading, error: personError } = usePerson(id || '')
  const { callings, loading: callingsLoading } = usePersonCallings(id || '')
  const { memories, loading: memoriesLoading } = usePersonMemories(id || '')
  const { photos, loading: photosLoading } = usePersonPhotos(id || '')
  const [showContributeModal, setShowContributeModal] = useState(false)
  const [showAuthModal, setShowAuthModal] = useState(false)

  const loading = personLoading || callingsLoading || memoriesLoading || photosLoading
  const hasContent = memories.length > 0 || photos.length > 0 || (person?.portrait_url && !person?.portrait_pending)

  if (loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading...</div>
      </div>
    )
  }

  if (personError || !person) {
    return (
      <div className="text-center py-12">
        <h1 className="text-2xl font-bold text-gray-900 mb-4">Person Not Found</h1>
        <Link to="/" className="text-primary-600 hover:text-primary-700 underline">
          Back to Home
        </Link>
      </div>
    )
  }

  return (
    <div>
      <div className="mb-6">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-gray-600 hover:text-primary-700 transition-colors mb-4"
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
          <span>Back</span>
        </button>
      </div>

      <div className="mb-8">
        <div className="flex items-start gap-6 mb-6">
          <PortraitDisplay person={person} onUploadComplete={() => window.location.reload()} />
          <div className="flex-1">
            <div className="flex items-start justify-between gap-4">
              <div>
                <h1 className="text-4xl font-bold text-primary-700 mb-2">
                  {person.display_name || person.full_name}
                </h1>
                {(person.birth_date || person.death_date) && (
                  <p className="text-lg text-gray-600">
                    {person.birth_date && parseLocalDate(person.birth_date).getFullYear()}
                    {person.death_date && ` – ${parseLocalDate(person.death_date).getFullYear()}`}
                  </p>
                )}
              </div>
              {!person.redacted && (
                <button
                  onClick={() => setShowContributeModal(true)}
                  className="flex items-center gap-2 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors whitespace-nowrap"
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
                      d="M12 4v16m8-8H4"
                    />
                  </svg>
                  <span>Contribute</span>
                </button>
              )}
            </div>
          </div>
        </div>
      </div>

      {callings.length > 0 && (
        <section className="mb-12">
          <h2 className="text-2xl font-bold text-primary-700 mb-4">Callings</h2>
          <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200">
            <div className="space-y-3">
              {callings.map((calling) => (
                <div key={calling.id} className="flex items-start gap-4 pb-3 border-b border-gray-100 last:border-0">
                  <div className="flex-1">
                    <div className="font-semibold text-gray-900">
                      {calling.position?.title}
                    </div>
                    <div className="text-sm text-gray-600">
                      {calling.organization?.id ? (
                        <Link
                          to={`/org/${calling.organization.id}`}
                          className="text-primary-600 hover:text-primary-700 hover:underline"
                        >
                          {calling.organization.name}
                        </Link>
                      ) : (
                        calling.organization?.name
                      )}
                    </div>
                    <div className="text-xs text-gray-500 mt-1">
                      {formatCallingRange(calling)}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      <section className="mb-12">
        <h2 className="text-2xl font-bold text-primary-700 mb-4">Memories</h2>
        {(!authLoading && !profileLoading && (!user || userProfile?.view_blocked)) ? (
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
              <p className="text-lg">Sign in to view memories shared about this person</p>
            </div>
            <button
              onClick={() => setShowAuthModal(true)}
              className="px-6 py-2 border-2 border-primary-600 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors"
            >
              Sign In
            </button>
          </div>
        ) : memories.length > 0 ? (
          <div className="grid gap-4">
            {memories.map((memory) => (
              <div
                key={memory.id}
                className="bg-white rounded-lg shadow-md p-6 border border-gray-200"
              >
                <div className="prose max-w-none">
                  <p className="text-gray-700 whitespace-pre-wrap">{memory.content}</p>
                </div>
                <div className="mt-4 pt-4 border-t border-gray-100 text-sm text-gray-500">
                  {memory.submitter_name && (
                    <span>
                      Shared by {memory.submitter_name}
                      {memory.relationship && (
                        <span className="ml-1">
                          ({relationshipLabels[memory.relationship] || memory.relationship})
                        </span>
                      )}
                    </span>
                  )}
                  {memory.time_period && (
                    <span className="ml-2">• {memory.time_period}</span>
                  )}
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center">
            <p className="text-lg text-gray-600">
              No memories have been shared yet.
            </p>
          </div>
        )}
      </section>

      <section className="mb-12">
        <h2 className="text-2xl font-bold text-primary-700 mb-4">Photos</h2>
        {(!authLoading && !profileLoading && (!user || userProfile?.view_blocked)) ? (
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
              <p className="text-lg">Sign in to view photos of this person</p>
            </div>
            <button
              onClick={() => setShowAuthModal(true)}
              className="px-6 py-2 border-2 border-primary-600 text-primary-600 rounded-lg hover:bg-primary-50 transition-colors"
            >
              Sign In
            </button>
          </div>
        ) : photos.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {photos.map((photo) => (
              <div
                key={photo.id}
                className="bg-white rounded-lg shadow-md overflow-hidden border border-gray-200 cursor-pointer hover:shadow-lg transition-shadow"
                onClick={() => {
                  const modal = document.createElement('div')
                  modal.className = 'fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50 p-4'
                  modal.onclick = () => modal.remove()
                  const photoUrl = photo.photo_url || (photo as any).file_url
                  modal.innerHTML = `
                    <div class="max-w-4xl max-h-[90vh] overflow-auto">
                      <img src="${photoUrl}" alt="${photo.caption || 'Photo'}" class="max-w-full h-auto" />
                      ${photo.caption ? `<p class="text-white mt-4 text-center">${photo.caption}</p>` : ''}
                    </div>
                  `
                  document.body.appendChild(modal)
                }}
              >
                <img
                  src={photo.photo_url || (photo as any).file_url}
                  alt={photo.caption || 'Photo'}
                  className="w-full h-64 object-cover"
                />
                {photo.caption && (
                  <div className="p-3">
                    <p className="text-sm text-gray-700">{photo.caption}</p>
                    {photo.approximate_date && (
                      <p className="text-xs text-gray-500 mt-1">{photo.approximate_date}</p>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        ) : (
          <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center">
            <p className="text-lg text-gray-600">
              No photos have been shared yet.
            </p>
          </div>
        )}
      </section>

      {!hasContent && (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center">
          <p className="text-lg text-gray-600 mb-4">
            No memories have been shared yet. Be the first to contribute!
          </p>
          <button
            onClick={() => setShowContributeModal(true)}
            className="bg-primary-600 text-white px-6 py-3 rounded-lg hover:bg-primary-700 transition-colors"
          >
            Contribute Information
          </button>
        </div>
      )}

      {showContributeModal && person && (
        <ContributionModal
          person={person}
          onUploadComplete={() => {
            setShowContributeModal(false)
            window.location.reload()
          }}
          onCancel={() => setShowContributeModal(false)}
        />
      )}

      {showAuthModal && (
        <AuthModal
          onClose={() => setShowAuthModal(false)}
          onSuccess={() => {
            setShowAuthModal(false)
            window.location.reload()
          }}
        />
      )}
    </div>
  )
}

