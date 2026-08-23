import type { BuildingEvent } from '../../data/archivesData'

interface BuildingTimelineProps {
  events: BuildingEvent[]
  onImageClick?: (url: string, alt: string) => void
}

/**
 * Renders a building's dated events as a stacked, single-column list. Designed
 * mobile-first: no date gutter, no connector lines or dots. When an event has a
 * presiding authority, it renders the same portrait/name/role card used at the
 * top of ArchivesPage; the portrait is omitted cleanly when no image exists.
 * When onImageClick is provided, portraits become clickable (e.g. to open a
 * lightbox), matching the top-of-page card's affordance.
 */
export function BuildingTimeline({ events, onImageClick }: BuildingTimelineProps) {
  return (
    <div className="space-y-8">
      {events.map((event, idx) => (
        <div key={idx}>
          <div className="flex flex-wrap items-baseline gap-x-2">
            <span className="text-lg font-bold text-primary-700">{event.year}</span>
            <span className="font-medium text-gray-700">{event.label}</span>
          </div>

          {event.date && <p className="text-sm text-gray-500 mt-0.5">{event.date}</p>}

          {event.detail && <p className="text-gray-700 leading-relaxed mt-2">{event.detail}</p>}

          {event.authority && (
            <div className="flex items-center gap-3 mt-4">
              {event.authorityImage && (
                <img
                  src={event.authorityImage}
                  alt={event.authority}
                  className={`w-16 h-16 rounded-full object-cover border-2 border-gray-200${
                    onImageClick ? ' cursor-pointer hover:opacity-80 transition-opacity' : ''
                  }`}
                  onClick={onImageClick ? () => onImageClick(event.authorityImage!, event.authority!) : undefined}
                />
              )}
              <div>
                <p className="font-medium text-gray-900">{event.authority}</p>
                {event.authorityRole && <p className="text-sm text-gray-500">{event.authorityRole}</p>}
              </div>
            </div>
          )}
        </div>
      ))}
    </div>
  )
}
