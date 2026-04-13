import { useState } from 'react'
import { FaTimes, FaTrash, FaExternalLinkAlt } from 'react-icons/fa'
import { useSuggestions, type Suggestion } from '../../hooks/useSuggestions'

const STATUS_LABELS: Record<string, string> = {
  new: 'New',
  in_review: 'In Review',
  resolved: 'Resolved',
  dismissed: 'Dismissed',
}

const STATUS_COLORS: Record<string, string> = {
  new: 'bg-yellow-100 text-yellow-800',
  in_review: 'bg-blue-100 text-blue-800',
  resolved: 'bg-green-100 text-green-800',
  dismissed: 'bg-gray-100 text-gray-600',
}

interface Props {
  onActionComplete?: () => void
}

export function AdminSuggestionsTab({ onActionComplete }: Props) {
  const [statusFilter, setStatusFilter] = useState('all')
  const { suggestions, loading, error, refetch, updateSuggestion, deleteSuggestion } = useSuggestions(statusFilter)
  const [selectedSuggestion, setSelectedSuggestion] = useState<Suggestion | null>(null)

  const handleRefresh = () => refetch()

  const formatDate = (iso: string) => {
    const d = new Date(iso)
    return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) +
      ' ' + d.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })
  }

  if (loading) {
    return <div className="text-center py-12 text-gray-500">Loading suggestions...</div>
  }

  if (error) {
    return <div className="text-center py-12 text-red-500">Failed to load suggestions.</div>
  }

  return (
    <div>
      {/* Toolbar */}
      <div className="flex items-center justify-between mb-4">
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          className="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
        >
          <option value="all">All Statuses</option>
          <option value="new">New</option>
          <option value="in_review">In Review</option>
          <option value="resolved">Resolved</option>
          <option value="dismissed">Dismissed</option>
        </select>
        <button
          onClick={handleRefresh}
          className="flex items-center gap-2 px-3 py-2 border border-gray-300 rounded-lg text-sm text-gray-600 hover:bg-gray-50 transition-colors"
        >
          Refresh
        </button>
      </div>

      {/* Content */}
      {suggestions.length === 0 ? (
        <div className="text-center py-16 text-gray-400">No suggestions found.</div>
      ) : (
        <>
          {/* Desktop table */}
          <div className="hidden md:block border border-gray-200 rounded-lg overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="text-left px-4 py-3 font-medium text-gray-600 w-36">Date</th>
                  <th className="text-left px-4 py-3 font-medium text-gray-600 w-44">From</th>
                  <th className="text-left px-4 py-3 font-medium text-gray-600">Suggestion</th>
                  <th className="text-left px-4 py-3 font-medium text-gray-600 w-28">Status</th>
                  <th className="text-left px-4 py-3 font-medium text-gray-600 w-32">Notes</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {suggestions.map((s) => (
                  <tr
                    key={s.id}
                    onClick={() => setSelectedSuggestion(s)}
                    className="hover:bg-gray-50 cursor-pointer transition-colors"
                  >
                    <td className="px-4 py-3 text-gray-500 whitespace-nowrap">
                      {formatDate(s.created_at)}
                    </td>
                    <td className="px-4 py-3">
                      <span className="text-gray-700">{s.email || <span className="text-gray-400 italic">anonymous</span>}</span>
                    </td>
                    <td className="px-4 py-3 text-accent-600 max-w-xs">
                      <span className="line-clamp-2">{s.suggestion}</span>
                    </td>
                    <td className="px-4 py-3">
                      <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${STATUS_COLORS[s.status]}`}>
                        {STATUS_LABELS[s.status]}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-gray-500 max-w-xs">
                      <span className="line-clamp-1">{s.admin_notes || ''}</span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            <div className="px-4 py-2 bg-gray-50 border-t border-gray-200 text-xs text-gray-500">
              {suggestions.length} suggestion{suggestions.length !== 1 ? 's' : ''}
            </div>
          </div>

          {/* Mobile cards */}
          <div className="md:hidden space-y-3">
            {suggestions.map((s) => (
              <div
                key={s.id}
                onClick={() => setSelectedSuggestion(s)}
                className="bg-white border border-gray-200 rounded-lg p-4 cursor-pointer active:bg-gray-50 transition-colors"
              >
                <div className="flex items-center justify-between mb-2">
                  <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${STATUS_COLORS[s.status]}`}>
                    {STATUS_LABELS[s.status]}
                  </span>
                  <span className="text-xs text-gray-400">{formatDate(s.created_at)}</span>
                </div>
                <p className="text-sm text-accent-600 line-clamp-3 mb-2">{s.suggestion}</p>
                <p className="text-xs text-gray-500">
                  {s.email || <span className="italic">anonymous</span>}
                </p>
                {s.admin_notes && (
                  <p className="text-xs text-gray-400 mt-1 line-clamp-1">Note: {s.admin_notes}</p>
                )}
              </div>
            ))}
            <div className="text-xs text-gray-500 text-center py-1">
              {suggestions.length} suggestion{suggestions.length !== 1 ? 's' : ''}
            </div>
          </div>
        </>
      )}

      {/* Detail Modal */}
      {selectedSuggestion && (
        <SuggestionDetailModal
          suggestion={selectedSuggestion}
          onClose={() => setSelectedSuggestion(null)}
          onSave={async (updates) => {
            await updateSuggestion(selectedSuggestion.id, updates)
            setSelectedSuggestion(null)
            onActionComplete?.()
          }}
          onDelete={async () => {
            await deleteSuggestion(selectedSuggestion.id)
            setSelectedSuggestion(null)
            onActionComplete?.()
          }}
        />
      )}
    </div>
  )
}

interface DetailModalProps {
  suggestion: Suggestion
  onClose: () => void
  onSave: (updates: { status: string; admin_notes: string }) => Promise<void>
  onDelete: () => Promise<void>
}

function SuggestionDetailModal({ suggestion, onClose, onSave, onDelete }: DetailModalProps) {
  const [status, setStatus] = useState(suggestion.status)
  const [adminNotes, setAdminNotes] = useState(suggestion.admin_notes ?? '')
  const [saving, setSaving] = useState(false)
  const [deleting, setDeleting] = useState(false)
  const [confirmDelete, setConfirmDelete] = useState(false)

  const formatDate = (iso: string) => {
    const d = new Date(iso)
    return d.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' }) +
      ' ' + d.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })
  }

  const handleSave = async () => {
    setSaving(true)
    try {
      await onSave({ status, admin_notes: adminNotes })
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async () => {
    if (!confirmDelete) { setConfirmDelete(true); return }
    setDeleting(true)
    try {
      await onDelete()
    } finally {
      setDeleting(false)
    }
  }

  return (
    <div
      className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white rounded-xl shadow-xl w-full max-w-lg animate-slideUp">
        {/* Header */}
        <div className="flex items-center justify-between p-5 border-b border-gray-100">
          <h2 className="text-base font-semibold text-gray-800">Suggestion Details</h2>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600 transition-colors" aria-label="Close">
            <FaTimes />
          </button>
        </div>

        <div className="p-5 space-y-4">
          {/* Meta */}
          <div className="bg-gray-50 rounded-lg px-4 py-3 text-sm space-y-1">
            <div><span className="font-medium text-gray-600">From: </span><span className="text-gray-800">{suggestion.email || <span className="italic text-gray-400">anonymous</span>}</span></div>
            {suggestion.page_url && (
              <div className="flex items-center gap-1">
                <span className="font-medium text-gray-600">Page: </span>
                <a
                  href={suggestion.page_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-accent-600 hover:underline flex items-center gap-1 truncate max-w-xs"
                  onClick={(e) => e.stopPropagation()}
                >
                  {suggestion.page_url}
                  <FaExternalLinkAlt className="text-xs flex-shrink-0" />
                </a>
              </div>
            )}
            <div><span className="font-medium text-gray-600">Date: </span><span className="text-gray-800">{formatDate(suggestion.created_at)}</span></div>
          </div>

          {/* Suggestion text */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Suggestion</label>
            <div className="bg-yellow-50 border border-yellow-200 rounded-lg px-3 py-2.5 text-sm text-gray-800 whitespace-pre-wrap">
              {suggestion.suggestion}
            </div>
          </div>

          {/* Status */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
            <select
              value={status}
              onChange={(e) => setStatus(e.target.value as Suggestion['status'])}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
            >
              <option value="new">New</option>
              <option value="in_review">In Review</option>
              <option value="resolved">Resolved</option>
              <option value="dismissed">Dismissed</option>
            </select>
          </div>

          {/* Admin Notes */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Admin Notes</label>
            <textarea
              value={adminNotes}
              onChange={(e) => setAdminNotes(e.target.value)}
              placeholder="Add notes about this suggestion..."
              rows={3}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm resize-y focus:outline-none focus:ring-2 focus:ring-primary-500"
            />
          </div>

          {/* Actions */}
          <div className="flex items-center gap-3 pt-1">
            <button
              onClick={handleDelete}
              disabled={deleting}
              className={`p-2 rounded-lg transition-colors ${
                confirmDelete
                  ? 'bg-red-500 hover:bg-red-600 text-white'
                  : 'text-gray-400 hover:text-red-500 hover:bg-red-50'
              }`}
              title={confirmDelete ? 'Click again to confirm delete' : 'Delete suggestion'}
            >
              <FaTrash className="text-sm" />
            </button>
            {confirmDelete && (
              <span className="text-xs text-red-500">Click again to confirm</span>
            )}
            <div className="flex-1" />
            <button
              onClick={onClose}
              className="px-4 py-2 border border-gray-300 rounded-lg text-sm text-gray-600 hover:bg-gray-50 transition-colors"
            >
              Cancel
            </button>
            <button
              onClick={handleSave}
              disabled={saving}
              className="px-4 py-2 bg-primary-600 hover:bg-primary-700 disabled:bg-gray-300 text-white rounded-lg text-sm font-medium transition-colors"
            >
              {saving ? 'Saving...' : 'Save Changes'}
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
