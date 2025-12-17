import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePendingCorrections } from '../../hooks/usePendingCorrections'
import type { Correction } from '../../lib/types'

interface AdminCorrectionsTabProps {
  onActionComplete?: () => void
}

export function AdminCorrectionsTab({ onActionComplete }: AdminCorrectionsTabProps) {
  const { corrections, loading, error, refetch } = usePendingCorrections()
  const [processing, setProcessing] = useState<string | null>(null)
  const [expandedId, setExpandedId] = useState<string | null>(null)

  const handleMarkComplete = async (correctionId: string) => {
    setProcessing(correctionId)
    try {
      const { error: updateError } = await supabase
        .from('correction_requests')
        .update({
          status: 'completed',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', correctionId)

      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to mark correction as complete')
    } finally {
      setProcessing(null)
    }
  }

  const handleDismiss = async (correctionId: string) => {
    setProcessing(correctionId)
    try {
      const { error: updateError } = await supabase
        .from('correction_requests')
        .update({
          status: 'dismissed',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', correctionId)

      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to dismiss correction')
    } finally {
      setProcessing(null)
    }
  }

  const getTypeLabel = (type: Correction['correction_type']) => {
    switch (type) {
      case 'name_spelling':
        return 'Name'
      case 'date_correction':
        return 'Date'
      default:
        return 'Other'
    }
  }

  const getTypeColor = (type: Correction['correction_type']) => {
    switch (type) {
      case 'name_spelling':
        return 'bg-blue-100 text-blue-800'
      case 'date_correction':
        return 'bg-purple-100 text-purple-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading corrections...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  if (corrections.length === 0) {
    return <div className="text-center py-8 text-gray-600">No pending corrections</div>
  }

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full bg-white border border-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Person/Org</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Submitted By</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-200">
          {corrections.map((correction) => {
            const person = (correction as any).person
            const isExpanded = expandedId === correction.id
            const description = correction.description
            const truncated = description.length > 100 ? description.substring(0, 100) + '...' : description

            return (
              <tr key={correction.id} className="hover:bg-gray-50">
                <td className="px-4 py-3">
                  {person ? (
                    <Link
                      to={`/person/${correction.person_id}`}
                      className="text-primary-600 hover:text-primary-700 hover:underline"
                    >
                      {person.display_name || person.full_name}
                    </Link>
                  ) : (
                    <span className="text-gray-600">Person ID: {correction.person_id}</span>
                  )}
                </td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-1 text-xs font-medium rounded ${getTypeColor(correction.correction_type)}`}>
                    {getTypeLabel(correction.correction_type)}
                  </span>
                </td>
                <td className="px-4 py-3 text-sm text-gray-900 max-w-md">
                  <div>
                    {isExpanded ? description : truncated}
                    {description.length > 100 && (
                      <button
                        onClick={() => setExpandedId(isExpanded ? null : correction.id)}
                        className="ml-2 text-primary-600 hover:text-primary-700 text-xs"
                      >
                        {isExpanded ? 'Show less' : 'Read more'}
                      </button>
                    )}
                  </div>
                </td>
                <td className="px-4 py-3 text-sm text-gray-900">{correction.submitter_name}</td>
                <td className="px-4 py-3 text-sm text-gray-600">{correction.submitter_email}</td>
                <td className="px-4 py-3 text-sm text-gray-600">
                  {correction.created_at 
                    ? new Date(correction.created_at).toLocaleDateString()
                    : (correction as any).submitted_at 
                      ? new Date((correction as any).submitted_at).toLocaleDateString()
                      : 'N/A'}
                </td>
                <td className="px-4 py-3">
                  <div className="flex gap-2">
                    <button
                      onClick={() => handleMarkComplete(correction.id)}
                      disabled={processing === correction.id}
                      className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                    >
                      Mark Complete
                    </button>
                    <button
                      onClick={() => handleDismiss(correction.id)}
                      disabled={processing === correction.id}
                      className="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                    >
                      Dismiss
                    </button>
                  </div>
                </td>
              </tr>
            )
          })}
        </tbody>
      </table>
    </div>
  )
}

