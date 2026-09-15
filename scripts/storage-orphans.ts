/**
 * storage-orphans.ts — READ-ONLY reconciliation report for the photos and
 * portraits storage buckets. Lists:
 *   (A) objects in a bucket with NO matching database row, and
 *   (B) database rows whose referenced object is MISSING from the bucket.
 * It DELETES NOTHING. It only reads and prints a report.
 *
 * RUN:
 *   npx tsx scripts/storage-orphans.ts
 *
 * KEYS (.env.local, gitignored):
 *   SUPABASE_URL              (or VITE_SUPABASE_URL)
 *   SUPABASE_SERVICE_ROLE_KEY (preferred) — bypasses RLS, sees every row.
 *   VITE_SUPABASE_ANON_KEY    (fallback)  — can LIST objects, but RLS limits its
 *                                            DB reads (see the warning below), so
 *                                            an anon run OVER-REPORTS orphans.
 *
 * WHY THE SERVICE KEY MATTERS: under the anon key, `photos` SELECT is limited to
 * status='approved' and `portrait_submissions` is admin-only, so pending/rejected
 * photos and every portrait submission are invisible — their objects would be
 * wrongly flagged as orphans. Only the service-role key gives an accurate report.
 */

import { createClient, type SupabaseClient } from '@supabase/supabase-js'
import { readFileSync, existsSync } from 'node:fs'
import { join } from 'node:path'

function loadEnvLocal(): void {
  const path = join(process.cwd(), '.env.local')
  if (!existsSync(path)) return
  for (const raw of readFileSync(path, 'utf8').split(/\r?\n/)) {
    const line = raw.trim()
    if (!line || line.startsWith('#')) continue
    const eq = line.indexOf('=')
    if (eq === -1) continue
    const key = line.slice(0, eq).trim()
    let val = line.slice(eq + 1).trim()
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) val = val.slice(1, -1)
    if (process.env[key] === undefined) process.env[key] = val
  }
}

function keyRole(jwt: string): string | null {
  try {
    const p = jwt.split('.')[1]
    return JSON.parse(Buffer.from(p.replace(/-/g, '+').replace(/_/g, '/'), 'base64').toString('utf8')).role ?? null
  } catch { return null }
}

// Normalize a stored value (public URL or bucket-relative path) to a path
// relative to the given bucket, matching what storage .list() returns.
function toBucketPath(value: string | null | undefined, bucket: string): string | null {
  if (!value) return null
  const marker = `/object/`
  const idx = value.indexOf(marker)
  if (idx !== -1) {
    // .../object/public/<bucket>/<path>  or  .../object/sign/<bucket>/<path>
    const after = value.slice(idx + marker.length)
    const m = after.match(new RegExp(`^(?:public|sign)/${bucket}/(.+)$`))
    if (m) return decodeURIComponent(m[1].split('?')[0])
    return null
  }
  return value // already a bucket-relative path
}

// Recursively list every object in a bucket (folders have id === null).
async function listAll(sb: SupabaseClient, bucket: string, prefix = ''): Promise<string[]> {
  const out: string[] = []
  const pageSize = 1000
  let offset = 0
  for (;;) {
    const { data, error } = await sb.storage.from(bucket).list(prefix, {
      limit: pageSize, offset, sortBy: { column: 'name', order: 'asc' },
    })
    if (error) throw new Error(`list ${bucket}/${prefix}: ${error.message}`)
    if (!data || data.length === 0) break
    for (const item of data) {
      const path = prefix ? `${prefix}/${item.name}` : item.name
      if (item.id === null) out.push(...await listAll(sb, bucket, path))
      else out.push(path)
    }
    if (data.length < pageSize) break
    offset += pageSize
  }
  return out
}

type RowRef = { table: string; id: string; column: string; path: string }

function printSection(title: string, rows: string[]): void {
  console.log(`\n${title} (${rows.length})`)
  console.log('-'.repeat(title.length + 6))
  for (const r of rows.slice(0, 200)) console.log('  ' + r)
  if (rows.length > 200) console.log(`  … and ${rows.length - 200} more`)
}

async function main() {
  loadEnvLocal()
  const url = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  const anonKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY
  const key = serviceKey || anonKey
  if (!url || !key) {
    console.error('Need SUPABASE_URL and a key (SUPABASE_SERVICE_ROLE_KEY preferred, or VITE_SUPABASE_ANON_KEY) in .env.local.')
    process.exit(1)
  }
  const role = keyRole(key)
  const usingService = role === 'service_role'
  console.log(`Connected as role='${role ?? 'unknown'}' (${usingService ? 'service_role — accurate' : 'ANON — RLS-limited'}).`)
  if (!usingService) {
    console.log('⚠️  Anon key: pending/rejected photos and all portrait_submissions are')
    console.log('    invisible under RLS, so orphan counts below are OVER-reported. Run')
    console.log('    with SUPABASE_SERVICE_ROLE_KEY for an authoritative report.')
  }
  const sb = createClient(url, key, { auth: { persistSession: false } })

  // ---- photos bucket ----
  const { data: photos, error: photosErr } = await sb.from('photos').select('id, photo_url, web_path, thumb_path')
  if (photosErr) throw photosErr
  const photoRefs = new Set<string>()
  const photoRowRefs: RowRef[] = []
  for (const p of photos ?? []) {
    for (const [col, val] of [['photo_url', p.photo_url], ['web_path', p.web_path], ['thumb_path', p.thumb_path]] as const) {
      const path = toBucketPath(val as string | null, 'photos')
      if (path) { photoRefs.add(path); photoRowRefs.push({ table: 'photos', id: p.id, column: col, path }) }
    }
  }
  const photoObjects = await listAll(sb, 'photos')
  const photoObjSet = new Set(photoObjects)
  const orphanPhotos = photoObjects.filter((o) => !photoRefs.has(o))
  const missingPhotos = photoRowRefs.filter((r) => !photoObjSet.has(r.path))

  // ---- portraits bucket ----
  const { data: people, error: peopleErr } = await sb.from('people').select('id, portrait_url')
  if (peopleErr) throw peopleErr
  const { data: subs, error: subsErr } = await sb.from('portrait_submissions').select('id, portrait_url')
  if (subsErr) console.warn(`(could not read portrait_submissions: ${subsErr.message} — expected under the anon key)`)
  const portraitRefs = new Set<string>()
  const portraitRowRefs: RowRef[] = []
  for (const pr of people ?? []) {
    const path = toBucketPath(pr.portrait_url, 'portraits')
    if (path) { portraitRefs.add(path); portraitRowRefs.push({ table: 'people', id: pr.id, column: 'portrait_url', path }) }
  }
  for (const s of subs ?? []) {
    const path = toBucketPath(s.portrait_url, 'portraits')
    if (path) { portraitRefs.add(path); portraitRowRefs.push({ table: 'portrait_submissions', id: s.id, column: 'portrait_url', path }) }
  }
  const portraitObjects = await listAll(sb, 'portraits')
  const portraitObjSet = new Set(portraitObjects)
  const orphanPortraits = portraitObjects.filter((o) => !portraitRefs.has(o))
  const missingPortraits = portraitRowRefs.filter((r) => !portraitObjSet.has(r.path))

  // ---- report ----
  console.log(`\n=== Storage reconciliation ===`)
  console.log(`photos:    ${photoObjects.length} objects, ${photoRefs.size} referenced paths (${photos?.length ?? 0} rows)`)
  console.log(`portraits: ${portraitObjects.length} objects, ${portraitRefs.size} referenced paths (${people?.length ?? 0} people, ${subs?.length ?? 0} submissions)`)

  printSection('(A) photos bucket — objects with NO matching row', orphanPhotos)
  printSection('(B) photos rows — object MISSING from bucket', missingPhotos.map((r) => `${r.table}.${r.column} ${r.id} -> ${r.path}`))
  printSection('(A) portraits bucket — objects with NO matching row', orphanPortraits)
  printSection('(B) portraits rows — object MISSING from bucket', missingPortraits.map((r) => `${r.table}.${r.column} ${r.id} -> ${r.path}`))

  console.log('\nNothing was deleted. This report is read-only.')
}

main().catch((err) => { console.error(err); process.exit(1) })
