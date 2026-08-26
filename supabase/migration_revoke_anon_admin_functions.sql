-- =====================================================================
-- migration_revoke_anon_admin_functions.sql   (APPLIED TO PRODUCTION 2026-08-25)
-- =====================================================================
-- STATUS: APPLIED TO PRODUCTION on 2026-08-25 by the project owner via the
--   Supabase SQL Editor, WITH ONE DEVIATION (below).
--
--   STANDS: Group 1 — EXECUTE on the 13 SECURITY DEFINER admin_* action
--   functions was revoked from PUBLIC/anon/authenticated and remains revoked.
--   Verified via the 2026-08-25 advisor pass: none of the 13 appear in the
--   anon_/authenticated_security_definer_function_executable lints.
--
--   DEVIATION: Group 2 — the two trigger functions
--   (enforce_user_profiles_privileged_columns, handle_new_user) had EXECUTE
--   re-granted to PUBLIC, anon, and authenticated after the initial revoke,
--   during troubleshooting of the admin "cannot edit another user's profile"
--   bug. That revoke was SUSPECTED as the cause and rolled back; it was LATER
--   DETERMINED NOT to be the cause — the real cause is the File D SELECT-policy
--   visibility change (an admin UPDATE ... WHERE id=<other> matches zero rows
--   because no SELECT/ALL policy makes the target row visible; fixed by File G).
--   So the Group 2 re-grant was an unnecessary red-herring rollback. It is
--   BENIGN as it stands: both functions return type `trigger` and are therefore
--   not invocable as PostgREST RPCs, so the anon/authenticated EXECUTE grant is
--   not actually reachable — it only re-triggers the (WARN-level)
--   anon_/authenticated_security_definer_function_executable lint. Re-applying
--   just the Group 2 revokes (Statements below) is safe and closes that lint;
--   sequence it AFTER File G so no one associates it with the edit bug again.
--   (Note: File B's CREATE OR REPLACE of enforce_user_profiles_privileged_columns
--   preserves ACLs, so it does not by itself explain the grant; the re-grant was
--   a deliberate manual step.)
--
--   Kept in-repo as the version-controlled record of what was applied; the SQL
--   below is unchanged from what ran.
-- =====================================================================
-- File E of the same-day security remediation. Closes the most severe live
-- finding from the advisor pass: 13 SECURITY DEFINER "admin_*" action functions
-- (plus 2 trigger functions) are EXECUTE-able by PUBLIC / anon / authenticated
-- and contain NO internal authorization check. Because they run as their owner
-- (postgres), any unauthenticated caller can invoke, e.g.:
--     POST /rest/v1/rpc/admin_redact_person {"p_person_id": "...", "p_reason":"..."}
-- and redact any person + mass-reject their memories; or approve/reject any
-- memory/photo/portrait/correction; etc. (admin_toggle_user_role's role write is
-- currently blocked by the File B trigger, but its grant is still wrong.)
--
-- GROUNDING (why this is safe): the application calls .rpc() NOWHERE — grep of
-- src/ and supabase/functions/ returns zero hits. Every admin action in the app
-- is done via direct table .update()/.insert() calls, not these RPCs. So these
-- functions are orphaned/unused, and revoking EXECUTE from anon AND authenticated
-- breaks no application code path. service_role and postgres retain EXECUTE.
--
-- DECISION PER FUNCTION: revoke anon AND authenticated (and PUBLIC) on all 15.
-- No function is called by the app as an authenticated admin, so the "add an
-- in-body admin check instead of revoking authenticated" branch does NOT apply
-- here. A template for that check is included, COMMENTED OUT, only for the future
-- case where these RPCs get wired to an authenticated admin UI (see bottom).
--
-- IMPORTANT — BOTH revokes are required. The functions carry an explicit grant to
-- anon/authenticated AND a PUBLIC grant (aclexplode shows grantee OID 0 = PUBLIC).
-- Revoking only anon/authenticated leaves the PUBLIC grant, and anon/authenticated
-- are members of PUBLIC — so EXECUTE must be revoked FROM PUBLIC too.
--
-- WHAT BREAKS IF APPLIED: nothing in the app (no .rpc() callers). Only direct
-- RPC invocation by anon/authenticated is removed. Trigger firing is unaffected
-- (Postgres does not check EXECUTE privilege to fire a trigger; the two trigger
-- functions cannot be called as RPCs regardless).
-- ROLLBACK (whole file): re-grant, e.g.
--     GRANT EXECUTE ON FUNCTION public.<name>(<args>) TO anon, authenticated;
--   (per function; only to restore the prior insecure state).
--
-- Supabase SQL Editor compatible: atomic statements, no BEGIN/COMMIT. Statement
-- order is irrelevant (independent revokes); grouped for readability.
-- =====================================================================


-- ---------------------------------------------------------------------
-- GROUP 1 — The 13 SECURITY DEFINER "action" functions (no internal auth check).
-- Each: revoke EXECUTE from PUBLIC, anon, authenticated. service_role/postgres keep it.
-- REVERSIBLE per line: GRANT EXECUTE ON FUNCTION ... TO anon, authenticated;  (rollback only)
-- ---------------------------------------------------------------------
REVOKE EXECUTE ON FUNCTION public.admin_approve_memory(uuid)             FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_approve_photo(uuid)             FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_approve_portrait(uuid)          FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_complete_correction(uuid, text) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_dismiss_correction(uuid, text)  FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_redact_person(uuid, text)       FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_reject_memory(uuid, text)       FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_reject_photo(uuid, text)        FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_reject_portrait(uuid, text)     FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_toggle_user_role(uuid)          FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.admin_unredact_person(uuid)           FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.approve_portrait(uuid, uuid)          FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.reject_portrait(uuid, uuid, text)     FROM PUBLIC, anon, authenticated;


-- ---------------------------------------------------------------------
-- GROUP 2 — The 2 trigger functions. Revoking EXECUTE is defense-in-depth and
-- silences the anon_/authenticated_security_definer_function_executable lint.
-- It does NOT affect trigger firing (triggers do not check EXECUTE) and these
-- cannot be invoked as RPCs (they return `trigger`).
-- REVERSIBLE: GRANT EXECUTE ... TO anon, authenticated;  (rollback only)
-- ---------------------------------------------------------------------
REVOKE EXECUTE ON FUNCTION public.enforce_user_profiles_privileged_columns() FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.handle_new_user()                          FROM PUBLIC, anon, authenticated;


-- ---------------------------------------------------------------------
-- OPTIONAL / NOT NEEDED TODAY — in-body admin check template.
-- Only relevant IF, in the future, one of the action functions is wired to an
-- authenticated admin UI (so `authenticated` must keep EXECUTE). In that case,
-- do NOT rely on the grant alone — add an internal check so a non-admin caller
-- cannot invoke it. Example for admin_redact_person (kept COMMENTED — applying it
-- would recreate the function; not part of this migration):
--
--   CREATE OR REPLACE FUNCTION public.admin_redact_person(p_person_id uuid, p_reason text DEFAULT NULL)
--   RETURNS void LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
--   BEGIN
--     IF NOT EXISTS (SELECT 1 FROM public.user_profiles up
--                     WHERE up.id = auth.uid() AND up.role = 'admin'::user_role) THEN
--       RAISE EXCEPTION 'Not authorized';
--     END IF;
--     -- ... original body ...
--   END $$;
--
-- Since NO function is app-called today, the revokes above are the complete fix
-- and this template is not applied.


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm no anon/authenticated/PUBLIC EXECUTE remains on the 15 functions
--    (expect only service_role/postgres, and NO 'anon', 'authenticated', or
--    PUBLIC/'-' grantee rows):
--       SELECT p.proname,
--              COALESCE((SELECT string_agg(COALESCE(pg_get_userbyid(a.grantee),'PUBLIC')||':'||a.privilege_type, ', ')
--                         FROM aclexplode(p.proacl) a), '(no ACL = owner only)') AS execute_grants
--         FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
--        WHERE n.nspname='public' AND p.proname IN (
--          'admin_approve_memory','admin_approve_photo','admin_approve_portrait','admin_complete_correction',
--          'admin_dismiss_correction','admin_redact_person','admin_reject_memory','admin_reject_photo',
--          'admin_reject_portrait','admin_toggle_user_role','admin_unredact_person','approve_portrait',
--          'reject_portrait','enforce_user_profiles_privileged_columns','handle_new_user')
--        ORDER BY p.proname;
--
-- 2. Re-run get_advisors(security); the 15 anon_/authenticated_security_definer_function_executable
--    findings should clear (function_search_path_mutable is a separate lint, not addressed here).
--
-- 3. Confirm signups still work (handle_new_user trigger unaffected) and an admin
--    display-name edit still works (enforce_... trigger unaffected) — behavioral,
--    do in a test/staging context, not by writing to prod.
-- =====================================================================
