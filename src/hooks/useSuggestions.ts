import { useState, useEffect, useCallback } from 'react'
import { supabase } from '../lib/supabase'

export interface Suggestion {
  id: string
  suggestion: string
  email: string | null
  page_url: string | null
  status: 'new' | 'in_review' | 'resolved' | 'dismissed'
  admin_notes: string | null
  created_at: string
  updated_at: string
}

export function useSuggestions(statusFilter?: string) {
  const [suggestions, setSuggestions] = useState<Suggestion[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<Error | null>(null)

  const fetchSuggestions = useCallback(async () => {
    setLoading(true)
    try {
      let query = supabase
        .from('suggestions')
        .select('*')
        .order('created_at', { ascending: false })

      if (statusFilter && statusFilter !== 'all') {
        query = query.eq('status', statusFilter)
      }

      const { data, error } = await query
      if (error) throw error
      setSuggestions(data ?? [])
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch suggestions'))
    } finally {
      setLoading(false)
    }
  }, [statusFilter])

  useEffect(() => {
    fetchSuggestions()
  }, [fetchSuggestions])

  const updateSuggestion = async (id: string, updates: { status?: string; admin_notes?: string }) => {
    const { error } = await supabase
      .from('suggestions')
      .update(updates)
      .eq('id', id)
    if (error) throw error
    await fetchSuggestions()
  }

  const deleteSuggestion = async (id: string) => {
    const { error } = await supabase
      .from('suggestions')
      .delete()
      .eq('id', id)
    if (error) throw error
    await fetchSuggestions()
  }

  return { suggestions, loading, error, refetch: fetchSuggestions, updateSuggestion, deleteSuggestion }
}
