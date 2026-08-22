import { useState } from 'react'
import { useSearchParams, useNavigate, useLocation } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import { dedicationSpeakers, buildings } from '../data/archivesData'
import { SpeakerCard } from '../components/archives/SpeakerCard'
import { AudioPlayer } from '../components/archives/AudioPlayer'
import { ImageLightbox } from '../components/archives/ImageLightbox'
import { BuildingPhotoAlbum } from '../components/archives/BuildingPhotoAlbum'
import { BuildingMemories } from '../components/archives/BuildingMemories'
import { AuthModal } from '../components/auth/AuthModal'

const tabLabels: Record<string, string> = {
  'stake-center': '1250 S Main',
  'middle-building': '102 E 1400 S',
  'south-building': '1500 S 600 E',
}

export function ArchivesPage() {
  const { user, loading: authLoading } = useAuth()
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const location = useLocation()
  const [lightboxImage, setLightboxImage] = useState<{ url: string; alt: string } | null>(null)
  const [showAuthModal, setShowAuthModal] = useState(false)

  // Select the active building from the ?building= param. A missing or unknown
  // value falls back to the first building rather than blanking the page.
  const activeBuilding =
    buildings.find(b => b.id === searchParams.get('building')) || buildings[0]

  // Reflect the selected tab in the URL so it can be copied and shared. Use
  // replace (not push) so tab clicks don't stack history entries and trap the
  // back button, and carry the current hash through so in-page anchors survive.
  const selectBuilding = (id: string) => {
    const nextParams = new URLSearchParams(searchParams)
    nextParams.set('building', id)
    navigate(
      { pathname: location.pathname, search: `?${nextParams.toString()}`, hash: location.hash },
      { replace: true }
    )
  }

  return (
    <div className="max-w-4xl mx-auto">
      {/* Page Header */}
      <div className="mb-8">
        <h1 className="text-4xl font-bold text-primary-700 mb-2">Buildings</h1>
        <p className="text-lg text-gray-600">
          Historical documents, recordings, photographs, and memories
        </p>
      </div>

      {/* Tab Bar */}
      <div className="mb-6 border-b border-gray-200">
        <div className="flex flex-wrap gap-0">
          {buildings.map(building => (
            <button
              key={building.id}
              onClick={() => selectBuilding(building.id)}
              className={`px-5 py-3 font-medium text-base border-b-2 transition-all whitespace-nowrap ${
                activeBuilding.id === building.id
                  ? 'border-primary-600 text-primary-700 shadow-[0_0_8px_rgba(30,64,110,0.3)]'
                  : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
              }`}
            >
              {tabLabels[building.id] || building.address}
            </button>
          ))}
        </div>
      </div>

      {/* Active Tab Content */}
      <div>
        {/* Building Info */}
        <section className="mb-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-2">{activeBuilding.name}</h2>
          <p className="text-gray-700 mb-1">{activeBuilding.address}</p>
          {activeBuilding.dedicatedDate && (
            <div className="mb-4">
              <p className="text-gray-600 text-sm">
                Dedicated {activeBuilding.dedicatedDate}
                {activeBuilding.dedicatedBy && ` by ${activeBuilding.dedicatedBy}`}
              </p>
              {activeBuilding.id === 'middle-building' && (
                <div className="flex items-center gap-3 mt-4">
                  <img
                    src="https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/legrand-richards.jpg"
                    alt="LeGrand Richards"
                    className="w-16 h-16 rounded-full object-cover border-2 border-gray-200 cursor-pointer hover:opacity-80 transition-opacity"
                    onClick={() =>
                      setLightboxImage({
                        url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/legrand-richards.jpg',
                        alt: 'LeGrand Richards',
                      })
                    }
                  />
                  <div>
                    <p className="font-medium text-gray-900">Bishop LeGrand Richards</p>
                    <p className="text-sm text-gray-500">Presiding Bishop, later called as an apostle</p>
                  </div>
                </div>
              )}
            </div>
          )}

          {activeBuilding.description && (
            <p className="text-gray-700 mb-4">{activeBuilding.description}</p>
          )}

          {/* Building Exterior Photo */}
          {activeBuilding.imageUrl && (
            <div className="mb-4">
              <img
                src={activeBuilding.imageUrl}
                alt={activeBuilding.name}
                className="w-full h-64 object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                onClick={() =>
                  setLightboxImage({
                    url: activeBuilding.imageUrl,
                    alt: activeBuilding.name,
                  })
                }
              />
            </div>
          )}

          {/* Documents */}
          {activeBuilding.documents.length > 0 && (
            <div className="mb-4 space-y-2">
              {activeBuilding.documents.map((doc, idx) => (
                <a
                  key={idx}
                  href={doc.url.startsWith('/*') ? '#' : doc.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-purple-600 hover:text-purple-700 hover:underline font-medium"
                >
                  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                    />
                  </svg>
                  <span>{doc.title}</span>
                  {!doc.url.startsWith('/*') && (
                    <span className="text-xs text-purple-500">[Download PDF]</span>
                  )}
                </a>
              ))}
            </div>
          )}
        </section>

        {/* Dedication Audio (Stake Center only) */}
        {activeBuilding.id === 'stake-center' && (
          <section className="mb-8">
            <div className="border-t border-gray-200 pt-4 mb-4">
              <h3 className="text-lg font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <span className="text-xl">🎧</span>
                DEDICATION AUDIO RECORDINGS
              </h3>
            </div>

            {activeBuilding.fullAudioUrl && activeBuilding.fullAudioUrl.trim() !== '' && (
              <div className="mb-6">
                <AudioPlayer audioUrl={activeBuilding.fullAudioUrl} title="Play Full Recording" />
              </div>
            )}

            <div className="mb-4">
              <h4 className="text-md font-semibold text-gray-800 mb-3">
                Individual Segments:
              </h4>
              <div className="space-y-3">
                {dedicationSpeakers.map((speaker, idx) => (
                  <SpeakerCard
                    key={idx}
                    name={speaker.name}
                    role={speaker.role}
                    personId={speaker.personId}
                    imageUrl={speaker.imageUrl}
                    audioUrl={speaker.audioUrl}
                    subtitle={speaker.subtitle}
                  />
                ))}
              </div>
            </div>
          </section>
        )}

        {/* Photo Album - requires sign-in */}
        <section className="mb-8 border-t border-gray-200 pt-6">
          {!authLoading && user ? (
            <BuildingPhotoAlbum key={activeBuilding.id} buildingId={activeBuilding.id} buildingName={activeBuilding.name} />
          ) : !authLoading ? (
            <div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">Photos</h3>
              <div className="bg-gray-50 border border-gray-200 rounded-lg p-6 text-center">
                <p className="text-gray-600 mb-3">Sign in to view and submit building photos</p>
                <button
                  onClick={() => setShowAuthModal(true)}
                  className="px-4 py-2 bg-primary-600 text-white text-sm rounded-lg hover:bg-primary-700 transition-colors"
                >
                  Sign In
                </button>
              </div>
            </div>
          ) : null}
        </section>

        {/* Memories - requires sign-in */}
        <section className="mb-8 border-t border-gray-200 pt-6">
          {!authLoading && user ? (
            <BuildingMemories key={activeBuilding.id} buildingId={activeBuilding.id} buildingName={activeBuilding.name} />
          ) : !authLoading ? (
            <div>
              <h3 className="text-lg font-semibold text-gray-900 mb-2">Memories</h3>
              <div className="bg-gray-50 border border-gray-200 rounded-lg p-6 text-center">
                <p className="text-gray-600 mb-3">Sign in to view and share building memories</p>
                <button
                  onClick={() => setShowAuthModal(true)}
                  className="px-4 py-2 bg-primary-600 text-white text-sm rounded-lg hover:bg-primary-700 transition-colors"
                >
                  Sign In
                </button>
              </div>
            </div>
          ) : null}
        </section>
      </div>

      {lightboxImage && (
        <ImageLightbox
          imageUrl={lightboxImage.url}
          alt={lightboxImage.alt}
          onClose={() => setLightboxImage(null)}
        />
      )}

      {showAuthModal && (
        <AuthModal
          onClose={() => setShowAuthModal(false)}
          onSuccess={() => setShowAuthModal(false)}
        />
      )}
    </div>
  )
}
