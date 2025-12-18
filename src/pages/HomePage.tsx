import { useEffect } from 'react'
import { Link } from 'react-router-dom'
import { getPeopleCount } from '../hooks/usePeople'
import { useOrganizations } from '../hooks/useOrganizations'
import { PersonSearch } from '../components/search/PersonSearch'
import type { Organization } from '../lib/types'

function isDiscontinued(org: Organization): boolean {
  const name = org.name.toLowerCase()
  return name.includes('mission') || (org.org_type === 'ward' && name.includes('57th'))
}

function getDisplayName(org: Organization): string {
  const name = org.name.toLowerCase()
  const discontinued = isDiscontinued(org)
  const asterisk = discontinued ? '*' : ''
  
  if (name.includes('executive secretary')) {
    return 'Executive Secretary'
  }
  if (name.includes('stake clerk') && !name.includes('assistant')) {
    return 'Stake Clerk'
  }
  if (name.includes('assistant stake clerk') || name.includes('assistant clerk')) {
    return 'Assistant Clerk'
  }
  if (name.includes('stake relief society') || name.includes('relief society')) {
    return 'Relief Society'
  }
  if (name.includes('stake young men') || name.includes('young men')) {
    return 'Young Men'
  }
  if (name.includes('stake young women') || name.includes('young women')) {
    return 'Young Women'
  }
  if (name.includes('stake primary') || name.includes('primary')) {
    return 'Primary'
  }
  if (name.includes('stake sunday school') || name.includes('sunday school')) {
    return 'Sunday School'
  }
  if (name.includes('stake mission') || name.includes('mission')) {
    return 'Mission' + asterisk
  }
  
  const baseName = org.short_name || org.name
  if (discontinued) {
    return baseName + asterisk
  }
  return baseName
}

function categorizeOrganizations(organizations: Organization[]): {
  stakeLeadership: Organization[]
  auxiliaries: Organization[]
  wardsAndBranches: Organization[]
} {
  const stakeLeadership: Organization[] = []
  const auxiliaries: Organization[] = []
  const wardsAndBranches: Organization[] = []

  organizations.forEach(org => {
    const name = org.name.toLowerCase()

    if (
      name.includes('stake presidency') ||
      name.includes('executive secretary') ||
      (name.includes('stake clerk') && !name.includes('assistant')) ||
      name.includes('assistant stake clerk') ||
      name.includes('assistant clerk') ||
      name.includes('high council') ||
      name.includes('patriarch')
    ) {
      stakeLeadership.push(org)
    } else if (
      name.includes('relief society') ||
      name.includes('young men') ||
      name.includes('young women') ||
      name.includes('primary') ||
      name.includes('sunday school') ||
      name.includes('mission')
    ) {
      auxiliaries.push(org)
    } else if (org.org_type === 'ward' || org.org_type === 'branch') {
      wardsAndBranches.push(org)
    }
  })

  const sortByOrder = (a: Organization, b: Organization) => a.sort_order - b.sort_order

  return {
    stakeLeadership: stakeLeadership.sort(sortByOrder),
    auxiliaries: auxiliaries.sort(sortByOrder),
    wardsAndBranches: wardsAndBranches.sort(sortByOrder),
  }
}

function getCardStyle(org: Organization): string {
  const name = org.name.toLowerCase()
  
  if (
    name.includes('stake presidency') ||
    name.includes('executive secretary') ||
    (name.includes('stake clerk') && !name.includes('assistant')) ||
    name.includes('assistant stake clerk') ||
    name.includes('assistant clerk') ||
    name.includes('high council') ||
    name.includes('patriarch')
  ) {
    return 'bg-[#1e3a5f] text-white border-l-4 border-[#152a47] hover:bg-[#152a47]'
  }
  
  if (
    name.includes('relief society') ||
    name.includes('young men') ||
    name.includes('young women') ||
    name.includes('primary') ||
    name.includes('sunday school') ||
    name.includes('mission')
  ) {
    return 'bg-[#c17f24] text-white border-l-4 border-[#a0661d] hover:bg-[#a0661d]'
  }
  
  if (org.org_type === 'ward' || org.org_type === 'branch') {
    return 'bg-[#287271] text-white border-l-4 border-[#1f5656] hover:bg-[#1f5656]'
  }
  
  return 'bg-accent-500 text-white border-l-4 border-accent-600 hover:bg-accent-600'
}

export function HomePage() {
  const { organizations, loading, error } = useOrganizations()

  useEffect(() => {
    async function checkConnection() {
      try {
        const count = await getPeopleCount()
        console.log(`✅ Supabase connection successful! People count: ${count}`)
      } catch (err) {
        console.error('❌ Supabase connection failed:', err)
      }
    }
    checkConnection()
  }, [])

  const { stakeLeadership, auxiliaries, wardsAndBranches } = categorizeOrganizations(organizations)
  
  const hasDiscontinued = organizations.some(org => isDiscontinued(org))

  const renderOrgCard = (org: Organization) => {
    const displayName = getDisplayName(org)
    const cardStyle = getCardStyle(org)

    return (
      <Link
        key={org.id}
        to={`/org/${org.id}`}
        className={`block ${cardStyle} rounded-lg px-4 py-3 text-center font-medium transition-colors shadow-sm`}
      >
        {displayName}
      </Link>
    )
  }

  return (
    <div className="min-h-screen bg-[#F8F9FA]">
      <div className="container mx-auto px-4 py-6 md:py-8">
        <div className="mb-8">
          <PersonSearch />
        </div>

        <div className="text-center mb-8">
          <h1 className="text-3xl md:text-4xl font-bold text-primary-700 mb-2">
            Stake Leadership History
          </h1>
          <p className="text-base md:text-lg text-gray-500">
            1958 to Present
          </p>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-6">
            Error loading organizations: {error.message}
          </div>
        )}

        {loading ? (
          <div className="text-center py-12 text-gray-600">Loading organizations...</div>
        ) : (
          <div className="space-y-10 max-w-6xl mx-auto">
            {stakeLeadership.length > 0 && (
              <section>
                <div className="border-t border-gray-200 pt-6 mb-4">
                  <h2 className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                    Stake Leadership
                  </h2>
                </div>
                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                  {stakeLeadership.map(renderOrgCard)}
                </div>
              </section>
            )}

            {auxiliaries.length > 0 && (
              <section>
                <div className="border-t border-gray-200 pt-6 mb-4">
                  <h2 className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                    Auxiliaries
                  </h2>
                </div>
                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                  {auxiliaries.map(renderOrgCard)}
                </div>
              </section>
            )}

            {wardsAndBranches.length > 0 && (
              <section>
                <div className="border-t border-gray-200 pt-6 mb-4">
                  <h2 className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                    Wards & Branches
                  </h2>
                </div>
                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
                  {wardsAndBranches.map(renderOrgCard)}
                </div>
              </section>
            )}

            {hasDiscontinued && (
              <div className="text-center pt-4">
                <p className="text-xs text-gray-500 italic">
                  * Discontinued organization
                </p>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  )
}

