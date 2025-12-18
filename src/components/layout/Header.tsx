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
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

  return (
    <header className="bg-primary-700 text-white shadow-md">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <Link 
            to="/" 
            className="text-xl md:text-2xl font-bold font-serif hover:text-accent-100 transition-colors leading-tight"
          >
            Bountiful Utah South Stake History
          </Link>
          
          <nav className="hidden md:flex items-center gap-6">
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

          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="md:hidden p-2 hover:bg-primary-600 rounded transition-colors"
            aria-label="Toggle menu"
          >
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              {mobileMenuOpen ? (
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M6 18L18 6M6 6l12 12"
                />
              ) : (
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M4 6h16M4 12h16M4 18h16"
                />
              )}
            </svg>
          </button>
        </div>

        {mobileMenuOpen && (
          <nav className="md:hidden mt-4 pb-2 border-t border-primary-600 pt-4">
            <div className="flex flex-col gap-4">
              <Link
                to="/"
                onClick={() => setMobileMenuOpen(false)}
                className="hover:text-accent-100 transition-colors"
              >
                Home
              </Link>
              <Link
                to="/about"
                onClick={() => setMobileMenuOpen(false)}
                className="hover:text-accent-100 transition-colors"
              >
                About
              </Link>
              {!loading && isAdmin && (
                <Link
                  to="/admin"
                  onClick={() => setMobileMenuOpen(false)}
                  className="text-red-400 hover:text-red-300 transition-colors"
                >
                  Admin
                </Link>
              )}
              {!loading && (
                <>
                  {user ? (
                    <div onClick={() => setMobileMenuOpen(false)}>
                      <UserMenu user={user} />
                    </div>
                  ) : (
                    <button
                      onClick={() => {
                        setShowAuthModal(true)
                        setMobileMenuOpen(false)
                      }}
                      className="text-left hover:text-accent-100 transition-colors"
                    >
                      Sign In
                    </button>
                  )}
                </>
              )}
            </div>
          </nav>
        )}
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

