import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift DB Schema v6 Migration Tests (Section 1 & 5)', () {
    test('Database schema version is 6', () {
      expect(db.schemaVersion, greaterThanOrEqualTo(6));
    });

    test('TeacherProfileTable exists and supports get, watch, and save', () async {
      // Initial state from seed
      final initialProfile = await db.getTeacherProfile();
      expect(initialProfile, isNotNull);
      expect(initialProfile!.id, equals('teacher_profile_single'));

      // Update profile
      await db.saveTeacherProfile(
        teacherName: 'सुनीता देवी',
        schoolName: 'प्राथमिक विद्यालय रामपुर',
        preferredLanguage: 'hi',
      );

      final updated = await db.getTeacherProfile();
      expect(updated, isNotNull);
      expect(updated!.teacherName, equals('सुनीता देवी'));
      expect(updated.schoolName, equals('प्राथमिक विद्यालय रामपुर'));
      expect(updated.preferredLanguage, equals('hi'));
    });

    test('AppSettingsTable supports activeClassId and consent fields', () async {
      final now = DateTime.now();
      await (db.update(db.appSettingsTable)..where((t) => t.id.equals('global_settings'))).write(
        AppSettingsTableCompanion(
          activeClassId: const drift.Value('class_real_1'),
          deviceDataConsentGiven: const drift.Value(true),
          deviceDataConsentDate: drift.Value(now),
          audioRecordingConsentGiven: const drift.Value(true),
          audioRecordingConsentDate: drift.Value(now),
        ),
      );

      final settings = await (db.select(db.appSettingsTable)..where((t) => t.id.equals('global_settings'))).getSingle();
      expect(settings.activeClassId, equals('class_real_1'));
      expect(settings.deviceDataConsentGiven, isTrue);
      expect(settings.audioRecordingConsentGiven, isTrue);
      expect(settings.deviceDataConsentDate, isNotNull);
      expect(settings.audioRecordingConsentDate, isNotNull);
    });
  });
}
