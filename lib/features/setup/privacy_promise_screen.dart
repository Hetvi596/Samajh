import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class PrivacyPromiseScreen extends ConsumerStatefulWidget {
  const PrivacyPromiseScreen({super.key});

  @override
  ConsumerState<PrivacyPromiseScreen> createState() => _PrivacyPromiseScreenState();
}

class _PrivacyPromiseScreenState extends ConsumerState<PrivacyPromiseScreen> {
  bool _consentStorage = false;
  bool _consentAudio = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bothConsented = _consentStorage && _consentAudio;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.privacyTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                children: [
                  Text(
                    l10n.privacySubtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: SamajhColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PrivacyCard(
                    icon: Icons.wifi_off_rounded,
                    title: l10n.privacyPoint1Title,
                    description: l10n.privacyPoint1Desc,
                  ),
                  _PrivacyCard(
                    icon: Icons.mic_off_rounded,
                    title: l10n.privacyPoint2Title,
                    description: l10n.privacyPoint2Desc,
                  ),
                  _PrivacyCard(
                    icon: Icons.person_pin_rounded,
                    title: l10n.privacyPoint3Title,
                    description: l10n.privacyPoint3Desc,
                  ),
                  _PrivacyCard(
                    icon: Icons.shield_rounded,
                    title: l10n.privacyPoint4Title,
                    description: l10n.privacyPoint4Desc,
                  ),
                  const SizedBox(height: 16),

                  // Required Consent Checkbox (a): Local Encrypted Storage & School Approval
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: _consentStorage ? SamajhColors.forestGreen : SamajhColors.dividerColor,
                          width: _consentStorage ? 1.5 : 1,
                        ),
                      ),
                      child: CheckboxListTile(
                        key: const Key('consent_storage_checkbox'),
                        value: _consentStorage,
                        activeColor: SamajhColors.forestGreen,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        onChanged: (val) {
                          setState(() => _consentStorage = val ?? false);
                        },
                        title: Text(
                          l10n.privacyConsentStorage,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: SamajhColors.textNavy,
                            height: 1.4,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),

                  // Required Consent Checkbox (b): Microphone Recording Consent with deletion on check
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: _consentAudio ? SamajhColors.forestGreen : SamajhColors.dividerColor,
                          width: _consentAudio ? 1.5 : 1,
                        ),
                      ),
                      child: CheckboxListTile(
                        key: const Key('consent_audio_checkbox'),
                        value: _consentAudio,
                        activeColor: SamajhColors.forestGreen,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        onChanged: (val) {
                          setState(() => _consentAudio = val ?? false);
                        },
                        title: Text(
                          l10n.privacyConsentAudio,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: SamajhColors.textNavy,
                            height: 1.4,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                key: const Key('privacy_accept_button'),
                onPressed: bothConsented
                    ? () async {
                        final db = ref.read(appDatabaseProvider);
                        final now = DateTime.now();
                        await db.update(db.appSettingsTable).write(
                          AppSettingsTableCompanion(
                            deviceDataConsentGiven: const drift.Value(true),
                            deviceDataConsentDate: drift.Value(now),
                            audioRecordingConsentGiven: const drift.Value(true),
                            audioRecordingConsentDate: drift.Value(now),
                          ),
                        );
                        if (context.mounted) {
                          context.push('/passcode');
                        }
                      }
                    : null,
                child: Text(l10n.privacyAccept),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PrivacyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: SamajhColors.paleMint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: SamajhColors.forestGreen, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: SamajhColors.textNavy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: SamajhColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
