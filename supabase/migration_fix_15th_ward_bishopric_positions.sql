-- Migration: Fix 15th Ward presidency 14 bishopric position_ids
-- EXECUTED 2026-09-14. Corrects wrong position_ids written by the admin transition
-- tool (see follow-up fix). Do not re-run.
--
-- The "create new presidency" path (AdminTransitionsTab.tsx handleBatchSave) fetched
-- positions with no ORDER BY and collapsed all president-type rows into one slot and
-- all counselor-type rows into one slot, so the new bishopric was written as
-- Director (should be Bishop) and both counselors as 3rd Counselor. These three
-- UPDATEs re-point each row to the correct position, keyed on organization, person,
-- presidency number, and the wrong position it was given.

-- Wendel: Director -> Bishop
UPDATE callings
SET position_id = (SELECT id FROM positions WHERE title = 'Bishop' AND position_type = 'president')
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 15th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Jason A. Wendel')
  AND presidency_number = 14
  AND position_id = (SELECT id FROM positions WHERE title = 'Director' AND position_type = 'president');

-- Higginson: 3rd Counselor -> 1st Counselor
UPDATE callings
SET position_id = (SELECT id FROM positions WHERE title = '1st Counselor' AND position_type = 'counselor')
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 15th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Colby J. Higginson')
  AND presidency_number = 14
  AND position_id = (SELECT id FROM positions WHERE title = '3rd Counselor' AND position_type = 'counselor');

-- Maudsley: 3rd Counselor -> 2nd Counselor
UPDATE callings
SET position_id = (SELECT id FROM positions WHERE title = '2nd Counselor' AND position_type = 'counselor')
WHERE organization_id = (SELECT id FROM organizations WHERE name = 'Bountiful 15th Ward')
  AND person_id = (SELECT id FROM people WHERE full_name = 'Andrew J. Maudsley')
  AND presidency_number = 14
  AND position_id = (SELECT id FROM positions WHERE title = '3rd Counselor' AND position_type = 'counselor');
