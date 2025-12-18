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
            .select('person_id')
            .eq('photo_id', photo.id)

          const personNames: string[] = []
          const personIds: string[] = []
          
          if (photoPeopleData && photoPeopleData.length > 0) {
            const personIdsList = photoPeopleData.map((item: any) => item.person_id)
            
            const { data: peopleData } = await supabase
              .from('people')
              .select('id, full_name, display_name')
              .in('id', personIdsList)
            
            if (peopleData) {
              peopleData.forEach((person: any) => {
                personIds.push(person.id)
                personNames.push(person.display_name || person.full_name)
              })
            }
          }

          return {
            ...photo,
            file_url: photo.photo_url,
            person_ids: personIds,
            person_names: personNames,
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

