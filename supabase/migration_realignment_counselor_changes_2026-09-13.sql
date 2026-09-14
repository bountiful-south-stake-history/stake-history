-- Migration: Counselor changes from the 13 September 2026 stake boundary realignment
-- EXECUTED 2026-09-14 by hand in Supabase SQL Editor (project ref kywsocmgkrckwhnmhtfz).
-- Recorded here for the trail. Do not re-run. Verified afterward: 15 current
-- bishopric callings across the five wards, three per ward.
--
-- Releases (2026-09-13): Buttars (25th 1st C), Johnson (14th 1st C), Misener (4th 2nd C),
--   Barker (20th 2nd C), Steenblik (7th 2nd C, called to 4th same day).
-- New callings (2026-09-13, same presidency numbers): Pay -> 25th 1st C (#13),
--   Bawden -> 14th 1st C (#15), Steenblik -> 4th 2nd C (#18), Allcott -> 20th 2nd C (#14, new person),
--   Baxter -> 7th 2nd C (#17).
-- Also cleaned stale notes='Current' on the 15th Ward's released presidency #13.
-- Note strings avoid semicolons: Studio's statement checker splits on them.

-- New person (added before the calling that references him)
INSERT INTO people (full_name) VALUES ('Kyle P. Allcott');

-- Releases (2026-09-13)
UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released 13 September 2026 in the stake boundary realignment'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 25th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Broderick V. Buttars')
  AND released_date IS NULL;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released 13 September 2026 in the stake boundary realignment'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 14th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'C. Scott Johnson')
  AND released_date IS NULL;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released 13 September 2026 in the stake boundary realignment'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 4th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Gregory R. Misener')
  AND released_date IS NULL;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released 13 September 2026 in the stake boundary realignment'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 20th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Trent B. Barker')
  AND released_date IS NULL;

UPDATE callings
SET released_date = '2026-09-13',
    released_precision = 'exact',
    notes = COALESCE(NULLIF(notes, 'Current') || ' ', '') || 'Released 13 September 2026 in the stake boundary realignment. Called as 2nd Counselor in the Bountiful 4th Ward the same day'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 7th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Jason J. Steenblik')
  AND released_date IS NULL;

-- New callings (2026-09-13, same presidency numbers)
INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision)
VALUES (
  (SELECT id FROM people WHERE full_name = 'Joshua E. Pay'),
  (SELECT id FROM positions WHERE title = '1st Counselor' AND position_type = 'counselor'),
  (SELECT id FROM organizations WHERE name = 'Bountiful 25th Ward'),
  13, '2026-09-13', 'exact'
);

INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision)
VALUES (
  (SELECT id FROM people WHERE full_name = 'Samuel J. Bawden'),
  (SELECT id FROM positions WHERE title = '1st Counselor' AND position_type = 'counselor'),
  (SELECT id FROM organizations WHERE name = 'Bountiful 14th Ward'),
  15, '2026-09-13', 'exact'
);

INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision)
VALUES (
  (SELECT id FROM people WHERE full_name = 'Jason J. Steenblik'),
  (SELECT id FROM positions WHERE title = '2nd Counselor' AND position_type = 'counselor'),
  (SELECT id FROM organizations WHERE name = 'Bountiful 4th Ward'),
  18, '2026-09-13', 'exact'
);

INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision)
VALUES (
  (SELECT id FROM people WHERE full_name = 'Kyle P. Allcott'),
  (SELECT id FROM positions WHERE title = '2nd Counselor' AND position_type = 'counselor'),
  (SELECT id FROM organizations WHERE name = 'Bountiful 20th Ward'),
  14, '2026-09-13', 'exact'
);

INSERT INTO callings (person_id, position_id, organization_id, presidency_number, sustained_date, sustained_precision)
VALUES (
  (SELECT id FROM people WHERE full_name = 'Jason W. Baxter'),
  (SELECT id FROM positions WHERE title = '2nd Counselor' AND position_type = 'counselor'),
  (SELECT id FROM organizations WHERE name = 'Bountiful 7th Ward'),
  17, '2026-09-13', 'exact'
);

-- Cleanup: stale notes='Current' on the 15th Ward's released presidency #13
UPDATE callings
SET notes = 'Released 13 September 2026 in the stake boundary realignment'
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 15th Ward')
  AND presidency_number = 13
  AND notes = 'Current';
