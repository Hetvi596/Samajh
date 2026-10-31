# SAMAJH DATABASE GUIDE

What we store, how the phone and Supabase fit together, how to connect them, and what every table is for.

## 1. Decisions this guide is built on

| Topic | Decision |
|---|---|
| Local database | **drift with encrypted SQLite (SQLite3MultipleCiphers)**, on the phone, always available, no internet |
| Cloud database | **Supabase (Postgres)**, later phase, **backup and restore** only. The phone stays the source of truth |
| Authentication | Supabase Auth, **later phase**. The schema is ready for it (`owner_id`), nothing signs in yet |
| Who owns data | **One teacher owns a class. A teacher can own many classes.** No head teacher, no school accounts, no shared classes |
| Leaves the phone (cloud phase only) | Class settings, children (first name + last initial), consent, checks (including student self-rating), marks, tiered question answers, results, groups, practice records. This matches the project report's privacy table ("Not until a backend exists") |
| Never leaves the phone | **Audio recordings (temporary local vault only, auto-deleted), the passcode, encryption keys**, demo data. **Zero camera capture, zero photos, zero OCR.** |
| Cloud region | Mumbai (ap-south-1) |
| Demo vs Real | Two separate local database files. Only the Real one ever syncs |

## 2. Local storage options and why drift

| Option | Offline | Encrypted | Relational queries | Easy to mirror to Supabase | Verdict |
|---|---|---|---|---|---|
| **drift + SQLite3MultipleCiphers** | Yes | Yes (whole file) | Yes | Yes (same table shapes as Postgres) | **Choose this** (already in the project report) |
| sqflite | Yes | No | Yes | Yes | No encryption |
| Isar / Hive | Yes | Limited | Weak | Hard | Poorly maintained, no relations |
| ObjectBox | Yes | Limited | Weak | Hard | Different data model |
| PowerSync (+ Supabase) | Yes | Check first | Yes | Built for it | Possible later, but replaces the local layer; evaluate only when sync starts |

## 3. What to store, and what not to

**Store (needed to run the app or restore a class)**
- Teacher: display name (optional), app language
- Class: name, grade, section, curriculum, languages, textbook id, academic year
- Child: **first name and last initial**, home language
- Consent: purpose (assessment or cloud backup), status, date, note
- Check: passage id, dates, state and step (for resume), student self-rating (thumbs up/down), noise level, low-confidence flag, reading seconds, rubric and benchmark used
- Marks: per-word mark, optional "what the child said" text, mistake kind
- Retell points ticked, question results (tiered levels 1-3, weighted points, discontinuation rule if level 1 fails), dictation item results (5 items marked directly by teacher in notebook; zero OCR, zero photos)
- Result: accuracy, speed (only when trustworthy), student self-rating, counts, understanding and writing summaries, group, next step
- Group history, practice needs, printed-sheet records, weekly plan ticks, parent-report approval, accepted pronunciations, milestone stars

**Never store**
- Date of birth, address, phone number, Aadhaar or any ID number, full surname
- Photos or images: Zero camera capture, zero photos, and zero OCR anywhere in the app or cloud
- Audio: only a temporary encrypted local file that is deleted upon saving marks; never enters the database or cloud
- The passcode or any key
- Precise location, advertising or device identifiers
- Free-text notes about a child's family or health

## 4. Structure of the database

```
teacher  (1)
  |-- sync_devices (phones the teacher uses)
  |-- accepted_pronunciations (teacher's own list)
  |-- classes (many)
        |-- weekly_plan_ticks
        |-- children (many)
              |-- consents
              |-- group_assignments (history, append-only)
              |-- practice_needs
              |-- practice_items_printed
              |-- parent_reports (approval record)
              |-- milestone_stars
              |-- listening_checks
              |-- checks (many)
                    |-- word_marks
                    |-- retell_points
                    |-- question_answers
                    |-- dictation_items
                    |-- results (exactly one per check)
```

Deleting a class or a child deletes everything below it in one step (`on delete cascade`). That is how "delete a child's data" works in the cloud as well as on the phone.

### What each table is for

| Table | Purpose | Key facts |
|---|---|---|
| `teachers` | Profile of the signed-in teacher | Created automatically at sign-up |
| `sync_devices` | Which phones a teacher uses and when they last synced | Helps with restore on a new phone |
| `classes` | One classroom | Curriculum, language of the check, textbook, year |
| `children` | One learner | First name and last initial only |
| `consents` | Parental consent records | Separate **purpose** for assessment and for cloud backup; status given, declined, withdrawn, not recorded |
| `checks` | One reading check | `state` supports pause and resume; records `student_self_rating` (thumbs up/down); stores benchmark and rubric used |
| `word_marks` | Teacher's mark on each word | Seven marks; "not sure" and "not reached" never count as errors |
| `retell_points` | Story points the teacher ticked | One row per point |
| `question_answers` | Tiered comprehension questions marked by teacher | Level 1 (fact 1pt), Level 2 (inferential 2pt), Level 3 (evaluative 3pt); supports discontinuation rule ('not_asked'); records points awarded |
| `dictation_items` | The five dictation items and their marking | Teacher marks directly in notebook; zero OCR, zero photos |
| `listening_checks` | Optional listening check | Used to tell decoding trouble from language trouble |
| `results` | Analysed outcome of one check | Accuracy, speed, `student_self_rating`, counts, evidence status, group, next step |
| `group_assignments` | Every group suggestion and every teacher move | Append-only history with notes |
| `practice_needs` | What a child needs next | Codes: matra, conjunct, bindu, word reading, fluency, facts, why or how, word meaning, spelling, listening |
| `practice_items_printed` | Record that a sheet was printed and passed the validator | Stores a hash, not the page |
| `weekly_plan_ticks` | Which weekly group activities are done | One per class, week, group, activity |
| `parent_reports` | That a parent report exists and the teacher approved it | The text is rebuilt on the phone; nothing is shared until approved |
| `accepted_pronunciations` | Regional pronunciations the teacher accepted | Teacher-only list |
| `milestone_stars` | Teacher-awarded stars | No class chart, no ranking |
| `sync_tombstones` | Ids of deleted classes and children | Lets a second phone remove them too; holds no personal data |

### Columns every synced table has
`id` (UUID made on the phone), `owner_id` (the teacher), `created_at`, `updated_at` (set by the phone when the row changes), `server_updated_at` (set by Supabase, used to pull "what changed since"), `deleted_at` (soft delete for ordinary rows).

### Local only (never uploaded)
`app_settings`, `media_index` (the list of temporary local encrypted audio files with their auto-expiry times; zero photos), `audit_events` (no personal data), `sync_outbox` (changes waiting to upload), `sync_state` (last sync position), the passcode hash and all keys.

## 5. How phone and cloud work together (later phase)

**Rule:** the app always reads and writes the local database. The cloud is a copy.

1. **Every change on the phone** is written to the local table and added to `sync_outbox` in the same transaction.
2. **When online and signed in** (and only if the teacher has switched cloud backup on), the sync job **pushes** the outbox in a fixed order so links never break:
   `classes, children, consents, checks, word_marks, retell_points, question_answers, dictation_items, listening_checks, results, group_assignments, practice_needs, practice_items_printed, weekly_plan_ticks, parent_reports, accepted_pronunciations, milestone_stars`.
3. **Pull** asks each table for rows with `server_updated_at` greater than the last saved position, then applies them locally.
4. **Conflicts:** last write wins, decided by `updated_at`. The server ignores an older edit from a phone that was offline for a long time. Groups, marks and checks are mostly written once, so conflicts are rare.
5. **Deleting:** removing a child or class deletes it in the cloud (cascade) and leaves a tombstone so other phones remove it too.
6. **Consent gate:** a child's data uploads only if the teacher has recorded **cloud backup** consent for that child (setting can be tightened or relaxed after the legal review).
7. **New phone:** sign in, pull everything, rebuild classes, children and results. Audio is never uploaded, and zero photos or OCR exist, so none return.
8. **Clocks:** `updated_at` uses the phone's clock. If a phone's date is badly wrong, the app should warn before syncing.

## 6. Connecting the project

### Phase A: now (offline build, no Supabase code running)
1. Make the local database cloud-ready:
   - Text **UUID** primary keys instead of 1, 2, 3.
   - Add `ownerId` (nullable until sign-in exists), `createdAt`, `updatedAt`, `deletedAt` to every table in section 4, matching the SQL file.
   - Add the local-only tables `sync_outbox` and `sync_state`.
   - Keep two database files: `samajh_demo.db` and `samajh_real.db`. Only the Real file gets the outbox.
2. Add two Android build flavours:
   - `offline` (default): **no INTERNET permission**. This is the build you test and submit today.
   - `sync` (later): adds the INTERNET permission through `android/app/src/sync/AndroidManifest.xml`, and the Supabase code. The "no INTERNET" test runs only on the `offline` flavour.
3. Define a `CloudSync` interface with two implementations: `NoopCloudSync` (offline flavour) and `SupabaseCloudSync` (sync flavour, built later).

Starter local table shape (drift):

```dart
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

mixin SyncColumns on Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get ownerId => text().nullable()();      // teacher id, empty until sign-in
  IntColumn get createdAt => integer()();             // epoch milliseconds
  IntColumn get updatedAt => integer()();             // set on every change
  IntColumn get deletedAt => integer().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Classes extends Table with SyncColumns {
  TextColumn get name => text()();
  IntColumn get grade => integer()();
  TextColumn get curriculum => text()();
  TextColumn get checkLanguage => text()();
  TextColumn get instructionMedium => text()();
  TextColumn get academicYear => text()();
  TextColumn get section => text().nullable()();
  TextColumn get textbookId => text().nullable()();
  TextColumn get currentChapterId => text().nullable()();
}

class Children extends Table with SyncColumns {
  TextColumn get classId => text().references(Classes, #id)();
  TextColumn get firstName => text()();
  TextColumn get lastInitial => text()();
  TextColumn get homeLanguage => text()();
}

class SyncOutbox extends Table {                       // local only
  IntColumn get seq => integer().autoIncrement()();
  TextColumn get tableName => text()();
  TextColumn get rowId => text()();
  TextColumn get op => text()();                       // 'upsert' or 'delete'
  IntColumn get createdAt => integer()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}
```

The other tables follow the same pattern, one drift table per Supabase table.

### Phase B: later (cloud backup and sign-in)

**Step 1: create the Supabase project**
1. supabase.com, New project, **region: Mumbai (ap-south-1)**, strong database password (save it in a password manager).
2. SQL Editor, New query, paste `samajh_supabase_schema.sql`, Run.
3. Run the four CHECK queries at the bottom of the file. All tables must show row level security on.

**Step 2: sign-in method (Authentication, Providers)**
- Easiest to start: **Email** (magic link or one-time code).
- Phone OTP needs an SMS provider, which costs money per message; decide later.
- Turn on email confirmation. Keep sign-ups limited to teachers (rate limits on).

**Step 3: get the two values the app needs**
Project Settings, API: **Project URL** and the **anon (public) key**. Only these go in the app. **Never** put the `service_role` key in the app or in the repository.

**Step 4: keep keys out of the code**
Pass them at build time:
```
flutter run --flavor sync --dart-define=SUPABASE_URL=https://xxxx.supabase.co --dart-define=SUPABASE_ANON_KEY=xxxx
```

**Step 5: app code (sync flavour only)**
```dart
// pubspec.yaml: supabase_flutter
await Supabase.initialize(
  url: const String.fromEnvironment('SUPABASE_URL'),
  anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
);
final db = Supabase.instance.client;

// sign in (email code)
await db.auth.signInWithOtp(email: email);
// after the code arrives:
await db.auth.verifyOTP(email: email, token: code, type: OtpType.email);

// push one batch (rows already converted: epoch ms -> ISO timestamps)
await db.from('children').upsert(rows, onConflict: 'id');

// pull changes since the saved position
final changed = await db
    .from('children')
    .select()
    .gt('server_updated_at', lastPulled)
    .order('server_updated_at')
    .limit(500);

// delete everything this teacher has in the cloud
await db.rpc('delete_my_cloud_data');
```

**Step 6: test before real use**
- Create two test teachers. Teacher B must see zero rows of teacher A's data and must be refused when inserting a child under A's class.
- Switch the phone to airplane mode, create data, reconnect, confirm it uploads in order and nothing duplicates.
- Delete a child on phone 1, sync, confirm phone 2 removes it.

## 7. Security and privacy rules for the cloud phase

- Row Level Security on every table; users get access only to rows where `owner_id` equals their own id. Anonymous (not signed in) users get nothing.
- Composite links (`class_id` plus `owner_id`) mean a row can never point at someone else's class.
- No Supabase Storage bucket is created; audio never leaves local encrypted storage and zero photos, camera captures, or OCR exist in the system.
- Update the in-app privacy promise and the privacy centre **before** turning sync on: it must say what is uploaded, offer "Delete my cloud data", and ask for the separate cloud-backup consent. The report's rule still applies: a qualified person must confirm how the DPDP education exemption applies before real schools use the app. The app never claims legal compliance.
- Backups of Supabase itself and who can open the dashboard (the team) should be limited to named people, with two-factor sign-in on the Supabase account.

## 8. What is deliberately not included

- Head-teacher accounts, school-level cloud dashboards, shared classes between teachers (you decided against them; each teacher stays isolated).
- Audio and photo cloud storage, camera image capture, and OCR / handwriting recognition (dictation is marked directly by the teacher in the child's notebook).
- Live real-time updates between phones (not needed; sync runs in the background when online).
- Any server code of your own. Supabase tables plus row-level security are enough for this phase.

## 9. Open questions to settle before turning sync on

1. Final sign-in method: email, phone OTP, or a school code.
2. Should cloud upload be **blocked** for a child without cloud-backup consent (recommended), or allowed with the assessment consent only? A reviewer should confirm.
3. Will two phones ever be used by the same teacher at once? (If never, restore-only sync is enough and conflict handling can stay minimal.)
4. How long should cloud data be kept after the academic year ends, and who deletes it?
