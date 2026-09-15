/**
 * import-album.ts — bulk-ingest one scanned scrapbook as an ordered album.
 *
 * Evolved from scripts/bulk-upload-building-photos.ts. See the header comment
 * "WHAT CHANGED vs. bulk-upload-building-photos.ts" below.
 *
 * RUN LOCALLY ONLY (by Troy), never in CI, never against prod automatically:
 *
 *   1. cp .env.example .env.local   # then fill in real values (gitignored)
 *   2. npm install                  # brings in sharp + tsx (devDependencies)
 *   3. npx tsx scripts/import-album.ts --help
 *   4. npx tsx scripts/import-album.ts --folder ./scans/rs-scrapbook \
 *        --title "Relief Society Scrapbook, 1998-2003" --slug rs-1998-2003 \
 *        --contributors "Jane Doe, John Smith" --dry-run
 *   5. drop --dry-run to perform the import for real.
 *
 * SAFETY:
 *   - Reads SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY from .env.local (a plain
 *     Node env loader — NOT Vite). The service-role key bypasses RLS and is
 *     treated like a password; it must never be committed and must never carry
 *     a VITE_ prefix (VITE_ vars are bundled into the browser).
 *   - The script decodes the key's JWT and REFUSES TO RUN if its role is not
 *     'service_role' (so the anon key can never be used for writes).
 *   - Idempotent + resumable: a deterministic photos.id (UUIDv5 of
 *     "<slug>:<page>") plus existence checks mean a re-run after a mid-job
 *     failure never duplicates rows or storage objects.
 *   - Uploads ONLY a web render + a thumbnail. The source scan is never
 *     uploaded; archival originals stay off-site (recorded on albums.originals_url).
 */

import { createClient, type SupabaseClient } from '@supabase/supabase-js'
import sharp from 'sharp'
import { createHash } from 'node:crypto'
import { readFileSync, readdirSync, existsSync, statSync } from 'node:fs'
import { join, basename } from 'node:path'

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------
const BUCKET = 'photos'
const BUCKET_LIMIT_BYTES = 10 * 1024 * 1024 // photos bucket file_size_limit (verified live)
const WEB_LONG_EDGE = 2000
const THUMB_LONG_EDGE = 400
const WEB_QUALITY = 85
const THUMB_QUALITY = 80
const CONCURRENCY = 4
// HEIC is intentionally excluded: sharp's heif support on this toolchain is
// AVIF-only (format.heif.fileSuffix = ['.avif']); Apple HEIC/HEVC decode is not
// guaranteed and can fail mid-import. Convert HEIC scans to JPEG before running.
const SOURCE_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.tif', '.tiff']
// Fixed namespace for UUIDv5 page ids. Arbitrary but MUST stay constant, or
// re-runs would compute different ids and defeat idempotency.
const ALBUM_ID_NAMESPACE = '6f9c3c4a-3e2b-5a1d-9b7e-2f1a0c8d4e6b'

// ---------------------------------------------------------------------------
// .env.local loader (dependency-free; does not clobber real process.env)
// ---------------------------------------------------------------------------
function loadEnvLocal(): void {
  const path = join(process.cwd(), '.env.local')
  if (!existsSync(path)) return
  const text = readFileSync(path, 'utf8')
  for (const raw of text.split(/\r?\n/)) {
    const line = raw.trim()
    if (!line || line.startsWith('#')) continue
    const eq = line.indexOf('=')
    if (eq === -1) continue
    const key = line.slice(0, eq).trim()
    let val = line.slice(eq + 1).trim()
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
      val = val.slice(1, -1)
    }
    if (process.env[key] === undefined) process.env[key] = val
  }
}

// ---------------------------------------------------------------------------
// UUIDv5 (RFC 4122, SHA-1) — deterministic id from a name + namespace
// ---------------------------------------------------------------------------
function uuidToBytes(uuid: string): Buffer {
  const hex = uuid.replace(/-/g, '')
  return Buffer.from(hex, 'hex')
}
function bytesToUuid(b: Buffer): string {
  const h = b.toString('hex')
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-${h.slice(12, 16)}-${h.slice(16, 20)}-${h.slice(20, 32)}`
}
function uuidv5(name: string, namespace: string): string {
  const hash = createHash('sha1')
    .update(Buffer.concat([uuidToBytes(namespace), Buffer.from(name, 'utf8')]))
    .digest()
  const bytes = Buffer.from(hash.subarray(0, 16))
  bytes[6] = (bytes[6] & 0x0f) | 0x50 // version 5
  bytes[8] = (bytes[8] & 0x3f) | 0x80 // RFC 4122 variant
  return bytesToUuid(bytes)
}

// ---------------------------------------------------------------------------
// JWT role guard — refuse anything that is not the service-role key
// ---------------------------------------------------------------------------
function keyRole(jwt: string): string | null {
  try {
    const payload = jwt.split('.')[1]
    const json = Buffer.from(payload.replace(/-/g, '+').replace(/_/g, '/'), 'base64').toString('utf8')
    return JSON.parse(json).role ?? null
  } catch {
    return null
  }
}

// ---------------------------------------------------------------------------
// Natural filename sort ("page-2" before "page-10")
// ---------------------------------------------------------------------------
function naturalCompare(a: string, b: string): number {
  const ax = a.match(/(\d+|\D+)/g) ?? []
  const bx = b.match(/(\d+|\D+)/g) ?? []
  for (let i = 0; i < Math.min(ax.length, bx.length); i++) {
    const an = ax[i], bn = bx[i]
    const bothNum = /^\d/.test(an) && /^\d/.test(bn)
    if (bothNum) {
      const d = parseInt(an, 10) - parseInt(bn, 10)
      if (d !== 0) return d
    } else if (an !== bn) {
      return an < bn ? -1 : 1
    }
  }
  return ax.length - bx.length
}

// Trailing-number extraction, used only to warn about inconsistent padding.
function lastNumberWidth(name: string): number | null {
  const m = basename(name).replace(/\.[^.]+$/, '').match(/(\d+)(?!.*\d)/)
  return m ? m[1].length : null
}

// ---------------------------------------------------------------------------
// Minimal CSV parser for an optional captions.csv (filename,caption,approx_date)
// ---------------------------------------------------------------------------
function parseCsvLine(line: string): string[] {
  const out: string[] = []
  let cur = '', inQ = false
  for (let i = 0; i < line.length; i++) {
    const c = line[i]
    if (inQ) {
      if (c === '"' && line[i + 1] === '"') { cur += '"'; i++ }
      else if (c === '"') inQ = false
      else cur += c
    } else if (c === '"') inQ = true
    else if (c === ',') { out.push(cur); cur = '' }
    else cur += c
  }
  out.push(cur)
  return out.map((s) => s.trim())
}
type CaptionRow = { caption?: string; approximate_date?: string }
function loadCaptions(folder: string): Map<string, CaptionRow> {
  const map = new Map<string, CaptionRow>()
  const path = join(folder, 'captions.csv')
  if (!existsSync(path)) return map
  const lines = readFileSync(path, 'utf8').split(/\r?\n/).filter((l) => l.trim())
  for (const line of lines) {
    const [file, caption, approx] = parseCsvLine(line)
    if (!file || file.toLowerCase() === 'filename') continue // skip header
    map.set(file, { caption: caption || undefined, approximate_date: approx || undefined })
  }
  return map
}

// ---------------------------------------------------------------------------
// Fixed-size concurrency pool
// ---------------------------------------------------------------------------
async function runPool<T>(items: T[], size: number, worker: (item: T, index: number) => Promise<void>): Promise<void> {
  let next = 0
  const runners = Array.from({ length: Math.min(size, items.length) }, async () => {
    while (next < items.length) {
      const i = next++
      await worker(items[i], i)
    }
  })
  await Promise.all(runners)
}

// ---------------------------------------------------------------------------
// CLI parsing
// ---------------------------------------------------------------------------
interface Args {
  folder?: string; title?: string; slug?: string
  org?: string; building?: string; date?: string
  dateStart?: string; dateEnd?: string
  contributors?: string; contributorEmail?: string; description?: string
  originalsUrl?: string; originalsNote?: string
  dryRun: boolean; help: boolean
}
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
function parseArgs(argv: string[]): Args {
  const a: Args = { dryRun: false, help: false }
  for (let i = 0; i < argv.length; i++) {
    const t = argv[i]
    const val = () => argv[++i]
    switch (t) {
      case '--folder': a.folder = val(); break
      case '--title': a.title = val(); break
      case '--slug': a.slug = val(); break
      case '--org': a.org = val(); break
      case '--building': a.building = val(); break
      case '--date': a.date = val(); break
      case '--date-start': a.dateStart = val(); break
      case '--date-end': a.dateEnd = val(); break
      case '--contributors': a.contributors = val(); break
      case '--contributor-email': a.contributorEmail = val(); break
      case '--description': a.description = val(); break
      case '--originals-url': a.originalsUrl = val(); break
      case '--originals-note': a.originalsNote = val(); break
      case '--dry-run': a.dryRun = true; break
      case '-h': case '--help': a.help = true; break
      default: console.warn(`Ignoring unknown argument: ${t}`)
    }
  }
  return a
}

const HELP = `
import-album.ts — bulk-ingest one scanned scrapbook as an ordered album.

Usage:
  npx tsx scripts/import-album.ts --folder <path> --title "..." --slug <slug> --contributor-email <email> [options]

Required:
  --folder <path>        Folder of page scans for ONE scrapbook (one folder = one album)
  --title "..."          Album title, e.g. "Relief Society Scrapbook, 1998-2003"
  --slug <slug>          URL-safe unique slug, e.g. rs-1998-2003 (also the storage prefix)
  --contributor-email <email>  Contact email stamped on every page (-> photos.submitter_email,
                         which is NOT NULL). No default — must be supplied.

Optional metadata:
  --org <uuid>           organizations.id to attach (e.g. the discontinued ward)
  --building <id>        buildings id tag (archivesData.ts)
  --date "..."           Free-text approximate date, e.g. "1998-2003"
  --date-start <YYYY-MM-DD>   Structured range start
  --date-end   <YYYY-MM-DD>   Structured range end
  --contributors "..."   Names of the members who scanned/contributed (-> submitter_name)
  --description "..."     Album description
  --originals-url <url>   Link to the off-site archival originals (Google Drive, etc.)
  --originals-note "..."  Free-text note about where the originals live

Behaviour:
  --dry-run              List every upload + insert and report total bytes; touches no network

Notes:
  - Pages are ordered by natural filename sort; album_page is the 1-based index.
    Use zero-padded names (page-0001.jpg) so ordering is unambiguous.
  - Optional captions.csv in the folder: "filename,caption,approximate_date" per page.
    A page with no caption gets "Page N" (the caption column is NOT NULL).
  - Source formats accepted: ${SOURCE_EXTENSIONS.join(', ')}. HEIC is NOT accepted —
    convert HEIC scans to JPEG first. Only a web render (${WEB_LONG_EDGE}px, JPEG
    q${WEB_QUALITY}) and a thumbnail (${THUMB_LONG_EDGE}px) are uploaded; the source scan is never uploaded.
  - Pages are inserted with status='approved'; the ALBUM is created status='pending'.
    Nothing is public until you flip albums.status to 'approved'.
  - Reads SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY from .env.local. The script
    refuses to run if the key's role is not 'service_role'.
`

// ---------------------------------------------------------------------------
// Image processing
// ---------------------------------------------------------------------------
async function renderWeb(buf: Buffer): Promise<Buffer> {
  let quality = WEB_QUALITY
  // .rotate() with no args applies EXIF orientation; the output strips all
  // metadata by default (no keepMetadata call), satisfying "metadata stripped".
  let out = await sharp(buf).rotate().resize({ width: WEB_LONG_EDGE, height: WEB_LONG_EDGE, fit: 'inside', withoutEnlargement: true }).jpeg({ quality }).toBuffer()
  // Safety valve for the 10 MB bucket limit (never expected at 2000px/q85).
  while (out.length > BUCKET_LIMIT_BYTES && quality > 40) {
    quality -= 10
    out = await sharp(buf).rotate().resize({ width: WEB_LONG_EDGE, height: WEB_LONG_EDGE, fit: 'inside', withoutEnlargement: true }).jpeg({ quality }).toBuffer()
  }
  if (out.length > BUCKET_LIMIT_BYTES) {
    throw new Error(`web render still ${(out.length / 1048576).toFixed(1)} MB > 10 MB limit at q${quality}`)
  }
  return out
}
async function renderThumb(buf: Buffer): Promise<Buffer> {
  return sharp(buf).rotate().resize({ width: THUMB_LONG_EDGE, height: THUMB_LONG_EDGE, fit: 'inside', withoutEnlargement: true }).jpeg({ quality: THUMB_QUALITY }).toBuffer()
}

// ---------------------------------------------------------------------------
// Storage existence check (skips work that a prior run already did)
// ---------------------------------------------------------------------------
async function objectExists(sb: SupabaseClient, path: string): Promise<boolean> {
  const slash = path.lastIndexOf('/')
  const dir = path.slice(0, slash)
  const base = path.slice(slash + 1)
  const { data, error } = await sb.storage.from(BUCKET).list(dir, { search: base, limit: 100 })
  if (error) return false
  return !!data?.some((o) => o.name === base)
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------
type PageResult = 'created' | 'skipped' | 'failed'

async function main() {
  loadEnvLocal()
  const args = parseArgs(process.argv.slice(2))
  if (args.help) { console.log(HELP); return }

  // Validate required args (fails here, before any network call)
  const missing = ['folder', 'title', 'slug'].filter((k) => !(args as Record<string, unknown>)[k])
  if (!args.contributorEmail) missing.push('contributor-email')
  if (missing.length) {
    console.error(`Missing required argument(s): ${missing.map((m) => '--' + m).join(', ')}\nRun with --help for usage.`)
    process.exit(1)
  }
  if (!EMAIL_RE.test(args.contributorEmail!)) {
    console.error(`--contributor-email "${args.contributorEmail}" is not a valid email address.`)
    process.exit(1)
  }
  const folder = args.folder!
  const slug = args.slug!
  if (!/^[a-z0-9][a-z0-9-]*$/.test(slug)) {
    console.error(`--slug "${slug}" must be lower-case letters, digits, and hyphens (it is also the storage prefix).`)
    process.exit(1)
  }
  if (!existsSync(folder) || !statSync(folder).isDirectory()) {
    console.error(`--folder "${folder}" is not a directory.`)
    process.exit(1)
  }

  // Enumerate + order source files
  const files = readdirSync(folder)
    .filter((f) => SOURCE_EXTENSIONS.includes('.' + f.split('.').pop()!.toLowerCase()))
    .sort(naturalCompare)
  if (files.length === 0) {
    console.error(`No source images (${SOURCE_EXTENSIONS.join(', ')}) found in ${folder}.`)
    process.exit(1)
  }

  // Warn loudly about inconsistent page-number padding
  const widths = new Set(files.map(lastNumberWidth).filter((w): w is number => w !== null))
  const noNumber = files.filter((f) => lastNumberWidth(f) === null)
  if (widths.size > 1) {
    console.warn(`\n⚠️  PAGE-NUMBER PADDING IS INCONSISTENT (digit widths: ${[...widths].sort().join(', ')}).`)
    console.warn(`    Natural sort was used to compensate, but verify the order below is correct before a real run.`)
  }
  if (noNumber.length) {
    console.warn(`\n⚠️  ${noNumber.length} file(s) have no page number and were ordered lexically: ${noNumber.slice(0, 5).join(', ')}${noNumber.length > 5 ? '…' : ''}`)
  }

  const captions = loadCaptions(folder)

  console.log(`\nAlbum:   "${args.title}"  (slug: ${slug})`)
  console.log(`Folder:  ${folder}`)
  console.log(`Pages:   ${files.length}${captions.size ? `  (captions.csv: ${captions.size} rows)` : ''}`)
  console.log(`Mode:    ${args.dryRun ? 'DRY RUN (no network)' : 'LIVE'}\n`)

  // -------------------------------------------------------------------------
  // DRY RUN: transform locally to measure bytes, list actions, no network.
  // -------------------------------------------------------------------------
  if (args.dryRun) {
    let totalBytes = 0
    console.log(`Would create-or-reuse album "${slug}" (status='pending').`)
    for (let i = 0; i < files.length; i++) {
      const page = i + 1
      const pad = String(page).padStart(4, '0')
      const src = join(folder, files[i])
      const webPath = `albums/${slug}/web/${pad}.jpg`
      const thumbPath = `albums/${slug}/thumb/${pad}.jpg`
      const id = uuidv5(`${slug}:${page}`, ALBUM_ID_NAMESPACE)
      let webBytes = 0, thumbBytes = 0, note = ''
      try {
        const buf = readFileSync(src)
        webBytes = (await renderWeb(buf)).length
        thumbBytes = (await renderThumb(buf)).length
        totalBytes += webBytes + thumbBytes
      } catch (err) {
        note = `  [!] cannot process: ${err instanceof Error ? err.message : err}`
      }
      const cap = captions.get(files[i])?.caption ?? `Page ${page}`
      const email = args.contributorEmail!
      console.log(`[${page}/${files.length}] ${files[i]} -> page ${page}`)
      console.log(`      upload ${webPath}   (${(webBytes / 1024).toFixed(0)} KB)`)
      console.log(`      upload ${thumbPath} (${(thumbBytes / 1024).toFixed(0)} KB)`)
      console.log(`      insert photos id=${id} status=approved album_page=${page} caption="${cap}" submitter_email=${email}${note}`)
    }
    console.log(`\nWould set album.page_count=${files.length}, cover_photo_id=page 1.`)
    console.log(`Total bytes that would be uploaded: ${(totalBytes / 1048576).toFixed(2)} MB across ${files.length * 2} objects.`)
    console.log(`\nDRY RUN complete — nothing was written.`)
    return
  }

  // -------------------------------------------------------------------------
  // LIVE: connect with the service-role key (refuse anything else).
  // -------------------------------------------------------------------------
  const url = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!url) { console.error('SUPABASE_URL is not set (put it in .env.local).'); process.exit(1) }
  if (!key) { console.error('SUPABASE_SERVICE_ROLE_KEY is not set (put it in .env.local).'); process.exit(1) }
  const role = keyRole(key)
  if (role !== 'service_role') {
    console.error(`Refusing to run: SUPABASE_SERVICE_ROLE_KEY has role='${role ?? 'unknown'}', not 'service_role'. Never use the anon key for writes.`)
    process.exit(1)
  }
  const sb = createClient(url, key, { auth: { persistSession: false, autoRefreshToken: false } })

  // Create or reuse the album row (by slug), status='pending'.
  let albumId: string
  const { data: existingAlbum, error: findErr } = await sb.from('albums').select('id, status').eq('slug', slug).maybeSingle()
  if (findErr) { console.error(`Failed to look up album: ${findErr.message}`); process.exit(1) }
  if (existingAlbum) {
    albumId = existingAlbum.id
    console.log(`Reusing existing album ${albumId} (status=${existingAlbum.status}).`)
  } else {
    const { data: created, error: insErr } = await sb.from('albums').insert({
      title: args.title, slug, description: args.description ?? null,
      organization_id: args.org ?? null, building_id: args.building ?? null,
      approximate_date: args.date ?? null, date_range_start: args.dateStart ?? null,
      date_range_end: args.dateEnd ?? null, contributor_names: args.contributors ?? null,
      originals_url: args.originalsUrl ?? null, originals_note: args.originalsNote ?? null,
      status: 'pending',
    }).select('id').single()
    if (insErr || !created) { console.error(`Failed to create album: ${insErr?.message}`); process.exit(1) }
    albumId = created.id
    console.log(`Created album ${albumId} (status='pending').`)
  }

  const counts = { created: 0, skipped: 0, failed: 0 }
  const failedFiles: string[] = []
  const firstPagePhotoId = uuidv5(`${slug}:1`, ALBUM_ID_NAMESPACE)

  await runPool(files, CONCURRENCY, async (file, i) => {
    const page = i + 1
    const pad = String(page).padStart(4, '0')
    const src = join(folder, file)
    const webPath = `albums/${slug}/web/${pad}.jpg`
    const thumbPath = `albums/${slug}/thumb/${pad}.jpg`
    const publicUrl = `${url}/storage/v1/object/public/${BUCKET}/${webPath}`
    const id = uuidv5(`${slug}:${page}`, ALBUM_ID_NAMESPACE)
    const cap = captions.get(file)

    try {
      // Skip-what's-done checks
      const [rowRes, webThere, thumbThere] = await Promise.all([
        sb.from('photos').select('id').eq('id', id).maybeSingle(),
        objectExists(sb, webPath),
        objectExists(sb, thumbPath),
      ])
      const rowThere = !!rowRes.data

      if (rowThere && webThere && thumbThere) {
        counts.skipped++
        console.log(`[${page}/${files.length}] ${file} — already done, skipped`)
        return
      }

      // Render only if an upload is actually needed
      if (!webThere || !thumbThere) {
        const buf = readFileSync(src)
        if (!webThere) {
          const web = await renderWeb(buf)
          const { error } = await sb.storage.from(BUCKET).upload(webPath, web, { contentType: 'image/jpeg', upsert: true })
          if (error) throw new Error(`web upload: ${error.message}`)
        }
        if (!thumbThere) {
          const thumb = await renderThumb(buf)
          const { error } = await sb.storage.from(BUCKET).upload(thumbPath, thumb, { contentType: 'image/jpeg', upsert: true })
          if (error) throw new Error(`thumb upload: ${error.message}`)
        }
      }

      if (!rowThere) {
        const { error } = await sb.from('photos').insert({
          id,
          photo_url: publicUrl,
          web_path: webPath,
          thumb_path: thumbPath,
          album_id: albumId,
          album_page: page,
          caption: cap?.caption ?? `Page ${page}`,          // caption is NOT NULL
          approximate_date: cap?.approximate_date ?? args.date ?? null,
          submitter_name: args.contributors ?? 'Stake Admin',
          submitter_email: args.contributorEmail!, // required flag; NOT NULL column
          status: 'approved',
        })
        if (error) {
          // A prior run may have inserted the row after our check; treat a
          // duplicate-key as already-done rather than a failure.
          if (error.code === '23505') { counts.skipped++; console.log(`[${page}/${files.length}] ${file} — row already present, skipped`); return }
          throw new Error(`db insert: ${error.message}`)
        }
      }

      counts.created++
      console.log(`[${page}/${files.length}] ${file} -> page ${page} ✓`)
    } catch (err) {
      counts.failed++
      failedFiles.push(file)
      console.error(`[${page}/${files.length}] ${file} — FAILED: ${err instanceof Error ? err.message : err}`)
    }
  })

  // Finalize album: page_count + cover (page 1), only if page 1 landed.
  const coverExists = counts.failed === 0 || !failedFiles.includes(files[0])
  const { error: finErr } = await sb.from('albums').update({
    page_count: files.length,
    cover_photo_id: coverExists ? firstPagePhotoId : null,
  }).eq('id', albumId)
  if (finErr) console.error(`Warning: failed to set album page_count/cover: ${finErr.message}`)

  console.log(`\nDone. created=${counts.created}  skipped=${counts.skipped}  failed=${counts.failed}  (of ${files.length})`)
  if (failedFiles.length) console.log(`Failed files: ${failedFiles.join(', ')}`)
  console.log(`\nThe album is still status='pending' and therefore NOT public.`)
  console.log(`When it looks right, make it visible by flipping its status:`)
  console.log(`  update albums set status='approved', reviewed_at=now() where slug='${slug}';`)
  if (counts.failed) process.exit(1)
}

main().catch((err) => { console.error(err); process.exit(1) })
