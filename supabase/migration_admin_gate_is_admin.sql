-- =====================================================================
-- migration_admin_gate_is_admin.sql   (DRAFT — FOR HUMAN REVIEW, UNAPPLIED)
-- =====================================================================
-- File G of the security-remediation arc.
--
-- PURPOSE (revised): fix the admin Users-tab breakage AND remove the fragile
-- self-referential admin gate. Two things ship here:
--   (1) THE FIX — restore admin SELECT-visibility of all user_profiles rows,
--       via a new SELECT policy gated by public.is_admin(). This is what makes
--       admin cross-user writes work again (see MECHANISM below).
--   (2) HARDENING — rewrite the existing "Admin can update any profile" UPDATE
--       policy to call is_admin() instead of an inline self-select, so the
--       admin gate no longer depends on which SELECT policies happen to exist.
--
-- ---------------------------------------------------------------------
-- MECHANISM — why the Users tab silently broke, and why (1) is the real fix
-- ---------------------------------------------------------------------
-- Confirmed root cause: PostgreSQL applies SELECT policies to an UPDATE that
-- reads columns of the relation. From the CREATE POLICY reference (UPDATE):
--   "Typically an UPDATE command also needs to read data from columns in the
--    relation being updated (e.g., in a WHERE clause ...). In this case, SELECT
--    rights are also required on the relation being updated, and the appropriate
--    SELECT or ALL policies will be applied in addition to the UPDATE policies.
--    Thus the user must have access to the row(s) being updated through a SELECT
--    or ALL policy in addition to being granted permission to update the row(s)
--    via an UPDATE or ALL policy."
-- The admin Users tab issues UPDATE ... WHERE id = <other user> (supabase-js
-- .update({...}).eq('id', userId) -> PATCH /user_profiles?id=eq.<id>). File D
-- dropped the two USING(true) SELECT policies, leaving only "Users can view own
-- profile" (auth.uid() = id). An admin therefore has NO SELECT/ALL policy that
-- makes another user's row visible, so the UPDATE matches ZERO rows and returns
-- success having changed nothing. The "Admin can update any profile" UPDATE
-- policy's USING(EXISTS(... self-select ...)) is satisfiable for a real admin
-- (the subquery sees the admin's own row via the own-row SELECT policy and
-- returns true) but is never the deciding factor — the row is filtered out by
-- SELECT-visibility before the UPDATE policy matters. So the actual fix is to
-- restore an admin SELECT policy, not to touch the UPDATE policy.
--
-- (The earlier draft of this file only rewrote the UPDATE policy. That alone
--  does NOT fix the breakage — hence this revision.)
--
-- ---------------------------------------------------------------------
-- WHAT BREAKS IF APPLIED
-- ---------------------------------------------------------------------
--   * Nothing user-facing breaks. This is additive + a like-for-like policy
--     swap. After apply, admin cross-user writes (display name, role toggle,
--     restrict/restore view) work again because the target rows become
--     SELECT-visible to admins.
--   * Behavioral change (intended): an admin can now SELECT ALL user_profiles
--     rows directly from the base table (including the email column), not only
--     via admin_users_view. This is admin-only and matches what admin_users_view
--     already exposes to admins. It does NOT widen access for anon or non-admin
--     authenticated users (see the anon note on Statement 3).
--   * If the app-side rows-affected fix (AdminUsersTab .select() check) is
--     deployed, note that BEFORE this migration those four writes would then
--     surface an explicit "no row updated" error instead of a phantom success;
--     AFTER this migration they succeed. Either order is safe; they are
--     independent. Deploying the app check first simply makes the current
--     breakage loud instead of silent until this migration lands.
--
-- ROLLBACK (whole file; restores exact prior state):
--   DROP POLICY "Admin can update any profile" ON public.user_profiles;
--   CREATE POLICY "Admin can update any profile" ON public.user_profiles
--     FOR UPDATE TO public
--     USING (EXISTS (SELECT 1 FROM public.user_profiles up
--                     WHERE up.id = auth.uid() AND up.role = 'admin'::user_role))
--     WITH CHECK (EXISTS (SELECT 1 FROM public.user_profiles up
--                     WHERE up.id = auth.uid() AND up.role = 'admin'::user_role));
--   DROP POLICY "Admins can view all profiles" ON public.user_profiles;
--   DROP FUNCTION public.is_admin();
--   (Per-statement rollback is also noted inline.)
--
-- Supabase SQL Editor compatible: atomic statements, no BEGIN/COMMIT. ORDER
-- MATTERS: the function is created before the policies that call it, and the
-- SELECT policy (additive, safe) is created before the UPDATE policy is
-- swapped, so there is no window in which admin access is worse than today.
-- =====================================================================


-- ---------------------------------------------------------------------
-- STATEMENT 1 — the helper, public.is_admin().
-- ---------------------------------------------------------------------
-- Returns true iff the current API caller (auth.uid()) maps to a user_profiles
-- row with role='admin'. For an anon caller auth.uid() is null => no row =>
-- false.
--
-- WHY SECURITY DEFINER IS REQUIRED (not merely convenient):
--   This function is called from RLS policies ON user_profiles, and its body
--   SELECTs user_profiles. If it ran SECURITY INVOKER (as the calling user),
--   that inner SELECT would itself be subject to user_profiles' RLS policies —
--   including the very SELECT policy that calls is_admin() — which is a cycle
--   Postgres rejects at runtime with "infinite recursion detected in policy for
--   relation user_profiles". SECURITY DEFINER makes the body run as the function
--   OWNER (postgres), and the table owner BYPASSES RLS, so the inner SELECT does
--   NOT re-enter policy evaluation. That is exactly what breaks the recursion and
--   is why an inline EXISTS(self-select) is safe in an UPDATE policy (its
--   subquery is gated by the simple own-row SELECT policy) but is NOT safe in a
--   SELECT policy (it would gate itself). Routing the admin check through a
--   SECURITY DEFINER function makes it safe in BOTH positions.
--   STABLE: no writes, result constant within a statement (lets the planner
--   cache it). Pinned search_path = public: prevents search_path hijacking of
--   the SECURITY DEFINER body.
--
-- REVERSIBLE: DROP FUNCTION public.is_admin();  (revert the policies below first,
--   otherwise they would reference a missing function).
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
      FROM public.user_profiles up
     WHERE up.id = auth.uid()
       AND up.role = 'admin'::user_role
  );
$$;


-- ---------------------------------------------------------------------
-- STATEMENT 2 — lock down EXECUTE on the helper.
-- ---------------------------------------------------------------------
-- RLS policy expressions are evaluated as the querying role, so `authenticated`
-- must be able to EXECUTE is_admin(); anon and PUBLIC must not (an anon caller
-- is never an admin, and this keeps the function off the anon-callable surface).
-- service_role/postgres retain EXECUTE. The function takes no arguments and
-- returns only a boolean about the CALLER, so even a direct authenticated RPC
-- call leaks nothing.
-- REVERSIBLE: GRANT EXECUTE ON FUNCTION public.is_admin() TO PUBLIC;
REVOKE EXECUTE ON FUNCTION public.is_admin() FROM PUBLIC;
GRANT  EXECUTE ON FUNCTION public.is_admin() TO authenticated;


-- ---------------------------------------------------------------------
-- STATEMENT 3 — THE FIX: restore admin SELECT-visibility of all rows.
-- ---------------------------------------------------------------------
-- Adds a permissive SELECT policy so an admin can read every user_profiles row.
-- This is what makes admin cross-user UPDATEs match rows again (per the MECHANISM
-- note: the UPDATE's WHERE needs the row visible through a SELECT/ALL policy).
-- Scoped TO authenticated; the gate is public.is_admin().
--
-- DOES THIS REOPEN THE FILE D ANON EMAIL EXPOSURE?  NO, on two independent
-- grounds, either of which is sufficient:
--   (a) anon holds NO grant on public.user_profiles — File D's
--       REVOKE ALL ... FROM anon stands (re-verified: zero anon/PUBLIC privileges
--       on the table). With no table-level privilege, anon cannot SELECT it at
--       all, regardless of any policy.
--   (b) This policy is TO authenticated and its USING is public.is_admin(), which
--       returns false for anon (auth.uid() is null) AND for every non-admin
--       authenticated user. Only admins match. Non-admin authenticated users keep
--       seeing only their own row via "Users can view own profile".
-- Net: base-table all-row read is re-enabled for ADMINS ONLY. The File D closure
-- (no anon/broad base-table email read) is preserved.
--
-- REVERSIBLE: DROP POLICY "Admins can view all profiles" ON public.user_profiles;
CREATE POLICY "Admins can view all profiles" ON public.user_profiles
  FOR SELECT
  TO authenticated
  USING (public.is_admin());


-- ---------------------------------------------------------------------
-- STATEMENT 4 — HARDENING: rewrite the admin UPDATE policy to use is_admin().
-- ---------------------------------------------------------------------
-- Replaces the inline self-select with the helper and narrows scope from public
-- to authenticated (anon can never be an admin). This is NOT the fix (Statement 3
-- is); it removes the fragile self-referential pattern so the UPDATE gate no
-- longer depends on SELECT-policy visibility for its OWN subquery. Behavior for a
-- real admin is unchanged.
--
-- Ordering: DROP then CREATE, run as a single paste. Between them, cross-user
-- admin UPDATE momentarily has no admin UPDATE policy (own-row still works via
-- "Users can update own profile"); the window is ~0 in one paste, and it is
-- never WORSE than today because Statement 3 (visibility) is already in place.
--
-- REVERSIBLE (restore prior definition exactly):
--   DROP POLICY "Admin can update any profile" ON public.user_profiles;
--   CREATE POLICY "Admin can update any profile" ON public.user_profiles
--     FOR UPDATE TO public
--     USING (EXISTS (SELECT 1 FROM public.user_profiles up
--                     WHERE up.id = auth.uid() AND up.role = 'admin'::user_role))
--     WITH CHECK (EXISTS (SELECT 1 FROM public.user_profiles up
--                     WHERE up.id = auth.uid() AND up.role = 'admin'::user_role));
DROP POLICY IF EXISTS "Admin can update any profile" ON public.user_profiles;

CREATE POLICY "Admin can update any profile" ON public.user_profiles
  FOR UPDATE
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());


-- =====================================================================
-- NOT CHANGED HERE, and why
-- ---------------------------------------------------------------------
--  * The File B trigger enforce_user_profiles_privileged_columns() also uses
--    EXISTS(self-select) in branch (C). It is NOT fragile: that function is
--    SECURITY DEFINER and runs as postgres (bypasses RLS), so its self-select
--    always sees every row. Left as-is. (It could call is_admin() for DRY-ness;
--    not worth a function replace right now.)
--  * File F's audit_log policies use the same is_admin() helper and therefore
--    depend on THIS file being applied first. See migration_enable_rls_disabled_tables.sql.
-- =====================================================================


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe in the SQL Editor)
-- =====================================================================
-- 1. Helper exists, is SECURITY DEFINER, has a pinned search_path:
--       SELECT proname, prosecdef, provolatile, proconfig
--         FROM pg_proc WHERE proname='is_admin' AND pronamespace='public'::regnamespace;
--    Expect prosecdef=true, provolatile='s' (STABLE), proconfig contains search_path=public.
--
-- 2. EXECUTE grants are authenticated-only (no anon/PUBLIC):
--       SELECT COALESCE(pg_get_userbyid(a.grantee),'PUBLIC') AS grantee, a.privilege_type
--         FROM pg_proc p LEFT JOIN LATERAL aclexplode(p.proacl) a ON true
--        WHERE p.proname='is_admin' AND p.pronamespace='public'::regnamespace;
--    Expect: authenticated (+ owner/service_role); NO anon, NO PUBLIC.
--
-- 3. Policies now include the admin SELECT policy and the rewritten UPDATE policy:
--       SELECT polname, polcmd,
--              pg_get_expr(polqual,polrelid)      AS using_expr,
--              pg_get_expr(polwithcheck,polrelid) AS check_expr,
--              ARRAY(SELECT rolname FROM pg_roles WHERE oid = ANY(polroles)) AS roles
--         FROM pg_policy WHERE polrelid='public.user_profiles'::regclass ORDER BY polcmd, polname;
--    Expect "Admins can view all profiles" (SELECT, authenticated, using is_admin())
--    and "Admin can update any profile" (UPDATE, authenticated, using/check is_admin()).
--
-- 4. anon STILL has no grant on the base table (File D closure preserved):
--       SELECT COALESCE(pg_get_userbyid(a.grantee),'PUBLIC') AS grantee, a.privilege_type
--         FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
--         LEFT JOIN LATERAL aclexplode(c.relacl) a ON true
--        WHERE n.nspname='public' AND c.relname='user_profiles'
--          AND COALESCE(pg_get_userbyid(a.grantee),'PUBLIC') IN ('anon','PUBLIC');
--    Expect: zero rows.
--
-- 5. Behavioral (needs a signed-in admin; test/staging or a careful prod check):
--    - As admin, GET /rest/v1/user_profiles?id=eq.<other user>&select=id,display_name
--      now returns the row (was [] before this migration).
--    - As admin, editing another user's display name / toggling role / restrict /
--      restore now persists (rows affected = 1).
--    - As a NON-admin authenticated user, the same cross-user GET still returns []
--      and cross-user writes still match 0 rows.
-- =====================================================================
