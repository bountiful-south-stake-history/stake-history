import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Photo } from '../lib/types'

export function useApprovedPhotos() {
  const [photos, setPhotos] = useState<(Photo & { person_name?: string })[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchPhotos = async () => {
    try {
      setLoading(true)
      setError(null)

      const { data: photosData, error: photosError } = await supabase
        .from('photos')
        .select(`
          *,
          person:people(id, full_name, display_name)
        `)
        .eq('status', 'approved')
        .order('submitted_at', { ascending: false })

      if (photosError) throw photosError

      const photosWithPeople = (photosData || []).map((photo: any) => ({
        ...photo,
        person_name: photo.person?.full_name || photo.person?.display_name || undefined,
        file_url: photo.photo_url,
      }))

      setPhotos(photosWithPeople)
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch approved photos'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchPhotos()
  }, [refreshTrigger])

  return { photos, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

