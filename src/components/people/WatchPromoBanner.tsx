import { useState, useEffect } from 'react'
import { MdNotifications } from 'react-icons/md'

interface WatchPromoBannerProps {
  onSignUp: () => void
}

export function WatchPromoBanner({ onSignUp }: WatchPromoBannerProps) {
  const [isDismissed, setIsDismissed] = useState(false)

  useEffect(() => {
    const dismissed = localStorage.getItem('watchBannerDismissed') === 'true'
    setIsDismissed(dismissed)
  }, [])

  const handleDismiss = () => {
    localStorage.setItem('watchBannerDismissed', 'true')
    setIsDismissed(true)
  }

  if (isDismissed) return null

  return (
    <div className="bg-primary-50 border border-primary-200 rounded-lg p-4 mb-6 relative animate-fadeIn">
      <button
        onClick={handleDismiss}
        className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 transition-colors"
        aria-label="Dismiss"
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
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      </button>

      <div className="flex items-start gap-3 pr-8">
        <MdNotifications className="w-6 h-6 text-primary-600 flex-shrink-0 mt-0.5" />
        <div className="flex-1">
          <p className="text-gray-800 mb-2">
            <span className="font-semibold">Want to know when new photos or memories are added</span> about this person? Create a free account to watch them.
          </p>
          <button
            onClick={onSignUp}
            className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors text-sm font-semibold"
          >
            Sign Up Free
          </button>
        </div>
      </div>
    </div>
  )
}
