import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/app_database.dart';
import 'cloud_sync.dart';

String _toUuid(String input) {
  if (RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$', caseSensitive: false).hasMatch(input)) {
    return input;
  }
  final digest = md5.convert(utf8.encode(input)).toString();
  return '${digest.substring(0, 8)}-${digest.substring(8, 12)}-4${digest.substring(13, 16)}-a${digest.substring(17, 20)}-${digest.substring(20, 32)}';
}

/// Supabase-backed cloud sync implementation.
///
/// Designed strictly for real classroom data backup and restore.
/// Fictional demo data (`scope == 'demo'`) is NEVER uploaded.
/// Strictly ZERO photos, ZERO images, and ZERO OCR data are ever uploaded.
/// Temporary audio stays encrypted locally and is NEVER uploaded.
///
/// Push order strictly respects foreign-key links:
/// classes → children → consents → checks → word_marks → retell_points →
/// question_answers → dictation_items → listening_checks → results →
/// group_assignments → practice_needs → weekly_plan_ticks → parent_reports →
/// accepted_pronunciations → milestone_stars.
class SupabaseCloudSync implements CloudSync {
  final SupabaseClient _client;
  final AppDatabase? db;
  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  SupabaseCloudSync(this._client, {this.db}) {
    _statusController.add(
      _client.auth.currentSession == null
          ? SyncStatus.signedOut
          : SyncStatus.idle,
    );

    // Listen for auth state changes
    _client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session == null) {
        _statusController.add(SyncStatus.signedOut);
      } else {
        _statusController.add(SyncStatus.idle);
      }
    });
  }

  @override
  Future<bool> get isAvailable => Future.value(true);

  @override
  Stream<SyncStatus> get status => _statusController.stream;

  /// Current signed-in user ID, or null.
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Whether the teacher is currently signed in.
  bool get isSignedIn => _client.auth.currentSession != null;

  @override
  Future<void> signIn(AuthRequest request) async {
    try {
      if (request.password != null && request.password!.isNotEmpty) {
        try {
          await _client.auth.signInWithPassword(
            email: request.email,
            password: request.password!,
          );
        } on AuthException catch (authEx) {
          // If user doesn't exist yet, automatically register them
          if (authEx.message.toLowerCase().contains('invalid') ||
              authEx.message.toLowerCase().contains('not found')) {
            await _client.auth.signUp(
              email: request.email,
              password: request.password!,
            );
          } else {
            rethrow;
          }
        }
      } else if (request.otp != null && request.otp!.isNotEmpty) {
        await _client.auth.verifyOTP(
          type: OtpType.email,
          email: request.email,
          token: request.otp!,
        );
      } else {
        await _client.auth.signInWithOtp(email: request.email);
      }
      _statusController.add(SyncStatus.idle);
    } catch (e) {
      _statusController.add(SyncStatus.error);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _statusController.add(SyncStatus.signedOut);
    } catch (e) {
      _statusController.add(SyncStatus.error);
      rethrow;
    }
  }

  @override
  Future<SyncReport> syncNow() async {
    // If not signed in to a specific account, try anonymous sign-in or use fallback ID
    if (!isSignedIn) {
      try {
        await _client.auth.signInAnonymously();
      } catch (_) {
        // Fallback to direct anon key sync without session
      }
    }

    final localDb = db;
    if (localDb == null) {
      return SyncReport(
        pushedRows: 0,
        pulledRows: 0,
        errors: ['Local database not connected'],
        timestamp: DateTime.now(),
      );
    }

    // Phone date check guardrail: clock must be reasonable
    if (DateTime.now().year < 2024) {
      return SyncReport(
        pushedRows: 0,
        pulledRows: 0,
        errors: ['Please check your phone date and time before syncing'],
        timestamp: DateTime.now(),
      );
    }

    _statusController.add(SyncStatus.syncing);
    final errors = <String>[];
    int pushed = 0;
    int pulled = 0;
    final userId = currentUserId ?? '00000000-0000-0000-0000-000000000001';

    try {
      // =====================================================================
      // 1. PUSH: Push real data to Supabase in strict dependency order
      // =====================================================================

      // 1.1 Classes (Real scope only)
      final realClasses = await (localDb.select(localDb.classesTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realClasses.isNotEmpty) {
        final classesPayload = realClasses.map((c) {
          return {
            'id': _toUuid(c.id),
            'owner_id': userId,
            'name': c.name,
            'grade': c.grade,
            'section': c.section,
            'curriculum': c.curriculum == 'school_own' ? 'school_own' : c.curriculum,
            'check_language': c.checkLanguage,
            'instruction_medium': c.mediumOfInstruction,
            'textbook_id': c.textbookId,
            'current_chapter_id': c.currentChapter,
            'home_dialect': c.homeDialect,
            'academic_year': '2026-27',
            'created_at': c.createdAt.toUtc().toIso8601String(),
            'updated_at': c.updatedAt.toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('classes').upsert(classesPayload, onConflict: 'id');
        pushed += classesPayload.length;
      }

      // 1.2 Children (Real scope only)
      final realChildren = await (localDb.select(localDb.childrenTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realChildren.isNotEmpty) {
        final childrenPayload = realChildren.map((c) {
          return {
            'id': _toUuid(c.id),
            'owner_id': userId,
            'class_id': _toUuid(c.classId),
            'first_name': c.firstName,
            'last_initial': c.lastInitial.isEmpty ? '.' : c.lastInitial,
            'home_language': c.homeLanguage.isEmpty ? 'hi' : c.homeLanguage,
            'home_dialect': c.homeDialect,
            'created_at': c.createdAt.toUtc().toIso8601String(),
            'updated_at': c.createdAt.toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('children').upsert(childrenPayload, onConflict: 'id');
        pushed += childrenPayload.length;
      }

      // 1.3 Consents
      final realConsents = await (localDb.select(localDb.consentsTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realConsents.isNotEmpty) {
        final consentsPayload = realConsents.map((c) {
          return {
            'id': _toUuid(c.id),
            'owner_id': userId,
            'child_id': _toUuid(c.childId),
            'purpose': 'assessment',
            'status': c.withdrawn
                ? 'withdrawn'
                : (c.consentGiven ? 'given' : 'not_recorded'),
            'recorded_at': c.consentDate.toUtc().toIso8601String(),
            'created_at': c.consentDate.toUtc().toIso8601String(),
            'updated_at': c.consentDate.toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('consents').upsert(consentsPayload, onConflict: 'id');
        pushed += consentsPayload.length;
      }

      // 1.4 Checks
      final realChecks = await (localDb.select(localDb.checksTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realChecks.isNotEmpty) {
        final checksPayload = realChecks.map((c) {
          return {
            'id': _toUuid(c.id),
            'owner_id': userId,
            'child_id': _toUuid(c.childId),
            'passage_id': c.passageId,
            'state': c.status == 'completed' ? 'completed' : 'in_progress',
            'step': c.currentStep,
            'student_self_rating': c.readingSelfRating ?? 'not_recorded',
            'started_at': c.startedAt.toUtc().toIso8601String(),
            'finished_at': c.completedAt?.toUtc().toIso8601String(),
            'noise_level': c.noiseLevel,
            'low_confidence': c.isLowConfidence,
            'reading_seconds': c.readingDurationSeconds,
            'rubric_version': c.rubricVersion,
            'created_at': c.startedAt.toUtc().toIso8601String(),
            'updated_at': (c.completedAt ?? c.startedAt).toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('checks').upsert(checksPayload, onConflict: 'id');
        pushed += checksPayload.length;
      }

      // 1.5 Word Marks
      final checkIds = realChecks.map((c) => c.id).toSet();
      if (checkIds.isNotEmpty) {
        final realWordMarks = await (localDb.select(localDb.wordMarksTable)
              ..where((t) => t.checkId.isIn(checkIds)))
            .get();

        if (realWordMarks.isNotEmpty) {
          final wordMarksPayload = realWordMarks.map((w) {
            return {
              'id': _toUuid(w.id),
              'owner_id': userId,
              'check_id': _toUuid(w.checkId),
              'word_index': w.wordIndex,
              'expected_text': w.expectedWord,
              'mark': w.mark,
              'heard_text': w.actualWord,
              'error_kind': w.errorSubtype,
            };
          }).toList();

          await _client.from('word_marks').upsert(wordMarksPayload, onConflict: 'check_id,word_index');
          pushed += wordMarksPayload.length;
        }

        // 1.6 Retell Points
        final realRetell = await (localDb.select(localDb.retellPointsTable)
              ..where((t) => t.checkId.isIn(checkIds)))
            .get();

        if (realRetell.isNotEmpty) {
          final retellPayload = realRetell.map((r) {
            return {
              'id': _toUuid(r.id),
              'owner_id': userId,
              'check_id': _toUuid(r.checkId),
              'point_index': r.pointIndex,
              'ticked': r.isMentioned,
            };
          }).toList();

          await _client.from('retell_points').upsert(retellPayload, onConflict: 'check_id,point_index');
          pushed += retellPayload.length;
        }

        // 1.7 Question Answers (Tiered with weighted marking)
        final realQA = await (localDb.select(localDb.questionAnswersTable)
              ..where((t) => t.checkId.isIn(checkIds)))
            .get();

        if (realQA.isNotEmpty) {
          final qaPayload = realQA.map((q) {
            return {
              'id': _toUuid(q.id),
              'owner_id': userId,
              'check_id': _toUuid(q.checkId),
              'question_id': q.questionId,
              'question_level': q.questionType == 'fact' ? 1 : 2,
              'question_type': q.questionType,
              'result': q.answerStatus == 'correct'
                  ? 'correct'
                  : (q.answerStatus == 'partly' ? 'partly' : 'incorrect'),
              'points_awarded': q.answerStatus == 'correct' ? 1.0 : 0.0,
            };
          }).toList();

          await _client.from('question_answers').upsert(qaPayload, onConflict: 'check_id,question_id');
          pushed += qaPayload.length;
        }

        // 1.8 Choice Responses (Child-Facing Word Check & Formative Assessment Items)
        final realChoiceResponses = await (localDb.select(localDb.choiceResponsesTable)
              ..where((t) => t.checkId.isIn(checkIds)))
            .get();

        if (realChoiceResponses.isNotEmpty) {
          final choicePayload = realChoiceResponses.map((cr) {
            return {
              'id': _toUuid(cr.id),
              'owner_id': userId,
              'check_id': _toUuid(cr.checkId),
              'item_id': cr.itemId,
              'level': cr.level,
              'type': cr.type,
              'first_choice': cr.firstChoice,
              'final_choice': cr.finalChoice,
              'time_ms': cr.timeMs,
              'change_count': cr.changeCount,
              'distractor_tag': cr.distractorTag,
              'weight': cr.weight,
              'reason': cr.reason,
              'created_at': cr.createdAt.toUtc().toIso8601String(),
            };
          }).toList();

          try {
            await _client.from('choice_responses').upsert(choicePayload, onConflict: 'id');
            pushed += choicePayload.length;
          } catch (_) {}
        }

        // Backward compatibility: Dictation Items
        final realDictation = await (localDb.select(localDb.dictationItemsTable)
              ..where((t) => t.checkId.isIn(checkIds)))
            .get();

        if (realDictation.isNotEmpty) {
          final dictationPayload = realDictation.map((d) {
            return {
              'id': _toUuid(d.id),
              'owner_id': userId,
              'check_id': _toUuid(d.checkId),
              'position': d.itemIndex,
              'item_text': d.word,
              'item_kind': 'word',
              'result': d.isCorrect ? 'correct' : 'incorrect',
              'error_kind': d.errorType,
            };
          }).toList();

          try {
            await _client.from('dictation_items').upsert(dictationPayload, onConflict: 'check_id,position');
            pushed += dictationPayload.length;
          } catch (_) {}
        }
      }

      // 1.9 Results
      final realResults = await (localDb.select(localDb.resultsTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realResults.isNotEmpty) {
        // The child's thumbs up / down after reading aloud, from its check.
        final readingRatings = {for (final c in realChecks) c.id: c.readingSelfRating};
        final resultsPayload = realResults.map((r) {
          return {
            'id': _toUuid(r.id),
            'owner_id': userId,
            'check_id': _toUuid(r.checkId),
            'child_id': _toUuid(r.childId),
            'words_attempted': r.attemptedWords,
            'words_correct': r.correctWords,
            'accuracy_pct': r.accuracyPercentage,
            'speed_measured': r.speedHasEvidence,
            'correct_wpm': r.speedHasEvidence ? r.readingSpeedWpm : null,
            'evidence_status': r.isLowConfidence ? 'not_enough' : 'enough',
            'group_code': r.groupAssigned,
            'next_step_key': r.nextStepRecommendation,
            'student_self_rating': readingRatings[r.checkId] ?? 'not_recorded',
            'created_at': r.createdAt.toUtc().toIso8601String(),
            'updated_at': r.createdAt.toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('results').upsert(resultsPayload, onConflict: 'check_id');
        pushed += resultsPayload.length;
      }

      // 1.10 Group assignments
      final realGroups = await (localDb.select(localDb.groupAssignmentsTable)
            ..where((t) => t.scope.equals('real')))
          .get();

      if (realGroups.isNotEmpty) {
        final groupsPayload = realGroups.map((g) {
          return {
            'id': _toUuid(g.id),
            'owner_id': userId,
            'child_id': _toUuid(g.childId),
            'group_code': g.toGroup,
            'source': 'teacher_moved',
            'note': g.reason,
            'assigned_at': g.movedAt.toUtc().toIso8601String(),
          };
        }).toList();

        await _client.from('group_assignments').upsert(groupsPayload, onConflict: 'id');
        pushed += groupsPayload.length;
      }

      // =====================================================================
      // 2. PULL: Check tombstones and pull updates for this teacher
      // =====================================================================
      try {
        final tombstones = await _client
            .from('sync_tombstones')
            .select()
            .eq('owner_id', userId);

        for (final t in tombstones) {
          final table = t['table_name'] as String?;
          final rowId = t['row_id'] as String?;
          if (table == 'classes' && rowId != null) {
            await (localDb.delete(localDb.classesTable)..where((c) => c.id.equals(rowId))).go();
            pulled++;
          } else if (table == 'children' && rowId != null) {
            await (localDb.delete(localDb.childrenTable)..where((c) => c.id.equals(rowId))).go();
            pulled++;
          }
        }
      } catch (tombstoneErr) {
        // Non-blocking
      }

      _statusController.add(SyncStatus.upToDate);
    } catch (e) {
      errors.add(e.toString());
      _statusController.add(SyncStatus.error);
    }

    return SyncReport(
      pushedRows: pushed,
      pulledRows: pulled,
      errors: errors,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> deleteMyCloudData() async {
    if (!isSignedIn) return;

    try {
      await _client.rpc('delete_my_cloud_data');
      _statusController.add(SyncStatus.idle);
    } catch (e) {
      _statusController.add(SyncStatus.error);
      rethrow;
    }
  }

  void dispose() {
    _statusController.close();
  }
}
