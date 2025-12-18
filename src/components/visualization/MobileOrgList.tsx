import { Link } from 'react-router-dom'
import type { Organization } from '../../lib/types'

interface MobileOrgListProps {
  organizations: Organization[]
}

function getDisplayName(org: Organization): string {
  const name = org.name.toLowerCase()
  
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
    return 'Mission'
  }
  
  return org.short_name || org.name
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
    return 'bg-[#1e3a5f] text-white border-2 border-[#152a47]'
  }
  
  if (
    name.includes('mission') ||
    (org.org_type === 'ward' && name.includes('57th'))
  ) {
    return 'bg-[#7851a9] text-white border-2 border-[#5d3d8a]'
  }
  
  if (
    name.includes('relief society') ||
    name.includes('young men') ||
    name.includes('young women') ||
    name.includes('primary') ||
    name.includes('sunday school')
  ) {
    return 'bg-[#c17f24] text-white border-2 border-[#a0661d]'
  }
  
  if (org.org_type === 'ward' || org.org_type === 'branch') {
    return 'bg-[#287271] text-white border-2 border-[#1f5656]'
  }
  
  return 'bg-accent-500 text-white border-2 border-accent-600'
}

export function MobileOrgList({ organizations }: MobileOrgListProps) {
  const { stakeLeadership, auxiliaries, wardsAndBranches } = categorizeOrganizations(organizations)

  const renderOrgCard = (org: Organization) => {
    const displayName = getDisplayName(org)
    const cardStyle = getCardStyle(org)

    return (
      <Link
        key={org.id}
        to={`/org/${org.id}`}
        className={`block ${cardStyle} rounded-lg px-4 py-3 text-center font-medium hover:opacity-90 transition-opacity`}
      >
        {displayName}
      </Link>
    )
  }

  return (
    <div className="space-y-6 px-4">
      {stakeLeadership.length > 0 && (
        <div>
          <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">
            Stake Leadership
          </h2>
          <div className="space-y-2">
            {stakeLeadership.map(renderOrgCard)}
          </div>
        </div>
      )}

      {auxiliaries.length > 0 && (
        <div>
          <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">
            Auxiliary Organizations
          </h2>
          <div className="space-y-2">
            {auxiliaries.map(renderOrgCard)}
          </div>
        </div>
      )}

      {wardsAndBranches.length > 0 && (
        <div>
          <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">
            Wards & Branches
          </h2>
          <div className="space-y-2">
            {wardsAndBranches.map(renderOrgCard)}
          </div>
        </div>
      )}
    </div>
  )
}

