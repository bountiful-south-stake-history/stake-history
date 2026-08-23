-- Rename building_id 'middle-building' -> '102-e-1400-s'
--
-- WHY: Building ids are being moved from directional names (which are unstable)
-- to address-derived ids (which are stable). The 'middle-building' record is
-- being sold this year and a West Building opens within months, so the
-- directional id would become misleading. The application code now uses the
-- address-derived id '102-e-1400-s' for this building. This migration realigns
-- the persisted data with the deployed code.
--
-- WHAT: Updates building_id on the photos and memories tables. The other two
-- buildings ('stake-center' -> '1250-s-main', 'south-building' -> '1500-s-600-e')
-- have NO rows in either table, so they need no data change -- this migration
-- only touches the single value that actually has data.
--
-- CAUTION: building_id is a bare nullable text column. It has NO foreign key,
-- NO check constraint, and NO default on either table. Nothing in the database
-- will reject an invalid value -- a typo in the string below would silently
-- orphan rows (they simply stop matching any building) with no error. Copy the
-- id values exactly. A verified pg_dump backup exists off-machine before running.
--
-- HOW TO RUN: Execute by hand in the Supabase SQL editor. There is intentionally
-- no BEGIN/COMMIT block -- the web SQL editor runs statements atomically and does
-- not accept an explicit transaction wrapper here. The UPDATEs are idempotent:
-- running this twice is safe because the second run matches zero 'middle-building'
-- rows. Read the BEFORE and AFTER counts to confirm the row counts moved as
-- expected (68 photos + 1 memory should shift from 'middle-building' to
-- '102-e-1400-s').

-- BEFORE: current distribution (expect photos middle-building=68, memories middle-building=1)
SELECT 'photos' AS tbl, building_id, count(*) AS rows
FROM photos
GROUP BY building_id
UNION ALL
SELECT 'memories' AS tbl, building_id, count(*) AS rows
FROM memories
GROUP BY building_id
ORDER BY tbl, building_id;

-- Rename on photos (idempotent: only matches the old id)
UPDATE photos
SET building_id = '102-e-1400-s'
WHERE building_id = 'middle-building';

-- Rename on memories (idempotent: only matches the old id)
UPDATE memories
SET building_id = '102-e-1400-s'
WHERE building_id = 'middle-building';

-- AFTER: verify the move (expect photos 102-e-1400-s=68, memories 102-e-1400-s=1,
-- and zero rows remaining for building_id = 'middle-building')
SELECT 'photos' AS tbl, building_id, count(*) AS rows
FROM photos
GROUP BY building_id
UNION ALL
SELECT 'memories' AS tbl, building_id, count(*) AS rows
FROM memories
GROUP BY building_id
ORDER BY tbl, building_id;
