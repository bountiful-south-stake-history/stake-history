import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'

export interface UserProfileData {
  id: string
  email: string
  display_name: string | null
  role: 'admin' | 'contributor' | 'viewer'
  view_blocked: boolean
  created_at: string
}

export function useUserProfile() {
  const { user, loading: authLoading } = useAuth()
  const [profile, setProfile] = useState<UserProfileData | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchProfile() {
      if (!user) {
        setProfile(null)
        setLoading(false)
        return
      }

      try {
        const { data, error } = await supabase
          .from('user_profiles')
          .select('id, email, display_name, role, view_blocked, created_at')
          .eq('id', user.id)
          .maybeSingle()

        if (error) throw error
        setProfile(data)
      } catch (err) {
        console.error('Failed to fetch user profile:', err)
        setProfile(null)
      } finally {
        setLoading(false)
      }
    }

    if (!authLoading) {
      fetchProfile()
    }
  }, [user, authLoading])

  return { profile, loading: loading || authLoading }
}

