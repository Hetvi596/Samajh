import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

/// Single source of truth: AppDatabase singleton provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Global App Settings Stream Provider
final appSettingsStreamProvider = StreamProvider<AppSettingsTableData?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.appSettingsTable)..where((t) => t.id.equals('global_settings')))
      .watchSingleOrNull();
});

/// Active Scope Provider ('demo' or 'real')
final activeScopeProvider = StateProvider<String>((ref) {
  final settingsAsync = ref.watch(appSettingsStreamProvider);
  return settingsAsync.value?.activeScope ?? 'demo';
});

/// App Language Provider (controls buttons, menus, chrome)
final appLanguageProvider = StateProvider<Locale>((ref) {
  final settingsAsync = ref.watch(appSettingsStreamProvider);
  final code = settingsAsync.value?.appLanguage ?? 'hi';
  return Locale(code);
});

/// Children's Reading Language Provider ('hi' or 'en' - controls passages, Devanagari, voice)
final readingLanguageProvider = StateProvider<String>((ref) {
  final activeClass = ref.watch(activeClassStreamProvider).value;
  if (activeClass != null && activeClass.checkLanguage.isNotEmpty) {
    return activeClass.checkLanguage;
  }
  final settingsAsync = ref.watch(appSettingsStreamProvider);
  return settingsAsync.value?.readingLanguage ?? 'hi';
});

/// Teacher Profile Stream Provider
final teacherProfileStreamProvider = StreamProvider<TeacherProfileTableData?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchTeacherProfile();
});

/// Explicitly selected class ID state provider
final selectedClassIdProvider = StateProvider<String?>((ref) => null);

/// Classes the teacher can switch between: their own classes first, then the
/// fictional sample class (demo scope).
final classesForScopeStreamProvider = StreamProvider<List<ClassesTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.classesTable)
        ..orderBy([
          (t) => OrderingTerm.desc(t.scope), // 'real' before 'demo'
          (t) => OrderingTerm.asc(t.grade),
          (t) => OrderingTerm.asc(t.section),
        ]))
      .watch();
});

/// Stream of real classes in database
final realClassesStreamProvider = StreamProvider<List<ClassesTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.classesTable)..where((t) => t.scope.equals('real'))).watch();
});

/// Active Class Stream Provider for current scope with stable selection support
final activeClassStreamProvider = StreamProvider<ClassesTableData?>((ref) async* {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);
  final selectedId = ref.watch(selectedClassIdProvider);
  final settingsAsync = ref.watch(appSettingsStreamProvider);
  final savedClassId = settingsAsync.value?.activeClassId;

  final targetId = selectedId ?? savedClassId;

  final query = (db.select(db.classesTable)
    ..where((t) => t.scope.equals(scope))
    ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]));

  await for (final list in query.watch()) {
    if (list.isEmpty) {
      yield null;
    } else {
      final match = list.where((c) => c.id == targetId).firstOrNull;
      yield match ?? list.first;
    }
  }
});

/// Roster Stream Provider (list of children in active class)
final rosterStreamProvider = StreamProvider<List<ChildrenTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);
  final activeClassAsync = ref.watch(activeClassStreamProvider);
  final classId = activeClassAsync.value?.id;

  if (classId == null) {
    return Stream.value([]);
  }

  return (db.select(db.childrenTable)
        ..where((t) => t.classId.equals(classId) & t.scope.equals(scope))
        ..orderBy([(t) => OrderingTerm.asc(t.firstName)]))
      .watch();
});

/// Consents Map Provider for children in active class
final consentsStreamProvider = StreamProvider<Map<String, bool>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);

  return (db.select(db.consentsTable)..where((t) => t.scope.equals(scope)))
      .watch()
      .map((rows) {
    return {for (var r in rows) r.childId: r.consentGiven && !r.withdrawn};
  });
});

/// Completed Checks Stream Provider in active scope
final completedChecksStreamProvider = StreamProvider<List<ChecksTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);

  return (db.select(db.checksTable)
        ..where((t) => t.scope.equals(scope) & t.status.equals('completed')))
      .watch();
});

/// Results Stream Provider in active scope
final resultsStreamProvider = StreamProvider<List<ResultsTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);

  return (db.select(db.resultsTable)..where((t) => t.scope.equals(scope))).watch();
});

/// Today Screen Stats Model
class TodayStats {
  final int totalChildren;
  final int checkedChildren;
  final ChildrenTableData? nextChildToCheck;
  final int suggestedToday;

  const TodayStats({
    required this.totalChildren,
    required this.checkedChildren,
    this.nextChildToCheck,
    required this.suggestedToday,
  });
}

/// Today Stats Provider
final todayStatsProvider = Provider<TodayStats>((ref) {
  final children = ref.watch(rosterStreamProvider).value ?? [];
  final completedChecks = ref.watch(completedChecksStreamProvider).value ?? [];
  final settings = ref.watch(appSettingsStreamProvider).value;

  final checkedChildIds = completedChecks.map((c) => c.childId).toSet();
  final checkedCount = children.where((c) => checkedChildIds.contains(c.id)).length;
  final totalCount = children.length;

  final remainingChildren = children.where((c) => !checkedChildIds.contains(c.id)).toList();
  final nextChild = remainingChildren.isNotEmpty ? remainingChildren.first : null;

  final windowDays = settings?.suggestedChecksWindowDays ?? 5;
  final remainingCount = totalCount - checkedCount;
  final suggested = windowDays > 0 ? (remainingCount / windowDays).ceil() : remainingCount;

  return TodayStats(
    totalChildren: totalCount,
    checkedChildren: checkedCount,
    nextChildToCheck: nextChild,
    suggestedToday: suggested > 0 ? suggested : 0,
  );
});

/// To-Do List Counts Model
class ToDoCounts {
  final int waitingReviewCount;
  final int rechecksDueCount;
  final int practiceSheetsReadyCount;

  const ToDoCounts({
    required this.waitingReviewCount,
    required this.rechecksDueCount,
    required this.practiceSheetsReadyCount,
  });
}

/// Group Assignments Stream Provider in active scope
final groupAssignmentsStreamProvider = StreamProvider<List<GroupAssignmentsTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);

  return (db.select(db.groupAssignmentsTable)..where((t) => t.scope.equals(scope))).watch();
});

/// In-progress Checks Stream Provider in active scope (waiting for teacher review)
final inProgressChecksStreamProvider = StreamProvider<List<ChecksTableData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final scope = ref.watch(activeScopeProvider);

  return (db.select(db.checksTable)
        ..where((t) => t.scope.equals(scope) & t.status.equals('in_progress')))
      .watch();
});

/// To-Do Counts Provider
final toDoCountsProvider = Provider<ToDoCounts>((ref) {
  final checks = ref.watch(completedChecksStreamProvider).value ?? [];
  final inProgress = ref.watch(inProgressChecksStreamProvider).value ?? [];
  final settings = ref.watch(appSettingsStreamProvider).value;
  final recheckWeeks = settings?.recheckPeriodWeeks ?? 3;
  final recheckThreshold = DateTime.now().subtract(Duration(days: recheckWeeks * 7));

  final rechecksDue = checks.where((c) => c.startedAt.isBefore(recheckThreshold)).length;

  return ToDoCounts(
    waitingReviewCount: inProgress.length,
    rechecksDueCount: rechecksDue,
    practiceSheetsReadyCount: 0,
  );
});

/// Function to change active class stably
Future<void> switchActiveClass(dynamic ref, String classId) async {
  ref.read(selectedClassIdProvider.notifier).state = classId;
  final AppDatabase db = ref.read(appDatabaseProvider);
  final cls = await (db.select(db.classesTable)..where((t) => t.id.equals(classId))).getSingleOrNull();
  // Picking the sample class switches to demo data; picking a real class
  // switches back.
  await db.update(db.appSettingsTable).write(
    AppSettingsTableCompanion(
      activeClassId: Value(classId),
      activeScope: cls == null ? const Value.absent() : Value(cls.scope),
    ),
  );
  if (cls != null) ref.read(activeScopeProvider.notifier).state = cls.scope;
  if (cls != null && cls.checkLanguage.isNotEmpty) {
    ref.read(readingLanguageProvider.notifier).state = cls.checkLanguage;
  }
}

/// Support Group Counts Model
class SupportGroupCounts {
  final int all;
  final int notGroupedYet;
  final int onTrack;
  final int needsDecoding;
  final int needsComprehension;
  final int needsBoth;

  const SupportGroupCounts({
    required this.all,
    required this.notGroupedYet,
    required this.onTrack,
    required this.needsDecoding,
    required this.needsComprehension,
    required this.needsBoth,
  });
}

/// Support Group Counts Provider
final supportGroupCountsProvider = Provider<SupportGroupCounts>((ref) {
  final children = ref.watch(rosterStreamProvider).value ?? [];
  final assignments = ref.watch(groupAssignmentsStreamProvider).value ?? [];

  // A child's group is their latest group move (from a check or the
  // teacher), the same source the Class list and child profile use.
  final latestGroup = <String, GroupAssignmentsTableData>{};
  for (final g in assignments) {
    final seen = latestGroup[g.childId];
    if (seen == null || g.movedAt.isAfter(seen.movedAt)) latestGroup[g.childId] = g;
  }

  int notGrouped = 0;
  int onTrack = 0;
  int needsDecoding = 0;
  int needsComprehension = 0;
  int needsBoth = 0;

  for (final c in children) {
    switch (latestGroup[c.id]?.toGroup) {
      case 'On track':
        onTrack++;
        break;
      case 'Understands, needs help reading words':
        needsDecoding++;
        break;
      case 'Reads words, needs help understanding':
        needsComprehension++;
        break;
      case 'Needs help with both':
        needsBoth++;
        break;
      default:
        notGrouped++;
        break;
    }
  }

  return SupportGroupCounts(
    all: children.length,
    notGroupedYet: notGrouped,
    onTrack: onTrack,
    needsDecoding: needsDecoding,
    needsComprehension: needsComprehension,
    needsBoth: needsBoth,
  );
});

/// In-memory session unlock state.
/// Defaults to false so every app launch requires unlocking if a passcode is configured.
final isAppUnlockedProvider = StateProvider<bool>((ref) => false);
