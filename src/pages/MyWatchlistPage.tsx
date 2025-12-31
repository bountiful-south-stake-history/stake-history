import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useWatchedPeople } from '../hooks/useWatchedPeople'
import { useAuth } from '../hooks/useAuth'
import { usePersonCallings } from '../hooks/usePersonCallings'
import { WatchButton } from '../components/people/WatchButton'
import { AuthModal } from '../components/auth/AuthModal'
import { useWatchActivity } from '../hooks/useWatchActivity'
import { ActivityCard } from '../components/watchlist/ActivityCard'
import { formatCallingRange } from '../lib/utils'
import { supabase } from '../lib/supabase'
import type { Person } from '../lib/types'

export function MyWatchlistPage() {
  const { user, loading: authLoading } = useAuth()
  const { watchedPeople, isLoading, refetch } = useWatchedPeople()
  const { activities, isLoading: activitiesLoading, hasMore, loadMore } = useWatchActivity(10)
  const navigate = useNavigate()
  const [showAuthModal, setShowAuthModal] = useState(false)
  const [emailDigestEnabled, setEmailDigestEnabled] = useState(true)
  const [loadingEmailPref, setLoadingEmailPref] = useState(true)

  useEffect(() => {
    if (!authLoading && !user) {
      setShowAuthModal(true)
    }
  }, [authLoading, user])

  useEffect(() => {
    if (watchedPeople.length > 0) {
      refetch()
    }
  }, [])

  useEffect(() => {
    async function fetchEmailPreference() {
      if (!user) {
        setLoadingEmailPref(false)
        return
      }

      try {
        const { data, error } = await supabase
          .from('user_profiles')
          .select('weekly_digest_enabled')
          .eq('id', user.id)
          .maybeSingle()

        if (error) {
          if (error.code === '42703') {
            setLoadingEmailPref(false)
            return
          }
          throw error
        }

        if (data?.weekly_digest_enabled !== null && data?.weekly_digest_enabled !== undefined) {
          setEmailDigestEnabled(data.weekly_digest_enabled)
        }
      } catch (err) {
        console.error('Failed to fetch email preference:', err)
      } finally {
        setLoadingEmailPref(false)
      }
    }

    if (!authLoading && user) {
      fetchEmailPreference()
    }
  }, [user, authLoading])

  if (authLoading || isLoading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-lg text-gray-600">Loading...</div>
      </div>
    )
  }

  if (!user) {
    return (
      <>
        <div className="text-center py-12">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Sign In Required</h1>
          <p className="text-gray-600 mb-6">Please sign in to view your watchlist.</p>
          <button
            onClick={() => setShowAuthModal(true)}
            className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
          >
            Sign In
          </button>
        </div>
        {showAuthModal && (
          <AuthModal
            onClose={() => {
              setShowAuthModal(false)
              if (!user) {
                navigate('/')
              }
            }}
            onSuccess={() => {
              setShowAuthModal(false)
            }}
          />
        )}
      </>
    )
  }

  return (
    <div>
      <h1 className="text-3xl font-bold text-primary-700 mb-6">
        My Watchlist ({watchedPeople.length})
      </h1>

      {watchedPeople.length === 0 ? (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-8 text-center mb-8">
          <div className="mb-4">
            <svg
              className="w-16 h-16 text-gray-400 mx-auto"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
              />
            </svg>
          </div>
          <p className="text-lg text-gray-600 mb-2">
            Your watchlist is empty.
          </p>
          <p className="text-gray-500 mb-6">
            Visit a person's page and click the bell icon to get notified about new photos and memories!
          </p>
          <Link
            to="/"
            className="inline-block px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
          >
            Browse People
          </Link>
        </div>
      ) : (
        <div className="space-y-4 mb-8">
          {watchedPeople.map((person) => (
            <PersonWatchCard key={person.id} person={person} onUnwatch={refetch} />
          ))}
        </div>
      )}

      <div className="border-t border-gray-200 pt-8 mb-8">
        <h2 className="text-xl font-bold text-primary-700 mb-4">Recent Activity</h2>
        {activitiesLoading ? (
          <div className="text-center py-8">
            <div className="text-gray-600">Loading activity...</div>
          </div>
        ) : activities.length === 0 ? (
          <div className="bg-gray-50 border border-gray-200 rounded-lg p-6 text-center">
            <p className="text-gray-600">
              No recent activity for the people you're watching.
            </p>
          </div>
        ) : (
          <>
            <div className="space-y-3 mb-4">
              {activities.map((activity) => (
                <ActivityCard key={activity.id} activity={activity} />
              ))}
            </div>
            {hasMore && (
              <button
                onClick={loadMore}
                className="w-full py-2 px-4 border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors"
              >
                Load more...
              </button>
            )}
          </>
        )}
      </div>

      <div className="border-t border-gray-200 pt-6">
        <h2 className="text-xl font-bold text-primary-700 mb-4">Email Preferences</h2>
        <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200">
          <label className="flex items-start gap-3 cursor-pointer">
            <input
              type="checkbox"
              checked={emailDigestEnabled}
              onChange={async (e) => {
                const newValue = e.target.checked
                setEmailDigestEnabled(newValue)
                
                if (user) {
                  try {
                    const { error } = await supabase
                      .from('user_profiles')
                      .update({ weekly_digest_enabled: newValue })
                      .eq('id', user.id)

                    if (error) {
                      if (error.code === '42703') {
                        console.warn('weekly_digest_enabled column does not exist yet')
                      } else {
                        throw error
                      }
                    }
                  } catch (err) {
                    console.error('Failed to update email preference:', err)
                    setEmailDigestEnabled(!newValue)
                  }
                }
              }}
              disabled={loadingEmailPref}
              className="mt-1 w-5 h-5 text-primary-600 border-gray-300 rounded focus:ring-primary-500 disabled:opacity-50"
            />
            <div className="flex-1">
              <div className="font-semibold text-gray-900 mb-1">
                Send me weekly digest emails about my watchlist
              </div>
              <p className="text-sm text-gray-600">
                You'll receive updates about new photos and memories for the people you're watching.
              </p>
            </div>
          </label>
        </div>
      </div>
    </div>
  )
}

interface PersonWatchCardProps {
  person: Person
  onUnwatch: () => void
}

function PersonWatchCard({ person, onUnwatch }: PersonWatchCardProps) {
  const { callings } = usePersonCallings(person.id)
  
  const handleToggle = () => {
    onUnwatch()
  }

  const getPersonTitle = () => {
    if (callings.length === 0) return null
    const latestCalling = callings[0]
    const title = latestCalling.position?.title || ''
    const org = latestCalling.organization?.name || ''
    const dateRange = formatCallingRange(latestCalling)
    if (title && org) {
      return `${title}, ${org}${dateRange ? ` (${dateRange})` : ''}`
    }
    return title || org || null
  }

  const portraitUrl = person.portrait_url || person.photo_url

  return (
    <div className="bg-white rounded-lg shadow-md p-6 border border-gray-200 hover:shadow-lg transition-shadow">
      <div className="flex items-start gap-4">
        <Link
          to={`/person/${person.id}`}
          className="flex-shrink-0"
          onClick={(e) => e.stopPropagation()}
        >
          {portraitUrl ? (
            <img
              src={portraitUrl}
              alt={person.display_name || person.full_name}
              className="w-20 h-20 rounded-full object-cover border-2 border-gray-200"
            />
          ) : (
            <div className="w-20 h-20 rounded-full bg-gray-200 flex items-center justify-center border-2 border-gray-300">
              <svg
                className="w-10 h-10 text-gray-400"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                />
              </svg>
            </div>
          )}
        </Link>
        <div className="flex-1 min-w-0">
          <div className="flex items-start justify-between gap-4">
            <div className="flex-1 min-w-0">
              <Link
                to={`/person/${person.id}`}
                className="text-xl font-bold text-primary-700 hover:text-primary-800 hover:underline"
                onClick={(e) => e.stopPropagation()}
              >
                {person.display_name || person.full_name}
              </Link>
              {getPersonTitle() && (
                <p className="text-sm text-gray-600 mt-1">{getPersonTitle()}</p>
              )}
            </div>
            <WatchButton
              personId={person.id}
              personName={person.display_name || person.full_name}
              onToggle={handleToggle}
            />
          </div>
        </div>
      </div>
    </div>
  )
}
