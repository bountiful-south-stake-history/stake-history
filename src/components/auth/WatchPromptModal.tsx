import { useNavigate } from 'react-router-dom'

interface WatchPromptModalProps {
  onClose: () => void
}

export function WatchPromptModal({ onClose }: WatchPromptModalProps) {
  const navigate = useNavigate()

  const handleBrowsePeople = () => {
    localStorage.setItem('hasSeenWatchPrompt', 'true')
    navigate('/')
    onClose()
  }

  const handleMaybeLater = () => {
    localStorage.setItem('hasSeenWatchPrompt', 'true')
    onClose()
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 animate-fadeIn">
      <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6 animate-slideUp">
        <div className="text-center mb-6">
          <div className="text-3xl mb-3">Get Notified! 🔔</div>
          <h2 className="text-xl font-bold text-gray-900 mb-4">Never miss a moment!</h2>
          <p className="text-gray-700 mb-4">
            Get weekly emails when:
          </p>
        </div>

        <div className="space-y-3 mb-6">
          <div className="flex items-start gap-3">
            <span className="text-2xl flex-shrink-0">📷</span>
            <p className="text-gray-700">
              Someone you know is tagged in a new photo
            </p>
          </div>

          <div className="flex items-start gap-3">
            <span className="text-2xl flex-shrink-0">💭</span>
            <p className="text-gray-700">
              A memory is shared about them
            </p>
          </div>
        </div>

        <p className="text-gray-600 text-sm mb-4 text-center">
          Just visit any person's page and click the 🔔 bell icon to start watching.
        </p>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 mb-6">
          <p className="text-sm text-gray-700 text-center">
            💡 <span className="font-semibold">Tip:</span> Start by watching yourself or family members!
          </p>
        </div>

        <div className="flex flex-col sm:flex-row gap-3 justify-center">
          <button
            onClick={handleBrowsePeople}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors font-semibold"
          >
            Browse People
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
