# Operations & Continuity Notes

**What this is:** the narrow set of facts a successor cannot discover by exploring the running site, and would otherwise have to get from the current owner. It is **not** the operator's manual — that fuller how-to comes after the admin UI is redesigned. Nothing here should describe buttons or screens, so it stays true even when the admin interface changes.

Everything below is drawn from the three record documents listed at the end. Where a fact is not recorded, it is marked **unknown** rather than guessed.

---

## Where the site lives

- **Hosting:** Vercel, deploying automatically from the `main` branch of the GitHub repository. A push to `main` triggers a production deploy.
- **Custom domain:** `history.bountifulsouthstake.org`.
- **Backend:** a single Supabase project (PostgreSQL + Auth + Storage). The project reference is the subdomain of the project's URL; the literal value is not recorded in these docs — read it from the deployment's `VITE_SUPABASE_URL` environment variable or from the Supabase dashboard once you have access.
- **Environment variables:** the app reads `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. These live in Vercel's project settings (and in a local `.env.local` for development, copied from `.env.example`). They are not committed to the repo.
- **Supabase Auth configuration is not in this repo.** SMTP, the redirect allowlist, email templates, and link-expiry settings are all dashboard state in the Supabase project. The recorded values are in **§10.2 of `docs/admin-remediation-plan.md`** — consult that section rather than assuming defaults.

---

## How admin access works

Admin rights are decided entirely by one column: **`user_profiles.role` set to `'admin'`**. There is no admin email list and no environment variable that grants access.

- An **existing admin** can promote another account through the admin Users tab.
- If **no admin is available**, promotion requires a **direct database write** to set that column. This path is intentional: the trigger that guards the privileged columns on `user_profiles` permits writes coming from a **direct database session** (as opposed to an ordinary signed-in user through the API), precisely so this recovery route survives even when no one can log in as admin.

---

## Recovering a locked-out administrator

Three routes back in, in order of preference:

1. **Self-service password reset** — the site has a working `/reset-password` flow (request a link by email, then set a new password). A locked-out admin who still controls their mailbox can recover themselves.
2. **Dashboard password reset** — a Supabase project owner can reset an account's password from the Auth section of the dashboard.
3. **Direct role write** — if the account itself is lost, set `user_profiles.role = 'admin'` on a known-good account directly in the database (see the recovery path above).

**As of this writing there is exactly one admin account.** A single admin is a single point of failure for handoff; treat standing up a second trusted admin as a priority when one becomes available.

---

## The recovery trust model

Password recovery **signs the user in via a link emailed to the account's address**. Therefore **whoever controls a mailbox controls any account registered to it.** This is not a bug; it is how email-based recovery works. The operational consequence here is that the mailbox tied to the admin account is itself a privileged credential — its access list is effectively the admin access list. Securing a handoff includes securing that mailbox, not just the admin login.

---

## The shared database

This Supabase project **also serves a second, separate application**: the transcript-review app at `transcript.bountifulsouthstake.org`. That app is a different codebase, and it uses the Supabase **anon key for full CRUD on the `contacts` and `talk_transcripts` tables**.

The consequence is a hard rule: **any change to database permissions (RLS, grants, revokes) must account for both applications.** A change that looks safe from inside this repository can silently break the transcript app, because this repo cannot see how that other app authenticates. This was discovered during the security work — a repo-scoped dependency check is **insufficient** here, and the security plan deliberately holds those two tables back from lockdown until the other app's database role is confirmed.

Every SQL script run by hand against production is recorded in **`docs/data-changes.md`** — the index of what ran, when, and how it was verified; add an entry there in the same PR that adds the migration file. `npm run lint` is currently unrunnable: `eslint.config.js` targets ESLint 9 / typescript-eslint but `package.json` still declares ESLint 8 — tracked as a separate migration.

---

## Inspecting the database (read-only MCP) and bulk ingest

- **Read-only inspection** of the production database is done through the **`supabase-stake`** MCP server (user-scope entry in `~/.claude.json`, `npx @supabase/mcp-server-supabase --read-only`, project ref `kywsocmgkrckwhnmhtfz`). It connects as `supabase_read_only_user` and can only `SELECT`.
  - Its `SUPABASE_ACCESS_TOKEN` must be **either an unscoped (legacy) personal token, or a scoped token whose scope includes project `kywsocmgkrckwhnmhtfz`**. This token is shared with the `supabase-appointments` server, which points at a *different* project in a *different* org — so a token scoped only to that org will authenticate but be refused here.
  - A **`"Your account does not have the necessary privileges … Access to project 'kywsocmgkrckwhnmhtfz' was denied"`** error means the **token is scoped to the wrong organization**, not that the project is missing or the server is misconfigured. Fix it by pointing `supabase-stake` at a token that includes this project's org, then restart the MCP server. (A project-scoped `supabase` entry with a token dedicated to this project also exists in the repo's local settings and can be used as the correct-scope reference.)

- **Bulk production ingest is a local developer task, not an admin action.** Large imports (e.g. scanned scrapbook albums via [`scripts/import-album.ts`](../scripts/import-album.ts)) are run **by the developer locally** with the **service-role key loaded from a gitignored `.env.local`** (variable `SUPABASE_SERVICE_ROLE_KEY`, no `VITE_` prefix — a `VITE_` var would be bundled into the public browser build). The service-role key bypasses RLS and is a password-grade secret; it is never committed and never used from the browser. The **anon key is never used for writes** — the import script decodes the key and refuses to run unless its role is `service_role`.
  - Every such run still follows the standing rule: **the migration it depends on is applied by hand and logged in [`docs/data-changes.md`](./data-changes.md)** in the same PR, and the album stays `status='pending'` (invisible) until it is reviewed and approved.

---

## What requires a developer

Some content is code, not data, and cannot be changed through any UI:

- **Buildings, timeline entries, and all narrative/site text** are hardcoded in source (the buildings and timeline live in a TypeScript data file; narrative text is in components). Changing any of it requires a **code change and a redeploy**. A volunteer will look for an "edit" button and find none — there isn't one by design.
- **The positions list** (Stake President, Bishop, High Councilor, etc.) is **seeded in SQL** and read into dropdowns at runtime. There is **no UI to add, rename, or remove a position**; a new one requires a developer or a direct database insert.

If a request touches any of the above, it is a developer task, not an admin task.

---

## Where the record of past work lives

Read these before changing anything. They are the memory of why the system is the way it is.

- **`docs/admin-ux-inventory.md`** — the factual, code-cited inventory of the admin surface: what every tab and action does, what tables it touches, and where the sharp edges are. This is the grounding all other claims trace back to.
- **`docs/admin-ux-verification.md`** — the verification pass over that inventory: literal code, grep results, and a verdict for each load-bearing claim. Consult it when you need to trust a specific claim.
- **`docs/admin-remediation-plan.md`** — the decisions and priorities for fixing the admin surface, the closed and open security findings, the recorded Supabase configuration (§10.2), and the dated session log of work done. This is where "what was decided and why" lives; do not re-litigate its closed decisions without cause.
- **`docs/moderation-model.md`** — the canon for how contributions are reviewed: why the site is moving from pre-moderation to post-moderation, the two trust tiers, the flag/hide/revert rules, what exists today, and what each planned PR adds.

---

## If you are taking this over

Verify these three things first, before touching anything:

1. **You can sign in as an admin** on the live site (an account whose `user_profiles.role` is `'admin'`).
2. **You can reach the Supabase project** — log in to the dashboard and confirm you have access to this project's database, Auth, and settings.
3. **You can deploy** — confirm you have access to the Vercel project and that a push to `main` produces a production deploy.

If any of the three fails, resolve it with the outgoing owner while they are still reachable. These are the credentials that cannot be recovered from inside the code.
