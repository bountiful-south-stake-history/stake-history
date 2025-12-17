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
        const { data, error } = await supabase
          .from('people')
          .select('*')
          .or(`full_name.ilike.%${searchTerm}%,display_name.ilike.%${searchTerm}%`)
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

