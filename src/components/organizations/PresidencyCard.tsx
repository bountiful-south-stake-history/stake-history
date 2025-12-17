import type { Calling, Person, Position } from '../../lib/types'
import { formatCallingRange, parseLocalDate } from '../../lib/utils'
import { PortraitDisplay } from '../people/PortraitDisplay'
import { PersonNameLink } from '../people/PersonNameLink'

interface CallingWithDetails extends Calling {
  person: Person
  position: Position
}

interface PresidencyCardProps {
  presidencyNumber: number
  callings: CallingWithDetails[]
  labelType?: 'presidency' | 'bishopric'
}

export function PresidencyCard({ presidencyNumber, callings, labelType = 'presidency' }: PresidencyCardProps) {
  if (callings.length === 0) return null

  const sortedCallings = [...callings].sort((a, b) => {
    const positionOrder = a.position.sort_order - b.position.sort_order
    if (positionOrder !== 0) return positionOrder
    return parseLocalDate(a.sustained_date).getTime() - parseLocalDate(b.sustained_date).getTime()
  })

  const president = sortedCallings.find(c => c.position.position_type === 'president')
  const counselors = sortedCallings.filter(c => c.position.position_type === 'counselor')
  const others = sortedCallings.filter(
    c => !['president', 'counselor'].includes(c.position.position_type)
  )

  const earliestDate = callings.reduce((earliest, calling) => {
    const date = parseLocalDate(calling.sustained_date)
    return date < earliest ? date : earliest
  }, parseLocalDate(callings[0].sustained_date))

  const latestDate = callings.reduce((latest, calling) => {
    const date = calling.released_date ? parseLocalDate(calling.released_date) : new Date()
    return date > latest ? date : latest
  }, parseLocalDate(callings[0].sustained_date))

  const isCurrent = callings.some(c => !c.released_date)

  return (
    <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-xl font-bold text-primary-700">
          {presidencyNumber === 0 
            ? 'Current Leadership' 
            : `${presidencyNumber}${getOrdinalSuffix(presidencyNumber)} ${labelType === 'bishopric' ? 'Bishopric' : 'Presidency'}`}
        </h3>
        <span className="text-sm text-gray-600">
          {earliestDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long' })} –{' '}
          {isCurrent ? 'Present' : latestDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long' })}
        </span>
      </div>

      {president && (
        <div className="mb-4 pb-4 border-b border-gray-200">
          <div className="flex items-center gap-3">
            <PortraitDisplay person={president.person} />
            <div className="flex-1">
              <div className="font-semibold text-lg">
                <PersonNameLink person={president.person} className="text-primary-700" />
              </div>
              <div className="text-sm text-gray-600">{president.position.title}</div>
              <div className="text-xs text-gray-500 mt-1">
                {formatCallingRange(president)}
              </div>
            </div>
          </div>
        </div>
      )}

      {counselors.length > 0 && (
        <div className="mb-4">
          <h4 className="text-sm font-semibold text-gray-700 mb-2">
            {labelType === 'bishopric' ? 'Counselors' : 'Counselors'}
          </h4>
          <div className="space-y-2">
            {counselors.map(calling => (
              <div key={calling.id} className="flex items-center gap-3 pl-4">
                <PortraitDisplay person={calling.person} />
                <div className="flex-1">
                  <div className="font-medium">
                    <PersonNameLink person={calling.person} className="text-gray-900" />
                  </div>
                  <div className="text-sm text-gray-600">{calling.position.title}</div>
                  <div className="text-xs text-gray-500 mt-1">
                    {formatCallingRange(calling)}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {others.length > 0 && (
        <div>
          <h4 className="text-sm font-semibold text-gray-700 mb-2">Other Positions</h4>
          <div className="space-y-2">
            {others.map(calling => (
              <div key={calling.id} className="flex items-center gap-3 pl-4">
                <PortraitDisplay person={calling.person} />
                <div className="flex-1">
                  <div className="font-medium">
                    <PersonNameLink person={calling.person} className="text-gray-900" />
                  </div>
                  <div className="text-sm text-gray-600">{calling.position.title}</div>
                  <div className="text-xs text-gray-500 mt-1">
                    {formatCallingRange(calling)}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}

function getOrdinalSuffix(n: number): string {
  const j = n % 10
  const k = n % 100
  if (j === 1 && k !== 11) return 'st'
  if (j === 2 && k !== 12) return 'nd'
  if (j === 3 && k !== 13) return 'rd'
  return 'th'
}

