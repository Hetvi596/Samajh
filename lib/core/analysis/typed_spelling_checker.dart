/// Compares what a child typed with the dictated word and names each kind of
/// mistake, using the same tags as the word-check distractors so both feed
/// the same practice suggestions. Pure Dart; no handwriting or OCR involved.
library;

class TypedSpellingResult {
  final String target;
  final String typed;
  final bool isCorrect;

  /// Mistake tags, most important first (empty when correct).
  final List<String> tags;

  const TypedSpellingResult({required this.target, required this.typed, required this.isCorrect, required this.tags});

  String? get primaryTag => tags.isEmpty ? null : tags.first;
}

class TypedSpellingChecker {
  static const _halant = 0x094D;
  static const _nukta = 0x093C;
  static const _anusvara = 0x0902;
  static const _chandrabindu = 0x0901;
  static const _visarga = 0x0903;

  /// Pairs that look alike in Devanagari and are commonly confused.
  static const _lookAlike = <Set<String>>[
    {'ब', 'व'},
    {'घ', 'ध'},
    {'म', 'भ'},
    {'प', 'ष'},
    {'ड', 'ङ'},
    {'थ', 'य'},
    {'ख', 'स'},
    {'ट', 'ठ'},
    {'द', 'ढ'},
    {'श', 'स'},
  ];

  static const _priority = [
    'dropped_conjunct',
    'short_long_i_ee',
    'short_long_u_oo',
    'wrong_matra',
    'bindu_chandrabindu',
    'nukta',
    'similar_shape_letter',
    'wrong_letter',
    'missing_letter',
    'extra_letter',
  ];

  static bool _isMatra(int r) => (r >= 0x093E && r <= 0x094C) || r == 0x0962 || r == 0x0963;
  static bool _isNasal(int r) => r == _anusvara || r == _chandrabindu;

  /// Removes spaces, punctuation and joiners; lower-cases Latin letters;
  /// writes a nasal half letter before a consonant of its own group as
  /// anusvara, since Hindi spelling accepts both (बन्दर and बंदर).
  static String normalise(String s) => s
      .replaceAll(RegExp(r'[‌‍\s।॥,.?!;:"\x27()\-]'), '')
      .toLowerCase()
      .replaceAllMapped(RegExp('([ङञणनम])्([क-ह])'), (m) => _nasalFor[m[2]] == m[1] ? 'ं${m[2]}' : m[0]!);

  /// The nasal letter of each consonant group (क-वर्ग to प-वर्ग).
  static const _nasalFor = {
    'क': 'ङ', 'ख': 'ङ', 'ग': 'ङ', 'घ': 'ङ', //
    'च': 'ञ', 'छ': 'ञ', 'ज': 'ञ', 'झ': 'ञ', //
    'ट': 'ण', 'ठ': 'ण', 'ड': 'ण', 'ढ': 'ण', //
    'त': 'न', 'थ': 'न', 'द': 'न', 'ध': 'न', //
    'प': 'म', 'फ': 'म', 'ब': 'म', 'भ': 'म', //
  };

  static TypedSpellingResult check(String target, String typed) {
    final t = normalise(target);
    final y = normalise(typed);
    if (t == y) return TypedSpellingResult(target: target, typed: typed, isCorrect: true, tags: const []);
    if (y.isEmpty) {
      return TypedSpellingResult(target: target, typed: typed, isCorrect: false, tags: const ['missing_letter']);
    }

    final a = t.runes.toList();
    final b = y.runes.toList();
    final n = a.length, m = b.length;
    // Levenshtein table, then walk back to find the edits.
    final d = List.generate(n + 1, (i) => List<int>.filled(m + 1, 0));
    for (var i = 0; i <= n; i++) {
      d[i][0] = i;
    }
    for (var j = 0; j <= m; j++) {
      d[0][j] = j;
    }
    for (var i = 1; i <= n; i++) {
      for (var j = 1; j <= m; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        d[i][j] = [d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + cost].reduce((x, z) => x < z ? x : z);
      }
    }

    final tags = <String>{};
    var i = n, j = m;
    while (i > 0 || j > 0) {
      if (i > 0 && j > 0 && a[i - 1] == b[j - 1] && d[i][j] == d[i - 1][j - 1]) {
        i--;
        j--;
      } else if (i > 0 && j > 0 && d[i][j] == d[i - 1][j - 1] + 1) {
        tags.add(_substitution(a[i - 1], b[j - 1]));
        i--;
        j--;
      } else if (i > 0 && d[i][j] == d[i - 1][j] + 1) {
        tags.add(_missing(a[i - 1]));
        i--;
      } else {
        tags.add(_extra(b[j - 1]));
        j--;
      }
    }
    final ordered = tags.toList()..sort((x, z) => _rank(x).compareTo(_rank(z)));
    return TypedSpellingResult(target: target, typed: typed, isCorrect: false, tags: ordered);
  }

  static int _rank(String tag) {
    final r = _priority.indexOf(tag);
    return r < 0 ? _priority.length : r;
  }

  static String _substitution(int want, int got) {
    if (_isMatra(want) && _isMatra(got)) {
      final pair = {want, got};
      if (pair.containsAll({0x093F, 0x0940})) return 'short_long_i_ee';
      if (pair.containsAll({0x0941, 0x0942})) return 'short_long_u_oo';
      return 'wrong_matra';
    }
    if (_isMatra(want) || _isMatra(got)) return 'wrong_matra';
    if (_isNasal(want) || _isNasal(got)) return 'bindu_chandrabindu';
    if (want == _halant || got == _halant) return 'dropped_conjunct';
    if (want == _nukta || got == _nukta) return 'nukta';
    final w = String.fromCharCode(want), g = String.fromCharCode(got);
    if (_lookAlike.any((s) => s.contains(w) && s.contains(g))) return 'similar_shape_letter';
    return 'wrong_letter';
  }

  static String _missing(int want) {
    if (want == _halant) return 'dropped_conjunct';
    if (_isMatra(want)) return 'wrong_matra';
    if (_isNasal(want)) return 'bindu_chandrabindu';
    if (want == _nukta) return 'nukta';
    if (want == _visarga) return 'wrong_matra';
    return 'missing_letter';
  }

  static String _extra(int got) {
    if (got == _halant) return 'dropped_conjunct';
    if (_isMatra(got)) return 'wrong_matra';
    if (_isNasal(got)) return 'bindu_chandrabindu';
    if (got == _nukta) return 'nukta';
    return 'extra_letter';
  }
}
