import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Person } from '../lib/types'

export function usePeople() {
  const [people, setPeople] = useState<Person[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    async function fetchPeople() {
      try {
        const { data, error } = await supabase
          .from('people')
          .select('*')
          .order('full_name')

        if (error) throw error
        setPeople((data || []).filter(person => !person.redacted))
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch people'))
      } finally {
        setLoading(false)
      }
    }

    fetchPeople()
  }, [])

  return { people, loading, error }
}

export async function getPeopleCount(): Promise<number> {
  const { data, error } = await supabase
    .from('people')
    .select('id, redacted')

  if (error) throw error
  return (data || []).filter(person => !person.redacted).length
}

