import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Calling } from '../lib/types'

export function useCallings() {
  const [callings, setCallings] = useState<Calling[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    async function fetchCallings() {
      try {
        const { data, error } = await supabase
          .from('callings')
          .select('*')
          .order('sustained_date', { ascending: false })

        if (error) throw error
        setCallings(data || [])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch callings'))
      } finally {
        setLoading(false)
      }
    }

    fetchCallings()
  }, [])

  return { callings, loading, error }
}

