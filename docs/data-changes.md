# Data changes log

Every SQL script run by hand against production (Supabase Studio, project `kywsocmgkrckwhnmhtfz`) is recorded here. Migration files in `supabase/` are the scripts; this log is the index of what ran, when, and how it was verified.

Convention: one entry per executed script. Never re-run a listed script. Add the entry in the same PR that adds the migration file.

| Date | Script | What it changed | Verified by |
|---|---|---|---|
| 2026-09-14 | `migration_discontinue_36th_39th_wards_and_stake_mission.sql` | Set `discontinued_date` + appended `notes` for Bountiful 36th Ward, 39th Ward, and the Stake Mission | Before/after `SELECT` on the three orgs (57th Ward included for comparison only), 4 rows |
| 2026-09-14 | `migration_release_36th_39th_bishoprics.sql` | Released the six sitting bishopric callings of the 36th and 39th Wards (released 2026-09-13, `released_precision = 'exact'`) | Before-check returned exactly 6 current rows (all notes `'Current'`); after-check confirmed 6 released (0 current) |
| 2026-09-14 | `migration_fix_15th_ward_bishopric_positions.sql` | Corrected 3 wrong `position_id`s written by the admin transition tool for 15th Ward presidency 14 (Director→Bishop, and two counselors) | `SELECT` on 15th Ward presidency 14 confirming the three corrected positions |
| 2026-09-14 | `migration_realignment_counselor_changes_2026-09-13.sql` | 5 counselor releases + 5 new callings (2026-09-13 realignment), 1 new person (Kyle P. Allcott), and cleanup of stale `notes='Current'` on the 15th Ward's released presidency #13 | 15 current bishopric callings across the five wards (three per ward) |
| **NOT YET APPLIED** | `migrations/20260915120000_add_albums.sql` | Adds the `albums` table; adds nullable `album_id`/`album_page`/`web_path`/`thumb_path` to `photos`; replaces the `"Public can view approved photos"` SELECT policy so album pages inherit their album's `status`. DRAFT on branch `feature/albums-ingest`. | **Pending** — apply by hand in the SQL Editor, then replace this cell with the verification (expect: `albums` present + RLS on; the 115 existing approved photos still visible; a `status='pending'` album's pages return 0 rows to anon) |

Earlier hand-run migrations (pre-2026-09-14) exist in `supabase/` but were not logged here; see each file's header.
