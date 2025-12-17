import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Memory } from '../lib/types'

export function useApprovedMemories() {
  const [memories, setMemories] = useState<(Memory & { person_name?: string })[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchMemories = async () => {
    try {
      setLoading(true)
      setError(null)

      const { data: memoriesData, error: memoriesError } = await supabase
        .from('memories')
        .select(`
          *,
          person:people(id, full_name, display_name)
        `)
        .eq('status', 'approved')
        .order('submitted_at', { ascending: false })

      if (memoriesError) throw memoriesError

      const memoriesWithPeople = (memoriesData || []).map((memory: any) => ({
        ...memory,
        person_name: memory.person?.full_name || memory.person?.display_name || undefined,
      }))

      setMemories(memoriesWithPeople)
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch approved memories'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchMemories()
  }, [refreshTrigger])

  return { memories, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

