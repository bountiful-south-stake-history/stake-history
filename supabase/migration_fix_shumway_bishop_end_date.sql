-- Migration: Fix Roger G. Shumway Jr. Bishop calling end date
-- Run this in Supabase SQL Editor
--
-- Shumway served as Bishop (17th Bishopric) from August 18, 2019 and was replaced
-- by Allen N. Whipple on November 26, 2023. The released_date was incorrectly left NULL.

UPDATE callings
SET
  released_date      = '2023-11-26',
  released_precision = 'exact',
  notes              = NULL
WHERE
  person_id = (SELECT id FROM people WHERE full_name = 'Roger G. Shumway Jr.')
  AND position_id = (SELECT id FROM positions WHERE title = 'Bishop')
  AND presidency_number = 17
  AND sustained_date = '2019-08-18'
  AND released_date IS NULL;
