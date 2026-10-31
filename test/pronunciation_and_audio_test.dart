import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/devanagari_engine.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';

void main() {
  group('Devanagari Akshara & Pronunciation Engine Tests', () {
    test('cleanWord cleanly removes punctuation and quotation marks', () {
      expect(DevanagariAksharaEngine.cleanWord('हवा।'), equals('हवा'));
      expect(DevanagariAksharaEngine.cleanWord('"सूरज"'), equals('सूरज'));
      expect(DevanagariAksharaEngine.cleanWord("'छिड़'"), equals('छिड़'));
      expect(DevanagariAksharaEngine.cleanWord('(बहस?)'), equals('बहस'));
    });

    test('segmentWord segments complex syllables and identifies phonetic categories', () {
      // 1. Long Matra: सूरज -> सू (long matra) - र (consonant) - ज (consonant)
      final surajSegments = DevanagariAksharaEngine.segmentWord('सूरज');
      expect(surajSegments.length, equals(3));
      expect(surajSegments[0].text, equals('सू'));
      expect(surajSegments[0].category, equals('long_matra'));
      expect(surajSegments[1].text, equals('र'));
      expect(surajSegments[2].text, equals('ज'));

      // 2. Short Matra & Nukta: छिड़ -> छि (short matra) - ड़ (nukta)
      final chhidSegments = DevanagariAksharaEngine.segmentWord('छिड़');
      expect(chhidSegments.length, equals(2));
      expect(chhidSegments[0].text, equals('छि'));
      expect(chhidSegments[0].category, equals('short_matra'));
      expect(chhidSegments[1].text, equals('ड़'));
      expect(chhidSegments[1].category, equals('nukta'));

      // 3. Conjunct: क्या -> क्या (conjunct)
      final kyaSegments = DevanagariAksharaEngine.segmentWord('क्या');
      expect(kyaSegments.length, equals(1));
      expect(kyaSegments[0].text, equals('क्या'));
      expect(kyaSegments[0].category, equals('conjunct'));
    });

    test('getRegionalVariants provides valid Hindi dialect substitutions', () {
      // 'व' -> 'ब' (Bhojpuri/Maithili/Eastern Hindi: हवा -> हबा)
      final havaVariants = DevanagariAksharaEngine.getRegionalVariants('हवा');
      expect(havaVariants, contains('हबा'));

      // 'श' -> 'स' (शाबाश -> साबास)
      final shabashVariants = DevanagariAksharaEngine.getRegionalVariants('शाबाश');
      expect(shabashVariants, contains('साबास'));

      // 'ड़' -> 'ड' or 'र' (छिड़ -> छिड, छिर)
      final chhidVariants = DevanagariAksharaEngine.getRegionalVariants('छिड़');
      expect(chhidVariants, contains('छिड'));
      expect(chhidVariants, contains('छिर'));
    });

    test('checkPronunciationMatch handles exact, regional dialect, and phonetic mismatch', () {
      // Exact match
      final match1 = DevanagariAksharaEngine.checkPronunciationMatch('सूरज', 'सूरज');
      expect(match1.isExact, isTrue);
      expect(match1.isAcceptedRegional, isFalse);

      // Regional accent match (हवा vs हबा)
      final match2 = DevanagariAksharaEngine.checkPronunciationMatch('हवा', 'हबा');
      expect(match2.isExact, isFalse);
      expect(match2.isAcceptedRegional, isTrue);
      expect(match2.feedbackNote, contains('क्षेत्रीय बोली'));

      // Pronunciation mismatch (सूरज vs सुरज: short instead of long matra)
      final match3 = DevanagariAksharaEngine.checkPronunciationMatch('सूरज', 'सुरज');
      expect(match3.isExact, isFalse);
      expect(match3.isAcceptedRegional, isFalse);
      expect(match3.detectedErrorType, equals('long oo matra'));
    });
  });

  group('CheckSessionState Word Marking & Regional Pronunciation Tests', () {
    test('CheckSessionState maintains regional pronunciations and error subtypes', () {
      const state = CheckSessionState(
        checkId: 'chk_123',
        childId: 'child_1',
        childName: 'रोहन',
        passage: {'id': 'passage_1', 'title': 'सूरज और हवा'},
        passageWords: ['हवा', 'सूरज', 'तेज़', 'चली'],
        wordMarks: {0: WordMark.correct, 1: WordMark.correct, 2: WordMark.correct, 3: WordMark.correct},
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
        currentStep: CheckStep.markReading,
        micPermissionGranted: true,
        audioPath: '/tmp/test_reading.wav',
        regionalAcceptedWords: {0},
        wordErrorSubtypes: {1: 'short matra'},
      );

      expect(state.micPermissionGranted, isTrue);
      expect(state.audioPath, equals('/tmp/test_reading.wav'));
      expect(state.regionalAcceptedWords.contains(0), isTrue);
      expect(state.wordErrorSubtypes[1], equals('short matra'));
      expect(state.wordMarks[0], equals(WordMark.correct));
    });
  });
}
