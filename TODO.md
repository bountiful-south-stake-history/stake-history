# TODO / follow-ups

Deferred work noted during fixes. Not done now — captured so it isn't lost.

## From the High Council release-and-replace fix (2026-10-18, branch `fix/hc-release-replacement`)

- [ ] **Give the presidency label its own column.** The label (e.g. "Hill Presidency")
  is overloaded into the free-text `callings.notes` field, alongside status text the
  release flow appends ("Released 18 October 2026"). Parsing/validating the label from
  notes is fragile (the UI detects label-using orgs with a regex over notes). Consider a
  dedicated column (e.g. `presidency_label`) and migrating existing notes into it.

- [ ] **Make the sequential-vs-presidency distinction an explicit DB flag.**
  `isPresidencyOrg` in `AdminTransitionsTab.tsx` is derived by matching organization
  names/types ("presidency", "relief society", "primary", …). A new or renamed org can
  be misclassified, which is exactly what drives the number/label behavior. Consider an
  org-level column (e.g. `numbering_scheme` = `'cohort' | 'sequential'`) instead of name
  matching.

- [ ] **Add a DB constraint against duplicate numbers in sequential orgs.** Nothing at
  the database level prevents two active callings from sharing a `presidency_number`
  within a sequentially numbered org (the bug this branch fixes created exactly that:
  High Council #227 held by both Bawden and Shegrud). Consider a partial unique
  index/constraint scoped to sequential orgs so the app can't reintroduce duplicates.

- [ ] **Compute the max presidency number from an unfiltered query.**
  `getMaxPresidencyNumber()` reduces over `callings` from `useOrganizationCallings`,
  which drops redacted people ([useOrganizationCallings.ts](src/hooks/useOrganizationCallings.ts) ~line 36).
  So a redacted member's number can be reused for a new member, silently creating a
  duplicate. Compute the max from a query that counts all rows regardless of redaction.

- [ ] **Scope the max to `position_id`.** `getMaxPresidencyNumber()` is org-wide, not
  per-position. Harmless for the High Council (a single position), but wrong for any
  future multi-position sequential org, where each position should number independently.

- [ ] **Retire the `orgUsesPresidencyLabels` regex.** The UI detects label-using orgs by
  running a regex over `callings.notes`. It is a stopgap that goes away once the
  dedicated presidency-label column (first item above) exists — switch the check to that
  column.

## Maintenance

- [ ] **Triage Dependabot alerts.** GitHub reports 11 vulnerabilities on the default
  branch (4 high, 7 moderate) as of 2026-10-18:
  <https://github.com/bountiful-south-stake-history/stake-history/security/dependabot>.
  Review, bump the affected deps, and confirm `npm run build` still passes.

- [ ] **Restore a runnable lint.** `npm run lint` currently fails because
  `eslint.config.js` imports `typescript-eslint`, which isn't installed (the package is
  missing from `devDependencies`). Add it (and any other configured plugins) so lint runs
  in CI and locally; today only `tsc` via `npm run build` catches type errors.

- [ ] **Clear the legacy `'Current'` placeholder from notes.** One RELEASED calling
  (Stake Sunday School) still has `notes = 'Current'`, which shows "Current" on a released
  member. Clear it to NULL via a guarded, id-targeted data change. Also consider replacing
  the legacy `'Current'` placeholder on the ~32 active rows with NULL; the UI can show
  "present" from `released_date` being null.
