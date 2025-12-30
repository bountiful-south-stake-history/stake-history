import { useState } from 'react'
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
  const [selectedPersonIds, setSelectedPersonIds] = useState<string[]>([])
  const [showMemoryForm, setShowMemoryForm] = useState(false)
  const [showSuccess, setShowSuccess] = useState(false)

  const allSelected = selectedPersonIds.length === taggedPeople.length

  // If only one person, show form immediately
  const peopleForForm = taggedPeople.length === 1
    ? taggedPeople
    : selectedPersonIds.length > 0
    ? taggedPeople.filter((p) => selectedPersonIds.includes(p.id))
    : null

  const handleTogglePerson = (personId: string) => {
    setSelectedPersonIds((prev) =>
      prev.includes(personId)
        ? prev.filter((id) => id !== personId)
        : [...prev, personId]
    )
  }

  const handleToggleAll = () => {
    if (allSelected) {
      setSelectedPersonIds([])
    } else {
      setSelectedPersonIds(taggedPeople.map((p) => p.id))
    }
  }

  const handleContinue = () => {
    if (selectedPersonIds.length === 0) return
    setShowMemoryForm(true)
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

  // Single person: show form directly
  if (taggedPeople.length === 1) {
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
          {showSuccess ? (
            <div className="text-center py-8">
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
              <h3 className="text-xl font-bold text-gray-900 mb-2">Memory Submitted!</h3>
              <p className="text-gray-600">
                Your memory has been shared for {taggedPeople[0].display_name || taggedPeople[0].full_name}.
              </p>
            </div>
          ) : (
            <MultiPersonMemoryForm
              taggedPeople={taggedPeople}
              onSuccess={handleMemorySuccess}
              onCancel={onClose}
            />
          )}
        </div>
      </div>
    )
  }

  const formatNamesForHeader = (people: TaggedPerson[]): string => {
    const names = people.map((p) => p.display_name || p.full_name)
    if (names.length === 1) {
      return `${names[0]}'s page`
    } else if (names.length === 2) {
      return `${names[0]}'s and ${names[1]}'s pages`
    } else {
      const allButLast = names.slice(0, -1).map((n) => `${n}'s`).join(', ')
      const last = names[names.length - 1]
      return `${allButLast}, and ${last}'s pages`
    }
  }

  if (showSuccess) {
    const personCount = peopleForForm?.length || taggedPeople.length
    
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
              {peopleForForm
                ? `Your memory has been shared on ${formatNamesForHeader(peopleForForm)}.`
                : `Your memory has been shared for ${personCount} ${personCount === 1 ? 'person' : 'people'}.`}
            </p>
          </div>
        </div>
      </div>
    )
  }

  if (showMemoryForm && peopleForForm) {
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4 overflow-y-auto">
        <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full p-6 my-8">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-gray-900">Share a Memory</h2>
            <button
              onClick={() => {
                setShowMemoryForm(false)
                setSelectedPersonIds([])
              }}
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
            taggedPeople={peopleForForm}
            onSuccess={handleMemorySuccess}
            onCancel={() => {
              setShowMemoryForm(false)
              setSelectedPersonIds([])
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
        <p className="text-gray-600 mb-6">Who is this memory about? (select one or more)</p>

        <div className="space-y-2 mb-6">
          {taggedPeople.map((person) => (
            <label
              key={person.id}
              className="flex items-center p-3 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors"
            >
              <input
                type="checkbox"
                checked={selectedPersonIds.includes(person.id)}
                onChange={() => handleTogglePerson(person.id)}
                className="mr-3 h-4 w-4 text-primary-600 focus:ring-primary-500 rounded border-gray-300"
              />
              <span className="text-gray-900">
                {person.display_name || person.full_name}
              </span>
            </label>
          ))}
          <div className="border-t border-gray-200 my-2"></div>
          <label className="flex items-center p-3 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
            <input
              type="checkbox"
              checked={allSelected}
              onChange={handleToggleAll}
              className="mr-3 h-4 w-4 text-primary-600 focus:ring-primary-500 rounded border-gray-300"
            />
            <span className="text-gray-900">All people in this photo</span>
          </label>
        </div>

        {selectedPersonIds.length > 0 && (
          <div className="mb-4 p-3 bg-primary-50 border border-primary-200 rounded-lg">
            <p className="text-sm text-gray-700">
              This memory will be shared on {formatNamesForHeader(taggedPeople.filter((p) => selectedPersonIds.includes(p.id)))}.
            </p>
          </div>
        )}

        <div className="flex gap-3 justify-end">
          <button
            onClick={onClose}
            className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleContinue}
            disabled={selectedPersonIds.length === 0}
            className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Continue
          </button>
        </div>
      </div>
    </div>
  )
}

