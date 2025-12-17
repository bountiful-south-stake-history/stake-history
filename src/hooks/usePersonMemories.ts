import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Memory } from '../lib/types'

export function usePersonMemories(personId: string) {
  const [memories, setMemories] = useState<Memory[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!personId) {
      setLoading(false)
      return
    }

    async function fetchMemories() {
      try {
        const { data: memoriesData, error: memoriesError } = await supabase
          .from('memories')
          .select('*')
          .eq('person_id', personId)
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
  }, [personId])

  return { memories, loading, error }
}

