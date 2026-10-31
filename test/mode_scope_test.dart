import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/database/app_database.dart';

void main() {
  group('Section 2 Demo and Real Mode Scopes Database Isolation Tests', () {
    late AppDatabase db;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      // Seed initial demo data
      await db.customSelect('SELECT 1').get();
    });

    tearDown(() async {
      await db.close();
    });

    test('Demo scope seeds exactly 1 demo class (3B) and 10 unchecked children', () async {
      final demoClasses = await (db.select(db.classesTable)..where((t) => t.scope.equals('demo'))).get();
      expect(demoClasses.length, equals(1));
      expect(demoClasses.first.name, equals('Class 3B'));
      expect(demoClasses.first.grade, equals(3));
      expect(demoClasses.first.curriculum, equals('up'));
      expect(demoClasses.first.checkLanguage, equals('hi'));

      final demoChildren = await (db.select(db.childrenTable)..where((t) => t.scope.equals('demo'))).get();
      expect(demoChildren.length, equals(10));
      for (final child in demoChildren) {
        expect(child.currentGroup, equals('not_grouped'));
      }
    });

    test('Real scope starts completely empty and never mixes with Demo records', () async {
      final realClasses = await (db.select(db.classesTable)..where((t) => t.scope.equals('real'))).get();
      expect(realClasses, isEmpty);

      final realChildren = await (db.select(db.childrenTable)..where((t) => t.scope.equals('real'))).get();
      expect(realChildren, isEmpty);

      // Create a real class
      final now = DateTime.now();
      await db.into(db.classesTable).insert(
        ClassesTableCompanion.insert(
          id: 'real_class_1',
          scope: 'real',
          name: 'Class 4A',
          grade: 4,
          section: 'A',
          curriculum: 'ncert',
          checkLanguage: 'en',
          mediumOfInstruction: 'en',
          createdAt: now,
          updatedAt: now,
        ),
      );

      final updatedRealClasses = await (db.select(db.classesTable)..where((t) => t.scope.equals('real'))).get();
      expect(updatedRealClasses.length, equals(1));
      expect(updatedRealClasses.first.name, equals('Class 4A'));

      // Verify demo classes remain strictly 1 and untouched
      final demoClassesAfter = await (db.select(db.classesTable)..where((t) => t.scope.equals('demo'))).get();
      expect(demoClassesAfter.length, equals(1));
      expect(demoClassesAfter.first.name, equals('Class 3B'));
    });

    test('Resetting demo class restores 10 fictional children to unchecked and leaves real data untouched', () async {
      final now = DateTime.now();

      // Add a real class and child
      await db.into(db.classesTable).insert(
        ClassesTableCompanion.insert(
          id: 'real_class_2',
          scope: 'real',
          name: 'Class 2A',
          grade: 2,
          section: 'A',
          curriculum: 'up',
          checkLanguage: 'hi',
          mediumOfInstruction: 'hi',
          createdAt: now,
          updatedAt: now,
        ),
      );
      await db.into(db.childrenTable).insert(
        ChildrenTableCompanion.insert(
          id: 'real_child_1',
          classId: 'real_class_2',
          scope: 'real',
          firstName: 'Suresh',
          lastInitial: 'K.',
          homeLanguage: 'hi',
          createdAt: now,
        ),
      );

      // Move a demo child to a group
      await (db.update(db.childrenTable)..where((t) => t.id.equals('demo_child_1'))).write(
        const ChildrenTableCompanion(
          currentGroup: Value('On track'),
        ),
      );

      // Reset demo class
      await db.resetDemoClass();

      // Verify demo child is reset to not_grouped
      final demoChildren = await (db.select(db.childrenTable)..where((t) => t.scope.equals('demo'))).get();
      expect(demoChildren.length, equals(10));
      for (final child in demoChildren) {
        expect(child.currentGroup, equals('not_grouped'));
      }

      // Verify real data is completely untouched
      final realClasses = await (db.select(db.classesTable)..where((t) => t.scope.equals('real'))).get();
      expect(realClasses.length, equals(1));
      final realChildren = await (db.select(db.childrenTable)..where((t) => t.scope.equals('real'))).get();
      expect(realChildren.length, equals(1));
      expect(realChildren.first.firstName, equals('Suresh'));
    });
  });
}
