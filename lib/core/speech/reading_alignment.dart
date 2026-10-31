import 'dart:convert';

import '../../features/check_flow/check_flow_controller.dart' show WordMark;

/// One word the speech recogniser heard, with its time and confidence.
class HeardWord {
  final String word;
  final double start;
  final double end;
  final double conf;

  const HeardWord(this.word, {this.start = 0, this.end = 0, this.conf = 1});

  bool get isUnknown => word == unknownToken;

  static const unknownToken = '[unk]';
}

/// What the app decided for each passage word, and which ones the teacher
/// should check by ear.
class AutoMarkResult {
  final Map<int, WordMark> marks;

  /// Words the teacher should listen to again: every word not marked
  /// correct, and correct words heard with low confidence.
  final Set<int> needsCheck;

  /// What the recogniser heard in place of a word, when it was another word.
  final Map<int, String> heardAs;

  const AutoMarkResult({required this.marks, required this.needsCheck, required this.heardAs});

  int get markedWrong => marks.values.where((m) => m == WordMark.readAsAnotherWord || m == WordMark.skipped).length;
}

/// Makes a passage word and a recognised word comparable: no punctuation,
/// no nukta (the model often drops it), chandrabindu treated as bindu,
/// English in lower case with apostrophes kept inside words (let's).
String normalizeSpokenWord(String raw) {
  var w = raw.trim().toLowerCase().replaceAll('’', "'");
  w = w.replaceAll(RegExp(r'''[।॥,.!?;:"“”‘()\[\]\-–—…]'''), '');
  w = w.replaceAll(RegExp(r"^'+|'+$"), '');
  w = w.replaceAll('़', ''); // nukta
  w = w.replaceAll('ँ', 'ं'); // chandrabindu -> bindu
  return w;
}

/// The words to listen for: each distinct passage word once, plus the
/// "unknown" token so a mispronounced word comes out as unknown rather than
/// being forced onto a passage word.
List<String> recognitionGrammar(List<String> passageWords) {
  final seen = <String>{};
  for (final w in passageWords) {
    final n = normalizeSpokenWord(w);
    if (n.isNotEmpty) seen.add(n);
  }
  return [...seen, HeardWord.unknownToken];
}

/// Reads the words out of Vosk result JSON strings ({"result": [...]}).
List<HeardWord> parseRecognizerResults(Iterable<String> jsonResults) {
  final words = <HeardWord>[];
  for (final raw in jsonResults) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) continue;
      final list = decoded['result'];
      if (list is! List) continue;
      for (final item in list) {
        if (item is! Map) continue;
        final w = '${item['word'] ?? ''}'.trim();
        if (w.isEmpty) continue;
        words.add(
          HeardWord(
            w,
            start: (item['start'] as num?)?.toDouble() ?? 0,
            end: (item['end'] as num?)?.toDouble() ?? 0,
            conf: (item['conf'] as num?)?.toDouble() ?? 1,
          ),
        );
      }
    } catch (_) {}
  }
  return words;
}

/// Lines up what was heard against the passage (fewest edits), then marks
/// each passage word:
/// - heard as itself: correct (checked by the teacher if confidence is low);
/// - heard as something else or as unknown: read as another word;
/// - nothing heard for it, with reading after it: skipped;
/// - nothing heard from there to the end: not reached.
/// Extra heard words (repeats, filler) are ignored.
AutoMarkResult alignReading(List<String> passage, List<HeardWord> heard, {double minConfidence = 0.6}) {
  final p = passage.map(normalizeSpokenWord).toList();
  final h = heard.map((w) => normalizeSpokenWord(w.word)).toList();
  final n = p.length, m = h.length;

  // cost[i][j]: edits to align p[i..] with h[j..].
  final cost = List.generate(n + 1, (_) => List<int>.filled(m + 1, 0));
  for (var i = n; i >= 0; i--) {
    for (var j = m; j >= 0; j--) {
      if (i == n) {
        cost[i][j] = m - j;
      } else if (j == m) {
        cost[i][j] = n - i;
      } else {
        final same = p[i] == h[j] ? 0 : 1;
        cost[i][j] = [
          cost[i + 1][j + 1] + same,
          cost[i + 1][j] + 1, // passage word not heard
          cost[i][j + 1] + 1, // extra heard word
        ].reduce((a, b) => a < b ? a : b);
      }
    }
  }

  final marks = <int, WordMark>{};
  final needsCheck = <int>{};
  final heardAs = <int, String>{};
  var lastHeardIndex = -1;
  var i = 0, j = 0;
  while (i < n) {
    if (j < m && cost[i][j] == cost[i + 1][j + 1] + (p[i] == h[j] ? 0 : 1)) {
      if (p[i] == h[j]) {
        marks[i] = WordMark.correct;
        if (heard[j].conf < minConfidence) needsCheck.add(i);
      } else {
        marks[i] = WordMark.readAsAnotherWord;
        if (!heard[j].isUnknown) heardAs[i] = heard[j].word;
        needsCheck.add(i);
      }
      lastHeardIndex = i;
      i++;
      j++;
    } else if (j < m && cost[i][j] == cost[i][j + 1] + 1) {
      j++; // extra word the child said
    } else {
      marks[i] = WordMark.skipped;
      needsCheck.add(i);
      i++;
    }
  }

  // Words after the last one heard were not reached, not skipped.
  for (var k = lastHeardIndex + 1; k < n; k++) {
    marks[k] = WordMark.notReached;
    needsCheck.remove(k);
  }

  return AutoMarkResult(marks: marks, needsCheck: needsCheck, heardAs: heardAs);
}
