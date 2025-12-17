import { useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../../hooks/useAuth'
import { useAdmin } from '../../hooks/useAdmin'
import { AuthModal } from '../auth/AuthModal'
import { UserMenu } from '../auth/UserMenu'

export function Header() {
  const { user, loading } = useAuth()
  const { isAdmin } = useAdmin()
  const [showAuthModal, setShowAuthModal] = useState(false)

  return (
    <header className="bg-primary-700 text-white shadow-md">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <Link to="/" className="text-2xl font-bold hover:text-accent-100 transition-colors">
            Bountiful Utah South Stake History
          </Link>
          <nav className="flex items-center gap-6">
            <Link to="/" className="hover:text-accent-100 transition-colors">
              Home
            </Link>
            <Link to="/about" className="hover:text-accent-100 transition-colors">
              About
            </Link>
            {!loading && isAdmin && (
              <Link to="/admin" className="text-red-400 hover:text-red-300 transition-colors">
                Admin
              </Link>
            )}
            {!loading && (
              <>
                {user ? (
                  <UserMenu user={user} />
                ) : (
                  <button
                    onClick={() => setShowAuthModal(true)}
                    className="hover:text-accent-100 transition-colors"
                  >
                    Sign In
                  </button>
                )}
              </>
            )}
          </nav>
        </div>
      </div>

      {showAuthModal && (
        <AuthModal
          onClose={() => setShowAuthModal(false)}
          onSuccess={() => setShowAuthModal(false)}
        />
      )}
    </header>
  )
}

