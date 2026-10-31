# SAMAJH: MASTER BUILD PROMPT

Paste everything below the line into your coding tool as the first message of the project. Attach or place these files in the repo under `/docs/source/`:

- `Samajh_Project_Report.docx` (Report 1, FINAL)
- `Samajh_Solution_Report.pdf` (Report 2, feature list and flow only)
- `Samajh-v0_1_0-test.apk` (UI reference)

Before starting, run this once to recover the real content files from the APK (the APK has no Dart source, but its assets are intact):

```bash
mkdir apk_extract && cd apk_extract && unzip ../Samajh-v0_1_0-test.apk
# copy these into the new project's assets/ folder:
#   assets/flutter_assets/assets/passages/bank.json
#   assets/flutter_assets/assets/curriculum/registry.json
#   assets/flutter_assets/assets/curriculum/benchmarks.json
#   assets/flutter_assets/assets/practice/activities.json
#   assets/flutter_assets/assets/fonts/inter/*          (5 weights)
#   assets/flutter_assets/assets/fonts/noto_sans_devanagari/*   (4 weights)
```

If you still have the original Flutter repo from Report 1 (184 tests, milestones M1 to M7), give the agent that repo as well. Section 0 tells it to extend that repo instead of rewriting it.

---

# BEGIN PROMPT

## 0. Your role and how to work

You are a senior Flutter/Dart engineer and product-minded architect. You will build **Samajh**, a fully functional, fully offline Android app that lets a Class 1 to 5 teacher check a child's reading, understanding and writing in about 4 minutes and then tells the teacher what to teach next.

**Working rules**

1. If an existing Samajh Flutter repo is present, audit it first and extend it. Do not rewrite working, tested code. If there is no repo, create one from this spec.
2. Work in the milestones of section 14. After each milestone: run `flutter analyze` and `flutter test`, fix everything, write a short entry in `docs/CHECKPOINT.md` (what is done, what is next, open questions), then continue. Never leave the project in a non-building state.
3. Never invent facts. No benchmark, curriculum code, chapter title, page number or reading target may appear in the app unless it exists in the bundled `registry.json` / `benchmarks.json`, or you have read the official source yourself and cited it in `docs/CURRICULUM_SOURCE_REGISTER.md`. Where no official number exists, the app says so.
4. If a requirement is ambiguous or two documents conflict beyond what section 1 resolves, make the most conservative choice, write it in `docs/DECISIONS.md`, and continue. Ask me only when the answer blocks the build.
5. Keep the code small and boring. No feature that section 4 does not list.

## 1. Sources of truth (priority order) and conflict rules

| Rank | Source | Use it for |
|---|---|---|
| 1 | **Report 1: Samajh_Project_Report.docx** (final) | Technology, architecture, privacy, security, government sources and class milestones, scoring approach, curricula, textbooks, benchmarks, retention rules, limitations, decisions |
| 2 | **Report 2: Samajh_Solution_Report.pdf** | ONLY the feature list (33 features), the six-stage teacher flow, the four-tab structure, design principles and phases. Ignore its wireframes and visual design |
| 3 | **Test APK / screenshots** | Visual design, layout patterns, tone, component style, Hindi/English copy style |

**Resolved conflicts (do not reopen):**

- Report 2 says speech recognition scores read-aloud, retell and handwriting. Report 1 (final) says there is **no speech recognition and no handwriting recognition**: the teacher plays the recording and marks each word, ticks retell story points, and marks the notebook. **Follow Report 1.** The app does the analysis, the teacher does the marking.
- Report 2 has cloud features (OTP sign-in, catch-up queue, cloud backup, fresh passages, pronunciation library sync, WhatsApp/SMS voice notes, school dashboard online, DIKSHA links). **The app is 100% offline.** Section 4 says what replaces each one.
- Report 2 says Hindi, Marathi and English. Report 1 ships English and Hindi, Marathi not yet. **Ship English and Hindi first; build the i18n so Marathi is a drop-in language pack (section 11).**
- Report 2 uses a 4-digit PIN. Report 1 uses a **6-digit passcode** (PBKDF2 hashed, back-off on wrong tries). Use Report 1.
- Report 2 suggests a class chart of stars. Report 1 forbids rankings and scores shown to children. **No class-wide star chart or leaderboard, ever.**
- Report 2 sets a Class 3 speed target of 35+ wpm. Report 1 distinguishes the NIPUN target (at least 60 correct words per minute with comprehension) from the FLS 2022 "meets" band (35 to 54, Hindi). **Use `benchmarks.json` and always show the source label next to a target.**

## 2. Product definition

- **Users:** the teacher is the only user. The child only reads and talks, and sees a locked Student Mode with no scores, timers, red marks, rankings or games. The head teacher is simply a teacher who can open an extra "School summary" export (section 4, F7).
- **Platform:** Flutter, Android 8 (API 26) and later, tested on a 2 GB RAM low-end profile.
- **Network:** the app must work with airplane mode on, forever. **Do not declare the `INTERNET` permission in `AndroidManifest.xml`.** Add a CI test that fails if it appears. No analytics, no crash reporters, no remote fonts, no remote config.
- **Languages:** English and Hindi UI. Student screens are always in Hindi (or the child's school language) even when the teacher uses English.
- **Curricula in the class settings:** NCERT/CBSE, Uttar Pradesh, Rajasthan, or "the school's own". Textbook and outcome data come from `registry.json`.
- **Design principles (from Report 2, kept):** teacher is the only user; one screen, one job; every result explained in plain words and correctable by the teacher; every result ends in an action; offline first.
- **Honesty rule:** when the app is unsure (noisy room, short reading, no comparable earlier check) it says so and shows an empty state, never a made-up number.

## 3. The teacher flow (six stages from Report 2, built per Report 1)

1. **Set up (once):** language, privacy promise, 6-digit passcode, optional fingerprint, create class (grade, section, curriculum, school language), add children (type or import CSV), mark parental consent, try the guided first check.
2. **Today (home):** one big button "Check next child", progress ("21 of 32 checked"), a to-do list of at most 3 lines (rechecks due, practice sheets ready, results waiting for marking), and a suggested number to check today.
3. **Check a child (~4 min):** noise check, child reads (Student Mode), "shabaash" and handback, teacher marks words, retell and questions, dictation (5 items from misread words), listening check only if needed. Pause and resume at any step.
4. **Review:** doubtful words highlighted, teacher corrects any marking, "not sure" never counts as an error, save, one tap to open the next child.
5. **Plan and practice:** plain-words result with group and one next step, decodable practice words, A4 practice sheet to print, 10-minute group plan, weekly class plan.
6. **Track and share:** recheck dates, progress only between comparable checks, early-warning flags, child report, teacher-approved parent report, class and school summary exports.

## 4. Feature specification: all 33 features from Report 2, resolved for an offline app

Phase P1 = must work in the demo build. P2 = pilot. P3 = after. Build P1 first, then P2, then P3. **Every feature below is offline.** "Replaced" means the online behaviour is dropped and the offline replacement is what you build.

### A. Set up and home
| # | Feature | Offline build |
|---|---|---|
| A1 | Teacher sign-in | **Replaced.** No OTP, no account. First run sets a 6-digit passcode (PBKDF2 in Keystore-backed secure storage), back-off after wrong tries, optional fingerprint (P2). Teacher Mode and locked Student Mode as in Report 1. P1 |
| A2 | Class setup and roster | Create class (grade, section, curriculum, school language). Add children by typing or importing a CSV via the system file picker. Each child: first name, initial, home language, consent mark. P1 |
| A3 | Privacy and child safety | Per Report 1 section 6 and the privacy section 10 below. A child cannot be checked until consent is marked. P1 |
| A4 | Multilingual support | English and Hindi via ARB files; Marathi-ready (section 11). Retell and answers in the child's home language accepted. P1 (Marathi P2) |
| A5 | Today screen | As in section 3 stage 2. P1 |
| A6 | Guided first check | Two-minute practice run with a built-in sample child that is never saved to a class. P2 |

### B. Check a child
| # | Feature | Offline build |
|---|---|---|
| B1 | Adaptive passage selection | Rule-based, no AI. First check starts one level below grade; later checks start where the last comparable check ended; the teacher can tap "Try an easier passage" from the marking screen if accuracy is very low. Thresholds in config, labelled provisional. Passages only from `bank.json`. P2 |
| B2 | Voice-guided instructions | Short pre-recorded or on-device TTS prompts (Hindi/English) for each step so the teacher can stay with the child. Use bundled audio first; fall back to Android system TTS only if the voice is installed; text is always shown too. P1 |
| B3 | Classroom noise detection | 3-second ambient-level check before recording; microphone permission asked here, never in front of the child. If too loud, ask the teacher to move; if they continue, mark the result **low confidence**. Threshold in config. P1 |
| B4 | Read-aloud assessment | Child reads, phone records 16 kHz WAV into the encrypted vault, no timer or score on the child's screen. Teacher plays it back and taps each word: correct, read differently, skipped, self-corrected, repeated, not sure. Compute accuracy, correct words per minute, pause-adjusted time. **No auto-marking.** P1 |
| B5 | Retell | Teacher ticks the story points the child retold (for example 5 of 6) from a checklist stored with the passage. Home language accepted. P1 |
| B6 | Dictation and handwriting | Teacher reads 5 items chosen from the words the child misread; teacher marks each in the notebook; optional photo goes to the encrypted photo vault and is deleted on save. **No handwriting recognition.** P1 |
| B7 | Listening check | Only for a child who struggles with both reading and understanding: the teacher reads a short passage aloud, the child retells, the teacher ticks points. Result separates decoding from language. A good listening result moves the child to "Understands, needs help reading words". P2 |
| B8 | Pause and resume | The check is a persisted state machine; killing the app mid-check and reopening resumes at the same step. P1 |
| B9 | One-tap next student | After save, one tap opens the next unchecked child, **never one still waiting for marking** (a bug Report 1 already fixed; keep a regression test). P1 |

### C. Review and results
| # | Feature | Offline build |
|---|---|---|
| C1 | Teacher review and correction | Before saving, "not sure" and low-confidence words are highlighted; teacher can correct a marking, accept a regional pronunciation, or retake a step. Accepted pronunciations are stored on this phone only (replaces F4). P1 |
| C2 | Mistake mapping | Pure-Dart Devanagari akshara segmentation. Each error is classified as consonant, matra (short/long vowel signs), conjunct, halant, bindu/anusvara, chandrabindu, nukta. Output reads "long ee matra", not "word wrong". P1 |
| C3 | Automatic reading group | Four provisional groups (On track; Understands, needs help reading words; Reads words, needs help understanding; Needs help with both). Teacher can move any child with a note; history kept. Group is a suggestion, never a ranking. P1 |

### D. Plan and practice
| # | Feature | Offline build |
|---|---|---|
| D1 | Personalized practice worksheets | One A4 page per child: the child's misread words first, then decodable words, a short passage, a writing task. Printed via Android print. Hindi pages must be drawn with Flutter's text engine (rasterise the widget), because the `pdf` package misprints Hindi conjuncts (Report 1 documents this bug). Only first names on sheets. P1 |
| D2 | Practice material validation | Rule-based checker: every word on a sheet may only use aksharas the child has already read correctly (plus the child's own misread words). A failing item is replaced from the bank before printing. Test: 100% of printed sheets pass. P1 |
| D3 | Weekly class plan | Children with the same practice need are grouped; each group gets a 10-minute activity from `activities.json`; one printed page; teacher ticks done. P2 |
| D4 | Educational resource links | **Replaced.** An offline "Where this comes from" reference list built from `registry.json` sources (document titles, codes, page numbers). No clickable web links, no deep integration. P3 |
| D5 | Progress stars | Teacher-awarded milestone stars (moved up a group, reached the benchmark) printed on that child's own sheet. No class chart, no ranking, no child-facing screen. P3 |

### E. Track the class
| # | Feature | Offline build |
|---|---|---|
| E1 | Teacher dashboard | Checked and waiting counts, group counts, most often misread aksharas (for example conjuncts: 9 children), spelling issues, rechecks due. Empty states instead of made-up numbers. P1 |
| E2 | Progress tracking | Compare only **comparable** checks (same passage family, same curriculum and grade, same language). Show reading, understanding and writing separately. P2 |
| E3 | Early-warning flags | Linear projection of a child's correct-words-per-minute trend towards the benchmark by 31 March; needs at least 2 comparable checks, else show an empty state. Wording is cautious ("may not reach"). P2 |

### F. Share (all offline)
| # | Feature | Offline build |
|---|---|---|
| F1 | Catch-up queue | **Replaced.** Nothing is cloud-processed, so nothing is queued. The only "waiting" state is **"waiting for marking"** (recording saved, teacher has not marked it yet). Recording auto-deletes after 24 h per Report 1, with a reminder before it does. P1 |
| F2 | Cloud backup and restore | **Replaced.** Manual encrypted backup: export one encrypted file (AES-256-GCM, key derived from a backup password the teacher chooses) via the system file picker to SD card or USB; restore on a new phone from the same file. Contains database only, never audio or photos. Android auto-backup stays off. P2 |
| F3 | Fresh passages and updates | **Replaced.** Signed content packs (JSON + checksum) imported from a file. App rejects packs whose checksum or schema version does not match, and marks every new item `pending_teacher_review`. P3 |
| F4 | Regional pronunciation library | **Replaced.** Local table of teacher-accepted pronunciations per child language/region, used by the word-comparison rules on this phone. No sharing. P2 (part of C1) |
| F5 | Parent report and home activity | One page in plain Hindi or English, no scores or rankings, one home activity. Cannot be printed or shared until the teacher ticks an approval box. Shared only through the Android share sheet or print (user-initiated). P2 |
| F6 | Voice-note parent report | **Replaced.** Optional: generate a short audio file with on-device TTS if a Hindi voice is installed; teacher shares the file manually. If no voice, feature hidden. P3 |
| F7 | School-level dashboard | **Replaced.** A "School summary" PDF export: aggregate counts only (checked, groups, common mistakes), per class on this phone, no names, audio or photos. Teachers combine PDFs outside the app. P3 |

Totals: 33 features kept (nothing from Report 2 dropped silently); 10 behave differently because of offline (A1, D4, F1, F2, F3, F4, F6, F7 replaced; B1 and E3 rule-based).

## 5. Technology (Report 1, keep exactly)

| Layer | Choice |
|---|---|
| App | Flutter (latest stable that supports the packages below), Dart 3, Android only |
| State / navigation | Riverpod, go_router with guards for lock state and Student Mode |
| Database | `drift` with SQLite3MultipleCiphers (encrypted), schema versioned with tested migrations |
| Secrets | Random keys in Android Keystore-backed `flutter_secure_storage` |
| Media | `record` (16 kHz WAV), `just_audio`, `image_picker`; AES-256-GCM vaults, one separate key for audio and one for photos |
| Rules engine | Pure Dart package inside the repo (no Flutter imports): akshara segmentation, word comparison, scoring rubric, dictation, groups, practice, decodability, progress comparison |
| Printing | `printing` + `pdf`; pages rendered through Flutter's own text engine as images |
| Content | JSON assets: curriculum registry, benchmark registry, passage bank, activity bank |
| i18n | ARB files, one per language, generated with `flutter gen-l10n`; a test fails if any English key lacks a Hindi value; no em dashes in any user-facing string |

**There is no backend.** The "backend" of this app is the on-device layer described in sections 6 to 8. Do not add Firebase, Supabase or any HTTP client package. If I later want sync, it will be a separate project with a defined interface (section 13).

## 6. Architecture and folder structure

```
lib/
  main.dart
  app/                 # router, theme, app shell, guards (lock, student mode)
  core/
    db/                # drift database, tables, DAOs, migrations
    security/          # key manager, passcode hasher, vaults (audio, photo), purge scheduler
    audio/             # recorder, player, noise meter
    i18n/              # locale controller, ARB files
    print/             # worksheet rendering, A4 layout
    config/            # thresholds.json loader (all tunable numbers live here)
  rules/               # PURE DART: no Flutter imports
    devanagari/        # akshara segmenter, matra/conjunct/halant classifier
    compare/           # word-by-word comparison, accepted pronunciations
    scoring/           # accuracy, correct words per minute, rubric vX
    groups/            # four-group assignment
    dictation/         # item selection from misread words
    practice/          # needs, decodable-word builder, validator
    progress/          # comparable-check logic, early warning projection
  features/
    setup/  today/  class_roster/  check/  student_mode/  marking/
    result/  practice/  reports/  settings/  privacy/
  content/             # repositories reading the JSON assets
assets/ passages/ curriculum/ practice/ fonts/ audio_prompts/
test/  (mirrors lib/, plus integration_test/)
docs/  CHECKPOINT.md  DECISIONS.md  BENCHMARKS.md  CURRICULUM_SOURCE_REGISTER.md  PRIVACY_CHECKLIST.md  TEST_RESULTS/  UI_REVIEWS/
```

Rule: `rules/` never imports Flutter, drift or any plugin, so it can be unit-tested fast and reused. UI calls repositories; repositories call DAOs and `rules/`.

## 7. Database design (encrypted drift / SQLite)

Use integer primary keys, UUID `public_id` where needed, UTC epoch milliseconds for time, soft delete only where noted. All tables live in one encrypted file; the key is generated on first run and stored in Keystore-backed secure storage. Create indexes on every foreign key and on `(child_id, started_at)`.

| Table | Key columns |
|---|---|
| `app_settings` | key, value (language, curriculum default, text scale, fingerprint on/off, theme) |
| `classes` | id, name (for example "3B"), grade 1..5, section, curriculum (ncert_cbse / up / rajasthan / school_own), school_language, academic_year, created_at |
| `children` | id, class_id, first_name, last_initial, home_language, created_at, deleted_at |
| `consents` | id, child_id, status (given / withdrawn), recorded_at, note, recorded_by_teacher |
| `checks` | id, child_id, passage_id, started_at, finished_at, state (state machine value for pause/resume), step, noise_level, low_confidence (bool), rubric_version, benchmark_id, benchmark_source_label |
| `word_marks` | id, check_id, word_index, expected_text, mark (correct / read_differently / skipped / self_corrected / repeated / not_sure), error_kind (from mapping, nullable), teacher_note, corrected_by_teacher (bool) |
| `retell_points` | id, check_id, point_index, ticked (bool) |
| `question_answers` | id, check_id, question_id, question_type (fact / word_meaning / why_how / main_idea), result (correct / partly / incorrect / not_asked), answer_language |
| `dictation_items` | id, check_id, item_text, source_word_mark_id, result (correct / error / not_sure), error_kind, photo_vault_id (nullable) |
| `listening_checks` | id, child_id, check_id (nullable), passage_id, points_ticked, points_total, created_at |
| `results` | id, check_id, correct_wpm, accuracy_pct, understanding_points, understanding_total, writing_summary, plain_words_summary_key, suggested_group |
| `group_assignments` | id, child_id, group_code, source (suggested / teacher_moved), note, assigned_at (history is append-only) |
| `practice_needs` | id, child_id, check_id, need_code (matra, conjunct, bindu, word_reading, fluency, facts, why_how, word_meaning, spelling, listening), detail |
| `practice_items_printed` | id, child_id, printed_at, content_hash, validator_passed (bool) |
| `weekly_plan_ticks` | id, class_id, week_start, group_code, activity_id, done |
| `parent_reports` | id, child_id, generated_at, language, approved_by_teacher (bool), approved_at |
| `accepted_pronunciations` | id, language_or_region, expected_word, accepted_variant, created_at |
| `milestone_stars` | id, child_id, kind, awarded_at |
| `media_index` | id, kind (audio / photo), vault_path, check_id, created_at, expires_at (audio 24 h, photo 7 days), deleted_at |
| `audit_events` | id, event (consent_marked, record_deleted, export_done, lock_failed ...), at, **no child names or content** |

Required behaviours:
- **Migrations:** every schema bump has a migration and a test that upgrades a v(N-1) fixture database.
- **Demo class:** seed "3B" with 10 fictional children on first run only, clearly labelled DEMO; a real class never mixes with it, and demo data can be deleted in one tap.
- **Deletion:** deleting a child removes all rows and vault files for that child in one transaction and writes an `audit_events` row without the name. Withdrawing consent blocks new checks and offers deletion.
- **Purge scheduler:** on app start and daily while open, delete expired vault files and null `media_index`. Marks saved => delete audio immediately.
- **Export/restore:** F2 export contains DB rows only, encrypted with the teacher's backup password.

## 8. The rules engine (pure Dart, heavily tested)

1. **Akshara segmenter:** split Devanagari words into aksharas (consonant + halant + consonant clusters, vowel signs, bindu, visarga, nukta). Golden tests with at least 100 words covering every class of conjunct and matra. Never treat a cluster as separate letters.
2. **Word comparison:** given expected and marked-as-different text (teacher types or picks what the child said), classify the difference (matra short/long, conjunct reduction, halant dropped, bindu missing, vowel swap). Respect `accepted_pronunciations`.
3. **Scoring (rubric v0.1, provisional):**
   - correct words = correct + self_corrected; repeated is neutral; `not_sure` is **excluded from errors and from attempted words**.
   - accuracy = correct words / attempted words; correct words per minute = correct words / minutes read, where minutes come from the recorded audio length minus teacher-trimmed lead-in (Report 1 limitation: the timer starts when the passage appears, so cap the time at the audio duration and ignore taps before the first spoken word).
   - Every threshold is read from `thresholds.json` and carries `status: provisional` until a teacher calibrates it in a pilot.
4. **Benchmark display:** target comes from `benchmarks.json` by (curriculum, grade, language, skill) and is shown with its source label. For Classes 1, 4, 5 (no official number) show "No official number; compared with the child's own earlier checks". The NIPUN example-story conflict (30 to 35 vs 45 to 60 for Class 2) is resolved in favour of the target table.
5. **Group assignment:** decoding adequate/not (accuracy and words per minute vs the grade benchmark) crossed with understanding adequate/not (for Class 3, 3 of 4 questions from NIPUN; otherwise the config threshold). Output one of four groups, plus the reason in one plain sentence. A listening check that shows understanding moves "Needs help with both" to "Understands, needs help reading words".
6. **Dictation selection:** pick 5 items from the child's misread words, prioritising different error kinds; fall back to bank words if fewer than 5.
7. **Practice needs and decodable words:** map evidence to need codes; the decodable-word builder emits only words whose aksharas are all in the child's "read correctly" set, plus the child's own misread words first.
8. **Practice validator (D2):** re-run the decodability rule on the final sheet content; fail closed.
9. **Progress comparison (E2) and early warning (E3):** only across comparable checks; empty state otherwise.
10. Every function has table-driven unit tests; the engine has at least 90% line coverage.

## 9. Screens and UI (copy the look and feel of the APK, not Report 2's wireframes)

**Visual language (from the APK screenshots; sample exact values from `docs/source` screenshots):**
- Warm off-white background (approx. `#FBF9F5`), white cards with large rounded corners (about 24 dp), deep navy text (approx. `#13294B`), forest-green primary buttons (approx. `#27775A`) with white bold text, pale mint (`#E7F4EC`) for avatars and selected states, amber chips (pale yellow fill, dark brown text) for groups that need help, green chip for "On track", soft red dot for "recording".
- Fonts: **Inter** (Regular/Medium/SemiBold/Bold/ExtraBold) for English, **Noto Sans Devanagari** (Regular/Medium/SemiBold/Bold) for Hindi. Student passages use very large Devanagari type with generous line height and are scrollable above a pinned large button.
- Mascot **Kiran** (a friendly sun) appears only on child-facing screens, with one short spoken-and-written instruction in Hindi.
- Bottom navigation with exactly four tabs and icons: **Today, Class, Practice, Reports**. Selected tab has a pill-shaped mint highlight. Settings sit behind the gear icon at the top right of the screen (not a fifth tab).
- Child list rows: round mint avatar with the first letter, child name with last initial, status line ("Checked" / "Not checked yet"), and a group chip.
- Group filter chips at the top of Class ("Reads words, needs help understanding · 1", "Not grouped yet · 8") with the helper line "Groups are suggestions from the latest check. You can move any child."
- Buttons are large (min 56 dp height) for use while standing; Student Mode has a small lock icon labelled "शिक्षक" (Teacher) at the top right that asks for the passcode.
- Text scales with the system font size up to 200% without clipping; every screen has a TalkBack label; contrast at least WCAG AA.

**Screens to build (one job each):**
1. Welcome and language, 2. Privacy promise (Hindi and English), 3. Passcode set/enter (with back-off), 4. Class setup, 5. Roster (add, import CSV, consent toggles), 6. **Today**, 7. **Class** (groups, rows, filters), 8. Child profile (history, start a check, move group, delete), 9. Pre-check "Before handing over" (noise check, mic permission, handback instruction), 10. Student Mode: greeting, read aloud, "मैंने पढ़ लिया" (I have read), "शाबाश!" and handback, 11. Teacher passcode to leave Student Mode, 12. Marking: play recording, tap each word through the six marks, "not sure" never red, 13. Retell checklist, 14. Typed questions with marks, 15. Dictation (5 items, optional photo), 16. Listening check (conditional), 17. **Result in plain words**: leads with group name and one next step; reading and understanding shown separately with the official target and its source; details behind a "details" tap; "Something wrong? Correct a marking", 18. Class milestones page (official targets by class), 19. **Practice** tab (group plans, decodable words, print sheet, weekly plan), 20. **Reports** tab (child report, parent report with approval box, class dashboard, progress, School summary export), 21. Settings (language, passcode change, fingerprint, backup export/restore, text size, delete data, about and sources), 22. Privacy and consent centre (consent list, withdrawal, deletion, DPDP checklist status).

**Copy rules:** same words everywhere ("group", "practice sheet", "recheck"); plain words before numbers; no red marks, rankings or scores on any child-facing screen; every English string has a Hindi twin; no em dashes in user-facing text.

## 10. Privacy, security and compliance (Report 1 is authoritative)

- Consent must be marked before a child can be checked; the app records the mark and the date, and leaves the school process to the school.
- Audio: encrypted vault, deleted when marks are saved, hard-deleted after 24 h regardless. Photo: separate vault key, deleted on save, hard-deleted after 7 days. Both never leave the phone and never go into the database.
- Android auto-backup off (`android:allowBackup="false"`, `fullBackupContent` disabled). `FLAG_SECURE` on student and result screens so screenshots and recents thumbnails are blocked. No logging of names or content, even in debug builds.
- Only first names and last initial appear on printed sheets and reports.
- Passcode: PBKDF2 hash, never stored in plain text, exponential back-off, auto-lock after 2 minutes idle in Teacher Mode, Student Mode cannot be escaped without the passcode (keep Report 1's escape-attempt tests).
- Real children's data is blocked by design until `docs/PRIVACY_CHECKLIST.md` is signed off by a qualified person. Build a visible switch: **"Demo mode" (default, fictional class only)** versus **"Real class mode"**, which can be enabled only after the teacher confirms the checklist, and shows a persistent banner if the legal review flag is still off.
- Under the DPDP Rules 2025, parental verifiable consent applies to children's data unless an exemption (for example for education) applies. **Do not claim legal compliance anywhere in the app.** Say "designed for DPDP; legal review pending" until a reviewer confirms. Reference documents are in Report 1 section 3.1 (PIB backgrounder on DPDP Rules 2025; gazette text to be read by a legal reviewer).
- Government documents used for syllabus and targets, which you must use only through `registry.json` and `benchmarks.json`: NCERT FLS 2022 benchmarking report; NIPUN Bharat Guidelines 2021; NCERT Learning Outcomes at the Foundational Stage (2025) and Elementary Stage (2017); NCF-FS 2022 and NCF-SE 2023; Basic Shiksha UP NIPUN tables and UP Class 3 teacher guide 2025-26; RSCERT Udaipur Hindi teacher guides (2025); NCERT textbook list 2025 and contents pages; CBSE circulars Acad-73/2024, 12/2025, 48/2025; NCERT NEP Mandate document. NCERT textbook text must **never** be copied into the app; only titles, codes and page numbers.
- Known gaps you must keep visible in the app and docs: UP Hindi books for Classes 1, 2, 4, 5 unverified; passages and activities need teacher review (`review_status: pending_teacher_review` is shown as a small "Pending review" tag until a teacher approves); rubric v0.1 provisional.

## 11. Content and language packs

- Use the bundled `bank.json` (nine original passages and word/sentence lists, each with outcome codes, skills and retell points) and `activities.json` (14 original activities in English and Hindi). Add new passages only as original text, in the same schema, with `review_status: pending_teacher_review`, and write word-count and decodability tests.
- Add at least two original passages per class (1 to 5) so every class can complete a check; Class 1 uses word lists and short sentences (4 to 5 simple words), per NIPUN.
- **Marathi (P2):** do not translate by guess. Build the language-pack mechanism now (UI ARB file, student prompts, practice templates, Devanagari rules shared with Hindi), add a Marathi-specific akshara test set, and mark Marathi content `pending_teacher_review`. A Maharashtra curriculum registry (for example Balbharati) needs official sources read and cited first; until then Marathi class setup uses "the school's own" curriculum.

## 12. Testing and quality gates

- Unit tests for every module in `rules/`; table-driven; Devanagari golden tests.
- Repository and DB tests: encryption on disk (the file is unreadable without the key), vault tests (ciphertext on disk, plaintext gone after save), migration tests, deletion tests.
- Widget tests: onboarding, lock back-off, Student Mode escape attempts, full check end to end, dictation, listening check, group move with note, class settings, milestones, parent report approval gate, next-child skips unmarked children.
- Static gates: `flutter analyze` clean; test that `AndroidManifest.xml` has no INTERNET permission; test that every English ARB key has a Hindi value and no em dashes; test that no `http` client package is in `pubspec.lock`.
- Performance: cold start under 3 s and a full check without jank on a 2 to 3 GB RAM profile; APK size reported; release build with R8 shrink.
- Accessibility: 200% text, TalkBack labels, contrast checks.
- Targets from Report 2 to measure in the pilot: teacher agreement with the app's analysis at least 90%; time to check one child under 5 minutes; 100% of printed practice sheets pass the decodability validator; no audio or photo leaves the phone; runs on 2 to 3 GB RAM; a new teacher completes the first check unaided within 10 minutes (to be validated); no checks lost on app kill or restart.

## 13. Future-proofing (design now, build never in this project)

Define repository interfaces (`ResultsRepository`, `RosterRepository`, `ContentRepository`) so an optional sync backend could be added later without touching the UI. Any cloud AI would only ever be called through such a backend, never with a key inside the app. Do not implement it.

## 14. Milestones (follow in order; report status in `docs/CHECKPOINT.md`)

| M | Scope | Done when |
|---|---|---|
| M0 | Audit existing repo if any; create or verify project, CI script, asset import from the APK, `thresholds.json`, docs skeleton | App builds and runs; manifest test passes |
| M1 | Theme, fonts, English/Hindi i18n, onboarding, privacy promise, passcode, app shell with four tabs | Screens match the APK style |
| M2 | Encrypted DB, key manager, vaults, purge scheduler, demo class, roster, CSV import, consent, Student Mode lock | Encryption and deletion tests pass |
| M3 | Curriculum registry, class settings, milestones page, benchmarks, akshara engine, passage selection (B1 rule-based) | Golden tests pass |
| M4 | Full reading check: noise (B3), voice prompts (B2), Student Mode, recording, word marking (B4), retell (B5), questions, pause/resume (B8), result in plain words | End-to-end widget test passes |
| M5 | Mistake mapping (C2), review and correction with accepted pronunciations (C1), dictation and photo (B6), listening check (B7), groups (C3), next-child (B9) | Group history and next-child tests pass |
| M6 | Practice engine and validator (D1, D2), worksheets and printing, group plans, weekly plan (D3), Today screen (A5), teacher dashboard (E1), guided first check (A6) | 100% of sheets pass validator; Hindi print is correct |
| M7 | Reports: child report, parent report with approval gate (F5), progress (E2), early warning (E3), stars (D5), reference list (D4), School summary PDF (F7), voice note if TTS available (F6) | Report tests pass |
| M8 | Privacy centre, consent withdrawal, deletion, encrypted export/restore (F2), content-pack import (F3), fingerprint unlock, Demo/Real mode switch and PRIVACY_CHECKLIST.md | Restore on a clean install works |
| M9 | Performance, accessibility, low-RAM profile, regression tests, TEST_RESULTS | All gates in section 12 green |
| M10 | Release build signed with the team's own key (kept outside the repo), release notes, install guide, completion report | Signed APK installs on a physical Android phone |

## 15. Deliverables

1. The complete Flutter project, building with `flutter build apk --release`.
2. All docs listed in section 6 kept current.
3. A short `README.md`: how to run, test, build, where thresholds live, how to import a content pack, how to enable Real class mode.
4. A final `docs/COMPLETION_REPORT.md` listing each of the 33 features with its status (done / replaced offline / deferred) and the evidence (test name or screenshot).

## 16. Start now

Begin with M0. First reply with: (a) what you found in the repo and assets, (b) any conflicts or gaps you see in this prompt, (c) the exact plan for M0 and M1. Then execute M0 and M1 without waiting, and continue milestone by milestone, stopping only for the blockers described in section 0.

# END PROMPT
