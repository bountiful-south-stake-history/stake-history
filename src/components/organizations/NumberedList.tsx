import type { Calling, Person, Position } from '../../lib/types'
import { formatCallingRange, parseLocalDate } from '../../lib/utils'
import { PortraitDisplay } from '../people/PortraitDisplay'
import { PersonNameLink } from '../people/PersonNameLink'

interface CallingWithDetails extends Calling {
  person: Person
  position: Position
}

interface NumberedListProps {
  callings: CallingWithDetails[]
}

export function NumberedList({ callings }: NumberedListProps) {
  const sortedCallings = [...callings].sort((a, b) => {
    const aNum = a.presidency_number ?? 0
    const bNum = b.presidency_number ?? 0
    if (aNum !== bNum) return bNum - aNum
    return parseLocalDate(a.sustained_date).getTime() - parseLocalDate(b.sustained_date).getTime()
  })

  return (
    <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200">
      <ol className="space-y-4">
        {sortedCallings.map((calling) => {
          const number = calling.presidency_number ?? 0
          return (
            <li key={calling.id} className="flex items-start gap-3">
              <span className="font-bold text-primary-700 text-lg min-w-[3rem]">
                {number}.
              </span>
              <PortraitDisplay person={calling.person} />
              <div className="flex-1">
                <div className="font-semibold text-lg">
                  <PersonNameLink person={calling.person} className="text-gray-900" />
                </div>
                <div className="text-sm text-gray-600 mt-1">
                  {calling.position.title}
                </div>
                <div className="text-xs text-gray-500 mt-1">
                  {formatCallingRange(calling)}
                </div>
                {calling.notes && (
                  <div className="text-xs text-gray-600 mt-1 italic">
                    {calling.notes}
                  </div>
                )}
              </div>
            </li>
          )
        })}
      </ol>
    </div>
  )
}

