import { useEffect } from 'react'
import { Link } from 'react-router-dom'
import { PhotoLikeButton } from './PhotoLikeButton'

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
  taggedPeople: TaggedPerson[]
  additionalPeople: string[]
}

interface PhotoLightboxProps {
  photo: Photo
  onClose: () => void
  likeCount?: number
  likedByUser?: boolean
  likedByNames?: string[]
  onToggleLike?: () => Promise<void>
  onShareMemory?: () => void
}

export function PhotoLightbox({
  photo,
  onClose,
  likeCount = 0,
  likedByUser = false,
  likedByNames = [],
  onToggleLike,
  onShareMemory,
}: PhotoLightboxProps) {
  useEffect(() => {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose()
      }
    }

    document.addEventListener('keydown', handleEscape)
    document.body.style.overflow = 'hidden'

    return () => {
      document.removeEventListener('keydown', handleEscape)
      document.body.style.overflow = ''
    }
  }, [onClose])

  return (
    <div
      className="fixed inset-0 bg-black bg-opacity-90 flex items-center justify-center z-50 p-4"
      onClick={onClose}
    >
      <button
        onClick={onClose}
        className="absolute top-4 right-4 text-white hover:text-gray-300 transition-colors z-10"
        aria-label="Close lightbox"
      >
        <svg
          className="w-8 h-8"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      </button>
      <div
        className="max-w-5xl w-full max-h-[90vh] overflow-y-auto"
        onClick={(e) => e.stopPropagation()}
      >
        <div className="bg-white rounded-lg overflow-hidden">
          <div className="flex justify-center bg-black">
            <img
              src={photo.photo_url}
              alt={photo.caption || 'Photo'}
              className="max-w-full max-h-[70vh] object-contain"
            />
          </div>
          <div className="p-6">
            {photo.caption && (
              <h2 className="text-2xl font-bold text-gray-900 mb-4">{photo.caption}</h2>
            )}
            <div className="space-y-2 text-gray-700">
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
                          onClick={(e) => e.stopPropagation()}
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
            <div className="mt-4 pt-4 border-t border-gray-200 flex items-center justify-between">
              {onToggleLike && (
                <PhotoLikeButton
                  photoId={photo.id}
                  likeCount={likeCount}
                  likedByUser={likedByUser}
                  likedByNames={likedByNames}
                  onToggleLike={onToggleLike}
                />
              )}
              <div className="flex items-center gap-4">
                {onShareMemory && (
                  <button
                    onClick={(e) => {
                      e.stopPropagation()
                      onShareMemory()
                    }}
                    className="text-primary-600 hover:text-primary-800 underline text-sm"
                  >
                    Share Memory
                  </button>
                )}
                <Link
                  to={`/photo/${photo.id}`}
                  onClick={(e) => {
                    e.stopPropagation()
                    onClose()
                  }}
                  className="text-primary-600 hover:text-primary-800 underline text-sm flex items-center gap-1"
                >
                  View Details
                  <svg
                    className="w-4 h-4"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

