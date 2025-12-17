import { useParams, Link } from 'react-router-dom'
import { useOrganization } from '../hooks/useOrganization'
import { useOrganizationCallings } from '../hooks/useOrganizationCallings'
import { PresidencyCard } from '../components/organizations/PresidencyCard'
import { NumberedList } from '../components/organizations/NumberedList'
import { parseLocalDate } from '../lib/utils'

export function OrganizationPage() {
  const { id } = useParams<{ id: string }>()
  const { organization, loading: orgLoading, error: orgError } = useOrganization(id || '')
  const { callings, loading: callingsLoading, error: callingsError } = useOrganizationCallings(id || '')

  const loading = orgLoading || callingsLoading
  const error = orgError || callingsError

  const getDisplayType = () => {
    if (!organization) return 'presidency'
    const name = organization.name.toLowerCase()
    
    if (
      name.includes('high council') ||
      name.includes('secretary') ||
      name.includes('clerk') ||
      name.includes('patriarch')
    ) {
      return 'numbered'
    }
    
    if (organization.org_type === 'ward') {
      return 'bishopric'
    }
    
    return 'presidency'
  }

  const displayType = getDisplayType()

  const presidencies = callings.reduce((acc, calling) => {
    const presNum = calling.presidency_number ?? 0
    if (!acc[presNum]) {
      acc[presNum] = []
    }
    acc[presNum].push(calling)
    return acc
  }, {} as Record<number, typeof callings>)

  const sortedPresidencies = Object.entries(presidencies)
    .map(([num, calls]) => ({
      number: parseInt(num),
      callings: calls,
      earliestDate: Math.min(...calls.map(c => parseLocalDate(c.sustained_date).getTime())),
    }))
    .sort((a, b) => b.earliestDate - a.earliestDate)

  if (loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading organization...</div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">
        Error loading organization: {error.message}
      </div>
    )
  }

  if (!organization) {
    return (
      <div className="text-center py-12">
        <h1 className="text-2xl font-bold text-gray-900 mb-4">Organization Not Found</h1>
        <Link to="/" className="text-primary-600 hover:text-primary-700 underline">
          Back to Home
        </Link>
      </div>
    )
  }

  const orgTypeLabel = {
    stake: 'Stake',
    ward: 'Ward',
    branch: 'Branch',
    auxiliary: 'Auxiliary',
  }[organization.org_type] || organization.org_type

  return (
    <div>
      <div className="mb-6">
        <Link
          to="/"
          className="text-primary-600 hover:text-primary-700 underline mb-4 inline-block"
        >
          ← Back to Home
        </Link>
        <h1 className="text-4xl font-bold text-primary-700 mt-2">
          {organization.name}
        </h1>
        <p className="text-lg text-gray-600 mt-1">
          {orgTypeLabel} • {organization.organized_date && `Organized ${parseLocalDate(organization.organized_date).getFullYear()}`}
        </p>
        {organization.discontinued_date && (
          <p className="text-sm text-gray-500 mt-1">
            Discontinued {parseLocalDate(organization.discontinued_date).getFullYear()}
          </p>
        )}
        {organization.notes && (
          <div className="bg-gray-50 border-l-4 border-primary-500 rounded-r-lg p-4 mt-4">
            <p className="text-sm text-gray-700 italic leading-relaxed">
              {organization.notes}
            </p>
          </div>
        )}
      </div>

      {callings.length === 0 ? (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center">
          <p className="text-gray-600">No calling records found for this organization.</p>
        </div>
      ) : displayType === 'numbered' ? (
        <NumberedList callings={callings} />
      ) : (
        <div className="space-y-6">
          {sortedPresidencies.map(({ number, callings: presCallings }) => (
            <PresidencyCard
              key={number}
              presidencyNumber={number}
              callings={presCallings}
              labelType={displayType === 'bishopric' ? 'bishopric' : 'presidency'}
            />
          ))}
        </div>
      )}
    </div>
  )
}
