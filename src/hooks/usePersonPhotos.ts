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
        
        const photoIds = [...new Set((photosData || []).map((item: any) => item.photos?.id).filter(Boolean))]
        
        const { data: taggedPeopleData } = await supabase
          .from('photo_people')
          .select(`
            photo_id,
            person_id,
            people:person_id (
              id,
              display_name,
              full_name
            )
          `)
          .in('photo_id', photoIds)

        const taggedPeopleMap = new Map<string, Array<{ id: string; display_name?: string; full_name: string }>>()
        if (taggedPeopleData) {
          taggedPeopleData.forEach((item: any) => {
            if (!taggedPeopleMap.has(item.photo_id)) {
              taggedPeopleMap.set(item.photo_id, [])
            }
            if (item.people) {
              taggedPeopleMap.get(item.photo_id)!.push({
                id: item.people.id,
                display_name: item.people.display_name,
                full_name: item.people.full_name,
              })
            }
          })
        }
        
        const filteredPhotos = (photosData || [])
          .map((item: any) => item.photos)
          .filter((photo: any) => photo && photo.status === 'approved')
          .map((photo: any) => ({
            ...photo,
            file_url: photo.photo_url,
            taggedPeople: taggedPeopleMap.get(photo.id) || [],
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

