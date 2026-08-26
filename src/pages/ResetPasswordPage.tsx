import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabase'

type Mode = 'checking' | 'request' | 'set' | 'done' | 'expired'

export function ResetPasswordPage() {
  // 'checking' until we know whether a recovery session exists, so we never
  // flash the "request a link" form at a user who arrived via a valid link.
  const [mode, setMode] = useState<Mode>('checking')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirmPassword, setShowConfirmPassword] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [message, setMessage] = useState<string | null>(null)

  const validateEmail = (value: string): boolean => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)
  }

  // Mode detection has to survive a timing race. With detectSessionInUrl (the
  // v2 default) the client parses the recovery token out of the URL hash very
  // early on load and then strips the fragment. Depending on ordering, that can
  // happen *before* an onAuthStateChange listener mounts here — so a listener
  // alone can miss the PASSWORD_RECOVERY event entirely. Conversely, if the
  // parse hasn't finished yet, getSession() alone can return null before the
  // recovery session lands. So we do both: check getSession() on mount for the
  // already-established case, AND register a listener for the case where the
  // event fires after we mount. A `settled` guard makes whichever wins idempotent
  // so we never handle the recovery twice or clobber a resolved mode.
  useEffect(() => {
    let settled = false

    const enterSetMode = () => {
      if (settled) return
      settled = true
      setMode('set')
    }

    // Supabase appends recovery *errors* (expired/invalid links) to the URL
    // hash as error=...&error_code=...&error_description=..., not to a session.
    // Detect that before anything else so we show a friendly message instead of
    // silently dropping the user into the request form.
    const hash = window.location.hash
    if (hash.includes('error')) {
      const params = new URLSearchParams(hash.replace(/^#/, ''))
      if (params.get('error') || params.get('error_code') || params.get('error_description')) {
        settled = true
        setMode('expired')
        return
      }
    }

    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (event === 'PASSWORD_RECOVERY' && session) {
        enterSetMode()
      }
    })

    // Covers the case where detectSessionInUrl already established the recovery
    // session before this effect ran (listener would never fire for it).
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session) {
        enterSetMode()
      } else if (!settled) {
        // No recovery session and no error in the URL: a bookmark or a direct
        // visit. Show the request form.
        settled = true
        setMode('request')
      }
    })

    return () => subscription.unsubscribe()
  }, [])

  const handleRequest = async (e: React.FormEvent) => {
    e.preventDefault()
    setError(null)
    setMessage(null)

    if (!email.trim()) {
      setError('Email is required')
      return
    }

    if (!validateEmail(email)) {
      setError('Please enter a valid email address')
      return
    }

    setLoading(true)

    try {
      const { error: resetError } = await supabase.auth.resetPasswordForEmail(email.trim(), {
        redirectTo: `${window.location.origin}/reset-password`,
      })

      if (resetError) throw resetError

      // Deliberately do not reveal whether the address has an account.
      setMessage(
        'If an account exists for that email, a password reset link is on its way. ' +
          'Please check your inbox (and your spam folder). The link is good for one hour.'
      )
      setEmail('')
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Something went wrong. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  const handleSetPassword = async (e: React.FormEvent) => {
    e.preventDefault()
    setError(null)
    setMessage(null)

    if (!password) {
      setError('Password is required')
      return
    }

    if (password.length < 6) {
      setError('Password must be at least 6 characters')
      return
    }

    if (password !== confirmPassword) {
      setError('Passwords do not match')
      return
    }

    setLoading(true)

    try {
      const { error: updateError } = await supabase.auth.updateUser({ password })

      if (updateError) throw updateError

      setMode('done')
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to update your password. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  const eyeIcon = (visible: boolean) =>
    visible ? (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.29 3.29m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"
        />
      </svg>
    ) : (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"
        />
      </svg>
    )

  const inputClass =
    'w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 text-gray-900 bg-white'
  const passwordInputClass =
    'w-full px-3 py-2 pr-10 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 text-gray-900 bg-white'
  const labelClass = 'block text-sm font-medium text-gray-700 mb-1'
  const primaryButtonClass =
    'flex-1 px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed'

  const renderHeading = (text: string) => (
    <h2 className="text-2xl font-bold text-primary-700 mb-6">{text}</h2>
  )

  const banners = (
    <>
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4">{error}</div>
      )}
      {message && (
        <div className="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded mb-4">{message}</div>
      )}
    </>
  )

  return (
    <div className="max-w-md mx-auto">
      <div className="bg-white rounded-lg shadow-xl">
        <div className="p-6">
          {mode === 'checking' && (
            <>
              {renderHeading('Reset Password')}
              <p className="text-gray-700">One moment...</p>
            </>
          )}

          {mode === 'set' && (
            <>
              {renderHeading('Choose a New Password')}
              <p className="text-gray-700 mb-6">
                Enter a new password for your account below. Make it at least 6 characters.
              </p>
              {banners}
              <form onSubmit={handleSetPassword} className="space-y-4">
                <div>
                  <label htmlFor="password" className={labelClass}>
                    New Password <span className="text-red-500">*</span>
                  </label>
                  <div className="relative">
                    <input
                      id="password"
                      type={showPassword ? 'text' : 'password'}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      className={passwordInputClass}
                      disabled={loading}
                      required
                      minLength={6}
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none"
                      tabIndex={-1}
                    >
                      {eyeIcon(showPassword)}
                    </button>
                  </div>
                </div>

                <div>
                  <label htmlFor="confirmPassword" className={labelClass}>
                    Confirm New Password <span className="text-red-500">*</span>
                  </label>
                  <div className="relative">
                    <input
                      id="confirmPassword"
                      type={showConfirmPassword ? 'text' : 'password'}
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      className={passwordInputClass}
                      disabled={loading}
                      required
                      minLength={6}
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700 focus:outline-none"
                      tabIndex={-1}
                    >
                      {eyeIcon(showConfirmPassword)}
                    </button>
                  </div>
                </div>

                <div className="flex gap-3">
                  <button type="submit" disabled={loading} className={primaryButtonClass}>
                    {loading ? 'Please wait...' : 'Update Password'}
                  </button>
                </div>
              </form>
            </>
          )}

          {mode === 'request' && (
            <>
              {renderHeading('Reset Password')}
              <p className="text-gray-700 mb-6">
                Enter the email address for your account and we'll send you a link to create a new password.
              </p>
              {banners}
              <form onSubmit={handleRequest} className="space-y-4">
                <div>
                  <label htmlFor="email" className={labelClass}>
                    Email <span className="text-red-500">*</span>
                  </label>
                  <input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className={inputClass}
                    disabled={loading}
                    required
                  />
                </div>

                <div className="flex gap-3">
                  <button type="submit" disabled={loading} className={primaryButtonClass}>
                    {loading ? 'Please wait...' : 'Send Reset Link'}
                  </button>
                  <Link
                    to="/"
                    className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 text-gray-700"
                  >
                    Cancel
                  </Link>
                </div>
              </form>
            </>
          )}

          {mode === 'expired' && (
            <>
              {renderHeading('Link Expired')}
              {banners}
              <p className="text-gray-700 mb-6">
                This password reset link is no longer valid. Reset links expire one hour after they're sent,
                and each one can only be used once. Please request a new link below.
              </p>
              <div className="flex gap-3">
                <button
                  type="button"
                  onClick={() => {
                    // Clear the error hash so we don't re-trigger expired mode,
                    // and drop the user into the request form.
                    window.history.replaceState(null, '', window.location.pathname)
                    setError(null)
                    setMessage(null)
                    setMode('request')
                  }}
                  className={primaryButtonClass}
                >
                  Request a New Link
                </button>
              </div>
            </>
          )}

          {mode === 'done' && (
            <>
              {renderHeading('Password Updated')}
              <div className="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded mb-6">
                Your password has been updated. You're now signed in.
              </div>
              <Link
                to="/"
                className="inline-block px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700"
              >
                Return to the site
              </Link>
            </>
          )}
        </div>
      </div>
    </div>
  )
}
