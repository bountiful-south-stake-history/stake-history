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

  useEffect(() => {
    function handleClickOutside(event: MouseEvent | TouchEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setShowDropdown(false)
      }
    }

    if (showDropdown) {
      document.addEventListener('mousedown', handleClickOutside)
      document.addEventListener('touchstart', handleClickOutside)
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('touchstart', handleClickOutside)
    }
  }, [showDropdown])

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    setShowDropdown(false)
    onSignOut?.()
  }

  const handleToggleDropdown = (e: React.MouseEvent | React.TouchEvent) => {
    e.stopPropagation()
    setShowDropdown(!showDropdown)
  }

  const handleDropdownClick = (e: React.MouseEvent | React.TouchEvent) => {
    e.stopPropagation()
  }

  return (
    <div className="relative" ref={dropdownRef} onClick={handleDropdownClick} onTouchStart={handleDropdownClick}>
      <button
        onClick={handleToggleDropdown}
        onTouchStart={handleToggleDropdown}
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
        <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-[100]">
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

