import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentAppLocale = ref.watch(appLanguageProvider);
    final readingLang = ref.watch(readingLanguageProvider);
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final teacherProfile = ref.watch(teacherProfileStreamProvider).value;
    final gradeNumber = activeClass?.grade ?? 3;

    final isHindi = currentAppLocale.languageCode == 'hi';

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              key: const Key('settings_profile_chip'),
              onTap: () => context.push('/profile'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: SamajhColors.paleMint,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: SamajhColors.forestGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: SamajhColors.forestGreen,
                      child: Text(
                        teacherProfile?.teacherName.isNotEmpty == true ? teacherProfile!.teacherName[0].toUpperCase() : 'T',
                        style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      teacherProfile?.teacherName ?? (isHindi ? "शिक्षक" : "Teacher"),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: SamajhColors.forestGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Teacher Profile Card
            InkWell(
              onTap: () => context.push('/profile'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: SamajhColors.dividerColor),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: SamajhColors.paleMint,
                      child: Text(
                        teacherProfile?.teacherName.isNotEmpty == true ? teacherProfile!.teacherName[0].toUpperCase() : 'T',
                        style: const TextStyle(fontSize: 16, color: SamajhColors.forestGreen, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacherProfile?.teacherName ?? (isHindi ? "शिक्षक प्रोफ़ाइल" : "Teacher Profile"),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            teacherProfile?.schoolName?.isNotEmpty == true
                                ? teacherProfile!.schoolName!
                                : l10n.profileTitle,
                            style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            // 1. Active Class Profile Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SamajhColors.paleMint,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.school, color: SamajhColors.forestGreen, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activeClass?.name ?? (isHindi ? "कक्षा" : "Class"),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: SamajhColors.textNavy,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${l10n.gradeLabel} ${activeClass?.grade ?? 3} · ${l10n.sectionLabel} ${activeClass?.section ?? 'A'} · ${activeClass?.checkLanguage == 'en' ? 'English' : 'हिंदी'}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: SamajhColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: SamajhColors.forestGreen),
                    tooltip: l10n.classSettingsTitle,
                    onPressed: () => context.push('/class_settings'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Two separate language segmented controls (Section 12)
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
                  // 1. App Language Segmented Control
                  Text(
                    isHindi
                        ? "ऐप भाषा (मेनू, शीर्षक, बटन)"
                        : "App language (menus, headings, buttons)",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 10),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'hi', label: Text("हिंदी")),
                      ButtonSegment(value: 'en', label: Text("English")),
                    ],
                    selected: {currentAppLocale.languageCode},
                    onSelectionChanged: (newSelection) async {
                      final selected = newSelection.first;
                      ref.read(appLanguageProvider.notifier).state = Locale(selected);
                      final db = ref.read(appDatabaseProvider);
                      await db.update(db.appSettingsTable).write(
                        AppSettingsTableCompanion(
                          appLanguage: drift.Value(selected),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // 2. Children's Reading Language Segmented Control
                  Text(
                    isHindi
                        ? "बच्चों की पठन भाषा (गद्यांश, आवाज़ संकेत)"
                        : "Children's reading language (passages, voice prompts)",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 10),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'hi', label: Text("हिंदी (Hindi)")),
                      ButtonSegment(value: 'en', label: Text("English")),
                    ],
                    selected: {readingLang},
                    onSelectionChanged: (newSelection) async {
                      final selected = newSelection.first;
                      ref.read(readingLanguageProvider.notifier).state = selected;
                      final db = ref.read(appDatabaseProvider);
                      await db.update(db.appSettingsTable).write(
                        AppSettingsTableCompanion(
                          readingLanguage: drift.Value(selected),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Cadence & Scheduling Card (Section 12)
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
                    isHindi ? "जांच की अवधि और अनुस्मारक" : "Check Cadence & Reminders",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 12),
                  // Suggested Checks Window
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "सुझाई गई जांच अवधि" : "Suggested checks window",
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              isHindi ? "पूरी कक्षा की जांच पूरी करने के दिन" : "Days to complete whole class check",
                              style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<int>(
                        value: ref.watch(appSettingsStreamProvider).value?.suggestedChecksWindowDays ?? 5,
                        items: [
                          DropdownMenuItem(value: 3, child: Text(isHindi ? "3 दिन" : "3 days")),
                          DropdownMenuItem(value: 5, child: Text(isHindi ? "5 दिन (डिफ़ॉल्ट)" : "5 days (default)")),
                          DropdownMenuItem(value: 10, child: Text(isHindi ? "10 दिन" : "10 days")),
                        ],
                        onChanged: (val) async {
                          if (val != null) {
                            final db = ref.read(appDatabaseProvider);
                            await db.update(db.appSettingsTable).write(
                              AppSettingsTableCompanion(suggestedChecksWindowDays: drift.Value(val)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  // Recheck Period
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "पुनः जांच की अवधि" : "Recheck due period",
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              isHindi ? "बच्चे की पुनः जांच कार्य-सूची में दिखने का समय" : "Time before child recheck appears in to-do",
                              style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      DropdownButton<int>(
                        value: ref.watch(appSettingsStreamProvider).value?.recheckPeriodWeeks ?? 3,
                        items: [
                          DropdownMenuItem(value: 2, child: Text(isHindi ? "2 सप्ताह" : "2 weeks")),
                          DropdownMenuItem(value: 3, child: Text(isHindi ? "3 सप्ताह (डिफ़ॉल्ट)" : "3 weeks (default)")),
                          DropdownMenuItem(value: 4, child: Text(isHindi ? "4 सप्ताह" : "4 weeks")),
                        ],
                        onChanged: (val) async {
                          if (val != null) {
                            final db = ref.read(appDatabaseProvider);
                            await db.update(db.appSettingsTable).write(
                              AppSettingsTableCompanion(recheckPeriodWeeks: drift.Value(val)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Cloud Auto-Sync Status Card (Direct background sync)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: ListTile(
                leading: const Icon(Icons.cloud_done_outlined, color: SamajhColors.forestGreen),
                title: Text(isHindi ? "क्लाउड ऑटो-सिंक" : "Cloud Auto-Sync", style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  isHindi
                      ? "इंटरनेट कनेक्ट होने पर डेटा सीधे सुपबेस पर सुरक्षित होता है"
                      : "Directly syncs to Supabase whenever connected to internet",
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.check_circle, color: SamajhColors.forestGreen, size: 20),
              ),
            ),
            // Milestones & Documents Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.menu_book_outlined, color: SamajhColors.forestGreen),
                    title: Text(l10n.classMilestonesTitle(gradeNumber), style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(isHindi ? "कक्षा अनुसार आधिकारिक लक्ष्य (कक्षा 1 से 5)" : "Official targets by class (Classes 1 to 5)", style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/milestones'),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined, color: SamajhColors.forestGreen),
                    title: Text(isHindi ? "गोपनीयता और सहमति केंद्र" : "Privacy & Consent Centre", style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(isHindi ? "DPDP चेकलिस्ट स्थिति, सहमति रिकॉर्ड और प्रतिधारण नियम" : "DPDP checklist status, consent records & retention rules", style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/privacy_center'),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: SamajhColors.forestGreen),
                    title: Text(isHindi ? "के बारे में और आधिकारिक स्रोत" : "About & Official Sources", style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text("NCERT FLS 2022, NIPUN Guidelines, NCF-FS", style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/about'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
