import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePeople } from '../../hooks/usePeople'

interface AdminPeopleTabProps {
  onActionComplete?: () => void
}

export function AdminPeopleTab({ onActionComplete }: AdminPeopleTabProps) {
  const { people, loading, error } = usePeople()
  const [editingId, setEditingId] = useState<string | null>(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [processing, setProcessing] = useState<string | null>(null)
  
  const [editData, setEditData] = useState({
    full_name: '',
    display_name: '',
    suffix: '',
    birth_date: '',
    death_date: '',
    bio: '',
  })

  const filteredPeople = people.filter((person) =>
    (person.full_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      person.display_name?.toLowerCase().includes(searchTerm.toLowerCase())) &&
    !person.redacted
  )

  const startEdit = (person: typeof people[0]) => {
    setEditingId(person.id)
    setEditData({
      full_name: person.full_name || '',
      display_name: person.display_name || '',
      suffix: person.suffix || '',
      birth_date: person.birth_date || '',
      death_date: person.death_date || '',
      bio: person.bio || '',
    })
  }

  const cancelEdit = () => {
    setEditingId(null)
    setEditData({
      full_name: '',
      display_name: '',
      suffix: '',
      birth_date: '',
      death_date: '',
      bio: '',
    })
  }

  const handleSave = async (personId: string) => {
    setProcessing(personId)
    try {
      const updateData: any = {}
      
      if (editData.full_name.trim()) updateData.full_name = editData.full_name.trim()
      if (editData.display_name.trim()) updateData.display_name = editData.display_name.trim()
      if (editData.suffix.trim()) updateData.suffix = editData.suffix.trim()
      if (editData.birth_date) updateData.birth_date = editData.birth_date || null
      if (editData.death_date) updateData.death_date = editData.death_date || null
      if (editData.bio.trim()) updateData.bio = editData.bio.trim()

      const { error: updateError } = await supabase
        .from('people')
        .update(updateData)
        .eq('id', personId)

      if (updateError) throw updateError
      
      setEditingId(null)
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update person')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading people...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  return (
    <div>
      <div className="mb-4">
        <input
          type="text"
          placeholder="Search by name..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full md:w-96 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
        />
      </div>

      <div className="bg-white rounded-lg shadow-md border border-gray-200 overflow-hidden">
        <div className="hidden md:block overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Original Name</th>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Corrected Name</th>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {filteredPeople.map((person) => {
                const isEditing = editingId === person.id
                return (
                  <tr key={person.id} className="hover:bg-gray-50">
                    {isEditing ? (
                      <>
                        <td className="px-4 py-3">
                          <input
                            type="text"
                            value={editData.full_name}
                            onChange={(e) => setEditData({ ...editData, full_name: e.target.value })}
                            className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                            placeholder="Full name"
                          />
                        </td>
                        <td className="px-4 py-3">
                          <input
                            type="text"
                            value={editData.display_name}
                            onChange={(e) => setEditData({ ...editData, display_name: e.target.value })}
                            className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                            placeholder="Display name"
                          />
                        </td>
                        <td className="px-4 py-3">
                          <div className="flex gap-2">
                            <button
                              onClick={() => handleSave(person.id)}
                              disabled={processing === person.id}
                              className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                            >
                              Save
                            </button>
                            <button
                              onClick={cancelEdit}
                              className="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm"
                            >
                              Cancel
                            </button>
                          </div>
                        </td>
                      </>
                    ) : (
                      <>
                        <td className="px-4 py-3 text-sm text-gray-900">
                          <Link
                            to={`/person/${person.id}`}
                            className="text-primary-600 hover:text-primary-700 hover:underline"
                          >
                            {person.full_name}
                          </Link>
                        </td>
                        <td className="px-4 py-3 text-sm text-gray-600">{person.display_name || '-'}</td>
                        <td className="px-4 py-3">
                          <button
                            onClick={() => startEdit(person)}
                            className="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm"
                          >
                            Edit
                          </button>
                        </td>
                      </>
                    )}
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>

        <div className="md:hidden divide-y divide-gray-200">
          {filteredPeople.map((person) => {
            const isEditing = editingId === person.id
            return (
              <div key={person.id} className="p-4">
                {isEditing ? (
                  <>
                    <div className="mb-3">
                      <label className="text-xs text-gray-500 uppercase">Original Name</label>
                      <input
                        type="text"
                        value={editData.full_name}
                        onChange={(e) => setEditData({ ...editData, full_name: e.target.value })}
                        className="w-full mt-1 px-3 py-2 border border-gray-300 rounded text-sm"
                        placeholder="Full name"
                      />
                    </div>
                    <div className="mb-3">
                      <label className="text-xs text-gray-500 uppercase">Corrected Name</label>
                      <input
                        type="text"
                        value={editData.display_name}
                        onChange={(e) => setEditData({ ...editData, display_name: e.target.value })}
                        className="w-full mt-1 px-3 py-2 border border-gray-300 rounded text-sm"
                        placeholder="Display name"
                      />
                    </div>
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleSave(person.id)}
                        disabled={processing === person.id}
                        className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                      >
                        Save
                      </button>
                      <button
                        onClick={cancelEdit}
                        className="px-3 py-1 border border-gray-300 rounded hover:bg-gray-50 text-sm"
                      >
                        Cancel
                      </button>
                    </div>
                  </>
                ) : (
                  <>
                    <div className="mb-2">
                      <Link
                        to={`/person/${person.id}`}
                        className="text-base font-medium text-primary-600 hover:text-primary-700 hover:underline"
                      >
                        {person.full_name}
                      </Link>
                    </div>
                    <div className="mb-3">
                      <span className="text-xs text-gray-500">Corrected: </span>
                      <span className="text-sm text-gray-900">{person.display_name || '-'}</span>
                    </div>
                    <div>
                      <button
                        onClick={() => startEdit(person)}
                        className="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm"
                      >
                        Edit
                      </button>
                    </div>
                  </>
                )}
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}

