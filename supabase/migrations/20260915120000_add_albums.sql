-- =====================================================================
-- 20260915120000_add_albums.sql   (DRAFT — NOT APPLIED)
-- =====================================================================
-- Adds first-class photo albums (one scrapbook = one album, pages in order)
-- so scanned ward scrapbooks can be ingested as grouped, ordered galleries.
--
-- STATUS: DRAFT / NOT YET APPLIED. Apply by hand in the Supabase SQL Editor
-- (project kywsocmgkrckwhnmhtfz), then log it in docs/data-changes.md in the
-- SAME PR, per that file's convention. This file is committed on branch
-- feature/albums-ingest and must not be run automatically.
--
-- MODEL (decisions already settled — see the PR description):
--   * New `albums` table; each row is one scrapbook.
--   * `photos` keeps its one-row-per-image shape and gains four nullable
--     columns: album_id (FK -> albums, ON DELETE CASCADE), album_page,
--     web_path, thumb_path.
--   * Album-level visibility gate: `albums.status`. Pages are inserted with
--     photos.status='approved'; the album's status is what actually decides
--     whether those pages are visible to the public.
--   * Supabase Storage holds only a web render + a thumbnail per page;
--     archival originals live off-site (albums.originals_url / originals_note).
--
-- POLICY PATTERN: mirrors the admin gate that is ALREADY LIVE on `photos`,
-- read from pg_policies on 2026-09-15:
--     EXISTS (SELECT 1 FROM user_profiles
--             WHERE user_profiles.id = auth.uid()
--               AND user_profiles.role = 'admin')
-- This is the same shape as schema.sql's "Admin full access" policies
-- (supabase/schema.sql:209-234). We deliberately do NOT adopt the
-- public.is_admin() helper drafted in the (still-unapplied)
-- migration_enable_rls_disabled_tables.sql, so `albums` stays consistent
-- with what is actually deployed on `photos` today.
--
-- Supabase SQL Editor compatible: plain atomic statements, no BEGIN/COMMIT.
-- Ordering matters: albums table -> photos columns -> cover FK -> unique
-- index -> grants/RLS on albums -> replace the public SELECT policy on photos.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. albums table
-- ---------------------------------------------------------------------
CREATE TABLE public.albums (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title             TEXT NOT NULL,
  slug              TEXT UNIQUE NOT NULL,
  description       TEXT,
  organization_id   UUID REFERENCES public.organizations(id),
  building_id       TEXT,
  approximate_date  TEXT,
  date_range_start  DATE,
  date_range_end    DATE,
  contributor_names TEXT,
  originals_url     TEXT,
  originals_note    TEXT,
  cover_photo_id    UUID,                 -- FK to photos(id) added in step 3
  status            TEXT NOT NULL DEFAULT 'pending'
                      CHECK (status IN ('pending','approved','rejected')),
  page_count        INTEGER,
  created_at        TIMESTAMPTZ DEFAULT now(),
  reviewed_at       TIMESTAMPTZ,
  reviewed_by       UUID                  -- matches photos.reviewed_by (uuid)
);

-- ---------------------------------------------------------------------
-- 2. photos: album linkage + stored render/thumbnail object paths
--    All four columns are nullable, so the 119 existing rows are unaffected
--    (album_id IS NULL for every non-album photo).
-- ---------------------------------------------------------------------
ALTER TABLE public.photos
  ADD COLUMN album_id   UUID REFERENCES public.albums(id) ON DELETE CASCADE,
  ADD COLUMN album_page INTEGER,
  ADD COLUMN web_path   TEXT,
  ADD COLUMN thumb_path TEXT;

-- ---------------------------------------------------------------------
-- 3. cover_photo_id FK (added now that the photos columns exist, per plan).
--    ON DELETE SET NULL: deleting the cover page must not delete the album.
-- ---------------------------------------------------------------------
ALTER TABLE public.albums
  ADD CONSTRAINT albums_cover_photo_id_fkey
  FOREIGN KEY (cover_photo_id) REFERENCES public.photos(id) ON DELETE SET NULL;

-- ---------------------------------------------------------------------
-- 4. one row per (album, page); also serves ORDER BY album_page reads.
-- ---------------------------------------------------------------------
CREATE UNIQUE INDEX photos_album_page_uniq
  ON public.photos (album_id, album_page)
  WHERE album_id IS NOT NULL;

-- ---------------------------------------------------------------------
-- 5. grants + RLS on albums
--    Supabase default-grants anon/authenticated FULL CRUD on new public
--    tables; RLS is the only real gate (docs/admin-remediation-plan.md §8).
--    Lock anon to SELECT only; authenticated keeps its write grants but the
--    policies below restrict writes to admins. The bulk import script runs
--    with the service-role key, which bypasses RLS entirely, so it does not
--    depend on any of these policies.
-- ---------------------------------------------------------------------
REVOKE ALL ON public.albums FROM anon;
GRANT SELECT ON public.albums TO anon;

ALTER TABLE public.albums ENABLE ROW LEVEL SECURITY;

-- Public (anon + authenticated) may read only approved albums.
CREATE POLICY "Public can view approved albums" ON public.albums
  FOR SELECT TO anon, authenticated
  USING (status = 'approved');

-- Admins may read every album regardless of status.
CREATE POLICY "Admins can view all albums" ON public.albums
  FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM public.user_profiles
                 WHERE user_profiles.id = auth.uid()
                   AND user_profiles.role = 'admin'));

CREATE POLICY "Admins can insert albums" ON public.albums
  FOR INSERT TO authenticated
  WITH CHECK (EXISTS (SELECT 1 FROM public.user_profiles
                      WHERE user_profiles.id = auth.uid()
                        AND user_profiles.role = 'admin'));

CREATE POLICY "Admins can update albums" ON public.albums
  FOR UPDATE TO authenticated
  USING (EXISTS (SELECT 1 FROM public.user_profiles
                 WHERE user_profiles.id = auth.uid()
                   AND user_profiles.role = 'admin'));

CREATE POLICY "Admins can delete albums" ON public.albums
  FOR DELETE TO authenticated
  USING (EXISTS (SELECT 1 FROM public.user_profiles
                 WHERE user_profiles.id = auth.uid()
                   AND user_profiles.role = 'admin'));

-- ---------------------------------------------------------------------
-- 6. Replace the public SELECT policy on photos so album pages inherit
--    their album's visibility.
--
--    Existing policy (verified live via pg_policies, 2026-09-15):
--      name:  "Public can view approved photos"
--      roles: {anon, authenticated}
--      cmd:   SELECT
--      using: (status = 'approved')
--
--    New behaviour: a photo is public when it is approved AND either it is a
--    normal (non-album) photo, or it belongs to an album that is itself
--    approved. The albums subquery runs under the CALLER's RLS: for
--    anon/authenticated the "Public can view approved albums" policy (step 5)
--    exposes exactly the approved albums, so EXISTS(...) is true only for
--    pages of an approved album — the intended gate. Admins are unaffected;
--    their separate "Admins can view all photos" policy already returns every
--    row. The 115 existing approved photos all have album_id IS NULL, so they
--    stay visible with no change.
-- ---------------------------------------------------------------------
DROP POLICY "Public can view approved photos" ON public.photos;

CREATE POLICY "Public can view approved photos" ON public.photos
  FOR SELECT TO anon, authenticated
  USING (
    status = 'approved'
    AND (
      photos.album_id IS NULL
      OR EXISTS (SELECT 1 FROM public.albums a
                 WHERE a.id = photos.album_id
                   AND a.status = 'approved')
    )
  );


-- =====================================================================
-- ROLLBACK (comments only — run by hand to fully reverse this migration)
-- =====================================================================
-- -- 1. Restore the original photos public SELECT policy:
-- DROP POLICY "Public can view approved photos" ON public.photos;
-- CREATE POLICY "Public can view approved photos" ON public.photos
--   FOR SELECT TO anon, authenticated
--   USING (status = 'approved');
--
-- -- 2. Drop album policies and disable RLS:
-- DROP POLICY "Admins can delete albums"      ON public.albums;
-- DROP POLICY "Admins can update albums"      ON public.albums;
-- DROP POLICY "Admins can insert albums"      ON public.albums;
-- DROP POLICY "Admins can view all albums"    ON public.albums;
-- DROP POLICY "Public can view approved albums" ON public.albums;
-- ALTER TABLE public.albums DISABLE ROW LEVEL SECURITY;
--
-- -- 3. Drop the cover FK, the unique index, and the photos columns
-- --    (drop album_id before dropping the albums table):
-- ALTER TABLE public.albums DROP CONSTRAINT albums_cover_photo_id_fkey;
-- DROP INDEX public.photos_album_page_uniq;
-- ALTER TABLE public.photos
--   DROP COLUMN thumb_path,
--   DROP COLUMN web_path,
--   DROP COLUMN album_page,
--   DROP COLUMN album_id;
--
-- -- 4. Drop the table (removes remaining grants + policies with it):
-- DROP TABLE public.albums;
-- =====================================================================
