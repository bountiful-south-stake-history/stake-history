import { useState } from 'react'
import { dedicationSpeakers, buildings, stakeInfo } from '../data/archivesData'
import { SpeakerCard } from '../components/archives/SpeakerCard'
import { AudioPlayer } from '../components/archives/AudioPlayer'
import { ImageLightbox } from '../components/archives/ImageLightbox'

export function ArchivesPage() {
  const [lightboxImage, setLightboxImage] = useState<{ url: string; alt: string } | null>(null)

  console.log('Buildings:', buildings)
  console.log('Speakers:', dedicationSpeakers)

  return (
    <div className="max-w-4xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold text-primary-700 mb-2">Archives</h1>
        <p className="text-lg text-gray-600">
          Historical documents, recordings, and photographs
        </p>
      </div>

      <section className="mb-12">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">STAKE ORGANIZATION</h2>
        <div className="bg-white border border-gray-200 rounded-lg p-6">
          <p className="text-gray-700 mb-2">
            The Bountiful Utah South Stake was organized on{' '}
            <span className="font-semibold">{stakeInfo.organizedDate}</span>.
          </p>
          <p className="text-gray-700">
            Current boundaries were established{' '}
            <span className="font-semibold">{stakeInfo.boundariesDate}</span>.
          </p>
        </div>
      </section>

      <div className="border-t-2 border-gray-300 my-8"></div>

      {buildings.map((building, buildingIndex) => (
        <div key={building.id} className="mb-12">
          <section className="mb-6">
            <h2 className="text-2xl font-bold text-gray-900 mb-2">{building.name}</h2>
            <p className="text-gray-700 mb-1">{building.address}</p>
            <div className="mb-4">
              <p className="text-gray-600 text-sm">
                Dedicated {building.dedicatedDate}
                {building.dedicatedBy && ` by ${building.dedicatedBy}`}
              </p>
              {building.id === 'middle-building' && (
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

            {building.description && (
              <p className="text-gray-700 mb-4">{building.description}</p>
            )}

            {building.id === 'stake-center' && (
              <div className="mb-4">
                <img
                  src="https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/stake-center-exterior.jpg"
                  alt="Stake Center"
                  className="w-full h-64 object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                  onClick={() =>
                    setLightboxImage({
                      url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/stake-center-exterior.jpg',
                      alt: 'Stake Center',
                    })
                  }
                />
              </div>
            )}
            {building.id === 'middle-building' && (
              <div className="mb-4">
                <img
                  src="https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/middle-building-exterior.jpg"
                  alt="Middle Building"
                  className="w-full h-64 object-cover rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
                  onClick={() =>
                    setLightboxImage({
                      url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/middle-building-exterior.jpg',
                      alt: 'Middle Building',
                    })
                  }
                />
              </div>
            )}

            {building.documents.length > 0 && (
              <div className="mb-4 space-y-2">
                {building.documents.map((doc, idx) => (
                  <a
                    key={idx}
                    href={doc.url.startsWith('/*') ? '#' : doc.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-2 text-purple-600 hover:text-purple-700 hover:underline font-medium"
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


            {building.id === 'stake-center' && (
              <div className="mt-6">
                <div className="border-t border-gray-200 pt-4 mb-4">
                  <h3 className="text-lg font-semibold text-gray-900 mb-3 flex items-center gap-2">
                    <span className="text-xl">🎧</span>
                    DEDICATION AUDIO RECORDINGS
                  </h3>
                </div>

                {building.fullAudioUrl && building.fullAudioUrl.trim() !== '' && (
                  <div className="mb-6">
                    <AudioPlayer audioUrl={building.fullAudioUrl} title="Play Full Recording" />
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
              </div>
            )}
          </section>

          {buildingIndex < buildings.length - 1 && (
            <div className="border-t-2 border-gray-300 my-8"></div>
          )}
        </div>
      ))}

      {lightboxImage && (
        <ImageLightbox
          imageUrl={lightboxImage.url}
          alt={lightboxImage.alt}
          onClose={() => setLightboxImage(null)}
        />
      )}
    </div>
  )
}
