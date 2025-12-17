import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Photo } from '../lib/types'

export interface PendingPhoto extends Photo {
  person_ids?: string[]
  person_names?: string[]
}

export function usePendingPhotos() {
  const [photos, setPhotos] = useState<PendingPhoto[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchPhotos = async () => {
    try {
      setLoading(true)
      setError(null)
      
      const { data: photosData, error: photosError } = await supabase
        .from('photos')
        .select('*')
        .eq('status', 'pending')
        .order('submitted_at', { ascending: false })

      if (photosError) throw photosError

      console.log('Fetched photos data:', photosData)
      console.log('Number of photos:', photosData?.length)

      // Note: Photos table may need a junction table for person relationships
      // For now, assuming photos can be linked via person_id if needed
      // Generate signed URLs for pending photos since they're in pending folder
      const photosWithPeople = await Promise.all(
        (photosData || []).map(async (photo) => {
          console.log('Processing photo:', {
            id: photo.id,
            photo_url: photo.photo_url,
            caption: photo.caption,
            allKeys: Object.keys(photo),
          })
          
          let displayUrl = photo.photo_url
          
          // Extract file path from URL to create signed URL for pending photos
          if (photo.photo_url) {
            try {
              const url = new URL(photo.photo_url)
              const pathMatch = url.pathname.match(/\/storage\/v1\/object\/public\/photos\/(.+)/)
              if (pathMatch) {
                const filePath = pathMatch[1]
                console.log('Extracted file path for signed URL:', filePath)
                
                // Create signed URL (valid for 1 hour) for pending photos
                const { data: signedData, error: signedError } = await supabase.storage
                  .from('photos')
                  .createSignedUrl(filePath, 3600)
                
                if (!signedError && signedData?.signedUrl) {
                  console.log('Using signed URL for photo:', photo.id)
                  displayUrl = signedData.signedUrl
                } else {
                  console.warn('Failed to create signed URL, using public URL:', signedError)
                }
              }
            } catch (err) {
              console.error('Error processing photo URL:', err)
            }
          }
          
          return {
            ...photo,
            photo_url: displayUrl, // Use signed URL if available
            file_url: displayUrl, // Map photo_url to file_url for compatibility
            person_ids: [],
            person_names: [],
          }
        })
      )

      console.log('Processed photos:', photosWithPeople)
      setPhotos(photosWithPeople)
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch pending photos'))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchPhotos()
  }, [refreshTrigger])

  return { photos, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

