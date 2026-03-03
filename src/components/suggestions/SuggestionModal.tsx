import { useState, useEffect, useRef } from 'react'
import { FaLightbulb, FaTimes } from 'react-icons/fa'
import { supabase } from '../../lib/supabase'

const RATE_LIMIT_KEY = 'suggestion_last_submitted'
const RATE_LIMIT_MS = 30_000
const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

interface Props {
  onClose: () => void
}

export function SuggestionModal({ onClose }: Props) {
  const [suggestion, setSuggestion] = useState('')
  const [email, setEmail] = useState('')
  const [emailError, setEmailError] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [error, setError] = useState('')
  const [rateLimited, setRateLimited] = useState(false)
  const [rateLimitSecondsLeft, setRateLimitSecondsLeft] = useState(0)
  const closeTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  // Check rate limit on mount and tick countdown
  useEffect(() => {
    const checkRateLimit = () => {
      const last = localStorage.getItem(RATE_LIMIT_KEY)
      if (!last) return
      const elapsed = Date.now() - parseInt(last, 10)
      if (elapsed < RATE_LIMIT_MS) {
        setRateLimited(true)
        setRateLimitSecondsLeft(Math.ceil((RATE_LIMIT_MS - elapsed) / 1000))
      }
    }
    checkRateLimit()
    const interval = setInterval(() => {
      const last = localStorage.getItem(RATE_LIMIT_KEY)
      if (!last) { setRateLimited(false); return }
      const elapsed = Date.now() - parseInt(last, 10)
      if (elapsed >= RATE_LIMIT_MS) {
        setRateLimited(false)
        setRateLimitSecondsLeft(0)
      } else {
        setRateLimitSecondsLeft(Math.ceil((RATE_LIMIT_MS - elapsed) / 1000))
      }
    }, 1000)
    return () => clearInterval(interval)
  }, [])

  // Auto-close 3s after successful submission
  useEffect(() => {
    if (submitted) {
      closeTimerRef.current = setTimeout(onClose, 3000)
    }
    return () => {
      if (closeTimerRef.current) clearTimeout(closeTimerRef.current)
    }
  }, [submitted, onClose])

  // Escape key to close
  useEffect(() => {
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose() }
    document.addEventListener('keydown', handler)
    return () => document.removeEventListener('keydown', handler)
  }, [onClose])

  const validateEmail = () => {
    if (email && !EMAIL_REGEX.test(email)) {
      setEmailError('Please enter a valid email address')
    } else {
      setEmailError('')
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (rateLimited || !suggestion.trim()) return
    if (email && !EMAIL_REGEX.test(email)) {
      setEmailError('Please enter a valid email address')
      return
    }

    setSubmitting(true)
    setError('')
    try {
      const { error: insertError } = await supabase.from('suggestions').insert({
        suggestion: suggestion.trim(),
        email: email.trim() || null,
        page_url: window.location.href,
      })
      if (insertError) throw insertError
      localStorage.setItem(RATE_LIMIT_KEY, String(Date.now()))
      setSubmitted(true)
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div
      className="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center p-4"
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white rounded-xl shadow-xl w-full max-w-md animate-slideUp">
        {/* Header */}
        <div className="flex items-center justify-between p-5 border-b border-gray-100">
          <div className="flex items-center gap-2 text-accent-500">
            <FaLightbulb className="text-lg" />
            <h2 className="text-lg font-semibold text-gray-800">Share a Suggestion</h2>
          </div>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors"
            aria-label="Close"
          >
            <FaTimes />
          </button>
        </div>

        {submitted ? (
          /* Success state */
          <div className="p-6 text-center animate-fadeIn">
            <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-3">
              <FaLightbulb className="text-green-600 text-xl" />
            </div>
            <h3 className="text-base font-semibold text-gray-800 mb-1">Thanks for your suggestion!</h3>
            <p className="text-sm text-gray-500">We appreciate your feedback and will review it soon.</p>
          </div>
        ) : (
          /* Form */
          <form onSubmit={handleSubmit} className="p-5 space-y-4">
            <p className="text-sm text-gray-600">
              Have an idea for improvement? Something that could work better? Share it here!
            </p>

            <div>
              <textarea
                value={suggestion}
                onChange={(e) => setSuggestion(e.target.value)}
                placeholder="Describe your suggestion..."
                rows={4}
                required
                className="w-full border border-gray-300 rounded-lg px-3 py-2.5 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-accent-500 focus:border-transparent"
              />
            </div>

            <div>
              <input
                type="text"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                onBlur={validateEmail}
                placeholder="Email (optional — for follow-up)"
                className={`w-full border rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-accent-500 focus:border-transparent ${
                  emailError ? 'border-red-400' : 'border-gray-300'
                }`}
              />
              {emailError && <p className="text-xs text-red-500 mt-1">{emailError}</p>}
            </div>

            {error && <p className="text-sm text-red-500">{error}</p>}

            <div className="flex gap-3 pt-1">
              <button
                type="button"
                onClick={onClose}
                className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-sm text-gray-600 hover:bg-gray-50 transition-colors"
              >
                Cancel
              </button>
              <button
                type="submit"
                disabled={submitting || rateLimited || !suggestion.trim()}
                className="flex-1 px-4 py-2 bg-accent-500 hover:bg-accent-600 disabled:bg-gray-300 disabled:cursor-not-allowed text-white rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-2"
              >
                {rateLimited
                  ? `Please wait (${rateLimitSecondsLeft}s)`
                  : submitting
                  ? 'Submitting...'
                  : (
                    <>
                      <FaLightbulb className="text-xs" />
                      Submit
                    </>
                  )}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  )
}
