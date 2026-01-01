import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'

export function useFeatureAnnouncements() {
  const { user, loading: authLoading } = useAuth()
  const [showWatchFeature, setShowWatchFeature] = useState(false)
  const [isChecking, setIsChecking] = useState(true)

  useEffect(() => {
    if (authLoading) return
    
    if (!user) {
      setIsChecking(false)
      return
    }

    const checkAnnouncement = async () => {
      try {
        const hasSeenInStorage = localStorage.getItem('hasSeenWatchFeature') === 'true'
        if (hasSeenInStorage) {
          setIsChecking(false)
          return
        }

        const { data, error } = await supabase
          .from('user_profiles')
          .select('has_seen_watch_feature')
          .eq('id', user.id)
          .maybeSingle()

        if (error) {
          if (error.code === '42703') {
            console.warn('has_seen_watch_feature column does not exist yet')
            setIsChecking(false)
            return
          }
          throw error
        }

        if (data && data.has_seen_watch_feature === false) {
          setShowWatchFeature(true)
        }
      } catch (err) {
        console.error('Failed to check feature announcement:', err)
      } finally {
        setIsChecking(false)
      }
    }

    checkAnnouncement()
  }, [user, authLoading])

  const dismissWatchFeature = async () => {
    setShowWatchFeature(false)
    localStorage.setItem('hasSeenWatchFeature', 'true')

    if (user) {
      try {
        const { error } = await supabase
          .from('user_profiles')
          .update({ has_seen_watch_feature: true })
          .eq('id', user.id)

        if (error) {
          if (error.code === '42703') {
            console.warn('has_seen_watch_feature column does not exist yet')
          } else {
            console.error('Failed to update feature announcement flag:', error)
          }
        }
      } catch (err) {
        console.error('Failed to dismiss feature announcement:', err)
      }
    }
  }

  return {
    showWatchFeature,
    dismissWatchFeature,
    isChecking,
  }
}
