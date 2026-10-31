import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/database/app_database.dart';

/// Real upgrade: build a database, strip the v7 columns and mark it v6,
/// then reopen so the v6 -> v7 migration has to add them back.
void main() {
  test('v6 database upgrades to v7: rating, level and marks columns are added, old rows kept', () async {
    final dir = Directory.systemTemp.createTempSync('samajh_v7');
    final file = File('${dir.path}/samajh.db');
    addTearDown(() => dir.deleteSync(recursive: true));

    var db = AppDatabase(NativeDatabase(file));
    expect(db.schemaVersion, greaterThanOrEqualTo(7));
    await db.customSelect('SELECT 1').get(); // forces creation and seeding
    final now = DateTime.now();
    await db.into(db.questionAnswersTable).insert(
          QuestionAnswersTableCompanion.insert(
            id: 'qa_old',
            checkId: 'check_old',
            questionId: 'q1',
            questionType: 'fact',
            answerStatus: 'correct',
          ),
        );
    for (final (table, column) in const [
      ('checks_table', 'reading_self_rating'),
      ('choice_responses_table', 'max_marks'),
      ('choice_responses_table', 'self_rating'),
      ('question_answers_table', 'level'),
      ('question_answers_table', 'time_ms'),
      ('question_answers_table', 'marks'),
      ('question_answers_table', 'max_marks'),
      ('question_answers_table', 'self_rating'),
      ('results_table', 'typing_score'),
      ('results_table', 'self_rating_summary_json'),
    ]) {
      await db.customStatement('ALTER TABLE $table DROP COLUMN $column');
    }
    await db.customStatement('PRAGMA user_version = 6');
    await db.close();

    db = AppDatabase(NativeDatabase(file));
    addTearDown(db.close);
    final old = await (db.select(db.questionAnswersTable)..where((t) => t.id.equals('qa_old'))).getSingle();
    expect(old.answerStatus, 'correct', reason: 'existing answers survive');
    expect(old.level, 1, reason: 'existing answers default to Level 1');
    expect(old.marks, isNull);

    await db.into(db.questionAnswersTable).insert(
          QuestionAnswersTableCompanion.insert(
            id: 'qa_new',
            checkId: 'check_new',
            questionId: 'q3',
            questionType: 'why_how',
            answerStatus: 'partly',
            level: const drift.Value(3),
            timeMs: const drift.Value(42000),
            marks: const drift.Value(1.2),
            maxMarks: const drift.Value(3.0),
            selfRating: const drift.Value('thumbs_down'),
          ),
        );
    final fresh = await (db.select(db.questionAnswersTable)..where((t) => t.id.equals('qa_new'))).getSingle();
    expect((fresh.level, fresh.maxMarks, fresh.selfRating), (3, 3.0, 'thumbs_down'));

    await db.into(db.choiceResponsesTable).insert(
          ChoiceResponsesTableCompanion.insert(
            id: 'cr_new',
            checkId: 'check_new',
            itemId: 'typing_l2_01',
            level: 2,
            type: 'typed_spelling',
            timeMs: 25000,
            maxMarks: const drift.Value(2.0),
            selfRating: const drift.Value('thumbs_up'),
            createdAt: now,
          ),
        );
    final cr = await (db.select(db.choiceResponsesTable)..where((t) => t.id.equals('cr_new'))).getSingle();
    expect((cr.maxMarks, cr.selfRating), (2.0, 'thumbs_up'));
  });
}
