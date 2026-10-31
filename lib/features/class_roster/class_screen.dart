import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import 'add_child_dialog.dart';

class ClassScreen extends ConsumerStatefulWidget {
  const ClassScreen({super.key});

  @override
  ConsumerState<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends ConsumerState<ClassScreen> {
  String _selectedGroupFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final roster = ref.watch(rosterStreamProvider).value ?? [];
    final checks = ref.watch(completedChecksStreamProvider).value ?? [];
    final results = ref.watch(resultsStreamProvider).value ?? [];
    final groupCounts = ref.watch(supportGroupCountsProvider);
    final groupAssignments = ref.watch(groupAssignmentsStreamProvider).value ?? [];

    final appLocale = ref.watch(appLanguageProvider);
    final isHindi = appLocale.languageCode == 'hi';

    final classMistakeCounts = <String, int>{};
    for (final res in results) {
      if (res.stuckOnAksharasJson != null) {
        try {
          final list = jsonDecode(res.stuckOnAksharasJson!) as List<dynamic>;
          for (final item in list) {
            final str = item.toString().trim();
            if (str.isNotEmpty) {
              classMistakeCounts[str] = (classMistakeCounts[str] ?? 0) + 1;
            }
          }
        } catch (_) {}
      }
    }
    final sortedMistakes = classMistakeCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top3ClassMistakes = sortedMistakes.take(3).map((e) => e.key).toList();

    if (activeClass == null) {
      return Scaffold(
        backgroundColor: SamajhColors.background,
        appBar: AppBar(
          title: Text(l10n.tabClass),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: SamajhColors.textNavy),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.groups_outlined, size: 64, color: SamajhColors.textMuted),
                const SizedBox(height: 16),
                Text(
                  isHindi ? "कोई कक्षा नहीं बनाई गई है" : "No class created yet",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                ),
                const SizedBox(height: 8),
                Text(
                  isHindi
                      ? "छात्रों और सहायता समूहों को प्रबंधित करने के लिए अपनी कक्षा बनाएं।"
                      : "Create your real classroom to manage students and support groups.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/class_setup'),
                  child: Text(isHindi ? "अपनी कक्षा बनाएं" : "Create your class"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final totalCount = roster.length;
    final grade = activeClass.grade;

    // Filter children based on selected group
    final filteredRoster = roster.where((child) {
      if (_selectedGroupFilter == 'all') return true;
      final childGroup = groupAssignments
          .where((g) => g.childId == child.id)
          .toList()
        ..sort((a, b) => b.movedAt.compareTo(a.movedAt));
      final groupName = childGroup.firstOrNull?.toGroup;

      if (_selectedGroupFilter == 'not_grouped') return groupName == null;
      if (_selectedGroupFilter == 'on_track') return groupName == 'On track';
      if (_selectedGroupFilter == 'needs_reading') return groupName == 'Understands, needs help reading words';
      if (_selectedGroupFilter == 'needs_understanding') return groupName == 'Reads words, needs help understanding';
      if (_selectedGroupFilter == 'needs_both') return groupName == 'Needs help with both';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.tabClass),
        actions: [
          IconButton(
            key: const Key('add_child_icon_button'),
            icon: const Icon(Icons.person_add_outlined, color: SamajhColors.textNavy),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => const AddChildDialog(),
              );
            },
          ),
          IconButton(
            key: const Key('settings_button'),
            icon: const Icon(Icons.settings_outlined, color: SamajhColors.textNavy),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Class summary line with two links
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${activeClass.name} · $totalCount ${isHindi ? 'बच्चे' : 'children'}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: SamajhColors.textNavy,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.push('/class_settings'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        l10n.classSettingsTitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: SamajhColors.forestGreen,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => context.push('/milestones'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        l10n.classMilestonesTitle(grade),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: SamajhColors.forestGreen,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            // Horizontally scrollable Support groups chip row (Section 5)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  _SupportGroupChip(
                    label: l10n.filterAll(groupCounts.all),
                    isSelected: _selectedGroupFilter == 'all',
                    onTap: () => setState(() => _selectedGroupFilter = 'all'),
                  ),
                  const SizedBox(width: 8),
                  _SupportGroupChip(
                    label: l10n.filterNotGrouped(groupCounts.notGroupedYet),
                    isSelected: _selectedGroupFilter == 'not_grouped',
                    onTap: () => setState(() => _selectedGroupFilter = 'not_grouped'),
                  ),
                  const SizedBox(width: 8),
                  _SupportGroupChip(
                    label: "${l10n.groupOnTrack} · ${groupCounts.onTrack}",
                    isSelected: _selectedGroupFilter == 'on_track',
                    onTap: () => setState(() => _selectedGroupFilter = 'on_track'),
                  ),
                  const SizedBox(width: 8),
                  _SupportGroupChip(
                    label: "${l10n.groupNeedsReading} · ${groupCounts.needsDecoding}",
                    isSelected: _selectedGroupFilter == 'needs_reading',
                    onTap: () => setState(() => _selectedGroupFilter = 'needs_reading'),
                  ),
                  const SizedBox(width: 8),
                  _SupportGroupChip(
                    label: "${l10n.groupNeedsUnderstanding} · ${groupCounts.needsComprehension}",
                    isSelected: _selectedGroupFilter == 'needs_understanding',
                    onTap: () => setState(() => _selectedGroupFilter = 'needs_understanding'),
                  ),
                  const SizedBox(width: 8),
                  _SupportGroupChip(
                    label: "${l10n.groupNeedsBoth} · ${groupCounts.needsBoth}",
                    isSelected: _selectedGroupFilter == 'needs_both',
                    onTap: () => setState(() => _selectedGroupFilter = 'needs_both'),
                  ),
                ],
              ),
            ),
            // Helper line below chips (Section 5)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              child: Text(
                l10n.groupHelperText,
                style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.3),
              ),
            ),
            if (top3ClassMistakes.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFCD34D)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.tips_and_updates_outlined, size: 20, color: Color(0xFF92400E)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "कक्षा में शीर्ष 3 सामान्य त्रुटियाँ:" : "Top 3 common mistakes in class:",
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF92400E)),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: top3ClassMistakes.map((tag) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  WordCheckScoringEngine.formatDistractorTag(tag, isHindi: isHindi),
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Divider(height: 1),
            // Child rows
            Expanded(
              child: roster.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person_add_alt_1_outlined, size: 54, color: SamajhColors.forestGreen),
                            const SizedBox(height: 14),
                            Text(
                              l10n.noChildrenInClassYet,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              l10n.addChildPrompt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              key: const Key('empty_state_add_child_button'),
                              icon: const Icon(Icons.add),
                              label: Text(l10n.addChildrenButton),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => const AddChildDialog(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : (filteredRoster.isEmpty
                      ? Center(
                          child: Text(
                            "No children match this filter",
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          itemCount: filteredRoster.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final child = filteredRoster[index];
                            return _ChildRow(
                              child: child,
                              checks: checks,
                              groupAssignments: groupAssignments,
                              l10n: l10n,
                            );
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportGroupChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SupportGroupChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? SamajhColors.forestGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? SamajhColors.forestGreen : SamajhColors.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : SamajhColors.textNavy,
          ),
        ),
      ),
    );
  }
}

class _ChildRow extends StatelessWidget {
  final ChildrenTableData child;
  final List<ChecksTableData> checks;
  final List<GroupAssignmentsTableData> groupAssignments;
  final AppLocalizations l10n;

  const _ChildRow({
    required this.child,
    required this.checks,
    required this.groupAssignments,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final childChecks = checks.where((c) => c.childId == child.id).toList()
      ..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    final latestCheck = childChecks.firstOrNull;

    final childGroups = groupAssignments.where((g) => g.childId == child.id).toList()
      ..sort((a, b) => b.movedAt.compareTo(a.movedAt));
    final groupName = childGroups.firstOrNull?.toGroup;

    // Determine status line
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
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
        title: Text(
          '${child.firstName} ${child.lastInitial}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: SamajhColors.textNavy,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              statusLine,
              style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
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
        trailing: const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
        onTap: () {
          // Open child profile
          context.push('/child_profile?childId=${child.id}');
        },
      ),
    );
  }
}
