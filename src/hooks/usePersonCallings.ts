import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Calling } from '../lib/types'

export function usePersonCallings(personId: string) {
  const [callings, setCallings] = useState<Calling[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!personId) {
      setLoading(false)
      return
    }

    async function fetchCallings() {
      try {
        const { data, error: fetchError } = await supabase
          .from('callings')
          .select(`
            *,
            position:positions(*),
            organization:organizations(*)
          `)
          .eq('person_id', personId)
          .order('sustained_date', { ascending: false })

        if (fetchError) throw fetchError
        setCallings(data || [])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch callings'))
      } finally {
        setLoading(false)
      }
    }

    fetchCallings()
  }, [personId])

  return { callings, loading, error }
}

