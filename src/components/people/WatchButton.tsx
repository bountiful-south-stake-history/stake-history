import { useState } from 'react'
import { usePersonWatch } from '../../hooks/usePersonWatch'
import { useAuth } from '../../hooks/useAuth'
import { MdNotificationsNone, MdNotifications } from 'react-icons/md'

interface WatchButtonProps {
  personId: string
  personName: string
  onToggle?: () => void
}

export function WatchButton({ personId, personName, onToggle }: WatchButtonProps) {
  const { user } = useAuth()
  const { isWatching, isLoading, toggleWatch } = usePersonWatch(personId)
  const [showTooltip, setShowTooltip] = useState(false)

  if (!user) {
    return null
  }

  const handleClick = async () => {
    try {
      await toggleWatch()
      onToggle?.()
    } catch (err) {
      console.error('Failed to toggle watch:', err)
    }
  }

  return (
    <div className="relative">
      <button
        onClick={handleClick}
        onMouseEnter={() => setShowTooltip(true)}
        onMouseLeave={() => setShowTooltip(false)}
        disabled={isLoading}
        className={`transition-opacity ${isLoading ? 'opacity-50 cursor-wait' : 'cursor-pointer hover:opacity-80'}`}
        aria-label={isWatching ? `Watching ${personName} - click to stop` : `Get notified of changes for ${personName}`}
      >
        {isWatching ? (
          <MdNotifications size={24} style={{ color: '#F59E0B' }} />
        ) : (
          <MdNotificationsNone size={24} className="text-gray-400" />
        )}
      </button>
      {showTooltip && (
        <div className="absolute right-0 top-full mt-2 px-2 py-1 bg-gray-800 text-white text-xs rounded whitespace-nowrap z-10">
          {isWatching ? 'Watching - click to stop' : 'Get notified of changes'}
          <div className="absolute bottom-full right-4 w-0 h-0 border-l-4 border-r-4 border-b-4 border-transparent border-b-gray-800"></div>
        </div>
      )}
    </div>
  )
}
