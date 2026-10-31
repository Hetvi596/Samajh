import 'dart:async';
import 'cloud_sync.dart';

/// Offline flavour implementation — sync is not available.
/// All operations are no-ops. Settings screen hides cloud options
/// when this implementation is active.
class NoopCloudSync implements CloudSync {
  @override
  Future<bool> get isAvailable => Future.value(false);

  @override
  Stream<SyncStatus> get status => Stream.value(SyncStatus.offline);

  @override
  Future<void> signIn(AuthRequest request) async {
    // No-op in offline flavour
  }

  @override
  Future<void> signOut() async {
    // No-op in offline flavour
  }

  @override
  Future<SyncReport> syncNow() async {
    return SyncReport(
      pushedRows: 0,
      pulledRows: 0,
      errors: [],
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> deleteMyCloudData() async {
    // No-op in offline flavour
  }
}
