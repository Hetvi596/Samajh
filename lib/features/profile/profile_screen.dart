import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/security/passcode_service.dart';
import 'class_students_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _showChangePasscodeDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final pass1Controller = TextEditingController();
    final pass2Controller = TextEditingController();
    String? errorText;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) {
          return AlertDialog(
            title: Text(l10n.changePasscode),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: pass1Controller,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: l10n.enterPasscode,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: pass2Controller,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: l10n.confirmPasscode,
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(l10n.cancelButton),
              ),
              ElevatedButton(
                onPressed: () async {
                  final p1 = pass1Controller.text.trim();
                  final p2 = pass2Controller.text.trim();
                  if (p1.length != 6 || p2.length != 6) {
                    setDialogState(() => errorText = "Passcode must be 6 digits");
                    return;
                  }
                  if (p1 != p2) {
                    setDialogState(() => errorText = l10n.passcodesDoNotMatch);
                    return;
                  }

                  final hash = ref.read(passcodeProvider.notifier).hashPasscode(p1);
                  final db = ref.read(appDatabaseProvider);
                  await db.update(db.appSettingsTable).write(
                    AppSettingsTableCompanion(
                      passcodeHash: drift.Value(hash),
                    ),
                  );
                  ref.read(passcodeProvider.notifier).setPasscode(p1);

                  if (ctx.mounted) Navigator.of(ctx).pop();
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.profileUpdated),
                      backgroundColor: SamajhColors.forestGreen,
                    ),
                  );
                },
                child: Text(l10n.saveButton),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showChangeLanguageDialog(TeacherProfileTableData profile) async {
    final l10n = AppLocalizations.of(context)!;
    String selectedLang = profile.preferredLanguage;

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) {
          return AlertDialog(
            title: Text(l10n.changeLanguage),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('हिंदी (Hindi)'),
                  value: 'hi',
                  // ignore: deprecated_member_use
                  groupValue: selectedLang,
                  // ignore: deprecated_member_use
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedLang = val);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'en',
                  // ignore: deprecated_member_use
                  groupValue: selectedLang,
                  // ignore: deprecated_member_use
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedLang = val);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(null),
                child: Text(l10n.cancelButton),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(selectedLang),
                child: Text(l10n.saveButton),
              ),
            ],
          );
        },
      ),
    );

    if (result != null && mounted) {
      final db = ref.read(appDatabaseProvider);
      await db.saveTeacherProfile(
        teacherName: profile.teacherName,
        schoolName: profile.schoolName,
        preferredLanguage: result,
      );
      await db.update(db.appSettingsTable).write(
        AppSettingsTableCompanion(
          appLanguage: drift.Value(result),
        ),
      );
      ref.read(appLanguageProvider.notifier).state = Locale(result);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileUpdated),
            backgroundColor: SamajhColors.forestGreen,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(teacherProfileStreamProvider);
    final db = ref.watch(appDatabaseProvider);
    final scope = ref.watch(activeScopeProvider);
    final classesStream = (db.select(db.classesTable)
          ..where((t) => t.scope.equals(scope))
          ..orderBy([(t) => drift.OrderingTerm.asc(t.grade), (t) => drift.OrderingTerm.asc(t.section)]))
        .watch();

    final profile = profileAsync.value ??
        TeacherProfileTableData(
          id: 'default',
          teacherName: 'Teacher',
          preferredLanguage: 'hi',
          updatedAt: DateTime.now(),
        );

    final isHindi = profile.preferredLanguage == 'hi';

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: SamajhColors.textNavy),
            tooltip: "Menu",
            onSelected: (val) {
              if (val == 'edit') {
                context.push('/profile_edit');
              } else if (val == 'passcode') {
                _showChangePasscodeDialog();
              } else if (val == 'language') {
                _showChangeLanguageDialog(profile);
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, size: 20, color: SamajhColors.textNavy),
                    const SizedBox(width: 10),
                    Text(l10n.editProfile),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'passcode',
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline, size: 20, color: SamajhColors.textNavy),
                    const SizedBox(width: 10),
                    Text(l10n.changePasscode),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'language',
                child: Row(
                  children: [
                    const Icon(Icons.language_outlined, size: 20, color: SamajhColors.textNavy),
                    const SizedBox(width: 10),
                    Text(l10n.changeLanguage),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // 1. Teacher Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: SamajhColors.paleMint,
                        child: Text(
                          profile.teacherName.isNotEmpty ? profile.teacherName[0].toUpperCase() : 'T',
                          style: const TextStyle(
                            fontSize: 26,
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
                              profile.teacherName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: SamajhColors.textNavy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.schoolName?.isNotEmpty == true
                                  ? profile.schoolName!
                                  : (isHindi ? "विद्यालय का नाम दर्ज नहीं है" : "No school specified"),
                              style: const TextStyle(
                                fontSize: 14,
                                color: SamajhColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  Row(
                    children: [
                      const Icon(Icons.translate, size: 20, color: SamajhColors.textMuted),
                      const SizedBox(width: 10),
                      Text(
                        l10n.preferredLanguageLabel,
                        style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isHindi ? 'हिंदी' : 'English',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: SamajhColors.forestGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _ProfileDetailsCard(profile: profile),
            const SizedBox(height: 24),

            // 2. Classes Header + Add Class Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.classesITeach,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: SamajhColors.textNavy,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/class_setup'),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.addClassButton),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SamajhColors.forestGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 3. Classes List
            StreamBuilder<List<ClassesTableData>>(
              stream: classesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final classes = snapshot.data ?? [];
                if (classes.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: SamajhColors.dividerColor),
                    ),
                    child: Center(
                      child: Text(
                        l10n.none,
                        style: const TextStyle(color: SamajhColors.textMuted, fontSize: 14),
                      ),
                    ),
                  );
                }

                return StreamBuilder<List<ChildrenTableData>>(
                  stream: (db.select(db.childrenTable)..where((t) => t.scope.equals(scope))).watch(),
                  builder: (context, childrenSnapshot) {
                    final allChildren = childrenSnapshot.data ?? [];

                    return Column(
                      children: classes.map((c) {
                        final studentCount = allChildren.where((child) => child.classId == c.id).length;
                        final curriculumDisplay = c.curriculum == 'up'
                            ? 'UP Basic Shiksha'
                            : (c.curriculum == 'ncert' ? 'NCERT / CBSE' : c.curriculum.toUpperCase());
                        final langDisplay = c.checkLanguage == 'en' ? 'English' : 'हिंदी';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ClassStudentsScreen(classId: c.id),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: SamajhColors.dividerColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: SamajhColors.paleMint,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.class_outlined, color: SamajhColors.forestGreen, size: 24),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: SamajhColors.textNavy,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "${l10n.gradeLabel} ${c.grade}${c.section.isNotEmpty ? ' · Section ${c.section}' : ''} · $curriculumDisplay · $langDisplay",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: SamajhColors.textMuted,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          l10n.studentCount(studentCount),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: SamajhColors.forestGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// What the teacher has entered about themselves, with a button to edit it.
class _ProfileDetailsCard extends StatelessWidget {
  final TeacherProfileTableData profile;

  const _ProfileDetailsCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final roles = {
      'teacher': l10n.roleTeacher,
      'head_teacher': l10n.roleHeadTeacher,
      'para_teacher': l10n.roleParaTeacher,
      'other': l10n.roleOther,
    };
    final states = {
      'rajasthan': l10n.stateRajasthan,
      'uttar_pradesh': l10n.stateUttarPradesh,
      'other': l10n.stateOther,
    };
    final place = [profile.block, profile.district, states[profile.state]]
        .where((v) => v != null && v.trim().isNotEmpty)
        .join(', ');
    final rows = <(IconData, String, String?)>[
      (Icons.badge_outlined, l10n.profileDisplayName, profile.displayName),
      (Icons.work_outline_rounded, l10n.profileRole, roles[profile.role]),
      (Icons.pin_outlined, l10n.profileUdise, profile.udiseCode),
      (Icons.place_outlined, '${l10n.profileBlock} / ${l10n.profileDistrict}', place.isEmpty ? null : place),
      (
        Icons.timeline_rounded,
        l10n.profileYears,
        profile.yearsTeaching == null ? null : l10n.profileYearsValue(profile.yearsTeaching!)
      ),
      (Icons.phone_outlined, l10n.profilePhone, profile.phone),
      (Icons.mail_outline_rounded, l10n.profileEmail, profile.email),
    ];
    final missing = rows.where((r) => r.$3 == null || r.$3!.trim().isEmpty).length;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 10, 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(SamajhRadius.card + 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.profileDetailsTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                ),
              ),
              TextButton.icon(
                key: const Key('profile_edit_details_button'),
                onPressed: () => context.push('/profile_edit'),
                style: TextButton.styleFrom(foregroundColor: SamajhColors.textNavy),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(l10n.editProfile),
              ),
            ],
          ),
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Row(
                children: [
                  Icon(r.$1, size: 18, color: SamajhColors.textMuted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(r.$2, style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted)),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      (r.$3 == null || r.$3!.trim().isEmpty) ? l10n.profileNotAdded : r.$3!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: (r.$3 == null || r.$3!.trim().isEmpty) ? SamajhColors.textSubtle : SamajhColors.textNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (missing >= 4) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: () => context.push('/profile_edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SamajhColors.textNavy,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(l10n.profileCompleteCta),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
