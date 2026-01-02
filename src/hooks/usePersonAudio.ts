import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export interface AudioClip {
  id: string
  person_id: string
  title: string
  audio_url: string
  event_context?: string
  approximate_date?: string
  description?: string
  created_at: string
}

export function usePersonAudio(personId: string) {
  const [audioClips, setAudioClips] = useState<AudioClip[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  useEffect(() => {
    if (!personId) {
      setIsLoading(false)
      return
    }

    const fetchAudioClips = async () => {
      try {
        setIsLoading(true)
        setError(null)

        const { data, error: fetchError } = await supabase
          .from('audio_clips')
          .select('*')
          .eq('person_id', personId)
          .order('approximate_date', { ascending: false, nullsFirst: false })
          .order('created_at', { ascending: false })

        if (fetchError) {
          if (fetchError.code === '42P01') {
            console.warn('audio_clips table does not exist yet')
            setAudioClips([])
            setIsLoading(false)
            return
          }
          throw fetchError
        }

        setAudioClips(data || [])
      } catch (err) {
        console.error('Failed to fetch audio clips:', err)
        setError(err instanceof Error ? err : new Error('Failed to fetch audio clips'))
        setAudioClips([])
      } finally {
        setIsLoading(false)
      }
    }

    fetchAudioClips()
  }, [personId])

  return { audioClips, isLoading, error }
}
