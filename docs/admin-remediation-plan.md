# Admin Remediation Plan — Bountiful South Stake History Site

**Status:** Canon. This document records decisions already made for the admin-surface remediation arc. It exists so future sessions do not re-litigate settled questions. Treat the Scope Decisions section as closed unless a new, explicit decision reopens a specific item.

**Factual basis:** [docs/admin-ux-inventory.md](./admin-ux-inventory.md). That inventory is the grounding for every claim referenced here. A verification pass on the inventory (pasting literal code for load-bearing claims, and capturing the live `admin_users_view` definition) was in progress when this plan was written; where the plan and a later-verified fact disagree, the verified fact wins and this plan should be amended.

**Audience:** the site is operated by rotating church volunteers who serve a few years and hand off to a successor, typically with no overlap and no technical background.

---

## 1. Design target

The single measurable bar the entire arc is judged against:

> A newly called stake executive secretary — with **no overlap** with his predecessor and **no technical background** — opens the admin area for the first time and successfully records **a release and a new calling within ten minutes**, **without asking anyone**, **without reading anything longer than a screen**, and **with no way to silently corrupt the record**.

Every proposed change is measured against this sentence. If a change does not move a first-time, unaided, non-technical user closer to completing that task safely in that time, it is out of scope for this arc regardless of merit. The bar is deliberately a task-completion bar, not a feature list: "within ten minutes, without asking anyone" is the acceptance test.

---

## 2. Primary failure mode

**This system dies by abandonment, not by confusion.**

The mechanism: the weekly task of recording callings and releases is unpleasant → it gets deferred → the backlog grows past the point where catching up feels like a chore → the historical record silently stops being maintained. No error is thrown, no alarm sounds; the data just quietly goes stale and the site's reason for existing evaporates.

The consequence for prioritization: **friction on the highest-frequency task is a continuity risk, not a cosmetic complaint.** This is why the "plumbing and language" work (Tier 4) is explicitly not cosmetic — it is what determines whether the weekly chore stays tolerable enough to keep happening. A correct-but-miserable calling flow fails the mission exactly as surely as a broken one, just more slowly.

---

## 3. Priority tiers

Tiers are worked in order. **Rule: no lower tier ships before the tier above it is complete.** A partial Tier 1 does not unlock Tier 2 work.

### Tier 1 — Continuity: the site must survive an unplanned handoff
The failure this tier addresses: the sole admin becomes unreachable (lost password, left the calling, moved) and no one can get back in or stand up a replacement without a developer.
- **Absent password-reset path.** There is no self-service password reset or account recovery anywhere in the codebase — a locked-out admin has no in-app route back in. (Inventory §13.)
- **Capture `admin_users_view` into a repo migration.** The Users tab and the dashboard user count depend on this view, but it exists **only in the live database** — no migration or schema file defines it. If the database is ever rebuilt from the repo, the Users tab breaks and admin management is lost. Its definition must be captured into a committed migration so the admin surface is reproducible from source. (Inventory §6, §8.)

### Tier 2 — Protection of the record: destructive actions gated proportionally to consequence
The principle: the strength of a confirmation gate should match the severity and reversibility of what it guards. Today the gating is inverted in places.
- **Photo reject destroys the only copy.** Rejecting a submitted photo deletes the source file from Storage with **no confirmation** — a single misclick permanently loses a contributor's submission. (Inventory §10, §12.)
- **Make Admin vs. Remove Admin asymmetry.** Granting admin fires on a single click with **no confirmation and no audit-log entry**, while the reversible Remove Admin requires **three** sequential confirmations. The higher-consequence, less-reversible direction is the *less* guarded one. (Inventory §2, verification Part E.)

### Tier 3 — The weekly path: the calling and release flow
This is the mission-critical repeated task and, per the inventory, the worst-served surface in the app. This tier is where the Design Target is actually won or lost.
- **Discoverability.** The create/release functions live inside a dropdown tab named "Manage Callings," and creating a person is buried further inside it; a first-time user cannot find them. (Inventory §1, §3, §4.)
- **Person-first navigation.** Callings can only be reached by first knowing and selecting the *organization*; there is no way to start from a person. (Inventory §3, §4.)
- **Date precision.** The UI always writes `'exact'` precision and offers no way to record an approximate historical date, forcing false exact dates. (Inventory §9; verification Part A3.)
- **Transactional integrity of release-plus-replacement.** Release and the replacement insert are sequential independent calls with no transaction; a mid-operation failure leaves someone released with no replacement. (Inventory §9; verification Part A4.)

### Tier 4 — Plumbing and language (explicitly non-cosmetic)
Recorded as the tier that determines whether the weekly chore feels tolerable — see §2. Not optional polish.
- **Raw `alert()` dialogs** surface raw Supabase/Postgres error text (e.g. "new row violates row-level security") directly to non-technical volunteers. (Inventory §5, §8.)
- **Full page reloads after every save** (`window.location.reload()`) throw the admin back to the default Portraits tab and lose their place. (Inventory §8; verification Part A6 — 8 occurrences in admin components.)
- **Misleading tab names** ("Fix Names," "Fix All Else," "Manage Callings") give no signal about what each does. (Inventory §1, §4.)

---

## 4. Scope decisions (closed)

These are settled. Do not revisit without an explicit new decision that names the specific item being reopened.

### 4.1 No standalone "add a person" screen
Inline person creation during calling assignment is the **correct shape**: on this site, a person is added as a consequence of being called, never catalogued for their own sake. The nesting is right. The defects to fix are (a) **discoverability** of the inline create, and (b) the **absent duplicate check** that lets a near-duplicate name silently create a second person record. Do not build a separate person-management CRUD screen. (Inventory §3, §12; verification Part A5.)

### 4.2 No CMS for buildings, timeline entries, or narrative text
This content changes roughly annually, and a content editor would introduce a large new surface for silent corruption for very little frequency of use. Buildings, timeline events, and narrative text **remain source-edit-and-redeploy**. The obligation this creates is documentation, not tooling: the operator's manual must state plainly that this content is changed by a developer, and name a contact for who performs it. (Inventory §3.)

### 4.3 Subscriber oversight is a column on the existing Users table, not a new screen
Today, registered accounts and digest subscribers are conflated: the Users tab shows accounts, while digest opt-in lives on `user_profiles.weekly_digest_enabled` and is **invisible to admins** (it is not even exposed by `admin_users_view`). The fix is to surface that opt-in **as a column on the existing Users table**, not to build a separate subscriber-management screen. (Inventory §11; verification Part B, Part E.)

---

## 5. Deliverable not yet scheduled

**An operator's manual for the admin role.** None exists today — the repo contains a contributor guide (`scripts/stake-history-guide.pdf`) and developer runbooks (the portrait-upload troubleshooting docs) only, neither of which explains how to *operate* the admin surface. (Inventory §7.)

This manual is a **required deliverable of this arc.** It must, at minimum, cover the four review queues, the weekly release/calling task end-to-end, presidency numbering, the fact that building/timeline/narrative content is developer-edited (with the contact from §4.2), and how to onboard a successor. **Tier: to be assigned.**

---

## 6. Grounding and provenance

- All factual claims trace to [docs/admin-ux-inventory.md](./admin-ux-inventory.md) (sections cited inline above).
- A verification pass on that inventory — pasting literal code for the load-bearing claims and retrieving the live `admin_users_view` definition read-only — was **in progress** when this plan was authored. Verified findings supersede the inventory's summaries where they differ; amend this plan accordingly if that happens.
- That verification pass is now **complete**; its literal-code evidence, grep results, the `admin_users_view` definition, and every verdict are recorded in [docs/admin-ux-verification.md](./admin-ux-verification.md).
- This document records decisions only. It is not an implementation spec and prescribes no code changes.

---

## 7. Status — security findings and current state

Security issues surfaced during grounding/verification, and where each stands as of **2026-08-24**:

- **Anon read of all account emails via `admin_users_view`** — **CLOSED 2026-08-24.** The view exposed `auth.users.email` for all accounts to the `anon` role (definer view + anon SELECT). Fixed by [migration_secure_admin_users_view.sql](../supabase/migration_secure_admin_users_view.sql) (File A), applied to production by the project owner and verified.
- **Privilege escalation — any authenticated user could set their own `role` to `admin`** — **CLOSED 2026-08-24.** RLS `UPDATE` policy with no `WITH CHECK` plus an unrestricted table-level UPDATE grant allowed self-promotion. Fixed by [migration_block_role_escalation.sql](../supabase/migration_block_role_escalation.sql) (File B), applied to production and verified (trigger enabled; admin edits still work; direct-session recovery preserved).
- **Anon read of emails directly from the `user_profiles` base table** — **CLOSED 2026-08-24.** Independent of the view: `anon` held table SELECT plus two `USING (true)` SELECT policies, so `GET /rest/v1/user_profiles?select=email` returned all addresses. Closed by the coordinated change set, in order: **File C** ([migration_public_profile_names.sql](../supabase/migration_public_profile_names.sql), the email-free `profile_display_names` view) + the **`usePhotoLikes` code repoint** (deployed in merge commit `99d2c21`) + **File D** ([migration_restrict_user_profiles_anon.sql](../supabase/migration_restrict_user_profiles_anon.sql), which revoked anon's grants and dropped the two `USING (true)` policies). All three applied/deployed and verified (base-table SELECT now own-row only for authenticated; liker names still render).

**All three security findings from the grounding phase are now closed.**

Additional standing notes:
- **Role changes still write no `audit_log` entry.** Promoting/demoting an admin leaves no recorded history; only current state is checkable.
- **At time of writing, production had exactly one admin account, whose `user_profiles` row had never been modified since creation** (`created_at` = `updated_at`). Single admin = single point of failure for handoff (see the Tier 1 continuity concerns above).

---

## 8. Open items (not tier-scoped)

- **RLS is the sole access control on `public` tables; no comprehensive coverage audit has been done.** Supabase default privileges grant `anon` (and `authenticated`) the **full privilege set on every new object in the `public` schema** — observed directly when `profile_display_names` was created and arrived anon-readable despite the migration granting only `authenticated` (see File C's applied-status note). This means Row Level Security is the *only* thing standing between the anon key and every table: any table with RLS disabled, or with a permissive `USING (true)` policy, is world-readable/writable to the extent of its policies. The findings closed above were specific instances of this pattern; **no systematic audit of RLS enablement and policy correctness across all `public` tables has been performed.** Recorded as a **known, unreviewed risk warranting a dedicated session** (enumerate every `public` table, confirm `relrowsecurity`, and review each policy against intended access).
