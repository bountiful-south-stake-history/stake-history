import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Memory } from '../lib/types'

export function usePendingMemories() {
  const [memories, setMemories] = useState<(Memory & { person_id?: string; person_name?: string })[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchMemories = async () => {
    try {
      setLoading(true)
      setError(null)
      
      // Try to fetch with person join first
      let memoriesData: any[] | null = null
      let memoriesError: any = null
      
      const result = await supabase
        .from('memories')
        .select(`
          *,
          person:people(id, full_name, display_name)
        `)
        .eq('status', 'pending')
        .order('submitted_at', { ascending: false })

      memoriesData = result.data
      memoriesError = result.error

      // If join fails, try without join
      if (memoriesError && (memoriesError.code === 'PGRST116' || memoriesError.message?.includes('relation'))) {
        console.warn('Join failed, fetching without person join:', memoriesError.message)
        const simpleResult = await supabase
          .from('memories')
          .select('*')
          .eq('status', 'pending')
          .order('submitted_at', { ascending: false })
        
        memoriesData = simpleResult.data
        memoriesError = simpleResult.error
      }

      if (memoriesError) throw memoriesError

      const memoriesWithPeople = (memoriesData || []).map((memory: any) => ({
        ...memory,
        person_name: memory.person?.full_name || memory.person?.display_name || undefined,
        person_id: memory.person_id || memory.person?.id,
      }))

      setMemories(memoriesWithPeople)
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch pending memories'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchMemories()
  }, [refreshTrigger])

  return { memories, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

