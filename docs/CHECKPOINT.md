# SAMAJH CHECKPOINT LOG

This document tracks progress milestone by milestone across the Samajh build.

## Milestone M0: Project Audit, Environment, Assets & CI Gates
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Audited repository: Initialized Flutter project with package name `in.ac.vit.runtimeterrors.samajh`.
  - Removed desktop `windows` plugin directory to maintain Android-only focus.
  - Removed all `INTERNET` permissions from `android/app/src/main/AndroidManifest.xml`, `debug/AndroidManifest.xml`, and `profile/AndroidManifest.xml`.
  - Configured `android:allowBackup="false"` and `android:fullBackupContent="false"`. Set `minSdk = 26` (Android 8.0).
  - Downloaded and bundled 9 offline Google Font TTF files (5 weights for Inter, 4 weights for Noto Sans Devanagari) under `assets/fonts/`.
  - Authored and verified bundled JSON content assets: `bank.json` (10 original passages covering Classes 1 to 5), `registry.json` (74 outcomes, 4 curricula, 9 textbooks), `benchmarks.json` (official targets from NIPUN, FLS 2022, NCERT), `activities.json` (14 original group/home activities), and `thresholds.json` (provisional config).
  - Configured project dependencies (`flutter_riverpod`, `go_router`, `drift`, `sqlite3_flutter_libs`, `cryptography`, `flutter_secure_storage`, `record`, `just_audio`, `printing`, `pdf`).
  - Added CI tests: `test/manifest_test.dart` and `test/arb_lint_test.dart`.
- **What is next:**
  - Milestone M1: Theme, typography, English/Hindi ARB localization, Onboarding screens, Privacy Promise, 6-digit Passcode with PBKDF2 & exponential back-off, 4-tab App Shell with Kiran mascot.
- **Open questions:** None blocking.

---

## Milestone M1: Theme, Fonts, English/Hindi i18n, Onboarding, Passcode & App Shell
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Implemented Design System & Theme (`lib/app/theme.dart`): Warm off-white background (`#FBF9F5`), white cards (24dp radius), deep navy text (`#13294B`), forest green primary buttons (`#27775A`, min 56dp height), pale mint accents (`#E7F4EC`), and amber chip styling for support groups.
  - Implemented Localization (`lib/core/i18n/`): Configured `l10n.yaml`, authored comprehensive `app_en.arb` and `app_hi.arb` (100% Hindi paired coverage, zero em dashes), generated type-safe localizations, and created dynamic `localeProvider`.
  - Built Mascot Kiran (`lib/features/student_mode/kiran_mascot.dart`): Friendly sun mascot with custom vector painting, smiling facial features, ray animation, and speech bubble for student screens.
  - Built Passcode Service (`lib/core/security/passcode_service.dart`): 6-digit passcode with PBKDF2 hashing, failed attempt tracking, and exponential back-off lockout timer.
  - Built Onboarding Flow:
    - Welcome Screen (`welcome_screen.dart`): Bilingual language selection and start.
    - Privacy Promise Screen (`privacy_promise_screen.dart`): 4 core offline commitments.
    - Passcode Setup Screen (`passcode_setup_screen.dart`): 6-digit keypad, PIN dots, and confirmation.
    - Class Setup Screen (`class_setup_screen.dart`): Grade 1-5 selector, section name, curriculum picker (NCERT/CBSE, UP, Rajasthan, School's own), and language settings.
  - Built 4-Tab App Shell (`lib/app/app_shell.dart`): Navigation bar with pill-shaped mint indicators for **Today, Class, Practice, Reports**, plus Mode banner (Demo Mode default vs Real Mode).
  - Built Screen shells: `TodayScreen` (progress bar, hero check button, 3-line todo list), `ClassScreen` (support group filter chips, 10 demo learners), `PracticeTab` (10-minute group plans), `ReportsTab` (class metrics and parent report approval gate), `SettingsScreen` (mode toggle and language controls), and `MilestonesPage` (official government targets).
  - All 16 automated tests passing (`manifest_test.dart`, `assets_integrity_test.dart`, `arb_lint_test.dart`, `onboarding_navigation_test.dart`, `widget_test.dart`).
  - Static analysis clean: `flutter analyze` 0 warnings, 0 errors.
- **What is next:**
  - Milestone M2: Encrypted Database (drift + SQLite3MultipleCiphers), key manager, vaults (audio, photo), purge scheduler, demo class seed, roster management, CSV import, consent tracking, and Student Mode lock guard.
- **Open questions:** None blocking.

---

## Milestone M2: Encrypted Database, Scopes, Roster & Milestones
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Database schema & Drift setup (`lib/core/database/tables.dart`, `app_database.dart`): 18 encrypted tables covering app settings, classes, children, consents, checks, word marks, retell points, question answers, dictation items, listening checks, results, group assignments, practice needs, weekly plan ticks, parent reports, accepted pronunciations, media index, and audit events.
  - Automatic demo class seed: Class 3B · Uttar Pradesh · Hindi with 10 fictional learners, all unchecked with consent marked.
  - Riverpod single source of truth data streams (`lib/core/providers/database_provider.dart`): `rosterStreamProvider`, `consentsStreamProvider`, `activeClassStreamProvider`, `resultsStreamProvider`, `todayStatsProvider`.
  - Class Screen (`lib/features/class_roster/class_screen.dart`): Support groups row with counts ("All", "Not grouped yet", "On track", "Understands, needs help reading words", "Reads words, needs help understanding", "Needs help with both"), child cards with status lines and group chips.
  - Child Profile (`child_profile_screen.dart`): Details, consent toggle, latest check results in plain words, move to group dialog with persistent history, delete child permanently.
  - Add Child Dialog (`add_child_dialog.dart`): Add child form with consent requirement explanation and validation.
  - Class Settings (`class_settings_screen.dart`): Curriculum, grade 1-5, check language, medium of instruction, verified textbook card from `registry.json`.
  - Class Milestones (`milestones_page.dart`): Official NIPUN Lakshya (at least 60 wpm for Class 3) and FLS 2022 (meets band: 35-54 wpm) benchmarks, outcome chips with official codes.
- **What is next:**
  - Milestone M3: Continuous check flow, noise test, Student Mode lock, 7-mark scoring, Devanagari Akshara engine, retelling, questions, dictation, and plain-words result.

---

## Milestone M3: Continuous Resumable Check Flow & Linguistic Engine
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Linguistic Analysis Engine (`lib/core/analysis/devanagari_engine.dart`): Phonetic classifier identifying short matras, long matras, conjuncts/halant, bindu/anusvara, chandrabindu, and nukta.
  - Check Flow Controller (`check_flow_controller.dart`): State machine managing 8 check steps (Handover, Student Mode reading, Shabaash, Word marking, Retelling, Comprehension questions, Dictation, Result).
  - Noise testing: 3-second ambient noise test; high noise flags result as low confidence without blocking teacher.
  - Student Mode Child-Facing Screen: Passcode-locked fullscreen reading interface with Kiran mascot, large Devanagari text, single "मैंने पढ़ लिया" button, zero scores/timers/red marks.
  - Mark Reading Screen: Audio playback controls (0.75x / 1.0x, seek slider), 7 word mark states (Correct, Read as another word, Skipped, Corrected self, Repeated, Not sure, Not reached), mistake mapping to Devanagari features.
  - Retelling & Comprehension: Story point checkboxes, 4 question types (Fact, Cause/effect, Word meaning, Why/how).
  - Dictation: 5 items selected from child's misread words; skipped option.
  - Plain-Words Result Card: Group assigned with one next step, reading speed/accuracy with official UP NIPUN & FLS 2022 comparisons, understanding breakdown, writing errors, and "Something wrong? Correct a marking" link.
  - Scoring Guardrails (Section 8.9): Reading time < 15s or > 250 wpm suppresses speed and triggers "Not enough evidence: teacher review needed".

---

## Milestone M4: Practice Sheets, 10-Minute Group Plans & Reports
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Practice Tab (`lib/features/practice/practice_tab.dart`):
    - Practice sheets list for children with results; printable A4 preview using native text rendering for perfect Devanagari conjuncts.
    - 10-minute group plans with 4 actionable steps, home activity lines, and weekly checkboxes.
    - Offline official resources mapping curriculum codes to learning outcomes.
  - Reports Tab (`lib/features/reports/reports_tab.dart`):
    - Class reading health metrics (Checked, On track, Needs help) reading live from database.
    - Aggregated akshara error frequencies and spelling issues.
    - Parent Report with teacher approval checkbox gate ("I have read this and approve it") before printing/sharing.
    - Anonymous school summary PDF export with aggregate counts only.

---

## Milestone M5: Offline Encrypted Backup, Privacy & Consent Centre
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - Privacy Checklist Gate (`privacy_checklist_screen.dart`): 4-point privacy checklist required to enable Real mode; logs audit event.
  - Privacy & Consent Centre (`privacy_center_screen.dart`):
    - DPDP status indicator ("Designed for DPDP; legal review pending" / "Reviewed by <name>").
    - Retention rules display (audio auto-purged on mark save / max 24h, photos max 7d).
    - Child consent management table with deletion action.
    - Delete All Data danger zone requiring typing "DELETE" to confirm.
  - Offline Backup & Restore (`backup_restore_screen.dart`):
    - Export database records with AES-256 password encryption.
    - Class restore workflow.
  - About & Official Sources (`about_screen.dart`): Official citations for NCERT FLS 2022, UP NIPUN Lakshya, NCF-FS, and bundled offline registries.
  - Settings Screen (`settings_screen.dart`): App Language & Reading Language dual segmented controls, Demo/Real mode switch, Reset demo class action, cadence settings (suggested window, recheck period).

---

## Milestone M6: Automated Test Verification & Release Build
- **Status:** Complete
- **Date:** 2026-10-25
- **What is done:**
  - 80 automated unit, widget, and layout tests passing (`flutter test` 100% pass):
    - `layout_robustness_test.dart`: 54 combinations (320, 360, 411 dp × scales 1.0, 1.3, 2.0 in en & hi).
    - `scoring_guardrails_test.dart`: Speed suppression for <15s & >250 wpm, linguistic classification.
    - `mode_scope_test.dart`: Complete database isolation between Demo and Real scopes.
    - `strings_lint_test.dart`: Zero unfinished strings, zero em dashes.
    - `arb_lint_test.dart`: 100% Hindi/English paired coverage.
    - `manifest_test.dart`: Strict offline verification (no INTERNET permission).
  - Zero static analysis issues (`flutter analyze`: No issues found).
  - Generated release APK (`flutter build apk --release`).

---

## Milestone M7: Supabase Cloud Sync Preparation & Zero-OCR Pipeline
- **Status:** Complete (Ready for user Supabase credentials)
- **Date:** 2026-10-28
- **What is done:**
  - Zero-OCR architecture enforced across project:
    - Removed camera photo capture and OCR dependencies; strictly zero image uploads.
    - Added student typing for spell-checks and picture-based MCQ options for line-alignment/letter formation.
    - Added thumbs up / thumbs down student self-rating tracking to checks and results.
    - Segregated questions level-wise with discontinuation rule (no advancement to level 2 if level 1 is missed).
    - Integrated weighted marking scheme with question level weightage and time-decay adjustments.
  - Updated reference documents and database schema:
    - [Samajh_Database_Connection_Prompt.md](file:///d:/PROJECTS/SRushtiiiiiiiiiiiiiiiiiiiiiiii/Samajh_Database_Connection_Prompt.md) updated with zero-OCR and self-rating rules.
    - [samajh_supabase_schema.sql](file:///d:/PROJECTS/SRushtiiiiiiiiiiiiiiiiiiiiiiii/samajh_supabase_schema.sql) updated with `student_self_rating` and tiered `question_answers` constraints.
    - [Samajh_Database_Guide.md](file:///d:/PROJECTS/SRushtiiiiiiiiiiiiiiiiiiiiiiii/Samajh_Database_Guide.md) updated with matching specifications.
  - Supabase connectivity layer configured:
    - Added `supabase_flutter: ^2.8.4` and `flutter_dotenv: ^5.2.1` to `pubspec.yaml`.
    - Bundled `.env` asset in `pubspec.yaml` and created root `.env` template.
    - Added `android.permission.INTERNET` to `android/app/src/main/AndroidManifest.xml`.
    - Created `CloudSync` interface, `NoopCloudSync`, and `SupabaseCloudSync` in `lib/core/sync/`.
    - Implemented Riverpod providers in `lib/core/sync/sync_providers.dart` with safe fallback to `NoopCloudSync` when uninitialized.
    - Updated `lib/main.dart` with resilient Supabase initialization supporting both `SUPABASE_PUBLISHABLE_KEY` and `SUPABASE_ANON_KEY`.
## Milestone M8: Child-Facing Word Check, Devanagari Regional Pronunciation & Drift v5
- **Status:** Complete
- **Date:** 2026-10-28
- **What is done:**
  - **Child-Facing Word Check in Student Mode:**
    - Eliminated teacher dictation marking screen and replaced it with child-facing Word Check immediately following reading passage completion.
    - Built `NotebookLineWordPainter` CustomPainter rendering Devanagari handwriting position on ruled notebook lines (correct hanging, floating above, sinking below, crossing line) without image assets.
    - Shuffled 4 visual options per item with randomized correct positions, audio prompt cues ("Play cue"), and "Not sure" neutral option.
    - Protected teacher exit with PIN passcode verification modal sheet.
  - **Multi-Level Progression & Weighted Marking (Teacher-Only View):**
    - Configured L1-L4 levels in `assets/config/thresholds.json` (marked provisional) with grade-level entry and quiet stop after 2 consecutive failed levels.
    - Implemented `WordCheckScoringEngine`: captures `first_choice`, `final_choice`, `time_to_first_tap_ms`, `change_count`, `distractor_tag`, `weight`, and `reason`.
    - Applied weighted marking constants: 1.0 first try, 0.75 wrong-to-right, 0.0 right-to-wrong, x0.5 for 3+ changes, x0.85 for >2x expected time (floor 0.5), fast tap (<1s) guess flag, and neutral skips.
    - Displayed raw count, weighted score, explanatory reasons, and top 3 common mistake tags on Result screen, Child Profile, Class screen, and practice engine recommendations.
  - **Devanagari Regional Pronunciation & Dialects:**
    - Created `assets/curriculum/regional_variants.json` with 4 regions (Awadhi/Bhojpuri, Rajasthani, Marathi-influenced, Punjabi-influenced) marked "needs linguist/teacher verification".
    - Updated `DevanagariAksharaEngine` with `loadRegionalVariantsJson`, region-specific `getRegionalVariants`, symmetric `isRegionalVariant`, and distractor validity filter (`isValidDistractor`).
    - Added `homeDialect` dropdown setting to Class Settings and Add Child Dialog; accepted regional variants count fully correct without error tags.
  - **Item Bank & Genuine Understanding:**
    - Created `assets/practice/word_check_bank.json` with 48 original items (6 items per level for Hindi and English) covering sound recognition, spelling, writing position, fill-the-blank, odd-one-out, sentence match, and inference.
  - **Database Migration v4 to v5:**
    - Added `ChoiceResponsesTable` (13 fields) and `homeDialect` columns to `ClassesTable` and `ChildrenTable` in `tables.dart`.
    - Bumped schema version to 5 and updated Supabase sync mapping.
  - **Verification, Quality & Automated Testing:**
    - Full static analysis clean: `flutter analyze` 0 warnings, 0 errors.
    - Automated unit, widget, and migration test suite: 134 tests passing (`flutter test` 100% pass).
    - Fully bilingual (Hindi + English) with zero em dashes in user text.

## Milestone M9: Typing Check, Letter-Formation Pictures, Self-Rating and Level-Wise Weighted Marks

- **Status:** Built and tested on the branch `feature/typing-levels-self-rating`; not yet tried by teachers.
- **Date:** 2026-10-30
- **Correction to M8:** M8 above says the check starts at the class grade, stops after 2 failed levels, and lowers slow answers by x0.85. That is now replaced (see D021, D022).
- **What is done:**
  - **Typing check (no OCR):** new child step after the word check. The phone says the word (offline text-to-speech; if the phone has no Hindi or English voice, the teacher presses and holds to see the word and says it). The child types on a big on-screen keypad (Hindi vowels, consonants, matras, bindu, chandrabindu, halant, nukta; or English letters). Mistakes are named: half letter dropped, short/long matra, wrong matra, bindu, nukta, look-alike letter, missing, extra or wrong letter. Three levels, 3 words each, from `assets/practice/typing_bank.json` (original lists, awaiting teacher review).
  - **Picture questions for letter formation:** 8 new Level 3 items (4 Hindi, 4 English). Four drawings of one word: one written well, the others with no शिरोरेखा, letters spread apart, uneven letters, or (English) a back-to-front b/d/p/q. English words now sit on the line. Every word check level includes a picture writing item when the bank has one.
  - **Thumbs up / down:** after reading aloud (own screen), after every word check item and typed word (Next waits for a rating), and for each teacher question (the teacher shows the phone to the child). The result screen shows the child's ratings beside the real results.
  - **Levels:** word check, typing and teacher questions all start at Level 1 and stop at the first level not passed. Teacher questions are grouped by level (fact, word meaning, why/how, main idea); higher levels appear only after the level below is passed. The old default of "correct" for every question is removed.
  - **Weighted marks:** level weight x answer credit x time factor (provisional, `thresholds.json` 0.3.0). Each question has a running timer from the moment it can be asked.
  - **Database v7:** reading self-rating on checks; level, time, marks, max marks and self-rating on question answers; max marks and self-rating on choice responses (typed words stored as `typed_spelling`); typing score and rating summary on results. Real upgrade test from v6.
  - **Sync:** `student_self_rating` now sends the child's real reading rating instead of always `not_recorded`.
- **Verification:** `flutter analyze` (only the 2 old missing-asset-folder warnings); `flutter test` all passing, including new tests for level gating, typing, ratings, the v6 to v7 upgrade, saved fields, and child screens at 320 dp.
- **Not done yet:** no emulator run or teacher trial of these screens; word lists and thresholds are provisional; text-to-speech depends on a Hindi voice being installed on the phone.
