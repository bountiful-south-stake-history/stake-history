import type { Calling, Organization } from './types'

export function isDiscontinuedOrg(org: Pick<Organization, 'discontinued_date'>): boolean {
  return !!org.discontinued_date
}

export function parseLocalDate(dateString: string): Date {
  if (dateString.includes('T')) {
    return new Date(dateString)
  }
  return new Date(dateString + 'T00:00:00')
}

export function formatDate(date: string, precision: 'exact' | 'month' | 'year'): string {
  const d = parseLocalDate(date)
  switch (precision) {
    case 'month':
      return d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long'
      })
    case 'year':
      return d.getFullYear().toString()
    case 'exact':
    default:
      return d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
  }
}

// Day-first long form, e.g. "13 September 2026" (formatDate uses US month-first).
export function formatDateLong(date: string): string {
  return parseLocalDate(date).toLocaleDateString('en-GB', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  })
}

export function formatCallingRange(calling: Calling): string {
  const start = formatDate(calling.sustained_date, calling.sustained_precision)
  const end = calling.released_date
    ? formatDate(calling.released_date, calling.released_precision!)
    : 'present'
  return `${start} – ${end}`
}

