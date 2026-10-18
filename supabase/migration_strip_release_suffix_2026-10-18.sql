-- Migration: Strip the app-generated "Released <date>" suffix from callings.notes
-- STATUS: APPLIED 2026-10-18 by Troy in the Supabase SQL Editor (project ref
-- kywsocmgkrckwhnmhtfz), 3 rows updated. Recorded in docs/data-changes.md. Do not
-- re-run (the current-notes guards make a re-run a no-op regardless).
--
-- Background: the release flow used to append "Released <date>" to notes, so the
-- public subtitle repeated the release date the date range already shows. The app
-- no longer does this (fix/release-keeps-notes). This cleans up the rows that
-- already carry the suffix.
--
-- Scope: ONLY the three rows whose notes exactly match the app-generated pattern
-- "<label> Released 18 October 2026" (date == released_date). Hand-written history
-- -- e.g. the "...in the stake boundary realignment" and "...was discontinued..."
-- notes, and "Released to become Stake President" -- is deliberately NOT touched.
--
-- Each row is targeted by id and guarded on its exact current notes value, so a
-- re-run (or any row that has since changed) updates 0 rows. NULLIF sets notes
-- back to NULL if stripping ever left it empty (none of these three do). Single
-- statement (CTE + UPDATE ... RETURNING) so Studio shows exactly what changed.
-- Expected: 3 rows updated. No semicolons inside string literals.

WITH targets (id, current_notes, new_notes) AS (
  VALUES
    -- "Anderson Presidency Released 18 October 2026" -> "Anderson Presidency"
    ('cdf7f8c1-2586-44dc-a642-3e0a9470eb9f'::uuid, 'Anderson Presidency Released 18 October 2026', 'Anderson Presidency'),
    -- "Anderson Presidency Released 18 October 2026" -> "Anderson Presidency" (Samuel J. Bawden, #227)
    ('fd8b461c-8d59-40a9-bb71-6d372887f159'::uuid, 'Anderson Presidency Released 18 October 2026', 'Anderson Presidency'),
    -- "Hill Presidency Released 18 October 2026" -> "Hill Presidency"
    ('ffd1cafe-5c48-447b-88e4-612c11a06593'::uuid, 'Hill Presidency Released 18 October 2026', 'Hill Presidency')
)
UPDATE callings c
SET notes = NULLIF(btrim(t.new_notes), '')
FROM targets t
WHERE c.id = t.id
  AND c.notes = t.current_notes
RETURNING c.id, t.current_notes AS old_notes, c.notes AS new_notes;
