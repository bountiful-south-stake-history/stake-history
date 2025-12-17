import { useCallback, useMemo, useState, useEffect } from 'react'
import ReactFlow, {
  Node,
  Edge,
  Background,
  Controls,
  useNodesState,
  useEdgesState,
  ConnectionMode,
} from 'reactflow'
import { useNavigate } from 'react-router-dom'
import type { Organization } from '../../lib/types'
import { OrgNode } from './OrgNode'

interface OrgChartProps {
  organizations: Organization[]
  loading?: boolean
}

const nodeTypes = {
  orgNode: OrgNode,
}

function getDisplayName(org: Organization): string {
  const name = org.name.toLowerCase()
  
  if (name.includes('executive secretary')) {
    return 'Exec. Secretary'
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
  stakePresidency: Organization[]
  execSecAndClerks: Organization[]
  highCouncilAndPatriarch: Organization[]
  auxiliaries: Organization[]
  wardsRow1: Organization[]
  wardsRow2: Organization[]
  branches: Organization[]
} {
  const stakePresidency: Organization[] = []
  const execSecAndClerks: Organization[] = []
  const highCouncilAndPatriarch: Organization[] = []
  const auxiliaries: Organization[] = []
  const wardsRow1: Organization[] = []
  const wardsRow2: Organization[] = []
  const branches: Organization[] = []

  organizations.forEach(org => {
    const name = org.name.toLowerCase()
    const shortName = org.short_name?.toLowerCase() || ''

    if (name.includes('stake presidency') || shortName.includes('stake presidency')) {
      stakePresidency.push(org)
    } else if (
      name.includes('executive secretary') ||
      (name.includes('stake clerk') && !name.includes('assistant'))
    ) {
      execSecAndClerks.push(org)
    } else if (name.includes('assistant stake clerk') || name.includes('assistant clerk')) {
      execSecAndClerks.push(org)
    } else if (name.includes('high council')) {
      highCouncilAndPatriarch.push(org)
    } else if (name.includes('patriarch')) {
      highCouncilAndPatriarch.push(org)
    } else if (
      name.includes('relief society') ||
      name.includes('young men') ||
      name.includes('young women') ||
      name.includes('primary') ||
      name.includes('sunday school') ||
      name.includes('mission')
    ) {
      auxiliaries.push(org)
    } else if (org.org_type === 'ward') {
      const wardNum = shortName.match(/\d+/)?.[0] || name.match(/\d+/)?.[0] || ''
      const num = parseInt(wardNum)
      if ([4, 7, 14, 15, 20].includes(num)) {
        wardsRow1.push(org)
      } else if ([25, 36, 39, 57].includes(num)) {
        wardsRow2.push(org)
      } else {
        wardsRow1.push(org)
      }
    } else if (org.org_type === 'branch') {
      branches.push(org)
    }
  })

  const sortByOrder = (a: Organization, b: Organization) => a.sort_order - b.sort_order

  return {
    stakePresidency: stakePresidency.sort(sortByOrder),
    execSecAndClerks: execSecAndClerks.sort(sortByOrder),
    highCouncilAndPatriarch: highCouncilAndPatriarch.sort(sortByOrder),
    auxiliaries: auxiliaries.sort(sortByOrder),
    wardsRow1: wardsRow1.sort(sortByOrder),
    wardsRow2: wardsRow2.sort(sortByOrder),
    branches: branches.sort(sortByOrder),
  }
}

function buildVerticalTree(
  organizations: Organization[],
  _expandedNodes: Set<string>,
  _toggleNode: (nodeId: string) => void,
  navigate: (path: string) => void
) {
  const {
    stakePresidency,
    execSecAndClerks,
    highCouncilAndPatriarch,
    auxiliaries,
    wardsRow1,
    wardsRow2,
    branches,
  } = categorizeOrganizations(organizations)

  if (stakePresidency.length === 0) return { nodes: [], edges: [] }

  const nodes: Node[] = []
  const edges: Edge[] = []
  const tightRowHeight = 65
  const largeGap = 60
  const nodeSpacing = 160
  const startY = 50

  const createNode = (
    org: Organization,
    x: number,
    y: number
  ): void => {
    const displayName = getDisplayName(org)
    nodes.push({
      id: org.id,
      type: 'orgNode',
      position: { x, y },
      data: {
        org,
        displayName,
        onClick: () => navigate(`/org/${org.id}`),
        isExpanded: false,
        onToggle: () => _toggleNode(org.id),
        hasChildren: false,
      },
    })
  }

  let currentY = startY
  const centerX = 0

  const createRow = (orgs: Organization[], horizontalSpacing: number = nodeSpacing, verticalSpacing: number = tightRowHeight) => {
    if (orgs.length === 0) return
    const totalWidth = (orgs.length - 1) * horizontalSpacing
    const startX = centerX - totalWidth / 2

    orgs.forEach((org, index) => {
      const x = startX + index * horizontalSpacing
      createNode(org, x, currentY)
    })
    currentY += verticalSpacing
  }

  if (stakePresidency.length > 0) {
    createRow(stakePresidency, 150, tightRowHeight)
  }

  if (execSecAndClerks.length > 0) {
    createRow(execSecAndClerks, 150, tightRowHeight)
  }

  if (highCouncilAndPatriarch.length > 0) {
    createRow(highCouncilAndPatriarch, 150, tightRowHeight)
  }

  currentY += largeGap

  if (auxiliaries.length > 0) {
    createRow(auxiliaries, 150, tightRowHeight)
  }

  currentY += largeGap

  if (wardsRow1.length > 0) {
    createRow(wardsRow1, 150, tightRowHeight)
  }

  const row2Orgs = [...wardsRow2, ...branches]
  if (row2Orgs.length > 0) {
    createRow(row2Orgs, 150, tightRowHeight)
  }

  return { nodes, edges }
}

export function OrgChart({ organizations, loading }: OrgChartProps) {
  const navigate = useNavigate()
  const stakePresidencyId = useMemo(
    () => organizations.find(o => o.name.toLowerCase().includes('stake presidency'))?.id,
    [organizations]
  )
  const [expandedNodes, setExpandedNodes] = useState<Set<string>>(
    stakePresidencyId ? new Set([stakePresidencyId]) : new Set()
  )

  const toggleNode = useCallback((nodeId: string) => {
    setExpandedNodes(prev => {
      const next = new Set(prev)
      if (next.has(nodeId)) {
        next.delete(nodeId)
      } else {
        next.add(nodeId)
      }
      return next
    })
  }, [])

  const { nodes: initialNodes, edges: initialEdges } = useMemo(() => {
    if (organizations.length === 0) {
      return { nodes: [], edges: [] }
    }

    return buildVerticalTree(organizations, expandedNodes, toggleNode, navigate)
  }, [organizations, expandedNodes, toggleNode, navigate])

  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes)
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges)

  useEffect(() => {
    const { nodes: newNodes, edges: newEdges } = buildVerticalTree(
      organizations,
      expandedNodes,
      toggleNode,
      navigate
    )
    setNodes(newNodes)
    setEdges(newEdges)
  }, [organizations, expandedNodes, toggleNode, navigate, setNodes, setEdges])

  const onNodeClick = useCallback(
    (_event: React.MouseEvent, node: Node) => {
      const org = node.data?.org as Organization
      if (org) {
        navigate(`/org/${org.id}`)
      }
    },
    [navigate]
  )

  if (loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading organizations...</div>
      </div>
    )
  }

  if (organizations.length === 0) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">No organizations found</div>
      </div>
    )
  }

  return (
    <div className="w-full h-[700px] border border-gray-300 rounded-lg overflow-hidden">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onNodeClick={onNodeClick}
        nodeTypes={nodeTypes}
        connectionMode={ConnectionMode.Loose}
        fitView
        fitViewOptions={{ padding: 0.2 }}
        proOptions={{ hideAttribution: true }}
      >
        <Background color="#e5e7eb" gap={16} />
        <Controls />
      </ReactFlow>
    </div>
  )
}
