import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String Audit - No Unfinished Text or Em Dashes', () {
    late Map<String, dynamic> enJson;
    late Map<String, dynamic> hiJson;

    setUpAll(() {
      final enFile = File('lib/core/i18n/app_en.arb');
      final hiFile = File('lib/core/i18n/app_hi.arb');

      enJson = jsonDecode(enFile.readAsStringSync()) as Map<String, dynamic>;
      hiJson = jsonDecode(hiFile.readAsStringSync()) as Map<String, dynamic>;
    });

    final forbiddenPatterns = [
      RegExp(r'\bM[1-9]\b'),
      RegExp(r'\bTODO\b', caseSensitive: false),
      RegExp(r'\bcoming soon\b', caseSensitive: false),
      RegExp(r'\bplaceholder\b', caseSensitive: false),
      RegExp(r'\bbuilt in\b', caseSensitive: false),
    ];

    test('No user-visible ARB strings contain unfinished text patterns', () {
      final violations = <String>[];

      for (final entry in enJson.entries) {
        if (entry.key.startsWith('@')) continue;
        final value = entry.value.toString();
        for (final pattern in forbiddenPatterns) {
          if (pattern.hasMatch(value)) {
            violations.add('en: "${entry.key}": "$value" matched ${pattern.pattern}');
          }
        }
      }

      for (final entry in hiJson.entries) {
        if (entry.key.startsWith('@')) continue;
        final value = entry.value.toString();
        for (final pattern in forbiddenPatterns) {
          if (pattern.hasMatch(value)) {
            violations.add('hi: "${entry.key}": "$value" matched ${pattern.pattern}');
          }
        }
      }

      expect(violations, isEmpty, reason: 'Found unfinished strings:\n${violations.join("\n")}');
    });

    test('No user-visible ARB strings contain em dashes (—)', () {
      const emDash = '\u2014';
      final violations = <String>[];

      for (final entry in enJson.entries) {
        if (entry.key.startsWith('@')) continue;
        if (entry.value.toString().contains(emDash)) {
          violations.add('en: "${entry.key}"');
        }
      }

      for (final entry in hiJson.entries) {
        if (entry.key.startsWith('@')) continue;
        if (entry.value.toString().contains(emDash)) {
          violations.add('hi: "${entry.key}"');
        }
      }

      expect(violations, isEmpty, reason: 'Found em dashes in keys: ${violations.join(", ")}');
    });
  });
}
