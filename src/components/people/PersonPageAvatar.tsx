import { PortraitDisplay } from './PortraitDisplay'
import type { Person } from '../../lib/types'

interface PersonPageAvatarProps {
  person: Person
  onContributeClick: () => void
  onUploadComplete?: () => void
}

export function PersonPageAvatar({ person, onContributeClick, onUploadComplete }: PersonPageAvatarProps) {
  const showPortrait = !!person.portrait_url && !person.portrait_pending
  const isMissingPortrait = !showPortrait && !person.redacted
  const personName = person.display_name || person.full_name || 'this person'

  return (
    <div className="relative flex-shrink-0">
      <div
        className={`relative group rounded-lg ${isMissingPortrait ? 'cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary-500 focus-visible:ring-offset-2 focus-visible:ring-offset-white' : ''}`}
        onClick={() => {
          if (isMissingPortrait) {
            onContributeClick()
          }
        }}
        onKeyDown={(e) => {
          if ((e.key === 'Enter' || e.key === ' ') && isMissingPortrait) {
            e.preventDefault()
            onContributeClick()
          }
        }}
        tabIndex={isMissingPortrait ? 0 : undefined}
        role={isMissingPortrait ? 'button' : undefined}
        aria-label={isMissingPortrait ? `Add portrait for ${personName}` : undefined}
      >
        <PortraitDisplay person={person} onUploadComplete={onUploadComplete} lightboxMode={showPortrait} />
        {isMissingPortrait && (
          <div className="absolute inset-0 flex flex-col items-center justify-center rounded-lg transition-all bg-blue-50/50 group-hover:bg-blue-100/60">
            <svg
              className="w-10 h-10 text-primary-600 mb-1"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              aria-hidden="true"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2.5}
                d="M12 4v16m8-8H4"
              />
            </svg>
            <span className="text-xs font-medium text-primary-700">Add Portrait</span>
          </div>
        )}
      </div>
    </div>
  )
}

