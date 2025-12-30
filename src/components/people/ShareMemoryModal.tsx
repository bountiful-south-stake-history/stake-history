import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { MultiPersonMemoryForm } from './MultiPersonMemoryForm'

interface TaggedPerson {
  id: string
  display_name?: string
  full_name: string
}

interface ShareMemoryModalProps {
  taggedPeople: TaggedPerson[]
  onClose: () => void
}

export function ShareMemoryModal({ taggedPeople, onClose }: ShareMemoryModalProps) {
  const navigate = useNavigate()
  const [selectedPersonId, setSelectedPersonId] = useState<string | 'all' | null>(null)
  const [showMemoryForm, setShowMemoryForm] = useState(false)
  const [showSuccess, setShowSuccess] = useState(false)

  const handleContinue = () => {
    if (!selectedPersonId) return

    if (selectedPersonId === 'all') {
      // Show memory form for all people
      setShowMemoryForm(true)
    } else {
      // Navigate to selected person's page with memory form
      onClose()
      navigate(`/person/${selectedPersonId}?openMemory=true`)
    }
  }

  const handleMemorySuccess = () => {
    setShowSuccess(true)
    setTimeout(() => {
      onClose()
    }, 2000)
  }

  if (taggedPeople.length === 0) {
    // No tagged people - shouldn't happen, but handle gracefully
    return null
  }

  useEffect(() => {
    if (taggedPeople.length === 1) {
      // Single person - skip selection and navigate directly
      navigate(`/person/${taggedPeople[0].id}?openMemory=true`)
      onClose()
    }
  }, [taggedPeople, navigate, onClose])

  if (taggedPeople.length === 1) {
    // Don't render modal for single person - useEffect handles navigation
    return null
  }

  if (showSuccess) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
          <div className="text-center">
            <div className="mb-4">
              <svg
                className="w-16 h-16 text-green-500 mx-auto"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M5 13l4 4L19 7"
                />
              </svg>
            </div>
            <h2 className="text-2xl font-bold text-gray-900 mb-2">Memory Submitted!</h2>
            <p className="text-gray-600">
              Your memory has been shared for all {taggedPeople.length} people in this photo.
            </p>
          </div>
        </div>
      </div>
    )
  }

  if (showMemoryForm) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 overflow-y-auto">
        <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full p-6 my-8">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-gray-900">Share a Memory</h2>
            <button
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600 transition-colors"
              aria-label="Close"
            >
              <svg
                className="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
          <MultiPersonMemoryForm
            taggedPeople={taggedPeople}
            onSuccess={handleMemorySuccess}
            onCancel={() => {
              setShowMemoryForm(false)
              setSelectedPersonId(null)
            }}
          />
        </div>
      </div>
    )
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">Share a Memory</h2>
        <p className="text-gray-600 mb-6">Who is this memory about?</p>

        <div className="space-y-2 mb-6">
          {taggedPeople.map((person) => (
            <label
              key={person.id}
              className="flex items-center p-3 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors"
            >
              <input
                type="radio"
                name="person"
                value={person.id}
                checked={selectedPersonId === person.id}
                onChange={() => setSelectedPersonId(person.id)}
                className="mr-3 h-4 w-4 text-primary-600 focus:ring-primary-500"
              />
              <span className="text-gray-900">
                {person.display_name || person.full_name}
              </span>
            </label>
          ))}
          <div className="border-t border-gray-200 my-2"></div>
          <label className="flex items-center p-3 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
            <input
              type="radio"
              name="person"
              value="all"
              checked={selectedPersonId === 'all'}
              onChange={() => setSelectedPersonId('all')}
              className="mr-3 h-4 w-4 text-primary-600 focus:ring-primary-500"
            />
            <span className="text-gray-900">All people in this photo</span>
          </label>
        </div>

        <div className="flex gap-3 justify-end">
          <button
            onClick={onClose}
            className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleContinue}
            disabled={!selectedPersonId}
            className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Continue
          </button>
        </div>
      </div>
    </div>
  )
}

