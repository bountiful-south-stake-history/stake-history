import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Photo } from '../lib/types'

export interface ApprovedPhoto extends Photo {
  person_ids?: string[]
  person_names?: string[]
}

export function useApprovedPhotos() {
  const [photos, setPhotos] = useState<ApprovedPhoto[]>([])
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
          id,
          photo_url,
          caption,
          submitter_name,
          submitter_email,
          submitter_phone,
          approximate_date,
          event_context,
          additional_people,
          submitted_at,
          status,
          reviewed_at,
          reviewed_by,
          rejection_reason
        `)
        .eq('status', 'approved')
        .order('submitted_at', { ascending: false })

      if (photosError) throw photosError

      const photosWithPeople = await Promise.all(
        (photosData || []).map(async (photo: any) => {
          const { data: photoPeopleData } = await supabase
            .from('photo_people')
            .select(`
              person_id,
              people:person_id (
                id,
                display_name,
                full_name
              )
            `)
            .eq('photo_id', photo.id)

          const taggedPeople: Array<{ id: string; display_name?: string; full_name: string }> = []
          let additionalPeople: string[] = []
          
          if (photoPeopleData && photoPeopleData.length > 0) {
            photoPeopleData.forEach((item: any) => {
              if (item.people) {
                taggedPeople.push({
                  id: item.people.id,
                  display_name: item.people.display_name,
                  full_name: item.people.full_name,
                })
              }
            })
          }

          try {
            if (photo.additional_people) {
              additionalPeople = typeof photo.additional_people === 'string' 
                ? JSON.parse(photo.additional_people) 
                : photo.additional_people
            }
          } catch (e) {
            console.error('Failed to parse additional_people:', e)
          }

          return {
            ...photo,
            file_url: photo.photo_url,
            taggedPeople,
            additionalPeople: additionalPeople || [],
          }
        })
      )

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

