# Admin UX Inventory — Verification Report (Parts A–E)

**What this is:** the evidence pass behind [docs/admin-ux-inventory.md](./admin-ux-inventory.md). Where the inventory summarized behavior, this file pastes the **literal code**, the **actual search results** (including empty ones), and the **live database view definition** that back the load-bearing claims, each followed by a verdict (CONFIRMED / partially confirmed / wrong).

**What it verifies:** photo-reject destructiveness and confirmation, the (absent) password-reset path, date-precision writes, release-plus-replacement transactionality, person-creation duplicate checks, the post-save reload count, the `admin_users_view` definition, public-display ordering, auth/SMTP configuration, and the Users-tab specifics (columns, Make/Remove Admin gating and audit, digest-flag write paths, row-click targets).

**As of:** reflects the repository code and live production database state as of **2026-08-24**.

> **Note on `admin_users_view`:** this view is defined **only in the live database**. It is **not** captured in any repo migration or schema file. Capturing it into a committed migration is a **Tier 1 deliverable** in [docs/admin-remediation-plan.md](./admin-remediation-plan.md); until then, the Users tab and the dashboard user count depend on a definition that cannot be reproduced from source. The verbatim definition is recorded in Part B below.

**Provenance:** Part B was retrieved read-only via `pg_get_viewdef`. No application code was changed and nothing was written to production during this pass.

---

## Part A — Literal code for load-bearing claims

### A1. Photo reject

[AdminPhotosTab.tsx:618-644](../src/components/admin/AdminPhotosTab.tsx#L618-L644) — the full handler:

```tsx
  const handleReject = async (photoId: string) => {
    setProcessing(photoId)
    try {
      const photo = photos.find((p) => p.id === photoId)
      if (photo && (photo.photo_url || (photo as any)?.file_url)) {
        const photoUrl = photo.photo_url || (photo as any).file_url
        const urlParts = photoUrl.split('/')
        const filePath = urlParts.slice(urlParts.indexOf('photos')).join('/')
        await supabase.storage.from('photos').remove([filePath])
      }

      const { error: updateError } = await supabase
        .from('photos')
        .update({
          status: 'rejected',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', photoId)
      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to reject photo')
    } finally {
      setProcessing(null)
    }
  }
```

The button that invokes it, [AdminPhotosTab.tsx:930-936](../src/components/admin/AdminPhotosTab.tsx#L930-L936):

```tsx
                      <button
                        onClick={() => handleReject(photo.id)}
                        disabled={processing === photo.id}
                        className="flex-1 px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                      >
                        Reject
                      </button>
```

**Verdict: CONFIRMED.** The `onClick` calls `handleReject` directly — there is **no confirmation gate** (no arm-state, no modal, no `window.confirm`). The image is deleted via `supabase.storage.from('photos').remove([filePath])` (L626) — a **delete, not a move**. One misclick permanently removes the file.

### A2. Password reset — search results

`resetPasswordForEmail|updateUser|Forgot|recover|reset`, case-insensitive.

**`supabase/` (edge functions + SQL):** `No matches found`.

**`src/`** — every hit (all are local UI "reset" state, none auth-related):
```
src\components\people\ContributionModal.tsx:114:  // Reset registerAlso when user becomes logged in
src\components\people\PortraitDisplay.tsx:22:  // Reset image error when person or portrait_url changes
src\components\admin\AdminPhotosTab.tsx:90:  // Reset crop and enhancement state when editing changes
src\components\admin\AdminPhotosTab.tsx:266:  const resetEnhancements = () => {
src\components\admin\AdminPhotosTab.tsx:1077:  onClick={resetEnhancements}
src\components\admin\AdminPhotosTab.tsx:1080:  Reset adjustments
src\components\admin\AdminPhotosTab.tsx:1194:  onClick={resetEnhancements}
src\components\admin\AdminPhotosTab.tsx:1198:  Reset
src\components\admin\AdminPhotosTab.tsx:1262:  Reset to default
src\components\admin\AdminPortraitsTab.tsx:146:  // Reset crop and enhancement state when editing changes
src\components\admin\AdminPortraitsTab.tsx:155:  // Reset enhancement sliders
src\components\admin\AdminPortraitsTab.tsx:319:  // Reset enhancement sliders when starting new crop
src\components\admin\AdminPortraitsTab.tsx:326:  const resetEnhancements = () => {
src\components\admin\AdminPortraitsTab.tsx:1184:  <button onClick={resetEnhancements} ...>Reset</button>
src\components\admin\AdminPortraitsTab.tsx:1211:  resetEnhancements()
```

**Verdict: CONFIRMED.** Zero matches for `resetPasswordForEmail`, `updateUser`, `Forgot`, or `recover` anywhere. Every "reset" hit is image-editor state. **No password-reset or account-recovery path exists in the codebase.**

### A3. Date precision

Every write of `sustained_precision` / `released_precision` in `src/` (grep, values shown):

```
AdminTransitionsTab.tsx:259:  released_precision: 'exact',          // handleRelease – release the person
AdminTransitionsTab.tsx:287:  sustained_precision: 'exact',         // handleRelease – replacement insert
AdminTransitionsTab.tsx:399:  sustained_precision: 'exact',         // handleAddCounselor
AdminTransitionsTab.tsx:468:  sustained_precision: 'exact',         // handleAddNew
AdminTransitionsTab.tsx:620:  released_precision: 'exact',          // handleBatchSave – release
AdminTransitionsTab.tsx:662:  sustained_precision: 'exact' as const,// handleBatchSave – new callings
```
(The remaining hits — L271, L306, L418 — are `audit_log` copies of the same `'exact'`; L793/837/926/962 are read-only display via `formatDate`; L48/50 are the type definition.) [AdminCallingsTab.tsx](../src/components/admin/AdminCallingsTab.tsx) writes **no** precision field at all in its edit handler (L98-107), so editing dates there leaves precision untouched.

**Verdict: CONFIRMED.** Every insert/release path hardcodes `'exact'` as a string literal. There is **no UI input bound to precision** anywhere, so an admin can never write `'month'` or `'year'`. The `'exact' | 'month' | 'year'` type ([types.ts:48,50](../src/lib/types.ts#L48)) is exercised only by seed/import data and the read-only `formatDate` display.

### A4. Release plus replacement — transaction check

[AdminTransitionsTab.tsx:231-328](../src/components/admin/AdminTransitionsTab.tsx#L231-L328), full `handleRelease` with every `await` in sequence:

```tsx
  const handleRelease = async () => {
    if (!showReleaseModal || !releaseDate) {
      alert('Please enter a release date')
      return
    }

    if (addReplacement && (!replacementPersonId || !replacementSustainedDate)) {
      alert('Please select a replacement person and enter a sustained date')
      return
    }

    setProcessing(showReleaseModal.id)
    try {
      const oldValues = {
        person_id: showReleaseModal.person_id,
        position_id: showReleaseModal.position_id,
        organization_id: showReleaseModal.organization_id,
        presidency_number: showReleaseModal.presidency_number,
        sustained_date: showReleaseModal.sustained_date,
        released_date: showReleaseModal.released_date,
        notes: showReleaseModal.notes,
      }

      // Release the current person
      const { error: updateError } = await supabase
        .from('callings')
        .update({
          released_date: releaseDate,
          released_precision: 'exact',
        })
        .eq('id', showReleaseModal.id)

      if (updateError) throw updateError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'callings',
          record_id: showReleaseModal.id,
          action: 'release_calling',
          old_values: oldValues,
          new_values: { ...oldValues, released_date: releaseDate, released_precision: 'exact' },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      // Add replacement if requested
      if (addReplacement && replacementPersonId && replacementSustainedDate) {
        const { data: newCalling, error: insertError } = await supabase
          .from('callings')
          .insert({
            person_id: replacementPersonId,
            organization_id: showReleaseModal.organization_id,
            position_id: showReleaseModal.position_id,
            presidency_number: showReleaseModal.presidency_number,
            sustained_date: replacementSustainedDate,
            sustained_precision: 'exact',
          })
          .select()
          .single()

        if (insertError) throw insertError

        if (user && newCalling) {
          await supabase.from('audit_log').insert({
            table_name: 'callings',
            record_id: newCalling.id,
            action: 'add_calling',
            old_values: null,
            new_values: {
              person_id: replacementPersonId,
              organization_id: showReleaseModal.organization_id,
              position_id: showReleaseModal.position_id,
              presidency_number: showReleaseModal.presidency_number,
              sustained_date: replacementSustainedDate,
              sustained_precision: 'exact',
            },
            performed_by: user.id,
            performed_at: new Date().toISOString(),
          })
        }
      }

      setShowReleaseModal(null)
      setReleaseDate('')
      setAddReplacement(false)
      setReplacementPersonId(null)
      setReplacementPersonName('')
      setReplacementSearchTerm('')
      setReplacementSustainedDate('')
      onActionComplete?.()
      window.location.reload()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to release calling')
    } finally {
      setProcessing(null)
    }
  }
```

**Verdict: CONFIRMED.** These are **four sequential, independent client calls** (release `update` → audit `insert` → replacement `insert` → audit `insert`). There is **no `rpc(...)`, no transaction, no `BEGIN/COMMIT`**. If the update at L255 succeeds and the insert at L279 throws, control jumps to `catch` (L323) with the person already released and no replacement created — exactly the partial-state hazard the inventory described.

### A5. Person creation — duplicate check

[AdminTransitionsTab.tsx:530-567](../src/components/admin/AdminTransitionsTab.tsx#L530-L567), full `handleAddNewPerson`:

```tsx
  const handleAddNewPerson = async () => {
    if (!newPersonName.trim()) {
      alert('Please enter a name')
      return
    }

    try {
      const { data, error } = await supabase
        .from('people')
        .insert({
          full_name: newPersonName.trim(),
          redacted: false,
        })
        .select()
        .single()

      if (error) throw error

      if (showAddPersonModal === 'replacement') {
        setReplacementPersonId(data.id)
        setReplacementPersonName(data.display_name || data.full_name)
      } else if (showAddCounselorModal) {
        setAddCounselorPersonId(data.id)
        setAddCounselorPersonName(data.display_name || data.full_name)
      } else if (showAddNewModal) {
        setAddNewPersonId(data.id)
        setAddNewPersonName(data.display_name || data.full_name)
      } else {
        const position = showAddPersonModal || 'president'
        handlePersonSelect(position, data)
      }

      setShowAddPersonModal(false)
      setNewPersonName('')
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to create person')
    }
  }
```

**Verdict: CONFIRMED.** The only guard is `!newPersonName.trim()` (non-empty). There is **no SELECT/lookup before the INSERT** and no unique constraint referenced — any name, including an exact or near-duplicate of an existing person, inserts a brand-new `people` row silently. (The upstream `PersonSelector` search is a separate `ilike` on `full_name` only, so a differently-spelled existing person won't surface, then this handler creates the duplicate.)

### A6. Post-save reload — full count

`window.location.reload()` grep across `src/`:

**Admin components (8 occurrences):**
```
AdminCallingsTab.tsx:130      (handleSave – edit calling)
AdminCallingsTab.tsx:191      (handleDeleteConfirm – delete calling)
AdminCallingsTab.tsx:243      (handlePresidencyNumberChange – Fix #)
AdminPeopleTab.tsx:80         (handleSave – edit person / Fix Names)
AdminTransitionsTab.tsx:322   (handleRelease)
AdminTransitionsTab.tsx:431   (handleAddCounselor)
AdminTransitionsTab.tsx:504   (handleAddNew)
AdminTransitionsTab.tsx:694   (handleBatchSave)
```
**Non-admin (for completeness, 4 occurrences):** `PersonMemoriesPage.tsx:114, 434, 450` and `PortraitDisplay.tsx:32`.

**Verdict: CONFIRMED.** **8** `window.location.reload()` calls in the admin components, matching the inventory's citation set (Fix Names ×1, Fix All Else ×3, Manage Callings ×4). Each hard-reloads and returns the dashboard to the default Portraits tab.

---

## Part B — `admin_users_view` definition (retrieved read-only from production)

`pg_get_viewdef('public.admin_users_view', true)` returned verbatim:

```sql
 SELECT up.id,
    au.email,
    up.display_name,
    up.role,
    up.view_blocked,
    up.view_blocked_at,
    up.view_blocked_reason,
    up.created_at
   FROM user_profiles up
     LEFT JOIN auth.users au ON up.id = au.id;
```

**Findings this resolves (previously "unknown" in inventory §8/§6):**
- It is `user_profiles LEFT JOIN auth.users`, keyed on `id`. It exposes `email` (from `auth.users`), `display_name`, `role`, the three `view_blocked*` columns, and `created_at`.
- **It does NOT expose `weekly_digest_enabled`** — confirming the digest flag is not available to the Users tab even at the data layer.
- Because it is driven by `user_profiles` (created by the `handle_new_user` signup trigger), a successor appears **only after they have an auth account / profile row** — corroborating the §6 inference that they must sign up before they can be promoted. (It's a `LEFT JOIN`, so a profile row with no matching `auth.users` row would still list with a null email, but the normal creation path always makes both.)
- No `WHERE` filter — it lists all profiles, not just admins.

No migration file was created and nothing was written to production. **Capturing this definition into a repo migration is a Tier 1 deliverable** (see header note and remediation plan).

---

## Part C — Sections 5, 9, and 10 of the inventory

These three inventory sections were reproduced verbatim during the verification pass to confirm they matched the on-disk file exactly. They are **not duplicated here** to avoid drift between two copies; they live in [docs/admin-ux-inventory.md](./admin-ux-inventory.md) §5 (text inventory), §9 (calling lifecycle), and §10 (photo/media handling). The verification confirmed the on-disk text matched what was reproduced, with no discrepancies.

---

## Part D — Two additional reads

### D1. Where calling data is ordered for public display

Ordering happens in three layers; `presidency_number` is load-bearing in two of them.

**Layer 1 — grouping into presidencies**, [OrganizationPage.tsx:38-53](../src/pages/OrganizationPage.tsx#L38-L53):
```tsx
  const presidencies = callings.reduce((acc, calling) => {
    const presNum = calling.presidency_number ?? 0
    if (!acc[presNum]) {
      acc[presNum] = []
    }
    acc[presNum].push(calling)
    return acc
  }, {} as Record<number, typeof callings>)

  const sortedPresidencies = Object.entries(presidencies)
    .map(([num, calls]) => ({
      number: parseInt(num),
      callings: calls,
      earliestDate: Math.min(...calls.map(c => parseLocalDate(c.sustained_date).getTime())),
    }))
    .sort((a, b) => b.earliestDate - a.earliestDate)
```

**Layer 2 — sequential list ordering**, [NumberedList.tsx:16-21](../src/components/organizations/NumberedList.tsx#L16-L21):
```tsx
  const sortedCallings = [...callings].sort((a, b) => {
    const aNum = a.presidency_number ?? 0
    const bNum = b.presidency_number ?? 0
    if (aNum !== bNum) return bNum - aNum
    return parseLocalDate(a.sustained_date).getTime() - parseLocalDate(b.sustained_date).getTime()
  })
```

**Layer 3 — within a presidency**, [PresidencyCard.tsx:20-22](../src/components/organizations/PresidencyCard.tsx#L20-L22): sorts by `position.sort_order` (president before counselors), not by number.

**Fields that determine ordering:** `presidency_number` (primary grouping key **and** the primary sort key in NumberedList), `sustained_date` (groups' relative order via each group's earliest date, and the tiebreak within equal numbers), and `position.sort_order` (arrangement inside one presidency).

**What breaks if `presidency_number` is set wrong:** the record is **grouped into the wrong presidency block** (Layer 1 buckets purely by that integer) — a wrong number can split one real presidency across two blocks or merge two presidencies into one. In the numbered list it also **jumps to the wrong rank** (Layer 2 sorts by it descending). Because the Fix-# modal writes the number with no cross-row validation, a duplicate or off-by-one silently reshuffles the public history. This corroborates inventory §4 #7 and §12 #6.

### D2. Supabase auth email templates / SMTP configuration

- **No `supabase/config.toml`** exists in the repo (checked; "no supabase config.toml"). So Supabase Auth settings — including the `[auth.email]` templates and any custom SMTP for auth mail — are **not version-controlled here**; they live only in the Supabase dashboard (not visible from the repo).
- **`.env.example`** contains only `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`, and `VITE_ADMIN_EMAIL` — no mail/SMTP variables.
- **`vercel.json`** is a SPA-rewrite only — no mail config.
- The **only** SMTP wiring in the whole repo is the weekly-digest edge function, [weekly-digest/index.ts:2,6-7,131-138,206-207](../supabase/functions/weekly-digest/index.ts#L131-L138): it uses `denomailer` against `smtp.gmail.com` with `GMAIL_USER` / `GMAIL_APP_PASSWORD`. This is an **application-level** sender for the digest; it is **not** Supabase Auth's mailer and cannot send a password-reset email.

**Implication for deliverability:** whether a password-reset email could even be sent today depends entirely on Supabase's built-in Auth email (dashboard-configured, default Supabase SMTP or a custom SMTP set there) — **none of which is in the repo or project config**. Combined with A2 (no reset code exists at all), a reset is currently neither triggerable from the app nor demonstrably deliverable from anything in this codebase. (**Inference** on the dashboard state, since it isn't in-repo; the absence of any in-repo auth-mail config is direct.)

---

## Part E — Users tab addendum

### E1. Users tab columns + the populating query

**Query**, [useUsers.ts:24-27](../src/hooks/useUsers.ts#L24-L27):
```tsx
        const { data, error: fetchError } = await supabase
          .from('admin_users_view')
          .select('*')
          .order('created_at', { ascending: false })
```

**Table header**, [AdminUsersTab.tsx:198-211](../src/components/admin/AdminUsersTab.tsx#L198-L211):
```tsx
          <thead className="bg-gray-50">
            <tr>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                Email
                <span className="ml-2 text-xs font-normal text-gray-400" title="Email can only be changed by the user">
                  (read-only)
                </span>
              </th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Display Name</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Role</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">View Access</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Created</th>
              <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
            </tr>
          </thead>
```

The row cells (non-editing branch), [AdminUsersTab.tsx:275-343](../src/components/admin/AdminUsersTab.tsx#L275-L343), render exactly: **Email** (`{user.email}`), **Display Name** (or "Not set"), **Role** badge, **View Access** (🚫/✅), **Created** date, **Actions** (Edit / Restrict-Restore / Make-Remove Admin). Full Make/Remove Admin JSX pasted in E2 below.

**Verdict re `weekly_digest_enabled`: CONFIRMED absent.** The query does `select('*')` from `admin_users_view`, and Part B proves that view **does not include** `weekly_digest_enabled`. It is not selected, not rendered in any of the six columns, and not editable anywhere in the admin area. Corroborates inventory §11.

### E2. Make Admin handler + button, confirmation, audit

Full handler, [AdminUsersTab.tsx:16-48](../src/components/admin/AdminUsersTab.tsx#L16-L48):
```tsx
  const toggleAdmin = async (userId: string, currentRole: string) => {
    if (userId === currentUser?.id && currentRole === 'admin') {
      alert('You cannot remove your own admin access.')
      return
    }

    if (currentRole === 'admin') {
      const confirm1 = window.confirm('Are you sure you want to remove admin access?')
      if (!confirm1) return

      const confirm2 = window.confirm('This will remove admin privileges. Continue?')
      if (!confirm2) return

      const confirm3 = window.confirm('Final confirmation: Remove admin access?')
      if (!confirm3) return
    }

    setProcessing(userId)
    try {
      const newRole = currentRole === 'admin' ? 'viewer' : 'admin'
      const { error: updateError } = await supabase
        .from('user_profiles')
        .update({ role: newRole })
        .eq('id', userId)

      if (updateError) throw updateError
      refetch()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to update user role')
    } finally {
      setProcessing(null)
    }
  }
```

Button JSX with styling, [AdminUsersTab.tsx:330-341](../src/components/admin/AdminUsersTab.tsx#L330-L341):
```tsx
                          <button
                            onClick={() => toggleAdmin(user.id, user.role)}
                            disabled={processing === user.id || (user.id === currentUser?.id && user.role === 'admin')}
                            className={`px-3 py-1 rounded text-sm disabled:opacity-50 ${
                              user.role === 'admin'
                                ? 'bg-red-600 text-white hover:bg-red-700'
                                : 'bg-green-600 text-white hover:bg-green-700'
                            }`}
                            title={user.id === currentUser?.id && user.role === 'admin' ? 'You cannot remove your own admin access' : ''}
                          >
                            {user.role === 'admin' ? 'Remove Admin' : 'Make Admin'}
                          </button>
```

**Verdicts:**
- **Make Admin has NO confirmation gate.** The `currentRole === 'admin'` branch (L22-31) is the only place `window.confirm` appears; when promoting a *viewer* to admin, `currentRole` is `'viewer'`, so all three confirms are skipped and the write at L36-39 runs on the single click. **CONFIRMED (asymmetric).**
- **Remove Admin requires THREE `window.confirm` dialogs** (L23, L26, L29), plus a hard block on demoting yourself (L17-20, and `disabled` at L332). **CONFIRMED — count = 3.**
- **The role write emits NO `audit_log` entry.** `toggleAdmin` contains no `audit_log` insert (contrast `handleSaveDisplayName` at [L75-84](../src/components/admin/AdminUsersTab.tsx#L75-L84), `handleRestrictView` at L116, `handleRestoreView` at L162, which all do). **CONFIRMED** — promoting or demoting an admin is unlogged, so there is no record of who granted or revoked admin, and (per inventory §8) no viewer even if there were.

### E3. Digest reachability — every write path to `weekly_digest_enabled`

Grep for `weekly_digest_enabled` across the whole repo yields exactly these code sites:

1. **User self-service checkbox (write)** — [MyWatchlistPage.tsx:200](../src/pages/MyWatchlistPage.tsx#L200), inside the checkbox `onChange`:
```tsx
                    const { error } = await supabase
                      .from('user_profiles')
                      .update({ weekly_digest_enabled: newValue })
                      .eq('id', user.id)
```
`user` here is the authenticated current user ([useAuth](../src/hooks/useAuth.ts)), so `.eq('id', user.id)` scopes the write to **the caller's own row only**.
2. **User self-service read** — MyWatchlistPage.tsx:45, 57-58 (loads the current value).
3. **Edge function read** — [weekly-digest/index.ts:120](../supabase/functions/weekly-digest/index.ts#L120): `.eq('weekly_digest_enabled', true)` — filters recipients; **read filter, not a write**.

**Verdicts:**
- **The only writer of `weekly_digest_enabled` is the user's own checkbox on My Watchlist**, always scoped to `user.id`. The edge function only reads it. **CONFIRMED.**
- **An admin cannot change another user's digest value from anywhere in the app today** — no admin component references the column at all, and the sole write path is self-scoped. Changing someone else's flag requires **direct database access**. **CONFIRMED**, matching inventory §11.

### E4. Row-click targets in the Users table (mis-click risk)

Desktop row, [AdminUsersTab.tsx:218-219](../src/components/admin/AdminUsersTab.tsx#L218-L219):
```tsx
                <tr key={user.id} className="hover:bg-gray-50">
                  <td className="px-4 py-3 text-sm text-gray-900">{user.email}</td>
```
The `<tr>` has only a `hover:bg-gray-50` class and **no `onClick`**; the same holds for the mobile card at [L358](../src/components/admin/AdminUsersTab.tsx#L358) (`<div ... className="p-4 bg-white ...">`, no handler). Every mutation is bound to an explicit `<button onClick=...>` inside the Actions cell (Edit L308, Restrict/Restore L315/L323, Make/Remove Admin L331).

**Verdict: CONFIRMED — low mis-click risk in this specific table.** No whole-row or whole-card click target exists; actions require hitting a specific button. (This contrasts with the Suggestions tab, where the entire row *is* clickable — [AdminSuggestionsTab.tsx:86-90](../src/components/admin/AdminSuggestionsTab.tsx#L86-L90) — but that opens a detail modal rather than performing a write.)

---

## Net result

Every Part-A claim is **CONFIRMED** as written in the inventory. Part B **resolves** a former unknown (the `admin_users_view` definition) and, in doing so, strengthens two inventory claims: the digest flag is not in the Users data source, and successors must have a profile row before they can appear/be promoted. Part E surfaces one point worth carrying into remediation that the inventory stated but did not fully sharpen: **promotion to admin is a single unconfirmed, unlogged click, while demotion takes three confirms** — an asymmetry that matters for handoff safety (remediation plan Tier 2). No code was changed and nothing was committed to production during verification.
