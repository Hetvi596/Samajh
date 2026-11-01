import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../class_roster/add_child_dialog.dart';

/// The teacher's home. Pebble style: cream page, white rounded cards, one
/// green accent for progress and navy for the main action.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final classes = ref.watch(classesForScopeStreamProvider).value ?? [];
    final todoCounts = ref.watch(toDoCountsProvider);
    final groupCounts = ref.watch(supportGroupCountsProvider);
    final teacherProfile = ref.watch(teacherProfileStreamProvider).value;
    final appLocale = ref.watch(appLanguageProvider);
    final isHindi = appLocale.languageCode == 'hi';

    // In Real scope with no class created yet, show empty state
    if (activeClass == null && classes.isEmpty) {
      return Scaffold(
        backgroundColor: SamajhColors.background,
        appBar: AppBar(
          title: Text(l10n.tabToday),
          actions: [
            IconButton(
              key: const Key('settings_button'),
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
                const Icon(Icons.school_outlined, size: 64, color: SamajhColors.textMuted),
                const SizedBox(height: 16),
                Text(
                  isHindi ? "कोई कक्षा नहीं बनाई गई है" : "No class created yet",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                ),
                const SizedBox(height: 8),
                Text(
                  isHindi
                      ? "छात्रों का ऑफलाइन आकलन शुरू करने के लिए अपनी कक्षा बनाएं।"
                      : "Create your real classroom to start assessing learners offline.",
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

    final db = ref.watch(appDatabaseProvider);
    final scope = ref.watch(activeScopeProvider);
    final shownClass = activeClass ?? classes.first;
    final teacherName = teacherProfile?.teacherName ?? '';
    final callName = (teacherProfile?.displayName?.trim().isNotEmpty ?? false)
        ? teacherProfile!.displayName!.trim()
        : (teacherName.isNotEmpty ? teacherName : (isHindi ? "शिक्षक जी" : "Teacher"));

    return Scaffold(
      backgroundColor: SamajhColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
          children: [
            EntranceFade(
              child: _Header(
                initial: teacherName.isNotEmpty ? teacherName.characters.first.toUpperCase() : 'T',
                greetingName: callName,
              ),
            ),
            const SizedBox(height: SamajhSpace.lg),

            // Class switcher: one pill per class, the open one in navy.
            if (classes.length > 1) ...[
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: classes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final cls = classes[i];
                    final selected = cls.id == shownClass.id;
                    return _ClassPill(
                      label: cls.name,
                      selected: selected,
                      onTap: selected ? null : () => switchActiveClass(ref, cls.id),
                    );
                  },
                ),
              ),
              const SizedBox(height: SamajhSpace.md),
            ],

            // The sample class holds fictional children and results only.
            if (scope == 'demo') ...[
              Container(
                key: const Key('sample_class_banner'),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: SamajhColors.paleMint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 18, color: SamajhColors.forestGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.demoModeBanner,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: SamajhSpace.md),
            ],

            // The open class: how many children are checked and the next step.
            StreamBuilder<List<ChildrenTableData>>(
              stream: (db.select(
                db.childrenTable,
              )..where((t) => t.classId.equals(shownClass.id) & t.scope.equals(scope))).watch(),
              builder: (context, childrenSnap) {
                final classChildren = childrenSnap.data ?? [];
                return StreamBuilder<List<ChecksTableData>>(
                  stream:
                      (db.select(db.checksTable)..where(
                            (t) =>
                                t.classId.equals(shownClass.id) & t.scope.equals(scope) & t.status.equals('completed'),
                          ))
                          .watch(),
                  builder: (context, checksSnap) {
                    final checkedIds = (checksSnap.data ?? []).map((c) => c.childId).toSet();
                    final checked = classChildren.where((c) => checkedIds.contains(c.id)).length;
                    final unchecked = classChildren.where((c) => !checkedIds.contains(c.id)).toList();
                    return EntranceFade(
                      index: 1,
                      child: _ClassCard(
                        cls: shownClass,
                        total: classChildren.length,
                        checked: checked,
                        nextChild: unchecked.isEmpty ? null : unchecked.first,
                        onStart: () async {
                          if (activeClass == null || activeClass.id != shownClass.id) {
                            await switchActiveClass(ref, shownClass.id);
                          }
                          if (!context.mounted) return;
                          if (unchecked.isEmpty) {
                            context.go('/app/class');
                          } else {
                            context.push('/check_flow?childId=${unchecked.first.id}');
                          }
                        },
                        onAddChildren: () => showDialog(
                          context: context,
                          builder: (_) => AddChildDialog(targetClassId: shownClass.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: SamajhSpace.lg),

            // To-do
            EntranceFade(
              index: 2,
              child: Row(
                children: [
                  Expanded(
                    child: _TodoTile(
                      icon: Icons.rate_review_outlined,
                      title: l10n.todoWaitingReview,
                      count: todoCounts.waitingReviewCount,
                      noneLabel: l10n.none,
                      onTap: () => context.go('/app/class'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TodoTile(
                      icon: Icons.update_rounded,
                      title: l10n.todoRechecksDue,
                      count: todoCounts.rechecksDueCount,
                      noneLabel: l10n.none,
                      onTap: () => context.go('/app/class'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SamajhSpace.lg),

            EntranceFade(
              index: 3,
              child: _SupportGroupsCard(counts: groupCounts, onViewClass: () => context.go('/app/class')),
            ),
            const SizedBox(height: SamajhSpace.lg),

            EntranceFade(index: 4, child: _PlanCard(isHindi: isHindi)),
            const SizedBox(height: SamajhSpace.xl),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded, size: 16, color: SamajhColors.forestGreen),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    l10n.worksOfflineReassurance,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String initial;
  final String greetingName;

  const _Header({required this.initial, required this.greetingName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.greetingMorning(greetingName)
        : hour < 17
        ? l10n.greetingAfternoon(greetingName)
        : l10n.greetingEvening(greetingName);
    final date = DateFormat.MMMMEEEEd(Localizations.localeOf(context).toLanguageTag()).format(DateTime.now());

    return Row(
      children: [
        Semantics(
          button: true,
          label: l10n.profileTitle,
          excludeSemantics: true,
          child: Pressable(
            child: InkWell(
              key: const Key('today_teacher_profile_chip'),
              onTap: () => context.push('/profile'),
              customBorder: const CircleBorder(),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: SamajhColors.forestGreen,
                child: Text(
                  initial,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
              ),
              const SizedBox(height: 2),
              Text(
                greeting,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: SamajhColors.textNavy,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _RoundIconButton(
          key: const Key('settings_button'),
          icon: Icons.tune_rounded,
          tooltip: l10n.settingsTitle,
          onTap: () => context.push('/settings'),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _RoundIconButton({super.key, required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: SamajhColors.textNavy),
        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      ),
    );
  }
}

class _ClassPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _ClassPill({required this.label, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      child: Material(
        color: selected ? SamajhColors.textNavy : SamajhColors.creamSoft,
        shape: const StadiumBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected ? Colors.white : SamajhColors.textNavy,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The open class. Children checked are shown as pebbles (one per child) for
/// classes up to 20, and as a single bar for bigger ones.
class _ClassCard extends StatelessWidget {
  final ClassesTableData cls;
  final int total;
  final int checked;
  final ChildrenTableData? nextChild;
  final VoidCallback onStart;
  final VoidCallback onAddChildren;

  const _ClassCard({
    required this.cls,
    required this.total,
    required this.checked,
    required this.nextChild,
    required this.onStart,
    required this.onAddChildren,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final language = cls.checkLanguage == 'en' ? 'English' : 'हिंदी';
    final meta = [
      '${l10n.gradeLabel} ${cls.grade}',
      if (cls.section.isNotEmpty) cls.section,
      language,
      if (cls.scope == 'demo') 'Demo',
    ].join(' · ');
    final next = nextChild;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SamajhRadius.hero),
        boxShadow: SamajhShadow.resting,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cls.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
          ),
          const SizedBox(height: 2),
          Text(meta, style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted)),
          const SizedBox(height: 16),
          Semantics(
            label: l10n.checkedProgress(checked, total),
            excludeSemantics: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                CountUpText(
                  checked,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: SamajhColors.textNavy,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.todayOfTotalChecked(total),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          total > 0 && total <= 20
              ? Row(
                  children: [
                    for (var i = 0; i < total; i++) ...[
                      if (i > 0) const SizedBox(width: 4),
                      Expanded(
                        child: AnimatedContainer(
                          duration: SamajhMotion.slow,
                          height: 10,
                          decoration: BoxDecoration(
                            color: i < checked ? SamajhColors.forestGreen : SamajhColors.creamTrack,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              : AnimatedBar(
                  value: total == 0 ? 0 : checked / total,
                  color: SamajhColors.forestGreen,
                  background: SamajhColors.creamTrack,
                  height: 10,
                ),
          const SizedBox(height: 10),
          Text(
            next == null
                ? (total == 0 ? l10n.checkedProgress(0, 0) : l10n.todayEveryoneChecked)
                : l10n.todayNextChild('${next.firstName} ${next.lastInitial}.'),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Pressable(
                  child: ElevatedButton.icon(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SamajhColors.textNavy,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(54),
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 22),
                    label: Text(
                      l10n.startCheckShortcuts,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Pressable(
                child: Tooltip(
                  message: l10n.addChildrenButton,
                  child: OutlinedButton(
                    onPressed: onAddChildren,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: SamajhColors.textNavy,
                      minimumSize: const Size(54, 54),
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: SamajhColors.creamLine, width: 2),
                      shape: const CircleBorder(),
                    ),
                    child: Icon(Icons.person_add_alt_1_rounded, semanticLabel: l10n.addChildrenButton),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TodoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final String noneLabel;
  final VoidCallback onTap;

  const _TodoTile({
    required this.icon,
    required this.title,
    required this.count,
    required this.noneLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = count > 0;
    const big = TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: SamajhColors.textNavy);
    return Pressable(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SamajhRadius.card + 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SamajhRadius.card + 4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(color: SamajhColors.creamSoft, shape: BoxShape.circle),
                  child: Icon(icon, size: 20, color: SamajhColors.textNavy),
                ),
                const SizedBox(height: 14),
                hasData
                    ? CountUpText(count, style: big)
                    : Text(noneLabel, style: big.copyWith(fontSize: 18, color: SamajhColors.textSubtle)),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One bar in shades of a single green (told apart by lightness), plus a
/// plain list with the numbers.
class _SupportGroupsCard extends StatelessWidget {
  final SupportGroupCounts counts;
  final VoidCallback onViewClass;

  const _SupportGroupsCard({required this.counts, required this.onViewClass});

  static const _shades = [SamajhColors.forestGreen, Color(0xFF6FA58E), Color(0xFFA9CDBD), SamajhColors.textNavy];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groups = [
      (l10n.groupOnTrack, counts.onTrack),
      (l10n.groupDecodingShort, counts.needsDecoding),
      (l10n.groupComprehensionShort, counts.needsComprehension),
      (l10n.groupBothShort, counts.needsBoth),
    ];
    final grouped = groups.fold<int>(0, (s, g) => s + g.$2);
    final notGrouped = (counts.all - grouped).clamp(0, 9999);

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 10, 18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(SamajhRadius.card + 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.supportGroupsTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                ),
              ),
              TextButton(
                onPressed: onViewClass,
                style: TextButton.styleFrom(foregroundColor: SamajhColors.textNavy),
                child: Text(l10n.viewClassLink),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                height: 12,
                child: Row(
                  children: [
                    for (var i = 0; i < groups.length; i++)
                      if (groups[i].$2 > 0)
                        Expanded(
                          flex: groups[i].$2,
                          child: Container(color: _shades[i]),
                        ),
                    if (notGrouped > 0 || counts.all == 0)
                      Expanded(
                        flex: notGrouped == 0 ? 1 : notGrouped,
                        child: Container(color: SamajhColors.creamTrack),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < groups.length; i++)
            _LegendRow(color: _shades[i], label: groups[i].$1, count: groups[i].$2),
          _LegendRow(color: SamajhColors.creamTrack, label: l10n.todayNotCheckedYet, count: notGrouped),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const _LegendRow({required this.color, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13, color: SamajhColors.textNavy)),
          ),
          CountUpText(
            count,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final bool isHindi;

  const _PlanCard({required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 10, 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(SamajhRadius.card + 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isHindi ? "10-मिनट योजना" : "10-Minute Plan",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: SamajhColors.creamSoft, borderRadius: BorderRadius.circular(999)),
                child: Text(
                  isHindi ? "10 मिनट" : "10 min",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.warning),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isHindi
                      ? "छोटी और बड़ी मात्रा का खेल (मात्रा अभ्यास)"
                      : "Short and Long Vowel Match (Sound Practice)",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                ),
                const SizedBox(height: 4),
                Text(
                  isHindi
                      ? "शिक्षक श्यामपट्ट पर मात्रा युग्म (दिन/दीन, कुल/कूल) लिखते हैं। बच्चे ज़ोर से पढ़ते हैं।"
                      : "Teacher writes vowel pairs on the board (e.g. sit/seat, ship/sheep). Children read aloud.",
                  style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          TextButton.icon(
            onPressed: () => context.go('/app/practice'),
            style: TextButton.styleFrom(foregroundColor: SamajhColors.textNavy),
            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
            label: Text(isHindi ? "सभी समूह योजनाएं देखें" : "View All Group Plans"),
          ),
        ],
      ),
    );
  }
}
