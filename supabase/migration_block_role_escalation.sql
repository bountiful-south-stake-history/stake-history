-- =====================================================================
-- migration_block_role_escalation.sql   (DRAFT — FOR HUMAN REVIEW)
-- =====================================================================
-- DO NOT APPLY BLINDLY. Split from the earlier combined draft
-- (migration_secure_user_profiles.sql). Independently appliable. Addresses ONE
-- issue only:
--
--   Privilege escalation. RLS policy "Users can update own profile" (role
--   authenticated, USING auth.uid()=id, NO WITH CHECK) + a table-level UPDATE
--   grant to authenticated on ALL columns (no column-level ACLs, no CHECK
--   constraint, no existing trigger) lets a signed-in non-admin UPDATE their
--   own row and set role='admin'. Confirmed by catalog inspection.
--
-- FIX: a BEFORE UPDATE trigger that blocks changes to the privileged columns
-- (role, view_blocked, view_blocked_at, view_blocked_reason) UNLESS the caller
-- is trusted. This version corrects a defect in the combined draft where the
-- guard raised whenever auth.uid() was null — which would have blocked the ONLY
-- recovery path for a locked-out administrator (a developer promoting an
-- account directly in the database, where auth.uid() is always null).
--
-- Written for the Supabase web SQL Editor: atomic statements only, no
-- BEGIN/COMMIT. Function is created before the trigger that references it.
--
-- ---------------------------------------------------------------------
-- DISCRIMINATOR — who passes, who is blocked, and why it is sound
-- ---------------------------------------------------------------------
-- The signal used is the PostgREST request GUC `request.jwt.claims`, NOT the
-- database role name. Rationale: this function is SECURITY DEFINER, so
-- current_user is rewritten to the owner (postgres) and cannot identify the
-- caller; and PostgREST logs every API role in through the shared `authenticator`
-- login, so session_user is 'authenticator' for anon/authenticated/service_role
-- alike. Only the JWT GUC distinguishes the real caller, and it is set by
-- PostgREST per request and is immune to the SECURITY DEFINER context. This was
-- verified read-only against production: a direct session returns
-- request.jwt.claims = NULL and auth.uid() = NULL.
--
-- Decision table (only reached when a PRIVILEGED column actually changed):
--   (A) request.jwt.claims IS NULL/''  -> PERMIT.
--       No PostgREST context = a direct DB session: Supabase SQL Editor, psql,
--       the migration runner, dashboard SQL. These are the trusted operator /
--       developer paths, including locked-out-admin recovery. MUST survive.
--   (B) JWT role claim = 'service_role' -> PERMIT.
--       Trusted backend calling through the API with the secret service key
--       (edge functions / server jobs). No app code updates these columns via
--       service_role today, but permitting it keeps future backend admin tooling
--       working and is safe because the service key is a server-only secret.
--   (C) Any other API request (authenticated end-user, or anon) -> require the
--       caller to be an admin (auth.uid() -> user_profiles.role='admin'); if not,
--       RAISE and block. This is the exact vector being closed: a non-admin
--       end-user trying to change role/view_blocked on any row.
-- Non-privileged column updates (display_name, weekly_digest_enabled,
-- has_seen_watch_feature, ...) bypass all of the above and always pass.
--
-- Why this discrimination is sound: the only way to obtain a JWT whose role
-- claim is 'service_role' is to hold the service secret key (server-side only);
-- an end-user's browser only ever gets an 'authenticated' or 'anon' JWT. A
-- direct DB session cannot be initiated by a web client at all. So (A) and (B)
-- are genuinely trusted channels, and (C) is the only channel a malicious
-- end-user can use — which is exactly where enforcement is applied.
--
-- ---------------------------------------------------------------------
-- Can an ANON caller reach this trigger at all?  NO.
-- ---------------------------------------------------------------------
-- From the retrieved RLS policies on user_profiles, the only UPDATE policies are:
--   * "Users can update own profile" — role {authenticated} only (not anon).
--   * "Admin can update any profile" — role {public}, USING EXISTS(admin with
--     auth.uid()); for anon, auth.uid() is null so the predicate is false.
-- RLS is permissive/OR-combined; for an anon caller NO permissive UPDATE policy
-- yields true, so the UPDATE is denied at the RLS layer and matches zero rows.
-- A BEFORE UPDATE trigger only fires for rows actually being updated, so it
-- never fires for anon. (The anon table-level UPDATE grant is therefore already
-- inert.) The trigger's real audience is authenticated NON-admins editing their
-- own row — branch (C) above. Branch (C) still checks for anon defensively in
-- case RLS is ever loosened, but under today's policies anon cannot reach it.
-- =====================================================================


-- ---------------------------------------------------------------------
-- STATEMENT 1 — Guard function.
-- ---------------------------------------------------------------------
-- SECURITY DEFINER + pinned search_path so the admin lookup reads user_profiles
-- reliably (bypassing RLS) and cannot be hijacked by a mutable search_path.
-- IS DISTINCT FROM is null-safe. Discrimination uses only the JWT GUC (see the
-- header), never current_user/session_user.
--
-- REVERSIBLE: yes. Drop the trigger (Statement 2) first, then:
--   DROP FUNCTION public.enforce_user_profiles_privileged_columns();

CREATE OR REPLACE FUNCTION public.enforce_user_profiles_privileged_columns()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_claims   text := current_setting('request.jwt.claims', true);
  v_jwt_role text;
BEGIN
  -- Fast path: no privileged column changed -> always allow.
  IF NEW.role               IS NOT DISTINCT FROM OLD.role
     AND NEW.view_blocked        IS NOT DISTINCT FROM OLD.view_blocked
     AND NEW.view_blocked_at     IS NOT DISTINCT FROM OLD.view_blocked_at
     AND NEW.view_blocked_reason IS NOT DISTINCT FROM OLD.view_blocked_reason
  THEN
    RETURN NEW;
  END IF;

  -- (A) No PostgREST/API JWT context => trusted direct DB session
  --     (SQL Editor, psql, migration runner). PERMIT — recovery path.
  IF v_claims IS NULL OR v_claims = '' THEN
    RETURN NEW;
  END IF;

  -- Parse the JWT role claim (claims is valid JSON when PostgREST set it;
  -- guarded so a malformed value cannot error the whole UPDATE).
  BEGIN
    v_jwt_role := (v_claims::json ->> 'role');
  EXCEPTION WHEN others THEN
    v_jwt_role := NULL;
  END;

  -- (B) Trusted backend calling through the API with the service key. PERMIT.
  IF v_jwt_role = 'service_role' THEN
    RETURN NEW;
  END IF;

  -- (C) End-user API request (authenticated/anon): require an admin caller.
  IF EXISTS (
       SELECT 1
         FROM public.user_profiles up
        WHERE up.id = auth.uid()
          AND up.role = 'admin'::user_role
     ) THEN
    RETURN NEW;
  END IF;

  RAISE EXCEPTION
    'Only administrators may change role or view-access fields on user_profiles';
END;
$$;


-- ---------------------------------------------------------------------
-- STATEMENT 2 — Attach the trigger (after the function exists, so it never
-- references a missing function). user_profiles currently has NO other
-- non-internal triggers (verified via pg_trigger), so no interaction.
-- ---------------------------------------------------------------------
-- REVERSIBLE: yes.
--   DROP TRIGGER trg_user_profiles_enforce_privileged_columns ON public.user_profiles;

DROP TRIGGER IF EXISTS trg_user_profiles_enforce_privileged_columns ON public.user_profiles;

CREATE TRIGGER trg_user_profiles_enforce_privileged_columns
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.enforce_user_profiles_privileged_columns();


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm the trigger exists and is enabled ('O' = enabled):
--       SELECT tgname, tgenabled
--         FROM pg_trigger
--        WHERE tgrelid='public.user_profiles'::regclass AND NOT tgisinternal;
--
-- 2. Confirm the function body is the intended guard:
--       SELECT pg_get_functiondef(
--                'public.enforce_user_profiles_privileged_columns()'::regprocedure);
--
-- 3. Confirm the recovery path still works FROM THE SQL EDITOR itself: this
--    session has request.jwt.claims = NULL, so branch (A) permits. A promotion
--    such as
--       UPDATE public.user_profiles SET role='admin' WHERE id = '<uuid>';
--    will be ALLOWED here. (Run only as a real, intended promotion — it writes.)
--
-- 4. Functional check of the BLOCK: do this in a STAGING/TEST project or with a
--    throwaway account, NOT by writing to production. Signed in via the API as a
--    NON-admin, attempt:
--       UPDATE public.user_profiles SET role='admin' WHERE id = auth.uid();
--    Expect: ERROR "Only administrators may change role or view-access fields".
--    Signed in as an admin, changing another user's role should still succeed.
-- =====================================================================
