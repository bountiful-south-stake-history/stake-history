import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export interface AdminStats {
  pendingPortraits: number
  pendingCorrections: number
  pendingMemories: number
  pendingPhotos: number
  newSuggestions: number
}

export function useAdminStats() {
  const [stats, setStats] = useState<AdminStats>({
    pendingPortraits: 0,
    pendingCorrections: 0,
    pendingMemories: 0,
    pendingPhotos: 0,
    newSuggestions: 0,
  })
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  const fetchStats = async () => {
    try {
      const [portraitsResult, correctionsResult, memoriesResult, photosResult, suggestionsResult] = await Promise.all([
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
        supabase
          .from('suggestions')
          .select('id', { count: 'exact', head: true })
          .eq('status', 'new'),
      ])

      const portraitCount = portraitsResult.count ?? 0
      const correctionCount = correctionsResult.count ?? 0
      const memoryCount = memoriesResult.count ?? 0
      const photoCount = photosResult.count ?? 0
      const suggestionCount = suggestionsResult.count ?? 0

      console.log('Admin Stats:', {
        pendingPortraits: portraitCount,
        pendingCorrections: correctionCount,
        pendingMemories: memoryCount,
        pendingPhotos: photoCount,
        newSuggestions: suggestionCount,
        portraitError: portraitsResult.error,
      })

      setStats({
        pendingPortraits: portraitCount,
        pendingCorrections: correctionCount,
        pendingMemories: memoryCount,
        pendingPhotos: photoCount,
        newSuggestions: suggestionCount,
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

