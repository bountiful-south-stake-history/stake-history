import type { Calling } from './types'

export function parseLocalDate(dateString: string): Date {
  if (dateString.includes('T')) {
    return new Date(dateString)
  }
  return new Date(dateString + 'T00:00:00')
}

export function formatDate(date: string, precision: 'exact' | 'month' | 'year'): string {
  const d = parseLocalDate(date)
  switch (precision) {
    case 'exact':
      return d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      })
    case 'month':
      return d.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long'
      })
    case 'year':
      return d.getFullYear().toString()
  }
}

export function formatCallingRange(calling: Calling): string {
  const start = formatDate(calling.sustained_date, calling.sustained_precision)
  const end = calling.released_date
    ? formatDate(calling.released_date, calling.released_precision!)
    : 'present'
  return `${start} – ${end}`
}

