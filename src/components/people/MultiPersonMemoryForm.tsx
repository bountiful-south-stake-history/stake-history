import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'

interface TaggedPerson {
  id: string
  display_name?: string
  full_name: string
}

interface MultiPersonMemoryFormProps {
  taggedPeople: TaggedPerson[]
  onSuccess: () => void
  onCancel: () => void
}

const relationshipOptions = [
  { value: 'family', label: 'Family Member' },
  { value: 'friend', label: 'Friend' },
  { value: 'served_together', label: 'Served Together' },
  { value: 'ward_member', label: 'Ward Member' },
  { value: 'other', label: 'Other' },
]

const MAX_MEMORY_LENGTH = 5000

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

export function MultiPersonMemoryForm({ taggedPeople, onSuccess, onCancel }: MultiPersonMemoryFormProps) {
  const { user } = useAuth()
  const [relationship, setRelationship] = useState('')
  const [timePeriod, setTimePeriod] = useState('')
  const [memoryContent, setMemoryContent] = useState('')
  const [submitterName, setSubmitterName] = useState('')
  const [submitterEmail, setSubmitterEmail] = useState('')
  const [submitterPhone, setSubmitterPhone] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [hasAutoPopulated, setHasAutoPopulated] = useState(false)

  useEffect(() => {
    if (user && !hasAutoPopulated) {
      const autoPopulate = async () => {
        if (user.email) {
          setSubmitterEmail((prev) => (!prev.trim() ? user.email || '' : prev))
        }

        try {
          const { data, error } = await supabase
            .from('user_profiles')
            .select('display_name')
            .eq('id', user.id)
            .single()

          if (!error && data?.display_name) {
            setSubmitterName((prev) => (!prev.trim() ? data.display_name : prev))
          }
        } catch (err) {
          console.warn('Failed to fetch user profile:', err)
        }

        setHasAutoPopulated(true)
      }

      autoPopulate()
    }
  }, [user, hasAutoPopulated])

  const validateForm = () => {
    if (!submitterName.trim()) {
      setError('Please enter your name')
      return false
    }
    if (!submitterEmail.trim()) {
      setError('Please enter your email')
      return false
    }
    if (!memoryContent.trim()) {
      setError('Please share your memory')
      return false
    }
    if (memoryContent.length > MAX_MEMORY_LENGTH) {
      setError(`Memory must be ${MAX_MEMORY_LENGTH} characters or less`)
      return false
    }
    return true
  }

  const handleSubmit = async () => {
    if (!validateForm()) {
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      const relationshipValue = relationship && relationship.trim() ? relationship.trim() : null
      const timePeriodValue = (timePeriod && typeof timePeriod === 'string' && timePeriod.trim())
        ? timePeriod.trim()
        : null

      const memoryData = {
        content: memoryContent,
        submitter_name: submitterName,
        submitter_email: submitterEmail,
        submitter_phone: submitterPhone && submitterPhone.trim() ? submitterPhone.trim() : null,
        relationship: relationshipValue,
        time_period: timePeriodValue,
        status: 'pending' as const,
      }

      // Create a memory for each tagged person with identical content
      const memoryPromises = taggedPeople.map((person) =>
        supabase.from('memories').insert({
          ...memoryData,
          person_id: person.id,
        })
      )

      const results = await Promise.allSettled(memoryPromises)
      const errors = results.filter((result) => result.status === 'rejected' || (result.status === 'fulfilled' && result.value.error))
      
      if (errors.length > 0) {
        // If all failed, show error. If some succeeded, still show success but log warning
        if (errors.length === taggedPeople.length) {
          throw new Error('Failed to submit memory. Please try again.')
        } else {
          console.warn(`Failed to submit memory for ${errors.length} of ${taggedPeople.length} people`)
        }
      }

      onSuccess()
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit memory')
      setSubmitting(false)
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h3 className="text-lg font-semibold text-gray-900 mb-2">
          Share a Memory About This Photo
        </h3>
        <p className="text-sm text-gray-600 mb-4">
          This memory will be shared on {formatNamesForHeader(taggedPeople)}.
        </p>
      </div>

      {error && (
        <div className="px-4 py-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
          {error}
        </div>
      )}

      <div className="space-y-4">
        <div>
          <label htmlFor="relationship" className="block text-sm font-medium text-gray-700 mb-1">
            Your Relationship
          </label>
          <select
            id="relationship"
            value={relationship}
            onChange={(e) => setRelationship(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
            disabled={submitting}
          >
            <option value="">Select relationship...</option>
            {relationshipOptions.map((opt) => (
              <option key={opt.value} value={opt.value}>
                {opt.label}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label htmlFor="timePeriod" className="block text-sm font-medium text-gray-700 mb-1">
            Time Period <span className="text-gray-500 font-normal">(optional)</span>
          </label>
          <input
            type="text"
            id="timePeriod"
            value={timePeriod}
            onChange={(e) => setTimePeriod(e.target.value)}
            placeholder="e.g., When he was bishop 1985-1990"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
            disabled={submitting}
          />
        </div>

        <div>
          <label htmlFor="memoryContent" className="block text-sm font-medium text-gray-700 mb-1">
            Memory / Story <span className="text-red-600">*</span>
          </label>
          <textarea
            id="memoryContent"
            value={memoryContent}
            onChange={(e) => {
              const value = e.target.value
              if (value.length <= MAX_MEMORY_LENGTH) {
                setMemoryContent(value)
                if (error && error.includes('Memory must be')) {
                  setError(null)
                }
              }
            }}
            onBlur={() => {
              if (!memoryContent.trim()) {
                setError('Please share your memory')
              }
            }}
            rows={8}
            className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
              error && error.includes('memory') ? 'border-red-300' : 'border-gray-300'
            }`}
            disabled={submitting}
            placeholder="Share your memory or story about this photo..."
          />
          <div className="flex justify-between items-center mt-1">
            <p className="text-xs text-gray-500">
              This memory will appear on each person's page
            </p>
            <p className={`text-sm ml-auto ${memoryContent.length > MAX_MEMORY_LENGTH ? 'text-red-600' : 'text-gray-500'}`}>
              {memoryContent.length} / {MAX_MEMORY_LENGTH}
            </p>
          </div>
        </div>
      </div>

      <div className="border-t border-gray-200 pt-6">
        <h3 className="text-lg font-semibold text-gray-900 mb-4">Submitter Information</h3>
        <div className="space-y-4">
          <div>
            <label htmlFor="submitterName" className="block text-sm font-medium text-gray-700 mb-1">
              Your Name <span className="text-red-600">*</span>
            </label>
            <input
              type="text"
              id="submitterName"
              value={submitterName}
              onChange={(e) => {
                setSubmitterName(e.target.value)
                if (error && error.includes('name')) {
                  setError(null)
                }
              }}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                error && error.includes('name') ? 'border-red-300' : 'border-gray-300'
              }`}
              disabled={submitting}
            />
          </div>

          <div>
            <label htmlFor="submitterEmail" className="block text-sm font-medium text-gray-700 mb-1">
              Your Email <span className="text-red-600">*</span>
            </label>
            <input
              type="email"
              id="submitterEmail"
              value={submitterEmail}
              onChange={(e) => {
                setSubmitterEmail(e.target.value)
                if (error && error.includes('email')) {
                  setError(null)
                }
              }}
              className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                error && error.includes('email') ? 'border-red-300' : 'border-gray-300'
              }`}
              disabled={submitting}
            />
          </div>

          <div>
            <label htmlFor="submitterPhone" className="block text-sm font-medium text-gray-700 mb-1">
              Your Phone <span className="text-gray-500 font-normal">(optional)</span>
            </label>
            <input
              type="tel"
              id="submitterPhone"
              value={submitterPhone}
              onChange={(e) => setSubmitterPhone(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
              disabled={submitting}
            />
          </div>

          <p className="text-xs text-gray-500 italic">
            We may contact you if there are questions about this submission
          </p>
        </div>
      </div>

      <div className="flex gap-3 justify-end pt-4 border-t border-gray-200">
        <button
          onClick={onCancel}
          disabled={submitting}
          className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Cancel
        </button>
        <button
          onClick={handleSubmit}
          disabled={submitting}
          className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
        >
          {submitting ? (
            <>
              <svg
                className="animate-spin h-4 w-4 text-white"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  className="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  strokeWidth="4"
                />
                <path
                  className="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                />
              </svg>
              Submitting...
            </>
          ) : (
            'Submit Memory'
          )}
        </button>
      </div>
    </div>
  )
}

