import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { useOrganizations } from '../../hooks/useOrganizations'
import { useOrganizationCallings } from '../../hooks/useOrganizationCallings'
import { usePeopleSearch } from '../../hooks/usePeopleSearch'
import { useAuth } from '../../hooks/useAuth'
import { formatDate } from '../../lib/utils'
import type { Person, Position, Calling } from '../../lib/types'

interface AdminTransitionsTabProps {
  onActionComplete?: () => void
}

interface NewLeadershipMember {
  position: 'president' | 'counselor1' | 'counselor2'
  personId: string | null
  personName: string
}

export function AdminTransitionsTab({ onActionComplete }: AdminTransitionsTabProps) {
  const { organizations, loading: orgsLoading } = useOrganizations()
  const { user } = useAuth()
  const [selectedOrgId, setSelectedOrgId] = useState<string>('')
  const { callings, loading: callingsLoading } = useOrganizationCallings(selectedOrgId)
  const [processing, setProcessing] = useState<string | null>(null)
  const [showBatchModal, setShowBatchModal] = useState(false)
  const [showReleaseModal, setShowReleaseModal] = useState<Calling | null>(null)
  const [showAddCounselorModal, setShowAddCounselorModal] = useState(false)
  const [showAddNewModal, setShowAddNewModal] = useState(false)
  const [showAddPersonModal, setShowAddPersonModal] = useState<string | false>(false)

  const [releaseDate, setReleaseDate] = useState('')
  const [selectedMembers, setSelectedMembers] = useState<Set<string>>(new Set())
  const [sustainedDate, setSustainedDate] = useState('')
  const [newLeadership, setNewLeadership] = useState<NewLeadershipMember[]>([
    { position: 'president', personId: null, personName: '' },
    { position: 'counselor1', personId: null, personName: '' },
    { position: 'counselor2', personId: null, personName: '' },
  ])
  const [searchTerms, setSearchTerms] = useState<Record<string, string>>({})
  const [newPersonName, setNewPersonName] = useState('')

  const [addCounselorPosition, setAddCounselorPosition] = useState<'counselor1' | 'counselor2' | 'president'>('counselor1')
  const [addCounselorPersonId, setAddCounselorPersonId] = useState<string | null>(null)
  const [addCounselorPersonName, setAddCounselorPersonName] = useState('')
  const [addCounselorSearchTerm, setAddCounselorSearchTerm] = useState('')
  const [addCounselorSustainedDate, setAddCounselorSustainedDate] = useState('')

  const [addNewPersonId, setAddNewPersonId] = useState<string | null>(null)
  const [addNewPersonName, setAddNewPersonName] = useState('')
  const [addNewSearchTerm, setAddNewSearchTerm] = useState('')
  const [addNewSustainedDate, setAddNewSustainedDate] = useState('')
  const [addNewPositionId, setAddNewPositionId] = useState<string>('')
  const [availablePositions, setAvailablePositions] = useState<Position[]>([])

  const loading = orgsLoading || callingsLoading

  const filteredOrganizations = organizations.filter(
    (org) => org.name !== 'Bountiful Utah South Stake'
  )

  const selectedOrg = organizations.find((o) => o.id === selectedOrgId)
  const isWard = selectedOrg?.org_type === 'ward'
  const isBranch = selectedOrg?.org_type === 'branch'

  const isPresidencyOrg = selectedOrg && (
    selectedOrg.org_type === 'ward' ||
    selectedOrg.org_type === 'branch' ||
    selectedOrg.name.toLowerCase().includes('presidency') ||
    selectedOrg.name.toLowerCase().includes('relief society') ||
    selectedOrg.name.toLowerCase().includes('young men') ||
    selectedOrg.name.toLowerCase().includes('young women') ||
    selectedOrg.name.toLowerCase().includes('primary') ||
    selectedOrg.name.toLowerCase().includes('sunday school') ||
    selectedOrg.name.toLowerCase().includes('mission')
  )

  const currentPresidency = callings.reduce((max, calling) => {
    const num = calling.presidency_number ?? 0
    return num > max ? num : max
  }, 0)

  const currentCallings = callings
    .filter((c) => !c.released_date)
    .sort((a, b) => {
      if (isPresidencyOrg) {
        const aPositionType = a.position?.position_type || ''
        const bPositionType = b.position?.position_type || ''
        const aSortOrder = a.position?.sort_order || 0
        const bSortOrder = b.position?.sort_order || 0

        if (aPositionType === 'president' && bPositionType !== 'president') return -1
        if (aPositionType !== 'president' && bPositionType === 'president') return 1

        if (aPositionType === 'counselor' && bPositionType === 'counselor') {
          return aSortOrder - bSortOrder
        }

        return 0
      } else {
        const aNum = a.presidency_number ?? 0
        const bNum = b.presidency_number ?? 0
        return bNum - aNum
      }
    })

  const currentPresidencyCallings = isPresidencyOrg
    ? currentCallings.filter((c) => c.presidency_number === currentPresidency)
    : []

  const nextPresidencyNumber = currentPresidency + 1

  const positionLabels = {
    president: isWard ? 'Bishop' : isBranch ? 'Branch President' : 'President',
    counselor1: '1st Counselor',
    counselor2: '2nd Counselor',
  }

  useEffect(() => {
    if (selectedOrgId && !isPresidencyOrg) {
      const fetchPositions = async () => {
        try {
          const { data, error } = await supabase
            .from('positions')
            .select('*')
            .order('sort_order', { ascending: true })

          if (error) throw error

          let filtered = data || []

          if (selectedOrg) {
            if (
              selectedOrg.name.toLowerCase().includes('executive secretary') ||
              selectedOrg.name.toLowerCase().includes('secretary')
            ) {
              filtered = filtered.filter((p) => p.position_type === 'secretary')
            } else if (
              selectedOrg.name.toLowerCase().includes('clerk') &&
              !selectedOrg.name.toLowerCase().includes('assistant')
            ) {
              filtered = filtered.filter((p) => p.title === 'Stake Clerk' || p.position_type === 'clerk')
            } else if (selectedOrg.name.toLowerCase().includes('assistant clerk')) {
              filtered = filtered.filter((p) => p.title === 'Assistant Stake Clerk' || p.position_type === 'clerk')
            } else if (selectedOrg.name.toLowerCase().includes('patriarch')) {
              filtered = filtered.filter((p) => p.title.includes('Patriarch') || p.position_type === 'other')
            } else if (selectedOrg.name.toLowerCase().includes('high council')) {
              filtered = filtered.filter((p) => p.title === 'High Councilor' || p.position_type === 'member')
            }
          }

          setAvailablePositions(filtered)

          if (filtered.length === 1) {
            setAddNewPositionId(filtered[0].id)
          }
        } catch (err) {
          console.error('Failed to fetch positions:', err)
        }
      }

      fetchPositions()
    } else {
      setAvailablePositions([])
      setAddNewPositionId('')
    }
  }, [selectedOrgId, selectedOrg, isPresidencyOrg])

  const getMaxPresidencyNumber = () => {
    return callings.reduce((max, calling) => {
      const num = calling.presidency_number ?? 0
      return num > max ? num : max
    }, 0)
  }

  const handleRelease = async () => {
    if (!showReleaseModal || !releaseDate) {
      alert('Please enter a release date')
      return
    }

    setProcessing(showReleaseModal.id)
    try {
      const oldValues = {
        person_id: showReleaseModal.person_id,
        position_id: showReleaseModal.position_id,
        organization_id: showReleaseModal.organization_id,
        presidency_number: showReleaseModal.presidency_number,
        sustained_date: showReleaseModal.sustained_date,
        released_date: showReleaseModal.released_date,
        notes: showReleaseModal.notes,
      }

      const { error: updateError } = await supabase
        .from('callings')
        .update({
          released_date: releaseDate,
          released_precision: 'exact',
        })
        .eq('id', showReleaseModal.id)

      if (updateError) throw updateError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: showReleaseModal.id,
          action: 'release_calling',
          old_values: oldValues,
          new_values: { ...oldValues, released_date: releaseDate, released_precision: 'exact' },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowReleaseModal(null)
      setReleaseDate('')
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to release calling')
    } finally {
      setProcessing(null)
    }
  }

  const handleAddCounselor = async () => {
    if (!addCounselorPersonId || !addCounselorSustainedDate) {
      alert('Please select a person and enter a sustained date')
      return
    }

    setProcessing('add-counselor')
    try {
      const org = organizations.find((o) => o.id === selectedOrgId)
      if (!org) throw new Error('Organization not found')

      const positionMap: Record<string, string> = {}
      const { data: positions, error: positionsError } = await supabase
        .from('positions')
        .select('*')
        .in('position_type', ['president', 'counselor'])

      if (positionsError) throw positionsError

      if (!positions || positions.length === 0) {
        throw new Error('No positions found')
      }

      positions.forEach((p) => {
        if (p.position_type === 'president') {
          positionMap['president'] = p.id
        } else if (p.position_type === 'counselor') {
          positionMap['counselor'] = p.id
        }
      })

      let presidencyNum: number
      if (addCounselorPosition === 'president') {
        presidencyNum = getMaxPresidencyNumber() + 1
      } else {
        const currentBishop = currentPresidencyCallings.find(
          (c) => c.position?.position_type === 'president'
        )
        if (!currentBishop) {
          throw new Error('No current Bishop/President found. Cannot add counselor without a Bishop/President.')
        }
        presidencyNum = currentBishop.presidency_number ?? currentPresidency
      }

      const positionId = addCounselorPosition === 'president' ? positionMap['president'] : positionMap['counselor']

      const { data: newCalling, error: insertError } = await supabase
        .from('callings')
        .insert({
          person_id: addCounselorPersonId,
          organization_id: selectedOrgId,
          position_id: positionId,
          presidency_number: presidencyNum,
          sustained_date: addCounselorSustainedDate,
          sustained_precision: 'exact',
        })
        .select()
        .single()

      if (insertError) throw insertError

      if (user && newCalling) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: newCalling.id,
          action: 'add_calling',
          old_values: null,
          new_values: {
            person_id: addCounselorPersonId,
            organization_id: selectedOrgId,
            position_id: positionId,
            presidency_number: presidencyNum,
            sustained_date: addCounselorSustainedDate,
            sustained_precision: 'exact',
          },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowAddCounselorModal(false)
      setAddCounselorPersonId(null)
      setAddCounselorPersonName('')
      setAddCounselorSearchTerm('')
      setAddCounselorSustainedDate('')
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to add calling')
    } finally {
      setProcessing(null)
    }
  }

  const handleAddNew = async () => {
    if (!addNewPersonId || !addNewPositionId || !addNewSustainedDate) {
      alert('Please select a person, position, and enter a sustained date')
      return
    }

    setProcessing('add-new')
    try {
      const maxNum = getMaxPresidencyNumber()
      const newPresidencyNum = maxNum + 1

      const { data: newCalling, error: insertError } = await supabase
        .from('callings')
        .insert({
          person_id: addNewPersonId,
          organization_id: selectedOrgId,
          position_id: addNewPositionId,
          presidency_number: newPresidencyNum,
          sustained_date: addNewSustainedDate,
          sustained_precision: 'exact',
        })
        .select()
        .single()

      if (insertError) throw insertError

      if (user && newCalling) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: newCalling.id,
          action: 'add_calling',
          old_values: null,
          new_values: {
            person_id: addNewPersonId,
            organization_id: selectedOrgId,
            position_id: addNewPositionId,
            presidency_number: newPresidencyNum,
            sustained_date: addNewSustainedDate,
            sustained_precision: 'exact',
          },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowAddNewModal(false)
      setAddNewPersonId(null)
      setAddNewPersonName('')
      setAddNewSearchTerm('')
      setAddNewSustainedDate('')
      setAddNewPositionId(availablePositions.length === 1 ? availablePositions[0].id : '')
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to add calling')
    } finally {
      setProcessing(null)
    }
  }

  const handlePersonSearch = (position: string, term: string) => {
    setSearchTerms({ ...searchTerms, [position]: term })
  }

  const handlePersonSelect = (position: string, person: Person | null) => {
    const index = newLeadership.findIndex((m) => m.position === position)
    if (index !== -1) {
      const updated = [...newLeadership]
      updated[index] = {
        ...updated[index],
        personId: person?.id || null,
        personName: person ? person.display_name || person.full_name : '',
      }
      setNewLeadership(updated)
      setSearchTerms({ ...searchTerms, [position]: '' })
    }
  }

  const handleAddNewPerson = async () => {
    if (!newPersonName.trim()) {
      alert('Please enter a name')
      return
    }

    try {
      const { data, error } = await supabase
        .from('people')
        .insert({
          full_name: newPersonName.trim(),
          redacted: false,
        })
        .select()
        .single()

      if (error) throw error

      if (showAddCounselorModal) {
        setAddCounselorPersonId(data.id)
        setAddCounselorPersonName(data.display_name || data.full_name)
      } else if (showAddNewModal) {
        setAddNewPersonId(data.id)
        setAddNewPersonName(data.display_name || data.full_name)
      } else {
        const position = showAddPersonModal || 'president'
        handlePersonSelect(position, data)
      }

      setShowAddPersonModal(false)
      setNewPersonName('')
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to create person')
    }
  }

  const handleMemberToggle = (callingId: string) => {
    const newSelected = new Set(selectedMembers)
    if (newSelected.has(callingId)) {
      newSelected.delete(callingId)
    } else {
      newSelected.add(callingId)
    }
    setSelectedMembers(newSelected)
  }

  const handleSelectAll = () => {
    if (selectedMembers.size === currentPresidencyCallings.length) {
      setSelectedMembers(new Set())
    } else {
      setSelectedMembers(new Set(currentPresidencyCallings.map((c) => c.id)))
    }
  }

  const handleReleaseDateChange = (date: string) => {
    setReleaseDate(date)
    if (!sustainedDate) {
      setSustainedDate(date)
    }
  }


  const handleBatchSave = async () => {
    if (selectedMembers.size === 0 && newLeadership.every((m) => !m.personId)) {
      alert('Please select members to release or add new leadership')
      return
    }

    if (selectedMembers.size > 0 && !releaseDate) {
      alert('Please enter a release date')
      return
    }

    if (newLeadership.some((m) => m.personId) && !sustainedDate) {
      alert('Please enter a sustained date')
      return
    }

    setProcessing('batch')
    try {
      const errors: string[] = []

      if (selectedMembers.size > 0) {
        const { error: releaseError } = await supabase
          .from('callings')
          .update({
            released_date: releaseDate,
            released_precision: 'exact',
          })
          .in('id', Array.from(selectedMembers))

        if (releaseError) errors.push(`Failed to release members: ${releaseError.message}`)
      }

      if (newLeadership.some((m) => m.personId)) {
        const org = organizations.find((o) => o.id === selectedOrgId)
        if (!org) {
          errors.push('Organization not found')
        } else {
          const positionMap: Record<string, string> = {}
          const { data: positions, error: positionsError } = await supabase
            .from('positions')
            .select('*')
            .in('position_type', ['president', 'counselor'])

          if (positionsError) {
            errors.push(`Failed to fetch positions: ${positionsError.message}`)
          } else if (!positions || positions.length === 0) {
            errors.push('No positions found. Please ensure president and counselor positions exist in the database.')
          } else {
            positions.forEach((p) => {
              if (p.position_type === 'president') {
                positionMap['president'] = p.id
              } else if (p.position_type === 'counselor') {
                positionMap['counselor'] = p.id
              }
            })

            if (!positionMap['president'] || !positionMap['counselor']) {
              errors.push('Missing required positions. Please ensure both president and counselor positions exist.')
            } else {
              const newCallingsToInsert = newLeadership
                .filter((m) => m.personId)
                .map((m) => ({
                  person_id: m.personId!,
                  organization_id: selectedOrgId,
                  position_id: positionMap[m.position === 'president' ? 'president' : 'counselor'],
                  presidency_number: nextPresidencyNumber,
                  sustained_date: sustainedDate,
                  sustained_precision: 'exact' as const,
                }))

              if (newCallingsToInsert.length > 0) {
                const { error: insertError } = await supabase
                  .from('callings')
                  .insert(newCallingsToInsert)

                if (insertError) {
                  errors.push(`Failed to create new callings: ${insertError.message}`)
                }
              }
            }
          }
        }
      }

      if (errors.length > 0) {
        alert(errors.join('\n'))
      } else {
        alert('Leadership transition saved successfully!')
        setSelectedMembers(new Set())
        setReleaseDate('')
        setSustainedDate('')
        setNewLeadership([
          { position: 'president', personId: null, personName: '' },
          { position: 'counselor1', personId: null, personName: '' },
          { position: 'counselor2', personId: null, personName: '' },
        ])
                  setSearchTerms({})
                  setShowBatchModal(false)
                  onActionComplete?.()
                  window.location.reload()
      }
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to save transition')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading...</div>
  }

  const getPresidencyLabel = () => {
    if (!selectedOrg) return ''
    if (isWard) return 'Bishopric'
    if (isBranch) return 'Presidency'
    return 'Presidency'
  }

  return (
    <div className="space-y-6">
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Organization
        </label>
        <select
          value={selectedOrgId}
          onChange={(e) => {
            setSelectedOrgId(e.target.value)
            setSelectedMembers(new Set())
            setReleaseDate('')
            setSustainedDate('')
            setNewLeadership([
              { position: 'president', personId: null, personName: '' },
              { position: 'counselor1', personId: null, personName: '' },
              { position: 'counselor2', personId: null, personName: '' },
            ])
            setSearchTerms({})
            setShowBatchModal(false)
            setShowReleaseModal(null)
            setShowAddCounselorModal(false)
            setShowAddNewModal(false)
            setReleaseDate('')
          }}
          className="w-full md:w-96 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
        >
          <option value="">-- Select an organization --</option>
          {filteredOrganizations.map((org) => (
            <option key={org.id} value={org.id}>
              {org.name}
            </option>
          ))}
        </select>
      </div>

      {selectedOrgId && (
        <div className="bg-white rounded-lg shadow-md border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-xl font-bold text-gray-900">
              {isPresidencyOrg
                ? `Current ${getPresidencyLabel()} (#${currentPresidency})`
                : 'Current'}
            </h2>
          </div>

          {isPresidencyOrg ? (
            currentPresidencyCallings.length > 0 ? (
              <>
                <div className="hidden md:block overflow-x-auto">
                  <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-50">
                      <tr>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Position
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Name
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Sustained
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Actions
                        </th>
                      </tr>
                    </thead>
                    <tbody className="bg-white divide-y divide-gray-200">
                      {currentPresidencyCallings.map((calling) => (
                        <tr key={calling.id} className="hover:bg-gray-50">
                          <td className="px-4 py-3 text-sm text-gray-900">
                            {calling.position?.title}
                          </td>
                          <td className="px-4 py-3 text-sm font-medium text-gray-900">
                            {calling.person?.display_name || calling.person?.full_name}
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">
                            {formatDate(
                              calling.sustained_date,
                              calling.sustained_precision
                            )}
                          </td>
                          <td className="px-4 py-3 text-sm">
                            <button
                              onClick={() => {
                                setShowReleaseModal(calling)
                                setReleaseDate(new Date().toISOString().split('T')[0])
                              }}
                              className="text-red-600 hover:text-red-700 hover:underline"
                            >
                              Release
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <div className="md:hidden space-y-3">
                  {currentPresidencyCallings.map((calling) => (
                    <div key={calling.id} className="p-4 border border-gray-200 rounded-lg">
                      <div className="mb-2">
                        <span className="text-sm font-medium text-gray-900">{calling.position?.title}</span>
                      </div>
                      <div className="mb-2">
                        <span className="text-base font-medium text-gray-900">
                          {calling.person?.display_name || calling.person?.full_name}
                        </span>
                      </div>
                      <div className="mb-3">
                        <span className="text-xs text-gray-500">Sustained: </span>
                        <span className="text-sm text-gray-900">
                          {formatDate(calling.sustained_date, calling.sustained_precision)}
                        </span>
                      </div>
                      <div>
                        <button
                          onClick={() => {
                            setShowReleaseModal(calling)
                            setReleaseDate(new Date().toISOString().split('T')[0])
                          }}
                          className="px-3 py-1 text-sm text-red-600 hover:text-red-700 hover:underline"
                        >
                          Release
                        </button>
                      </div>
                    </div>
                  ))}
                </div>

                <div className="mt-6 flex gap-4">
                  <button
                    onClick={() => {
                      setAddCounselorPosition('counselor1')
                      setAddCounselorPersonId(null)
                      setAddCounselorPersonName('')
                      setAddCounselorSearchTerm('')
                      setAddCounselorSustainedDate('')
                      setShowAddCounselorModal(true)
                    }}
                    className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700"
                  >
                    + Add Counselor
                  </button>
                  <button
                    onClick={() => {
                      setSelectedMembers(new Set())
                      setReleaseDate('')
                      setSustainedDate('')
                      setNewLeadership([
                        { position: 'president', personId: null, personName: '' },
                        { position: 'counselor1', personId: null, personName: '' },
                        { position: 'counselor2', personId: null, personName: '' },
                      ])
                      setSearchTerms({})
                      setShowBatchModal(true)
                    }}
                    className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                  >
                    Change Entire {getPresidencyLabel()}
                  </button>
                </div>
              </>
            ) : (
              <div className="text-gray-600 py-4">
                No current callings found for this organization.
              </div>
            )
          ) : (
            currentCallings.length > 0 ? (
              <>
                <div className="hidden md:block overflow-x-auto">
                  <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-50">
                      <tr>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          #
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Name
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Dates
                        </th>
                        <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                          Actions
                        </th>
                      </tr>
                    </thead>
                    <tbody className="bg-white divide-y divide-gray-200">
                      {currentCallings.map((calling) => (
                        <tr key={calling.id} className="hover:bg-gray-50">
                          <td className="px-4 py-3 text-sm text-gray-900">
                            #{calling.presidency_number || '-'}
                          </td>
                          <td className="px-4 py-3 text-sm font-medium text-gray-900">
                            {calling.person?.display_name || calling.person?.full_name}
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">
                            {formatDate(
                              calling.sustained_date,
                              calling.sustained_precision
                            )}{' '}
                            – present
                          </td>
                          <td className="px-4 py-3 text-sm">
                            <button
                              onClick={() => {
                                setShowReleaseModal(calling)
                                setReleaseDate(new Date().toISOString().split('T')[0])
                              }}
                              className="text-red-600 hover:text-red-700 hover:underline"
                            >
                              Release
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <div className="md:hidden space-y-3">
                  {currentCallings.map((calling) => (
                    <div key={calling.id} className="p-4 border border-gray-200 rounded-lg">
                      <div className="mb-2">
                        <span className="text-xs text-gray-500">#</span>
                        <span className="text-sm text-gray-900 ml-1">#{calling.presidency_number || '-'}</span>
                      </div>
                      <div className="mb-2">
                        <span className="text-base font-medium text-gray-900">
                          {calling.person?.display_name || calling.person?.full_name}
                        </span>
                      </div>
                      <div className="mb-3">
                        <span className="text-xs text-gray-500">Dates: </span>
                        <span className="text-sm text-gray-900">
                          {formatDate(calling.sustained_date, calling.sustained_precision)} – present
                        </span>
                      </div>
                      <div>
                        <button
                          onClick={() => {
                            setShowReleaseModal(calling)
                            setReleaseDate(new Date().toISOString().split('T')[0])
                          }}
                          className="px-3 py-1 text-sm text-red-600 hover:text-red-700 hover:underline"
                        >
                          Release
                        </button>
                      </div>
                    </div>
                  ))}
                </div>

                <div className="mt-6">
                  <button
                    onClick={() => {
                      setAddNewPersonId(null)
                      setAddNewPersonName('')
                      setAddNewSearchTerm('')
                      setAddNewSustainedDate('')
                      setAddNewPositionId(availablePositions.length === 1 ? availablePositions[0].id : '')
                      setShowAddNewModal(true)
                    }}
                    className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700"
                  >
                    + Add New
                  </button>
                </div>
              </>
            ) : (
              <div className="text-gray-600 py-4">
                No current callings found for this organization.
              </div>
            )
          )}
        </div>
      )}

      {showReleaseModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
            <h2 className="text-xl font-bold text-gray-900 mb-4">
              Release {showReleaseModal.person?.display_name || showReleaseModal.person?.full_name}
            </h2>
            <p className="text-gray-700 mb-4">
              Release {showReleaseModal.person?.display_name || showReleaseModal.person?.full_name} as{' '}
              {showReleaseModal.position?.title} from {selectedOrg?.name}?
            </p>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Release Date
              </label>
              <input
                type="date"
                value={releaseDate}
                onChange={(e) => setReleaseDate(e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
              />
            </div>
            <div className="flex gap-2 justify-end">
              <button
                onClick={() => {
                  setShowReleaseModal(null)
                  setReleaseDate('')
                }}
                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleRelease}
                disabled={processing === showReleaseModal.id || !releaseDate}
                className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50"
              >
                {processing === showReleaseModal.id ? 'Releasing...' : 'Confirm Release'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showAddCounselorModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6 max-h-[90vh] overflow-y-auto">
            <h2 className="text-xl font-bold text-gray-900 mb-4">Add Counselor</h2>

            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Position
              </label>
              <select
                value={addCounselorPosition}
                onChange={(e) =>
                  setAddCounselorPosition(e.target.value as 'counselor1' | 'counselor2' | 'president')
                }
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
              >
                <option value="counselor1">1st Counselor</option>
                <option value="counselor2">2nd Counselor</option>
                <option value="president">
                  {isWard ? 'Bishop' : isBranch ? 'Branch President' : 'President'}
                </option>
              </select>
              {addCounselorPosition === 'president' && (
                <p className="text-yellow-700 bg-yellow-50 border border-yellow-200 rounded p-2 mt-2 text-sm">
                  This will start a new {getPresidencyLabel()} #{getMaxPresidencyNumber() + 1}
                </p>
              )}
            </div>

            <div className="mb-4">
              <PersonSelector
                label="Person"
                value={addCounselorPersonName}
                searchTerm={addCounselorSearchTerm}
                onSearchChange={setAddCounselorSearchTerm}
                onPersonSelect={(person) => {
                  setAddCounselorPersonId(person?.id || null)
                  setAddCounselorPersonName(person ? person.display_name || person.full_name : '')
                }}
                onAddNew={() => setShowAddPersonModal('add-counselor')}
              />
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Sustained Date
              </label>
              <input
                type="date"
                value={addCounselorSustainedDate}
                onChange={(e) => setAddCounselorSustainedDate(e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
              />
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Presidency #
              </label>
              <div className="px-3 py-2 bg-gray-100 rounded text-gray-700">
                {addCounselorPosition === 'president'
                  ? `Will be assigned to ${getPresidencyLabel()} #${getMaxPresidencyNumber() + 1}`
                  : `Will be assigned to ${getPresidencyLabel()} #${currentPresidency}`}
              </div>
            </div>

            <div className="flex gap-2 justify-end">
              <button
                onClick={() => {
                  setShowAddCounselorModal(false)
                  setAddCounselorPersonId(null)
                  setAddCounselorPersonName('')
                  setAddCounselorSearchTerm('')
                  setAddCounselorSustainedDate('')
                }}
                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleAddCounselor}
                disabled={processing === 'add-counselor' || !addCounselorPersonId || !addCounselorSustainedDate}
                className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50"
              >
                {processing === 'add-counselor' ? 'Saving...' : 'Save'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showAddNewModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6 max-h-[90vh] overflow-y-auto">
            <h2 className="text-xl font-bold text-gray-900 mb-4">
              Add {availablePositions.find((p) => p.id === addNewPositionId)?.title || 'New Calling'}
            </h2>

            {availablePositions.length > 1 && (
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Position
                </label>
                <select
                  value={addNewPositionId}
                  onChange={(e) => setAddNewPositionId(e.target.value)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                >
                  <option value="">-- Select position --</option>
                  {availablePositions.map((pos) => (
                    <option key={pos.id} value={pos.id}>
                      {pos.title}
                    </option>
                  ))}
                </select>
              </div>
            )}

            {addNewPositionId && (
              <>
                <div className="mb-4">
                  <PersonSelector
                    label="Person"
                    value={addNewPersonName}
                    searchTerm={addNewSearchTerm}
                    onSearchChange={setAddNewSearchTerm}
                    onPersonSelect={(person) => {
                      setAddNewPersonId(person?.id || null)
                      setAddNewPersonName(person ? person.display_name || person.full_name : '')
                    }}
                    onAddNew={() => setShowAddPersonModal('add-new')}
                  />
                </div>

                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Sustained Date
                  </label>
                  <input
                    type="date"
                    value={addNewSustainedDate}
                    onChange={(e) => setAddNewSustainedDate(e.target.value)}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  />
                </div>

                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">#</label>
                  <div className="px-3 py-2 bg-gray-100 rounded text-gray-700">
                    Will be assigned #{getMaxPresidencyNumber() + 1}
                  </div>
                </div>
              </>
            )}

            <div className="flex gap-2 justify-end">
              <button
                onClick={() => {
                  setShowAddNewModal(false)
                  setAddNewPersonId(null)
                  setAddNewPersonName('')
                  setAddNewSearchTerm('')
                  setAddNewSustainedDate('')
                  setAddNewPositionId(availablePositions.length === 1 ? availablePositions[0].id : '')
                }}
                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleAddNew}
                disabled={processing === 'add-new' || !addNewPersonId || !addNewPositionId || !addNewSustainedDate}
                className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50"
              >
                {processing === 'add-new' ? 'Saving...' : 'Save'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showBatchModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full p-6 max-h-[90vh] overflow-y-auto">
            <h2 className="text-xl font-bold text-gray-900 mb-4">
              Change Entire {getPresidencyLabel()} (Presidency #{nextPresidencyNumber})
            </h2>

            {currentPresidencyCallings.length > 0 && (
              <div className="mb-6">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-semibold text-gray-900">
                    Current {getPresidencyLabel()} (Presidency #{currentPresidency})
                  </h3>
                  <button
                    onClick={handleSelectAll}
                    className="text-sm text-primary-600 hover:text-primary-700"
                  >
                    {selectedMembers.size === currentPresidencyCallings.length ? 'Deselect All' : 'Select All'}
                  </button>
                </div>

                <div className="space-y-2 mb-4">
                  {currentPresidencyCallings.map((calling) => (
                    <label
                      key={calling.id}
                      className="flex items-center gap-3 p-3 border border-gray-200 rounded hover:bg-gray-50 cursor-pointer"
                    >
                      <input
                        type="checkbox"
                        checked={selectedMembers.has(calling.id)}
                        onChange={() => handleMemberToggle(calling.id)}
                        className="w-4 h-4 text-primary-600 rounded focus:ring-primary-500"
                      />
                      <div className="flex-1">
                        <div className="font-medium text-gray-900">
                          {calling.person?.display_name || calling.person?.full_name}
                        </div>
                        <div className="text-sm text-gray-600">{calling.position?.title}</div>
                      </div>
                    </label>
                  ))}
                </div>

                {selectedMembers.size > 0 && (
                  <div className="mb-6">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Release Date (applies to all selected)
                    </label>
                    <input
                      type="date"
                      value={releaseDate}
                      onChange={(e) => handleReleaseDateChange(e.target.value)}
                      className="w-full md:w-64 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    />
                  </div>
                )}
              </div>
            )}

            <div className="mb-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">
                New {getPresidencyLabel()} (Presidency #{nextPresidencyNumber})
              </h3>

              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Sustained Date
                </label>
                <input
                  type="date"
                  value={sustainedDate}
                  onChange={(e) => setSustainedDate(e.target.value)}
                  className="w-full md:w-64 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                />
              </div>

              <div className="space-y-4">
                {newLeadership.map((member) => (
                  <PersonSelector
                    key={member.position}
                    label={positionLabels[member.position]}
                    value={member.personName}
                    searchTerm={searchTerms[member.position] || ''}
                    onSearchChange={(term) => handlePersonSearch(member.position, term)}
                    onPersonSelect={(person) => handlePersonSelect(member.position, person)}
                    onAddNew={() => setShowAddPersonModal(member.position)}
                  />
                ))}
              </div>
            </div>

            <div className="flex gap-2 justify-end">
              <button
                onClick={() => {
                  setShowBatchModal(false)
                  setSelectedMembers(new Set())
                  setReleaseDate('')
                  setSustainedDate('')
                  setNewLeadership([
                    { position: 'president', personId: null, personName: '' },
                    { position: 'counselor1', personId: null, personName: '' },
                    { position: 'counselor2', personId: null, personName: '' },
                  ])
                  setSearchTerms({})
                }}
                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleBatchSave}
                disabled={processing === 'batch'}
                className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50"
              >
                {processing === 'batch' ? 'Saving...' : 'Save All'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showAddPersonModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
            <h2 className="text-xl font-bold text-gray-900 mb-4">Add New Person</h2>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Full Name <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                value={newPersonName}
                onChange={(e) => setNewPersonName(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                placeholder="Enter full name"
                autoFocus
              />
            </div>
            <div className="flex gap-2 justify-end">
              <button
                onClick={() => {
                  setShowAddPersonModal(false)
                  setNewPersonName('')
                }}
                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleAddNewPerson}
                className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700"
              >
                Create
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

interface PersonSelectorProps {
  label: string
  value: string
  searchTerm: string
  onSearchChange: (term: string) => void
  onPersonSelect: (person: Person | null) => void
  onAddNew: () => void
}

function PersonSelector({
  label,
  value,
  searchTerm,
  onSearchChange,
  onPersonSelect,
  onAddNew,
}: PersonSelectorProps) {
  const { people, loading } = usePeopleSearch(searchTerm)
  const [showDropdown, setShowDropdown] = useState(false)

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      const target = event.target as HTMLElement
      if (!target.closest('.person-selector-container')) {
        setShowDropdown(false)
      }
    }

    if (showDropdown) {
      document.addEventListener('mousedown', handleClickOutside)
      return () => document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [showDropdown])

  return (
    <div className="relative person-selector-container">
      <label className="block text-sm font-medium text-gray-700 mb-2">{label}</label>
      <div className="relative">
        <input
          type="text"
          value={value || searchTerm}
          onChange={(e) => {
            onSearchChange(e.target.value)
            setShowDropdown(true)
            if (!e.target.value) {
              onPersonSelect(null)
            }
          }}
          onFocus={() => {
            if (searchTerm) setShowDropdown(true)
          }}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
          placeholder="Search for person..."
        />
        {value && (
          <button
            onClick={() => {
              onPersonSelect(null)
              onSearchChange('')
            }}
            className="absolute right-2 top-2 text-gray-400 hover:text-gray-600"
          >
            ✕
          </button>
        )}
        {showDropdown && searchTerm && searchTerm.length >= 2 && (
          <div className="absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-auto">
            {loading ? (
              <div className="px-4 py-2 text-gray-500">Searching...</div>
            ) : people.length === 0 ? (
              <div className="px-4 py-2">
                <div className="text-gray-500 mb-2">No results found</div>
                <button
                  onClick={() => {
                    setShowDropdown(false)
                    onAddNew()
                  }}
                  className="text-primary-600 hover:text-primary-700 text-sm font-medium"
                >
                  + Add new person
                </button>
              </div>
            ) : (
              <>
                {people.map((person) => (
                  <button
                    key={person.id}
                    onClick={() => {
                      onPersonSelect(person)
                      setShowDropdown(false)
                      onSearchChange('')
                    }}
                    className="w-full text-left px-4 py-2 hover:bg-gray-100 border-b border-gray-100 last:border-0"
                  >
                    <div className="font-medium text-gray-900">
                      {person.display_name || person.full_name}
                    </div>
                    {person.display_name && person.full_name !== person.display_name && (
                      <div className="text-sm text-gray-500">{person.full_name}</div>
                    )}
                  </button>
                ))}
                <div className="border-t border-gray-200 px-4 py-2">
                  <button
                    onClick={() => {
                      setShowDropdown(false)
                      onAddNew()
                    }}
                    className="text-primary-600 hover:text-primary-700 text-sm font-medium"
                  >
                    + Add new person
                  </button>
                </div>
              </>
            )}
          </div>
        )}
      </div>
    </div>
  )
}
