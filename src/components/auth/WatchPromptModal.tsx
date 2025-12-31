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
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
        <div className="text-center mb-6">
          <div className="text-4xl mb-4">🎉</div>
          <h2 className="text-2xl font-bold text-gray-900 mb-4">Welcome!</h2>
          <p className="text-gray-700 mb-2">
            Want to get notified when you or someone you know is tagged in new photos or memories?
          </p>
          <p className="text-gray-600 text-sm mb-6">
            Search for yourself or family members and click the bell icon on their profile page to watch for updates.
          </p>
        </div>
        <div className="flex gap-3 justify-center">
          <button
            onClick={handleBrowsePeople}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
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
