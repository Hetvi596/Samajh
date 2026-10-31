# DPDP 2025 & Child Privacy Checklist

This document must be signed off by a qualified person before real student data can be gathered in any live classroom.

## Technical Safeguards Implemented

- [x] **Offline-First by Default**: The app operates fully offline with zero internet dependency for core check flows, assessments, and reports. Optional cloud backup (Supabase) is strictly disabled by default and requires explicit teacher activation.
- [x] **Zero Telemetry / Analytics**: No Firebase, crash reporters, analytics SDKs, or third-party tracking.
- [x] **Encrypted Local Database**: SQLite database encrypted via SQLCipher / SQLite3MultipleCiphers using AES-256 (schema version 5).
- [x] **Key Derivation & Secure Keystore**: Vault and database keys are generated randomly on device and stored in Android Keystore via `flutter_secure_storage`.
- [x] **Passcode Protection**: 6-digit teacher passcode hashed with PBKDF2 (10,000 iterations); exponential back-off prevents brute-force attempts.
- [x] **Ephemeral Audio Vault**:
  - Audio recordings of children are kept in an AES-256-GCM vault, never leave the phone without explicit backup, are deleted immediately once marks are saved, and are hard-purged after 24 hours.
  - Zero photo or OCR dependencies: no camera permissions, no image picker, and no photos stored.
- [x] **Automatic Backup Disabled**: Android cloud auto-backup is disabled (`android:allowBackup="false"` and `android:fullBackupContent="false"`).
- [x] **Screenshot & Recents Guard**: Window flag `FLAG_SECURE` prevents capturing screen contents or thumbnails in task switchers for student and results screens.
- [x] **First Names Only on Reports**: Worksheets and parent reports only display the child's first name and last initial.
- [x] **Demo Mode Gate**: "Demo Mode" is enabled by default with 10 fictional learners. Switching to "Real Class Mode" requires acknowledging this privacy checklist and displays a persistent banner until legal review signoff.

## Legal Review Status

- [ ] **DPDP Rules 2025 Exemption Review**: Verifiable parental consent versus educational institutional exemption reviewed by legal counsel.
- [ ] **School Consent Mechanism Sign-off**: School administrator / institutional authorization procedure documented.
- [ ] **Qualified Signoff Date**: Pending legal review.

*Notice*: Samajh does not claim legal compliance; the app is "Designed for DPDP; legal review pending".
