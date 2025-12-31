import { useState, useCallback, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'
import type { Person } from '../lib/types'

export function useWatchedPeople() {
  const { user } = useAuth()
  const [watchedPeople, setWatchedPeople] = useState<Person[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<Error | null>(null)

  const fetchWatchedPeople = useCallback(async () => {
    if (!user) {
      setWatchedPeople([])
      return
    }

    try {
      setIsLoading(true)
      setError(null)
      const { data, error: fetchError } = await supabase
        .from('person_follows')
        .select(`
          person_id,
          people (
            id,
            full_name,
            display_name,
            photo_url,
            portrait_url,
            birth_date,
            death_date,
            bio
          )
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })

      if (fetchError) throw fetchError

      const people = (data || [])
        .map((item: any) => item.people)
        .filter(Boolean) as Person[]

      setWatchedPeople(people)
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Failed to fetch watched people')
      setError(error)
      console.error('Error fetching watched people:', err)
    } finally {
      setIsLoading(false)
    }
  }, [user])

  useEffect(() => {
    fetchWatchedPeople()
  }, [fetchWatchedPeople])

  return {
    watchedPeople,
    isLoading,
    error,
    refetch: fetchWatchedPeople,
  }
}
