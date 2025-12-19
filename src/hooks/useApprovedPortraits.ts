import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Person } from '../lib/types'

export interface ApprovedPortrait {
  person: Person
  portrait_url: string
  portrait_approved_at?: string
  submitter_name?: string
  submitter_email?: string
}

export function useApprovedPortraits() {
  const [portraits, setPortraits] = useState<ApprovedPortrait[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchPortraits = async () => {
    try {
      setLoading(true)
      setError(null)

      const { data: peopleData, error: peopleError } = await supabase
        .from('people')
        .select('id, full_name, display_name, portrait_url, portrait_approved_at')
        .not('portrait_url', 'is', null)
        .eq('portrait_pending', false)
        .order('portrait_approved_at', { ascending: false, nullsFirst: false })

      if (peopleError) throw peopleError

      const portraitsWithSubmissions = await Promise.all(
        (peopleData || []).map(async (person) => {
          const { data: submissionData } = await supabase
            .from('portrait_submissions')
            .select('submitter_name, submitter_email')
            .eq('person_id', person.id)
            .eq('status', 'approved')
            .order('reviewed_at', { ascending: false })
            .limit(1)
            .single()

          return {
            person: {
              id: person.id,
              full_name: person.full_name,
              display_name: person.display_name,
              redacted: false,
              created_at: '',
              updated_at: '',
            } as Person,
            portrait_url: person.portrait_url!,
            portrait_approved_at: person.portrait_approved_at || undefined,
            submitter_name: submissionData?.submitter_name || undefined,
            submitter_email: submissionData?.submitter_email || undefined,
          }
        })
      )

      setPortraits(portraitsWithSubmissions)
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch approved portraits'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchPortraits()
  }, [refreshTrigger])

  return { portraits, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

