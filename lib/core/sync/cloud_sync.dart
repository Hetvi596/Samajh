/// CloudSync interface — defines the contract for cloud backup/sync.
///
/// Two implementations exist:
/// - [NoopCloudSync]: offline flavour, does nothing.
/// - [SupabaseCloudSync]: sync flavour, backs up to Supabase.
library;

/// Status of the sync engine.
enum SyncStatus {
  idle,
  offline,
  signedOut,
  syncing,
  error,
  upToDate,
}

/// Report returned after a sync cycle.
class SyncReport {
  final int pushedRows;
  final int pulledRows;
  final List<String> errors;
  final DateTime timestamp;

  const SyncReport({
    required this.pushedRows,
    required this.pulledRows,
    required this.errors,
    required this.timestamp,
  });

  bool get hasErrors => errors.isNotEmpty;
}

/// Auth request for sign-in (email code, password, or OTP).
class AuthRequest {
  final String email;
  final String? otp;
  final String? password;

  const AuthRequest({required this.email, this.otp, this.password});
}

/// Abstract contract for cloud sync operations.
abstract class CloudSync {
  /// Whether cloud sync is available in this build flavour.
  Future<bool> get isAvailable;

  /// Stream of current sync status.
  Stream<SyncStatus> get status;

  /// Sign in with the given auth request.
  Future<void> signIn(AuthRequest request);

  /// Sign out and stop syncing.
  Future<void> signOut();

  /// Push local changes then pull remote changes.
  Future<SyncReport> syncNow();

  /// Delete all of this teacher's data from the cloud.
  Future<void> deleteMyCloudData();
}
