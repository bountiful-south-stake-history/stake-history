import { useState, type ReactNode } from 'react'

interface CollapsibleSectionProps {
  title: string
  subtitle?: string
  defaultOpen?: boolean
  children: ReactNode
}

/**
 * A self-contained collapsible section for public pages. Its header reads as a
 * clickable section heading (matching the text-lg font-semibold text-gray-900
 * register used elsewhere on the page) rather than an admin form-control strip.
 * Each instance manages its own open/closed state.
 */
export function CollapsibleSection({ title, subtitle, defaultOpen = false, children }: CollapsibleSectionProps) {
  const [open, setOpen] = useState(defaultOpen)

  return (
    <div>
      <button
        type="button"
        onClick={() => setOpen(prev => !prev)}
        aria-expanded={open}
        className="w-full flex items-center justify-between text-left group"
      >
        <span>
          <span className="block text-lg font-semibold text-gray-900 group-hover:text-primary-700 transition-colors">
            {title}
          </span>
          {subtitle && <span className="block text-sm text-gray-500 mt-0.5">{subtitle}</span>}
        </span>
        <svg
          className={`w-5 h-5 text-gray-500 transition-transform flex-shrink-0 ml-3 ${open ? 'rotate-180' : ''}`}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>
      {open && <div className="mt-4">{children}</div>}
    </div>
  )
}
