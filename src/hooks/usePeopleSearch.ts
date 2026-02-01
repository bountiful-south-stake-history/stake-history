import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'
import type { Person } from '../lib/types'

export function usePeopleSearch(searchTerm: string) {
  const [people, setPeople] = useState<Person[]>([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (!searchTerm || searchTerm.length < 2) {
      setPeople([])
      return
    }

    const searchPeople = async () => {
      setLoading(true)
      try {
        // Split search into words and join with wildcards for partial matching
        // "Gary Hill" becomes "%Gary%Hill%" to match "Gary R. Hill"
        const searchPattern = searchTerm.trim().split(/\s+/).join('%')
        
        const { data, error } = await supabase
          .from('people')
          .select('*')
          .or(`full_name.ilike.%${searchPattern}%,display_name.ilike.%${searchPattern}%`)
          .eq('redacted', false)
          .limit(10)
          .order('full_name')

        if (error) throw error
        setPeople(data || [])
      } catch (err) {
        console.error('Error searching people:', err)
        setPeople([])
      } finally {
        setLoading(false)
      }
    }

    const debounceTimer = setTimeout(() => {
      searchPeople()
    }, 300)

    return () => clearTimeout(debounceTimer)
  }, [searchTerm])

  return { people, loading }
}

