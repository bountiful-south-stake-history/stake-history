-- =====================================================================
-- 20260915150000_policy_cleanup.sql   (DRAFT — NOT APPLIED)
-- =====================================================================
-- Three related RLS cleanups on the core public tables:
--   1. Redaction is not enforced at the API: people has a permissive public
--      SELECT policy "Public read people" USING (true) that ORs with
--      "Public read access to people" USING (redacted = false), so a direct
--      GET /rest/v1/people returns redacted people. Remove the permissive one.
--   2. The three schema-era admin policies are FOR ALL with roles {public}, so
--      anon evaluates their user_profiles subquery and a write attempt throws
--      42501 "permission denied for table user_profiles" instead of a clean
--      denial. Scope them TO authenticated (anon is never an admin).
--   3. suggestions."Anyone can submit suggestions" is WITH CHECK (true); its
--      status defaults to 'new'. Gate it to WITH CHECK (status = 'new') so a
--      direct anon call cannot insert a pre-triaged suggestion.
--
-- STATUS: DRAFT / NOT YET APPLIED. Apply by hand in the Supabase SQL Editor
-- (project kywsocmgkrckwhnmhtfz), then log it in docs/data-changes.md in the
-- SAME PR. Committed on branch fix/policy-cleanup.
--
-- GROUNDING (pg_policies + grep, 2026-09-15):
--   * people SELECT policies: "Public read access to people" (redacted=false)
--     and "Public read people" (true), both roles {public}. Every client that
--     reads people already filters redacted=false (usePerson.ts:22,
--     usePeopleSearch.ts:26, PersonSearchModal.tsx:52) or client-side
--     (usePeople.ts:19/39); admin reads redacted rows via "Admin full access
--     people", NOT the permissive public policy. No client depends on the
--     permissive policy. (738 people, 0 currently redacted.)
--   * Admin ALL policies with roles {public}: "Admin full access people",
--     "...organizations", "...callings" — identical shape. photos/albums admin
--     policies are already TO authenticated, so only these three need scoping.
--   * suggestions: SuggestionModal.tsx:86-90 inserts without setting status,
--     relying on the 'new' default; WITH CHECK is evaluated after defaults, so
--     the gate does not affect the form.
--
-- ORDERING (deliberate — admins must never lose people read access, even
-- briefly): the admin "people" policy is recreated FIRST, while the permissive
-- "Public read people" still exists; only AFTER the admin policy is back in
-- place is the permissive policy dropped. So at every instant an admin has a
-- full-access SELECT path on people (the permissive policy during the admin
-- policy's drop/recreate window, then the recreated admin policy afterward).
--
-- Supabase SQL Editor compatible: plain atomic statements, no BEGIN/COMMIT.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. Scope the three admin ALL policies TO authenticated.
--    (A policy's roles cannot be ALTERed in place, so DROP + CREATE.)
--    "people" is done FIRST so its admin read path is restored before the
--    permissive public SELECT is dropped in section 2.
-- ---------------------------------------------------------------------
DROP POLICY "Admin full access people" ON public.people;
CREATE POLICY "Admin full access people" ON public.people
  FOR ALL TO authenticated
  USING (EXISTS ( SELECT 1 FROM public.user_profiles
                  WHERE user_profiles.id = auth.uid()
                    AND user_profiles.role = 'admin'::user_role));

DROP POLICY "Admin full access organizations" ON public.organizations;
CREATE POLICY "Admin full access organizations" ON public.organizations
  FOR ALL TO authenticated
  USING (EXISTS ( SELECT 1 FROM public.user_profiles
                  WHERE user_profiles.id = auth.uid()
                    AND user_profiles.role = 'admin'::user_role));

DROP POLICY "Admin full access callings" ON public.callings;
CREATE POLICY "Admin full access callings" ON public.callings
  FOR ALL TO authenticated
  USING (EXISTS ( SELECT 1 FROM public.user_profiles
                  WHERE user_profiles.id = auth.uid()
                    AND user_profiles.role = 'admin'::user_role));


-- ---------------------------------------------------------------------
-- 2. Enforce redaction at the API: drop the permissive public SELECT on
--    people. "Public read access to people" USING (redacted = false) remains
--    as the sole public SELECT, so redacted people are no longer API-readable.
--    Runs AFTER the admin "people" recreate above (see ORDERING note).
-- ---------------------------------------------------------------------
DROP POLICY "Public read people" ON public.people;


-- ---------------------------------------------------------------------
-- 3. Gate suggestions submissions to status='new' (the column default).
-- ---------------------------------------------------------------------
DROP POLICY "Anyone can submit suggestions" ON public.suggestions;
CREATE POLICY "Anyone can submit suggestions" ON public.suggestions
  FOR INSERT TO anon, authenticated
  WITH CHECK (status = 'new');


-- =====================================================================
-- ROLLBACK (comments only — restores each original policy verbatim)
-- =====================================================================
-- -- 3. suggestions:
-- DROP POLICY "Anyone can submit suggestions" ON public.suggestions;
-- CREATE POLICY "Anyone can submit suggestions" ON public.suggestions
--   FOR INSERT TO anon, authenticated WITH CHECK (true);
--
-- -- 2. restore the permissive public SELECT on people:
-- CREATE POLICY "Public read people" ON public.people
--   FOR SELECT USING (true);
--
-- -- 1. restore the three admin ALL policies to roles {public}:
-- DROP POLICY "Admin full access callings" ON public.callings;
-- CREATE POLICY "Admin full access callings" ON public.callings
--   FOR ALL
--   USING (EXISTS ( SELECT 1 FROM public.user_profiles
--                   WHERE user_profiles.id = auth.uid()
--                     AND user_profiles.role = 'admin'::user_role));
-- DROP POLICY "Admin full access organizations" ON public.organizations;
-- CREATE POLICY "Admin full access organizations" ON public.organizations
--   FOR ALL
--   USING (EXISTS ( SELECT 1 FROM public.user_profiles
--                   WHERE user_profiles.id = auth.uid()
--                     AND user_profiles.role = 'admin'::user_role));
-- DROP POLICY "Admin full access people" ON public.people;
-- CREATE POLICY "Admin full access people" ON public.people
--   FOR ALL
--   USING (EXISTS ( SELECT 1 FROM public.user_profiles
--                   WHERE user_profiles.id = auth.uid()
--                     AND user_profiles.role = 'admin'::user_role));
-- =====================================================================
