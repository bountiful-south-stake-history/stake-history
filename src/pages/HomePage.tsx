import { useEffect } from 'react'
import { getPeopleCount } from '../hooks/usePeople'
import { useOrganizations } from '../hooks/useOrganizations'
import { OrgChart } from '../components/visualization/OrgChart'
import { PersonSearch } from '../components/search/PersonSearch'

export function HomePage() {
  const { organizations, loading, error } = useOrganizations()

  useEffect(() => {
    async function checkConnection() {
      try {
        const count = await getPeopleCount()
        console.log(`✅ Supabase connection successful! People count: ${count}`)
      } catch (err) {
        console.error('❌ Supabase connection failed:', err)
      }
    }
    checkConnection()
  }, [])

  return (
    <div>
      <div className="text-center mb-8">
        <h1 className="text-4xl font-bold text-primary-700 mb-2">
          Stake Leadership History
        </h1>
        <p className="text-lg text-gray-500 mb-1">
          1958 to Present
        </p>
        <p className="text-sm text-[#6b7280] italic">
          Click any organization to view leadership history
        </p>
      </div>

      <PersonSearch />

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4">
          Error loading organizations: {error.message}
        </div>
      )}

      <OrgChart organizations={organizations} loading={loading} />
    </div>
  )
}

