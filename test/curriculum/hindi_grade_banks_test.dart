import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/grade_bank.dart';
import 'package:samajh/core/analysis/typed_spelling_checker.dart';
import 'package:samajh/features/check_flow/typing_check_step_view.dart';

Map<String, dynamic> _json(String path) => jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  final wordCheck = _json('assets/practice/word_check_bank.json');
  final typing = _json('assets/practice/typing_bank.json');
  final passages = _json('assets/passages/bank.json');
  final outcomeIds = {
    for (final o in _json('assets/curriculum/hindi_outcomes_g1_3.json')['outcomes'] as List) (o as Map)['id'] as String,
  };

  group('levelsForGrade', () {
    const bank = {
      'hindi': {
        'level_1': ['shared1'],
        'level_2': ['shared2'],
      },
      'hindi_by_grade': {
        '1': {
          'level_1': ['own1'],
        },
      },
      'english': {
        'level_1': ['en1'],
      },
    };

    test('a class with its own levels uses them and keeps shared ones it lacks', () {
      final l = levelsForGrade(bank, isHindi: true, grade: 1);
      expect(l['level_1'], ['own1']);
      expect(l['level_2'], ['shared2']);
    });

    test('a class without its own entry, and English, use the shared bank', () {
      expect(levelsForGrade(bank, isHindi: true, grade: 4)['level_1'], ['shared1']);
      expect(levelsForGrade(bank, isHindi: false, grade: 1)['level_1'], ['en1']);
    });
  });

  group('Hindi Class 1-3 word check bank', () {
    final byGrade = wordCheck['hindi_by_grade'] as Map<String, dynamic>;

    test('Classes 1, 2 and 3 each have four levels with enough items', () {
      expect(byGrade.keys, containsAll(['1', '2', '3']));
      for (final g in ['1', '2', '3']) {
        for (var lvl = 1; lvl <= 4; lvl++) {
          final items = (byGrade[g] as Map)['level_$lvl'] as List;
          expect(items.length, greaterThanOrEqualTo(4), reason: 'class $g level $lvl');
        }
      }
    });

    test('every item: one right answer, four different options, known outcomes, awaiting review', () {
      final ids = <String>{};
      for (final g in ['1', '2', '3']) {
        for (var lvl = 1; lvl <= 4; lvl++) {
          for (final raw in (byGrade[g] as Map)['level_$lvl'] as List) {
            final item = raw as Map<String, dynamic>;
            final id = item['id'] as String;
            expect(ids.add(id), isTrue, reason: 'duplicate id $id');
            expect(item['level'], lvl, reason: id);
            final options = (item['options'] as List).cast<Map<String, dynamic>>();
            expect(options.length, 4, reason: id);
            expect(options.where((o) => o['is_correct'] == true).length, 1, reason: id);
            final isDrawing = item['type'] == 'writing_position' || item['type'] == 'letter_formation';
            final distinct = isDrawing ? options.map((o) => o['position_style']) : options.map((o) => o['text']);
            expect(distinct.toSet().length, 4, reason: id);
            for (final o in options.where((o) => o['is_correct'] != true)) {
              expect(o['distractor_tag'], isNotNull, reason: id);
            }
            final outs = (item['outcomes'] as List).cast<String>();
            expect(outs, isNotEmpty, reason: id);
            expect(outcomeIds, containsAll(outs), reason: id);
            expect(item['status'], 'awaiting teacher review', reason: id);
          }
        }
      }
    });
  });

  group('Hindi Class 1-3 typing words', () {
    test('each class has three levels and loads through TypingBank', () {
      for (final g in [1, 2, 3]) {
        final bank = TypingBank.fromJson(typing, isHindi: true, grade: g);
        expect(bank.levels, [1, 2, 3], reason: 'class $g');
        for (final words in bank.byLevel.values) {
          expect(words.length, greaterThanOrEqualTo(2));
        }
      }
      expect(
        TypingBank.fromJson(typing, isHindi: true, grade: 1).byLevel[1],
        isNot(TypingBank.fromJson(typing, isHindi: true, grade: 3).byLevel[1]),
      );
    });

    test('Class 4 still uses the shared list', () {
      final shared = TypingBank.fromJson(typing, isHindi: true, grade: 4);
      expect(shared.byLevel[1], (typing['hindi'] as Map)['level_1']);
    });
  });

  test('Class 1-3 passage questions point to checked outcomes', () {
    for (final p in (passages['passages'] as List).cast<Map<String, dynamic>>()) {
      if ((p['grade'] as int) > 3) continue;
      expect(outcomeIds, containsAll((p['ncert_outcomes'] as List).cast<String>()), reason: p['id'] as String);
      for (final q in (p['questions'] as List).cast<Map<String, dynamic>>()) {
        expect(outcomeIds, contains(q['outcome']), reason: q['id'] as String);
      }
      expect(p['word_count'], (p['text_hi'] as String).split(RegExp(r'\s+')).length, reason: p['id'] as String);
    }
  });

  group('typed spelling: both standard nasal spellings count', () {
    test('बन्दर and चन्द्रमा match the anusvara spelling', () {
      expect(TypedSpellingChecker.check('बंदर', 'बन्दर').isCorrect, isTrue);
      expect(TypedSpellingChecker.check('चंद्रमा', 'चन्द्रमा').isCorrect, isTrue);
      expect(TypedSpellingChecker.check('पंप', 'पम्प').isCorrect, isTrue);
    });

    test('a nasal from the wrong group is still a mistake', () {
      expect(TypedSpellingChecker.check('बंदर', 'बम्दर').isCorrect, isFalse);
      expect(TypedSpellingChecker.check('बंदर', 'बदर').isCorrect, isFalse);
    });
  });
}
