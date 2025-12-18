import { useState, useEffect, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { usePeopleSearch } from '../../hooks/usePeopleSearch'
import { supabase } from '../../lib/supabase'
import type { Person, Calling, Position, Organization } from '../../lib/types'

interface PersonWithCalling extends Person {
  mostRecentCalling?: {
    organization: Organization
    position: Position
    sustained_date: string
  }
}

export function PersonSearch() {
  const [searchTerm, setSearchTerm] = useState('')
  const [showDropdown, setShowDropdown] = useState(false)
  const [peopleWithCallings, setPeopleWithCallings] = useState<PersonWithCalling[]>([])
  const searchRef = useRef<HTMLDivElement>(null)
  const navigate = useNavigate()
  const { people, loading } = usePeopleSearch(searchTerm)

  useEffect(() => {
    if (people.length === 0) {
      setPeopleWithCallings([])
      return
    }

    const fetchCallings = async () => {
      const peopleIds = people.map((p) => p.id)
      
      const { data: callingsData, error } = await supabase
        .from('callings')
        .select(`
          *,
          position:positions(*),
          organization:organizations(*)
        `)
        .in('person_id', peopleIds)
        .order('sustained_date', { ascending: false })

      if (error) {
        console.error('Error fetching callings:', error)
        setPeopleWithCallings(people.map((p) => ({ ...p })))
        return
      }

      const callingsByPerson = new Map<string, Calling & { position?: Position; organization?: Organization }>()
      callingsData?.forEach((calling: any) => {
        if (!callingsByPerson.has(calling.person_id)) {
          callingsByPerson.set(calling.person_id, calling)
        }
      })

      const enriched = people.map((person) => {
        const mostRecent = callingsByPerson.get(person.id)
        return {
          ...person,
          mostRecentCalling:
            mostRecent && mostRecent.organization && mostRecent.position
              ? {
                  organization: mostRecent.organization,
                  position: mostRecent.position,
                  sustained_date: mostRecent.sustained_date,
                }
              : undefined,
        }
      })

      setPeopleWithCallings(enriched)
    }

    fetchCallings()
  }, [people])

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
        setShowDropdown(false)
      }
    }

    const handleEscape = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setShowDropdown(false)
      }
    }

    if (showDropdown) {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('keydown', handleEscape)
      return () => {
        document.removeEventListener('mousedown', handleClickOutside)
        document.removeEventListener('keydown', handleEscape)
      }
    }
  }, [showDropdown])

  const handlePersonClick = (personId: string) => {
    navigate(`/person/${personId}`)
    setSearchTerm('')
    setShowDropdown(false)
  }

  const displayResults = peopleWithCallings.slice(0, 10)

  return (
    <div ref={searchRef} className="relative w-full max-w-sm mx-auto mb-6 md:mb-8">
      <div className="relative">
        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <svg
            className="h-5 w-5 text-gray-400"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>
        <input
          type="text"
          value={searchTerm}
          onChange={(e) => {
            setSearchTerm(e.target.value)
            setShowDropdown(true)
          }}
          onFocus={() => {
            if (searchTerm && displayResults.length > 0) {
              setShowDropdown(true)
            }
          }}
          placeholder="Search for a person..."
          className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent text-gray-900 bg-white"
        />
      </div>

      {showDropdown && searchTerm.length >= 2 && (
        <div className="absolute z-10 w-full mt-2 bg-white border border-gray-300 rounded-lg shadow-lg max-h-96 overflow-auto">
          {loading ? (
            <div className="px-4 py-3 text-gray-500 text-center">Searching...</div>
          ) : displayResults.length === 0 ? (
            <div className="px-4 py-3 text-gray-500 text-center">No results found</div>
          ) : (
            <>
              {displayResults.map((person) => (
                <button
                  key={person.id}
                  onClick={() => handlePersonClick(person.id)}
                  className="w-full text-left px-4 py-3 hover:bg-gray-50 border-b border-gray-100 last:border-0 transition-colors"
                >
                  <div className="font-medium text-gray-900">
                    {person.display_name || person.full_name}
                  </div>
                  {person.mostRecentCalling && (
                    <div className="text-sm text-gray-600 mt-1">
                      {person.mostRecentCalling.position?.title} • {person.mostRecentCalling.organization?.name}
                    </div>
                  )}
                </button>
              ))}
            </>
          )}
        </div>
      )}
    </div>
  )
}

