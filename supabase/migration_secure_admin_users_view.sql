-- =====================================================================
-- migration_secure_admin_users_view.sql   (DRAFT — FOR HUMAN REVIEW)
-- =====================================================================
-- DO NOT APPLY BLINDLY. Split from the earlier combined draft
-- (migration_secure_user_profiles.sql), which this file + its sibling
-- migration_block_role_escalation.sql together supersede. This file is
-- independently appliable and addresses ONE issue only:
--
--   admin_users_view exposes auth.users.email for ALL 42 accounts to the
--   anon (unauthenticated) role. The view has no security_invoker, so on
--   PostgreSQL 17 it runs as its owner (postgres), which bypasses RLS and can
--   read auth.users; anon holds SELECT on the view; therefore
--   GET /rest/v1/admin_users_view with only the anon key returns every
--   account's email.
--
-- Written for the Supabase web SQL Editor: atomic statements only, no
-- BEGIN/COMMIT. Two statements, ordered so the leak is closed by the first
-- and the second is defense-in-depth; the site is never in a broken state.
--
-- COLUMN-SHAPE CHECK (done before finalizing this draft): the live view was
-- re-fetched via pg_get_viewdef('public.admin_users_view'::regclass, true) and
-- returns these columns in this order:
--     id, email, display_name, role, view_blocked, view_blocked_at,
--     view_blocked_reason, created_at
-- Statement 1 reproduces that exact column set/order (a hard requirement of
-- CREATE OR REPLACE VIEW) and only adds a WHERE clause.
-- =====================================================================


-- ---------------------------------------------------------------------
-- STATEMENT 1 — Recreate admin_users_view WITH an admin-only row gate.
-- ---------------------------------------------------------------------
-- Identical columns/order to the current view; the only change is the added
-- WHERE EXISTS(...) clause, which returns rows ONLY when the caller is an admin.
--
-- The view is intentionally LEFT AS SECURITY DEFINER (security_invoker NOT set).
-- It must run as owner `postgres` to read auth.users for the email column; a
-- security_invoker view would run as the caller, and neither anon nor
-- authenticated can read auth.users, which would break the Users tab for real
-- admins too. Safety instead comes from the in-body auth.uid() admin gate.
-- auth.uid() reads the request JWT and works inside a definer view; the EXISTS
-- subquery reads user_profiles as owner (bypassing RLS) so it reliably sees the
-- caller's role, and is a SELECT (no recursion).
--
-- Effect the instant this runs:
--   * admin caller (authenticated, role='admin')  -> all rows (Users tab works)
--   * non-admin authenticated caller              -> 0 rows
--   * anon caller                                 -> 0 rows
-- So the email leak is closed here; Statement 2 is belt-and-suspenders. No
-- admin-facing functionality is interrupted (readers useUsers.ts:25 and
-- useAdminStats.ts:49 both run as an authenticated admin).
--
-- REVERSIBLE: yes. Re-run CREATE OR REPLACE VIEW with the original (insecure)
-- body, preserved here for rollback only:
--     SELECT up.id, au.email, up.display_name, up.role, up.view_blocked,
--            up.view_blocked_at, up.view_blocked_reason, up.created_at
--       FROM user_profiles up
--       LEFT JOIN auth.users au ON up.id = au.id;

CREATE OR REPLACE VIEW public.admin_users_view AS
  SELECT up.id,
         au.email,
         up.display_name,
         up.role,
         up.view_blocked,
         up.view_blocked_at,
         up.view_blocked_reason,
         up.created_at
    FROM public.user_profiles up
    LEFT JOIN auth.users au ON up.id = au.id
   WHERE EXISTS (
           SELECT 1
             FROM public.user_profiles adm
            WHERE adm.id = auth.uid()
              AND adm.role = 'admin'::user_role
         );


-- ---------------------------------------------------------------------
-- STATEMENT 2 — Remove anon's access to the view entirely (defense-in-depth).
-- ---------------------------------------------------------------------
-- src/ dependency scan confirms admin_users_view is read in EXACTLY two places,
-- both admin-only and both as an authenticated admin (useUsers.ts:25,
-- useAdminStats.ts:49). Nothing reads it as anon, so revoking anon is safe.
-- SELECT for `authenticated` is intentionally KEPT (load-bearing for admins;
-- the Statement 1 gate already returns 0 rows to non-admins).
--
-- Note: production currently grants anon the FULL privilege set on this view
-- (DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE);
-- REVOKE ALL strips all of them. The write privileges are non-functional on a
-- join view anyway, so this is zero-impact beyond removing the SELECT leak.
--
-- REVERSIBLE: yes. GRANT SELECT ON public.admin_users_view TO anon;
--   (Rollback only — reverting re-exposes the view to anon.)

REVOKE ALL ON public.admin_users_view FROM anon;


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm the view now carries the admin gate (expect the WHERE EXISTS ...
--    role='admin' clause to appear):
--       SELECT pg_get_viewdef('public.admin_users_view'::regclass, true);
--
-- 2. Confirm anon has NO privilege on the view; authenticated SELECT remains:
--       SELECT pg_get_userbyid(a.grantee) AS grantee, a.privilege_type
--         FROM pg_class c
--         JOIN pg_namespace n ON n.oid = c.relnamespace
--         LEFT JOIN LATERAL aclexplode(c.relacl) a ON true
--        WHERE n.nspname='public' AND c.relname='admin_users_view'
--        ORDER BY grantee, privilege_type;
--    Expect: zero 'anon' rows; an 'authenticated' / 'SELECT' row still present.
--
-- 3. Optional functional check (do NOT rely on prod data): from an anon
--    PostgREST call, GET /rest/v1/admin_users_view should now return [].
--    From an admin session it should return all rows. Verify in a test project
--    or with a throwaway token rather than by writing to production.
-- =====================================================================
