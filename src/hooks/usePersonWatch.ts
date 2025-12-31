import { useState, useCallback, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'
import type { Person } from '../lib/types'

export function usePersonWatch(personId: string) {
  const { user } = useAuth()
  const [isWatching, setIsWatching] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [watchedPeople, setWatchedPeople] = useState<Person[]>([])
  const [watchCount, setWatchCount] = useState(0)

  const checkWatching = useCallback(async () => {
    if (!user || !personId) {
      setIsWatching(false)
      return
    }

    try {
      const { data, error } = await supabase
        .from('person_follows')
        .select('id')
        .eq('user_id', user.id)
        .eq('person_id', personId)
        .single()

      if (error && error.code !== 'PGRST116') {
        throw error
      }

      setIsWatching(!!data)
    } catch (err) {
      console.error('Error checking watch status:', err)
      setIsWatching(false)
    }
  }, [user, personId])

  const getWatchedPeople = useCallback(async () => {
    if (!user) {
      setWatchedPeople([])
      setWatchCount(0)
      return
    }

    try {
      setIsLoading(true)
      const { data, error } = await supabase
        .from('person_follows')
        .select(`
          person_id,
          people (
            id,
            full_name,
            display_name,
            photo_url,
            portrait_url
          )
        `)
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })

      if (error) throw error

      const people = (data || [])
        .map((item: any) => item.people)
        .filter(Boolean) as Person[]

      setWatchedPeople(people)
      setWatchCount(people.length)
    } catch (err) {
      console.error('Error fetching watched people:', err)
      setWatchedPeople([])
      setWatchCount(0)
    } finally {
      setIsLoading(false)
    }
  }, [user])

  const watchPerson = useCallback(async () => {
    if (!user || !personId) {
      throw new Error('Must be logged in to watch')
    }

    setIsLoading(true)
    try {
      const { error } = await supabase
        .from('person_follows')
        .insert({
          user_id: user.id,
          person_id: personId,
        })

      if (error) {
        if (error.code === '23505') {
          setIsWatching(true)
          return
        }
        throw error
      }

      setIsWatching(true)
      setWatchCount((prev) => prev + 1)
    } catch (err) {
      console.error('Error watching person:', err)
      throw err
    } finally {
      setIsLoading(false)
    }
  }, [user, personId])

  const unwatchPerson = useCallback(async () => {
    if (!user || !personId) {
      throw new Error('Must be logged in to unwatch')
    }

    setIsLoading(true)
    try {
      const { error } = await supabase
        .from('person_follows')
        .delete()
        .eq('user_id', user.id)
        .eq('person_id', personId)

      if (error) throw error

      setIsWatching(false)
      setWatchCount((prev) => Math.max(0, prev - 1))
    } catch (err) {
      console.error('Error unwatching person:', err)
      throw err
    } finally {
      setIsLoading(false)
    }
  }, [user, personId])

  const toggleWatch = useCallback(async () => {
    if (isWatching) {
      await unwatchPerson()
    } else {
      await watchPerson()
    }
  }, [isWatching, watchPerson, unwatchPerson])

  useEffect(() => {
    checkWatching()
  }, [checkWatching])

  return {
    isWatching,
    isLoading,
    toggleWatch,
    watchedPeople,
    watchCount,
    refetchWatchedPeople: getWatchedPeople,
  }
}
