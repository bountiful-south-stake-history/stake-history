-- Migration: Release the sitting bishoprics of the Bountiful 36th and 39th Wards
-- Run this in Supabase SQL Editor (project ref kywsocmgkrckwhnmhtfz).
--
-- Confirmed by Troy: all six bishopric callings were current on 2026-09-13.
-- The wards were discontinued 13 September 2026 in a boundary realignment, and
-- every sitting bishopric member was released the same day. Run the opening
-- SELECT first as a sanity check that it returns exactly six rows before running
-- the UPDATE. Sets released_precision = 'exact', matching the Shumway precedent.
-- 'Current' is a status marker, not history; NULLIF drops it on release while preserving any other existing note.
-- Executed 2026-09-14. Before-check returned exactly six rows, all notes = 'Current'; after-check confirmed six rows released.

-- Before (expect exactly 6 rows: Bishop + two counselors in each of the two wards):
SELECT o.name AS ward, pos.title, p.full_name, c.sustained_date, c.released_date, c.notes
FROM callings c
JOIN organizations o ON o.id = c.organization_id
JOIN people p ON p.id = c.person_id
JOIN positions pos ON pos.id = c.position_id
WHERE o.name IN ('Bountiful 36th Ward', 'Bountiful 39th Ward')
  AND c.released_date IS NULL
ORDER BY o.name, pos.title;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released when the Bountiful 36th Ward was discontinued 13 September 2026'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 36th Ward')
  AND released_date IS NULL;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released when the Bountiful 39th Ward was discontinued 13 September 2026'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 39th Ward')
  AND released_date IS NULL;

-- After (the same query should now return 0 rows):
SELECT o.name AS ward, pos.title, p.full_name, c.sustained_date, c.released_date, c.notes
FROM callings c
JOIN organizations o ON o.id = c.organization_id
JOIN people p ON p.id = c.person_id
JOIN positions pos ON pos.id = c.position_id
WHERE o.name IN ('Bountiful 36th Ward', 'Bountiful 39th Ward')
  AND c.released_date IS NULL
ORDER BY o.name, pos.title;
