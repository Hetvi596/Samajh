import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/speech/reading_alignment.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';

List<HeardWord> heard(String text, {double conf = 0.95}) =>
    text.split(' ').where((w) => w.isNotEmpty).map((w) => HeardWord(w, conf: conf)).toList();

void main() {
  const passage = ['राम', 'मेले', 'में', 'गया।', 'वह', 'खुश', 'हुआ।'];

  test('every word read: all correct, nothing to check', () {
    final r = alignReading(passage, heard('राम मेले में गया वह खुश हुआ'));
    expect(r.marks.values.every((m) => m == WordMark.correct), isTrue);
    expect(r.needsCheck, isEmpty);
  });

  test('a mispronounced word comes out as unknown and is marked for the teacher', () {
    final r = alignReading(passage, heard('राम [unk] में गया वह खुश हुआ'));
    expect(r.marks[1], WordMark.readAsAnotherWord);
    expect(r.heardAs.containsKey(1), isFalse, reason: 'unknown is not a word to show');
    expect(r.needsCheck, {1});
    expect(r.marks[0], WordMark.correct);
    expect(r.marks[2], WordMark.correct);
  });

  test('a word read as another passage word keeps what was heard', () {
    final r = alignReading(passage, heard('राम मेले में गया राम खुश हुआ'));
    expect(r.marks[4], WordMark.readAsAnotherWord);
    expect(r.heardAs[4], 'राम');
  });

  test('a word left out in the middle is skipped', () {
    final r = alignReading(passage, heard('राम मेले गया वह खुश हुआ'));
    expect(r.marks[2], WordMark.skipped);
    expect(r.needsCheck, contains(2));
    expect(r.marks[3], WordMark.correct);
  });

  test('stopping early: the rest is not reached, not wrong', () {
    final r = alignReading(passage, heard('राम मेले में'));
    expect([for (var i = 0; i < 3; i++) r.marks[i]], everyElement(WordMark.correct));
    expect([for (var i = 3; i < 7; i++) r.marks[i]], everyElement(WordMark.notReached));
    expect(r.needsCheck, isEmpty);
  });

  test('repeating a word does not shift the marks', () {
    final r = alignReading(passage, heard('राम मेले मेले में गया वह खुश हुआ'));
    expect(r.marks.values.every((m) => m == WordMark.correct), isTrue);
  });

  test('a correct word heard with low confidence is sent to the teacher', () {
    final words = heard('राम मेले में गया वह खुश हुआ');
    words[5] = const HeardWord('खुश', conf: 0.3);
    final r = alignReading(passage, words);
    expect(r.marks[5], WordMark.correct);
    expect(r.needsCheck, {5});
  });

  test('nothing heard: every word not reached', () {
    final r = alignReading(passage, const []);
    expect(r.marks.values, everyElement(WordMark.notReached));
  });

  test('punctuation, nukta and chandrabindu do not count as mistakes', () {
    expect(normalizeSpokenWord('पढ़ा।'), normalizeSpokenWord('पढा'));
    expect(normalizeSpokenWord('हँसा'), normalizeSpokenWord('हंसा'));
    expect(normalizeSpokenWord('"Ram,"'), 'ram');
  });

  test('grammar lists each passage word once plus unknown', () {
    final g = recognitionGrammar(['राम', 'राम।', 'गया']);
    expect(g, ['राम', 'गया', '[unk]']);
  });

  test('reads Vosk result JSON', () {
    final words = parseRecognizerResults([
      '{"result":[{"conf":0.98,"end":1.2,"start":0.6,"word":"राम"}],"text":"राम"}',
      '{"text":""}',
      'not json',
    ]);
    expect(words.single.word, 'राम');
    expect(words.single.conf, 0.98);
  });
}
