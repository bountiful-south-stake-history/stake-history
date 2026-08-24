-- =====================================================================
-- migration_restrict_user_profiles_anon.sql   (DRAFT — FOR HUMAN REVIEW, UNAPPLIED)
-- =====================================================================
-- !!! ORDERING CONSTRAINT — READ BEFORE APPLYING !!!
-- DO NOT APPLY THIS FILE until BOTH of these are true:
--   (1) File C (migration_public_profile_names.sql) has been applied, AND
--   (2) the application code change that repoints usePhotoLikes.ts (all three
--       call sites) from public.user_profiles to public.profile_display_names —
--       dropping `email` from the select — has been DEPLOYED to production and
--       verified live.
--
-- WHAT BREAKS IF YOU APPLY THIS EARLY: the currently-deployed code reads
-- public.user_profiles directly on public photo pages (usePhotoLikes.ts:41,163,270).
-- The moment anon loses its grant / the USING(true) policies are dropped, those
-- anonymous reads return zero rows (or error), so every "liked by <name>" list
-- silently empties on PhotoAlbumPage, PhotoDetailPage, BuildingPhotoAlbum, and
-- PhotoLightbox for logged-out visitors. It does not crash the pages, but it
-- degrades a public feature. Apply ONLY after the code no longer reads the base
-- table anonymously.
--
-- This file is File D of the email-exposure close (Files A, B, C, D). Written
-- for the Supabase web SQL Editor: atomic statements only, no BEGIN/COMMIT.
--
-- ---------------------------------------------------------------------
-- PRE-DRAFT READER RE-CHECK (required before proposing any revoke):
-- Every remaining reader of public.user_profiles was re-scanned. AFTER the
-- usePhotoLikes repoint, each is authenticated and reads only its OWN row
-- (auth.uid()=id) — or reads via a definer view, not the base table:
--   * useAdmin.ts:20                 .select('role').eq('id', user.id)      [auth, own; if(!user) return]
--   * useUserProfile.ts:29           .select('id,email,...').eq('id',user.id)[auth, own]
--   * MyWatchlistPage.tsx:44         .select('weekly_digest_enabled')...own  [auth, own]
--   * useFeatureAnnouncements.ts:27  .select('has_seen_watch_feature')...own [auth, own; if(!user) return]
--   * BuildingMemories.tsx:136       .select('display_name').eq('id',user.id)[auth, own; inside if(user)]
--   * BuildingPhotoAlbum.tsx:303     .select('display_name').eq('id',user.id)[auth, own; inside if(user)]
--   * MultiPersonMemoryForm.tsx:61   .select('display_name').eq('id',user.id)[auth, own; inside if(user)]
--   * ContributionModal.tsx:140      .select('display_name').eq('id',user.id)[auth, own; inside if(user)]
--   * Admin reads of ALL profiles go via public.admin_users_view (definer,
--     File A), NOT the base table (useUsers.ts:25, useAdminStats.ts:49).
--   * WRITERS (all authenticated own-row or admin): MyWatchlistPage:199,
--     useFeatureAnnouncements:61, AuthModal:134 (upsert own), ContributionModal:695
--     (upsert own), AdminUsersTab:37/68/105/151 (admin).
--   * The ONLY anonymous, cross-user base-table reader was usePhotoLikes — moved
--     to profile_display_names by the code change gating this file.
-- Conclusion: with the code change deployed, NO anonymous reader of
-- public.user_profiles remains, so the revoke below is safe. If the code change
-- is NOT yet live, STOP — do not apply.
-- =====================================================================


-- ---------------------------------------------------------------------
-- STATEMENT 1 — Revoke ALL of anon's grants on the base table.
-- ---------------------------------------------------------------------
-- anon currently holds the full privilege set on user_profiles (DELETE, INSERT,
-- MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE — confirmed via
-- aclexplode). SELECT is the live email leak; the write privileges were already
-- inert (no permissive RLS policy grants anon writes). REVOKE ALL removes them.
-- authenticated and service_role grants are intentionally left untouched
-- (own-row reads/writes and admin/backend paths depend on them).
--
-- REVERSIBLE: yes (rollback only — re-exposes the base table to anon):
--   GRANT SELECT ON public.user_profiles TO anon;

REVOKE ALL ON public.user_profiles FROM anon;


-- ---------------------------------------------------------------------
-- STATEMENT 2 — Drop the first broad "read everything" SELECT policy.
-- ---------------------------------------------------------------------
-- "Anyone can read profiles" is role {public} with USING (true): it makes every
-- row (incl. email) readable by everyone, including anon. With anon's grant gone
-- (Statement 1) and no anonymous base reader remaining, this policy is both a
-- leak enabler and redundant. Dropping it leaves authenticated own-row reads
-- intact via "Users can view own profile". Admin all-rows reads use the definer
-- admin_users_view, not this policy.
--
-- REVERSIBLE: yes (rollback only):
--   CREATE POLICY "Anyone can read profiles" ON public.user_profiles
--     FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "Anyone can read profiles" ON public.user_profiles;


-- ---------------------------------------------------------------------
-- STATEMENT 3 — Drop the second broad "read everything" SELECT policy.
-- ---------------------------------------------------------------------
-- "Public can view profiles" is roles {anon, authenticated} with USING (true):
-- same all-rows exposure as Statement 2. Dropping it removes the last route by
-- which a non-owner row (and its email) is readable at the base table. After
-- Statements 2 and 3, the surviving SELECT policy is "Users can view own
-- profile" (authenticated, auth.uid()=id) — own row only.
--
-- REVERSIBLE: yes (rollback only):
--   CREATE POLICY "Public can view profiles" ON public.user_profiles
--     FOR SELECT TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "Public can view profiles" ON public.user_profiles;


-- =====================================================================
-- Verification after apply  (READ-ONLY — safe to run in the SQL Editor)
-- =====================================================================
-- 1. Confirm anon has NO privilege left on the base table:
--       SELECT pg_get_userbyid(a.grantee) AS grantee, a.privilege_type
--         FROM pg_class c
--         JOIN pg_namespace n ON n.oid=c.relnamespace
--         LEFT JOIN LATERAL aclexplode(c.relacl) a ON true
--        WHERE n.nspname='public' AND c.relname='user_profiles'
--        ORDER BY grantee, privilege_type;
--    Expect: zero 'anon' rows; authenticated/service_role rows remain.
--
-- 2. Confirm the two broad policies are gone and own-row SELECT remains:
--       SELECT policyname, roles, cmd, qual
--         FROM pg_policies
--        WHERE schemaname='public' AND tablename='user_profiles'
--        ORDER BY policyname;
--    Expect NO "Anyone can read profiles" and NO "Public can view profiles";
--    "Users can view own profile" (authenticated, auth.uid()=id) still present.
--
-- 3. Confirm the public names path still works and carries no email:
--    Optional functional check (test project / throwaway anon token, not a prod
--    write): GET /rest/v1/profile_display_names?select=id,display_name returns
--    rows; GET /rest/v1/user_profiles as anon returns [] / permission denied.
--
-- 4. Confirm an authenticated non-admin can still read THEIR OWN profile:
--    GET /rest/v1/user_profiles?id=eq.<own-uid> as that user returns 1 row.
-- =====================================================================
