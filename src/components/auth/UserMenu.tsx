import { useState, useRef, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { useAdmin } from '../../hooks/useAdmin'
import type { User } from '@supabase/supabase-js'

interface UserMenuProps {
  user: User
  onSignOut?: () => void
}

export function UserMenu({ user, onSignOut }: UserMenuProps) {
  const [showDropdown, setShowDropdown] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)
  const { isAdmin } = useAdmin()
  const timeoutRef = useRef<NodeJS.Timeout | null>(null)

  useEffect(() => {
    if (!showDropdown) return

    const handleClickOutside = (event: MouseEvent | TouchEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setShowDropdown(false)
      }
    }

    timeoutRef.current = setTimeout(() => {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('touchstart', handleClickOutside)
    }, 150)

    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('touchstart', handleClickOutside)
    }
  }, [showDropdown])

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    setShowDropdown(false)
    onSignOut?.()
  }

  const handleToggleDropdown = (e: React.MouseEvent) => {
    e.stopPropagation()
    e.preventDefault()
    setShowDropdown((prev) => !prev)
  }

  return (
    <div className="relative" ref={dropdownRef}>
      <button
        onClick={handleToggleDropdown}
        className="flex items-center gap-2 hover:text-accent-100 transition-colors text-left"
      >
        <span className="text-sm">{user.email}</span>
        <svg
          className={`w-4 h-4 transition-transform ${showDropdown ? 'rotate-180' : ''}`}
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
        </svg>
      </button>

      {showDropdown && (
        <div 
          className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-[100]"
          onClick={(e) => e.stopPropagation()}
        >
          {isAdmin && (
            <Link
              to="/admin"
              onClick={(e) => {
                e.stopPropagation()
                setShowDropdown(false)
              }}
              className="block px-4 py-2 text-gray-700 hover:bg-gray-100 transition-colors"
            >
              Admin
            </Link>
          )}
          <button
            onClick={(e) => {
              e.stopPropagation()
              handleSignOut()
            }}
            className="w-full text-left px-4 py-2 text-gray-700 hover:bg-gray-100 transition-colors"
          >
            Sign Out
          </button>
        </div>
      )}
    </div>
  )
}

