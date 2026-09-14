import type { SupabaseClient } from '@supabase/supabase-js'
import type { Organization } from './types'

// The canonical leader title for an organization type, or null when it cannot be
// determined automatically (auxiliaries etc.) and the caller must supply one.
export function leaderTitleForOrg(org: Pick<Organization, 'org_type'>): string | null {
  switch (org.org_type) {
    case 'ward':
      return 'Bishop'
    case 'branch':
      return 'Branch President'
    case 'stake':
      return 'Stake President'
    default:
      return null
  }
}

// Resolve position ids by EXACT title, failing loudly on ambiguity. Throws if any
// requested title resolves to zero or more than one row. No fallback, no "first match".
export async function resolvePositionIds(
  supabase: SupabaseClient,
  titles: string[]
): Promise<Record<string, string>> {
  const uniqueTitles = [...new Set(titles)]
  if (uniqueTitles.length === 0) {
    return {}
  }

  const { data, error } = await supabase
    .from('positions')
    .select('id, title')
    .in('title', uniqueTitles)

  if (error) {
    throw new Error(`Failed to load positions: ${error.message}`)
  }

  const idsByTitle: Record<string, string[]> = {}
  for (const row of (data ?? []) as { id: string; title: string }[]) {
    ;(idsByTitle[row.title] ||= []).push(row.id)
  }

  const map: Record<string, string> = {}
  for (const title of uniqueTitles) {
    const ids = idsByTitle[title] ?? []
    if (ids.length !== 1) {
      throw new Error(
        `Position "${title}" resolved to ${ids.length} rows (expected exactly 1). ` +
          `Cannot safely assign callings — fix the positions table so this title is unique.`
      )
    }
    map[title] = ids[0]
  }

  return map
}
