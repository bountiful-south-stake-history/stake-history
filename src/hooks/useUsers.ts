import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export interface UserProfile {
  id: string
  email: string
  display_name: string
  role: 'admin' | 'contributor' | 'viewer'
  view_blocked?: boolean
  view_blocked_reason?: string | null
  created_at: string
}

export function useUsers() {
  const [users, setUsers] = useState<UserProfile[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  useEffect(() => {
    async function fetchUsers() {
      try {
        setLoading(true)
        const { data, error: fetchError } = await supabase
          .from('admin_users_view')
          .select('*')
          .order('created_at', { ascending: false })

        if (fetchError) throw fetchError
        setUsers(data || [])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch users'))
      } finally {
        setLoading(false)
      }
    }

    fetchUsers()
  }, [refreshTrigger])

  return {
    users,
    loading,
    error,
    refetch: () => setRefreshTrigger((prev) => prev + 1),
  }
}

