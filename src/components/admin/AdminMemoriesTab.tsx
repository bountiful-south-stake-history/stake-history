import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePendingMemories } from '../../hooks/usePendingMemories'
import { useApprovedMemories } from '../../hooks/useApprovedMemories'

const relationshipLabels: Record<string, string> = {
  family: 'Family Member',
  friend: 'Friend',
  served_together: 'Served Together',
  ward_member: 'Ward Member',
  other: 'Other',
}

interface AdminMemoriesTabProps {
  onActionComplete?: () => void
}

export function AdminMemoriesTab({ onActionComplete }: AdminMemoriesTabProps) {
  const [viewMode, setViewMode] = useState<'pending' | 'approved'>('pending')
  const { memories: pendingMemories, loading: pendingLoading, error: pendingError, refetch: refetchPending } = usePendingMemories()
  const { memories: approvedMemories, loading: approvedLoading, error: approvedError, refetch: refetchApproved } = useApprovedMemories()
  const [processing, setProcessing] = useState<string | null>(null)
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editContent, setEditContent] = useState('')
  const [expandedId, setExpandedId] = useState<string | null>(null)

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

  const handleApprove = async (memoryId: string, content?: string) => {
    setProcessing(memoryId)
    try {
      const { error: updateError } = await supabase
        .from('memories')
        .update({
          status: 'approved',
          content: content || undefined,
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

  const handleDelete = async (memoryId: string) => {
    if (!confirm('Are you sure you want to delete this memory? This action cannot be undone.')) {
      return
    }

    setProcessing(memoryId)
    try {
      const { error: deleteError } = await supabase
        .from('memories')
        .delete()
        .eq('id', memoryId)

      if (deleteError) throw deleteError
      
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to delete memory')
    } finally {
      setProcessing(null)
    }
  }

  const handleUpdate = async (memoryId: string, content: string) => {
    setProcessing(memoryId)
    try {
      const { error: updateError } = await supabase
        .from('memories')
        .update({
          content: content,
        })
        .eq('id', memoryId)

      if (updateError) throw updateError
      
      setEditingId(null)
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update memory')
    } finally {
      setProcessing(null)
    }
  }

  const startEdit = (memory: typeof memories[0]) => {
    setEditingId(memory.id)
    setEditContent(memory.content)
  }

  const cancelEdit = () => {
    setEditingId(null)
    setEditContent('')
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
              <div className="text-sm text-gray-600 space-y-1">
                <div>
                  Submitted by: {memory.submitter_name}
                  {memory.submitter_email && ` (${memory.submitter_email})`}
                </div>
                {memory.relationship && (
                  <div>Relationship: {relationshipLabels[memory.relationship] || memory.relationship}</div>
                )}
                {memory.time_period && <div>Time Period: {memory.time_period}</div>}
              </div>
            </div>

            <div className="border-t border-gray-200 pt-4 mb-4">
              {isEditing ? (
                <div>
                  <textarea
                    value={editContent}
                    onChange={(e) => setEditContent(e.target.value)}
                    rows={8}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  />
                  <div className="flex gap-2 mt-2">
                    {viewMode === 'pending' ? (
                      <button
                        onClick={() => handleApprove(memory.id, editContent)}
                        disabled={processing === memory.id}
                        className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                      >
                        Save & Approve
                      </button>
                    ) : (
                      <button
                        onClick={() => handleUpdate(memory.id, editContent)}
                        disabled={processing === memory.id}
                        className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                      >
                        Save Changes
                      </button>
                    )}
                    <button
                      onClick={cancelEdit}
                      className="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm"
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
                      onClick={() => handleDelete(memory.id)}
                      disabled={processing === memory.id}
                      className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50"
                    >
                      Delete
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
    </div>
  )
}

