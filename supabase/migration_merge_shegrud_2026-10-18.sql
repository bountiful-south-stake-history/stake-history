-- Migration: Merge duplicate person records for Erik N. Shegrud (2026-10-18)
-- STATUS: DRAFTED, NOT APPLIED — pending Troy to run by hand in the Supabase SQL
-- Editor (project ref kywsocmgkrckwhnmhtfz) and record in docs/data-changes.md.
--
-- Two rows exist for the same man (Troy confirmed):
--   OLD (keep): 441c0017-ef60-45b7-875e-b118d48a9082  full_name 'Eric N. Shegrud'
--               created 2025-12-16, holds the history (two Bountiful 20th Ward
--               counselor callings). Spelling is wrong.
--   NEW (drop): a36f6251-c484-48a9-b82c-86fac2499bff  full_name 'Erik N. Shegrud'
--               created 2026-10-18 when added as High Councilor (#238, Hill
--               Presidency). Spelling is correct.
--
-- Plan: repoint every reference from NEW -> OLD, rename OLD to the correct
-- spelling, then delete the NEW row. All of his callings are preserved and NONE
-- are released or changed (the Bountiful 20th Ward counselor calling stays exactly
-- as-is — Troy handles any calling changes separately in the app).
--
-- Grounding (read-only, 2026-10-18): the only child rows that exist for either id
-- are in `callings` (OLD has 2, NEW has 1). Every other person-FK table
-- (audio_clips, correction_requests, follow_activity, media_people, memories,
-- person_follows, photo_people, portrait_history, portrait_submissions,
-- story_people) has 0 rows for both ids. They are still repointed below for
-- robustness in case a row is added before this runs; the junction tables with a
-- composite unique key (media_people, person_follows, photo_people, story_people)
-- were empty for both ids at drafting, so no composite-key collision is possible.
-- Should one arise before apply, the BEGIN/COMMIT below aborts the whole merge
-- (nothing half-done) and the colliding rows would need manual dedup first.
--
-- `callings` has no unique key beyond its PK, so moving person_id cannot collide.
-- The audit_log JSON references the NEW id once (the add_calling for #238); that is
-- a historical record of what happened and is deliberately LEFT AS-IS.
-- No person-merge function exists; `current_callings` is a plain view (the rename
-- propagates automatically); there are no slug/search/cached-name fields to update;
-- neither record has a photo or portrait. `photos.additional_people` (free text)
-- does not mention the surname.
--
-- Avoid semicolons inside string literals.

BEGIN;

-- Repoint every person reference from the NEW id to the OLD id (target by id).
UPDATE callings             SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE audio_clips          SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE correction_requests  SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE follow_activity      SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE media_people         SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE memories             SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE person_follows       SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE photo_people         SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE portrait_history     SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE portrait_submissions SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';
UPDATE story_people         SET person_id = '441c0017-ef60-45b7-875e-b118d48a9082' WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff';

-- Correct the spelling on the record we keep (guarded on the current misspelling).
UPDATE people
SET full_name = 'Erik N. Shegrud', updated_at = now()
WHERE id = '441c0017-ef60-45b7-875e-b118d48a9082'
  AND full_name = 'Eric N. Shegrud';

-- Delete the duplicate NEW row last (guarded by id AND full_name).
DELETE FROM people
WHERE id = 'a36f6251-c484-48a9-b82c-86fac2499bff'
  AND full_name = 'Erik N. Shegrud';

COMMIT;

-- Verification (single SELECT, shown by Studio). Expected: 3 rows, one per calling,
-- all with person 'Erik N. Shegrud' (the OLD id 441c0017…):
--   Bountiful 20th Ward / 2nd Counselor / #12 / 2019-06-23 -> 2019-12-29
--   Bountiful 20th Ward / 1st Counselor / #13 / 2019-12-29 -> 2025-08-24
--   High Council        / High Councilor / #238 / Hill Presidency / 2026-10-18 -> (null)
-- In every row new_id_refs_remaining = 0 and new_person_rows_remaining = 0.
SELECT
  pe.id          AS person_id,
  pe.full_name,
  o.name         AS org,
  pos.title      AS position,
  c.presidency_number,
  c.notes,
  c.sustained_date,
  c.released_date,
  (
    (SELECT count(*) FROM callings             WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM audio_clips          WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM correction_requests  WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM follow_activity      WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM media_people         WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM memories             WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM person_follows       WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM photo_people         WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM portrait_history     WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM portrait_submissions WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff') +
    (SELECT count(*) FROM story_people         WHERE person_id = 'a36f6251-c484-48a9-b82c-86fac2499bff')
  ) AS new_id_refs_remaining,
  (SELECT count(*) FROM people WHERE id = 'a36f6251-c484-48a9-b82c-86fac2499bff') AS new_person_rows_remaining
FROM people pe
LEFT JOIN callings c       ON c.person_id = pe.id
LEFT JOIN organizations o  ON o.id = c.organization_id
LEFT JOIN positions pos    ON pos.id = c.position_id
WHERE pe.id = '441c0017-ef60-45b7-875e-b118d48a9082'
ORDER BY c.sustained_date;
