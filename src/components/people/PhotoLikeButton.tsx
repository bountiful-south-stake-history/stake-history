import { useState } from 'react'

interface PhotoLikeButtonProps {
  photoId: string
  likeCount: number
  likedByUser: boolean
  likedByNames: string[]
  onToggleLike: () => Promise<void>
  disabled?: boolean
}

export function PhotoLikeButton({
  likeCount,
  likedByUser,
  likedByNames,
  onToggleLike,
  disabled = false,
}: PhotoLikeButtonProps) {
  const [isToggling, setIsToggling] = useState(false)
  const [showTooltip, setShowTooltip] = useState(false)

  const handleClick = async (e: React.MouseEvent) => {
    e.stopPropagation()
    if (disabled || isToggling) return

    setIsToggling(true)
    try {
      await onToggleLike()
    } catch (err) {
      console.error('Failed to toggle like:', err)
    } finally {
      setIsToggling(false)
    }
  }

  const getTooltipText = () => {
    if (likeCount === 0) {
      return 'Be the first to like this!'
    }

    const displayNames = likedByNames.slice(0, 5)
    const remaining = likedByNames.length - displayNames.length

    if (remaining > 0) {
      return `${displayNames.join(', ')}, +${remaining} other${remaining === 1 ? '' : 's'}`
    }

    return displayNames.join(', ')
  }

  return (
    <div className="flex items-center gap-1 relative">
      <button
        onClick={handleClick}
        disabled={disabled || isToggling}
        className={`flex items-center gap-1 transition-colors ${
          likedByUser
            ? 'text-red-500 hover:text-red-600'
            : 'text-gray-400 hover:text-red-400'
        } ${disabled || isToggling ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'}`}
        aria-label={likedByUser ? 'Unlike this photo' : 'Like this photo'}
      >
        <svg
          className={`w-5 h-5 transition-all ${likedByUser ? 'fill-current' : ''}`}
          fill={likedByUser ? 'currentColor' : 'none'}
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth={2}
            d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
          />
        </svg>
      </button>
      <span
        className="text-sm text-gray-600 cursor-default"
        onMouseEnter={() => likeCount > 0 && setShowTooltip(true)}
        onMouseLeave={() => setShowTooltip(false)}
      >
        {likeCount}
      </span>
      {showTooltip && likeCount > 0 && (
        <div className="absolute bottom-full left-0 mb-2 px-2 py-1 bg-gray-800 text-white text-xs rounded whitespace-nowrap z-10">
          {getTooltipText()}
          <div className="absolute top-full left-4 w-0 h-0 border-l-4 border-r-4 border-t-4 border-transparent border-t-gray-800"></div>
        </div>
      )}
    </div>
  )
}

