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

## Build

Requirements: Flutter 3.x, Android SDK, JDK 21.

```bash
cp .env.example .env
flutter pub get
flutter build apk --release --split-per-abi
```

The `.env` file is only for the optional cloud backup. The app works fully offline without it.

## Status

This is a working prototype. All passages, questions and word lists are original and await teacher review. Scoring thresholds are provisional. Speech-marking accuracy on children's reading has not been measured yet. Design decisions are recorded in [docs/DECISIONS.md](docs/DECISIONS.md).

## Licences

Speech models: [Vosk](https://alphacephei.com/vosk/models) (Apache-2.0). Fonts: Inter and Noto Sans Devanagari (SIL Open Font License).
