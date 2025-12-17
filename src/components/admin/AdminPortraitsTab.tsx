import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePendingPortraits } from '../../hooks/usePendingPortraits'

interface AdminPortraitsTabProps {
  onActionComplete?: () => void
}

export function AdminPortraitsTab({ onActionComplete }: AdminPortraitsTabProps) {
  const { portraits, loading, error, refetch } = usePendingPortraits()
  const [processing, setProcessing] = useState<string | null>(null)
  const [showRejectModal, setShowRejectModal] = useState<{ id: string; name: string } | null>(null)
  const [rejectionReason, setRejectionReason] = useState('')

  const handleApprove = async (submissionId: string) => {
    setProcessing(submissionId)
    try {
      const submission = portraits.find((p) => p.id === submissionId)
      if (!submission) throw new Error('Portrait submission not found')

      const personId = submission.person_id
      const oldPath = submission.portrait_url
      const filename = oldPath.split('/').pop() || `${personId}.jpg`
      const newPath = `portraits/approved/${personId}/${filename}`

      const { data: fileData, error: downloadError } = await supabase.storage
        .from('portraits')
        .download(oldPath)

      if (downloadError) throw downloadError

      const { error: uploadError } = await supabase.storage
        .from('portraits')
        .upload(newPath, fileData, { upsert: true })

      if (uploadError) throw uploadError

      const { error: deleteError } = await supabase.storage.from('portraits').remove([oldPath])
      if (deleteError) console.error('Failed to delete old file:', deleteError)

      const {
        data: { publicUrl },
      } = supabase.storage.from('portraits').getPublicUrl(newPath)

      const { data: { user } } = await supabase.auth.getUser()
      const reviewedBy = user?.id || null

      const { error: updatePeopleError } = await supabase
        .from('people')
        .update({
          portrait_url: publicUrl,
          portrait_pending: false,
          portrait_approved_at: new Date().toISOString(),
        })
        .eq('id', personId)

      if (updatePeopleError) throw updatePeopleError

      const { error: updateSubmissionError } = await supabase
        .from('portrait_submissions')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
          reviewed_by: reviewedBy,
        })
        .eq('id', submissionId)

      if (updateSubmissionError) throw updateSubmissionError

      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to approve portrait')
    } finally {
      setProcessing(null)
    }
  }

  const handleReject = async () => {
    if (!showRejectModal) return

    setProcessing(showRejectModal.id)
    try {
      const submission = portraits.find((p) => p.id === showRejectModal.id)
      if (!submission) throw new Error('Portrait submission not found')
      
      // Delete the pending portrait file
      await supabase.storage.from('portraits').remove([submission.portrait_url])

      const { data: { user } } = await supabase.auth.getUser()
      const reviewedBy = user?.id || null

      const { error: updateSubmissionError } = await supabase
        .from('portrait_submissions')
        .update({
          status: 'rejected',
          reviewed_at: new Date().toISOString(),
          reviewed_by: reviewedBy,
          rejection_reason: rejectionReason || null,
        })
        .eq('id', showRejectModal.id)

      if (updateSubmissionError) throw updateSubmissionError

      setShowRejectModal(null)
      setRejectionReason('')
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to reject portrait')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading portraits...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  if (portraits.length === 0) {
    return <div className="text-center py-8 text-gray-600">No pending portraits</div>
  }


  return (
    <div>
      <div className="overflow-x-auto">
        <table className="min-w-full bg-white border border-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Portrait</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Person Name</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Submitted By</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Phone</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200">
            {portraits.map((submission) => {
              const person = submission.person
              const personName = person?.display_name || person?.full_name || 'Unknown Person'
              const personId = submission.person_id
              
              // Generate pending portrait URL from storage path
              const {
                data: { publicUrl: pendingPortraitUrl },
              } = supabase.storage.from('portraits').getPublicUrl(submission.portrait_url)
              
              return (
                <tr key={submission.id} className="hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <img
                      src={pendingPortraitUrl}
                      alt={personName}
                      className="w-20 h-[100px] object-cover rounded"
                      onError={(e) => {
                        // Fallback to person's approved portrait if pending file doesn't exist
                        if (person?.portrait_url) {
                          (e.target as HTMLImageElement).src = person.portrait_url
                        }
                      }}
                    />
                  </td>
                  <td className="px-4 py-3">
                    <Link
                      to={`/person/${personId}`}
                      className="text-primary-600 hover:text-primary-700 hover:underline"
                    >
                      {personName}
                    </Link>
                  </td>
                  <td className="px-4 py-3 text-sm text-gray-900">{submission.submitter_name}</td>
                  <td className="px-4 py-3 text-sm text-gray-600">{submission.submitter_email}</td>
                  <td className="px-4 py-3 text-sm text-gray-600">{submission.submitter_phone || '-'}</td>
                  <td className="px-4 py-3 text-sm text-gray-600">
                    {submission.submitted_at
                      ? new Date(submission.submitted_at).toLocaleDateString()
                      : '-'}
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleApprove(submission.id)}
                        disabled={processing === submission.id}
                        className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                      >
                        Approve
                      </button>
                      <button
                        onClick={() =>
                          setShowRejectModal({
                            id: submission.id,
                            name: personName,
                          })
                        }
                        disabled={processing === submission.id}
                        className="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                      >
                        Reject
                      </button>
                    </div>
                  </td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>

      {showRejectModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
            <h2 className="text-xl font-bold text-gray-900 mb-4">
              Reject Portrait for {showRejectModal.name}
            </h2>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Rejection Reason (optional)
              </label>
              <textarea
                value={rejectionReason}
                onChange={(e) => setRejectionReason(e.target.value)}
                rows={3}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                placeholder="e.g., Image quality too low, incorrect person..."
              />
            </div>
            <div className="flex gap-3 justify-end">
              <button
                onClick={() => {
                  setShowRejectModal(null)
                  setRejectionReason('')
                }}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleReject}
                disabled={processing === showRejectModal.id}
                className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 disabled:opacity-50"
              >
                Reject
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

