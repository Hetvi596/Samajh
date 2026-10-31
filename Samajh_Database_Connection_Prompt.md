# SAMAJH: DATABASE AND SUPABASE CONNECTION PROMPT

Use in the Antigravity workspace that holds the Samajh project and `/docs/source/`. Also place these two files in `/docs/database/`: `samajh_supabase_schema.sql` and `Samajh_Database_Guide.md`. Paste everything between BEGIN and END.

# BEGIN PROMPT

## 0. Task

Make Samajh's local database cloud-ready **without changing how the app behaves today**, and prepare (but do not activate) a Supabase backup-and-sync layer. The app must keep working 100% offline with the local encrypted database as the source of truth.

Read `/docs/database/Samajh_Database_Guide.md` and `/docs/database/samajh_supabase_schema.sql` first. They define the decisions, the cloud tables and the sync rules. This prompt tells you how to build against them.

**Rules**
1. Do not change screens, wording or behaviour except where a database change forces it. Existing tests must keep passing.
2. Local database stays **drift with encrypted SQLite (SQLite3MultipleCiphers)**, key in Android Keystore-backed secure storage. Audio stays in its temporary encrypted vault (auto-deleted upon marking) and **never** enters the database or the cloud. Zero camera capture, zero photo storage, and zero OCR exist anywhere in the app.
3. The default build (flavour `offline`) has **no `INTERNET` permission** and no network code running. Supabase code exists only in the `sync` flavour and is off by default.
4. Cloud holds only what the schema file lists. Never add date of birth, address, phone number, ID numbers, audio, photos/images, passcode or keys.
5. Reply first with a plan: the list of current tables and what changes in each, then do the work in the order of section 9. Run `flutter analyze` and `flutter test` after each step and log it in `docs/CHECKPOINT.md`.

## 1. Two local database files

- `samajh_demo.db` for the fictional class and `samajh_real.db` for real data, each with its own encryption key in secure storage and its own media folder.
- All repositories take the active database from a provider that switches when the mode changes; every provider that reads data is invalidated on switch.
- Only `samajh_real.db` has the outbox and ever syncs. Demo data never leaves the phone.
- If the current app uses one database, write a one-time migration that moves existing demo rows into `samajh_demo.db` and leaves `samajh_real.db` empty (or moves real rows if any exist). Log what you did in `docs/DECISIONS.md`.

## 2. Make the local schema match the cloud schema

For every synced table in the SQL file, the local drift table has the **same name, same columns and the same meaning** with these local type rules:

| Cloud (Postgres) | Local (drift) |
|---|---|
| `uuid` | `text` (UUID v4 string, generated on the phone with the `uuid` package) |
| `timestamptz` | `integer` (epoch milliseconds, UTC) |
| `date` | `text` (ISO `yyyy-MM-dd`) |
| `boolean` | `bool` |
| `numeric` | `real` |
| `text[]` | `text` (JSON array) |
| `jsonb` | `text` (JSON object) |
| `check (... in (...))` | enum-like text with a Dart `enum` and a converter; reject unknown values |

Every synced table gets the `SyncColumns` mixin: `id` (text UUID, client default), `ownerId` (nullable until sign-in exists), `createdAt`, `updatedAt` (set by the repository on every write), `deletedAt` (nullable). `server_updated_at` is **not** stored locally.

Synced tables (19 in the SQL, 18 stored locally plus tombstones handled by the sync layer): classes, children, consents, checks (with `student_self_rating`), word_marks, retell_points, question_answers (tiered with weighted points and discontinuation rule), dictation_items (marked directly by teacher in notebook; zero OCR, zero photos), listening_checks, results (with `student_self_rating`), group_assignments, practice_needs, practice_items_printed, weekly_plan_ticks, parent_reports, accepted_pronunciations, milestone_stars (and the sync_devices record, created only by the sync layer).

Local-only tables (never uploaded): `app_settings`, `media_index` (temporary audio vault only; zero photos), `audit_events`, `sync_outbox`, `sync_state`.

Rules to enforce in code, mirroring the SQL constraints:
- `results.correct_wpm` is null unless `speed_measured` is true.
- A parent report cannot be marked approved without `approved_at`.
- `word_marks` unique on (`checkId`, `wordIndex`); `retell_points` unique on (`checkId`, `pointIndex`); `question_answers` unique on (`checkId`, `questionId`); `dictation_items` unique on (`checkId`, `position`).
- `checks.student_self_rating` and `results.student_self_rating` accept 'thumbs_up', 'thumbs_down', or 'not_recorded'.
- `question_answers` supports tiered comprehension types ('fact', 'cause_effect', 'word_meaning', 'why_how', 'main_idea') with weighted points and discontinuation rule (higher tiers marked 'not_asked' if Level 1 fails).
- Child names are stored as first name and last initial only. Reject longer initials.
- Foreign keys are enforced (`PRAGMA foreign_keys = ON`) with cascade deletes matching the cloud (class to children to everything below).

**Migration:** bump the schema version, write a migration from the current version that converts integer ids to UUIDs (keep a temporary mapping table, rewrite every foreign key, then drop the mapping), adds the new columns with sensible defaults (`createdAt = updatedAt = migration time`), and add a migration test using a fixture database from the previous version. Existing behaviour and data must survive.

## 3. Repository layer and the outbox

- All writes go through repositories. A repository write does three things in **one transaction**: set `updatedAt` (and `createdAt` on insert), write the row, and add a row to `sync_outbox` (`tableName`, `rowId`, `op` = `upsert` or `delete`, `createdAt`). The outbox is written only in `samajh_real.db`.
- Collapse duplicates: if a row already has a pending outbox entry, update it instead of adding another.
- Deleting a child or class: delete locally with cascade, then add one outbox `delete` entry for the parent row (the cloud cascades). Child rows of a deleted parent are removed from the outbox.
- A single `Clock` service supplies time so tests can control it. If the phone's date is earlier than the app's build date, the sync layer must refuse to run and the app must show a gentle "check your phone's date" message.
- Screens never call the cloud and never wait for it.

## 4. Build flavours

- Android product flavours: `offline` (default, used for testing and the hackathon build) and `sync`.
- `android/app/src/main/AndroidManifest.xml` has no `INTERNET` permission. `android/app/src/sync/AndroidManifest.xml` adds it.
- Entry points `lib/main_offline.dart` (wires `NoopCloudSync`) and `lib/main_sync.dart` (wires `SupabaseCloudSync`). Shared code stays in `lib/`.
- The CI/static test "no INTERNET permission, no HTTP package" runs against the `offline` flavour and its dependency set. Put `supabase_flutter` and any network package only in a dependency group used by `main_sync.dart` (for example through conditional imports or a separate package `packages/samajh_sync`), so the offline build does not contain them. Document how in `README.md`.
- Build commands in README: `flutter build apk --release --flavor offline -t lib/main_offline.dart` and `flutter run --flavor sync -t lib/main_sync.dart --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`.

## 5. The CloudSync interface (build now, activate later)

Define in the shared code:

```dart
abstract class CloudSync {
  Future<bool> get isAvailable;          // false in the offline flavour
  Stream<SyncStatus> get status;         // idle, offline, signedOut, syncing, error, upToDate
  Future<void> signIn(AuthRequest request);
  Future<void> signOut();
  Future<SyncReport> syncNow();          // push then pull
  Future<void> deleteMyCloudData();
}
```

- `NoopCloudSync` (offline flavour): `isAvailable` is false, everything else does nothing. The Settings screen shows **no** cloud options in this flavour.
- `SupabaseCloudSync` (sync flavour): implement against `/docs/database/samajh_supabase_schema.sql`. Mark it **off by default**: nothing uploads until the teacher signs in **and** turns on "Cloud backup" in Settings.
- Build the `sync_state` table (last pulled `server_updated_at` per table, last push time, device id).

### Push
- Read `sync_outbox` in order of `seq`, group by table, and send in this table order so links never break: classes, children, consents, checks, word_marks, retell_points, question_answers, dictation_items, listening_checks, results, group_assignments, practice_needs, practice_items_printed, weekly_plan_ticks, parent_reports, accepted_pronunciations, milestone_stars.
- Convert rows (epoch ms to ISO timestamps, JSON text to arrays and objects), attach `owner_id` from the signed-in user, and `upsert` in batches of up to 200 rows with `onConflict: 'id'`.
- Deletes: send `delete` for the parent row (class or child). Remove outbox entries only after the server confirms.
- On failure keep entries, increase `attempts`, store `lastError`, back off, and never block the UI.
- Skip children who do not have a `cloud_backup` consent of status `given` (and everything below them) when the setting "Back up only children with cloud consent" is on (default on).

### Pull
- For each table (and `sync_tombstones`), request rows with `server_updated_at` greater than the saved position, ordered ascending, 500 at a time; apply to the local database inside a transaction **without** creating outbox entries (use a flag on the repository).
- Conflict rule: last write wins by `updatedAt`; keep the local row if its `updatedAt` is newer than the incoming one.
- Apply tombstones for classes and children by deleting the local row (cascade).
- Never pull or create anything in `samajh_demo.db`.

### Restore on a new phone
After sign-in, if the local Real database is empty, offer "Restore from cloud", run a full pull from the beginning, and report what came back (classes, children, checks). Audio is never uploaded, and zero photos or OCR exist, so none return.

## 6. Auth (prepared, minimal)

- `AuthRequest` supports email code sign-in now; leave a clean extension point for phone OTP.
- Store the Supabase session using the package's secure persistence. A signed-out app behaves exactly like today.
- Set `ownerId` on all local rows the first time a teacher signs in (one transaction, then enqueue everything for upload only if the teacher turns on Cloud backup).
- The app passcode is separate and unchanged; signing in never replaces it.

## 7. Settings and privacy changes (sync flavour only)

- New "Cloud backup" section: sign in or out, a switch "Back up my class to the cloud", "Back up now", last backup time, "Restore from cloud", **"Delete my cloud data"** (calls `delete_my_cloud_data`, requires the passcode and a typed confirmation).
- A clear explanation screen before first use: what is uploaded (first name and last initial, class, consent, marks, answers, results, groups, practice records), what is never uploaded (recordings, passcode; zero photos or OCR exist), where it is stored (Mumbai region), and that a qualified person must confirm data-protection compliance before real-school use. No wording may claim compliance.
- Consent: add the **cloud backup** purpose to the consent form for each child (separate from assessment consent) and to CSV import. Privacy and consent centre shows both purposes.
- Update the privacy table text in the app so the "Leaves the phone?" column reads "Only if you turn on cloud backup" for names, class, consent, marks, answers and groups, and "Never" for recordings and passcode (zero photos or OCR).
- All new strings in English and Hindi; no em dashes.

## 8. Tests

**Local (run in the offline flavour)**
- Schema parity test: a test reads `/docs/database/samajh_supabase_schema.sql`, extracts table and column names, and asserts every cloud table has a local drift table with the same columns (minus `server_updated_at`), and that local-only tables are not in the SQL.
- Migration test: previous-version fixture database upgrades with data intact, ids converted to UUIDs, all foreign keys valid.
- Repository tests: every write sets `updatedAt` and writes exactly one outbox entry in the same transaction (Real database); no outbox in the demo database; duplicates collapse; deleting a child writes one delete entry and removes child rows from the outbox.
- Cascade tests: deleting a class or child removes everything below it locally.
- Constraint tests: invalid enum values, long initials, speed set without `speed_measured`, approved parent report without date are rejected.
- Isolation tests: demo and real databases never contain each other's rows; switching mode refreshes every screen.
- Offline flavour tests: manifest has no `INTERNET`, no network package in the dependency set, app runs fully in airplane mode, Settings shows no cloud section.
- Existing tests (check flow, results, privacy, resume) still pass.

**Sync (run with a fake `SupabaseClient` or a local test project)**
- Push order respects links; failed batches retry without duplicates; offline edits upload once online.
- Pull applies changes without creating outbox entries; stale incoming rows do not overwrite newer local rows; tombstones delete locally.
- Consent gate: a child without cloud consent is not uploaded.
- Restore on an empty phone rebuilds classes, children and results.
- A deliberately wrong phone date blocks syncing with a gentle message.
- Manual two-teacher isolation test against the real Supabase project, following the CHECK steps at the end of the SQL file.

## 9. Order of work

1. Plan and the list of current tables (reply first).
2. Split into `samajh_demo.db` and `samajh_real.db`, provider switching, migration of existing rows.
3. Local schema changes: UUIDs, `SyncColumns`, enums, constraints, schema version bump, migration and its test, parity test.
4. Repository layer with transactional outbox and clock service.
5. Flavours and entry points; move network packages out of the offline build; manifest and dependency tests.
6. `CloudSync` interface, `NoopCloudSync`, `sync_state`.
7. `SupabaseCloudSync`: auth, push, pull, tombstones, restore (sync flavour only, off by default).
8. Settings, consent purpose and privacy text changes (sync flavour only), tests.
9. Documentation: update `README.md`, `docs/DECISIONS.md`, `docs/CHECKPOINT.md`, and a short `docs/SYNC.md` describing the flow.

## 10. Acceptance

- [ ] The offline flavour builds, runs in airplane mode, has no `INTERNET` permission and no network package, and behaves exactly as before (all previous tests pass).
- [ ] Local schema matches the cloud schema (parity test green), with UUID keys and sync columns, and the migration keeps existing data.
- [ ] Every Real-database write creates one outbox entry in the same transaction; Demo never does.
- [ ] The sync flavour can sign in, back up, restore and delete cloud data against a Supabase project created from `samajh_supabase_schema.sql`, and two test teachers cannot see each other's data.
- [ ] Audio, photos/images, the passcode and keys never appear in the database, the outbox or any upload (add a test that scans outbox payloads for forbidden fields).
- [ ] Documentation is updated.

## 11. Start now

First reply with (a) the current local tables and how each maps to the cloud tables, (b) anything in the SQL file or guide that conflicts with the current code or reports, (c) your plan for step 2. Then execute and continue.

# END PROMPT
