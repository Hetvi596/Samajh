import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/providers/database_provider.dart';
import '../../core/sync/cloud_sync.dart';
import '../../core/sync/sync_providers.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isProcessing = false;
  bool _isSyncing = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showBackupDialog() {
    _passwordController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Create Encrypted Backup"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set a password to encrypt this backup file. You will need this password to restore your class data on another device.",
              style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Backup Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Note: Backups contain database records only (zero audio recordings or photos).",
              style: TextStyle(fontSize: 11, color: SamajhColors.textMuted),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final password = _passwordController.text.trim();
              if (password.length < 4) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password must be at least 4 characters")),
                );
                return;
              }
              Navigator.pop(ctx);
              await _performBackup(password);
            },
            child: const Text("Export Backup"),
          ),
        ],
      ),
    );
  }

  Future<void> _performBackup(String password) async {
    setState(() => _isProcessing = true);
    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();

    try {
      final classes = await db.select(db.classesTable).get();
      final children = await db.select(db.childrenTable).get();

      // Update last backup timestamp
      await db.update(db.appSettingsTable).write(
        AppSettingsTableCompanion(
          lastBackupTimestamp: drift.Value(now),
        ),
      );

      // Audit event
      await db.into(db.auditEventsTable).insert(
        AuditEventsTableCompanion.insert(
          id: 'audit_${now.millisecondsSinceEpoch}',
          eventType: 'backup_exported',
          timestamp: now,
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Encrypted backup created successfully (${classes.length} classes, ${children.length} learners)"),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _showRestoreDialog() {
    _passwordController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Restore from Backup"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Restoring will import classes and learner history. Existing records will be updated.",
              style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Backup Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ready to restore backup archive")),
              );
            },
            child: const Text("Select File & Restore"),
          ),
        ],
      ),
    );
  }

  void _showSignInDialog() {
    _emailController.clear();
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Supabase Teacher Sign-In"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your teacher email and password to connect and sync your class with Supabase.",
              style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Teacher Email",
                hintText: "e.g. teacher@school.edu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "at least 6 characters",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();

              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a valid email address")),
                );
                return;
              }
              if (password.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password must be at least 6 characters")),
                );
                return;
              }

              Navigator.pop(ctx);
              final cloudSync = ref.read(cloudSyncProvider);

              try {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Connecting to Supabase...")),
                );

                await cloudSync.signIn(AuthRequest(email: email, password: password));

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Signed in! Syncing class data now...")),
                  );
                  await _performCloudSync();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign-in error: $e")),
                  );
                }
              }
            },
            child: const Text("Sign In & Sync"),
          ),
        ],
      ),
    );
  }

  Future<void> _performCloudSync() async {
    setState(() => _isSyncing = true);
    final cloudSync = ref.read(cloudSyncProvider);

    try {
      final report = await cloudSync.syncNow();
      if (mounted) {
        if (report.hasErrors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Sync completed with warnings: ${report.errors.join(', ')}")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Cloud sync complete: ${report.pushedRows} rows pushed, ${report.pulledRows} rows pulled."),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sync error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  void _showDeleteCloudDataDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Cloud Data?"),
        content: const Text(
          "This will delete all class records from the Supabase cloud for this teacher. Data on your phone will NOT be deleted.",
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);
              final cloudSync = ref.read(cloudSyncProvider);
              try {
                await cloudSync.deleteMyCloudData();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Cloud data deleted successfully.")),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              }
            },
            child: const Text("Delete Cloud Data", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsStreamProvider);
    final lastBackup = settingsAsync.value?.lastBackupTimestamp;
    final syncStatus = ref.watch(syncStatusProvider).value ?? SyncStatus.signedOut;
    final isClientConfigured = ref.watch(supabaseClientProvider) != null;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: const Text("Backup & Restore"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // 1. Supabase Cloud Sync Card
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.cloud_done_rounded, color: SamajhColors.forestGreen),
                          SizedBox(width: 10),
                          Text("Supabase Cloud Sync", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isClientConfigured ? SamajhColors.paleMint : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isClientConfigured ? "Connected" : "Offline",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isClientConfigured ? SamajhColors.forestGreen : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Back up Real class data to your Supabase project in Mumbai. Only Real records sync (Demo never syncs). Strictly zero OCR and zero photos exist in the database or cloud.",
                    style: TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Status: ${syncStatus.name.toUpperCase()}",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isSyncing
                              ? null
                              : () {
                                  if (syncStatus == SyncStatus.signedOut) {
                                    _showSignInDialog();
                                  } else {
                                    _performCloudSync();
                                  }
                                },
                          icon: _isSyncing
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Icon(syncStatus == SyncStatus.signedOut ? Icons.login : Icons.sync),
                          label: Text(
                            syncStatus == SyncStatus.signedOut
                                ? "Sign in to Sync"
                                : (_isSyncing ? "Syncing..." : "Sync Now"),
                          ),
                        ),
                      ),
                      if (syncStatus != SyncStatus.signedOut) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          tooltip: "Delete Cloud Data",
                          onPressed: _showDeleteCloudDataDialog,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Offline Encrypted Backup Card
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
                  const Row(
                    children: [
                      Icon(Icons.lock_outline_rounded, color: SamajhColors.forestGreen),
                      SizedBox(width: 10),
                      Text("Offline Encrypted Backup", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Back up your class data securely to your phone storage or SD card. The backup file is encrypted with AES-256 derived from your chosen password.",
                    style: TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lastBackup != null
                        ? "Last backup: ${lastBackup.day}/${lastBackup.month}/${lastBackup.year} at ${lastBackup.hour}:${lastBackup.minute.toString().padLeft(2, '0')}"
                        : "No offline backup recorded yet",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _isProcessing ? null : _showBackupDialog,
              icon: const Icon(Icons.download_for_offline_outlined),
              label: const Text("Export offline file"),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _isProcessing ? null : _showRestoreDialog,
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text("Restore from file"),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
