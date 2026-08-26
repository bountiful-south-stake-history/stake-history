-- =====================================================================
-- migration_enable_rls_disabled_tables.sql   (DRAFT — FOR HUMAN REVIEW, UNAPPLIED)
-- =====================================================================
-- File F of the same-day security remediation. Closes the rls_disabled_in_public
-- finding: 8 public tables have RLS DISABLED while anon holds full CRUD grants,
-- so anon can read AND write them via PostgREST. Enables RLS and adds policies
-- only where an app consumer needs them.
--
-- !!! REVISED — TWO TABLES HELD BACK (contacts, talk_transcripts). See the HOLD
--     block below. As revised, this file locks down 6 of the 8 tables:
--     audit_log, portrait_history, media_people, media_callings, story_people,
--     story_time_periods. contacts and talk_transcripts are NOT touched here.
--
-- !!! DEPENDENCY — apply migration_admin_gate_is_admin.sql (File G) FIRST. The
--     audit_log policies below call public.is_admin(); that helper must exist.
--     File G also replaces the identical fragile self-select pattern on
--     user_profiles; the audit_log policies here were originally drafted with the
--     SAME EXISTS(SELECT ... FROM user_profiles) self-referential shape and have
--     been switched to is_admin() so they cannot be silently coupled to
--     user_profiles' SELECT-policy visibility.
--
-- GROUNDING (from grep of src/ and supabase/functions/):
--   * audit_log        — WRITE-ONLY by authenticated admins (16 .insert sites in
--                        the admin tabs); NEVER read by the app; also written by
--                        the (now-locked) definer functions which run as postgres.
--   * contacts         — NO consumer IN THIS REPO (0 refs). 13 rows of
--                        names+emails exist. HELD BACK: a separate speaker-approval
--                        side-app on the SAME database is reported to use this
--                        table; its access role (anon vs authenticated vs
--                        service_role) is NOT yet grounded. Locking RLS here could
--                        silently break that app. See HOLD block.
--   * talk_transcripts — NO consumer IN THIS REPO (0 refs); 0 rows today. HELD
--                        BACK for the SAME reason as contacts (same side-app).
--   * portrait_history — NO app consumer (0 refs); only written by the unused
--                        definer functions approve_portrait/reject_portrait.
--   * media_people, media_callings, story_people, story_time_periods — NO app
--     consumer (0 refs); legacy Phase-2 junction tables; empty.
--
-- POLICY DECISIONS:
--   * audit_log: needs policies, because authenticated admins INSERT to it and a
--     read viewer is a known future deliverable. Add admin-only SELECT (future
--     viewer) and admin-only INSERT (preserve today's audit writes), both gated
--     by public.is_admin(). NO UPDATE/DELETE policy => the log is immutable via
--     the API (only service_role/postgres/definer functions, which bypass RLS,
--     can modify).
--   * portrait_history + the 4 legacy junction tables: NO app consumer => NO
--     policy needed. RLS enabled with NO policy DENIES everything to
--     anon/authenticated, while service_role and the owner (postgres) — and thus
--     the definer functions — continue to work (they bypass RLS).
--
-- Anon table grants are revoked where they serve no purpose (the 6 locked here).
--
-- ---------------------------------------------------------------------
-- HOLD BLOCK — contacts and talk_transcripts (DO NOT enable RLS yet)
-- ---------------------------------------------------------------------
-- A separate speaker-approval application shares this Postgres database and is
-- reported to read/write contacts (and talk_transcripts). This repo has zero
-- references to either table, so the in-repo grep CANNOT see how that side-app
-- authenticates. Enabling RLS with no policy would default-DENY anon and
-- authenticated — which would silently break the side-app if it talks to the DB
-- with the anon or authenticated key (the common case for a Supabase front-end).
--
-- REQUIRED BEFORE locking these two down (own session/ticket):
--   1. Identify the side-app's DB role: does it use the anon key, a logged-in
--      (authenticated) user, or the service_role secret key?
--   2. If service_role only  -> safe to ENABLE RLS with no policy (service_role
--      bypasses RLS); mirror the portrait_history treatment.
--   3. If anon/authenticated  -> write explicit policies matching its real
--      access pattern BEFORE enabling RLS; do not default-deny it.
-- Until that grounding exists, contacts and talk_transcripts are LEFT AS-IS by
-- this file. Their original statements are preserved COMMENTED OUT below so the
-- intended lockdown is not lost.
--
-- WHAT BREAKS IF APPLIED:
--   * Nothing user-facing. The only app interaction with any of these tables is
--     admin audit_log inserts, which the admin-only INSERT policy preserves
--     (and which are best-effort/non-fatal in the app regardless).
--   * If a future/out-of-repo consumer (e.g. an edge function using the anon or
--     authenticated key) reads/writes contacts/talk_transcripts/etc., it would
--     now be denied. None exists in this repo; flag for the owner to confirm no
--     external consumer before applying.
-- ROLLBACK (per statement, noted inline): ALTER TABLE ... DISABLE ROW LEVEL
--   SECURITY; DROP POLICY ...; GRANT ... TO anon;  (restores prior open state).
--
-- Supabase SQL Editor compatible: atomic statements, no BEGIN/COMMIT. ORDERING
-- matters ONLY for audit_log: policies are created BEFORE RLS is enabled, so
-- there is no window where admin inserts are denied.
-- =====================================================================


-- =====================================================================
-- audit_log  (191 rows; write-only by admins today; future read viewer)
-- =====================================================================

-- STATEMENT 1 — admin-only SELECT policy (created before RLS is enabled).
-- Enables a future admin audit viewer and gates reads to admins. Uses the
-- File G helper public.is_admin() (SECURITY DEFINER, bypasses RLS) instead of a
-- self-select of user_profiles, so this gate does NOT depend on user_profiles'
-- SELECT-policy visibility. Scoped TO authenticated (anon is never an admin).
-- REVERSIBLE: DROP POLICY "Admins can read audit log" ON public.audit_log;
CREATE POLICY "Admins can read audit log" ON public.audit_log
  FOR SELECT
  TO authenticated
  USING (public.is_admin());

-- STATEMENT 2 — admin-only INSERT policy (preserves today's audit writes; blocks
-- a signed-in non-admin from forging entries). Created before RLS is enabled.
-- Same is_admin() gate as Statement 1.
-- REVERSIBLE: DROP POLICY "Admins can insert audit log" ON public.audit_log;
CREATE POLICY "Admins can insert audit log" ON public.audit_log
  FOR INSERT
  TO authenticated
  WITH CHECK (public.is_admin());

-- STATEMENT 3 — enable RLS. With the two policies above already present, admin
-- reads (future) and admin inserts (today) work; anon and non-admin authenticated
-- are denied; no UPDATE/DELETE policy => immutable via API. service_role/postgres
-- and the definer functions bypass RLS and are unaffected.
-- REVERSIBLE: ALTER TABLE public.audit_log DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_log ENABLE ROW LEVEL SECURITY;

-- STATEMENT 4 — remove anon's table grants (anon has no business touching the
-- audit log). authenticated grants are RETAINED because the admin INSERT policy
-- needs the underlying INSERT grant to function; the policy gates it to admins.
-- REVERSIBLE: GRANT SELECT, INSERT, UPDATE, DELETE ON public.audit_log TO anon;
REVOKE ALL ON public.audit_log FROM anon;


-- =====================================================================
-- contacts  (13 rows: name + email PII)  — *** HELD BACK, NOT APPLIED ***
-- =====================================================================
-- Shared with a separate speaker-approval side-app; its DB role is not yet
-- grounded (see HOLD block in the header). Do NOT enable RLS here until that
-- app's access pattern is known — a default-deny could silently break it.
-- Original intended statements preserved commented out:
--   -- STATEMENT 5 — enable RLS (default-deny for anon/authenticated).
--   ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;
--   -- STATEMENT 6 — revoke anon grants (belt-and-suspenders alongside RLS).
--   REVOKE ALL ON public.contacts FROM anon;


-- =====================================================================
-- talk_transcripts  (0 rows)  — *** HELD BACK, NOT APPLIED ***
-- =====================================================================
-- Same speaker-approval side-app dependency as contacts. Held back.
-- Original intended statements preserved commented out:
--   -- STATEMENT 7 — enable RLS (default-deny).
--   ALTER TABLE public.talk_transcripts ENABLE ROW LEVEL SECURITY;
--   -- STATEMENT 8 — revoke anon grants.
--   REVOKE ALL ON public.talk_transcripts FROM anon;


-- =====================================================================
-- portrait_history  (0 rows; only written by unused definer fns) — RLS on, no policy.
-- =====================================================================
-- STATEMENT 9 — enable RLS. REVERSIBLE: ALTER TABLE ... DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.portrait_history ENABLE ROW LEVEL SECURITY;
-- STATEMENT 10 — revoke anon grants. REVERSIBLE: GRANT SELECT,INSERT,UPDATE,DELETE ON public.portrait_history TO anon;
REVOKE ALL ON public.portrait_history FROM anon;


-- =====================================================================
-- Legacy junction tables: media_people, media_callings, story_people,
-- story_time_periods (0 rows; NO app consumer) — RLS on, no policy each.
-- =====================================================================
-- STATEMENT 11 — media_people.       REVERSIBLE: ALTER TABLE ... DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.media_people ENABLE ROW LEVEL SECURITY;
-- STATEMENT 12 — revoke anon.        REVERSIBLE: GRANT SELECT,INSERT,UPDATE,DELETE ON public.media_people TO anon;
REVOKE ALL ON public.media_people FROM anon;
-- STATEMENT 13 — media_callings.     REVERSIBLE: ALTER TABLE ... DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.media_callings ENABLE ROW LEVEL SECURITY;
-- STATEMENT 14 — revoke anon.        REVERSIBLE: GRANT SELECT,INSERT,UPDATE,DELETE ON public.media_callings TO anon;
REVOKE ALL ON public.media_callings FROM anon;
-- STATEMENT 15 — story_people.       REVERSIBLE: ALTER TABLE ... DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.story_people ENABLE ROW LEVEL SECURITY;
-- STATEMENT 16 — revoke anon.        REVERSIBLE: GRANT SELECT,INSERT,UPDATE,DELETE ON public.story_people TO anon;
REVOKE ALL ON public.story_people FROM anon;
-- STATEMENT 17 — story_time_periods. REVERSIBLE: ALTER TABLE ... DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.story_time_periods ENABLE ROW LEVEL SECURITY;
-- STATEMENT 18 — revoke anon.        REVERSIBLE: GRANT SELECT,INSERT,UPDATE,DELETE ON public.story_time_periods TO anon;
REVOKE ALL ON public.story_time_periods FROM anon;


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm RLS is now enabled on the 6 tables locked here (NOT contacts /
--    talk_transcripts, which are held back):
--       SELECT relname, relrowsecurity
--         FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
--        WHERE n.nspname='public' AND relname IN
--          ('audit_log','portrait_history',
--           'media_people','media_callings','story_people','story_time_periods')
--        ORDER BY relname;
--    Expect relrowsecurity = true for all 6. (contacts/talk_transcripts remain
--    false by design until the side-app is grounded.)
--
-- 2. Confirm anon holds NO grants on the 6 tables (expect no 'anon' rows):
--       SELECT c.relname, pg_get_userbyid(a.grantee) AS grantee, a.privilege_type
--         FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
--         LEFT JOIN LATERAL aclexplode(c.relacl) a ON true
--        WHERE n.nspname='public' AND c.relname IN
--          ('audit_log','portrait_history',
--           'media_people','media_callings','story_people','story_time_periods')
--          AND pg_get_userbyid(a.grantee)='anon';
--    Expect: zero rows.
--
-- 3. Confirm audit_log policies exist and are admin-scoped:
--       SELECT policyname, cmd, qual, with_check FROM pg_policies
--        WHERE schemaname='public' AND tablename='audit_log' ORDER BY policyname;
--
-- 4. Re-run get_advisors(security); the 8 rls_disabled_in_public findings should clear.
--
-- 5. Behavioral (test/staging, not a prod write): an admin action that writes an
--    audit_log entry still succeeds; an anon PostgREST GET/POST/PATCH/DELETE on
--    any of the 8 tables is now denied.
-- =====================================================================
