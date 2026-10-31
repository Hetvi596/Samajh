import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cloud_sync.dart';
import 'sync_providers.dart';

/// Manages automatic background synchronization between the local encrypted
/// SQLite database and Supabase.
///
/// Features:
/// 1. Offline-first: Data is ALWAYS written to local SQLite first.
/// 2. Direct upload: Whenever internet is reachable, data uploads automatically
///    to Supabase without requiring manual teacher clicks or backup export files.
/// 3. Resilient: If the device is offline, failures are handled silently,
///    and syncing re-attempts on schedule or on next activity.
class AutoSyncManager {
  final CloudSync _cloudSync;
  Timer? _periodicTimer;
  Timer? _initialTimer;
  bool _isSyncing = false;

  AutoSyncManager(this._cloudSync) {
    _startPeriodicSync();
  }

  void _startPeriodicSync() {
    _initialTimer?.cancel();
    _periodicTimer?.cancel();

    // Do not schedule background timers during tests
    if (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }

    // Immediate initial sync attempt after launch
    _initialTimer = Timer(const Duration(seconds: 2), triggerSync);

    // Periodic sync every 30 seconds
    _periodicTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      triggerSync();
    });
  }

  /// Manually or programmatically trigger an immediate sync (e.g., after adding
  /// a class, adding a student, or completing an assessment).
  Future<void> triggerSync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final report = await _cloudSync.syncNow();
      if (report.hasErrors) {
        debugPrint('[AutoSync] Notice: ${report.errors.join(", ")}');
      } else if (report.pushedRows > 0 || report.pulledRows > 0) {
        debugPrint(
          '[AutoSync] Success: Pushed ${report.pushedRows} rows, pulled ${report.pulledRows} rows.',
        );
      }
    } catch (e) {
      debugPrint('[AutoSync] Offline or connection error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  void dispose() {
    _initialTimer?.cancel();
    _periodicTimer?.cancel();
  }
}

/// Provider for AutoSyncManager.
final autoSyncManagerProvider = Provider<AutoSyncManager>((ref) {
  final cloudSync = ref.watch(cloudSyncProvider);
  final manager = AutoSyncManager(cloudSync);
  ref.onDispose(() => manager.dispose());
  return manager;
});
