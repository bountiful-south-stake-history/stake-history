import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import { useBuildingMemories } from '../../hooks/useBuildingMemories'

const buildingRelationshipOptions = [
  { value: 'attended', label: 'Attended meetings here' },
  { value: 'helped_build', label: 'Helped build/maintain' },
  { value: 'grew_up', label: 'Grew up attending' },
  { value: 'served_callings', label: 'Served in callings here' },
  { value: 'other', label: 'Other' },
]

const relationshipLabels: Record<string, string> = {
  attended: 'Attended meetings here',
  helped_build: 'Helped build/maintain',
  grew_up: 'Grew up attending',
  served_callings: 'Served in callings here',
  other: 'Other',
}

const MAX_MEMORY_LENGTH = 5000

interface BuildingMemoriesProps {
  buildingId: string
  buildingName: string
}

export function BuildingMemories({ buildingId, buildingName }: BuildingMemoriesProps) {
  const { user } = useAuth()
  const { memories, loading, error, refetch } = useBuildingMemories(buildingId)
  const [showSubmitModal, setShowSubmitModal] = useState(false)

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-semibold text-gray-900">
          Memories {memories.length > 0 && `(${memories.length})`}
        </h3>
        {user && (
          <button
            onClick={() => setShowSubmitModal(true)}
            className="px-4 py-2 bg-primary-600 text-white text-sm rounded-lg hover:bg-primary-700 transition-colors"
          >
            Share a Memory
          </button>
        )}
      </div>

      {loading && <p className="text-gray-500 text-sm">Loading memories...</p>}
      {error && <p className="text-red-600 text-sm">{error.message}</p>}

      {!loading && memories.length === 0 && (
        <p className="text-gray-500 text-sm py-4">
          No memories shared yet.{user ? ' Be the first to share one!' : ' Sign in to share a memory.'}
        </p>
      )}

      {memories.length > 0 && (
        <div className="space-y-4">
          {memories.map((memory) => (
            <div key={memory.id} className="bg-white border border-gray-200 rounded-lg p-5">
              <p className="text-gray-700 whitespace-pre-wrap mb-3">{memory.content}</p>
              <div className="text-xs text-gray-500 space-y-0.5">
                {memory.relationship && (
                  <p>{relationshipLabels[memory.relationship] || memory.relationship}</p>
                )}
                {memory.time_period && <p>{memory.time_period}</p>}
                {memory.submitter_name && (
                  <p className="text-gray-400">Shared by {memory.submitter_name}</p>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {showSubmitModal && (
        <BuildingMemorySubmitModal
          buildingId={buildingId}
          buildingName={buildingName}
          onClose={() => setShowSubmitModal(false)}
          onSuccess={() => {
            setShowSubmitModal(false)
            refetch()
          }}
        />
      )}
    </div>
  )
}

interface BuildingMemorySubmitModalProps {
  buildingId: string
  buildingName: string
  onClose: () => void
  onSuccess: () => void
}

export function BuildingMemorySubmitModal({ buildingId, buildingName, onClose, onSuccess }: BuildingMemorySubmitModalProps) {
  const { user } = useAuth()
  const [relationship, setRelationship] = useState('')
  const [timePeriod, setTimePeriod] = useState('')
  const [memoryContent, setMemoryContent] = useState('')
  const [submitterName, setSubmitterName] = useState('')
  const [submitterEmail, setSubmitterEmail] = useState('')
  const [submitterPhone, setSubmitterPhone] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState(false)

  useEffect(() => {
    if (user) {
      const autoPopulate = async () => {
        if (user.email) setSubmitterEmail(prev => prev || user.email || '')
        try {
          const { data } = await supabase
            .from('user_profiles')
            .select('display_name')
            .eq('id', user.id)
            .single()
          if (data?.display_name) setSubmitterName(prev => prev || data.display_name)
        } catch {}
      }
      autoPopulate()
    }
  }, [user])

  const handleSubmit = async () => {
    if (!submitterName.trim()) { setError('Please enter your name'); return }
    if (!submitterEmail.trim()) { setError('Please enter your email'); return }
    if (!memoryContent.trim()) { setError('Please share your memory'); return }
    if (memoryContent.length > MAX_MEMORY_LENGTH) { setError(`Memory must be ${MAX_MEMORY_LENGTH} characters or less`); return }

    setSubmitting(true)
    setError(null)

    try {
      const { error: insertError } = await supabase.from('memories').insert({
        building_id: buildingId,
        content: memoryContent,
        submitter_name: submitterName,
        submitter_email: submitterEmail,
        submitter_phone: submitterPhone?.trim() || null,
        relationship: relationship?.trim() || null,
        time_period: timePeriod?.trim() || null,
        status: 'pending',
      })

      if (insertError) throw insertError
      setSuccess(true)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit memory')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4" onClick={onClose}>
      <div className="bg-white rounded-lg shadow-xl max-w-lg w-full max-h-[90vh] overflow-y-auto p-6" onClick={e => e.stopPropagation()}>
        {success ? (
          <div className="text-center py-8">
            <div className="text-4xl mb-4">✓</div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">Memory Submitted!</h3>
            <p className="text-gray-600 mb-6">Your memory will appear after admin review.</p>
            <button
              onClick={onSuccess}
              className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700"
            >
              Done
            </button>
          </div>
        ) : (
          <>
            <h2 className="text-xl font-semibold text-gray-900 mb-1">Share a Memory</h2>
            <p className="text-sm text-gray-600 mb-4">about {buildingName}</p>

            {error && (
              <div className="px-4 py-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm mb-4">
                {error}
              </div>
            )}

            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Your Connection</label>
                <select
                  value={relationship}
                  onChange={e => setRelationship(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  disabled={submitting}
                >
                  <option value="">Select...</option>
                  {buildingRelationshipOptions.map(opt => (
                    <option key={opt.value} value={opt.value}>{opt.label}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Time Period <span className="text-gray-500 font-normal">(optional)</span>
                </label>
                <input
                  type="text"
                  value={timePeriod}
                  onChange={e => setTimePeriod(e.target.value)}
                  placeholder="e.g., 1970s, When I was in Young Women"
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  disabled={submitting}
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Memory / Story <span className="text-red-600">*</span>
                </label>
                <textarea
                  value={memoryContent}
                  onChange={e => {
                    if (e.target.value.length <= MAX_MEMORY_LENGTH) setMemoryContent(e.target.value)
                  }}
                  rows={6}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  placeholder="Share your memory about this building..."
                  disabled={submitting}
                />
                <p className={`text-sm text-right mt-1 ${memoryContent.length > MAX_MEMORY_LENGTH ? 'text-red-600' : 'text-gray-500'}`}>
                  {memoryContent.length} / {MAX_MEMORY_LENGTH}
                </p>
              </div>

              <div className="border-t border-gray-200 pt-4">
                <h4 className="text-sm font-semibold text-gray-900 mb-3">Your Information</h4>
                <div className="space-y-3">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Name <span className="text-red-600">*</span>
                    </label>
                    <input
                      type="text"
                      value={submitterName}
                      onChange={e => setSubmitterName(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Email <span className="text-red-600">*</span>
                    </label>
                    <input
                      type="email"
                      value={submitterEmail}
                      onChange={e => setSubmitterEmail(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Phone <span className="text-gray-500 font-normal">(optional)</span>
                    </label>
                    <input
                      type="tel"
                      value={submitterPhone}
                      onChange={e => setSubmitterPhone(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting}
                    />
                  </div>
                  <p className="text-xs text-gray-500 italic">
                    We may contact you if there are questions about this submission
                  </p>
                </div>
              </div>
            </div>

            <div className="flex gap-3 justify-end mt-6 pt-4 border-t border-gray-200">
              <button
                onClick={onClose}
                disabled={submitting}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50"
              >
                Cancel
              </button>
              <button
                onClick={handleSubmit}
                disabled={submitting}
                className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 flex items-center gap-2"
              >
                {submitting ? (
                  <>
                    <svg className="animate-spin h-4 w-4 text-white" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                    </svg>
                    Submitting...
                  </>
                ) : 'Submit Memory'}
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  )
}
