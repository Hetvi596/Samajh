import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Manifest Security and Offline Compliance Gates', () {
    test('Main AndroidManifest declares INTERNET permission for Supabase sync', () {
      final mainManifest = File('android/app/src/main/AndroidManifest.xml');
      expect(mainManifest.existsSync(), isTrue);
      final content = mainManifest.readAsStringSync();
      expect(
        content.contains('android.permission.INTERNET'),
        isTrue,
        reason: 'Main AndroidManifest must declare INTERNET permission for Supabase cloud sync.',
      );
    });

    test('Main AndroidManifest disables auto-backup for child privacy', () {
      final mainManifest = File('android/app/src/main/AndroidManifest.xml');
      expect(mainManifest.existsSync(), isTrue);
      final content = mainManifest.readAsStringSync();
      expect(content.contains('android:allowBackup="false"'), isTrue);
      expect(content.contains('android:fullBackupContent="false"'), isTrue);
    });

    test('Microphone permission is declared in main AndroidManifest', () {
      final mainManifest = File('android/app/src/main/AndroidManifest.xml');
      expect(mainManifest.existsSync(), isTrue);
      final content = mainManifest.readAsStringSync();
      expect(content.contains('android.permission.RECORD_AUDIO'), isTrue);
    });
  });
}
