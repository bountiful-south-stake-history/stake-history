import { useState, useCallback } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth'

export interface PhotoLikeData {
  photoId: string
  likeCount: number
  likedByUser: boolean
  likedByNames: string[]
}

export function usePhotoLikes() {
  const { user } = useAuth()
  const [likesMap, setLikesMap] = useState<Map<string, PhotoLikeData>>(new Map())
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<Error | null>(null)

  const fetchLikesForPhotos = useCallback(async (photoIds: string[]): Promise<Map<string, PhotoLikeData>> => {
    if (photoIds.length === 0) return new Map()

    try {
      setLoading(true)
      setError(null)

      // First query: Fetch all likes for these photos (without join)
      const { data: likesData, error: likesError } = await supabase
        .from('photo_likes')
        .select('photo_id, user_id, created_at')
        .in('photo_id', photoIds)
        .order('created_at', { ascending: false })

      if (likesError) throw likesError

      // Get unique user IDs from the likes
      const userIds = [...new Set((likesData || []).map((like) => like.user_id))]

      // Second query: Fetch user profiles for display names
      let profilesMap = new Map<string, { display_name?: string; email?: string }>()
      if (userIds.length > 0) {
        const { data: profilesData } = await supabase
          .from('user_profiles')
          .select('id, display_name, email')
          .in('id', userIds)

        if (profilesData) {
          profilesData.forEach((profile) => {
            profilesMap.set(profile.id, {
              display_name: profile.display_name || undefined,
              email: profile.email || undefined,
            })
          })
        }
      }

      // Fetch user's likes if logged in
      let userLikes: string[] = []
      if (user) {
        const { data: userLikesData } = await supabase
          .from('photo_likes')
          .select('photo_id')
          .eq('user_id', user.id)
          .in('photo_id', photoIds)

        if (userLikesData) {
          userLikes = userLikesData.map((like) => like.photo_id)
        }
      }

      // Group likes by photo_id and map to display names
      const likesByPhoto = new Map<string, PhotoLikeData>()

      photoIds.forEach((photoId) => {
        const photoLikes = (likesData || []).filter((like) => like.photo_id === photoId)
        const likedByNames = photoLikes
          .map((like) => {
            const profile = profilesMap.get(like.user_id)
            if (profile?.display_name) {
              return profile.display_name
            }
            if (profile?.email) {
              // Extract name from email (before @)
              return profile.email.split('@')[0]
            }
            return null
          })
          .filter(Boolean) as string[]

        likesByPhoto.set(photoId, {
          photoId,
          likeCount: photoLikes.length,
          likedByUser: userLikes.includes(photoId),
          likedByNames,
        })
      })

      // Merge with existing state instead of replacing
      setLikesMap((prev) => {
        const merged = new Map(prev)
        likesByPhoto.forEach((value, key) => {
          merged.set(key, value)
        })
        return merged
      })
      return likesByPhoto
    } catch (err) {
      const error = err instanceof Error ? err : new Error('Failed to fetch likes')
      setError(error)
      throw error
    } finally {
      setLoading(false)
    }
  }, [user])

  const likePhoto = useCallback(async (photoId: string): Promise<void> => {
    if (!user) throw new Error('Must be logged in to like photos')

    // Optimistic update - save previous state for rollback
    let previousState: PhotoLikeData | undefined
    setLikesMap((prev) => {
      const newMap = new Map(prev)
      const current = newMap.get(photoId) || {
        photoId,
        likeCount: 0,
        likedByUser: false,
        likedByNames: [],
      }
      
      previousState = { ...current }

      newMap.set(photoId, {
        photoId,
        likeCount: current.likeCount + 1,
        likedByUser: true,
        likedByNames: [...current.likedByNames, 'You'], // Temporary, will be replaced by refetch
      })

      return newMap
    })

    try {
      const { error } = await supabase
        .from('photo_likes')
        .insert({
          photo_id: photoId,
          user_id: user.id,
        })

      if (error) throw error

      // Fetch updated like data for this photo only and merge with existing state
      const { data: likesData } = await supabase
        .from('photo_likes')
        .select('photo_id, user_id, created_at')
        .eq('photo_id', photoId)
        .order('created_at', { ascending: false })

      if (likesData) {
        const userIds = [...new Set(likesData.map((like) => like.user_id))]
        let profilesMap = new Map<string, { display_name?: string; email?: string }>()
        
        if (userIds.length > 0) {
          const { data: profilesData } = await supabase
            .from('user_profiles')
            .select('id, display_name, email')
            .in('id', userIds)

          if (profilesData) {
            profilesData.forEach((profile) => {
              profilesMap.set(profile.id, {
                display_name: profile.display_name || undefined,
                email: profile.email || undefined,
              })
            })
          }
        }

        const likedByNames = likesData
          .map((like) => {
            const profile = profilesMap.get(like.user_id)
            if (profile?.display_name) {
              return profile.display_name
            }
            if (profile?.email) {
              return profile.email.split('@')[0]
            }
            return null
          })
          .filter(Boolean) as string[]

        // Update only this photo's data in the map
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          newMap.set(photoId, {
            photoId,
            likeCount: likesData.length,
            likedByUser: true,
            likedByNames,
          })
          return newMap
        })
      }
    } catch (err) {
      // Revert optimistic update on error
      if (previousState) {
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          newMap.set(photoId, previousState!)
          return newMap
        })
      } else {
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          const current = newMap.get(photoId)
          if (current) {
            newMap.set(photoId, {
              ...current,
              likedByUser: false,
              likeCount: Math.max(0, current.likeCount - 1),
            })
          }
          return newMap
        })
      }
      throw err
    }
  }, [user, fetchLikesForPhotos])

  const unlikePhoto = useCallback(async (photoId: string): Promise<void> => {
    if (!user) throw new Error('Must be logged in to unlike photos')

    // Optimistic update - save previous state for rollback
    let previousState: PhotoLikeData | undefined
    setLikesMap((prev) => {
      const newMap = new Map(prev)
      const current = newMap.get(photoId)
      if (current) {
        previousState = { ...current }
        newMap.set(photoId, {
          photoId,
          likeCount: Math.max(0, current.likeCount - 1),
          likedByUser: false,
          likedByNames: current.likedByNames.slice(0, -1), // Remove last (optimistic)
        })
      }
      return newMap
    })

    try {
      const { error } = await supabase
        .from('photo_likes')
        .delete()
        .eq('photo_id', photoId)
        .eq('user_id', user.id)

      if (error) throw error

      // Fetch updated like data for this photo only and merge with existing state
      const { data: likesData } = await supabase
        .from('photo_likes')
        .select('photo_id, user_id, created_at')
        .eq('photo_id', photoId)
        .order('created_at', { ascending: false })

      if (likesData) {
        const userIds = [...new Set(likesData.map((like) => like.user_id))]
        let profilesMap = new Map<string, { display_name?: string; email?: string }>()
        
        if (userIds.length > 0) {
          const { data: profilesData } = await supabase
            .from('user_profiles')
            .select('id, display_name, email')
            .in('id', userIds)

          if (profilesData) {
            profilesData.forEach((profile) => {
              profilesMap.set(profile.id, {
                display_name: profile.display_name || undefined,
                email: profile.email || undefined,
              })
            })
          }
        }

        const likedByNames = likesData
          .map((like) => {
            const profile = profilesMap.get(like.user_id)
            if (profile?.display_name) {
              return profile.display_name
            }
            if (profile?.email) {
              return profile.email.split('@')[0]
            }
            return null
          })
          .filter(Boolean) as string[]

        // Update only this photo's data in the map
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          newMap.set(photoId, {
            photoId,
            likeCount: likesData.length,
            likedByUser: false,
            likedByNames,
          })
          return newMap
        })
      }
    } catch (err) {
      // Revert optimistic update on error
      if (previousState) {
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          newMap.set(photoId, previousState!)
          return newMap
        })
      } else {
        setLikesMap((prev) => {
          const newMap = new Map(prev)
          const current = newMap.get(photoId)
          if (current) {
            newMap.set(photoId, {
              ...current,
              likedByUser: true,
              likeCount: current.likeCount + 1,
            })
          }
          return newMap
        })
      }
      throw err
    }
  }, [user, fetchLikesForPhotos])

  return {
    likesMap,
    loading,
    error,
    fetchLikesForPhotos,
    likePhoto,
    unlikePhoto,
  }
}

