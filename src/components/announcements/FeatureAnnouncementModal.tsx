import { useNavigate } from 'react-router-dom'
import { MdNotifications } from 'react-icons/md'

interface FeatureAnnouncementModalProps {
  onClose: () => void
}

export function FeatureAnnouncementModal({ onClose }: FeatureAnnouncementModalProps) {
  const navigate = useNavigate()

  const handleStartWatching = () => {
    navigate('/')
    onClose()
  }

  const handleMaybeLater = () => {
    onClose()
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 animate-fadeIn">
      <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6 animate-slideUp relative">
        <button
          onClick={handleMaybeLater}
          className="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition-colors"
          aria-label="Close"
        >
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
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>

        <div className="text-center mb-6">
          <div className="text-3xl mb-3">✨ New Feature! ✨</div>
          <h2 className="text-2xl font-bold text-gray-900 mb-6">
            Introducing: Watch & Get Notified
          </h2>
        </div>

        <div className="space-y-4 mb-6">
          <p className="text-gray-700 text-center">
            Never miss updates about people you care about!
          </p>

          <div className="space-y-3">
            <div className="flex items-start gap-3">
              <MdNotifications className="w-6 h-6 text-amber-500 flex-shrink-0 mt-0.5" />
              <div>
                <div className="font-semibold text-gray-900">Click the bell icon</div>
                <div className="text-sm text-gray-600">on any person's page</div>
              </div>
            </div>

            <div className="flex items-start gap-3">
              <span className="text-2xl flex-shrink-0">📧</span>
              <div>
                <div className="font-semibold text-gray-900">Get weekly email digests</div>
                <div className="text-sm text-gray-600">with new photos & memories</div>
              </div>
            </div>

            <div className="flex items-start gap-3">
              <span className="text-2xl flex-shrink-0">📋</span>
              <div>
                <div className="font-semibold text-gray-900">Manage everything</div>
                <div className="text-sm text-gray-600">in your Watchlist</div>
              </div>
            </div>
          </div>

          <p className="text-gray-600 text-sm text-center pt-2">
            Watch yourself, family members, or anyone you'd like to stay updated on.
          </p>
        </div>

        <div className="flex flex-col sm:flex-row gap-3 justify-center">
          <button
            onClick={handleStartWatching}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-semibold"
          >
            Start Watching
          </button>
          <button
            onClick={handleMaybeLater}
            className="px-6 py-2 border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors"
          >
            Maybe Later
          </button>
        </div>
      </div>
    </div>
  )
}
