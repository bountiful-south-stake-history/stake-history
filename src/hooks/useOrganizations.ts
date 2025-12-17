import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Organization } from '../lib/types'

export function useOrganizations() {
  const [organizations, setOrganizations] = useState<Organization[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    async function fetchOrganizations() {
      try {
        const { data, error } = await supabase
          .from('organizations')
          .select('*')
          .order('sort_order')

        if (error) throw error
        setOrganizations(data || [])
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch organizations'))
      } finally {
        setLoading(false)
      }
    }

    fetchOrganizations()
  }, [])

  return { organizations, loading, error }
}

