<p align="center"><img src="docs/brand/Samajh_logo_mark_1024.png" alt="Samajh logo" width="140"></p>

# Samajh (समझ)

An offline Android app that helps Class 1 to 5 teachers in India check whether a child **understands** what they read, not just how fast they read, and then tells the teacher what to teach next. English (default) and Hindi. NCERT/CBSE, Uttar Pradesh and Rajasthan curricula.

## What it does

- **Student Mode:** the child reads a short passage aloud on the teacher's phone, locked behind the teacher's passcode.
- **Automatic marking on the phone:** offline Vosk speech models (Hindi and English) mark every word. The teacher only rechecks the words the app was unsure about. Audio never leaves the phone.
- **Word check and typing:** picture, spelling, writing and meaning questions, plus typed words, in levels. Every child starts at Level 1 and moves up only by passing.
- **NCERT-aligned Hindi for Classes 1–3:** each item is tagged with the NCERT outcome it checks. See [docs/CURRICULUM_ALIGNMENT_HINDI_G1_3.md](docs/CURRICULUM_ALIGNMENT_HINDI_G1_3.md).
- **Results the teacher can act on:** a support group, one next teaching step, reading accuracy and speed against NIPUN Bharat and NCERT FLS 2022 targets, and the child's top mistakes.
- **Teacher tools:** 10-minute group plans, printable practice sheets, parent reports, class summaries and a teacher profile.

## AI models and external services

The app calls **no external AI service or API**, and needs **no AI keys**. All AI runs on the phone.

| What | Used for | Where it runs | Key needed? |
|---|---|---|---|
| [Vosk](https://alphacephei.com/vosk/) speech recognition (`com.alphacephei:vosk-android:0.3.47`), model `vosk-model-small-hi-0.22` (Hindi) | Turns the child's reading recording into words, which are then matched against the passage to mark each word | On the phone, offline. Model bundled in `assets/models/` | No |
| Vosk model `vosk-model-small-en-us-0.15` (English) | Same, for English passages | On the phone, offline. Model bundled in `assets/models/` | No |
| Android text-to-speech (the phone's own engine, via `flutter_tts`) | Says words aloud in the word check and typing check | On the phone (part of Android, not shipped by us) | No |

Code: [lib/core/speech/reading_recognizer.dart](lib/core/speech/reading_recognizer.dart) (Flutter side), [MainActivity.kt](android/app/src/main/kotlin/in/ac/vit/runtimeterrors/samajh/MainActivity.kt) (runs Vosk), [lib/core/speech/reading_alignment.dart](lib/core/speech/reading_alignment.dart) (matches heard words to the passage).

Everything else (scores, support groups, next steps, practice plans) is plain rules based on NCERT, NIPUN Bharat and FLS 2022, so every result can be explained. No large language model is used.

**The only service that takes keys** is the optional cloud backup (Supabase, not AI). It is off unless `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` are set in `.env`. Without them the app runs fully offline.

## Run locally

Requirements: Flutter 3.x (Dart 3), Android SDK, JDK 21, and an Android phone (Android 8+) or emulator.

1. Clone the repo:
   ```bash
   git clone https://github.com/Hetvi596/Samajh.git
   cd Samajh
   ```
2. Create the environment file. This step is required, because the build expects a `.env` file. It can stay empty:
   ```bash
   cp .env.example .env
   ```
   On Windows PowerShell: `Copy-Item .env.example .env`
3. Install packages:
   ```bash
   flutter pub get
   ```
4. Start an emulator or plug in a phone with USB debugging on, then run:
   ```bash
   flutter run
   ```
5. To build an installable APK:
   ```bash
   flutter build apk --release --split-per-abi
   ```
   The APKs are in `build/app/outputs/flutter-apk/` (use `app-arm64-v8a-release.apk` for most phones).

Run the tests with `flutter test`.

**First launch:** choose English or Hindi, read the privacy promise and set a 6-digit passcode. The app opens with a demo class of fictional children.

## Environment file

[`.env.example`](.env.example) lists every variable. Both are optional:

| Variable | Used for |
|---|---|
| `SUPABASE_URL` | Optional cloud backup project URL |
| `SUPABASE_PUBLISHABLE_KEY` | Optional cloud backup public key |

## Data and privacy

- No secrets or API keys are committed. `.env` is in `.gitignore`.
- No personal data of real users is in this repo. Demo children are fictional.
- Reading recordings stay on the phone and are never uploaded. Speech recognition runs offline.

## Status

This is a working prototype. All passages, questions and word lists are original and await teacher review. Scoring thresholds are provisional. Speech-marking accuracy on children's reading has not been measured yet. Design decisions are recorded in [docs/DECISIONS.md](docs/DECISIONS.md).

## Licences

Speech models: [Vosk](https://alphacephei.com/vosk/models) (Apache-2.0). Fonts: Inter and Noto Sans Devanagari (SIL Open Font License).
