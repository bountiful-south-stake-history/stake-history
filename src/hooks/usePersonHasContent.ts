import { useState, useEffect } from 'react'
import { supabase } from '../lib/supabase'

export function usePersonHasContent(personId: string): boolean {
  const [hasContent, setHasContent] = useState(false)

  useEffect(() => {
    if (!personId) {
      setHasContent(false)
      return
    }

    async function checkContent() {
      try {
        const { data, error } = await supabase
          .from('people_with_content')
          .select('id')
          .eq('id', personId)
          .maybeSingle()

        setHasContent(!!data && !error)
      } catch {
        setHasContent(false)
      }
    }

    checkContent()
  }, [personId])

  return hasContent
}

