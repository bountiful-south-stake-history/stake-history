-- Migration: Discontinue Bountiful 36th and 39th Wards; record Stake Mission discontinuation
-- Run this in Supabase SQL Editor (project ref kywsocmgkrckwhnmhtfz).
-- Run BEFORE deploying the discontinue-36th-39th-wards branch — the homepage
-- asterisk now reads discontinued_date instead of hardcoded names.
--
-- 36th and 39th Wards discontinued 13 September 2026 in a boundary realignment
-- to strengthen wards. Stake Mission discontinued per spring 2002 First
-- Presidency directive; presidency released 19 May 2002.
-- The 57th Ward is included in the SELECTs for comparison only; it is not updated.
--
-- Executed 2026-09-14. Live notes for all three orgs were already populated
-- (richer than the seed), so this appends rather than overwrites. Note text
-- avoids semicolons: Supabase Studio's statement checker splits on them and
-- falsely reports an UPDATE without WHERE.

-- Before:
SELECT name, org_type, discontinued_date, notes FROM organizations
WHERE name IN ('Bountiful 36th Ward', 'Bountiful 39th Ward', 'Bountiful 57th Ward') OR name ILIKE '%mission%';

UPDATE organizations
SET discontinued_date = '2026-09-13',
    notes = notes || ' Discontinued 13 September 2026 in a boundary realignment to strengthen wards. Members were absorbed into the Bountiful 7th, 15th, and 20th Wards.'
WHERE name = 'Bountiful 36th Ward';

UPDATE organizations
SET discontinued_date = '2026-09-13',
    notes = notes || ' Discontinued 13 September 2026 in a boundary realignment to strengthen wards. Members were divided between the Bountiful 14th and 25th Wards.'
WHERE name = 'Bountiful 39th Ward';

UPDATE organizations
SET discontinued_date = '2002-05-19',
    notes = notes || ' The stake mission presidency was released 19 May 2002.'
WHERE name = 'Stake Mission';

-- After:
SELECT name, org_type, discontinued_date, notes FROM organizations
WHERE name IN ('Bountiful 36th Ward', 'Bountiful 39th Ward', 'Bountiful 57th Ward') OR name ILIKE '%mission%';
