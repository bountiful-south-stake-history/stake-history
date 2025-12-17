import type { Organization } from '../../lib/types'

interface OrgNodeProps {
  data: {
    org: Organization & { displayName?: string }
    displayName?: string
    onClick: () => void
    isExpanded: boolean
    onToggle: () => void
    hasChildren: boolean
  }
}

export function OrgNode({ data }: OrgNodeProps) {
  const { org, displayName: propDisplayName, onClick, isExpanded, onToggle, hasChildren } = data

  const getNodeStyle = () => {
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

  const displayName = propDisplayName || org.short_name || org.name

  return (
    <div
      className={`${getNodeStyle()} rounded-lg shadow-lg px-4 py-3 w-[150px] cursor-pointer hover:shadow-xl transition-shadow`}
      onClick={onClick}
    >
      <div className="flex items-center justify-between gap-2">
        <div className="flex-1 text-center">
          <div className="font-semibold text-sm leading-tight">{displayName}</div>
        </div>
        
        {hasChildren && (
          <button
            onClick={(e) => {
              e.stopPropagation()
              onToggle()
            }}
            className="text-white hover:bg-white/20 rounded px-2 py-1 text-xs font-bold transition-colors"
            aria-label={isExpanded ? 'Collapse' : 'Expand'}
          >
            {isExpanded ? '−' : '+'}
          </button>
        )}
      </div>
    </div>
  )
}
