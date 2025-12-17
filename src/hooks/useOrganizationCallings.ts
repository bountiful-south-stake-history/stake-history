import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Calling, Person, Position } from '../lib/types'

export interface CallingWithDetails extends Calling {
  person: Person
  position: Position
}

export function useOrganizationCallings(organizationId: string) {
  const [callings, setCallings] = useState<CallingWithDetails[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!organizationId) {
      setLoading(false)
      return
    }

    async function fetchCallings() {
      try {
        const { data, error } = await supabase
          .from('callings')
          .select(`
            *,
            person:people(*),
            position:positions(*)
          `)
          .eq('organization_id', organizationId)
          .order('sustained_date', { ascending: false })

        if (error) throw error

        const filteredCallings = (data || [])
          .filter((calling: any) => calling.person && !calling.person.redacted)
          .map((calling: any) => ({
            ...calling,
            person: calling.person as Person,
            position: calling.position as Position,
          }))

        setCallings(filteredCallings)
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch callings'))
      } finally {
        setLoading(false)
      }
    }

    fetchCallings()
  }, [organizationId])

  return { callings, loading, error }
}

