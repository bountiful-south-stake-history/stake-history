import { Link } from 'react-router-dom'
import type { Person } from '../../lib/types'

interface PersonNameLinkProps {
  person: Person
  className?: string
}

export function PersonNameLink({ person, className = '' }: PersonNameLinkProps) {
  const displayName = person.display_name || person.full_name

  return (
    <Link
      to={`/person/${person.id}`}
      className={`text-primary-600 hover:text-primary-700 hover:underline ${className}`.trim()}
    >
      {displayName}
    </Link>
  )
}

