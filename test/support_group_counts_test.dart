import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/database/app_database.dart';
import 'package:samajh/core/providers/database_provider.dart';

void main() {
  test('support group counts follow each child\'s latest group, as the Class list does', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(overrides: [appDatabaseProvider.overrideWithValue(db)]);
    addTearDown(() async {
      container.dispose();
      await db.close();
    });

    // Keep the streams alive and wait until the sample class roster and its
    // group moves have loaded.
    container.listen(supportGroupCountsProvider, (_, __) {});
    container.listen(rosterStreamProvider, (_, __) {});
    container.listen(groupAssignmentsStreamProvider, (_, __) {});
    for (var i = 0; i < 50; i++) {
      final counts = container.read(supportGroupCountsProvider);
      if (counts.all == 10 && counts.notGroupedYet < 10) break;
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    final counts = container.read(supportGroupCountsProvider);
    expect(counts.all, 10);
    expect(counts.notGroupedYet, 4);
    expect(counts.onTrack + counts.needsDecoding + counts.needsComprehension + counts.needsBoth, 6);
    expect(counts.onTrack, greaterThan(0));
    expect(counts.needsDecoding, greaterThan(0));
    expect(counts.needsComprehension, greaterThan(0));
    expect(counts.needsBoth, greaterThan(0));
  });

  test('switching to the sample class opens demo data, and back to a real class', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(overrides: [appDatabaseProvider.overrideWithValue(db)]);
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    final now = DateTime.now();
    await db.into(db.classesTable).insert(
          ClassesTableCompanion.insert(
            id: 'real_1',
            scope: 'real',
            name: 'Class 3A',
            grade: 3,
            section: 'A',
            curriculum: 'up',
            checkLanguage: 'hi',
            mediumOfInstruction: 'hi',
            createdAt: now,
            updatedAt: now,
          ),
        );

    await switchActiveClass(container, 'demo_class_3b');
    expect(container.read(activeScopeProvider), 'demo');
    final settings = await db.select(db.appSettingsTable).getSingle();
    expect(settings.activeScope, 'demo');
    expect(settings.activeClassId, 'demo_class_3b');

    await switchActiveClass(container, 'real_1');
    expect(container.read(activeScopeProvider), 'real');
    expect((await db.select(db.appSettingsTable).getSingle()).activeScope, 'real');
  });
}
