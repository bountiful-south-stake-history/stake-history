import { useState, useCallback, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'

export interface ActivityItem {
  id: string
  personId: string
  personName: string
  activityType: 'photo_tag' | 'memory'
  photoId?: string
  memoryId?: string
  title: string
  createdAt: string
}

export function useWatchActivity(limit: number = 10) {
  const { user } = useAuth()
  const [activities, setActivities] = useState<ActivityItem[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [hasMore, setHasMore] = useState(false)

  const fetchActivities = useCallback(async (offset: number = 0) => {
    if (!user) {
      setActivities([])
      setIsLoading(false)
      return
    }

    try {
      setIsLoading(true)
      setError(null)

      const { data: watchedPeople, error: watchedError } = await supabase
        .from('person_follows')
        .select('person_id')
        .eq('user_id', user.id)

      if (watchedError) throw watchedError

      if (!watchedPeople || watchedPeople.length === 0) {
        setActivities([])
        setHasMore(false)
        setIsLoading(false)
        return
      }

      const personIds = watchedPeople.map((wp) => wp.person_id)

      const { data: activityData, error: activityError } = await supabase
        .from('follow_activity')
        .select(`
          id,
          person_id,
          activity_type,
          photo_id,
          memory_id,
          title,
          created_at,
          people:person_id (
            id,
            display_name,
            full_name
          )
        `)
        .in('person_id', personIds)
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1)

      if (activityError) throw activityError

      const { count, error: countError } = await supabase
        .from('follow_activity')
        .select('*', { count: 'exact', head: true })
        .in('person_id', personIds)

      if (countError) {
        console.error('Failed to get activity count:', countError)
      } else {
        setHasMore((count || 0) > offset + limit)
      }

      const formattedActivities: ActivityItem[] = (activityData || [])
        .map((item: any) => {
          const person = item.people
          const personName = person?.display_name || person?.full_name || 'Unknown Person'

          return {
            id: item.id,
            personId: item.person_id,
            personName,
            activityType: item.activity_type,
            photoId: item.photo_id || undefined,
            memoryId: item.memory_id || undefined,
            title: item.title,
            createdAt: item.created_at,
          }
        })
        .filter(Boolean)

      if (offset === 0) {
        setActivities(formattedActivities)
      } else {
        setActivities((prev) => [...prev, ...formattedActivities])
      }
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Failed to fetch activity'
      setError(errorMessage)
      console.error('Error fetching watch activity:', err)
    } finally {
      setIsLoading(false)
    }
  }, [user, limit])

  useEffect(() => {
    fetchActivities(0)
  }, [fetchActivities])

  const loadMore = useCallback(() => {
    if (!isLoading && hasMore) {
      fetchActivities(activities.length)
    }
  }, [isLoading, hasMore, activities.length, fetchActivities])

  return {
    activities,
    isLoading,
    error,
    hasMore,
    refetch: () => fetchActivities(0),
    loadMore,
  }
}
