# Admin Surface Inventory — Bountiful South Stake History Site

**Purpose:** Grounding document for a UX audit of the admin area. This is a read-only inventory of what exists in the code as of this writing. It does not propose fixes.

**Scope note:** The "admin area" is a single tabbed dashboard behind `/admin`. Some tasks the audit cares about (adding a person, editing buildings, editing narratives) are *not* done in the admin dashboard at all — they happen through a hidden sub-flow, through a static code file, or not through any UI. Those cases are called out explicitly.

Every claim below cites a file and line. Where behavior is inferred rather than read directly, it is labeled **(inference)**.

---

## 1. Route and screen map

There is exactly **one** admin route.

| Route | Component | How you reach it |
|---|---|---|
| `/admin` | [AdminPage.tsx](../src/pages/AdminPage.tsx) → [AdminDashboard.tsx](../src/components/admin/AdminDashboard.tsx) | "Admin" link in the header nav, shown only to admins |

- The full route table is in [App.tsx:22-33](../src/App.tsx#L22-L33). `/admin` is the only admin-gated route; all others (`/`, `/person/:id`, `/org/:id`, `/photos`, `/photo/:photoId`, `/archives`, `/about`, `/my-watchlist`, `/search`) are public.
- The "Admin" nav link only renders when `isAdmin` is true: [Header.tsx:46-50](../src/components/layout/Header.tsx#L46-L50) (desktop) and [Header.tsx:137-145](../src/components/layout/Header.tsx#L137-L145) (mobile).
- [AdminPage.tsx:10-31](../src/pages/AdminPage.tsx#L10-L31): a non-admin who navigates to `/admin` directly is redirected to `/` (or sees "Access Denied" briefly). So the URL is not a back door.

### Screens within `/admin` (tabs, not routes)

The dashboard is a single component with client-side tab state ([AdminDashboard.tsx:18](../src/components/admin/AdminDashboard.tsx#L18)). **None of these tabs has its own URL** — they are not routes, so they cannot be linked to, bookmarked, or reached by typing a URL. Reloading the page always returns to the default "Portraits" tab ([AdminDashboard.tsx:18](../src/components/admin/AdminDashboard.tsx#L18)).

Tabs are split into two visual groups: five top-level tabs and a "Tools" dropdown ([AdminDashboard.tsx:23-36](../src/components/admin/AdminDashboard.tsx#L23-L36)):

| Tab label in UI | Internal id | Component | Group |
|---|---|---|---|
| Portraits | `portraits` | [AdminPortraitsTab.tsx](../src/components/admin/AdminPortraitsTab.tsx) | top row (default) |
| Corrections | `corrections` | [AdminCorrectionsTab.tsx](../src/components/admin/AdminCorrectionsTab.tsx) | top row |
| Memories | `memories` | [AdminMemoriesTab.tsx](../src/components/admin/AdminMemoriesTab.tsx) | top row |
| Photos | `photos` | [AdminPhotosTab.tsx](../src/components/admin/AdminPhotosTab.tsx) | top row |
| Suggestions | `suggestions` | [AdminSuggestionsTab.tsx](../src/components/admin/AdminSuggestionsTab.tsx) | top row |
| **Fix Names** | `people` | [AdminPeopleTab.tsx](../src/components/admin/AdminPeopleTab.tsx) | Tools dropdown |
| **Fix All Else** | `callings` | [AdminCallingsTab.tsx](../src/components/admin/AdminCallingsTab.tsx) | Tools dropdown |
| **Manage Callings** | `transitions` | [AdminTransitionsTab.tsx](../src/components/admin/AdminTransitionsTab.tsx) | Tools dropdown |
| Users | `users` | [AdminUsersTab.tsx](../src/components/admin/AdminUsersTab.tsx) | Tools dropdown |

Label ↔ id mapping is at [AdminDashboard.tsx:31-36](../src/components/admin/AdminDashboard.tsx#L31-L36). The tab-render switch is at [AdminDashboard.tsx:170-178](../src/components/admin/AdminDashboard.tsx#L170-L178).

**Screens reachable only by an unlabeled path (flag):**
- The **"Add a calling" and "Add a new person"** functions live *inside* the "Manage Callings" tab (`transitions`). Nothing in the tab name or the dashboard tells a user that creating a person happens there. See §3 and §4.
- There is **no admin screen at all** for buildings, timeline entries, or site narrative text. Those are not tabs and not routes. See §3 and §8.

**Non-obvious tab names (flag for audit):** "Fix Names" edits people, "Fix All Else" edits calling records, and "Manage Callings" adds/releases callings. The three are easy to confuse, and the most powerful one ("Manage Callings," which also creates people) is buried in a dropdown.

---

## 2. Action inventory (every write action in the admin area)

Legend for "Confirm?": **none** = fires on click; **1-click arm** = button changes to "Are you sure?" first; **type-DELETE** = modal requiring the word DELETE; **double-entry** = value must be typed twice; **3× dialog** = three sequential `window.confirm`.

Most actions are **not reversible from the UI**; where an inverse action exists it is noted. Many writes are logged to the `audit_log` table, but that log has **no viewer in the UI** — see §8.

### Portraits tab ([AdminPortraitsTab.tsx](../src/components/admin/AdminPortraitsTab.tsx))
| Action | What it does | Tables / storage | Type | Confirm? | Reversible in UI? |
|---|---|---|---|---|---|
| Approve portrait | Moves file from `pending` to `approved` storage path, sets `people.portrait_url/portrait_pending/portrait_approved_at`, marks submission approved | `portrait_submissions` (update), `people` (update), Storage `portraits` (download/upload/remove) — [L403-465](../src/components/admin/AdminPortraitsTab.tsx#L403-L465) | update + file move | none | No |
| Reject portrait | Deletes the pending file, marks submission rejected with optional reason | `portrait_submissions` (update), Storage remove — [L467-501](../src/components/admin/AdminPortraitsTab.tsx#L467-L501) | update + file delete | reason modal (optional text) | No |
| Edit portrait (crop/adjust/replace/reassign) | Re-uploads image, can reassign to a different person, updates `people` rows | `people` (update, possibly two rows), Storage, `audit_log` (insert) — [L549-656](../src/components/admin/AdminPortraitsTab.tsx#L549-L656) | update | none | No (old file removed) |
| Delete portrait | Removes approved file, nulls `people.portrait_url` | `people` (update), Storage remove, `audit_log` — [L695-741](../src/components/admin/AdminPortraitsTab.tsx#L695-L741) | update (clears field) + file delete | **type-DELETE** | No |

### Corrections tab ([AdminCorrectionsTab.tsx](../src/components/admin/AdminCorrectionsTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Approve & Set Link (FamilySearch corrections only) | Writes the submitted URL to `people.familysearch_url`, marks request completed | `people` (update), `correction_requests` (update) — [L19-47](../src/components/admin/AdminCorrectionsTab.tsx#L19-L47) | update | none | No |
| Mark Complete | Marks request completed. **Does not change any target data** — the admin is expected to make the actual fix elsewhere (Fix Names / Fix All Else) | `correction_requests` (update) — [L49-68](../src/components/admin/AdminCorrectionsTab.tsx#L49-L68) | update (status only) | none | Re-openable only via DB |
| Dismiss | Marks request dismissed | `correction_requests` (update) — [L70-89](../src/components/admin/AdminCorrectionsTab.tsx#L70-L89) | update (status only) | none | No |

Note: corrections actions write **no** `audit_log` entry.

### Memories tab ([AdminMemoriesTab.tsx](../src/components/admin/AdminMemoriesTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Approve | Sets `memories.status='approved'`; inserts a `follow_activity` row for watchers | `memories` (update), `follow_activity` (insert) — [L70-114](../src/components/admin/AdminMemoriesTab.tsx#L70-L114) | update | none | Re-editable; status change only via re-approve/reject |
| Save & Approve | Saves edits then approves | `memories` (update ×2), `audit_log` — [L192-241](../src/components/admin/AdminMemoriesTab.tsx#L192-L241), [L414-426](../src/components/admin/AdminMemoriesTab.tsx#L414-L426) | update | none | Partially |
| Edit | Edits content, relationship, time period, submitter name/email | `memories` (update), `audit_log` — [L192-241](../src/components/admin/AdminMemoriesTab.tsx#L192-L241) | update | none | No prior-value view |
| Reject | Sets `status='rejected'` | `memories` (update) — [L116-135](../src/components/admin/AdminMemoriesTab.tsx#L116-L135) | update | none | Only by re-approve |
| Delete (approved view only) | Permanently deletes the row | `memories` (delete), `audit_log` — [L152-190](../src/components/admin/AdminMemoriesTab.tsx#L152-L190) | **hard delete** | 1-click arm → **type-DELETE** modal | No |

### Photos tab ([AdminPhotosTab.tsx](../src/components/admin/AdminPhotosTab.tsx))
| Action | What it does | Tables / storage | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Approve | Sets `photos.status='approved'`; inserts `follow_activity` for tagged people | `photos` (update), `photo_people` (read), `follow_activity` (insert) — [L567-616](../src/components/admin/AdminPhotosTab.tsx#L567-L616) | update | none | Only by reject |
| Edit | Caption, date, event, tagged people, additional names, focal point; optional crop/adjust re-upload | `photos` (update), `photo_people` (delete+insert), Storage, `audit_log` — [L408-540](../src/components/admin/AdminPhotosTab.tsx#L408-L540) | update | none | No |
| Reject | Deletes the file, sets `status='rejected'` | `photos` (update), Storage remove — [L618-644](../src/components/admin/AdminPhotosTab.tsx#L618-L644) | update + file delete | none | No (file gone) |
| Delete (approved view) | Permanently deletes row, tags, and file | `photos` (delete), `photo_people` (delete), Storage remove, `audit_log` — [L661-719](../src/components/admin/AdminPhotosTab.tsx#L661-L719) | **hard delete** | 1-click arm → **type-DELETE** modal | No |

### Suggestions tab ([AdminSuggestionsTab.tsx](../src/components/admin/AdminSuggestionsTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Save (status + admin notes) | Updates a suggestion's status and notes | `suggestions` (update) via [useSuggestions.ts:49](../src/hooks/useSuggestions.ts#L49) | update | none | Yes (re-edit) |
| Delete | Deletes the suggestion | `suggestions` (delete) via [useSuggestions.ts:58](../src/hooks/useSuggestions.ts#L58) | **hard delete** | 1-click arm ("Click again to confirm") — [L197-205](../src/components/admin/AdminSuggestionsTab.tsx#L197-L205) | No |

### Fix Names tab ([AdminPeopleTab.tsx](../src/components/admin/AdminPeopleTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Edit person (Save) | Updates `full_name`, `display_name`, `suffix`, `birth_date`, `death_date`, `bio`, `familysearch_url`. Only two of these (Original/Corrected name) are shown as fields; the rest are in state but have no inputs in this tab — see §8 | `people` (update) — [L58-86](../src/components/admin/AdminPeopleTab.tsx#L58-L86) | update | none | No; also **hard page reload** on save ([L80](../src/components/admin/AdminPeopleTab.tsx#L80)) |

No `audit_log` entry is written for person name edits.

### Fix All Else tab ([AdminCallingsTab.tsx](../src/components/admin/AdminCallingsTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Edit calling | Updates `sustained_date`, `released_date`, `position_id`, `notes` (NOT presidency number) | `callings` (update), `audit_log` only if position changed — [L85-136](../src/components/admin/AdminCallingsTab.tsx#L85-L136) | update | none | No; **hard reload** on save |
| Fix # (presidency number) | Changes `presidency_number` | `callings` (update), `audit_log` — [L199-249](../src/components/admin/AdminCallingsTab.tsx#L199-L249) | update | **double-entry** modal (type number twice) | No; **hard reload** |
| Delete calling | Permanently deletes the calling record | `callings` (delete), `audit_log` — [L153-197](../src/components/admin/AdminCallingsTab.tsx#L153-L197) | **hard delete** | 1-click arm → **type-DELETE** modal ("PERMANENT DELETION") | No; **hard reload** |

### Manage Callings tab ([AdminTransitionsTab.tsx](../src/components/admin/AdminTransitionsTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Release | Sets `released_date`/`released_precision` on a current calling; optionally inserts a replacement calling | `callings` (update, +insert), `audit_log` — [L231-328](../src/components/admin/AdminTransitionsTab.tsx#L231-L328) | update (+create) | modal w/ date | No; **hard reload** |
| Add Counselor | Inserts a new counselor/president calling into the current (or next) presidency | `callings` (insert), `positions` (read), `audit_log` — [L330-437](../src/components/admin/AdminTransitionsTab.tsx#L330-L437) | create | modal | Delete via "Fix All Else"; **hard reload** |
| Add New (non-presidency orgs) | Inserts a calling with auto-assigned sequential number and optional label | `callings` (insert), `audit_log` — [L439-510](../src/components/admin/AdminTransitionsTab.tsx#L439-L510) | create | modal | Delete via "Fix All Else"; **hard reload** |
| Change Entire Presidency/Bishopric (batch) | Releases selected members and inserts a full new presidency | `callings` (bulk update + bulk insert) — [L595-701](../src/components/admin/AdminTransitionsTab.tsx#L595-L701) | update + create | modal, then `alert()` on success | No; **hard reload** |
| **Add New Person** (nested `PersonSelector` → "+ Add new person") | Inserts a `people` row with only `full_name` and `redacted:false` | `people` (insert) — [L530-567](../src/components/admin/AdminTransitionsTab.tsx#L530-L567) | create | modal (name only) | No (no delete-person UI anywhere) |

### Users tab ([AdminUsersTab.tsx](../src/components/admin/AdminUsersTab.tsx))
| Action | What it does | Tables | Type | Confirm? | Reversible? |
|---|---|---|---|---|---|
| Make Admin | Sets `user_profiles.role='admin'` | `user_profiles` (update) — [L16-48](../src/components/admin/AdminUsersTab.tsx#L16-L48) | update | none | Yes (Remove Admin) |
| Remove Admin | Sets role back to `viewer` | `user_profiles` (update) — [L22-48](../src/components/admin/AdminUsersTab.tsx#L22-L48) | update | **3× `window.confirm`** dialogs; cannot remove your own | Yes (Make Admin) |
| Edit display name | Updates `user_profiles.display_name` | `user_profiles` (update), `audit_log` — [L60-94](../src/components/admin/AdminUsersTab.tsx#L60-L94) | update | none | Yes |
| Restrict View | Sets `view_blocked=true` + reason; user can still submit but can't view members' memories/photos | `user_profiles` (update), `audit_log` — [L96-139](../src/components/admin/AdminUsersTab.tsx#L96-L139) | update | modal (optional reason) | Yes (Restore View) |
| Restore View | Clears `view_blocked` | `user_profiles` (update), `audit_log` — [L141-184](../src/components/admin/AdminUsersTab.tsx#L141-L184) | update | modal | Yes |

**Email is read-only** in this tab ([L200-205](../src/components/admin/AdminUsersTab.tsx#L200-L205)).

---

## 3. Task paths (from admin home to completion)

Admin home = the `/admin` dashboard, which always opens on the **Portraits** tab.

### Approve a pending contribution
"Contribution" is not one thing — there are four separate queues, each with its own approve button. There is no unified "pending" inbox; the tab badges (counts) are the only signal that something is waiting ([AdminDashboard.tsx:77-99](../src/components/admin/AdminDashboard.tsx#L77-L99)).

- **Portrait:** Portraits tab (default) → "Pending" sub-tab → row → **Approve** ([AdminPortraitsTab.tsx:924-930](../src/components/admin/AdminPortraitsTab.tsx#L924-L930)). No fields required.
- **Memory:** click **Memories** tab → "Pending" sub-tab → card → **Approve** (or **Edit** → **Save & Approve**) ([AdminMemoriesTab.tsx:464-469](../src/components/admin/AdminMemoriesTab.tsx#L464-L469)).
- **Photo:** click **Photos** tab → "Pending" sub-tab → card → **Approve** ([AdminPhotosTab.tsx:923-929](../src/components/admin/AdminPhotosTab.tsx#L923-L929)).
- **Correction:** click **Corrections** tab → row → **Mark Complete** or **Approve & Set Link** ([AdminCorrectionsTab.tsx:202-218](../src/components/admin/AdminCorrectionsTab.tsx#L202-L218)). Note: only the FamilySearch variant actually writes data; a plain "Mark Complete" changes status but makes no correction.

### Reject a pending contribution
- **Portrait:** Portraits → Pending → **Reject** → optional reason in modal → **Reject** ([AdminPortraitsTab.tsx:931-942](../src/components/admin/AdminPortraitsTab.tsx#L931-L942), modal [L1419-1457](../src/components/admin/AdminPortraitsTab.tsx#L1419-L1457)).
- **Memory:** Memories → Pending → **Reject** (no reason field) ([AdminMemoriesTab.tsx:478-483](../src/components/admin/AdminMemoriesTab.tsx#L478-L483)).
- **Photo:** Photos → Pending → **Reject** (no reason field) ([AdminPhotosTab.tsx:930-936](../src/components/admin/AdminPhotosTab.tsx#L930-L936)).
- **Correction:** Corrections → **Dismiss** ([AdminCorrectionsTab.tsx:219-225](../src/components/admin/AdminCorrectionsTab.tsx#L219-L225)).

### Add a new individual
**Not possible as a standalone task.** There is no "Add Person" screen and no "People" management tab. The header **Add** button opens a modal that only *searches existing* people and, on empty results, says "The person database is curated by admins — contact us if someone is missing" ([PersonSearchModal.tsx:112-119](../src/components/people/PersonSearchModal.tsx#L112-L119)). It never creates a record.

The **only** UI path that inserts a `people` row:
1. Admin home → **Tools** dropdown → **Manage Callings** ([AdminDashboard.tsx:149-161](../src/components/admin/AdminDashboard.tsx#L149-L161)).
2. Pick an organization from the dropdown.
3. Click **+ Add New** / **+ Add Counselor** / **Release** (with "Add replacement") / **Change Entire…** — any flow containing a `PersonSelector`.
4. In the person search box, type the name; when "No results found" appears, click **+ Add new person** ([AdminTransitionsTab.tsx:1569-1581](../src/components/admin/AdminTransitionsTab.tsx#L1569-L1581)).
5. A modal titled "Add New Person" asks for **Full Name** only → **Create** ([AdminTransitionsTab.tsx:1459-1495](../src/components/admin/AdminTransitionsTab.tsx#L1459-L1495)). The insert sets only `full_name` and `redacted:false` ([L537-544](../src/components/admin/AdminTransitionsTab.tsx#L537-L544)).

So a person can only be born as a side effect of giving them a calling, and only `full_name` is captured at creation. Birth/death/bio/display name must be added afterward in "Fix Names" (which only exposes name fields — see §8).

### Add a calling to an individual
Done from the org's side, not the person's. Admin home → **Tools → Manage Callings** → select organization → **+ Add New** (or **+ Add Counselor** for presidency orgs) → in the modal: **Position** (dropdown; auto-selected if the org has only one position type), **Person** (search or add-new), **Sustained Date** (date picker), optional **Presidency Label** for non-president callings → **Save** ([AdminTransitionsTab.tsx:1218-1336](../src/components/admin/AdminTransitionsTab.tsx#L1218-L1336)). The presidency/sequential number is auto-assigned as max+1 ([L451](../src/components/admin/AdminTransitionsTab.tsx#L451), [L1284-1288](../src/components/admin/AdminTransitionsTab.tsx#L1284-L1288)). There is **no way to add a calling by starting from a person's page.**

### Correct a calling's dates
Admin home → **Tools → Fix All Else** → select organization from dropdown → find the person's row → **Edit** → change **Sustained** / **Released** date pickers → **Save** ([AdminCallingsTab.tsx:324-338](../src/components/admin/AdminCallingsTab.tsx#L324-L338), save [L85-136](../src/components/admin/AdminCallingsTab.tsx#L85-L136)). You must already know which *organization* the calling belongs to; you cannot search by person. On save the whole page reloads.

Fixing the presidency number is a separate, gated flow: **Fix #** button → double-entry modal ([AdminCallingsTab.tsx:650-716](../src/components/admin/AdminCallingsTab.tsx#L650-L716)).

### Add or edit a building
**Not possible through any UI.** Buildings are a hardcoded TypeScript array in [archivesData.ts:133-214](../src/data/archivesData.ts#L133-L214). Adding or editing a building (name, address, dedication date, description, hero image URL) requires **editing source code and redeploying**. The public Buildings page (`/archives`) reads this file; there is no admin equivalent.

### Add a timeline entry to a building
**Not possible through any UI.** Timeline events are the `timeline` array on each building object in [archivesData.ts:156-204](../src/data/archivesData.ts#L156-L204) (see the "Middle" building). Each event's `year`, `date`, `label`, `detail`, `authority`, `authorityImage`, `authorityRole`, and attached `documents` are all authored by hand in the code file. Done via **source edit + redeploy** (this is literally what recent git commits like "Add East title photo…" and "Move the 1952 dedication PDF into the timeline…" did).

### Upload or attach media
Two different realities:
- **As an admin, you cannot originate an upload.** The admin Photos/Portraits tabs only *review* what the public submitted. Uploads come from public contribution flows: [ContributionModal.tsx](../src/components/people/ContributionModal.tsx) (person portraits/photos), [BuildingPhotoAlbum.tsx:353](../src/components/archives/BuildingPhotoAlbum.tsx#L353) (building photos, inserted with a `building_id`), and [BuildingMemories.tsx:157](../src/components/archives/BuildingMemories.tsx#L157). These are reachable by any user via the header **Add** button and the Buildings pages — **not** from `/admin`.
- **What the admin can do:** approve/reject/delete those submissions, and while editing, crop/adjust/replace the image, set a focal point (photos), reassign a portrait to a different person. All within the Photos and Portraits tabs (§2).
- Building/dedication audio and the building hero images are URLs hardcoded in [archivesData.ts](../src/data/archivesData.ts) and are uploaded to Supabase Storage out of band (see `scripts/bulk-upload-building-photos.ts`), not through the admin UI.

### Edit site content or a written narrative
**Not possible through any UI.** All narrative text — the building descriptions and timeline `detail` paragraphs ([archivesData.ts](../src/data/archivesData.ts)), the About page, the Home page copy — is hardcoded in React components / the data file. There is no CMS, no rich-text editor, and no "content" table. Changing a narrative = **source edit + redeploy**. (The only free-text an admin can edit through the UI is per-record: a memory's content, a photo caption, a person's bio field — and the bio field isn't even exposed in "Fix Names," see §8.)

---

## 4. Required outside knowledge (the most important section)

Every point below is a place where finishing a task requires information the screen does not give you. A volunteer with no handoff notes would be stuck or would guess.

### Structural / "you must know the model" knowledge
1. **A person must exist before almost anything.** Portraits, photos, memories, and callings all attach to a `people` row. But the only way to create one is buried inside "Manage Callings" (§3). Nothing on any screen tells you this ordering constraint.
2. **Callings are organized by organization, not by person.** To edit or add a calling you must first know *which organization* it belongs to and select it from a dropdown ([AdminCallingsTab.tsx:262-278](../src/components/admin/AdminCallingsTab.tsx#L262-L278), [AdminTransitionsTab.tsx:720-747](../src/components/admin/AdminTransitionsTab.tsx#L720-L747)). There is no person-first path and no search-by-person. If you don't already know Brother X was a "Bountiful 7th Ward" bishop, you can't find his calling.
3. **The three "fix/manage" tabs do different things, and the names don't say what.** "Fix Names" = edit people; "Fix All Else" = edit existing callings; "Manage Callings" = add/release callings (and secretly create people). A newcomer cannot infer which tab to use for a given task from the labels ([AdminDashboard.tsx:31-36](../src/components/admin/AdminDashboard.tsx#L31-L36)).
4. **"Mark Complete" on a correction does not perform the correction.** The admin must read the request, then go make the actual change in Fix Names / Fix All Else / Manage Callings, then come back and mark it complete ([AdminCorrectionsTab.tsx:49-68](../src/components/admin/AdminCorrectionsTab.tsx#L49-L68)). Nothing on screen explains that the button is bookkeeping only.
5. **Buildings, timeline, and all narrative text are code, not data.** A volunteer would reasonably look for an "edit building" button; there isn't one, and nothing tells them the content lives in a source file that requires a developer (§3).

### Field-meaning knowledge (labels that assume prior context)
6. **"Focal point."** The Photos edit modal lets you click to set a focal point ([AdminPhotosTab.tsx:1206-1280](../src/components/admin/AdminPhotosTab.tsx#L1206-L1280)). The panel is labeled "Preview Focus Point" and explains "click on faces," but the concept (it sets CSS `object-position` for cropped grid thumbnails, default 50% / 33%) is not explained. The default `33` for Y is a magic number ([AdminPhotosTab.tsx:60](../src/components/admin/AdminPhotosTab.tsx#L60)).
7. **"Presidency #" / "Sequential #".** These integers group and order callings into presidencies/bishoprics. The "Fix All Else" and "Manage Callings" tabs surface them, and the app's ordering depends on them ([AdminTransitionsTab.tsx:85-118](../src/components/admin/AdminTransitionsTab.tsx#L85-L118)), but nothing explains what a correct value is or how the numbering scheme works. The Fix-# modal only warns "changing… affects historical ordering" ([AdminCallingsTab.tsx:656-659](../src/components/admin/AdminCallingsTab.tsx#L656-L659)).
8. **"Presidency Label" / notes like "Hill Presidency."** The placeholder is `e.g., Hill Presidency` ([AdminTransitionsTab.tsx:1299](../src/components/admin/AdminTransitionsTab.tsx#L1299)); the convention (last name of the presiding officer + "Presidency") is only conveyed by the placeholder and an auto-fill derived from the current stake president's surname ([L207-213](../src/components/admin/AdminTransitionsTab.tsx#L207-L213)). A volunteer must infer the naming convention.
9. **"Original Name" vs "Corrected Name."** In "Fix Names," the columns are "Original Name" (= `full_name`) and "Corrected Name" (= `display_name`) ([AdminPeopleTab.tsx:113-114](../src/components/admin/AdminPeopleTab.tsx#L113-L114)). Which one drives what appears on the site (display_name preferred, falls back to full_name — e.g. [AdminCallingsTab.tsx:308](../src/components/admin/AdminCallingsTab.tsx#L308)) is not stated.
10. **Date precision.** The schema stores `sustained_precision` / `released_precision` ('exact'|'month'|'year') and the public display honors it ([utils formatDate]; CURSOR_INSTRUCTIONS §4). But the admin date pickers only accept exact dates and silently write `precision:'exact'` ([AdminTransitionsTab.tsx:259-260](../src/components/admin/AdminTransitionsTab.tsx#L259-L260)). A volunteer entering an approximate historical date has no way to mark it approximate and won't know the concept exists.
11. **"Restrict View" semantics.** The button blocks a user from *viewing* members-only content but still lets them submit ([AdminUsersTab.tsx:505-508](../src/components/admin/AdminUsersTab.tsx#L505-L508)). The distinction (view vs. submit vs. admin) requires reading the modal text; the button alone doesn't convey it.
12. **Roles.** `admin` / `contributor` / `viewer` exist ([useUsers.ts:8](../src/hooks/useUsers.ts#L8)), but the UI only toggles admin↔viewer; "contributor" is displayed if present but never assignable ([AdminUsersTab.tsx:340](../src/components/admin/AdminUsersTab.tsx#L340)). What each role can do is documented nowhere in the UI.

### Value/identifier knowledge
13. **Building IDs.** When a photo or memory is attached to a building, it carries a `building_id` string like `1250-s-main`, `102-e-1400-s`, `1500-s-600-e` ([archivesData.ts:135,150,207](../src/data/archivesData.ts#L135)). The admin Photos tab resolves the id to a name only if the id matches the hardcoded list ([AdminPhotosTab.tsx:866-869](../src/components/admin/AdminPhotosTab.tsx#L866-L869)); an unknown id shows the raw slug. The building "names" ("Stake Center," "Middle," "East") also don't match their addresses obviously.
14. **Which org a historical calling belongs to.** As in #2 — you must know the exact organization name to select it. Discontinued orgs (e.g. "Bountiful 57th Ward") and renamed orgs add ambiguity.
15. **Relationship codes.** Memory records store a `relationship` enum (`served_together`, `helped_build`, etc.). The admin edit form maps them to labels ([AdminMemoriesTab.tsx:9-31](../src/components/admin/AdminMemoriesTab.tsx#L9-L31)), but a raw/unknown code would display verbatim.
16. **Granting a successor admin access requires knowing they must first sign up.** New accounts default to `viewer` ([migration_setup_user_profile_trigger.sql:29-35](../supabase/migration_setup_user_profile_trigger.sql#L29-L35)); they only appear in the Users tab after they have logged in at least once (the tab reads `admin_users_view`). An outgoing admin must know to have the successor create an account *before* they can be promoted (see §6).

---

## 5. Text inventory (verbatim guidance text in the admin UI)

This lists non-obvious labels, help text, placeholders, empty states, validation, errors, and confirmations, per tab. Plain column headers and obvious labels (e.g. "Email," "Date") are omitted unless notable.

### AdminDashboard
- Heading: "Admin Dashboard"; "{n} registered users" ([L68-71](../src/components/admin/AdminDashboard.tsx#L68-L71))
- Tab labels: "Portraits", "Corrections", "Memories", "Photos", "Suggestions", "Tools" → "Fix Names", "Fix All Else", "Manage Callings", "Users" ([L23-36](../src/components/admin/AdminDashboard.tsx#L23-L36))
- **No help text or descriptions on any tab.**

### Portraits
- Sub-tabs "Pending (n)" / "Approved (n)"; empty: "No pending portraits" / "No approved portraits" / "No portraits match your search" ([L779,959,1003](../src/components/admin/AdminPortraitsTab.tsx#L779))
- Placeholders: "Search by name...", "Search to reassign..." ([L974,1243](../src/components/admin/AdminPortraitsTab.tsx#L974)); sort options "Approved Date (Newest)" etc. ([L988-991](../src/components/admin/AdminPortraitsTab.tsx#L988-L991))
- Accordion labels: "Crop", "Adjust", "Upload Replacement", "Assign to Person" ([L1040,1143,1197,1227](../src/components/admin/AdminPortraitsTab.tsx#L1040))
- Help text: "Reposition or resize the portrait crop area." ([L1123](../src/components/admin/AdminPortraitsTab.tsx#L1123)); "Show head position guide" ([L1113](../src/components/admin/AdminPortraitsTab.tsx#L1113)); "⚠️ Cropping replaces the original image." ([L1119](../src/components/admin/AdminPortraitsTab.tsx#L1119)); "Upload a completely new portrait image." ([L1204](../src/components/admin/AdminPortraitsTab.tsx#L1204)); "Currently assigned to: …" ([L1234](../src/components/admin/AdminPortraitsTab.tsx#L1234))
- Reject modal: "Rejection Reason (optional)", placeholder "e.g., Image quality too low, incorrect person..." ([L1426-1434](../src/components/admin/AdminPortraitsTab.tsx#L1426-L1434))
- Delete modal: "⚠️ Delete Portrait", "This action CANNOT be undone.", "The portrait for {name} will be permanently deleted. The image file will be removed from storage.", "Type DELETE to confirm:", button "Delete Forever" ([L1469-1508](../src/components/admin/AdminPortraitsTab.tsx#L1469-L1508))
- File-type validation alert: "Please select a valid image file (JPEG, PNG, WebP, or HEIC)" ([L527](../src/components/admin/AdminPortraitsTab.tsx#L527)); "Failed to process image. Please try again." ([L545](../src/components/admin/AdminPortraitsTab.tsx#L545))

### Corrections
- Empty: "No pending corrections" ([L122](../src/components/admin/AdminCorrectionsTab.tsx#L122))
- Type badges: "FamilySearch" / "Name" / "Date" / "Other" ([L91-100,167](../src/components/admin/AdminCorrectionsTab.tsx#L91-L100))
- Buttons: "Approve & Set Link", "Mark Complete", "Dismiss" ([L208,214,224](../src/components/admin/AdminCorrectionsTab.tsx#L208))
- "Read more" / "Show less" ([L184](../src/components/admin/AdminCorrectionsTab.tsx#L184)); fallback "Person ID: {id}" when the person can't be joined ([L162](../src/components/admin/AdminCorrectionsTab.tsx#L162))
- Error toasts via `alert()` ("Failed to approve FamilySearch link", etc.)
- **No explanation that "Mark Complete" makes no data change.**

### Memories
- Sub-tabs "Pending (n)" / "Approved (n)"; empty "No {pending|approved} memories" ([L296](../src/components/admin/AdminMemoriesTab.tsx#L296))
- Field labels: "Memory/Story *", "Relationship (optional)", "Time Period (optional)", "Submitter Name", "Submitter Email" ([L349-411](../src/components/admin/AdminMemoriesTab.tsx#L349-L411))
- Placeholder: "e.g., When he was bishop 1985-1990" ([L384](../src/components/admin/AdminMemoriesTab.tsx#L384)); "Select relationship..." ([L370](../src/components/admin/AdminMemoriesTab.tsx#L370))
- Meta labels: "Relationship:", "Time Period:", "Submitted by:", building suffix "(Building)" ([L314,330,335,339](../src/components/admin/AdminMemoriesTab.tsx#L314))
- Buttons: "Approve", "Edit", "Reject", "Save & Approve", "Save Changes", "Are you sure?" ([L425,433,469,477,483,504](../src/components/admin/AdminMemoriesTab.tsx#L425))
- Delete modal: "⚠️ Delete Memory", "This action CANNOT be undone.", "The memory and all associated data will be permanently deleted.", "Type DELETE to confirm:", "Delete Forever" ([L525-564](../src/components/admin/AdminMemoriesTab.tsx#L525-L564))

### Photos
- Sub-tabs "Pending (n)"/"Approved (n)"; empty "No {pending|approved} photos" ([L756](../src/components/admin/AdminPhotosTab.tsx#L756))
- Accordions: "Crop Image", "Adjust Image", "Preview Focus Point" ([L1009,1128,1214](../src/components/admin/AdminPhotosTab.tsx#L1009))
- Help text: "Crop the image to remove unwanted areas." ([L1105](../src/components/admin/AdminPhotosTab.tsx#L1105)); "Warning: Crop cannot be undone after saving." ([L1101](../src/components/admin/AdminPhotosTab.tsx#L1101)); "Click on the image to set where the preview should focus (e.g., click on faces)." ([L1219-1221](../src/components/admin/AdminPhotosTab.tsx#L1219-L1221)); "Position: {x}% from left, {y}% from top", "Reset to default", "Preview (how it appears in the grid):" ([L1254-1267](../src/components/admin/AdminPhotosTab.tsx#L1254-L1267))
- Field labels/placeholders: "Caption *", "Approximate Date (optional)" ph "e.g., 1985 or Spring 1990", "Event/Context (optional)" ph "e.g., Ward Christmas Party", "Tagged People (optional)" with "Search for people in the database or add names manually." and "Search for a person or type a name...", '+ Add "{name}"' ([L1282-1408](../src/components/admin/AdminPhotosTab.tsx#L1282-L1408))
- Image-failure inline text: "Image not available", "Check storage bucket permissions" ([L836-838](../src/components/admin/AdminPhotosTab.tsx#L836-L838))
- Delete modal: "⚠️ Delete Photo", "This action CANNOT be undone.", "The photo and all associated data (tags, captions) will be permanently deleted. The image file will be lost.", "Type DELETE to confirm:", "Delete Forever" ([L1476-1515](../src/components/admin/AdminPhotosTab.tsx#L1476-L1515))
- **Note:** this tab logs raw photo data to the browser console on every render ([L764-770](../src/components/admin/AdminPhotosTab.tsx#L764-L770)) — leftover debug output, not user-facing text.

### Suggestions
- Filter options "All Statuses/New/In Review/Resolved/Dismissed"; "Refresh"; empty "No suggestions found." ([L53-69](../src/components/admin/AdminSuggestionsTab.tsx#L53-L69))
- Status labels: New/In Review/Resolved/Dismissed ([L5-10](../src/components/admin/AdminSuggestionsTab.tsx#L5-L10)); "anonymous" for missing email ([L95](../src/components/admin/AdminSuggestionsTab.tsx#L95))
- Detail modal: "Suggestion Details", "From:/Page:/Date:", "Admin Notes" ph "Add notes about this suggestion...", delete tooltip "Click again to confirm delete" / "Delete suggestion", "Click again to confirm" ([L215-293](../src/components/admin/AdminSuggestionsTab.tsx#L215-L293))

### Fix Names
- Placeholder "Search by name..."; columns "Original Name" / "Corrected Name"; edit placeholders "Full name" / "Display name" ([L101,113-114,131,139](../src/components/admin/AdminPeopleTab.tsx#L101))
- **No help text explaining the two name fields or that only names are editable here.**

### Fix All Else
- "Select Organization", "-- Select an organization --"; empty "No callings found for this organization" ([L259-278,590](../src/components/admin/AdminCallingsTab.tsx#L259-L278))
- Columns incl. "Presidency #"; released shows "Current" when null ([L399](../src/components/admin/AdminCallingsTab.tsx#L399)); notes placeholder "e.g., Hill Presidency" ([L362](../src/components/admin/AdminCallingsTab.tsx#L362)); "Fix #" button ([L353](../src/components/admin/AdminCallingsTab.tsx#L353))
- Delete modal: "PERMANENT DELETION", "This will permanently delete {name}'s {position} calling record from {org}. This cannot be undone.", "Type DELETE to confirm:" ([L602-621](../src/components/admin/AdminCallingsTab.tsx#L602-L621))
- Fix-# modal: "Fix Presidency Number", "Changing presidency numbers affects historical ordering. Only change if the number was entered incorrectly.", "Current Value:", "New Presidency Number:", "Confirm New Number:" ph "Type number again to confirm" ([L656-687](../src/components/admin/AdminCallingsTab.tsx#L656-L687))
- Validation alerts: "Presidency numbers do not match. Please type the same number twice." / "Please enter a valid number" ([L204,210](../src/components/admin/AdminCallingsTab.tsx#L204))

### Manage Callings
- "Organization", "-- Select an organization --"; heading "Current {Bishopric|Presidency} (#n)"; empty "No current callings found for this organization." ([L717-747,754-756,889](../src/components/admin/AdminTransitionsTab.tsx#L717-L747))
- Buttons: "+ Add Counselor", "Change Entire {Presidency}", "+ Add New", "Release" ([L867,884,992,802](../src/components/admin/AdminTransitionsTab.tsx#L867))
- Release modal: "Release {name}", "Release {name} as {position} from {org}?", "Release Date", "Add replacement now", "Same position as released calling", "Sustained Date", button "Release & Add Replacement" / "Confirm Release" ([L1008-1120](../src/components/admin/AdminTransitionsTab.tsx#L1008-L1120))
- Add Counselor modal warning: "This will start a new {Presidency} #{n}"; "Will be assigned to {Presidency} #{n}" ([L1150,1188](../src/components/admin/AdminTransitionsTab.tsx#L1150))
- Add New modal: "Presidency #" → "Will start new presidency #{n}"; "Sequential #" → "Will be assigned #{n} (auto-assigned)"; "Presidency Label (optional)" ph "e.g., Hill Presidency"; "Auto-filled from current Stake President" ([L1276-1303](../src/components/admin/AdminTransitionsTab.tsx#L1276-L1303))
- Add New Person modal: "Add New Person", "Full Name *" ph "Enter full name", "Create" ([L1462-1490](../src/components/admin/AdminTransitionsTab.tsx#L1462-L1490))
- PersonSelector: ph "Search for person...", "No results found", "+ Add new person" ([L1552,1571,1579](../src/components/admin/AdminTransitionsTab.tsx#L1552))
- Success: `alert('Leadership transition saved successfully!')` ([L682](../src/components/admin/AdminTransitionsTab.tsx#L682)); many validation `alert()`s ("Please enter a release date", etc.)

### Users
- Column note: "Email (read-only)" with tooltip "Email can only be changed by the user" ([L200-205](../src/components/admin/AdminUsersTab.tsx#L200-L205))
- View status: "🚫 Restricted" / "✅ Allowed"; role badges admin/contributor/viewer; "Not set" for missing display name ([L247-249,279](../src/components/admin/AdminUsersTab.tsx#L247-L249))
- Buttons: "Make Admin" / "Remove Admin", "Restrict View" / "Restore View", tooltip "You cannot remove your own admin access" ([L338-340](../src/components/admin/AdminUsersTab.tsx#L338-L340))
- Remove-admin `window.confirm` chain: "Are you sure you want to remove admin access?" → "This will remove admin privileges. Continue?" → "Final confirmation: Remove admin access?" ([L23-31](../src/components/admin/AdminUsersTab.tsx#L23-L31)); self-removal alert "You cannot remove your own admin access." ([L19](../src/components/admin/AdminUsersTab.tsx#L19))
- Restrict modal: "Restrict View Access", "This will prevent {name} from viewing memories and photos. They will still be able to submit content, but will see 'Sign in to view' even when logged in.", "Reason (optional)" ph "Admin notes..." ([L504-517](../src/components/admin/AdminUsersTab.tsx#L504-L517))
- Restore modal: "Restore View Access", "This will allow {name} to view memories and photos again." ([L550-552](../src/components/admin/AdminUsersTab.tsx#L550-L552))

**Screens with essentially no guidance text:** Fix Names (only field placeholders), the Corrections tab (no explanation of what completing/dismissing does), and the dashboard itself (no onboarding, no descriptions of the tabs). Almost all errors are raw browser `alert()` dialogs surfacing Supabase messages verbatim (e.g. [AdminCallingsTab.tsx:132](../src/components/admin/AdminCallingsTab.tsx#L132)), which will show a volunteer database jargon like "new row violates row-level security."

---

## 6. Permissions and access

- **Where the role lives:** `user_profiles.role`, an enum `user_role` = `admin | contributor | viewer` ([schema.sql:14,84-91](../supabase/schema.sql#L14-L91); type in [useUsers.ts:8](../src/hooks/useUsers.ts#L8)).
- **How admin is checked in the app:** [useAdmin.ts:18-26](../src/hooks/useAdmin.ts#L18-L26) reads `user_profiles.role` for the current user and treats `role === 'admin'` as admin. This drives both the "Admin" nav link and the `/admin` route guard.
- **How the DB enforces it:** RLS "Admin full access" policies on `people`, `organizations`, `callings` require an `admin` row in `user_profiles` ([schema.sql:208-234](../supabase/schema.sql#L208-L234)). So a non-admin literally cannot perform the write actions even if they reached the components.
- **Default role for a new account:** `viewer`, assigned automatically by the `handle_new_user` trigger on signup, using either the submitted display name or the email's local part ([migration_setup_user_profile_trigger.sql:26-51](../supabase/migration_setup_user_profile_trigger.sql#L26-L51)).
- **How an existing admin grants access to a successor (via UI):**
  1. The successor must **first create an account** (Sign In → Sign Up) so a `user_profiles` row exists as `viewer`.
  2. Admin → Tools → **Users** tab → find the successor's row (the tab lists rows from `admin_users_view`) → **Make Admin** ([AdminUsersTab.tsx:330-341](../src/components/admin/AdminUsersTab.tsx#L330-L341)), which sets `role='admin'` ([L35-40](../src/components/admin/AdminUsersTab.tsx#L35-L40)).
  - **This is possible from the UI**, with one hard prerequisite the UI never states: the successor must have logged in at least once first, or they won't appear in the list. (**Inference**, from the default-viewer trigger plus the tab reading an existing-users view.)
- **Removing access** is also UI-possible (Remove Admin, gated by three confirms; you cannot demote yourself — [L16-31](../src/components/admin/AdminUsersTab.tsx#L16-L31)).
- **Bootstrapping the first admin** is *not* possible from the UI (someone has to be admin to promote others). It must be done by directly setting `user_profiles.role='admin'` in the database. (**Inference**, from the fact that every promote path requires an existing admin.)
- **`admin_users_view`** is the view the Users tab and the dashboard user-count read ([useUsers.ts:24-27](../src/hooks/useUsers.ts#L24-L27), [useAdminStats.ts:48-50](../src/hooks/useAdminStats.ts#L48-L50)). Its definition is **not in the repo** — no migration or schema file defines it (confirmed by search). It exists only in the live database, so its exact columns/filter are unknown from code (see §8).

---

## 7. Existing documentation

- **`scripts/stake-history-guide.pdf`** + its generator **[generate_guide_pdf.py](../scripts/generate_guide_pdf.py)** — "Getting Started with the Bountiful South Stake History Site: A Simple Guide for Contributors." Covers, for **public contributors** (not admins): reaching the site, creating an account, searching, following/watching a person, adding a memory, adding a photo/portrait, and troubleshooting. It explicitly tells users that submissions are reviewed by an administrator ([generate_guide_pdf.py:208,238-239](../scripts/generate_guide_pdf.py#L208-L239)) but says **nothing about how to *be* an administrator** — no coverage of any admin tab, approving, or the "Fix/Manage" tools.
- **[README.md](../README.md)** — project overview, tech stack, DB setup steps, data summary. One line on access: "Contact the Stake Executive Secretary for access" ([README.md:70](../README.md#L70)). No admin operating instructions.
- **[CURSOR_INSTRUCTIONS.md](../CURSOR_INSTRUCTIONS.md)** — a developer/AI build guide: schema, TypeScript interfaces, env vars, styling, deployment. Describes an intended admin surface that **does not match the current build** — it lists `DataExport.tsx` and `RedactionManager.tsx` components ([CURSOR_INSTRUCTIONS.md:58-61](../CURSOR_INSTRUCTIONS.md#L58-L61)) and a JSON "Admin Data Export" feature ([L402-430](../CURSOR_INSTRUCTIONS.md#L402-L430)) that are not implemented (see §8). Aimed at a developer, not a volunteer operator.
- **[QUICK_FIX_PORTRAIT_UPLOAD.md](../QUICK_FIX_PORTRAIT_UPLOAD.md)** and **[TROUBLESHOOTING_PORTRAIT_UPLOAD.md](../TROUBLESHOOTING_PORTRAIT_UPLOAD.md)** — developer-facing runbooks for Supabase migration/storage/RLS errors behind portrait uploads. Assume access to the Supabase dashboard and SQL editor; not usable by a non-technical volunteer.
- **Supabase migrations** (`supabase/*.sql`) — schema history, useful only to a developer.

**Summary of coverage:** there is a friendly guide for *contributors* and technical runbooks for *developers*. There is **no operator's manual for the admin/reviewer role** — nothing that explains the four review queues, the three confusingly-named tools tabs, presidency numbering, building-content-lives-in-code, or how to onboard a successor.

---

## 8. Dead ends and unknowns

**Orphaned / unfinished code:**
- **[PresidencyScheduleGrid.tsx](../src/components/admin/PresidencyScheduleGrid.tsx)** exists in the admin folder but is **imported and rendered nowhere** (confirmed by search — the only hits are its own definition). Dead component.
- **`DataExport.tsx` and `RedactionManager.tsx`** are referenced in [CURSOR_INSTRUCTIONS.md:58-61](../CURSOR_INSTRUCTIONS.md#L58-L61) but **do not exist** in `src/components/admin/`. The "Admin Data Export" JSON download described at [CURSOR_INSTRUCTIONS.md:402-430](../CURSOR_INSTRUCTIONS.md#L402-L430) is **not implemented** — there is no export button anywhere in the admin UI.
- **Redaction has no UI.** The `people` table supports `redacted/redacted_at/redacted_by/redaction_reason` and the app filters on it, but there is **no admin control to redact or un-redact a person.** Setting `redacted` requires direct DB access. (Adds up with the missing `RedactionManager`.)
- **"Contributor" role is a dead option.** The role is displayed if present but can never be assigned through the UI (only admin↔viewer toggling exists — [AdminUsersTab.tsx:35](../src/components/admin/AdminUsersTab.tsx#L35)). Whether any contributor rows exist, and what the role would grant, is undetermined from code.
- **Legacy Phase-2 tables unused by admin.** `media`, `media_people`, `media_callings`, `stories`, `story_people` in [schema.sql:97-148](../supabase/schema.sql#L97-L148) appear superseded by the `photos` / `memories` / `portrait_submissions` tables the admin actually uses. No admin code touches the `media`/`stories` tables. Likely abandoned early design.

**Behavioral rough edges (read directly, not inferred):**
- **Full page reloads** (`window.location.reload()`) after saving in Fix Names ([L80](../src/components/admin/AdminPeopleTab.tsx#L80)), Fix All Else ([L130,191,243](../src/components/admin/AdminCallingsTab.tsx#L130)), and every Manage Callings write ([AdminTransitionsTab.tsx:322,431,503,694](../src/components/admin/AdminTransitionsTab.tsx#L322)). This throws the admin back to the default Portraits tab and loses their place.
- **Inconsistent audit logging.** Some writes log to `audit_log` (portraits, photos, memories delete/edit, user changes, most calling operations) but others do **not** (all Corrections actions; person name edits in Fix Names; calling edits unless the *position* specifically changed — [AdminCallingsTab.tsx:116](../src/components/admin/AdminCallingsTab.tsx#L116)). And regardless, **`audit_log` has no viewer in the UI** — it is write-only from the operator's perspective.
- **Left-over debug console logging** in the Photos tab renders on every photo ([AdminPhotosTab.tsx:764-770](../src/components/admin/AdminPhotosTab.tsx#L764-L770)) and in useAdminStats ([L60-68](../src/hooks/useAdminStats.ts#L60-L68)).
- **Reject reasons are uneven:** portraits capture a rejection reason; memories and photos do not.

**Things I could not determine from the code (stated plainly):**
- The exact definition of **`admin_users_view`** (its columns, and whether it includes users who have never logged in) — it is not in the repo; it lives only in the live database. Everything about who appears in the Users tab, and the "registered users" count, depends on this unknown view.
- Whether **RLS policies for the newer tables** (`memories`, `photos`, `portrait_submissions`, `correction_requests`, `suggestions`, `follow_activity`, `photo_people`, `audit_log`) restrict writes to admins. The base `schema.sql` only defines admin policies for `people/organizations/callings`; policies for the review-queue tables would be in later migrations or set in the dashboard, which I did not fully trace. So I cannot confirm from code alone that a non-admin is blocked at the DB layer from, say, deleting a memory. (**Uncertainty**, not a claim of a hole.)
- Whether any **`contributor`-role** accounts actually exist in production, and what — if anything — differs for them.
- The real-world **presidency-numbering convention** (what constitutes a "correct" number) — the code auto-increments max+1, but historical backfill correctness is a data question the code can't answer.

---

## 9. The calling lifecycle in detail

Callings are the core of the site and the highest-frequency admin task. Two tabs touch them: **Manage Callings** ([AdminTransitionsTab.tsx](../src/components/admin/AdminTransitionsTab.tsx)) creates and releases; **Fix All Else** ([AdminCallingsTab.tsx](../src/components/admin/AdminCallingsTab.tsx)) edits and deletes.

### How a calling record is created
There are four insert paths, all in Manage Callings, all writing to the `callings` table:
- **+ Add New** (non-presidency orgs) — [handleAddNew, L439-510](../src/components/admin/AdminTransitionsTab.tsx#L439-L510)
- **+ Add Counselor** (presidency/bishopric orgs) — [handleAddCounselor, L330-437](../src/components/admin/AdminTransitionsTab.tsx#L330-L437)
- **Release → "Add replacement now"** — [handleRelease, L278-312](../src/components/admin/AdminTransitionsTab.tsx#L278-L312)
- **Change Entire Presidency (batch)** — [handleBatchSave, L654-673](../src/components/admin/AdminTransitionsTab.tsx#L654-L673)

**Fields written at creation** (e.g. the Add New insert object, [L454-469](../src/components/admin/AdminTransitionsTab.tsx#L454-L469)):
- `person_id` — required (must select or inline-create a person; validated, [L440](../src/components/admin/AdminTransitionsTab.tsx#L440))
- `organization_id` — required (the org selected in the dropdown; there is no per-insert choice)
- `position_id` — required (validated, [L440](../src/components/admin/AdminTransitionsTab.tsx#L440)); auto-selected when the org exposes only one position ([L161-162](../src/components/admin/AdminTransitionsTab.tsx#L161-L162))
- `sustained_date` — required (validated, [L440](../src/components/admin/AdminTransitionsTab.tsx#L440))
- `presidency_number` — **not entered by the admin**; auto-computed as `getMaxPresidencyNumber() + 1` ([L451](../src/components/admin/AdminTransitionsTab.tsx#L451), [L224-229](../src/components/admin/AdminTransitionsTab.tsx#L224-L229))
- `sustained_precision` — **always hardcoded to `'exact'`** ([L468](../src/components/admin/AdminTransitionsTab.tsx#L468)); the admin cannot set month/year precision
- `notes` — optional, only for non-president callings ([L472-474](../src/components/admin/AdminTransitionsTab.tsx#L472-L474))

The DB requires `person_id`, `position_id`, `organization_id`, `sustained_date` (NOT NULL); `presidency_number` is nullable ([schema.sql:65-78](../supabase/schema.sql#L65-L78)).

### How a calling is ended / released
There **is** an explicit "Release" action (a button on each current calling — [L797-805](../src/components/admin/AdminTransitionsTab.tsx#L797-L805)). It is **not** a delete and **not** an archive: it sets a terminal date on the existing row — `released_date` = the entered date and `released_precision='exact'` ([handleRelease, L255-263](../src/components/admin/AdminTransitionsTab.tsx#L255-L263)). The record stays in the table permanently.
- "Current vs. past" is derived purely from whether `released_date` is null: current callings are those with no release date ([L90-91](../src/components/admin/AdminTransitionsTab.tsx#L90-L91); displayed as "Current" in Fix All Else, [L399](../src/components/admin/AdminCallingsTab.tsx#L399)).
- A release date can also be set/changed manually as a plain field edit in **Fix All Else** ([L332-338](../src/components/admin/AdminCallingsTab.tsx#L332-L338)) — so there are two different ways to end a calling (the Release button, or editing the Released date field), and they are not the same UI.
- `released_precision` is always `'exact'` from both paths — the editor date picker in Fix All Else writes the date but the precision column is not exposed.

### Release + replacement as one operation
**Both single and linked forms exist:**
- **Linked:** the Release modal has an "Add replacement now" checkbox. When checked, `handleRelease` performs the release update **and** the replacement insert in the same handler, reusing the released calling's `organization_id`, `position_id`, and `presidency_number` ([L278-312](../src/components/admin/AdminTransitionsTab.tsx#L278-L312)). The button reads "Release & Add Replacement" ([L1119](../src/components/admin/AdminTransitionsTab.tsx#L1119)).
- **Batch linked:** "Change Entire Presidency" releases the selected members and inserts a whole new presidency (next number) in one save ([L595-701](../src/components/admin/AdminTransitionsTab.tsx#L595-L701)).
- **Independent:** you can also just Release (no replacement), then later Add New/Add Counselor as a separate action.

**Not transactional (inference):** the release update and the replacement insert are sequential `await`s, not a DB transaction ([L255-292](../src/components/admin/AdminTransitionsTab.tsx#L255-L292)). If the insert fails after the update succeeds, the person is released with no replacement and the admin sees only the insert's error. Likewise the batch path pushes errors to an array and continues ([L613-677](../src/components/admin/AdminTransitionsTab.tsx#L613-L677)), so a partial transition is possible.

### Two people, same position, overlapping dates
**Silently allowed.** No code checks for an existing unreleased calling in the same position/org before inserting, and there is no unique constraint or overlap constraint on `callings` in the schema ([schema.sql:65-78](../supabase/schema.sql#L65-L78) — only a primary key and foreign keys). Nothing warns the admin. The result is simply two "current" rows, both of which display as active. (Adding a president via "Add Counselor" does bump the presidency number ([L376-378](../src/components/admin/AdminTransitionsTab.tsx#L376-L378)), but adding a same-position duplicate within a presidency is unguarded.)

### End date before start date / blank dates
- **Blank sustained date:** blocked by a JS check with an `alert()` ("Please enter a sustained date") in every create path ([L331,440](../src/components/admin/AdminTransitionsTab.tsx#L331), Release requires a release date [L232-235](../src/components/admin/AdminTransitionsTab.tsx#L232-L235)). The DB also enforces `sustained_date NOT NULL`.
- **Blank released date:** allowed and meaningful (null = current).
- **Released date earlier than sustained date:** **no validation anywhere.** There is no comparison of the two dates in any handler. An admin can release someone "before" they were sustained and the record saves silently, producing negative/again-current-looking ranges downstream (**inference** on the downstream display effect; the absence of the check is direct).
- **Precision** is never surfaced, so an admin entering an approximate historical date is forced to enter a false exact date (§4 #10).

### Are positions controlled or free text?
**Controlled**, via the `positions` lookup table and a `position_id` foreign key ([schema.sql:53-62,68](../supabase/schema.sql#L53-L62)). The list is **seeded in code** ([schema.sql:345-370](../supabase/schema.sql#L345-L370) — Stake President, Bishop, High Councilor, etc.) and read into dropdowns at runtime ([AdminTransitionsTab.tsx:130-133](../src/components/admin/AdminTransitionsTab.tsx#L130-L133), [AdminCallingsTab.tsx:45-49](../src/components/admin/AdminCallingsTab.tsx#L45-L49)). **An admin cannot add, rename, or remove a position from the UI** — there is no positions-management screen. A needed-but-missing position requires a developer/DB insert. The tab even has hardcoded name-matching logic to guess which positions belong to which org type ([AdminTransitionsTab.tsx:139-157](../src/components/admin/AdminTransitionsTab.tsx#L139-L157)), which will silently mis-filter if org names don't match the expected strings (**inference**).

### Adding a calling for a person not yet in the system
**Can be done inline** — no separate prior step is required. Inside every `PersonSelector`, typing a name with no match reveals "+ Add new person" → a name-only modal → **Create**, which inserts the `people` row and immediately selects it for the calling ([AdminTransitionsTab.tsx:530-567](../src/components/admin/AdminTransitionsTab.tsx#L530-L567), [L1569-1581](../src/components/admin/AdminTransitionsTab.tsx#L1569-L1581)). Caveat: only `full_name` is captured (§3, §4 #16), and this inline creation is the *only* create-person path in the whole app.

---

## 10. Photo and media handling

All in [AdminPhotosTab.tsx](../src/components/admin/AdminPhotosTab.tsx) (submitted event/group photos) and, for headshots, [AdminPortraitsTab.tsx](../src/components/admin/AdminPortraitsTab.tsx). Admins only ever *review* uploads; origination is a public flow (§3).

### Approve a submitted photo
Path: Photos tab → Pending → **Approve** ([handleApprove, L567-616](../src/components/admin/AdminPhotosTab.tsx#L567-L616)).
- Sets `photos.status='approved'`, `reviewed_at=now()`.
- Reads `photo_people` and inserts a `follow_activity` row per tagged person so watchers get it.
- **Admin sets nothing at approve time** — no required parameters. The file is not moved (unlike portraits). No `audit_log` entry for approve.

### Reject a submitted photo
Path: Photos → Pending → **Reject** ([handleReject, L618-644](../src/components/admin/AdminPhotosTab.tsx#L618-L644)).
- Sets `status='rejected'`, `reviewed_at=now()`.
- **The original file is deleted from Storage** (`photos` bucket, [L622-627](../src/components/admin/AdminPhotosTab.tsx#L622-L627)) — rejection is destructive to the image. There is **no rejection-reason field** for photos (unlike portraits).

### Adjust focal point / crop / adjust image (Edit modal)
Path: Photos → **Edit** → accordions ([L1000-1280](../src/components/admin/AdminPhotosTab.tsx#L1000-L1280)).
- **Focal point:** click on the image to set `focal_x`/`focal_y` (percent). **Defaults: x=50, y=33** ([L59-60](../src/components/admin/AdminPhotosTab.tsx#L59-L60)); "Reset to default" restores 50/33 ([L1259](../src/components/admin/AdminPhotosTab.tsx#L1259)). Stored on the `photos` row and used as CSS `object-position` for grid thumbnails ([L799](../src/components/admin/AdminPhotosTab.tsx#L799)). Purely presentational; the underlying file is unchanged.
- **Crop:** manual drag; free-form aspect (starts at 90% of the image, [L110-124](../src/components/admin/AdminPhotosTab.tsx#L110-L124)). Warning shown: "Crop cannot be undone after saving." ([L1101](../src/components/admin/AdminPhotosTab.tsx#L1101)). Applying a crop generates a **new** compressed file.
- **Adjust:** brightness/contrast/saturation sliders, each defaulting to 0 ([L49-51](../src/components/admin/AdminPhotosTab.tsx#L49-L51)), range −50…+50. Applying generates a new file.
- Crop and adjust are mutually exclusive at save (crop takes precedence, [L421-437](../src/components/admin/AdminPhotosTab.tsx#L421-L437)).

### Replace / re-upload the image (side effect of crop or adjust on save)
On **Save Changes** ([handleSaveEdit, L408-540](../src/components/admin/AdminPhotosTab.tsx#L408-L540)):
- If a crop or adjust was applied, a new file is uploaded to `photos/approved/{id}_{timestamp}.jpg` and `photos.photo_url` is updated; **the old file is then removed from Storage** ([L455-466](../src/components/admin/AdminPhotosTab.tsx#L455-L466)). So editing an image destroys the previous version.
- If no image change, `photo_url` is deliberately **not** rewritten to avoid persisting a short-lived signed URL ([L479-483](../src/components/admin/AdminPhotosTab.tsx#L479-L483)).
- Manual metadata the admin can set on this modal: **Caption (required)**, Approximate Date (optional, free text), Event/Context (optional, free text), Tagged People (DB people or free-text names), Submitter Name, Submitter Email, focal point. `photo_people` is fully deleted and re-inserted from the current tag list ([L492-510](../src/components/admin/AdminPhotosTab.tsx#L492-L510)). Writes an `audit_log` entry with `old_values:null` ([L512-530](../src/components/admin/AdminPhotosTab.tsx#L512-L530)) — i.e. prior caption/tags are not preserved.

### Delete a photo
Path: Photos → Approved → **Delete** (1-click arm → type-DELETE modal) ([handleDeleteConfirm, L661-719](../src/components/admin/AdminPhotosTab.tsx#L661-L719)). Deletes `photo_people`, then the Storage file, then the `photos` row; writes `audit_log`. **The file is permanently removed from storage.** Irreversible.

### Portrait specifics (for contrast)
- **Approve** *moves* the file from `portraits/pending/...` to `portraits/approved/{personId}/...`, deletes the pending copy, and stamps `people.portrait_url/portrait_pending=false/portrait_approved_at` ([AdminPortraitsTab.tsx:403-465](../src/components/admin/AdminPortraitsTab.tsx#L403-L465)).
- **Reject** deletes the pending file and records an **optional rejection reason** ([L467-501](../src/components/admin/AdminPortraitsTab.tsx#L467-L501)).
- **Edit** enforces a **4:5 aspect crop** ([ASPECT_RATIO, L14](../src/components/admin/AdminPortraitsTab.tsx#L14)) with an oval head-position guide, brightness/contrast/saturation, replace-file, and **reassign to a different person** (which nulls the old person's `portrait_url`, [L605-628](../src/components/admin/AdminPortraitsTab.tsx#L605-L628)). Old file removed on replace.
- **Delete** removes the approved file and nulls `people.portrait_url` ([L695-741](../src/components/admin/AdminPortraitsTab.tsx#L695-L741)).

**Summary of destructiveness:** rejecting or deleting a photo/portrait **permanently deletes the source image from Storage**; editing an image **permanently replaces** the prior version. None of these are recoverable from the UI.

---

## 11. Subscription list

There is a weekly email digest, but **no subscriber list as a managed entity and no admin UI for it whatsoever.**

- **Where "subscriber" state lives:** a single boolean column `user_profiles.weekly_digest_enabled`. The "subscriber list" is therefore just "user_profiles rows where that flag is true." Who a user follows lives in a separate `person_follows` table, and the activity that seeds emails lives in `follow_activity`.
- **How someone subscribes/unsubscribes:** **self-service only**, via a checkbox on their own **My Watchlist** page ("Send me weekly digest emails about my watchlist") which toggles `weekly_digest_enabled` on their own profile ([MyWatchlistPage.tsx:195-221](../src/pages/MyWatchlistPage.tsx#L195-L221)). There is no unsubscribe link in the emails themselves — the digest footer only offers "Manage your watchlist" / "Visit Stake History" ([weekly-digest/index.ts:96-99](../supabase/functions/weekly-digest/index.ts#L96-L99)).
- **How the digest is sent:** the Supabase edge function [weekly-digest/index.ts](../supabase/functions/weekly-digest/index.ts) runs on a schedule (**inference** — the function exists but no cron definition is in the repo), selects users with `weekly_digest_enabled=true` ([L117-120](../supabase/functions/weekly-digest/index.ts#L117-L120)), shards them across weekdays by a hash of their id ([L12-19,148](../supabase/functions/weekly-digest/index.ts#L12-L19)), pulls their watched people and last-7-days activity, and emails via Gmail SMTP using the service-role key. Users with no new activity are skipped ([L182-186](../supabase/functions/weekly-digest/index.ts#L182-L186)). Recipient email addresses are read from `auth.users` at send time ([L124-128](../supabase/functions/weekly-digest/index.ts#L124-L128)).
- **Admin capabilities for viewing / adding / editing / exporting / removing subscribers:** **none exist in the codebase.** No admin screen lists digest recipients, follower counts, or watch relationships; there is no export; an admin cannot subscribe, unsubscribe, or edit anyone's digest preference from the UI. The only ways to change a subscriber flag are the user's own checkbox or **direct database access.** (`weekly_digest_enabled` is not even shown in the Users tab.)
- **Related:** there is a separate feature-announcement flag `user_profiles.has_seen_watch_feature` ([useFeatureAnnouncements.ts:62](../src/hooks/useFeatureAnnouncements.ts#L62)) — also not admin-manageable.

---

## 12. Silent corruption paths

Ways a well-meaning admin can damage the historical record with **no error and no warning**. Each is grounded in the code; recoverability is assessed from the UI's perspective.

1. **Duplicate person via non-matching search.** Person search is a plain `ilike '%term%'` on `full_name` only ([PersonSearchModal.tsx:48-54](../src/components/people/PersonSearchModal.tsx#L48-L54), [usePeopleSearch] used by PersonSelector). Inline "Add new person" inserts with **no duplicate check** ([AdminTransitionsTab.tsx:537-544](../src/components/admin/AdminTransitionsTab.tsx#L537-L544)). So "J. Smith" vs "John Smith" vs "Jonathan Smith," a typo, or a middle-initial difference silently creates a second person, splitting that individual's callings/photos/memories across two records. **No merge tool exists**, so this is not recoverable from the UI — it requires DB surgery.
2. **Renaming a person over the top of the wrong identity.** "Fix Names" updates `full_name`/`display_name` in place on whatever row is being edited ([AdminPeopleTab.tsx:58-86](../src/components/admin/AdminPeopleTab.tsx#L58-L86)), with no `audit_log` entry and a hard page reload. It does **not** orphan callings (they reference `person_id`), but if an admin edits the wrong record or retypes a name to "fix" a duplicate, every calling/photo/memory attached to that id silently changes identity. The prior name is not recorded anywhere (no audit log for this action) — not recoverable from the UI.
3. **Editing/overwriting a submitted contribution.** Editing a memory overwrites the contributor's original `content` (and relationship/time period/submitter fields) and logs `old_values:null` ([AdminMemoriesTab.tsx:199-225](../src/components/admin/AdminMemoriesTab.tsx#L199-L225)); editing a photo overwrites caption/tags/date similarly with `old_values:null` ([AdminPhotosTab.tsx:512-530](../src/components/admin/AdminPhotosTab.tsx#L512-L530)). The submitter's original words are **not preserved** after an edit. Not recoverable from the UI.
4. **Reassigning a portrait silently strips it from the previous person.** In the portrait Edit → "Assign to Person" flow, saving with a different person nulls the old person's `portrait_url` ([AdminPortraitsTab.tsx:605-628](../src/components/admin/AdminPortraitsTab.tsx#L605-L628)) with no confirmation. Choosing the wrong person removes a correct portrait silently. The old image file may also be removed on replace.
5. **Overlapping / contradictory calling dates.** As in §9: no overlap check and no start-vs-end validation. An admin can create two concurrent holders of one position, or release-before-sustained, and the record saves without complaint. Downstream ordering/current-status displays quietly go wrong (**inference** on downstream effect).
6. **Changing a presidency number.** The Fix-# double-entry modal only *warns* it "affects historical ordering" ([AdminCallingsTab.tsx:656-659](../src/components/admin/AdminCallingsTab.tsx#L656-L659)); it doesn't validate against other rows. Setting a colliding or out-of-sequence number silently reorders/regroups a presidency. Reversible only by knowing and re-entering the prior value (which isn't shown after the change).
7. **Rejecting or deleting a photo/portrait destroys the only copy.** Reject and delete remove the source file from Storage (§10). A misclick on Reject (no reason prompt, no undo for photos) permanently loses the submitted image. Not recoverable from the UI.
8. **Partial leadership transitions.** The release-then-insert and batch flows are non-transactional (§9). A mid-operation failure can leave someone released with no replacement, or a half-built new presidency, and the admin sees only the last error. Recovery requires manually finishing the transition.
9. **Deleting an individual is not exposed — but the schema would cascade.** There is no delete-person button anywhere, so an admin cannot do this from the UI (a mild safety). However, `callings.person_id` is `ON DELETE CASCADE` ([schema.sql:67](../supabase/schema.sql#L67)), so **if** a person is ever deleted directly in the database, all their calling history is silently and permanently destroyed with it (**inference** about DB-side behavior; the cascade is direct).
10. **`released_date` set via the plain field editor.** Fix All Else lets an admin type any released date on any calling with no guardrails ([AdminCallingsTab.tsx:332-338](../src/components/admin/AdminCallingsTab.tsx#L332-L338)); combined with #5 this is an easy way to silently truncate or reopen a historical term.

Cross-cutting: **the `audit_log` table captures some of these mutations but has no viewer** (§8), so even where a trail exists, an admin has no in-app way to notice or reverse a mistake.

---

## 13. Session and access continuity

This section extends §6 (which covered roles and granting admin).

### How a session is established and how long it lasts
- Sign-in is **email + password** via `supabase.auth.signInWithPassword` ([AuthModal.tsx:51-54](../src/components/auth/AuthModal.tsx#L51-L54)). There is no magic-link or SSO path in the UI (despite CURSOR_INSTRUCTIONS describing magic links as the Phase-2 plan).
- The client is configured with `persistSession: true` and `autoRefreshToken: true` ([supabase.ts:10-15](../src/lib/supabase.ts#L10-L15)), so the session is stored in the browser (localStorage) and the access token is auto-refreshed. There is **no explicit session-timeout or idle-logout in the app code** — duration is governed by Supabase's JWT/refresh-token settings on the server, which are not in the repo (**inference**: with defaults, an access token lasts ~1 hour and silently refreshes, so a persisted login effectively stays valid until sign-out or refresh-token expiry/revocation).
- Admin status is re-derived on every load by querying `user_profiles.role` ([useAdmin.ts:18-26](../src/hooks/useAdmin.ts#L18-L26)); auth state changes are tracked live ([useAuth.ts:15-21](../src/hooks/useAuth.ts#L15-L21)).
- **Sign-out** is a single `supabase.auth.signOut()` from the user menu ([UserMenu.tsx:42](../src/components/auth/UserMenu.tsx#L42)).

### What happens on password reset
- **There is no password-reset UI in the app.** No `resetPasswordForEmail`, no `updateUser`, and no "Forgot Password?" link exist anywhere in the code (confirmed by search). The Sign-In modal offers only email/password and a toggle to Sign Up ([AuthModal.tsx:405-431](../src/components/auth/AuthModal.tsx#L405-L431)).
- This directly contradicts the contributor guide, which instructs users to click a "Forgot Password?" link and receive a reset email ([generate_guide_pdf.py:162,232-233](../scripts/generate_guide_pdf.py#L162-L233)). **That link does not exist** — a user who forgets their password has no self-service recovery in the product.
- A reset could still be triggered out-of-band from the Supabase dashboard (an admin/developer sending a recovery email), but nothing in the app initiates or handles the recovery redirect (**inference**).

### Account recovery path that does not require database/dashboard access
- **None exists in the app.** With no forgot-password flow and no admin "reset this user's password" control, every recovery route runs through the Supabase dashboard or database (i.e. developer-level access). A locked-out admin cannot be recovered by another admin from the UI.

### Can the current admin create, disable, or transfer an admin account from the UI?
- **Create an admin account:** Partial. An admin cannot create a login for someone — the successor must self-register first ([AuthModal.tsx:69-120](../src/components/auth/AuthModal.tsx#L69-L120)); the admin can then promote them via **Users → Make Admin** ([AdminUsersTab.tsx:330-341](../src/components/admin/AdminUsersTab.tsx#L330-L341)). So the "create admin" task is two-party and depends on the successor completing signup.
- **Disable an account:** No true disable/suspend. The closest control is **Restrict View** ([AdminUsersTab.tsx:96-139](../src/components/admin/AdminUsersTab.tsx#L96-L139)), which only blocks *viewing* members-only content — it does **not** prevent sign-in, submission, or (for an admin) admin actions. There is no "deactivate user," no force-sign-out, and no delete-user in the UI.
- **Transfer admin:** Done as promote-then-demote — promote the successor (Make Admin), then Remove Admin on the outgoing account (three `window.confirm` dialogs; you cannot demote yourself, [AdminUsersTab.tsx:16-31](../src/components/admin/AdminUsersTab.tsx#L16-L31)). Both are UI-possible **provided at least one admin account remains reachable.**

### Handoff-survival summary
The site survives a *planned* handoff (outgoing admin promotes the successor who has signed up, then optionally demotes themselves). It does **not** gracefully survive an *unplanned* one: if the sole admin loses their password, there is no in-app recovery and no other admin to promote a replacement — restoring access requires Supabase dashboard/database access (a developer), because bootstrapping the first/only admin was never a UI capability (§6). (**Inference**, from the combination of: no forgot-password UI, no admin-initiated password reset, promotion requiring an existing admin, and self-demotion being blocked.)
