import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Memory } from '../lib/types'

export function useBuildingMemories(buildingId: string) {
  const [memories, setMemories] = useState<Memory[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  useEffect(() => {
    if (!buildingId) {
      setLoading(false)
      return
    }

    async function fetchMemories() {
      try {
        setLoading(true)
        const { data: memoriesData, error: memoriesError } = await supabase
          .from('memories')
          .select('*')
          .eq('building_id', buildingId)
          .eq('status', 'approved')
          .order('submitted_at', { ascending: false })

        if (memoriesError) throw memoriesError
        setMemories(memoriesData || [])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch memories'))
      } finally {
        setLoading(false)
      }
    }

    fetchMemories()
  }, [buildingId, refreshTrigger])

  return { memories, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}
