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
