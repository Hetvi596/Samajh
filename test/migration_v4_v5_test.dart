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

  group('Drift DB Schema v5 Migration Tests (Section 6)', () {
    test('Database schema version is at least 5', () {
      expect(db.schemaVersion, greaterThanOrEqualTo(5));
    });

    test('ChoiceResponsesTable exists and supports all 13 fields', () async {
      final now = DateTime.now();
      const checkId = 'check_test_123';
      const childId = 'child_test_001';

      // First create child and check parent records for foreign consistency
      await db.into(db.classesTable).insert(
        ClassesTableCompanion.insert(
          id: 'class_test_1',
          name: 'Class 3A',
          grade: 3,
          section: 'A',
          curriculum: 'up',
          checkLanguage: 'hi',
          mediumOfInstruction: 'hi',
          scope: 'demo',
          homeDialect: const drift.Value('awadhi_bhojpuri'),
          createdAt: now,
          updatedAt: now,
        ),
      );

      await db.into(db.childrenTable).insert(
        ChildrenTableCompanion.insert(
          id: childId,
          classId: 'class_test_1',
          scope: 'demo',
          firstName: 'Aarav',
          lastInitial: 'K.',
          homeLanguage: 'Hindi',
          homeDialect: const drift.Value('awadhi_bhojpuri'),
          createdAt: now,
        ),
      );

      // Verify homeDialect is stored on child and class
      final storedChild = await (db.select(db.childrenTable)..where((t) => t.id.equals(childId))).getSingle();
      expect(storedChild.homeDialect, equals('awadhi_bhojpuri'));

      final storedClass = await (db.select(db.classesTable)..where((t) => t.id.equals('class_test_1'))).getSingle();
      expect(storedClass.homeDialect, equals('awadhi_bhojpuri'));

      // Insert into ChoiceResponsesTable
      await db.into(db.choiceResponsesTable).insert(
        ChoiceResponsesTableCompanion.insert(
          id: 'cr_001',
          checkId: checkId,
          itemId: 'item_word_check_01',
          level: 2,
          type: 'spelling',
          firstChoice: const drift.Value('कलम'),
          finalChoice: const drift.Value('कमल'),
          timeMs: 2350,
          changeCount: const drift.Value(1),
          distractorTag: const drift.Value('letter_reversal'),
          weight: const drift.Value(0.75),
          reason: const drift.Value('self-corrected answer'),
          createdAt: now,
        ),
      );

      final responses = await db.select(db.choiceResponsesTable).get();
      expect(responses.length, equals(1));
      final r = responses.first;
      expect(r.id, equals('cr_001'));
      expect(r.checkId, equals(checkId));
      expect(r.itemId, equals('item_word_check_01'));
      expect(r.level, equals(2));
      expect(r.type, equals('spelling'));
      expect(r.firstChoice, equals('कलम'));
      expect(r.finalChoice, equals('कमल'));
      expect(r.timeMs, equals(2350));
      expect(r.changeCount, equals(1));
      expect(r.distractorTag, equals('letter_reversal'));
      expect(r.weight, equals(0.75));
      expect(r.reason, equals('self-corrected answer'));
    });

    test('deleteChildData cascades and removes child checks and choice responses', () async {
      final now = DateTime.now();
      const childId = 'child_cascade_test';
      const checkId = 'check_cascade_test';

      await db.into(db.classesTable).insert(
        ClassesTableCompanion.insert(
          id: 'class_c1',
          name: 'Class 2B',
          grade: 2,
          section: 'B',
          curriculum: 'up',
          checkLanguage: 'hi',
          mediumOfInstruction: 'hi',
          scope: 'demo',
          createdAt: now,
          updatedAt: now,
        ),
      );

      await db.into(db.childrenTable).insert(
        ChildrenTableCompanion.insert(
          id: childId,
          classId: 'class_c1',
          scope: 'demo',
          firstName: 'Diya',
          lastInitial: 'M.',
          homeLanguage: 'Hindi',
          createdAt: now,
        ),
      );

      await db.into(db.checksTable).insert(
        ChecksTableCompanion.insert(
          id: checkId,
          childId: childId,
          classId: 'class_c1',
          scope: 'demo',
          status: 'completed',
          currentStep: 'result',
          passageId: 'p_01',
          passageTitle: 'Story',
          passageLevel: 1,
          startedAt: now,
        ),
      );

      await db.into(db.choiceResponsesTable).insert(
        ChoiceResponsesTableCompanion.insert(
          id: 'cr_cascade_1',
          checkId: checkId,
          itemId: 'item_01',
          level: 1,
          type: 'sound_recognition',
          timeMs: 1500,
          weight: const drift.Value(1.0),
          createdAt: now,
        ),
      );

      expect((await db.select(db.choiceResponsesTable).get()).length, equals(1));

      // Invoke deleteChildData
      await db.deleteChildData(childId);

      // Verify child and associated choice responses are gone
      final remainingChildren = await (db.select(db.childrenTable)..where((t) => t.id.equals(childId))).get();
      expect(remainingChildren.isEmpty, isTrue);

      final remainingChoices = await (db.select(db.choiceResponsesTable)..where((t) => t.checkId.equals(checkId))).get();
      expect(remainingChoices.isEmpty, isTrue);
    });
  });
}
