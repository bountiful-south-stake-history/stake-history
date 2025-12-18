import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Photo } from '../lib/types'

export function usePersonPhotos(personId: string) {
  const [photos, setPhotos] = useState<Photo[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!personId) {
      setLoading(false)
      return
    }

    async function fetchPhotos() {
      try {
        const { data: photosData, error: photosError } = await supabase
          .from('photo_people')
          .select(`
            photo_id,
            photos (
              id,
              photo_url,
              caption,
              submitter_name,
              submitter_email,
              submitter_phone,
              approximate_date,
              event_context,
              status,
              submitted_at,
              reviewed_at,
              reviewed_by,
              rejection_reason
            )
          `)
          .eq('person_id', personId)

        if (photosError) throw photosError
        
        const filteredPhotos = (photosData || [])
          .map((item: any) => item.photos)
          .filter((photo: any) => photo && photo.status === 'approved')
          .map((photo: any) => ({
            ...photo,
            file_url: photo.photo_url,
          }))
        
        setPhotos(filteredPhotos)
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch photos'))
      } finally {
        setLoading(false)
      }
    }

    fetchPhotos()
  }, [personId])

  return { photos, loading, error }
}

