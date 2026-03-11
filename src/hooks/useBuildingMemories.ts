import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Memory } from '../lib/types'

export interface BuildingMemoryWithPhoto extends Memory {
  photo_caption?: string
  photo_url?: string
}

export function useBuildingMemories(buildingId: string) {
  const [memories, setMemories] = useState<BuildingMemoryWithPhoto[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  useEffect(() => {
    if (!buildingId) {
      setLoading(false)
      return
    }

    async function fetchMemories() {
      try {
        setLoading(true)
        const { data: memoriesData, error: memoriesError } = await supabase
          .from('memories')
          .select('*')
          .eq('building_id', buildingId)
          .eq('status', 'approved')
          .order('submitted_at', { ascending: false })

        if (memoriesError) throw memoriesError

        const rawMemories: Memory[] = memoriesData || []

        // Fetch photo info for memories linked to photos
        const photoIds = [...new Set(rawMemories.filter(m => m.photo_id).map(m => m.photo_id!))]
        let photoMap = new Map<string, { caption?: string; photo_url?: string }>()

        if (photoIds.length > 0) {
          const { data: photosData } = await supabase
            .from('photos')
            .select('id, caption, photo_url')
            .in('id', photoIds)

          if (photosData) {
            for (const photo of photosData) {
              // Generate signed URL for thumbnail
              let displayUrl = photo.photo_url
              if (photo.photo_url) {
                try {
                  const url = new URL(photo.photo_url)
                  const pathMatch = url.pathname.match(/\/storage\/v1\/object\/(?:public|sign)\/photos\/(.+)/)
                  if (pathMatch) {
                    const { data: signedData } = await supabase.storage
                      .from('photos')
                      .createSignedUrl(pathMatch[1], 86400)
                    if (signedData?.signedUrl) displayUrl = signedData.signedUrl
                  }
                } catch { /* fall back to raw url */ }
              }
              photoMap.set(photo.id, { caption: photo.caption, photo_url: displayUrl })
            }
          }
        }

        const enriched: BuildingMemoryWithPhoto[] = rawMemories.map(m => ({
          ...m,
          photo_caption: m.photo_id ? photoMap.get(m.photo_id)?.caption : undefined,
          photo_url: m.photo_id ? photoMap.get(m.photo_id)?.photo_url : undefined,
        }))

        setMemories(enriched)
      } catch (err) {
        setError(err instanceof Error ? err : new Error('Failed to fetch memories'))
      } finally {
        setLoading(false)
      }
    }

    fetchMemories()
  }, [buildingId, refreshTrigger])

  return { memories, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}
