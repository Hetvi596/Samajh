import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class ChildProfileScreen extends ConsumerStatefulWidget {
  final String childId;

  const ChildProfileScreen({super.key, required this.childId});

  @override
  ConsumerState<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends ConsumerState<ChildProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appLocale = ref.watch(appLanguageProvider);
    final isHindi = appLocale.languageCode == 'hi';
    final roster = ref.watch(rosterStreamProvider).value ?? [];
    final child = roster.where((c) => c.id == widget.childId).firstOrNull;

    if (child == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.childProfileTitle)),
        body: Center(child: Text(isHindi ? "बच्चा नहीं मिला" : "Child not found")),
      );
    }

    final activeClass = ref.watch(activeClassStreamProvider).value;
    final consentsMap = ref.watch(consentsStreamProvider).value ?? {};
    final hasConsent = consentsMap[child.id] ?? false;

    final results = ref.watch(resultsStreamProvider).value ?? [];
    final childResults = results.where((r) => r.childId == child.id).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final latestResult = childResults.firstOrNull;

    final groupAssignments = ref.watch(groupAssignmentsStreamProvider).value ?? [];
    final childGroups = groupAssignments.where((g) => g.childId == child.id).toList()
      ..sort((a, b) => b.movedAt.compareTo(a.movedAt));
    final currentGroup = childGroups.firstOrNull?.toGroup ?? l10n.groupNotGroupedYet;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.childProfileTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: SamajhColors.paleMint,
                    child: Text(
                      child.firstName.isNotEmpty ? child.firstName[0] : '?',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: SamajhColors.forestGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${child.firstName} ${child.lastInitial}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: SamajhColors.textNavy,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${activeClass?.name ?? "Class 3B"} · ${isHindi ? "घर की भाषा" : "Home language"}: ${child.homeLanguage}',
                          style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: hasConsent ? SamajhColors.paleMint : Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            hasConsent ? l10n.consentGiven : l10n.statusConsentMissing,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: hasConsent ? SamajhColors.forestGreen : Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Current Group Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? "वर्तमान सहायता समूह" : "Current Support Group",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    currentGroup,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _showMoveGroupDialog(context, child.id, currentGroup),
                    icon: const Icon(Icons.swap_horiz_rounded),
                    label: Text(l10n.moveToAnotherGroup),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Latest Result Summary Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? "नवीनतम जाँच परिणाम" : "Latest Check Result",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 8),
                  if (latestResult == null)
                    Text(
                      isHindi ? "इस बच्चे के लिए अभी कोई जाँच दर्ज नहीं की गई है।" : "No checks recorded yet for this child.",
                      style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted),
                    )
                  else ...[
                    Text(
                      latestResult.groupReason,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${isHindi ? 'पठन' : 'Reading'}: ${(latestResult.accuracyPercentage * 100).toInt()}% ${isHindi ? 'सटीकता' : 'accuracy'} · ${latestResult.readingSpeedWpm?.toInt() ?? 0} wpm",
                      style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                    ),
                    Text(
                      "${isHindi ? 'समझ' : 'Understanding'}: ${latestResult.comprehensionFactScore} · ${latestResult.retellScore}",
                      style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                    ),
                    if (latestResult.dictationScore.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          "${isHindi ? 'शब्द जाँच' : 'Word check'}: ${latestResult.dictationScore}",
                          style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                        ),
                      ),
                    () {
                      List<dynamic> mistakes = [];
                      try {
                        if (latestResult.stuckOnAksharasJson != null) {
                          mistakes = jsonDecode(latestResult.stuckOnAksharasJson!);
                        }
                      } catch (_) {}
                      if (mistakes.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isHindi ? "शीर्ष त्रुटियाँ:" : "Top common mistakes:",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF92400E)),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: mistakes.take(3).map((m) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    WordCheckScoringEngine.formatDistractorTag(m.toString(), isHindi: isHindi),
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
                                  ),
                                )).toList(),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }(),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Actions
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: hasConsent
                  ? () => context.push('/check_flow?childId=${child.id}')
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Parental consent must be recorded before starting a check.")),
                      );
                    },
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(l10n.startCheck),
            ),
            const SizedBox(height: 12),
            // Consent toggle
            OutlinedButton.icon(
              onPressed: () async {
                final db = ref.read(appDatabaseProvider);
                final newConsent = !hasConsent;
                await db.into(db.consentsTable).insertOnConflictUpdate(
                  ConsentsTableCompanion.insert(
                    id: 'consent_${child.id}',
                    childId: child.id,
                    scope: activeClass?.scope ?? 'demo',
                    consentGiven: drift.Value(newConsent),
                    consentDate: DateTime.now(),
                    withdrawn: drift.Value(!newConsent),
                    withdrawnDate: drift.Value(!newConsent ? DateTime.now() : null),
                  ),
                );
              },
              icon: Icon(hasConsent ? Icons.cancel_outlined : Icons.check_circle_outlined),
              label: Text(hasConsent ? l10n.withdrawConsent : l10n.markConsent),
            ),
            const SizedBox(height: 12),
            // Delete child button
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: SamajhColors.recordingRed,
              ),
              onPressed: () => _confirmDeleteChild(context, child.id, '${child.firstName} ${child.lastInitial}'),
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.deleteChild),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoveGroupDialog(BuildContext context, String childId, String currentGroup) {
    final l10n = AppLocalizations.of(context)!;
    final isHindi = Localizations.localeOf(context).languageCode == 'hi';
    final groups = [
      "On track",
      "Understands, needs help reading words",
      "Reads words, needs help understanding",
      "Needs help with both",
    ];
    final groupLabels = {
      "On track": l10n.groupOnTrack,
      "Understands, needs help reading words": l10n.groupNeedsReading,
      "Reads words, needs help understanding": l10n.groupNeedsUnderstanding,
      "Needs help with both": l10n.groupNeedsBoth,
    };
    String selected = currentGroup;
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.moveToAnotherGroup),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...groups.map((g) => RadioListTile<String>(
                    title: Text(groupLabels[g] ?? g, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    value: g,
                    // ignore: deprecated_member_use
                    groupValue: selected,
                    // ignore: deprecated_member_use
                    onChanged: (val) => setDialogState(() => selected = val!),
                  )),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: isHindi ? "शिक्षक टिप्पणी (वैकल्पिक)" : "Teacher note (optional)",
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancelButton)),
            ElevatedButton(
              onPressed: () async {
                final db = ref.read(appDatabaseProvider);
                final activeClass = ref.read(activeClassStreamProvider).value;
                await db.into(db.groupAssignmentsTable).insert(
                  GroupAssignmentsTableCompanion.insert(
                    id: 'group_move_${DateTime.now().millisecondsSinceEpoch}',
                    childId: childId,
                    scope: activeClass?.scope ?? 'demo',
                    fromGroup: currentGroup,
                    toGroup: selected,
                    reason: drift.Value(noteController.text.isNotEmpty ? noteController.text : 'Teacher moved child'),
                    movedAt: DateTime.now(),
                  ),
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text("Move child"),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteChild(BuildContext context, String childId, String childName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete child data?"),
        content: Text("This permanently deletes all check records, results, and files for $childName."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SamajhColors.recordingRed),
            onPressed: () async {
              final db = ref.read(appDatabaseProvider);
              await (db.delete(db.childrenTable)..where((t) => t.id.equals(childId))).go();
              await (db.delete(db.checksTable)..where((t) => t.childId.equals(childId))).go();
              await (db.delete(db.resultsTable)..where((t) => t.childId.equals(childId))).go();
              await (db.delete(db.consentsTable)..where((t) => t.childId.equals(childId))).go();
              if (ctx.mounted) {
                Navigator.pop(ctx);
                context.pop();
              }
            },
            child: const Text("Delete permanently"),
          ),
        ],
      ),
    );
  }
}
