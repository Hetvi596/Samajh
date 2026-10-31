import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class PrivacyChecklistScreen extends ConsumerStatefulWidget {
  const PrivacyChecklistScreen({super.key});

  @override
  ConsumerState<PrivacyChecklistScreen> createState() => _PrivacyChecklistScreenState();
}

class _PrivacyChecklistScreenState extends ConsumerState<PrivacyChecklistScreen> {
  bool _point1 = false;
  bool _point2 = false;
  bool _point4 = false;

  bool get _allChecked => _point1 && _point2 && _point4;

  Future<void> _enableRealMode() async {
    final db = ref.read(appDatabaseProvider);
    // Switch active scope to 'real'
    await db.update(db.appSettingsTable).write(
      const AppSettingsTableCompanion(
        activeScope: drift.Value('real'),
      ),
    );
    ref.read(activeScopeProvider.notifier).state = 'real';

    // Write audit event without personal data
    await db.into(db.auditEventsTable).insert(
      AuditEventsTableCompanion.insert(
        id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
        eventType: 'REAL_MODE_ENABLED',
        details: const drift.Value('Teacher verified all 3 privacy checklist gates and enabled Real class mode'),
        timestamp: DateTime.now(),
      ),
    );

    if (mounted) {
      context.pop();
      context.go('/app/today');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.privacyChecklistTitle),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                children: [
                  Text(
                    l10n.privacyChecklistSubtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SamajhColors.textNavy,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ChecklistTile(
                    value: _point1,
                    text: l10n.privacyChecklist1,
                    onChanged: (val) => setState(() => _point1 = val ?? false),
                  ),
                  _ChecklistTile(
                    value: _point2,
                    text: l10n.privacyChecklist2,
                    onChanged: (val) => setState(() => _point2 = val ?? false),
                  ),
                  _ChecklistTile(
                    value: _point4,
                    text: l10n.privacyChecklist4,
                    onChanged: (val) => setState(() => _point4 = val ?? false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                key: const Key('enable_real_mode_button'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _allChecked ? SamajhColors.forestGreen : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                ),
                onPressed: _allChecked ? _enableRealMode : null,
                child: Text(l10n.switchToRealMode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistTile extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool?> onChanged;

  const _ChecklistTile({
    required this.value,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? SamajhColors.forestGreen : SamajhColors.dividerColor,
          width: value ? 1.5 : 1,
        ),
      ),
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        value: value,
        activeColor: SamajhColors.forestGreen,
        onChanged: onChanged,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: SamajhColors.textNavy,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
