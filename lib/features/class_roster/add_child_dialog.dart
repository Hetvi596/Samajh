import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/sync/auto_sync_manager.dart';

class AddChildDialog extends ConsumerStatefulWidget {
  final String? targetClassId;
  const AddChildDialog({super.key, this.targetClassId});

  @override
  ConsumerState<AddChildDialog> createState() => _AddChildDialogState();
}

class _AddChildDialogState extends ConsumerState<AddChildDialog> {
  final _firstNameController = TextEditingController();
  final _lastInitialController = TextEditingController();
  String _homeLanguage = 'Hindi';
  String? _homeDialect;
  bool _consentGiven = false;
  String? _error;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastInitialController.dispose();
    super.dispose();
  }

  Future<void> _saveChild() async {
    final firstName = _firstNameController.text.trim();
    final lastInitial = _lastInitialController.text.trim();

    if (firstName.isEmpty || lastInitial.isEmpty) {
      setState(() => _error = "First name and last initial are required.");
      return;
    }

    final db = ref.read(appDatabaseProvider);
    ClassesTableData? targetClass;
    if (widget.targetClassId != null) {
      targetClass = await (db.select(db.classesTable)..where((t) => t.id.equals(widget.targetClassId!))).getSingleOrNull();
    }
    targetClass ??= ref.read(activeClassStreamProvider).value;
    if (targetClass == null) {
      setState(() => _error = "No active class found.");
      return;
    }

    final childId = 'child_${DateTime.now().millisecondsSinceEpoch}';

    await db.into(db.childrenTable).insert(
      ChildrenTableCompanion.insert(
        id: childId,
        classId: targetClass.id,
        scope: targetClass.scope,
        firstName: firstName,
        lastInitial: lastInitial.endsWith('.') ? lastInitial : '$lastInitial.',
        homeLanguage: _homeLanguage,
        homeDialect: drift.Value(_homeDialect),
        createdAt: DateTime.now(),
      ),
    );

    if (_consentGiven) {
      await db.into(db.consentsTable).insert(
        ConsentsTableCompanion.insert(
          id: 'consent_$childId',
          childId: childId,
          scope: targetClass.scope,
          consentDate: DateTime.now(),
          consentGiven: const drift.Value(true),
        ),
      );
    }

    // Trigger direct background sync to Supabase if connected
    ref.read(autoSyncManagerProvider).triggerSync();

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(l10n.addChild, style: const TextStyle(fontWeight: FontWeight.w700)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                hintText: "e.g., Aarav",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastInitialController,
              decoration: const InputDecoration(
                labelText: "Last Initial",
                hintText: "e.g., K.",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _homeLanguage,
              decoration: const InputDecoration(
                labelText: "Home Language",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Hindi', child: Text("Hindi")),
                DropdownMenuItem(value: 'Bhojpuri', child: Text("Bhojpuri")),
                DropdownMenuItem(value: 'Awadhi', child: Text("Awadhi")),
                DropdownMenuItem(value: 'English', child: Text("English")),
                DropdownMenuItem(value: 'Urdu', child: Text("Urdu")),
              ],
              onChanged: (val) => setState(() => _homeLanguage = val!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              initialValue: _homeDialect,
              decoration: const InputDecoration(
                labelText: "Home Dialect (Optional)",
                border: OutlineInputBorder(),
                helperText: "Regional variants will not be penalized as mistakes",
              ),
              items: const [
                DropdownMenuItem(value: null, child: Text("Standard / None")),
                DropdownMenuItem(value: 'awadhi_bhojpuri', child: Text("Awadhi / Bhojpuri")),
                DropdownMenuItem(value: 'rajasthani', child: Text("Rajasthani")),
                DropdownMenuItem(value: 'marathi_influenced', child: Text("Marathi-influenced")),
                DropdownMenuItem(value: 'punjabi_influenced', child: Text("Punjabi-influenced")),
              ],
              onChanged: (val) => setState(() => _homeDialect = val),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: SamajhColors.forestGreen,
              value: _consentGiven,
              onChanged: (val) => setState(() => _consentGiven = val ?? false),
              title: const Text(
                "Parental consent given",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                "A child cannot be checked until consent is marked (protects children's privacy under DPDP).",
                style: TextStyle(fontSize: 11, color: SamajhColors.textMuted),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(fontSize: 12, color: SamajhColors.recordingRed),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: _saveChild,
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
