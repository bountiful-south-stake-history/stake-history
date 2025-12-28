import { useState, useEffect, useRef } from 'react'

interface ArrowHintProps {
  text: string
  direction?: 'left' | 'right' | 'up' | 'down'
  duration?: number
  className?: string
  onInteraction?: () => void
}

export function ArrowHint({ 
  text, 
  direction = 'right', 
  duration = 8000,
  className = '',
  onInteraction 
}: ArrowHintProps) {
  const [isVisible, setIsVisible] = useState(true)
  const [prefersReducedMotion, setPrefersReducedMotion] = useState(false)
  const timeoutRef = useRef<NodeJS.Timeout | null>(null)
  const interactedRef = useRef(false)

  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-reduced-motion: reduce)')
    setPrefersReducedMotion(mediaQuery.matches)

    const handleChange = (e: MediaQueryListEvent) => {
      setPrefersReducedMotion(e.matches)
    }

    mediaQuery.addEventListener('change', handleChange)
    return () => mediaQuery.removeEventListener('change', handleChange)
  }, [])

  useEffect(() => {
    if (prefersReducedMotion || interactedRef.current) return

    timeoutRef.current = setTimeout(() => {
      setIsVisible(false)
      onInteraction?.()
    }, duration)

    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
    }
  }, [duration, prefersReducedMotion, onInteraction])

  const handleInteraction = () => {
    if (!interactedRef.current) {
      interactedRef.current = true
      setIsVisible(false)
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
      onInteraction?.()
    }
  }

  const arrowPaths = {
    right: 'M9 5l7 7-7 7',
    left: 'M15 19l-7-7 7-7',
    up: 'M19 9l-7 7-7-7',
    down: 'M5 15l7-7 7 7',
  }

  if (!isVisible) return null

  return (
    <div
      className={`flex items-center gap-1.5 text-sm text-gray-600 ${prefersReducedMotion ? '' : 'animate-pulse-subtle'} ${className}`}
      onMouseEnter={handleInteraction}
      onFocus={handleInteraction}
      role="status"
      aria-live="polite"
    >
      <span>{text}</span>
      <svg
        className="w-4 h-4"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        aria-hidden="true"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d={arrowPaths[direction]}
        />
      </svg>
    </div>
  )
}

