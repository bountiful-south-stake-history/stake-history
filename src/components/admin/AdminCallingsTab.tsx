import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { useOrganizationCallings } from '../../hooks/useOrganizationCallings'
import { useOrganizations } from '../../hooks/useOrganizations'
import { useAuth } from '../../hooks/useAuth'

interface AdminCallingsTabProps {
  onActionComplete?: () => void
}

export function AdminCallingsTab({ onActionComplete }: AdminCallingsTabProps) {
  const { organizations, loading: orgsLoading } = useOrganizations()
  const { user } = useAuth()
  const [selectedOrgId, setSelectedOrgId] = useState<string>('')
  const { callings, loading: callingsLoading } = useOrganizationCallings(selectedOrgId)
  const [editingId, setEditingId] = useState<string | null>(null)
  const [processing, setProcessing] = useState<string | null>(null)
  const [deleteConfirmState, setDeleteConfirmState] = useState<Record<string, 'none' | 'warning' | 'modal'>>({})
  const [deleteConfirmText, setDeleteConfirmText] = useState<Record<string, string>>({})
  const [showPresidencyModal, setShowPresidencyModal] = useState<string | null>(null)
  const [presidencyNewValue, setPresidencyNewValue] = useState('')
  const [presidencyConfirmValue, setPresidencyConfirmValue] = useState('')
  
  const [editData, setEditData] = useState({
    sustained_date: '',
    released_date: '',
    presidency_number: '',
    notes: '',
  })

  const filteredOrganizations = organizations.filter(
    (org) => org.name !== 'Bountiful Utah South Stake'
  )

  const loading = orgsLoading || callingsLoading

  const startEdit = (calling: typeof callings[0]) => {
    setEditingId(calling.id)
    setEditData({
      sustained_date: calling.sustained_date || '',
      released_date: calling.released_date || '',
      presidency_number: calling.presidency_number?.toString() || '',
      notes: calling.notes || '',
    })
  }

  const cancelEdit = () => {
    setEditingId(null)
    setEditData({
      sustained_date: '',
      released_date: '',
      presidency_number: '',
      notes: '',
    })
  }

  const handleSave = async (callingId: string) => {
    setProcessing(callingId)
    try {
      const updateData: any = {}
      
      if (editData.sustained_date) updateData.sustained_date = editData.sustained_date
      if (editData.released_date) updateData.released_date = editData.released_date || null
      // Presidency number is NOT updated here - it's protected
      if (editData.notes !== undefined) updateData.notes = editData.notes.trim() || null

      const { error: updateError } = await supabase
        .from('callings')
        .update(updateData)
        .eq('id', callingId)

      if (updateError) throw updateError
      
      setEditingId(null)
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update calling')
    } finally {
      setProcessing(null)
    }
  }

  const handleDeleteClick = (callingId: string) => {
    const currentState = deleteConfirmState[callingId] || 'none'
    if (currentState === 'none') {
      setDeleteConfirmState({ ...deleteConfirmState, [callingId]: 'warning' })
    } else if (currentState === 'warning') {
      setDeleteConfirmState({ ...deleteConfirmState, [callingId]: 'modal' })
      setDeleteConfirmText({ ...deleteConfirmText, [callingId]: '' })
    }
  }

  const handleDeleteCancel = (callingId: string) => {
    setDeleteConfirmState({ ...deleteConfirmState, [callingId]: 'none' })
    setDeleteConfirmText({ ...deleteConfirmText, [callingId]: '' })
  }

  const handleDeleteConfirm = async (callingId: string) => {
    const calling = callings.find((c) => c.id === callingId)
    if (!calling) return

    setProcessing(callingId)
    try {
      const oldValues = {
        person_id: calling.person_id,
        position_id: calling.position_id,
        organization_id: calling.organization_id,
        presidency_number: calling.presidency_number,
        sustained_date: calling.sustained_date,
        released_date: calling.released_date,
        notes: calling.notes,
      }

      const { error: deleteError } = await supabase
        .from('callings')
        .delete()
        .eq('id', callingId)

      if (deleteError) throw deleteError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: callingId,
          action: 'delete_calling',
          old_values: oldValues,
          new_values: null,
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }
      
      setDeleteConfirmState({ ...deleteConfirmState, [callingId]: 'none' })
      setDeleteConfirmText({ ...deleteConfirmText, [callingId]: '' })
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to delete calling')
    } finally {
      setProcessing(null)
    }
  }

  const handlePresidencyNumberChange = async (callingId: string) => {
    const calling = callings.find((c) => c.id === callingId)
    if (!calling) return

    if (presidencyNewValue !== presidencyConfirmValue) {
      alert('Presidency numbers do not match. Please type the same number twice.')
      return
    }

    const newNumber = parseInt(presidencyNewValue)
    if (isNaN(newNumber)) {
      alert('Please enter a valid number')
      return
    }

    setProcessing(callingId)
    try {
      const oldValues = {
        presidency_number: calling.presidency_number,
      }

      const { error: updateError } = await supabase
        .from('callings')
        .update({ presidency_number: newNumber })
        .eq('id', callingId)

      if (updateError) throw updateError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: callingId,
          action: 'change_presidency_number',
          old_values: oldValues,
          new_values: { presidency_number: newNumber },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowPresidencyModal(null)
      setPresidencyNewValue('')
      setPresidencyConfirmValue('')
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update presidency number')
    } finally {
      setProcessing(null)
    }
  }


  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading...</div>
  }

  return (
    <div>
      <div className="mb-4">
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Select Organization
        </label>
        <select
          value={selectedOrgId}
          onChange={(e) => {
            setSelectedOrgId(e.target.value)
            setDeleteConfirmState({})
            setDeleteConfirmText({})
            setShowPresidencyModal(null)
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

      {selectedOrgId && callings.length > 0 && (
        <div className="bg-white rounded-lg shadow-md border border-gray-200 overflow-hidden">
          <div className="hidden md:block overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Person</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Position</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Sustained</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Released</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Presidency #</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {callings.map((calling) => {
                  const isEditing = editingId === calling.id
                  return (
                    <tr key={calling.id} className="hover:bg-gray-50">
                      {isEditing ? (
                        <>
                          <td className="px-4 py-3 text-sm text-gray-900">
                            <Link
                              to={`/person/${calling.person_id}`}
                              className="text-primary-600 hover:text-primary-700 hover:underline"
                            >
                              {calling.person?.display_name || calling.person?.full_name}
                            </Link>
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">{calling.position?.title}</td>
                          <td className="px-4 py-3">
                            <input
                              type="date"
                              value={editData.sustained_date}
                              onChange={(e) => setEditData({ ...editData, sustained_date: e.target.value })}
                              className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                            />
                          </td>
                          <td className="px-4 py-3">
                            <input
                              type="date"
                              value={editData.released_date}
                              onChange={(e) => setEditData({ ...editData, released_date: e.target.value })}
                              className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                            />
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-2">
                              <span className="text-sm text-gray-500 px-2 py-1 bg-gray-100 rounded">
                                {calling.presidency_number || '-'}
                              </span>
                              <button
                                onClick={() => {
                                  setShowPresidencyModal(calling.id)
                                  setPresidencyNewValue(calling.presidency_number?.toString() || '')
                                  setPresidencyConfirmValue('')
                                }}
                                className="px-2 py-1 text-xs border border-gray-300 rounded hover:bg-gray-50 text-gray-600"
                              >
                                Fix #
                              </button>
                            </div>
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex gap-2">
                              <button
                                onClick={() => handleSave(calling.id)}
                                disabled={processing === calling.id}
                                className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                              >
                                Save
                              </button>
                              <button
                                onClick={cancelEdit}
                                className="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm"
                              >
                                Cancel
                              </button>
                            </div>
                          </td>
                        </>
                      ) : (
                        <>
                          <td className="px-4 py-3 text-sm text-gray-900">
                            <Link
                              to={`/person/${calling.person_id}`}
                              className="text-primary-600 hover:text-primary-700 hover:underline"
                            >
                              {calling.person?.display_name || calling.person?.full_name}
                            </Link>
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">{calling.position?.title}</td>
                          <td className="px-4 py-3 text-sm text-gray-600">
                            {calling.sustained_date ? new Date(calling.sustained_date).toLocaleDateString() : '-'}
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">
                            {calling.released_date ? new Date(calling.released_date).toLocaleDateString() : 'Current'}
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-600">{calling.presidency_number || '-'}</td>
                          <td className="px-4 py-3">
                            <div className="flex gap-2">
                              <button
                                onClick={() => startEdit(calling)}
                                className="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm"
                              >
                                Edit
                              </button>
                              <button
                                onClick={() => handleDeleteClick(calling.id)}
                                disabled={processing === calling.id}
                                className={`px-3 py-1 rounded text-sm border disabled:opacity-50 ${
                                  deleteConfirmState[calling.id] === 'warning'
                                    ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100'
                                    : 'border-red-300 text-red-700 hover:bg-red-50'
                                }`}
                              >
                                {deleteConfirmState[calling.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                              </button>
                            </div>
                          </td>
                        </>
                      )}
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>

          <div className="md:hidden divide-y divide-gray-200">
            {callings.map((calling) => {
              const isEditing = editingId === calling.id
              return (
                <div key={calling.id} className="p-4">
                  {isEditing ? (
                    <>
                      <div className="mb-3">
                        <label className="text-xs text-gray-500 uppercase">Person</label>
                        <div className="mt-1">
                          <Link
                            to={`/person/${calling.person_id}`}
                            className="text-sm text-primary-600 hover:text-primary-700 hover:underline"
                          >
                            {calling.person?.display_name || calling.person?.full_name}
                          </Link>
                        </div>
                      </div>
                      <div className="mb-3">
                        <label className="text-xs text-gray-500 uppercase">Position</label>
                        <div className="mt-1 text-sm text-gray-900">{calling.position?.title}</div>
                      </div>
                      <div className="mb-3">
                        <label className="text-xs text-gray-500 uppercase">Sustained</label>
                        <input
                          type="date"
                          value={editData.sustained_date}
                          onChange={(e) => setEditData({ ...editData, sustained_date: e.target.value })}
                          className="w-full mt-1 px-3 py-2 border border-gray-300 rounded text-sm"
                        />
                      </div>
                      <div className="mb-3">
                        <label className="text-xs text-gray-500 uppercase">Released</label>
                        <input
                          type="date"
                          value={editData.released_date}
                          onChange={(e) => setEditData({ ...editData, released_date: e.target.value })}
                          className="w-full mt-1 px-3 py-2 border border-gray-300 rounded text-sm"
                        />
                      </div>
                      <div className="mb-3">
                        <label className="text-xs text-gray-500 uppercase">Presidency #</label>
                        <div className="mt-1 flex items-center gap-2">
                          <span className="text-sm text-gray-900 px-2 py-1 bg-gray-100 rounded">
                            {calling.presidency_number || '-'}
                          </span>
                          <button
                            onClick={() => {
                              setShowPresidencyModal(calling.id)
                              setPresidencyNewValue(calling.presidency_number?.toString() || '')
                              setPresidencyConfirmValue('')
                            }}
                            className="px-2 py-1 text-xs border border-gray-300 rounded hover:bg-gray-50 text-gray-600"
                          >
                            Fix #
                          </button>
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleSave(calling.id)}
                          disabled={processing === calling.id}
                          className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                        >
                          Save
                        </button>
                        <button
                          onClick={cancelEdit}
                          className="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm"
                        >
                          Cancel
                        </button>
                      </div>
                    </>
                  ) : (
                    <>
                      <div className="mb-2">
                        <Link
                          to={`/person/${calling.person_id}`}
                          className="text-base font-medium text-primary-600 hover:text-primary-700 hover:underline"
                        >
                          {calling.person?.display_name || calling.person?.full_name}
                        </Link>
                      </div>
                      <div className="mb-2">
                        <span className="text-xs text-gray-500">Position: </span>
                        <span className="text-sm text-gray-900">{calling.position?.title}</span>
                      </div>
                      <div className="mb-2">
                        <span className="text-xs text-gray-500">Sustained: </span>
                        <span className="text-sm text-gray-900">
                          {calling.sustained_date ? new Date(calling.sustained_date).toLocaleDateString() : '-'}
                        </span>
                      </div>
                      <div className="mb-2">
                        <span className="text-xs text-gray-500">Released: </span>
                        <span className="text-sm text-gray-900">
                          {calling.released_date ? new Date(calling.released_date).toLocaleDateString() : 'Current'}
                        </span>
                      </div>
                      <div className="mb-3">
                        <span className="text-xs text-gray-500">Presidency #: </span>
                        <span className="text-sm text-gray-900">{calling.presidency_number || '-'}</span>
                      </div>
                      <div className="flex gap-2 flex-wrap">
                        <button
                          onClick={() => startEdit(calling)}
                          className="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDeleteClick(calling.id)}
                          disabled={processing === calling.id}
                          className={`px-3 py-1 rounded text-sm border disabled:opacity-50 ${
                            deleteConfirmState[calling.id] === 'warning'
                              ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100'
                              : 'border-red-300 text-red-700 hover:bg-red-50'
                          }`}
                        >
                          {deleteConfirmState[calling.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                        </button>
                      </div>
                    </>
                  )}
                </div>
              )
            })}
          </div>
        </div>
      )}

      {selectedOrgId && callings.length === 0 && (
        <div className="text-center py-8 text-gray-600">No callings found for this organization</div>
      )}

      {callings.map((calling) => {
        const deleteState = deleteConfirmState[calling.id]
        if (deleteState === 'modal') {
          return (
            <div
              key={`delete-modal-${calling.id}`}
              className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
            >
              <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
                <h2 className="text-xl font-bold text-red-700 mb-4">PERMANENT DELETION</h2>
                <p className="text-gray-700 mb-4">
                  This will permanently delete{' '}
                  <strong>
                    {calling.person?.display_name || calling.person?.full_name}'s {calling.position?.title}
                  </strong>{' '}
                  calling record from <strong>{calling.organization?.name}</strong>. This cannot be undone.
                </p>
                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Type <strong>DELETE</strong> to confirm:
                  </label>
                  <input
                    type="text"
                    value={deleteConfirmText[calling.id] || ''}
                    onChange={(e) =>
                      setDeleteConfirmText({ ...deleteConfirmText, [calling.id]: e.target.value })
                    }
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                    placeholder="DELETE"
                    autoFocus
                  />
                </div>
                <div className="flex gap-2 justify-end">
                  <button
                    onClick={() => handleDeleteCancel(calling.id)}
                    className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={() => handleDeleteConfirm(calling.id)}
                    disabled={
                      processing === calling.id ||
                      (deleteConfirmText[calling.id] || '').toUpperCase() !== 'DELETE'
                    }
                    className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    Delete
                  </button>
                </div>
              </div>
            </div>
          )
        }
        return null
      })}

      {showPresidencyModal && (() => {
        const calling = callings.find((c) => c.id === showPresidencyModal)
        if (!calling) return null
        return (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
              <h2 className="text-xl font-bold text-gray-900 mb-4">Fix Presidency Number</h2>
              <p className="text-yellow-700 bg-yellow-50 border border-yellow-200 rounded p-3 mb-4">
                Changing presidency numbers affects historical ordering. Only change if the number was entered incorrectly.
              </p>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">Current Value:</label>
                <div className="px-3 py-2 bg-gray-100 rounded text-gray-700">
                  {calling.presidency_number || 'None'}
                </div>
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  New Presidency Number:
                </label>
                <input
                  type="number"
                  value={presidencyNewValue}
                  onChange={(e) => setPresidencyNewValue(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  placeholder="Enter new number"
                />
              </div>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Confirm New Number:
                </label>
                <input
                  type="number"
                  value={presidencyConfirmValue}
                  onChange={(e) => setPresidencyConfirmValue(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  placeholder="Type number again to confirm"
                />
              </div>
              <div className="flex gap-2 justify-end">
                <button
                  onClick={() => {
                    setShowPresidencyModal(null)
                    setPresidencyNewValue('')
                    setPresidencyConfirmValue('')
                  }}
                  className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handlePresidencyNumberChange(showPresidencyModal)}
                  disabled={
                    processing === showPresidencyModal ||
                    !presidencyNewValue ||
                    presidencyNewValue !== presidencyConfirmValue
                  }
                  className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Save Changes
                </button>
              </div>
            </div>
          </div>
        )
      })()}
    </div>
  )
}

