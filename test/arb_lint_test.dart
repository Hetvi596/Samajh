import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ARB Localization Lint and Integrity Tests', () {
    late Map<String, dynamic> enJson;
    late Map<String, dynamic> hiJson;

    setUpAll(() {
      final enFile = File('lib/core/i18n/app_en.arb');
      final hiFile = File('lib/core/i18n/app_hi.arb');

      expect(enFile.existsSync(), isTrue, reason: 'app_en.arb must exist');
      expect(hiFile.existsSync(), isTrue, reason: 'app_hi.arb must exist');

      enJson = jsonDecode(enFile.readAsStringSync()) as Map<String, dynamic>;
      hiJson = jsonDecode(hiFile.readAsStringSync()) as Map<String, dynamic>;
    });

    test('Every English ARB key has a corresponding Hindi translation', () {
      final missingKeys = <String>[];
      for (final key in enJson.keys) {
        if (key.startsWith('@')) continue; // Skip metadata
        if (!hiJson.containsKey(key) || hiJson[key] == null || (hiJson[key] as String).isEmpty) {
          missingKeys.add(key);
        }
      }

      expect(
        missingKeys,
        isEmpty,
        reason: 'The following English keys lack Hindi translations: ${missingKeys.join(", ")}',
      );
    });

    test('No user-facing ARB string contains an em dash (—)', () {
      const emDash = '\u2014'; // Em dash character '—'

      for (final entry in enJson.entries) {
        if (entry.key.startsWith('@')) continue;
        final value = entry.value.toString();
        expect(
          value.contains(emDash),
          isFalse,
          reason: 'English key "${entry.key}" contains an em dash: "$value". Use hyphens or en-dashes instead.',
        );
      }

      for (final entry in hiJson.entries) {
        if (entry.key.startsWith('@')) continue;
        final value = entry.value.toString();
        expect(
          value.contains(emDash),
          isFalse,
          reason: 'Hindi key "${entry.key}" contains an em dash: "$value". Use hyphens or en-dashes instead.',
        );
      }
    });
  });
}
