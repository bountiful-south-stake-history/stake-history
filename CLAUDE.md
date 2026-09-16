# CLAUDE.md

## What this is

The Bountiful South Stake history site — an interactive record of leadership callings, people, buildings, and member-contributed photos and memories. Stack: React + TypeScript + Vite + Tailwind, Supabase (Postgres + Auth + Storage), hosted on Vercel. Supabase project ref `kywsocmgkrckwhnmhtfz`. **Merging to `main` deploys to production via Vercel.** This is a live site holding real members' data — there is **no staging environment**, so treat every change as production-bound.

## Working agreement

- **Roles:** Troy directs. An architect session (Claude chat) plans and reviews. Claude Code (CC) executes.
- **DB reads:** CC reads the live database only through the **`supabase-stake` MCP** (read-only). Its access token must be an unscoped legacy token, or a scoped token that includes this project; a "does not have the necessary privileges" error means the token is scoped to the wrong org, not that the project is missing.
- **No prod writes by CC, ever.** Migrations are drafted in `supabase/migrations/` marked **NOT APPLIED**. Troy applies them by hand in the Supabase SQL Editor, and every applied migration is recorded in `docs/data-changes.md` **in the same PR**.
- **Bulk ingests** run locally by Troy with the **service-role key** from `.env.local` (never `VITE_`-prefixed, never committed). The anon key is never used for writes.
- **Every change goes through a branch and a PR.** `main` is protected; **Troy merges** — CC does not push to `main`.
- **Ground before building:** re-read the actual code and cite `file:line`. Never reuse citations from a prior session. If grounding contradicts the plan, **stop and report** before writing.

## Read these first

- `docs/moderation-model.md` — the post-moderation canon (why review works the way it does).
- `docs/OPERATIONS.md` — continuity facts (hosting, admin access, recovery, the shared DB, MCP token scope).
- `docs/data-changes.md` — the log of every hand-applied migration.
- `docs/admin-remediation-plan.md` — decisions, priorities, and closed/open security findings.

## State as of 2026-09-15

- **Albums:** schema is live; the import script `scripts/import-album.ts` is ready (requires `--contributor-email`). **No album UI yet** — albums are made visible by a manual `UPDATE albums SET status='approved'` for now.
- **Security (PRs #9–#11, landed):** the database enforces that public submissions can only enter as `pending`; redaction is enforced at the API; admin policies are scoped to authenticated admins.
- **Housekeeping (#13/#14, landed):** photo reject has a two-step confirm; HEIC removed from upload accept lists; multiple pending portraits per person are allowed by design (admins choose).
- `docs/moderation-model.md` is **canon** for the contribution/review model.

## Next up

- **PR 2 — albums UI:** album index and detail pages, cards on ward pages (**including discontinued wards**), per-page web download, an admin **Albums** tab with approve/hide, and a **flag button + hide-able pages from day one**. Starts when the 36th Ward scrapbook scans are ~a week out; **needs the 36th Ward `organization_id`**.
- **PR 3 — member contributions:** live tagging/context for signed-in members, flags, hide/revert, an **admin review digest** reusing the existing `weekly-digest` plumbing, an admin-editable notification address via a `site_settings` row, and **non-destructive reject**. Open decisions live in the moderation doc's **Open questions** — do not resolve them without Troy.

## Known sharp edges

See the **Known sharp edges** section of `docs/moderation-model.md` (kept current there; not duplicated here).
