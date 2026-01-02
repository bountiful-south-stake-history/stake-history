import { useState } from 'react'
import { Link } from 'react-router-dom'
import { usePerson } from '../../hooks/usePerson'
import { AudioPlayer } from './AudioPlayer'
import { ImageLightbox } from './ImageLightbox'

interface SpeakerCardProps {
  name: string
  role: string
  personId?: string | null
  imageUrl?: string | null
  audioUrl: string
  subtitle?: string
}

export function SpeakerCard({
  name,
  role,
  personId,
  imageUrl,
  audioUrl,
  subtitle,
}: SpeakerCardProps) {
  const { person } = usePerson(personId || '')
  const [showLightbox, setShowLightbox] = useState(false)

  let displayImage: string | null | undefined = null
  if (personId && person) {
    displayImage = person?.portrait_url || person?.photo_url
  } else if (!personId && imageUrl) {
    displayImage = imageUrl
  }
  
  if (name === 'Harold B. Lee' && !displayImage) {
    displayImage = 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/harold-b-lee.jpg'
  }

  const hasProfile = !!personId && person
  const hasAudio = audioUrl && audioUrl.trim() !== ''

  return (
    <div className="bg-white border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
      <div className="flex flex-col sm:flex-row gap-4">
        <div className="flex items-start gap-3 flex-shrink-0">
          {displayImage ? (
            <>
              <img
                src={displayImage}
                alt={name}
                className="w-16 h-16 rounded-full object-cover border-2 border-gray-200 cursor-pointer hover:opacity-80 transition-opacity"
                onClick={() => setShowLightbox(true)}
              />
              {showLightbox && (
                <ImageLightbox
                  imageUrl={displayImage}
                  alt={name}
                  onClose={() => setShowLightbox(false)}
                />
              )}
            </>
          ) : (
            <div className="w-16 h-16 rounded-full bg-gray-200 flex items-center justify-center border-2 border-gray-300">
              <svg
                className="w-8 h-8 text-gray-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                />
              </svg>
            </div>
          )}
          <div className="flex-1 min-w-0">
            <div>
              {hasProfile ? (
                <Link
                  to={`/person/${personId}`}
                  className="text-lg font-semibold text-primary-700 hover:text-primary-800 hover:underline"
                >
                  {name}
                </Link>
              ) : (
                <h3 className="text-lg font-semibold text-gray-900">{name}</h3>
              )}
              <p className="text-sm text-gray-600 mt-0.5">{role}</p>
              {subtitle && (
                <p className="text-xs text-gray-500 mt-1">{subtitle}</p>
              )}
            </div>
          </div>
        </div>
        <div className="flex-1 min-w-0">
          {hasAudio ? (
            <AudioPlayer audioUrl={audioUrl} compact />
          ) : (
            <p className="text-sm text-gray-500 italic">Audio coming soon</p>
          )}
        </div>
      </div>
    </div>
  )
}
