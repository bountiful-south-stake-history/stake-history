import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePendingMemories } from '../../hooks/usePendingMemories'
import { useApprovedMemories } from '../../hooks/useApprovedMemories'
import { useAuth } from '../../hooks/useAuth'

const relationshipLabels: Record<string, string> = {
  family: 'Family Member',
  friend: 'Friend',
  served_together: 'Served Together',
  ward_member: 'Ward Member',
  other: 'Other',
}

const relationshipOptions = [
  { value: 'family', label: 'Family Member' },
  { value: 'friend', label: 'Friend' },
  { value: 'served_together', label: 'Served Together' },
  { value: 'ward_member', label: 'Ward Member' },
  { value: 'other', label: 'Other' },
]

interface AdminMemoriesTabProps {
  onActionComplete?: () => void
}

export function AdminMemoriesTab({ onActionComplete }: AdminMemoriesTabProps) {
  const { user } = useAuth()
  const [viewMode, setViewMode] = useState<'pending' | 'approved'>('pending')
  const { memories: pendingMemories, loading: pendingLoading, error: pendingError, refetch: refetchPending } = usePendingMemories()
  const { memories: approvedMemories, loading: approvedLoading, error: approvedError, refetch: refetchApproved } = useApprovedMemories()
  const [processing, setProcessing] = useState<string | null>(null)
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editContent, setEditContent] = useState('')
  const [editRelationship, setEditRelationship] = useState('')
  const [editTimePeriod, setEditTimePeriod] = useState('')
  const [editSubmitterName, setEditSubmitterName] = useState('')
  const [editSubmitterEmail, setEditSubmitterEmail] = useState('')
  const [expandedId, setExpandedId] = useState<string | null>(null)
  const [deleteConfirmState, setDeleteConfirmState] = useState<Record<string, 'none' | 'warning' | 'modal'>>({})
  const [deleteConfirmText, setDeleteConfirmText] = useState<Record<string, string>>({})

  const memories = viewMode === 'pending' ? pendingMemories : approvedMemories
  const loading = viewMode === 'pending' ? pendingLoading : approvedLoading
  const error = viewMode === 'pending' ? pendingError : approvedError
  
  const refetch = () => {
    if (viewMode === 'pending') {
      refetchPending()
    } else {
      refetchApproved()
    }
  }

  const handleApprove = async (memoryId: string) => {
    setProcessing(memoryId)
    try {
      const { error: updateError } = await supabase
        .from('memories')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', memoryId)

      if (updateError) throw updateError
      setEditingId(null)
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to approve memory')
    } finally {
      setProcessing(null)
    }
  }

  const handleReject = async (memoryId: string) => {
    setProcessing(memoryId)
    try {
      const { error: updateError } = await supabase
        .from('memories')
        .update({
          status: 'rejected',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', memoryId)
      
      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to reject memory')
    } finally {
      setProcessing(null)
    }
  }

  const handleDeleteClick = (memoryId: string) => {
    const currentState = deleteConfirmState[memoryId] || 'none'
    if (currentState === 'none') {
      setDeleteConfirmState({ ...deleteConfirmState, [memoryId]: 'warning' })
    } else if (currentState === 'warning') {
      setDeleteConfirmState({ ...deleteConfirmState, [memoryId]: 'modal' })
      setDeleteConfirmText({ ...deleteConfirmText, [memoryId]: '' })
    }
  }

  const handleDeleteCancel = (memoryId: string) => {
    setDeleteConfirmState({ ...deleteConfirmState, [memoryId]: 'none' })
    setDeleteConfirmText({ ...deleteConfirmText, [memoryId]: '' })
  }

  const handleDeleteConfirm = async (memoryId: string) => {
    const memory = memories.find((m) => m.id === memoryId)
    if (!memory) return

    setProcessing(memoryId)
    try {
      const { error: deleteError } = await supabase
        .from('memories')
        .delete()
        .eq('id', memoryId)

      if (deleteError) throw deleteError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'memories',
          record_id: memoryId,
          action: 'delete_memory',
          old_values: {
            content: memory.content,
            relationship: memory.relationship,
            time_period: memory.time_period,
          },
          new_values: null,
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setDeleteConfirmState({ ...deleteConfirmState, [memoryId]: 'none' })
      setDeleteConfirmText({ ...deleteConfirmText, [memoryId]: '' })
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to delete memory')
    } finally {
      setProcessing(null)
    }
  }

  const handleSaveEdit = async () => {
    if (!editingId) return

    setProcessing(editingId)
    try {
      const { error: updateError } = await supabase
        .from('memories')
        .update({
          content: editContent,
          relationship: editRelationship || null,
          time_period: editTimePeriod || null,
          submitter_name: editSubmitterName,
          submitter_email: editSubmitterEmail,
        })
        .eq('id', editingId)

      if (updateError) throw updateError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'memories',
          record_id: editingId,
          action: 'edit_memory',
          old_values: null,
          new_values: {
            content: editContent,
            relationship: editRelationship,
            time_period: editTimePeriod,
            submitter_name: editSubmitterName,
            submitter_email: editSubmitterEmail,
          },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setEditingId(null)
      setEditContent('')
      setEditRelationship('')
      setEditTimePeriod('')
      setEditSubmitterName('')
      setEditSubmitterEmail('')
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to save changes')
    } finally {
      setProcessing(null)
    }
  }

  const startEdit = (memory: typeof memories[0]) => {
    setEditingId(memory.id)
    setEditContent(memory.content)
    setEditRelationship(memory.relationship || '')
    setEditTimePeriod(memory.time_period || '')
    setEditSubmitterName(memory.submitter_name || '')
    setEditSubmitterEmail(memory.submitter_email || '')
  }

  const cancelEdit = () => {
    setEditingId(null)
    setEditContent('')
    setEditRelationship('')
    setEditTimePeriod('')
    setEditSubmitterName('')
    setEditSubmitterEmail('')
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading memories...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  return (
    <div>
      <div className="mb-4 flex gap-2 border-b border-gray-200">
        <button
          onClick={() => setViewMode('pending')}
          className={`px-4 py-2 font-medium border-b-2 transition-colors ${
            viewMode === 'pending'
              ? 'border-primary-600 text-primary-700'
              : 'border-transparent text-gray-500 hover:text-gray-700'
          }`}
        >
          Pending ({pendingMemories.length})
        </button>
        <button
          onClick={() => setViewMode('approved')}
          className={`px-4 py-2 font-medium border-b-2 transition-colors ${
            viewMode === 'approved'
              ? 'border-primary-600 text-primary-700'
              : 'border-transparent text-gray-500 hover:text-gray-700'
          }`}
        >
          Approved ({approvedMemories.length})
        </button>
      </div>

      {memories.length === 0 && (
        <div className="text-center py-8 text-gray-600">
          No {viewMode} memories
        </div>
      )}

      {memories.length > 0 && (
        <div className="grid gap-4">
      {memories.map((memory) => {
        const isExpanded = expandedId === memory.id
        const isEditing = editingId === memory.id
        const truncated = memory.content.length > 200 ? memory.content.substring(0, 200) + '...' : memory.content

        return (
          <div key={memory.id} className="bg-white border border-gray-200 rounded-lg p-6">
            <div className="mb-4">
              <h3 className="font-semibold text-gray-900 mb-2">
                Memory for:{' '}
                {memory.person_id ? (
                  <Link
                    to={`/person/${memory.person_id}`}
                    className="text-primary-600 hover:text-primary-700 hover:underline"
                  >
                    {memory.person_name || 'Unknown Person'}
                  </Link>
                ) : (
                  'Unknown Person'
                )}
              </h3>
              <div className="text-xs text-gray-500 space-y-1">
                {memory.relationship && (
                  <div>
                    <span className="text-gray-400">Relationship:</span> {relationshipLabels[memory.relationship] || memory.relationship}
                  </div>
                )}
                {memory.time_period && (
                  <div>
                    <span className="text-gray-400">Time Period:</span> {memory.time_period}
                  </div>
                )}
                <div>
                  <span className="text-gray-400">Submitted by:</span> {memory.submitter_name}
                  {memory.submitter_email && ` (${memory.submitter_email})`}
                </div>
              </div>
            </div>

            <div className="border-t border-gray-200 pt-4 mb-4">
              {isEditing ? (
                <div className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Memory/Story <span className="text-red-500">*</span>
                    </label>
                    <textarea
                      value={editContent}
                      onChange={(e) => setEditContent(e.target.value)}
                      rows={8}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === memory.id}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Relationship <span className="text-gray-400 text-xs">(optional)</span>
                    </label>
                    <select
                      value={editRelationship}
                      onChange={(e) => setEditRelationship(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === memory.id}
                    >
                      <option value="">Select relationship...</option>
                      {relationshipOptions.map(opt => (
                        <option key={opt.value} value={opt.value}>{opt.label}</option>
                      ))}
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Time Period <span className="text-gray-400 text-xs">(optional)</span>
                    </label>
                    <input
                      type="text"
                      value={editTimePeriod}
                      onChange={(e) => setEditTimePeriod(e.target.value)}
                      placeholder="e.g., When he was bishop 1985-1990"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === memory.id}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Submitter Name
                    </label>
                    <input
                      type="text"
                      value={editSubmitterName}
                      onChange={(e) => setEditSubmitterName(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === memory.id}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Submitter Email
                    </label>
                    <input
                      type="email"
                      value={editSubmitterEmail}
                      onChange={(e) => setEditSubmitterEmail(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === memory.id}
                    />
                  </div>
                  <div className="flex gap-2">
                    {viewMode === 'pending' ? (
                      <button
                        onClick={async () => {
                          await handleSaveEdit()
                          if (editingId) {
                            await handleApprove(editingId)
                          }
                        }}
                        disabled={processing === memory.id || !editContent.trim()}
                        className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                        Save & Approve
                      </button>
                    ) : (
                      <button
                        onClick={handleSaveEdit}
                        disabled={processing === memory.id || !editContent.trim()}
                        className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                        Save Changes
                      </button>
                    )}
                    <button
                      onClick={cancelEdit}
                      disabled={processing === memory.id}
                      className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50 disabled:opacity-50"
                    >
                      Cancel
                    </button>
                  </div>
                </div>
              ) : (
                <div>
                  <p className="text-gray-700 whitespace-pre-wrap">{isExpanded ? memory.content : truncated}</p>
                  {memory.content.length > 200 && (
                    <button
                      onClick={() => setExpandedId(isExpanded ? null : memory.id)}
                      className="mt-2 text-primary-600 hover:text-primary-700 text-sm"
                    >
                      {isExpanded ? 'Show less' : 'Read more'}
                    </button>
                  )}
                </div>
              )}
            </div>

            {!isEditing && (
              <div className="flex gap-2">
                {viewMode === 'pending' ? (
                  <>
                    <button
                      onClick={() => handleApprove(memory.id)}
                      disabled={processing === memory.id}
                      className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50"
                    >
                      Approve
                    </button>
                    <button
                      onClick={() => startEdit(memory)}
                      disabled={processing === memory.id}
                      className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
                    >
                      Edit
                    </button>
                    <button
                      onClick={() => handleReject(memory.id)}
                      disabled={processing === memory.id}
                      className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50"
                    >
                      Reject
                    </button>
                  </>
                ) : (
                  <>
                    <button
                      onClick={() => startEdit(memory)}
                      disabled={processing === memory.id}
                      className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
                    >
                      Edit
                    </button>
                    <button
                      onClick={() => handleDeleteClick(memory.id)}
                      disabled={processing === memory.id}
                      className={`px-4 py-2 rounded disabled:opacity-50 ${
                        deleteConfirmState[memory.id] === 'warning'
                          ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100 border-2'
                          : 'border-red-300 text-red-700 hover:bg-red-50 border-2'
                      }`}
                    >
                      {deleteConfirmState[memory.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                    </button>
                  </>
                )}
              </div>
            )}
          </div>
        )
      })}
        </div>
      )}

      {memories.map((memory) => {
        const deleteState = deleteConfirmState[memory.id]
        if (deleteState === 'modal') {
          return (
            <div
              key={`delete-modal-${memory.id}`}
              className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
            >
              <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
                <h2 className="text-xl font-bold text-red-700 mb-4 flex items-center gap-2">
                  <span>⚠️</span> Delete Memory
                </h2>
                <p className="text-gray-700 mb-4">
                  This action CANNOT be undone.
                </p>
                <p className="text-gray-700 mb-4">
                  The memory and all associated data will be permanently deleted.
                </p>
                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Type <strong>DELETE</strong> to confirm:
                  </label>
                  <input
                    type="text"
                    value={deleteConfirmText[memory.id] || ''}
                    onChange={(e) =>
                      setDeleteConfirmText({ ...deleteConfirmText, [memory.id]: e.target.value })
                    }
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                    placeholder="DELETE"
                    autoFocus
                  />
                </div>
                <div className="flex gap-2 justify-end">
                  <button
                    onClick={() => handleDeleteCancel(memory.id)}
                    className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={() => handleDeleteConfirm(memory.id)}
                    disabled={
                      processing === memory.id ||
                      (deleteConfirmText[memory.id] || '').toUpperCase() !== 'DELETE'
                    }
                    className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    Delete Forever
                  </button>
                </div>
              </div>
            </div>
          )
        }
        return null
      })}
    </div>
  )
}

