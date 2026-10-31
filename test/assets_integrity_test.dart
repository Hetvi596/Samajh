import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bundled Assets Integrity and Schema Tests', () {
    test('Offline font files exist and are populated', () {
      final fontFiles = [
        'assets/fonts/inter/Inter-Regular.ttf',
        'assets/fonts/inter/Inter-Medium.ttf',
        'assets/fonts/inter/Inter-SemiBold.ttf',
        'assets/fonts/inter/Inter-Bold.ttf',
        'assets/fonts/inter/Inter-ExtraBold.ttf',
        'assets/fonts/noto_sans_devanagari/NotoSansDevanagari-Regular.ttf',
        'assets/fonts/noto_sans_devanagari/NotoSansDevanagari-Medium.ttf',
        'assets/fonts/noto_sans_devanagari/NotoSansDevanagari-SemiBold.ttf',
        'assets/fonts/noto_sans_devanagari/NotoSansDevanagari-Bold.ttf',
      ];

      for (final path in fontFiles) {
        final file = File(path);
        expect(file.existsSync(), isTrue, reason: 'Font file missing: $path');
        expect(file.lengthSync(), greaterThan(100000), reason: 'Font file too small: $path');
      }
    });

    test('Thresholds configuration is valid JSON and marked provisional', () {
      final file = File('assets/config/thresholds.json');
      expect(file.existsSync(), isTrue);
      final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(jsonMap['status'], equals('provisional'));
      expect(jsonMap['security']['passcode_length'], equals(6));
      expect(jsonMap['security']['auto_lock_seconds'], equals(120));
      expect(jsonMap['scoring']['dictation_item_count'], equals(5));
    });

    test('Curriculum benchmarks registry contains Classes 1 to 5', () {
      final file = File('assets/curriculum/benchmarks.json');
      expect(file.existsSync(), isTrue);
      final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final grades = jsonMap['grades'] as Map<String, dynamic>;
      expect(grades.containsKey('1'), isTrue);
      expect(grades.containsKey('2'), isTrue);
      expect(grades.containsKey('3'), isTrue);
      expect(grades.containsKey('4'), isTrue);
      expect(grades.containsKey('5'), isTrue);

      // Class 1, 4, 5 should have no official speed target
      expect(grades['1']['has_official_speed_target'], isFalse);
      expect(grades['4']['has_official_speed_target'], isFalse);
      expect(grades['5']['has_official_speed_target'], isFalse);

      // Class 2 and 3 have official targets
      expect(grades['2']['has_official_speed_target'], isTrue);
      expect(grades['2']['target_wpm'], equals(45));
      expect(grades['3']['has_official_speed_target'], isTrue);
      expect(grades['3']['target_wpm'], equals(60));
      expect(grades['3']['fls_meets_min'], equals(35));
      expect(grades['3']['fls_meets_max'], equals(54));
    });

    test('Curriculum registry contains 4 curricula and textbooks', () {
      final file = File('assets/curriculum/registry.json');
      expect(file.existsSync(), isTrue);
      final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final curricula = jsonMap['curricula'] as List;
      expect(curricula.length, greaterThanOrEqualTo(4));
      final textbookList = jsonMap['textbooks'] as List;
      expect(textbookList.length, greaterThanOrEqualTo(8));
    });

    test('Passage bank has at least 2 passages per grade 1-5', () {
      final file = File('assets/passages/bank.json');
      expect(file.existsSync(), isTrue);
      final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final passages = jsonMap['passages'] as List;
      expect(passages.length, greaterThanOrEqualTo(10));

      for (int grade = 1; grade <= 5; grade++) {
        final gradePassages = passages.where((p) => p['grade'] == grade).toList();
        expect(
          gradePassages.length,
          greaterThanOrEqualTo(2),
          reason: 'Grade $grade must have at least 2 passages in the bank',
        );
      }
    });

    test('Activities bank contains 14 activities in English and Hindi', () {
      final file = File('assets/practice/activities.json');
      expect(file.existsSync(), isTrue);
      final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final activities = jsonMap['activities'] as List;
      expect(activities.length, equals(14));

      for (final act in activities) {
        expect(act['title_en'], isNotEmpty);
        expect(act['title_hi'], isNotEmpty);
        expect(act['instructions_en'], isNotEmpty);
        expect(act['instructions_hi'], isNotEmpty);
        expect(act['home_activity_en'], isNotEmpty);
        expect(act['home_activity_hi'], isNotEmpty);
      }
    });
  });
}
