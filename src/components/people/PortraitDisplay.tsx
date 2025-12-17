import { useState, useEffect } from 'react'
import type { Person } from '../../lib/types'
import { ContributionModal } from './ContributionModal'

interface PortraitDisplayProps {
  person: Person
  onUploadComplete?: () => void
}

export function PortraitDisplay({ person, onUploadComplete }: PortraitDisplayProps) {
  const [showUploadModal, setShowUploadModal] = useState(false)
  const [imageError, setImageError] = useState(false)
  const showPortrait = person.portrait_url && !person.portrait_pending && !imageError
  const canUpload = !person.redacted

  // Reset image error when person or portrait_url changes
  useEffect(() => {
    setImageError(false)
  }, [person.id, person.portrait_url, person.portrait_pending])

  const handleUploadComplete = () => {
    setShowUploadModal(false)
    if (onUploadComplete) {
      onUploadComplete()
    } else {
      window.location.reload()
    }
  }

  return (
    <>
      <div
        className={`w-20 h-[100px] rounded-lg overflow-hidden flex-shrink-0 bg-gray-200 relative ${
          canUpload ? 'cursor-pointer group' : ''
        }`}
        onClick={() => canUpload && setShowUploadModal(true)}
      >
        {showPortrait ? (
          <>
            <img
              src={person.portrait_url}
              alt={`${person.display_name || person.full_name}`}
              className="w-full h-full object-cover"
              onError={() => {
                console.error('Portrait image failed to load:', {
                  personId: person.id,
                  personName: person.display_name || person.full_name,
                  portraitUrl: person.portrait_url,
                  portraitPending: person.portrait_pending,
                })
                setImageError(true)
              }}
              onLoad={() => {
                // Reset error state if image loads successfully (e.g., after URL update)
                setImageError(false)
              }}
            />
            {canUpload && (
              <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-30 transition-all flex items-center justify-center">
                <svg
                  className="w-6 h-6 text-white opacity-0 group-hover:opacity-100 transition-opacity"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                  />
                </svg>
              </div>
            )}
          </>
        ) : (
          <>
            <svg
              className="w-full h-full"
              viewBox="0 0 80 100"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect width="80" height="100" fill="#E2E8F0" />
              <circle cx="40" cy="32" r="16" fill="#94A3B8" />
              <ellipse cx="40" cy="75" rx="24" ry="22" fill="#94A3B8" />
            </svg>
            {canUpload && (
              <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-30 transition-all flex items-center justify-center">
                <svg
                  className="w-8 h-8 text-white opacity-0 group-hover:opacity-100 transition-opacity"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"
                  />
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
              </div>
            )}
          </>
        )}
      </div>

      {showUploadModal && (
        <ContributionModal
          person={person}
          onUploadComplete={handleUploadComplete}
          onCancel={() => setShowUploadModal(false)}
        />
      )}
    </>
  )
}

