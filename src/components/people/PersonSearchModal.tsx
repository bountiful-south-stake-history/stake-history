import { useState, useEffect, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { FaTimes } from 'react-icons/fa'
import { supabase } from '../../lib/supabase'

interface PersonResult {
  id: string
  full_name: string
  display_name: string | null
  portrait_url: string | null
  portrait_pending: boolean | null
}

interface Props {
  onClose: () => void
}

export function PersonSearchModal({ onClose }: Props) {
  const navigate = useNavigate()
  const [query, setQuery] = useState('')
  const [results, setResults] = useState<PersonResult[]>([])
  const [loading, setLoading] = useState(false)
  const [searched, setSearched] = useState(false)
  const inputRef = useRef<HTMLInputElement>(null)
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  // Escape key to close
  useEffect(() => {
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    document.addEventListener('keydown', handler)
    return () => document.removeEventListener('keydown', handler)
  }, [onClose])

  // Debounced search
  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current)

    const trimmed = query.trim()
    if (!trimmed) {
      setResults([])
      setSearched(false)
      return
    }

    debounceRef.current = setTimeout(async () => {
      setLoading(true)
      try {
        const { data } = await supabase
          .from('people')
          .select('id, full_name, display_name, portrait_url, portrait_pending')
          .ilike('full_name', `%${trimmed}%`)
          .eq('redacted', false)
          .order('full_name', { ascending: true })
          .limit(10)
        setResults(data ?? [])
        setSearched(true)
      } finally {
        setLoading(false)
      }
    }, 300)

    return () => {
      if (debounceRef.current) clearTimeout(debounceRef.current)
    }
  }, [query])

  const handleSelect = (person: PersonResult) => {
    navigate(`/person/${person.id}`)
    onClose()
  }

  const showPortrait = (p: PersonResult) => p.portrait_url && !p.portrait_pending

  return (
    <div
      className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-start justify-center pt-[10vh] p-4"
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white text-gray-900 rounded-xl shadow-xl w-full max-w-md animate-slideUp">
        {/* Header */}
        <div className="flex items-center justify-between p-5 border-b border-gray-100">
          <h2 className="text-base font-semibold text-gray-800">Add a Portrait, Photo, or Memory — Find a Person</h2>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600 transition-colors" aria-label="Close">
            <FaTimes />
          </button>
        </div>

        <div className="p-4">
          {/* Search input */}
          <input
            ref={inputRef}
            autoFocus
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search by name..."
            className="w-full border border-gray-300 rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
          />

          {/* Results / states */}
          <div className="mt-3">
            {!query.trim() && (
              <p className="text-sm text-gray-400 text-center py-4">
                Search by name to find someone to contribute to
              </p>
            )}

            {loading && (
              <p className="text-sm text-gray-400 text-center py-4">Searching...</p>
            )}

            {!loading && searched && results.length === 0 && (
              <div className="text-center py-4">
                <p className="text-sm text-gray-600 font-medium mb-1">No results found</p>
                <p className="text-xs text-gray-400">
                  Can't find who you're looking for? The person database is curated by admins — contact us if someone is missing.
                </p>
              </div>
            )}

            {!loading && results.length > 0 && (
              <ul className="space-y-1 max-h-64 overflow-y-auto">
                {results.map((person) => (
                  <li key={person.id}>
                    <button
                      onClick={() => handleSelect(person)}
                      className="w-full flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-gray-50 transition-colors text-left"
                    >
                      {/* Mini portrait / bubble head */}
                      <div className="w-10 h-[50px] rounded overflow-hidden flex-shrink-0 bg-gray-200">
                        {showPortrait(person) ? (
                          <img
                            src={person.portrait_url!}
                            alt={person.display_name || person.full_name}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <svg viewBox="0 0 80 100" fill="none" xmlns="http://www.w3.org/2000/svg" className="w-full h-full">
                            <rect width="80" height="100" fill="#E2E8F0" />
                            <circle cx="40" cy="32" r="16" fill="#94A3B8" />
                            <ellipse cx="40" cy="75" rx="24" ry="22" fill="#94A3B8" />
                          </svg>
                        )}
                      </div>
                      <span className="text-sm text-gray-800 font-medium">
                        {person.display_name || person.full_name}
                      </span>
                    </button>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
