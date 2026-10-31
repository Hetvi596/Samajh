import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  AppSettingsTable,
  ClassesTable,
  ChildrenTable,
  ConsentsTable,
  GroupAssignmentsTable,
  ChecksTable,
  WordMarksTable,
  RetellPointsTable,
  QuestionAnswersTable,
  DictationItemsTable,
  ListeningChecksTable,
  ResultsTable,
  PracticeNeedsTable,
  WeeklyPlanTicksTable,
  ParentReportsTable,
  AcceptedPronunciationsTable,
  MediaIndexTable,
  AuditEventsTable,
  ChoiceResponsesTable,
  TeacherProfileTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection()) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaultData();
        },
        onUpgrade: (m, from, to) async {
          if (from < 5) {
            // v4 -> v5 migration:
            // 1. Create choice_responses table
            await m.createTable(choiceResponsesTable);

            // 2. Add homeDialect columns if missing
            try {
              await m.addColumn(classesTable, classesTable.homeDialect);
            } catch (_) {}
            try {
              await m.addColumn(childrenTable, childrenTable.homeDialect);
            } catch (_) {}

            // 3. Migrate any existing dictation items to choice responses
            try {
              final oldDictations = await select(dictationItemsTable).get();
              for (final oldItem in oldDictations) {
                await into(choiceResponsesTable).insertOnConflictUpdate(
                  ChoiceResponsesTableCompanion.insert(
                    id: 'migrated_${oldItem.id}',
                    checkId: oldItem.checkId,
                    itemId: 'item_${oldItem.itemIndex}',
                    level: 2,
                    type: 'spelling',
                    firstChoice: Value(oldItem.word),
                    finalChoice: Value(oldItem.word),
                    timeMs: 5000,
                    changeCount: const Value(0),
                    distractorTag: Value(oldItem.errorType),
                    weight: Value(oldItem.isCorrect ? 1.0 : 0.0),
                    reason: Value(oldItem.isSkipped ? 'Skipped' : (oldItem.isCorrect ? 'Correct' : 'Incorrect')),
                    createdAt: DateTime.now(),
                  ),
                );
              }
            } catch (_) {}
          }

          if (from < 6) {
            // v5 -> v6 migration:
            // 1. Create TeacherProfileTable
            await m.createTable(teacherProfileTable);

            // 2. Add activeClassId and consent columns to AppSettingsTable
            try {
              await m.addColumn(appSettingsTable, appSettingsTable.activeClassId);
            } catch (_) {}
            try {
              await m.addColumn(appSettingsTable, appSettingsTable.deviceDataConsentGiven);
            } catch (_) {}
            try {
              await m.addColumn(appSettingsTable, appSettingsTable.deviceDataConsentDate);
            } catch (_) {}
            try {
              await m.addColumn(appSettingsTable, appSettingsTable.audioRecordingConsentGiven);
            } catch (_) {}
            try {
              await m.addColumn(appSettingsTable, appSettingsTable.audioRecordingConsentDate);
            } catch (_) {}
          }

          if (from < 7) {
            // v6 -> v7: self-ratings, level-wise weighted marks, typing check.
            final adds = <Future<void> Function()>[
              () => m.addColumn(checksTable, checksTable.readingSelfRating),
              () => m.addColumn(choiceResponsesTable, choiceResponsesTable.maxMarks),
              () => m.addColumn(choiceResponsesTable, choiceResponsesTable.selfRating),
              () => m.addColumn(questionAnswersTable, questionAnswersTable.level),
              () => m.addColumn(questionAnswersTable, questionAnswersTable.timeMs),
              () => m.addColumn(questionAnswersTable, questionAnswersTable.marks),
              () => m.addColumn(questionAnswersTable, questionAnswersTable.maxMarks),
              () => m.addColumn(questionAnswersTable, questionAnswersTable.selfRating),
              () => m.addColumn(resultsTable, resultsTable.typingScore),
              () => m.addColumn(resultsTable, resultsTable.selfRatingSummaryJson),
            ];
            for (final add in adds) {
              try {
                await add();
              } catch (_) {}
            }
          }

          if (from < 8) {
            // v7 -> v8: fuller teacher profile.
            final t = teacherProfileTable;
            for (final column in [
              t.displayName,
              t.role,
              t.udiseCode,
              t.block,
              t.district,
              t.state,
              t.yearsTeaching,
              t.phone,
              t.email,
            ]) {
              try {
                await m.addColumn(t, column);
              } catch (_) {}
            }
          }
        },
      );

  Future<void> _seedDefaultData() async {
    final now = DateTime.now();

    // 1. Default Settings
    await into(appSettingsTable).insert(
      AppSettingsTableCompanion.insert(
        id: 'global_settings',
        activeScope: const Value('demo'),
        appLanguage: const Value('hi'),
        readingLanguage: const Value('hi'),
        suggestedChecksWindowDays: const Value(5),
        recheckPeriodWeeks: const Value(3),
        backupReminderPeriodDays: const Value(14),
      ),
    );

    // 1b. Default Teacher Profile
    await into(teacherProfileTable).insert(
      TeacherProfileTableCompanion.insert(
        id: 'teacher_profile_single',
        teacherName: 'शिक्षिका / Teacher',
        schoolName: const Value(null),
        preferredLanguage: const Value('hi'),
        updatedAt: now,
      ),
    );

    // 2. Default Demo Class: Class 3B · Uttar Pradesh · Hindi
    const demoClassId = 'demo_class_3b';
    await into(classesTable).insert(
      ClassesTableCompanion.insert(
        id: demoClassId,
        scope: 'demo',
        name: 'Class 3B',
        grade: 3,
        section: 'B',
        curriculum: 'up',
        checkLanguage: 'hi',
        mediumOfInstruction: 'hi',
        textbookId: const Value('up_khushi_3'),
        currentChapter: const Value('1'),
        createdAt: now,
        updatedAt: now,
      ),
    );

    // 3. Ten fictional unchecked children in demo scope
    final demoChildren = [
      ('Aarav', 'K.'),
      ('Diya', 'M.'),
      ('Kabir', 'S.'),
      ('Ananya', 'P.'),
      ('Rohan', 'V.'),
      ('Meera', 'T.'),
      ('Vihaan', 'B.'),
      ('Ishaan', 'N.'),
      ('Pooja', 'R.'),
      ('Aditya', 'G.'),
    ];

    for (int i = 0; i < demoChildren.length; i++) {
      final childId = 'demo_child_${i + 1}';
      final child = demoChildren[i];

      await into(childrenTable).insert(
        ChildrenTableCompanion.insert(
          id: childId,
          classId: demoClassId,
          scope: 'demo',
          firstName: child.$1,
          lastInitial: child.$2,
          homeLanguage: 'hi',
          currentGroup: const Value('not_grouped'),
          createdAt: now,
        ),
      );

      // Consent marked given for demo children
      await into(consentsTable).insert(
        ConsentsTableCompanion.insert(
          id: 'demo_consent_${i + 1}',
          childId: childId,
          scope: 'demo',
          consentGiven: const Value(true),
          consentDate: now,
        ),
      );
    }
  }

  /// Resets the demo class scope to initial state (10 unchecked children)
  Future<void> resetDemoClass() async {
    final now = DateTime.now();
    // Delete all demo checks, results, group moves, practice needs
    await (delete(checksTable)..where((t) => t.scope.equals('demo'))).go();
    await (delete(resultsTable)..where((t) => t.scope.equals('demo'))).go();
    await (delete(groupAssignmentsTable)..where((t) => t.scope.equals('demo'))).go();
    await (delete(practiceNeedsTable)..where((t) => t.scope.equals('demo'))).go();
    await (delete(parentReportsTable)..where((t) => t.scope.equals('demo'))).go();
    await (delete(mediaIndexTable)).go();

    // Reset children group to not_grouped
    await (update(childrenTable)..where((t) => t.scope.equals('demo'))).write(
      const ChildrenTableCompanion(
        currentGroup: Value('not_grouped'),
      ),
    );

    // Audit event
    await into(auditEventsTable).insert(
      AuditEventsTableCompanion.insert(
        id: 'audit_${now.millisecondsSinceEpoch}',
        eventType: 'demo_reset',
        timestamp: now,
      ),
    );
  }

  /// Deletes all data and records associated with a specific child (Section 5 & 14)
  Future<void> deleteChildData(String childId) async {
    final now = DateTime.now();

    // 1. Find all checks for child to purge media
    final childChecks = await (select(checksTable)..where((t) => t.childId.equals(childId))).get();
    for (final ch in childChecks) {
      if (ch.audioPath != null) {
        try {
          final f = File(ch.audioPath!);
          if (await f.exists()) await f.delete();
        } catch (_) {}
      }
      await (delete(wordMarksTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(retellPointsTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(questionAnswersTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(dictationItemsTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(choiceResponsesTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(listeningChecksTable)..where((t) => t.checkId.equals(ch.id))).go();
      await (delete(resultsTable)..where((t) => t.checkId.equals(ch.id))).go();
    }

    // 2. Delete child records
    await (delete(checksTable)..where((t) => t.childId.equals(childId))).go();
    await (delete(consentsTable)..where((t) => t.childId.equals(childId))).go();
    await (delete(groupAssignmentsTable)..where((t) => t.childId.equals(childId))).go();
    await (delete(practiceNeedsTable)..where((t) => t.childId.equals(childId))).go();
    await (delete(parentReportsTable)..where((t) => t.childId.equals(childId))).go();
    await (delete(childrenTable)..where((t) => t.id.equals(childId))).go();

    // 3. Log audit event strictly with NO personal data (Section 14 & 15)
    await into(auditEventsTable).insert(
      AuditEventsTableCompanion.insert(
        id: 'audit_${now.millisecondsSinceEpoch}',
        eventType: 'child_deleted',
        timestamp: now,
      ),
    );
  }

  /// Delete All Data with typed confirmation (Section 14)
  Future<void> deleteAllData() async {
    final now = DateTime.now();
    await delete(wordMarksTable).go();
    await delete(retellPointsTable).go();
    await delete(questionAnswersTable).go();
    await delete(dictationItemsTable).go();
    await delete(choiceResponsesTable).go();
    await delete(listeningChecksTable).go();
    await delete(resultsTable).go();
    await delete(checksTable).go();
    await delete(practiceNeedsTable).go();
    await delete(weeklyPlanTicksTable).go();
    await delete(parentReportsTable).go();
    await delete(groupAssignmentsTable).go();
    await delete(consentsTable).go();
    await delete(mediaIndexTable).go();
    await delete(childrenTable).go();
    await delete(classesTable).go();

    // Re-seed demo baseline
    await _seedDefaultData();

    // Audit event (no personal data)
    await into(auditEventsTable).insert(
      AuditEventsTableCompanion.insert(
        id: 'audit_${now.millisecondsSinceEpoch}',
        eventType: 'all_data_deleted',
        timestamp: now,
      ),
    );
  }

  /// Record legal reviewer name and date (Section 14)
  Future<void> recordLegalReviewer(String reviewerName) async {
    final now = DateTime.now();
    await update(appSettingsTable).write(
      AppSettingsTableCompanion(
        legalReviewerName: Value(reviewerName),
        legalReviewDate: Value(now),
        legalReviewCompleted: const Value(true),
      ),
    );

    await into(auditEventsTable).insert(
      AuditEventsTableCompanion.insert(
        id: 'audit_${now.millisecondsSinceEpoch}',
        eventType: 'legal_review_recorded',
        timestamp: now,
      ),
    );
  }

  /// Purges expired audio recordings on start and daily (Section 14 & 15)
  Future<void> purgeExpiredMedia() async {
    final now = DateTime.now();
    final expired = await (select(mediaIndexTable)
          ..where((t) => t.expiresAt.isSmallerThanValue(now) & t.isPurged.equals(false)))
        .get();

    for (final item in expired) {
      try {
        final f = File(item.filePath);
        if (await f.exists()) await f.delete();
      } catch (_) {}
      await (update(mediaIndexTable)..where((t) => t.id.equals(item.id))).write(
        const MediaIndexTableCompanion(isPurged: Value(true)),
      );
    }
  }

  /// Gets the teacher profile record.
  Future<TeacherProfileTableData?> getTeacherProfile() async {
    return (select(teacherProfileTable)..where((t) => t.id.equals('teacher_profile_single'))).getSingleOrNull();
  }

  /// Watches the teacher profile record.
  Stream<TeacherProfileTableData?> watchTeacherProfile() {
    return (select(teacherProfileTable)..where((t) => t.id.equals('teacher_profile_single'))).watchSingleOrNull();
  }

  /// Saves or updates the teacher profile.
  Future<void> saveTeacherProfile({
    required String teacherName,
    String? schoolName,
    String preferredLanguage = 'hi',
  }) async {
    await into(teacherProfileTable).insertOnConflictUpdate(
      TeacherProfileTableCompanion.insert(
        id: 'teacher_profile_single',
        teacherName: teacherName,
        schoolName: Value(schoolName),
        preferredLanguage: Value(preferredLanguage),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// Saves every field of the profile form at once.
  Future<void> saveTeacherProfileDetails(TeacherProfileTableCompanion details) async {
    await into(teacherProfileTable).insertOnConflictUpdate(
      details.copyWith(id: const Value('teacher_profile_single'), updatedAt: Value(DateTime.now())),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'samajh_v1.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
