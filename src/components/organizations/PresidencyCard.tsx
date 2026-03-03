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

  const getPositionLabel = (positionType: string, title: string) => {
    if (positionType === 'president') {
      return labelType === 'bishopric' ? 'Bishop' : 'President'
    }
    if (positionType === 'counselor') {
      if (title.toLowerCase().includes('first')) return '1st Counselor'
      if (title.toLowerCase().includes('second')) return '2nd Counselor'
      return 'Counselor'
    }
    return title
  }

  const CallingRow = ({ calling, isPresident = false }: { calling: CallingWithDetails; isPresident?: boolean }) => (
    <>
      {/* Desktop view */}
      <div className="hidden md:flex items-center gap-3">
        <PortraitDisplay person={calling.person} personId={calling.person?.id || undefined} />
        <div className="flex-1 min-w-0">
          <div className={`font-semibold ${isPresident ? 'text-lg' : 'text-base'} break-words`}>
            <PersonNameLink person={calling.person} className={isPresident ? 'text-primary-700' : 'text-gray-900'} />
          </div>
          <div className="text-sm text-gray-600 mt-1">{calling.position.title}</div>
          <div className="text-xs text-gray-500 mt-1">
            {formatCallingRange(calling)}
          </div>
        </div>
      </div>
      {/* Mobile view - matching Appointments app style */}
      <div className="md:hidden flex items-start gap-4 py-3 border-b border-gray-100 last:border-b-0">
        <div className="w-24 flex-shrink-0 pt-1">
          <span className="text-sm text-gray-500">
            {getPositionLabel(calling.position.position_type, calling.position.title)}:
          </span>
        </div>
        <div className="flex-1 min-w-0">
          <div className="font-semibold text-base text-primary-600 break-words">
            <PersonNameLink person={calling.person} className="text-primary-600" />
          </div>
          <div className="text-sm text-primary-400 mt-0.5">{calling.position.title}</div>
          <div className="text-xs text-gray-500 mt-0.5">
            {formatCallingRange(calling)}
          </div>
        </div>
      </div>
    </>
  )

  return (
    <div className="bg-white rounded-lg shadow-md p-4 md:p-6 border border-gray-200">
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 mb-4">
        <h3 className="text-lg md:text-xl font-bold text-primary-700">
          {presidencyNumber === 0 
            ? 'Current Leadership' 
            : `${presidencyNumber}${getOrdinalSuffix(presidencyNumber)} ${labelType === 'bishopric' ? 'Bishopric' : 'Presidency'}`}
        </h3>
        <span className="text-xs sm:text-sm text-gray-600 whitespace-nowrap">
          {earliestDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long' })} –{' '}
          {isCurrent ? 'Present' : latestDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long' })}
        </span>
      </div>

      {president && (
        <div className="mb-4 pb-4 border-b border-gray-200 md:border-b">
          <CallingRow calling={president} isPresident />
        </div>
      )}

      {counselors.length > 0 && (
        <div className="mb-4">
          <h4 className="hidden md:block text-sm font-semibold text-gray-700 mb-2">
            Counselors
          </h4>
          <div className="md:space-y-3 md:pl-4">
            {counselors.map(calling => (
              <CallingRow key={calling.id} calling={calling} />
            ))}
          </div>
        </div>
      )}

      {others.length > 0 && (
        <div>
          <h4 className="hidden md:block text-sm font-semibold text-gray-700 mb-2">Other Positions</h4>
          <div className="md:space-y-3 md:pl-4">
            {others.map(calling => (
              <CallingRow key={calling.id} calling={calling} />
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

