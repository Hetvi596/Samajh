import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class PrivacyCenterScreen extends ConsumerStatefulWidget {
  const PrivacyCenterScreen({super.key});

  @override
  ConsumerState<PrivacyCenterScreen> createState() => _PrivacyCenterScreenState();
}

class _PrivacyCenterScreenState extends ConsumerState<PrivacyCenterScreen> {
  final _reviewerNameController = TextEditingController();

  @override
  void dispose() {
    _reviewerNameController.dispose();
    super.dispose();
  }

  void _showRecordReviewerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Record Legal & DPDP Review"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter the name of the school authority or legal reviewer who conducted the data protection assessment.",
              style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _reviewerNameController,
              decoration: const InputDecoration(
                labelText: "Reviewer Name",
                hintText: "e.g., Principal S. Sharma",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = _reviewerNameController.text.trim();
              if (name.isNotEmpty) {
                await ref.read(appDatabaseProvider).recordLegalReviewer(name);
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              }
            },
            child: const Text("Save Record"),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteChild(BuildContext context, String childId, String childName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete all records for $childName?"),
        content: const Text(
          "This will permanently erase all check recordings, results, notes, and group assignments for this child from this device.",
          style: TextStyle(fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: SamajhColors.recordingRed),
            onPressed: () async {
              await ref.read(appDatabaseProvider).deleteChildData(childId);
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Records for $childName permanently deleted")),
                );
              }
            },
            child: const Text("Delete Child", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAllData(BuildContext context) {
    final confirmationController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text("Delete All Data", style: TextStyle(color: SamajhColors.recordingRed)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "This action cannot be undone. All classes, children, check histories, and results across both Demo and Real modes will be permanently erased.",
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 14),
              const Text(
                "Type DELETE below to confirm:",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmationController,
                decoration: const InputDecoration(
                  hintText: "DELETE",
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setDialogState(() {}),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: SamajhColors.recordingRed),
              onPressed: confirmationController.text.trim().toUpperCase() == 'DELETE'
                  ? () async {
                      await ref.read(appDatabaseProvider).deleteAllData();
                      if (ctx.mounted) Navigator.pop(ctx);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("All application data has been wiped")),
                        );
                        context.go('/');
                      }
                    }
                  : null,
              child: const Text("Confirm Erase", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsAsync = ref.watch(appSettingsStreamProvider);
    final settings = settingsAsync.value;
    final roster = ref.watch(rosterStreamProvider).value ?? [];
    final consentsMap = ref.watch(consentsStreamProvider).value ?? {};

    final isReviewed = settings?.legalReviewCompleted ?? false;
    final reviewerName = settings?.legalReviewerName;
    final reviewDate = settings?.legalReviewDate;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: const Text("Privacy & Consent Centre"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // DPDP Status Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isReviewed ? SamajhColors.paleMint : const Color(0xFFFFF8E7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isReviewed ? SamajhColors.forestGreen : const Color(0xFFE5B038),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isReviewed ? Icons.verified_user_rounded : Icons.pending_actions_rounded,
                        color: isReviewed ? SamajhColors.forestGreen : const Color(0xFFB57D12),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          isReviewed ? "DPDP Review Completed" : "Legal Review Pending",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isReviewed ? SamajhColors.forestGreen : const Color(0xFF8C5B05),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isReviewed
                        ? "Reviewed by $reviewerName on ${reviewDate?.day}/${reviewDate?.month}/${reviewDate?.year}. Designed in accordance with Digital Personal Data Protection principles."
                        : "Designed for DPDP; legal review pending. The app stores all records locally and requires parental consent for every child.",
                    style: const TextStyle(fontSize: 13, height: 1.4, color: SamajhColors.textNavy),
                  ),
                  if (!isReviewed) ...[
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      onPressed: () => _showRecordReviewerDialog(context),
                      icon: const Icon(Icons.edit_note_rounded, size: 18),
                      label: const Text("Record Legal Reviewer", style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Device & Audio Consent Status (Requirement 5)
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
                  Row(
                    children: [
                      const Icon(Icons.security_rounded, color: SamajhColors.forestGreen),
                      const SizedBox(width: 10),
                      Text(
                        l10n.storageConsentTitle,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (settings?.deviceDataConsentGiven ?? false) ? SamajhColors.paleMint : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (settings?.deviceDataConsentGiven ?? false)
                              ? l10n.storageConsentGiven
                              : l10n.none,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: (settings?.deviceDataConsentGiven ?? false) ? SamajhColors.forestGreen : SamajhColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.storageConsentDesc,
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                  if (settings?.deviceDataConsentDate != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Recorded on: ${settings!.deviceDataConsentDate!.day}/${settings.deviceDataConsentDate!.month}/${settings.deviceDataConsentDate!.year}",
                      style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                    ),
                  ],
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.mic_none_rounded, color: SamajhColors.forestGreen),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.audioConsentTitle,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (settings?.audioRecordingConsentGiven ?? false) ? SamajhColors.paleMint : const Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (settings?.audioRecordingConsentGiven ?? false)
                              ? l10n.audioConsentStatusGranted
                              : l10n.audioConsentStatusWithdrawn,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: (settings?.audioRecordingConsentGiven ?? false) ? SamajhColors.forestGreen : SamajhColors.recordingRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.audioConsentDesc,
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                  if (settings?.audioRecordingConsentDate != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Status updated: ${settings!.audioRecordingConsentDate!.day}/${settings.audioRecordingConsentDate!.month}/${settings.audioRecordingConsentDate!.year}",
                      style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                    ),
                  ],
                  if (!(settings?.audioRecordingConsentGiven ?? false)) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        l10n.audioConsentWithdrawnMessage,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF856404), height: 1.3),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: (settings?.audioRecordingConsentGiven ?? false) ? SamajhColors.recordingRed : SamajhColors.forestGreen,
                      side: BorderSide(
                        color: (settings?.audioRecordingConsentGiven ?? false) ? SamajhColors.recordingRed : SamajhColors.forestGreen,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      final currentGiven = settings?.audioRecordingConsentGiven ?? false;
                      final db = ref.read(appDatabaseProvider);
                      await db.update(db.appSettingsTable).write(
                        AppSettingsTableCompanion(
                          audioRecordingConsentGiven: drift.Value(!currentGiven),
                          audioRecordingConsentDate: drift.Value(DateTime.now()),
                        ),
                      );
                    },
                    icon: Icon(
                      (settings?.audioRecordingConsentGiven ?? false) ? Icons.block_rounded : Icons.check_circle_outline,
                      size: 16,
                    ),
                    label: Text(
                      (settings?.audioRecordingConsentGiven ?? false)
                          ? l10n.withdrawAudioConsent
                          : l10n.grantAudioConsent,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Retention Rules Card (Section 14)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history_toggle_off_rounded, color: SamajhColors.forestGreen),
                      SizedBox(width: 10),
                      Text("Data Retention & Purging Rules", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 12),
                  _RuleRow(
                    title: "Audio Recordings",
                    detail: "Deleted immediately upon saving marks; hard auto-purged after 24 hours.",
                  ),
                  SizedBox(height: 10),
                  _RuleRow(
                    title: "No Photos or OCR",
                    detail: "Zero camera usage, image capture, or OCR. Word checks and reading assessments are completed interactively with no photo uploads.",
                  ),
                  SizedBox(height: 10),
                  _RuleRow(
                    title: "Storage & Encryption",
                    detail: "Database encrypted with AES-256 via SQLite3MultipleCiphers. Key protected by Android Keystore.",
                  ),
                  SizedBox(height: 10),
                  _RuleRow(
                    title: "Zero Analytics & Offline First",
                    detail: "Optional cloud sync is off by default. Zero third-party trackers or ad SDKs. When sync is disabled, all data stays strictly on device with zero network calls.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Child Consent Records Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Consent Records",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                ),
                Text(
                  "${roster.where((c) => consentsMap[c.id] == true).length} of ${roster.length} consented",
                  style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Child Consent List
            if (roster.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: SamajhColors.dividerColor),
                ),
                child: const Center(
                  child: Text("No children in active class.", style: TextStyle(color: SamajhColors.textMuted)),
                ),
              )
            else
              ...roster.map((child) {
                final hasConsent = consentsMap[child.id] ?? false;
                final childName = '${child.firstName} ${child.lastInitial}';

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: SamajhColors.dividerColor),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: hasConsent ? SamajhColors.paleMint : const Color(0xFFFDECEB),
                        child: Icon(
                          hasConsent ? Icons.check_circle_outline : Icons.cancel_outlined,
                          size: 20,
                          color: hasConsent ? SamajhColors.forestGreen : SamajhColors.recordingRed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(childName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            Text(
                              hasConsent ? "Consent recorded" : "No consent / Withdrawn",
                              style: TextStyle(
                                fontSize: 12,
                                color: hasConsent ? SamajhColors.forestGreen : SamajhColors.recordingRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: "Delete child data",
                        icon: const Icon(Icons.delete_outline, size: 20, color: SamajhColors.recordingRed),
                        onPressed: () => _confirmDeleteChild(context, child.id, childName),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 24),
            // Danger Zone Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFF2C2C2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: SamajhColors.recordingRed),
                      SizedBox(width: 10),
                      Text(
                        "Delete All Data",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: SamajhColors.recordingRed),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Permanently wipes all classes, children, check histories, and results from this device. Requires typing DELETE to confirm.",
                    style: TextStyle(fontSize: 12, color: SamajhColors.textNavy, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SamajhColors.recordingRed,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _confirmDeleteAllData(context),
                    child: const Text("Delete All Data"),
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

class _RuleRow extends StatelessWidget {
  final String title;
  final String detail;

  const _RuleRow({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy)),
        const SizedBox(height: 2),
        Text(detail, style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.3)),
      ],
    );
  }
}
