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
      
      const { data, error: fetchError, count } = await supabase
        .from('portrait_submissions')
        .select(`
          *,
          person:people(*)
        `, { count: 'exact' })
        .eq('status', 'pending')
        .order('submitted_at', { ascending: false })

      if (fetchError) throw fetchError
      
      const portraitsData = (data || []) as PendingPortrait[]
      console.log('Pending Portraits:', {
        count: portraitsData.length,
        queryCount: count,
        data: portraitsData.map(p => ({ id: p.id, person_id: p.person_id, status: p.status })),
      })
      
      setPortraits(portraitsData)
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

