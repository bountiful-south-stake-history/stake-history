import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Organization } from '../lib/types'

export function useOrganization(id: string) {
  const [organization, setOrganization] = useState<Organization | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!id) {
      setLoading(false)
      return
    }

    async function fetchOrganization() {
      try {
        const { data, error } = await supabase
          .from('organizations')
          .select('*')
          .eq('id', id)
          .single()

        if (error) throw error
        setOrganization(data)
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch organization'))
      } finally {
        setLoading(false)
      }
    }

    fetchOrganization()
  }, [id])

  return { organization, loading, error }
}

