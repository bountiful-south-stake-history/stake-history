import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Person } from '../lib/types'

export function usePerson(id: string) {
  const [person, setPerson] = useState<Person | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!id) {
      setLoading(false)
      return
    }

    async function fetchPerson() {
      try {
        const { data, error: fetchError } = await supabase
          .from('people')
          .select('*')
          .eq('id', id)
          .eq('redacted', false)
          .single()

        if (fetchError) throw fetchError
        setPerson(data)
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch person'))
      } finally {
        setLoading(false)
      }
    }

    fetchPerson()
  }, [id])

  return { person, loading, error }
}

