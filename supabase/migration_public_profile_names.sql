-- =====================================================================
-- migration_public_profile_names.sql   (DRAFT — FOR HUMAN REVIEW, UNAPPLIED)
-- =====================================================================
-- File C of the email-exposure close (Files A, B, C, D). Independently
-- appliable and SAFE TO APPLY FIRST — it only ADDS a new read surface and
-- changes nothing existing.
--
-- WHY THIS EXISTS: public photo pages (usePhotoLikes.ts, on PhotoAlbumPage /
-- PhotoDetailPage / BuildingPhotoAlbum / PhotoLightbox) currently read
-- public.user_profiles directly to show "liked by <name>", and they select the
-- `email` column. Because anon can read the whole user_profiles table today
-- (table grant + two USING(true) SELECT policies), anonymous visitors receive
-- other users' email addresses. We cannot lock down the base table until those
-- readers have an email-free path to display names. This view IS that path.
--
-- SEQUENCING: apply this file -> deploy the code change that repoints
-- usePhotoLikes at this view -> verify -> only then apply File D
-- (migration_restrict_user_profiles_anon.sql), which revokes anon from the base
-- table. This file on its own has no dependency and no risk.
--
-- Written for the Supabase web SQL Editor: atomic statements only, no
-- BEGIN/COMMIT.
--
-- ---------------------------------------------------------------------
-- security_invoker DECISION: NOT set (the view runs SECURITY DEFINER, i.e. as
-- its owner `postgres`). Justification:
--   * The task hint notes this view "reads no auth schema data," which would
--     normally argue for security_invoker=true (the usual lint preference).
--     But the PURPOSE of this view is to let File D fully REVOKE anon from
--     public.user_profiles and drop the two USING(true) SELECT policies. If the
--     view were security_invoker=true, reading it would execute as the caller
--     and would be subject to user_profiles' RLS/grants — so anon could only
--     read it if anon still had base-table access, which is exactly what we are
--     removing. security_invoker would therefore defeat the lockdown.
--   * Running as owner (the default) makes this the SOLE, self-contained,
--     email-free anon read path, independent of base-table RLS. That is what
--     allows File D to revoke anon from the base table without breaking the
--     public site.
--   * This is safe because the view exposes ONLY non-sensitive columns that are
--     already public on the site: `id` (a UUID already present in public
--     photo_likes data) and `display_name` (already rendered publicly). It does
--     NOT expose email, role, or the view_blocked* fields.
--   * Trade-off acknowledged: a SECURITY DEFINER view trips the Supabase
--     "security definer view" advisor. That warning is accepted here precisely
--     because the two exposed columns are non-sensitive and the definer
--     semantics are the mechanism that lets us close the email leak. (Contrast
--     admin_users_view in File A, which is definer for a different reason —
--     reading auth.users — and is additionally gated to admins.)
-- =====================================================================


-- ---------------------------------------------------------------------
-- STATEMENT 1 — Create the minimal public view: id + display_name only.
-- ---------------------------------------------------------------------
-- No email, no role, no view_blocked. Runs as owner (default; security_invoker
-- intentionally NOT set — see header) so it bypasses base-table RLS and returns
-- the two public columns for all profiles to any grantee of the view.
--
-- REVERSIBLE: yes.  DROP VIEW public.profile_display_names;

CREATE OR REPLACE VIEW public.profile_display_names AS
  SELECT id, display_name
  FROM public.user_profiles;


-- ---------------------------------------------------------------------
-- STATEMENT 2 — Grant read access to the two client roles.
-- ---------------------------------------------------------------------
-- anon (public photo pages while logged out) and authenticated (same pages
-- while logged in) both need to read liker display names. Supabase default
-- privileges may already grant these on new public objects; this GRANT is
-- explicit and idempotent so the file is self-contained and deterministic.
-- service_role and postgres retain their implicit owner/superuser access.
--
-- REVERSIBLE: yes.
--   REVOKE SELECT ON public.profile_display_names FROM anon, authenticated;

GRANT SELECT ON public.profile_display_names TO anon, authenticated;


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm the view exists, exposes exactly id + display_name, and carries NO
--    email/role columns:
--       SELECT column_name FROM information_schema.columns
--        WHERE table_schema='public' AND table_name='profile_display_names'
--        ORDER BY ordinal_position;
--    Expect exactly: id, display_name.
--
-- 2. Confirm the view is NOT security_invoker (reloptions null or lacking
--    security_invoker => runs as owner, which is what we want here):
--       SELECT relname, reloptions FROM pg_class
--        WHERE oid='public.profile_display_names'::regclass;
--
-- 3. Confirm anon + authenticated hold SELECT on the view:
--       SELECT pg_get_userbyid(a.grantee) AS grantee, a.privilege_type
--         FROM pg_class c
--         JOIN pg_namespace n ON n.oid=c.relnamespace
--         LEFT JOIN LATERAL aclexplode(c.relacl) a ON true
--        WHERE n.nspname='public' AND c.relname='profile_display_names'
--        ORDER BY grantee, privilege_type;
--    Expect SELECT rows for 'anon' and 'authenticated'.
--
-- 4. Optional functional check (test project or throwaway anon token, NOT a
--    prod write): GET /rest/v1/profile_display_names?select=id,display_name
--    should return rows with names and no email field.
-- =====================================================================
