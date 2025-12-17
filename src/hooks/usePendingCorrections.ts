import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Correction } from '../lib/types'

export function usePendingCorrections() {
  const [corrections, setCorrections] = useState<Correction[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)
  const [refreshTrigger, setRefreshTrigger] = useState(0)

  const fetchCorrections = async () => {
    try {
      setLoading(true)
      setError(null)
      
      console.log('Fetching pending corrections from correction_requests table...')
      
      // First, fetch without ordering to see what columns exist
      let result = await supabase
        .from('correction_requests')
        .select(`
          *,
          person:people(id, full_name, display_name)
        `)
        .eq('status', 'pending')
      
      let data = result.data
      let fetchError = result.error

      // If join fails, try without join
      if (fetchError && (fetchError.code === 'PGRST116' || fetchError.message?.includes('relation') || fetchError.message?.includes('foreign key'))) {
        console.warn('Join failed, trying without person join:', fetchError.message)
        result = await supabase
          .from('correction_requests')
          .select('*')
          .eq('status', 'pending')
        
        data = result.data
        fetchError = result.error
      }

      // If we got data, try to order it (try different timestamp columns)
      if (!fetchError && data && data.length > 0) {
        console.log('Sample correction keys:', Object.keys(data[0]))
        
        // Try ordering by submitted_at first (matches memories/photos pattern)
        const orderedResult = await supabase
          .from('correction_requests')
          .select(fetchError ? '*' : `*, person:people(id, full_name, display_name)`)
          .eq('status', 'pending')
          .order('submitted_at', { ascending: false })
        
        if (!orderedResult.error) {
          data = orderedResult.data
        } else {
          // Try created_at as fallback
          const createdOrderResult = await supabase
            .from('correction_requests')
            .select(fetchError ? '*' : `*, person:people(id, full_name, display_name)`)
            .eq('status', 'pending')
            .order('created_at', { ascending: false })
          
          if (!createdOrderResult.error) {
            data = createdOrderResult.data
          }
          // If both fail, just use unordered data
        }
      }

      if (fetchError) {
        console.error('Corrections fetch error:', fetchError)
        console.error('Error code:', fetchError.code)
        console.error('Error message:', fetchError.message)
        console.error('Error details:', fetchError.details)
        console.error('Error hint:', fetchError.hint)
        throw fetchError
      }
      
      console.log('Fetched corrections successfully:', data?.length || 0, 'items')
      setCorrections(data || [])
    } catch (err) {
      console.error('Failed to fetch pending corrections:', err)
      const errorMessage = err instanceof Error ? err.message : 'Failed to fetch pending corrections'
      setError(new Error(errorMessage))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchCorrections()
  }, [refreshTrigger])

  return { corrections, loading, error, refetch: () => setRefreshTrigger(prev => prev + 1) }
}

