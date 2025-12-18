import { useState } from 'react'
import { supabase } from '../../lib/supabase'
import { useUsers } from '../../hooks/useUsers'
import { useAuth } from '../../hooks/useAuth'

export function AdminUsersTab() {
  const { users, loading, error, refetch } = useUsers()
  const { user: currentUser } = useAuth()
  const [processing, setProcessing] = useState<string | null>(null)
  const [editingId, setEditingId] = useState<string | null>(null)
  const [editDisplayName, setEditDisplayName] = useState('')
  const [showRestrictModal, setShowRestrictModal] = useState<string | null>(null)
  const [showRestoreModal, setShowRestoreModal] = useState<string | null>(null)
  const [restrictReason, setRestrictReason] = useState('')

  const toggleAdmin = async (userId: string, currentRole: string) => {
    if (userId === currentUser?.id && currentRole === 'admin') {
      alert('You cannot remove your own admin access.')
      return
    }

    if (currentRole === 'admin') {
      const confirm1 = window.confirm('Are you sure you want to remove admin access?')
      if (!confirm1) return

      const confirm2 = window.confirm('This will remove admin privileges. Continue?')
      if (!confirm2) return

      const confirm3 = window.confirm('Final confirmation: Remove admin access?')
      if (!confirm3) return
    }

    setProcessing(userId)
    try {
      const newRole = currentRole === 'admin' ? 'viewer' : 'admin'
      const { error: updateError } = await supabase
        .from('user_profiles')
        .update({ role: newRole })
        .eq('id', userId)

      if (updateError) throw updateError
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update user role')
    } finally {
      setProcessing(null)
    }
  }

  const startEdit = (userId: string, currentDisplayName: string) => {
    setEditingId(userId)
    setEditDisplayName(currentDisplayName || '')
  }

  const cancelEdit = () => {
    setEditingId(null)
    setEditDisplayName('')
  }

  const handleSaveDisplayName = async (userId: string) => {
    setProcessing(userId)
    try {
      const oldValues = {
        display_name: users.find((u) => u.id === userId)?.display_name || null,
      }

      const { error: updateError } = await supabase
        .from('user_profiles')
        .update({ display_name: editDisplayName.trim() || null })
        .eq('id', userId)

      if (updateError) throw updateError

      if (currentUser) {
        await supabase.from('audit_log').insert({
          table_name: 'user_profiles',
          record_id: userId,
          action: 'update_display_name',
          old_values: oldValues,
          new_values: { display_name: editDisplayName.trim() || null },
          performed_by: currentUser.id,
          performed_at: new Date().toISOString(),
        })
      }

      setEditingId(null)
      setEditDisplayName('')
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update display name')
    } finally {
      setProcessing(null)
    }
  }

  const handleRestrictView = async (userId: string) => {
    setProcessing(userId)
    try {
      const user = users.find((u) => u.id === userId)
      const oldValues = {
        view_blocked: user?.view_blocked || false,
      }

      const { error: updateError } = await supabase
        .from('user_profiles')
        .update({
          view_blocked: true,
          view_blocked_at: new Date().toISOString(),
          view_blocked_reason: restrictReason.trim() || null,
        })
        .eq('id', userId)

      if (updateError) throw updateError

      if (currentUser) {
        await supabase.from('audit_log').insert({
          table_name: 'user_profiles',
          record_id: userId,
          action: 'restrict_view_access',
          old_values: oldValues,
          new_values: {
            view_blocked: true,
            view_blocked_at: new Date().toISOString(),
            view_blocked_reason: restrictReason.trim() || null,
          },
          performed_by: currentUser.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowRestrictModal(null)
      setRestrictReason('')
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to restrict view access')
    } finally {
      setProcessing(null)
    }
  }

  const handleRestoreView = async (userId: string) => {
    setProcessing(userId)
    try {
      const user = users.find((u) => u.id === userId)
      const oldValues = {
        view_blocked: user?.view_blocked || false,
        view_blocked_reason: user?.view_blocked_reason || null,
      }

      const { error: updateError } = await supabase
        .from('user_profiles')
        .update({
          view_blocked: false,
          view_blocked_at: null,
          view_blocked_reason: null,
        })
        .eq('id', userId)

      if (updateError) throw updateError

      if (currentUser) {
        await supabase.from('audit_log').insert({
          table_name: 'user_profiles',
          record_id: userId,
          action: 'restore_view_access',
          old_values: oldValues,
          new_values: {
            view_blocked: false,
            view_blocked_at: null,
            view_blocked_reason: null,
          },
          performed_by: currentUser.id,
          performed_at: new Date().toISOString(),
        })
      }

      setShowRestoreModal(null)
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to restore view access')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading users...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  return (
    <>
      <div className="hidden md:block overflow-x-auto">
        <table className="min-w-full bg-white border border-gray-200">
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Email
                <span className="ml-2 text-xs font-normal text-gray-400" title="Email can only be changed by the user">
                  (read-only)
                </span>
              </th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Display Name</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">View Access</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Created</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200">
            {users.map((user) => {
              const isEditing = editingId === user.id
              const isViewBlocked = user.view_blocked === true
              return (
                <tr key={user.id} className="hover:bg-gray-50">
                  <td className="px-4 py-3 text-sm text-gray-900">{user.email}</td>
                  {isEditing ? (
                    <>
                      <td className="px-4 py-3">
                        <input
                          type="text"
                          value={editDisplayName}
                          onChange={(e) => setEditDisplayName(e.target.value)}
                          className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                          placeholder="Display name (optional)"
                          autoFocus
                        />
                      </td>
                      <td className="px-4 py-3">
                        <span
                          className={`px-2 py-1 text-xs font-medium rounded ${
                            user.role === 'admin'
                              ? 'bg-green-100 text-green-800'
                              : user.role === 'contributor'
                              ? 'bg-blue-100 text-blue-800'
                              : 'bg-gray-100 text-gray-800'
                          }`}
                        >
                          {user.role}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-sm">
                        {isViewBlocked ? (
                          <span className="text-red-600">🚫 Restricted</span>
                        ) : (
                          <span className="text-green-600">✅ Allowed</span>
                        )}
                      </td>
                      <td className="px-4 py-3 text-sm text-gray-600">
                        {new Date(user.created_at).toLocaleDateString()}
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex gap-2">
                          <button
                            onClick={() => handleSaveDisplayName(user.id)}
                            disabled={processing === user.id}
                            className="px-3 py-1 bg-green-600 text-white rounded text-sm hover:bg-green-700 disabled:opacity-50"
                          >
                            Save
                          </button>
                          <button
                            onClick={cancelEdit}
                            className="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50"
                          >
                            Cancel
                          </button>
                        </div>
                      </td>
                    </>
                  ) : (
                    <>
                      <td className="px-4 py-3 text-sm text-gray-900">
                        {user.display_name ? (
                          user.display_name
                        ) : (
                          <span className="text-gray-400 italic">Not set</span>
                        )}
                      </td>
                      <td className="px-4 py-3">
                        <span
                          className={`px-2 py-1 text-xs font-medium rounded ${
                            user.role === 'admin'
                              ? 'bg-green-100 text-green-800'
                              : user.role === 'contributor'
                              ? 'bg-blue-100 text-blue-800'
                              : 'bg-gray-100 text-gray-800'
                          }`}
                        >
                          {user.role}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-sm">
                        {isViewBlocked ? (
                          <span className="text-red-600">🚫 Restricted</span>
                        ) : (
                          <span className="text-green-600">✅ Allowed</span>
                        )}
                      </td>
                      <td className="px-4 py-3 text-sm text-gray-600">
                        {new Date(user.created_at).toLocaleDateString()}
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex gap-2 flex-wrap">
                          <button
                            onClick={() => startEdit(user.id, user.display_name || '')}
                            className="px-3 py-1 bg-blue-600 text-white rounded text-sm hover:bg-blue-700"
                          >
                            Edit
                          </button>
                          {isViewBlocked ? (
                            <button
                              onClick={() => setShowRestoreModal(user.id)}
                              disabled={processing === user.id}
                              className="px-3 py-1 bg-green-600 text-white rounded text-sm hover:bg-green-700 disabled:opacity-50"
                            >
                              Restore View
                            </button>
                          ) : (
                            <button
                              onClick={() => setShowRestrictModal(user.id)}
                              disabled={processing === user.id}
                              className="px-3 py-1 bg-yellow-600 text-white rounded text-sm hover:bg-yellow-700 disabled:opacity-50"
                            >
                              Restrict View
                            </button>
                          )}
                          <button
                            onClick={() => toggleAdmin(user.id, user.role)}
                            disabled={processing === user.id || (user.id === currentUser?.id && user.role === 'admin')}
                            className={`px-3 py-1 rounded text-sm disabled:opacity-50 ${
                              user.role === 'admin'
                                ? 'bg-red-600 text-white hover:bg-red-700'
                                : 'bg-green-600 text-white hover:bg-green-700'
                            }`}
                            title={user.id === currentUser?.id && user.role === 'admin' ? 'You cannot remove your own admin access' : ''}
                          >
                            {user.role === 'admin' ? 'Remove Admin' : 'Make Admin'}
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

      <div className="md:hidden space-y-3">
        {users.map((user) => {
          const isEditing = editingId === user.id
          const isViewBlocked = user.view_blocked === true
          return (
            <div key={user.id} className="p-4 bg-white border border-gray-200 rounded-lg shadow-sm">
              {isEditing ? (
                <>
                  <div className="mb-3">
                    <span className="text-sm font-medium text-gray-900">{user.email}</span>
                  </div>
                  <div className="mb-3">
                    <label className="text-xs text-gray-500 uppercase">Display Name</label>
                    <input
                      type="text"
                      value={editDisplayName}
                      onChange={(e) => setEditDisplayName(e.target.value)}
                      className="w-full mt-1 px-3 py-2 border border-gray-300 rounded text-sm"
                      placeholder="Display name (optional)"
                      autoFocus
                    />
                  </div>
                  <div className="mb-3">
                    <span className="text-xs text-gray-500">Role: </span>
                    <span
                      className={`px-2 py-1 text-xs font-medium rounded ${
                        user.role === 'admin'
                          ? 'bg-green-100 text-green-800'
                          : user.role === 'contributor'
                          ? 'bg-blue-100 text-blue-800'
                          : 'bg-gray-100 text-gray-800'
                      }`}
                    >
                      {user.role}
                    </span>
                  </div>
                  <div className="mb-3">
                    <span className="text-xs text-gray-500">View: </span>
                    {isViewBlocked ? (
                      <span className="text-sm text-red-600">🚫 Restricted</span>
                    ) : (
                      <span className="text-sm text-green-600">✅ Allowed</span>
                    )}
                  </div>
                  <div className="mb-3">
                    <span className="text-xs text-gray-500">Created: </span>
                    <span className="text-sm text-gray-900">{new Date(user.created_at).toLocaleDateString()}</span>
                  </div>
                  <div className="flex gap-2">
                    <button
                      onClick={() => handleSaveDisplayName(user.id)}
                      disabled={processing === user.id}
                      className="px-3 py-1 bg-green-600 text-white rounded text-sm hover:bg-green-700 disabled:opacity-50"
                    >
                      Save
                    </button>
                    <button
                      onClick={cancelEdit}
                      className="px-3 py-1 border border-gray-300 rounded text-sm hover:bg-gray-50"
                    >
                      Cancel
                    </button>
                  </div>
                </>
              ) : (
                <>
                  <div className="mb-2">
                    <span className="text-sm font-medium text-gray-900">{user.email}</span>
                  </div>
                  <div className="mb-2">
                    <span className="text-xs text-gray-500">Name: </span>
                    <span className="text-sm text-gray-900">
                      {user.display_name || <span className="text-gray-400 italic">Not set</span>}
                    </span>
                  </div>
                  <div className="mb-2">
                    <span className="text-xs text-gray-500">Role: </span>
                    <span
                      className={`px-2 py-1 text-xs font-medium rounded ${
                        user.role === 'admin'
                          ? 'bg-green-100 text-green-800'
                          : user.role === 'contributor'
                          ? 'bg-blue-100 text-blue-800'
                          : 'bg-gray-100 text-gray-800'
                      }`}
                    >
                      {user.role}
                    </span>
                  </div>
                  <div className="mb-2">
                    <span className="text-xs text-gray-500">View: </span>
                    {isViewBlocked ? (
                      <span className="text-sm text-red-600">🚫 Restricted</span>
                    ) : (
                      <span className="text-sm text-green-600">✅ Allowed</span>
                    )}
                  </div>
                  <div className="mb-3">
                    <span className="text-xs text-gray-500">Created: </span>
                    <span className="text-sm text-gray-900">{new Date(user.created_at).toLocaleDateString()}</span>
                  </div>
                  <div className="flex gap-2 flex-wrap">
                    <button
                      onClick={() => startEdit(user.id, user.display_name || '')}
                      className="px-3 py-1 bg-blue-600 text-white rounded text-sm hover:bg-blue-700"
                    >
                      Edit
                    </button>
                    {isViewBlocked ? (
                      <button
                        onClick={() => setShowRestoreModal(user.id)}
                        disabled={processing === user.id}
                        className="px-3 py-1 bg-green-600 text-white rounded text-sm hover:bg-green-700 disabled:opacity-50"
                      >
                        Restore View
                      </button>
                    ) : (
                      <button
                        onClick={() => setShowRestrictModal(user.id)}
                        disabled={processing === user.id}
                        className="px-3 py-1 bg-yellow-600 text-white rounded text-sm hover:bg-yellow-700 disabled:opacity-50"
                      >
                        Restrict View
                      </button>
                    )}
                    <button
                      onClick={() => toggleAdmin(user.id, user.role)}
                      disabled={processing === user.id || (user.id === currentUser?.id && user.role === 'admin')}
                      className={`px-3 py-1 rounded text-sm disabled:opacity-50 ${
                        user.role === 'admin'
                          ? 'bg-red-600 text-white hover:bg-red-700'
                          : 'bg-green-600 text-white hover:bg-green-700'
                      }`}
                      title={user.id === currentUser?.id && user.role === 'admin' ? 'You cannot remove your own admin access' : ''}
                    >
                      {user.role === 'admin' ? 'Remove Admin' : 'Make Admin'}
                    </button>
                  </div>
                </>
              )}
            </div>
          )
        })}
      </div>

      {showRestrictModal && (() => {
        const user = users.find((u) => u.id === showRestrictModal)
        if (!user) return null
        return (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
              <h2 className="text-xl font-bold text-gray-900 mb-4">Restrict View Access</h2>
              <p className="text-gray-700 mb-4">
                This will prevent {user.display_name || user.email} from viewing memories and photos. They will still
                be able to submit content, but will see 'Sign in to view' even when logged in.
              </p>
              <div className="mb-4">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Reason (optional)
                </label>
                <textarea
                  value={restrictReason}
                  onChange={(e) => setRestrictReason(e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 text-gray-900 bg-white"
                  placeholder="Admin notes..."
                  rows={3}
                />
              </div>
              <div className="flex gap-2 justify-end">
                <button
                  onClick={() => {
                    setShowRestrictModal(null)
                    setRestrictReason('')
                  }}
                  className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handleRestrictView(showRestrictModal)}
                  disabled={processing === showRestrictModal}
                  className="px-4 py-2 bg-yellow-600 text-white rounded hover:bg-yellow-700 disabled:opacity-50"
                >
                  {processing === showRestrictModal ? 'Restricting...' : 'Restrict Access'}
                </button>
              </div>
            </div>
          </div>
        )
      })()}

      {showRestoreModal && (() => {
        const user = users.find((u) => u.id === showRestoreModal)
        if (!user) return null
        return (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
              <h2 className="text-xl font-bold text-gray-900 mb-4">Restore View Access</h2>
              <p className="text-gray-700 mb-4">
                This will allow {user.display_name || user.email} to view memories and photos again.
              </p>
              <div className="flex gap-2 justify-end">
                <button
                  onClick={() => setShowRestoreModal(null)}
                  className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  onClick={() => handleRestoreView(showRestoreModal)}
                  disabled={processing === showRestoreModal}
                  className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50"
                >
                  {processing === showRestoreModal ? 'Restoring...' : 'Restore Access'}
                </button>
              </div>
            </div>
          </div>
        )
      })()}
    </>
  )
}
