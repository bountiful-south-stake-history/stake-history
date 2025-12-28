import { useEffect, useState } from 'react'

interface GuidanceArrowProps {
  direction?: 'left' | 'down' | 'up' | 'right'
  className?: string
}

export function GuidanceArrow({ direction = 'left', className = '' }: GuidanceArrowProps) {
  const [prefersReducedMotion, setPrefersReducedMotion] = useState(false)

  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-reduced-motion: reduce)')
    setPrefersReducedMotion(mediaQuery.matches)

    const handleChange = (e: MediaQueryListEvent) => {
      setPrefersReducedMotion(e.matches)
    }

    mediaQuery.addEventListener('change', handleChange)
    return () => mediaQuery.removeEventListener('change', handleChange)
  }, [])

  const rotationMap = {
    left: 'rotate(180deg)',
    right: 'rotate(0deg)',
    up: 'rotate(-90deg)',
    down: 'rotate(90deg)',
  }

  return (
    <div
      className={className}
      style={{ transform: rotationMap[direction] }}
    >
      <div className={prefersReducedMotion ? '' : 'animate-float-subtle'}>
        <svg
          className="guidance-arrow"
          width="80"
          height="80"
          viewBox="0 0 24 24"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          aria-hidden="true"
        >
          <path
            d="M9 5l7 7-7 7"
            stroke="#2a4365"
            strokeWidth="2.5"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </div>
    </div>
  )
}

