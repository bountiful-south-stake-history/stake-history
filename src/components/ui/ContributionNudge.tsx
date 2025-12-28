import { useState, useEffect, useRef } from 'react'

interface ContributionNudgeProps {
  words: string[]
  interval?: number
  className?: string
}

export function ContributionNudge({ words, interval = 3600, className = '' }: ContributionNudgeProps) {
  const [currentIndex, setCurrentIndex] = useState(0)
  const [isVisible, setIsVisible] = useState(true)
  const [prefersReducedMotion, setPrefersReducedMotion] = useState(false)
  const [isPaused, setIsPaused] = useState(false)
  const [isHovered, setIsHovered] = useState(false)
  const intervalRef = useRef<NodeJS.Timeout | null>(null)
  const timeoutRef = useRef<NodeJS.Timeout | null>(null)

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
    if (prefersReducedMotion || words.length <= 1 || isPaused) {
      if (intervalRef.current) {
        clearInterval(intervalRef.current)
        intervalRef.current = null
      }
      return
    }

    const cycleWords = () => {
      setIsVisible(false)
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
      timeoutRef.current = setTimeout(() => {
        setCurrentIndex((prev) => (prev + 1) % words.length)
        setIsVisible(true)
      }, 300)
    }

    intervalRef.current = setInterval(cycleWords, interval)
    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current)
      }
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
    }
  }, [words.length, interval, prefersReducedMotion, isPaused])

  const titleCaseWords = words.map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
  const longestWord = titleCaseWords.reduce((a, b) => a.length > b.length ? a : b)
  const displayText = prefersReducedMotion
    ? titleCaseWords.join(', ')
    : titleCaseWords[currentIndex]

  return (
    <div
      className={`flex flex-col items-center ${className}`}
      aria-live={isHovered ? 'polite' : 'off'}
      onMouseEnter={() => {
        setIsPaused(true)
        setIsHovered(true)
      }}
      onMouseLeave={() => {
        setIsPaused(false)
        setIsHovered(false)
      }}
      onFocus={() => {
        setIsPaused(true)
        setIsHovered(true)
      }}
      onBlur={() => {
        setIsPaused(false)
        setIsHovered(false)
      }}
    >
      <div className="inline-flex items-center justify-start gap-1.5">
        <span className="text-[13px] text-primary-600 whitespace-nowrap">Help add:</span>
        <span className="relative inline-block">
          <span className="text-[13px] font-semibold text-red-800 opacity-0 pointer-events-none" aria-hidden="true">
            {longestWord}
          </span>
          <span className={`absolute left-0 top-0 text-[13px] font-semibold text-red-800 whitespace-nowrap ${prefersReducedMotion ? '' : isVisible ? 'opacity-100 transition-opacity duration-300' : 'opacity-0 transition-opacity duration-300'}`}>
            {displayText}
          </span>
        </span>
      </div>
    </div>
  )
}
