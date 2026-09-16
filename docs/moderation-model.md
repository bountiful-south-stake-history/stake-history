# Moderation model — the post-moderation canon

**What this is.** The reasoning behind how contributions are reviewed on this site, the rules that follow from it, what exists today, and what each planned change adds. If you are a steward taking this over — or a future Claude session — read this first. It explains *why* the site behaves as it does, so the behavior can outlive the person who built it.

---

## Why post-moderation

The site is moving from **pre-moderation** (an admin approves every submission before anyone sees it) to **post-moderation** (signed-in members contribute live; review happens by exception, driven by flags).

The reason is the audience. Contributions come from **signed-in stake members** — a community of a few hundred people who know each other, each identifiable by name and email. The realistic failure mode here is a **mistake**, not malice: a wrong tag, a photo someone would rather not share, a memory that is a little too personal. Those are a **flag-and-fix** problem, not a gate-everything problem.

Pre-moderation solves the wrong problem and creates a worse one: it makes the historical record depend on **one motivated person** clearing a queue every week. When that person tires or moves on, the queue stops, submissions stall, and the site quietly dies. The site must survive an unmotivated steward. Post-moderation is how.

---

## Two trust tiers

- **Anonymous submissions (no account) stay pre-moderated.** Name and email are required; the item lands **pending** and an admin approves it before it appears. This path is **intentional design and must not be removed** — many older members have the photos and memories most worth keeping and will never create an account. The name and email are the accountability layer in place of an account.
- **Signed-in members post live.** An account is the accountability boundary: a real person, reachable, who can be asked to fix a mistake. Their contributions appear immediately and are reviewed only if flagged.

The account is the line between "review before" and "review after."

---

## Rules of the model

**(a) Nothing is destructive.** Every tag, context note, and memory is its **own row**, stamped with its author and time. A takedown **hides**, it does not delete; the history is retained and a **revert is one action**. This is what makes live posting safe: any mistake is reversible, so the cost of being wrong is low.

**(b) Flags are the queue.** Every photo, tag, and memory carries a **flag** button. A flag creates a record and notifies the admin address. After **a small number of independent flags** (threshold undecided; see Open questions), an item **auto-hides** pending review. The steward reacts to flags instead of pre-screening everything.

**(c) Passive awareness replaces approval.** Instead of an approval gate, the steward gets a **periodic digest** they can skim — a low-effort way to stay aware of what's being added without standing between members and the site.

**(d) Removal on request, no debate.** Anyone tagged in a photo, or a family member, can **request removal**; the request **hides the tag immediately** pending review. No justification is required. **Living people and minors in old photos** are the privacy edge that gets a hard rule: err toward hiding, always, and fast.

**(e) History is not archived away.** **Discontinued units stay browsable** — a ward that no longer exists is still part of the record and remains visible (marked as discontinued), not hidden.

---

## What exists today

**The database now enforces the review gate (PRs #9–#11, applied 2026-09-15).** Public submissions can only enter as `status='pending'` — the anon key can no longer insert pre-approved rows. This holds for photos, photo tags, memories, portraits, and corrections; album pages inherit their album's status; **redaction is now enforced at the API** (a redacted person is no longer readable through the public data endpoint, not just hidden in the UI); admin policies are scoped to signed-in admins.

**Review is pre-moderation, per surface, one item at a time.** An admin opens each queue and approves or rejects individually — photos, memories, portraits, corrections, suggestions each have their own tab. Approving a tagged photo also records watchlist **activity** for the tagged people. Rejecting a photo deletes its stored image. There is **no batch action**.

**The contribution form is anonymous-friendly.** On a person's page, the form requires a name and email, offers an optional "create an account too" checkbox, and shows a banner stating every submission is reviewed by an administrator before appearing.

**Photos and memories are sign-in gated to view.** The Photo Album and building galleries show a sign-in prompt to signed-out visitors; only members see the photos.

**A member watchlist digest already exists.** A scheduled edge function emails members who opt in (a toggle on their watchlist page, promoted once via a feature announcement) a weekly summary of new activity — photos and memories — for the people they *watch*. It sends through the stake Gmail mailbox over SMTP, spreads sends across the week by user, and sends nothing to a member with no new activity. **This is the proven plumbing** the admin digest below reuses.

**`audit_log` is a trail, not a screen.** Admin actions across the tabs write to `audit_log`, but **nothing in the app ever reads it**. It exists so a future steward can reconstruct what happened; it is not a surface anyone sees day to day.

**Tags are set at submission and replaced wholesale by an admin edit.** A photo's people-tags are written when it is submitted; an admin edit deletes and re-inserts the whole tag set. There is **no way for a member to add a tag to an existing photo** after the fact.

**What does not exist yet:** no flag mechanism; no hide/unhide; no revert; no **admin-facing** digest of new contributions to review; no member-initiated tagging or context on existing photos; no configured admin-notification address (`VITE_ADMIN_EMAIL` was removed and nothing replaced it).

---

## What is pending, mapped to PRs

- **PRs #9–#11 — landed.** The database enforces that public submissions land pending, and redaction is enforced at the API. This is the foundation the rest builds on.
- **PR 2 — albums.** Album index and detail pages, cards on ward pages (**including discontinued wards**), and per-page download. Album pages ship with a **flag button** and **hide-able pages** from day one — the first place the post-moderation tooling appears.
- **PR 3 — member contributions.** Signed-in members can add **live tags and context to any photo**; **flags**, **hide/revert**, and an **admin review digest** land in the same change; and the submission policies gain a clause letting signed-in members insert **live** (not just pending). The admin digest is a **second audience for the existing digest plumbing** — it reuses the same SMTP path and the same `follow_activity` feed, aimed at the steward ("what's new to skim") rather than the member ("activity on people you watch"). **Free live posting must not open before the takedown tooling exists** — that is why live tagging, flags, hide, revert, and the digest are one PR, not several.

---

## The steward's job, in one paragraph

Week to week under this model, a steward **responds to flags**, **skims the digest**, and **approves the occasional anonymous submission**. That is the whole job. There is no queue to clear before members can contribute, and no obligation to watch the site — the flags and the digest bring the exceptions to the steward, rather than requiring the steward to go looking.

---

## Known sharp edges

- **Rejecting a photo deletes its stored image** — *Resolved in #13:* photo reject now requires a two-step inline confirm before it runs (portrait reject already had a confirm modal; memory reject touches no storage). Reject is **still destructive** after confirming — making it non-destructive (retain the object and sweep old rejects on a schedule) is planned for PR 3.
- **Suggestions use a `new`/`reviewed` vocabulary**, not the `pending`/`approved` used elsewhere — a small inconsistency to remember when reasoning about that queue.
- **Multiple pending portraits per person** — *Resolved by design in #14:* this is intentional, not a conflict — an admin chooses which pending portrait to approve. The submit-time note is informational (the submitter may still add theirs), and AdminPortraitsTab approves or rejects each submission independently, leaving the others pending rather than orphaned. No uniqueness is enforced, deliberately.
- **The contribution form accepted HEIC but the storage bucket rejects it** (JPEG/PNG/WebP only) — *Resolved in #13:* HEIC/HEIF was removed from the accept lists on both the contribution form and the admin portrait upload, with a "choose JPEG, not HEIC" message. In-browser HEIC→JPEG conversion isn't viable, so blocking plus guidance is the correct fix.
- **~40 orphaned storage objects** exist versus database rows — *still open.* A read-only report script, `scripts/storage-orphans.ts`, now exists (from #13); Troy runs it with the service-role key for the authoritative list. The actual cleanup sweep has not been done.
- **`people.portrait_pending` is dead schema** — nothing ever sets it to `true` (the portrait submit path writes only `portrait_submissions`; admin approve/reject/replace only ever set it `false`, and there is no trigger; 0 of 738 rows are `true`), so the `!portrait_pending` display gates never fire and it cannot signal a pending portrait. The real pending state lives in `portrait_submissions.status`.

---

## Open questions (undecided — do not resolve without a decision)

- **Probation for new accounts?** Whether a brand-new account's posts should be pending for its first few days.
- **Flag threshold: one or two?** Whether a single flag auto-hides, or it takes two independent flags.
- **Digest cadence: weekly or on-activity?** Whether the admin digest is fixed-weekly or fires when there is something to see.
- **Which address receives flag notifications and the admin digest?** `VITE_ADMIN_EMAIL` is gone and **nothing is configured today**. The stake Gmail mailbox is the obvious candidate, but that is Troy's call.

---

## Where this lives in the code

- **Review queues:** `src/components/admin/AdminPhotosTab.tsx` (approve `:567`, reject `:618`, edit `:408`, delete `:661`); `AdminMemoriesTab.tsx` (approve `:70`, reject `:116`); `AdminPortraitsTab.tsx` (approve/replace/reject, `:437`/`:610`/`:709`); `AdminCorrectionsTab.tsx` (approve→`completed` `:19`, dismiss→`dismissed` `:70`); `AdminSuggestionsTab.tsx`.
- **Anonymous contribution form:** `src/components/people/ContributionModal.tsx` — required name/email (`:344-352`), optional account checkbox (`:1384-1405`), reviewed-by banner (`:1276-1281`), photo insert as `pending` (`:1105-1117`), tag insert (`:1143-1150`).
- **Sign-in gates:** `src/pages/PhotoAlbumPage.tsx:222-246`; `src/components/archives/BuildingPhotoAlbum.tsx:129` (submit button behind a signed-in check).
- **Watchlist activity + likes:** `follow_activity` written on approval (`AdminPhotosTab.tsx:592-602`); likes in `src/hooks/usePhotoLikes.ts`.
- **Member watchlist digest:** `supabase/functions/weekly-digest/index.ts`; opt-in toggle `src/pages/MyWatchlistPage.tsx:191-221`; promo `src/components/announcements/FeatureAnnouncementModal.tsx:67`.
- **Audit trail:** `audit_log` inserts across `src/components/admin/*Tab.tsx` (e.g. `AdminPhotosTab.tsx:513`, `:696`); never read by the app.
- **Discontinued units stay visible:** `src/lib/utils.ts:3-4` (`isDiscontinuedOrg`); `src/pages/OrganizationPage.tsx:104-106`.
- **DB-level gates (PRs #9–#11):** `supabase/migrations/20260915130000_tighten_submission_policies.sql` (pending-only INSERT + `photo_is_pending`), `20260915140000_drop_anon_people_update.sql`, `20260915150000_policy_cleanup.sql`; album status gate in `20260915120000_add_albums.sql`. Applied dates in `docs/data-changes.md`.
