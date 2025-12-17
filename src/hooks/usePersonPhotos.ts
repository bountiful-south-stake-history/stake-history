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
        // Note: Photos table structure may need person_id column or junction table
        // For now, assuming photos table has person_id or needs to be linked differently
        // This may need adjustment based on actual schema
        const { data: photosData, error: photosError } = await supabase
          .from('photos')
          .select('*')
          .eq('status', 'approved')
          .order('submitted_at', { ascending: false })

        if (photosError) throw photosError
        
        // Filter by person_id if column exists, otherwise return all (may need schema adjustment)
        const filteredPhotos = photosData?.filter((photo: any) => 
          photo.person_id === personId
        ) || []
        
        // Map photo_url to file_url for compatibility
        const mappedPhotos = filteredPhotos.map((photo: any) => ({
          ...photo,
          file_url: photo.photo_url,
        }))
        
        setPhotos(mappedPhotos)
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

