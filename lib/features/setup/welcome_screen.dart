import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(appLanguageProvider);

    return Scaffold(
      backgroundColor: SamajhColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight > 32 ? constraints.maxHeight - 32 : 500),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      // Kiran mascot (a friendly sun)
                      EntranceFade(
                        offsetY: 28,
                        child: Center(
                          child: Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED), // Warm sun amber tint
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.amber.shade300, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withValues(alpha: 0.15),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.wb_sunny_rounded, size: 48, color: Color(0xFFF59E0B)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // App Name: "Samajh समझ"
                      EntranceFade(
                        index: 1,
                        child: Text(
                          l10n.appTitleDevanagari,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: SamajhColors.textNavy,
                            letterSpacing: -0.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // One line: "See what every child understands"
                      EntranceFade(
                        index: 2,
                        child: Text(
                          l10n.welcomeHeadline,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: SamajhColors.textNavy,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // One line: saying it works without internet
                      EntranceFade(
                        index: 3,
                        child: Text(
                          l10n.welcomeSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: SamajhColors.textMuted,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      // Language Choice (English / Hindi)
                      EntranceFade(
                        index: 4,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: SamajhColors.borderColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.selectLanguage,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: SamajhColors.textMuted,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _LanguageOptionChip(
                                        label: "हिंदी",
                                        isSelected: currentLocale.languageCode == 'hi',
                                        onTap: () async {
                                          ref.read(appLanguageProvider.notifier).state = const Locale('hi');
                                          final db = ref.read(appDatabaseProvider);
                                          await db
                                              .update(db.appSettingsTable)
                                              .write(const AppSettingsTableCompanion(appLanguage: drift.Value('hi')));
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _LanguageOptionChip(
                                        label: "English",
                                        isSelected: currentLocale.languageCode == 'en',
                                        onTap: () async {
                                          ref.read(appLanguageProvider.notifier).state = const Locale('en');
                                          final db = ref.read(appDatabaseProvider);
                                          await db
                                              .update(db.appSettingsTable)
                                              .write(const AppSettingsTableCompanion(appLanguage: drift.Value('en')));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // "Get started" button
                      EntranceFade(
                        index: 5,
                        child: ElevatedButton(
                          key: const Key('welcome_continue_button'),
                          onPressed: () {
                            context.push('/privacy');
                          },
                          child: Text(l10n.getStartedButton),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LanguageOptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOptionChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? SamajhColors.paleMint : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? SamajhColors.forestGreen : SamajhColors.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? SamajhColors.forestGreen : SamajhColors.textNavy,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
