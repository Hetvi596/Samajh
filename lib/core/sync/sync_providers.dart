import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/database_provider.dart';
import 'cloud_sync.dart';
import 'noop_cloud_sync.dart';
import 'supabase_cloud_sync.dart';

/// Provider for the Supabase client instance.
/// Returns null if Supabase has not been initialized yet.
final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  try {
    return Supabase.instance.client;
  } catch (_) {
    return null;
  }
});

/// Provider for the CloudSync implementation.
/// Uses SupabaseCloudSync when initialized; falls back to NoopCloudSync.
final cloudSyncProvider = Provider<CloudSync>((ref) {
  final client = ref.watch(supabaseClientProvider);
  if (client == null) {
    return NoopCloudSync();
  }
  final db = ref.watch(appDatabaseProvider);
  return SupabaseCloudSync(client, db: db);
});

/// Stream provider exposing the current sync status to the UI.
final syncStatusProvider = StreamProvider<SyncStatus>((ref) {
  final cloudSync = ref.watch(cloudSyncProvider);
  return cloudSync.status;
});

/// Provider exposing whether cloud sync is available in this build.
final isCloudAvailableProvider = FutureProvider<bool>((ref) {
  final cloudSync = ref.watch(cloudSyncProvider);
  return cloudSync.isAvailable;
});
