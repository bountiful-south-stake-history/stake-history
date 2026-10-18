-- Migration: Fix High Council release-and-replace fallout (2026-10-18)
-- STATUS: DRAFTED, NOT APPLIED. Pending Troy to run by hand in the Supabase SQL
-- Editor (project ref kywsocmgkrckwhnmhtfz) and record in docs/data-changes.md.
--
-- Background: the "release + add replacement now" flow (handleRelease in
-- src/components/admin/AdminTransitionsTab.tsx) copied the released member's
-- presidency_number to the replacement and never set the presidency label
-- (notes). On the High Council -- a sequentially numbered org, where every
-- member gets their own number -- this produced two bad rows on 2026-10-18:
--   - Erik N. Shegrud: presidency_number 227, a DUPLICATE of the released
--     Samuel J. Bawden (#227), notes NULL.
--   - Spencer D. Arntsen: notes NULL. His number was already corrected to 236
--     by hand via the Fix # tool, which edits only the number, not the label.
-- Current max High Council presidency_number is 236, so Shegrud moves to 237.
--
-- Rows are targeted by id. Each UPDATE re-checks the current value in its WHERE
-- clause, so a rerun or a stale assumption changes 0 rows. Note strings avoid
-- semicolons (Studio's statement checker splits on them).

-- BEFORE: expect Shegrud #227 notes NULL, Arntsen #236 notes NULL
SELECT id, presidency_number, sustained_date, released_date, notes
FROM callings
WHERE id IN (
  'f3009f32-74a1-430b-ba48-d4ea7e8f624d',  -- Erik N. Shegrud
  'b545b60e-04d1-4125-93af-7fd14ece16e5'   -- Spencer D. Arntsen
)
ORDER BY presidency_number;

-- Fix 1: Shegrud 227 -> 237, and set the Hill Presidency label
UPDATE callings
SET presidency_number = 237,
    notes = 'Hill Presidency'
WHERE id = 'f3009f32-74a1-430b-ba48-d4ea7e8f624d'
  AND presidency_number = 227
  AND notes IS NULL;

-- Fix 2: Arntsen keeps #236, set the Hill Presidency label
UPDATE callings
SET notes = 'Hill Presidency'
WHERE id = 'b545b60e-04d1-4125-93af-7fd14ece16e5'
  AND presidency_number = 236
  AND notes IS NULL;

-- AFTER: expect Shegrud #237 'Hill Presidency', Arntsen #236 'Hill Presidency'
SELECT id, presidency_number, sustained_date, released_date, notes
FROM callings
WHERE id IN (
  'f3009f32-74a1-430b-ba48-d4ea7e8f624d',
  'b545b60e-04d1-4125-93af-7fd14ece16e5'
)
ORDER BY presidency_number;

-- Duplicate check across the High Council (expect 0 rows after the fix)
SELECT presidency_number, COUNT(*)
FROM callings
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'High Council')
GROUP BY presidency_number
HAVING COUNT(*) > 1;
