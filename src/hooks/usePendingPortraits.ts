import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { PortraitSubmission, Person } from '../lib/types'

export interface PendingPortrait extends PortraitSubmission {
  person?: Person
}

export function usePendingPortraits() {
  const [portraits, setPortraits] = useState<PendingPortrait[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchPortraits = async () => {
    try {
      setLoading(true)
      setError(null)
      
      const { data, error: fetchError } = await supabase
        .from('portrait_submissions')
        .select(`
          *,
          person:people(*)
        `)
        .eq('status', 'pending')
        .order('submitted_at', { ascending: false })

      if (fetchError) throw fetchError
      setPortraits((data || []) as PendingPortrait[])
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch pending portraits'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchPortraits()
  }, [refreshTrigger])

  return { portraits, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

