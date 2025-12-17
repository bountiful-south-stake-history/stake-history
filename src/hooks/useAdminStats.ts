import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export interface AdminStats {
  pendingPortraits: number
  pendingCorrections: number
  pendingMemories: number
  pendingPhotos: number
}

export function useAdminStats() {
  const [stats, setStats] = useState<AdminStats>({
    pendingPortraits: 0,
    pendingCorrections: 0,
    pendingMemories: 0,
    pendingPhotos: 0,
  })
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  const fetchStats = async () => {
    try {
      const [portraitsResult, correctionsResult, memoriesResult, photosResult] = await Promise.all([
        supabase
          .from('portrait_submissions')
          .select('id', { count: 'exact', head: true })
          .eq('status', 'pending'),
        supabase
          .from('correction_requests')
          .select('id', { count: 'exact', head: true })
          .eq('status', 'pending'),
        supabase
          .from('memories')
          .select('id', { count: 'exact', head: true })
          .eq('status', 'pending'),
        supabase
          .from('photos')
          .select('id', { count: 'exact', head: true })
          .eq('status', 'pending'),
      ])

      setStats({
        pendingPortraits: portraitsResult.count || 0,
        pendingCorrections: correctionsResult.count || 0,
        pendingMemories: memoriesResult.count || 0,
        pendingPhotos: photosResult.count || 0,
      })
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch stats'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchStats()
  }, [])

  const refetch = () => {
    setLoading(true)
    fetchStats()
  }

  return { stats, loading, error, refetch }
}

