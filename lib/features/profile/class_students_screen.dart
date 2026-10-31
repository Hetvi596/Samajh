import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class ClassStudentsScreen extends ConsumerWidget {
  final String classId;

  const ClassStudentsScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final db = ref.watch(appDatabaseProvider);
    final scope = ref.watch(activeScopeProvider);

    return FutureBuilder<ClassesTableData?>(
      future: (db.select(db.classesTable)
            ..where((t) => t.id.equals(classId) & t.scope.equals(scope)))
          .getSingleOrNull(),
      builder: (context, classSnapshot) {
        final classData = classSnapshot.data;
        final title = classData != null
            ? '${classData.name} (${l10n.gradeLabel} ${classData.grade}${classData.section.isNotEmpty ? classData.section : ""})'
            : l10n.tabClass;

        return Scaffold(
          backgroundColor: SamajhColors.background,
          appBar: AppBar(
            title: Text(title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: StreamBuilder<List<ChildrenTableData>>(
            stream: (db.select(db.childrenTable)
                  ..where((t) => t.classId.equals(classId) & t.scope.equals(scope))
                  ..orderBy([(t) => OrderingTerm.asc(t.firstName)]))
                .watch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final children = snapshot.data ?? [];
              if (children.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_outline, size: 64, color: SamajhColors.textMuted),
                        const SizedBox(height: 16),
                        Text(
                          l10n.none,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: SamajhColors.textNavy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.studentCount(0),
                          style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return StreamBuilder<List<ChecksTableData>>(
                stream: (db.select(db.checksTable)
                      ..where((t) => t.scope.equals(scope) & t.status.equals('completed')))
                    .watch(),
                builder: (context, checksSnapshot) {
                  final checks = checksSnapshot.data ?? [];

                  return StreamBuilder<List<GroupAssignmentsTableData>>(
                    stream: (db.select(db.groupAssignmentsTable)
                          ..where((t) => t.scope.equals(scope)))
                        .watch(),
                    builder: (context, groupsSnapshot) {
                      final groupAssignments = groupsSnapshot.data ?? [];

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        itemCount: children.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final child = children[index];
                          final childChecks = checks.where((c) => c.childId == child.id).toList()
                            ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
                          final latestCheck = childChecks.firstOrNull;

                          final childGroups = groupAssignments.where((g) => g.childId == child.id).toList()
                            ..sort((a, b) => b.movedAt.compareTo(a.movedAt));
                          final groupName = childGroups.firstOrNull?.toGroup;

                          String statusLine;
                          if (latestCheck == null) {
                            statusLine = l10n.statusNotChecked;
                          } else {
                            final now = DateTime.now();
                            final diff = now.difference(latestCheck.startedAt);
                            if (diff.inDays == 0) {
                              statusLine = l10n.statusCheckedToday;
                            } else {
                              statusLine = l10n.statusCheckedOn('${latestCheck.startedAt.day}/${latestCheck.startedAt.month}');
                            }
                          }

                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.push('/child_profile?childId=${child.id}');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: SamajhColors.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: SamajhColors.paleMint,
                                    radius: 22,
                                    child: Text(
                                      child.firstName.isNotEmpty ? child.firstName[0] : '?',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: SamajhColors.forestGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${child.firstName} ${child.lastInitial}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: SamajhColors.textNavy,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          statusLine,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: SamajhColors.textMuted,
                                          ),
                                        ),
                                        if (groupName != null) ...[
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: SamajhColors.paleMint,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              groupName,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: SamajhColors.forestGreen,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
