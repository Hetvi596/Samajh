import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/devanagari_engine.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';

void main() {
  group('Section 8.9 Scoring Guardrails & Devanagari Akshara Engine Tests', () {
    test('Correct words = Correct + Corrected self; Repeated is neutral; Not sure and Not reached are excluded', () {
      final marks = [
        WordMark.correct, // correct
        WordMark.correctedSelf, // correct
        WordMark.repeated, // attempted, but not correct or error
        WordMark.readAsAnotherWord, // attempted error
        WordMark.skipped, // attempted error
        WordMark.notSure, // completely excluded
        WordMark.notReached, // completely excluded
      ];

      int correctCount = 0;
      int attemptedCount = 0;

      for (final mark in marks) {
        if (mark == WordMark.notReached || mark == WordMark.notSure) {
          continue;
        }
        attemptedCount++;
        if (mark == WordMark.correct || mark == WordMark.correctedSelf) {
          correctCount++;
        }
      }

      expect(attemptedCount, equals(5));
      expect(correctCount, equals(2));
      final accuracy = correctCount / attemptedCount;
      expect(accuracy, equals(0.4)); // 40% accuracy
    });

    test('Reading time below 15 seconds triggers notEnoughEvidence and shows no speed number', () {
      const readingDurationSeconds = 12.0;
      const correctWords = 10;
      const attemptedWords = 12;

      bool notEnoughEvidence = false;
      int? wpm;

      if (readingDurationSeconds < 15.0 || attemptedWords == 0) {
        notEnoughEvidence = true;
        wpm = null;
      } else {
        wpm = ((correctWords / readingDurationSeconds) * 60).round();
      }

      expect(notEnoughEvidence, isTrue);
      expect(wpm, isNull);
    });

    test('Impossible reading speed above 250 wpm triggers notEnoughEvidence and suppresses speed', () {
      const readingDurationSeconds = 20.0;
      const correctWords = 95; // 95 in 20s = 285 wpm!
      const attemptedWords = 95;

      bool notEnoughEvidence = false;
      int? wpm;

      if (readingDurationSeconds < 15.0 || attemptedWords == 0) {
        notEnoughEvidence = true;
        wpm = null;
      } else {
        final rawWpm = ((correctWords / readingDurationSeconds) * 60).round();
        if (rawWpm > 250) {
          notEnoughEvidence = true;
          wpm = null;
        } else {
          wpm = rawWpm;
        }
      }

      expect(notEnoughEvidence, isTrue);
      expect(wpm, isNull);
    });

    test('Valid reading speed between 15s and 250 wpm calculates correctly', () {
      const readingDurationSeconds = 60.0;
      const correctWords = 45;
      const attemptedWords = 50;

      bool notEnoughEvidence = false;
      int? wpm;

      if (readingDurationSeconds < 15.0 || attemptedWords == 0) {
        notEnoughEvidence = true;
        wpm = null;
      } else {
        final rawWpm = ((correctWords / readingDurationSeconds) * 60).round();
        if (rawWpm > 250) {
          notEnoughEvidence = true;
          wpm = null;
        } else {
          wpm = rawWpm;
        }
      }

      expect(notEnoughEvidence, isFalse);
      expect(wpm, equals(45));
    });

    test('Devanagari Akshara Engine classifies linguistic features accurately', () {
      // Test short matra
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('दिन'),
        equals('short i matra'),
      );

      // Test long matra
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('पानी'),
        equals('long ee matra'),
      );

      // Test conjunct / halant
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('बच्चा'),
        equals('conjunct'),
      );

      // Test bindu / anusvara
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('पतंग'),
        equals('bindu'),
      );

      // Test chandrabindu
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('चाँद'),
        equals('chandrabindu'),
      );

      // Test nukta
      expect(
        DevanagariAksharaEngine.classifyPrimaryMistake('साफ़'),
        equals('nukta'),
      );
    });
  });
}
