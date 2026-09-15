-- =====================================================================
-- 20260915130000_tighten_submission_policies.sql   (DRAFT — NOT APPLIED)
-- =====================================================================
-- Makes the admin review queue a REAL gate at the database layer.
--
-- STATUS: DRAFT / NOT YET APPLIED. Apply by hand in the Supabase SQL Editor
-- (project kywsocmgkrckwhnmhtfz), then log it in docs/data-changes.md in the
-- SAME PR. Committed on branch fix/submission-policies.
--
-- PROBLEM (verified via pg_policies, 2026-09-15):
-- The public submission tables all carry an INSERT policy with WITH CHECK (true)
-- for {anon, authenticated} (or {public}), so a direct PostgREST call with the
-- public anon key can insert rows with status='approved' and bypass review:
--     photos                "Anyone can submit photos"       WITH CHECK (true)
--     photo_people          "Anyone can tag people in photos" WITH CHECK (true)   (no status column)
--     memories              "Anyone can submit memories"      WITH CHECK (true)
--     memories              "Authenticated users can insert memories" WITH CHECK (true)
--     portrait_submissions  "Anyone can submit portraits"     WITH CHECK (true)
--     correction_requests   "Anyone can submit corrections"   WITH CHECK (true)   (roles {public})
--
-- FIX: constrain each public INSERT to status='pending' (so submissions can only
-- ever enter the queue, never land pre-approved). The UI is unchanged and the
-- anonymous submission path stays open — every client already inserts
-- status='pending' explicitly (ContributionModal.tsx photos L1116, memory L990,
-- portrait L827, correction L909, familysearch L947; BuildingPhotoAlbum.tsx L361).
-- Postgres evaluates WITH CHECK AFTER column defaults are applied, and every table
-- below defaults status to 'pending', so even a client that OMITTED status would
-- still pass. No client inserts a non-pending status.
--
-- photo_people has NO status column; a page is "in the queue" iff its photo is
-- pending. Anon cannot SELECT a pending photo (its photos SELECT policy is
-- status='approved'), so an inline EXISTS subquery would evaluate under the
-- caller's RLS and always be false. We use a small SECURITY DEFINER helper
-- (public.photo_is_pending) that bypasses RLS to read photos.status — following
-- the convention of public.is_admin() in migration_admin_gate_is_admin.sql:106-133
-- (LANGUAGE sql, SECURITY DEFINER, STABLE, SET search_path = public, EXECUTE
-- revoked from PUBLIC then granted to the roles that need it).
--
-- ADMIN PATH: AdminPhotosTab.handleSaveEdit (src/components/admin/AdminPhotosTab.tsx
-- :492-510) deletes and re-inserts photo_people when an admin edits a photo's tags
-- — including APPROVED photos, which the new pending-only public policy would
-- reject. There is currently NO admin INSERT policy on photo_people (the admin
-- relied on the permissive public one). So this migration ADDS an admin INSERT
-- policy on photo_people, mirroring the live admin gate on photos
-- ("Admins can update photos": EXISTS(user_profiles ... role='admin')). RLS is
-- OR-permissive, so an admin session inserts tags on any photo while anon/public
-- can only tag pending photos.
--
-- NOT TOUCHED (by design):
--   * SELECT policies (the albums migration owns the photos SELECT policy; this
--     migration only changes INSERT, so the two cannot conflict).
--   * Storage policies (anonymous uploads to the photos bucket are intended).
--   * suggestions."Anyone can submit suggestions": its status column defaults to
--     'new', NOT 'pending', so the status='pending' rule does not apply; left as-is
--     (see follow-up note at the end).
--
-- Supabase SQL Editor compatible: plain atomic statements, no BEGIN/COMMIT.
-- ORDERING: create the helper first, then the policies that use it.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. SECURITY DEFINER helper: is this photo still pending?
--    DEFINER so it can read photos.status regardless of the caller's SELECT
--    RLS (anon cannot see pending photos). Takes only a uuid and returns a
--    boolean about that row, so it leaks nothing when called directly.
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.photo_is_pending(p_photo_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.photos
     WHERE id = p_photo_id AND status = 'pending'
  );
$$;
-- anon and authenticated both tag photos through the form, so both need EXECUTE.
REVOKE EXECUTE ON FUNCTION public.photo_is_pending(uuid) FROM PUBLIC;
GRANT  EXECUTE ON FUNCTION public.photo_is_pending(uuid) TO anon, authenticated;


-- ---------------------------------------------------------------------
-- 2. photos — submissions may only enter as pending.
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can submit photos" ON public.photos;
CREATE POLICY "Anyone can submit photos" ON public.photos
  FOR INSERT TO anon, authenticated
  WITH CHECK (status = 'pending');


-- ---------------------------------------------------------------------
-- 3. photo_people — public may tag only a PENDING photo; admins may tag any.
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can tag people in photos" ON public.photo_people;
CREATE POLICY "Anyone can tag people in photos" ON public.photo_people
  FOR INSERT TO anon, authenticated
  WITH CHECK (public.photo_is_pending(photo_id));

-- NEW: preserve AdminPhotosTab's wholesale tag replacement on approved photos.
CREATE POLICY "Admins can tag people in photos" ON public.photo_people
  FOR INSERT TO authenticated
  WITH CHECK (EXISTS ( SELECT 1 FROM public.user_profiles
                       WHERE user_profiles.id = auth.uid()
                         AND user_profiles.role = 'admin'));


-- ---------------------------------------------------------------------
-- 4. memories — BOTH public INSERT policies constrained to pending.
--    (The second, authenticated-only policy is redundant with the first but
--    also had WITH CHECK (true); leaving it unconstrained would let a signed-in
--    viewer bypass the gate, since RLS is OR-permissive.)
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can submit memories" ON public.memories;
CREATE POLICY "Anyone can submit memories" ON public.memories
  FOR INSERT TO anon, authenticated
  WITH CHECK (status = 'pending');

DROP POLICY "Authenticated users can insert memories" ON public.memories;
CREATE POLICY "Authenticated users can insert memories" ON public.memories
  FOR INSERT TO authenticated
  WITH CHECK (status = 'pending');


-- ---------------------------------------------------------------------
-- 5. portrait_submissions — submissions may only enter as pending.
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can submit portraits" ON public.portrait_submissions;
CREATE POLICY "Anyone can submit portraits" ON public.portrait_submissions
  FOR INSERT TO anon, authenticated
  WITH CHECK (status = 'pending');


-- ---------------------------------------------------------------------
-- 6. correction_requests — submissions may only enter as pending.
--    Original policy targeted role {public} (no TO clause); restored the same.
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can submit corrections" ON public.correction_requests;
CREATE POLICY "Anyone can submit corrections" ON public.correction_requests
  FOR INSERT
  WITH CHECK (status = 'pending');


-- =====================================================================
-- ROLLBACK (comments only — restores every original policy verbatim)
-- =====================================================================
-- DROP POLICY "Anyone can submit photos" ON public.photos;
-- CREATE POLICY "Anyone can submit photos" ON public.photos
--   FOR INSERT TO anon, authenticated WITH CHECK (true);
--
-- DROP POLICY "Admins can tag people in photos" ON public.photo_people;
-- DROP POLICY "Anyone can tag people in photos" ON public.photo_people;
-- CREATE POLICY "Anyone can tag people in photos" ON public.photo_people
--   FOR INSERT TO anon, authenticated WITH CHECK (true);
--
-- DROP POLICY "Anyone can submit memories" ON public.memories;
-- CREATE POLICY "Anyone can submit memories" ON public.memories
--   FOR INSERT TO anon, authenticated WITH CHECK (true);
-- DROP POLICY "Authenticated users can insert memories" ON public.memories;
-- CREATE POLICY "Authenticated users can insert memories" ON public.memories
--   FOR INSERT TO authenticated WITH CHECK (true);
--
-- DROP POLICY "Anyone can submit portraits" ON public.portrait_submissions;
-- CREATE POLICY "Anyone can submit portraits" ON public.portrait_submissions
--   FOR INSERT TO anon, authenticated WITH CHECK (true);
--
-- DROP POLICY "Anyone can submit corrections" ON public.correction_requests;
-- CREATE POLICY "Anyone can submit corrections" ON public.correction_requests
--   FOR INSERT WITH CHECK (true);
--
-- REVOKE EXECUTE ON FUNCTION public.photo_is_pending(uuid) FROM anon, authenticated;
-- DROP FUNCTION public.photo_is_pending(uuid);
-- =====================================================================


-- =====================================================================
-- FOLLOW-UPS SURFACED BY STEP 0 (NOT fixed here — out of the INSERT scope):
--   * people."Anyone can update portrait fields" — an UPDATE policy for
--     {anon, authenticated} with USING (true) and WITH CHECK (true). This lets
--     the anon key overwrite portrait_url / portrait_pending on ANY person,
--     bypassing portrait review entirely (the portrait equivalent of the holes
--     fixed above). Grep of src/ finds NO client that updates `people` directly,
--     so this policy appears to be consumer-less legacy and is likely safe to
--     drop — but that is an UPDATE fix, out of this PR's INSERT scope. Recommend
--     an immediate follow-up PR.
--   * suggestions."Anyone can submit suggestions" — WITH CHECK (true); status
--     defaults to 'new' (not 'pending'), so the rule here does not apply. If
--     suggestions should also be gated, constrain to status='new' separately.
--   * No anon DELETE policy exists on any public table (verified).
-- =====================================================================
