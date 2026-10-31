library devanagari_engine;

import 'dart:convert';

/// Devanagari Akshara Engine for linguistic classification of reading/spelling errors
/// and precise phonetic segmentation for pronunciation verification.
/// Classifies mistakes by linguistic component: consonant, short/long matra,
/// conjunct, halant, anusvara (bindu), chandrabindu, nukta.

class AksharaSegment {
  final String text; // e.g. "सू"
  final String category; // 'consonant', 'long_matra', 'short_matra', 'conjunct', 'nukta', 'bindu'
  final String categoryLabelHi; // e.g. "दीर्घ 'ऊ' मात्रा (ू)"
  final String categoryLabelEn; // e.g. "Long 'oo' matra (ू)"
  final String phoneticNoteHi; // e.g. "खिंचाव के साथ लम्बी ध्वनि (oo sound)"
  final String phoneticNoteEn; // e.g. "Stretched long 'oo' sound"

  const AksharaSegment({
    required this.text,
    required this.category,
    required this.categoryLabelHi,
    required this.categoryLabelEn,
    required this.phoneticNoteHi,
    required this.phoneticNoteEn,
  });
}

class PronunciationResult {
  final bool isExact;
  final bool isAcceptedRegional;
  final String? matchedRegionalVariant;
  final String feedbackNote;
  final String? detectedErrorType;

  const PronunciationResult({
    required this.isExact,
    required this.isAcceptedRegional,
    this.matchedRegionalVariant,
    required this.feedbackNote,
    this.detectedErrorType,
  });
}

class DevanagariAksharaEngine {
  static const String halant = '\u094D';
  static const String anusvara = '\u0902';
  static const String chandrabindu = '\u0901';
  static const String nukta = '\u093C';

  static const Set<String> shortMatras = {
    '\u093F', // िक (chhoti i)
    '\u0941', // ुक (chhota u)
    '\u0943', // ृ (vocalic r)
  };

  static const Set<String> longMatras = {
    '\u093E', // ा (aa)
    '\u0940', // ी (badi ee)
    '\u0942', // ू (bada oo)
    '\u0947', // े (e)
    '\u0948', // ै (ai)
    '\u094B', // ो (o)
    '\u094C', // ौ (au)
  };

  /// Cleans punctuation from Devanagari words.
  static String cleanWord(String raw) {
    return raw
        .replaceAll(RegExp(r'[\u0964,.\?!\(\)\[\]]'), '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .trim();
  }

  /// Segments a Devanagari word into its constituent akshara syllables and phonetic units.
  static List<AksharaSegment> segmentWord(String rawWord) {
    final clean = cleanWord(rawWord);
    if (clean.isEmpty) return const [];

    final segments = <AksharaSegment>[];
    final runes = clean.runes.toList();
    int i = 0;

    while (i < runes.length) {
      final buffer = StringBuffer();
      bool hasHalant = false;
      bool hasNukta = false;
      bool hasShortMatra = false;
      bool hasLongMatra = false;
      bool hasBindu = false;
      String matraChar = '';

      // Consume base consonant or independent vowel
      buffer.writeCharCode(runes[i]);
      i++;

      // Consume attached signs (nukta, virama/conjunct, matra, anusvara)
      while (i < runes.length) {
        final ch = String.fromCharCode(runes[i]);
        if (ch == nukta) {
          hasNukta = true;
          buffer.write(ch);
          i++;
        } else if (ch == halant) {
          hasHalant = true;
          buffer.write(ch);
          i++;
          // If followed by another consonant, bind it into the conjunct
          if (i < runes.length) {
            buffer.writeCharCode(runes[i]);
            i++;
          }
        } else if (shortMatras.contains(ch)) {
          hasShortMatra = true;
          matraChar = ch;
          buffer.write(ch);
          i++;
        } else if (longMatras.contains(ch)) {
          hasLongMatra = true;
          matraChar = ch;
          buffer.write(ch);
          i++;
        } else if (ch == anusvara || ch == chandrabindu) {
          hasBindu = true;
          buffer.write(ch);
          i++;
        } else {
          break;
        }
      }

      final segText = buffer.toString();
      String category = 'consonant';
      String catHi = 'सामान्य व्यंजन';
      String catEn = 'Consonant';
      String noteHi = 'स्पष्ट व्यंजन ध्वनि';
      String noteEn = 'Clear consonant sound';

      if (hasHalant) {
        category = 'conjunct';
        catHi = 'संयुक्त अक्षर (आधा अक्षर)';
        catEn = 'Conjunct (Half letter)';
        noteHi = 'आधा अक्षर: बिना रुके अगली ध्वनि के साथ संयुक्त';
        noteEn = 'Half letter conjunct: blend without pause';
      } else if (hasLongMatra) {
        category = 'long_matra';
        if (matraChar == '\u0940') {
          catHi = "दीर्घ 'ई' की मात्रा (ी)";
          catEn = "Long 'ee' vowel sign";
          noteHi = "खिंचाव के साथ लम्बी ध्वनि (ee as in feel)";
          noteEn = "Stretched sound (ee as in feel)";
        } else if (matraChar == '\u0942') {
          catHi = "दीर्घ 'ऊ' की मात्रा (ू)";
          catEn = "Long 'oo' vowel sign";
          noteHi = "खिंचाव के साथ लम्बी ध्वनि (oo as in pool)";
          noteEn = "Stretched sound (oo as in pool)";
        } else if (matraChar == '\u093E') {
          catHi = "दीर्घ 'आ' की मात्रा (ा)";
          catEn = "Long 'aa' vowel sign";
          noteHi = "मुँह खोलकर लम्बी 'आ' ध्वनि (aa as in calm)";
          noteEn = "Open mouth sound (aa as in calm)";
        } else if (matraChar == '\u0947' || matraChar == '\u0948') {
          catHi = "'ए/ऐ' की मात्रा (े/ै)";
          catEn = "'e/ai' vowel sign";
          noteHi = "कंठ-तालु ध्वनि";
          noteEn = "Front vowel sound (e or ai)";
        } else {
          catHi = "'ओ/औ' की मात्रा (ो/ौ)";
          catEn = "'o/au' vowel sign";
          noteHi = "कंठ-ओष्ठ ध्वनि";
          noteEn = "Back rounded vowel sound";
        }
      } else if (hasShortMatra) {
        category = 'short_matra';
        if (matraChar == '\u093F') {
          catHi = "ह्रस्व 'इ' की मात्रा (ि)";
          catEn = "Short 'i' vowel sign";
          noteHi = "हल्का और त्वरित उच्चारण (i as in pin)";
          noteEn = "Quick light sound (i as in pin)";
        } else if (matraChar == '\u0941') {
          catHi = "ह्रस्व 'उ' की मात्रा (ु)";
          catEn = "Short 'u' vowel sign";
          noteHi = "हल्का और त्वरित उच्चारण (u as in put)";
          noteEn = "Quick light sound (u as in put)";
        } else {
          catHi = "ह्रस्व मात्रा";
          catEn = "Short vowel sign";
          noteHi = "त्वरित उच्चारण";
          noteEn = "Quick vowel sound";
        }
      } else if (hasNukta) {
        category = 'nukta';
        catHi = "नुक्ता ध्वनि (़)";
        catEn = "Nukta sign";
        noteHi = "मूर्धन्य उत्क्षिप्त या विशेष ध्वनि";
        noteEn = "Retroflex flap or modified sound";
      } else if (hasBindu) {
        category = 'bindu';
        catHi = "अनुस्वार / बिंदु (ं/ँ)";
        catEn = "Nasal (Anusvara/Bindu)";
        noteHi = "नासिका (नाक) से उच्चारित ध्वनि";
        noteEn = "Nasalized vowel sound";
      }

      segments.add(AksharaSegment(
        text: segText,
        category: category,
        categoryLabelHi: catHi,
        categoryLabelEn: catEn,
        phoneticNoteHi: noteHi,
        phoneticNoteEn: noteEn,
      ));
    }

    return segments;
  }

  /// Generates a standard phonetic guide for the word.
  static String generatePronunciationGuide(String rawWord) {
    final segments = segmentWord(rawWord);
    if (segments.isEmpty) return rawWord;

    final parts = segments.map((s) => s.text).join('-');
    final primaryNotes = segments
        .where((s) => s.category != 'consonant')
        .map((s) => s.categoryLabelHi)
        .toSet()
        .join(', ');

    if (primaryNotes.isNotEmpty) {
      return "$parts ($primaryNotes)";
    }
    return parts;
  }

  static final Map<String, Map<String, List<String>>> _regionalRegistryByRegion = {};
  static final Map<String, Set<String>> _curriculumRegionalMap = {};

  /// Loads regional variants from JSON string (e.g. from assets/curriculum/regional_variants.json).
  static void loadRegionalVariantsJson(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final regions = decoded['regions'] as Map<String, dynamic>?;
      if (regions != null) {
        for (final rEntry in regions.entries) {
          final regionId = rEntry.key;
          final regionObj = rEntry.value as Map<String, dynamic>;
          final entries = regionObj['entries'] as Map<String, dynamic>? ?? {};
          final regionWords = <String, List<String>>{};

          for (final wEntry in entries.entries) {
            final standard = cleanWord(wEntry.key);
            final valMap = wEntry.value as Map<String, dynamic>;
            final variants = (valMap['accepted_variants'] as List<dynamic>?)
                    ?.map((v) => cleanWord(v.toString()))
                    .where((v) => v.isNotEmpty && v != standard)
                    .toList() ??
                [];
            regionWords[standard] = variants;

            _curriculumRegionalMap.putIfAbsent(standard, () => <String>{}).addAll(variants);
          }
          _regionalRegistryByRegion[regionId] = regionWords;
        }
      }
    } catch (_) {
      // Gracefully fall back to rule-based engine if asset not loaded yet
    }
  }

  /// Returns recognized regional / dialectal variants for Hindi (Awadhi/Bhojpuri UP, Rajasthani, Marathi-influenced, Punjabi-influenced).
  static List<String> getRegionalVariants(String rawWord, {String? regionId}) {
    final clean = cleanWord(rawWord);
    final variants = <String>{};

    // 1. Check registry from curriculum JSON if loaded
    if (regionId != null && _regionalRegistryByRegion.containsKey(regionId)) {
      final regWords = _regionalRegistryByRegion[regionId]![clean];
      if (regWords != null) {
        variants.addAll(regWords);
      }
    } else {
      final allWords = _curriculumRegionalMap[clean];
      if (allWords != null) {
        variants.addAll(allWords);
      }
    }

    // 2. Fallback / supplementary linguistic phonological rules:
    // (a) 'श' / 'ष' -> 'स' (Awadhi/Bhojpuri, Rajasthani: शाबाश -> साबास, विशाल -> बिसाल)
    if (clean.contains('श') || clean.contains('ष')) {
      variants.add(clean.replaceAll('श', 'स').replaceAll('ष', 'स'));
    }
    // (b) 'व' -> 'ब' (Bhojpuri / Eastern Hindi: हवा -> हबा, वह -> बह)
    if (clean.contains('व') && (regionId == null || regionId == 'awadhi_bhojpuri' || regionId == 'marathi_influenced')) {
      variants.add(clean.replaceAll('व', 'ब'));
    }
    // (c) 'ड़' -> 'ड' or 'र' (छिड़ -> छिड या छिर, पेड़ -> पेर)
    if (clean.contains('ड़')) {
      if (regionId == null || regionId == 'rajasthani') {
        variants.add(clean.replaceAll('ड़', 'ड'));
      }
      if (regionId == null || regionId == 'awadhi_bhojpuri') {
        variants.add(clean.replaceAll('ड़', 'र'));
      }
    }
    // (d) 'ण' <-> 'न' (कारण -> कारन, पानी -> पाणी)
    if (clean.contains('ण')) {
      variants.add(clean.replaceAll('ण', 'न'));
    }
    if (clean.contains('न')) {
      variants.add(clean.replaceAll('न', 'ण'));
    }
    // (e) 'ऋ' -> 'रि' or 'रु' (ऋतु -> रितु या रुतु)
    if (clean.contains('ऋ')) {
      variants.add(clean.replaceAll('ऋ', 'रि'));
      if (regionId == null || regionId == 'marathi_influenced') {
        variants.add(clean.replaceAll('ऋ', 'रु'));
      }
    }
    // (f) Prosthetic 'इ' for s-clusters (Awadhi/Bhojpuri: स्कूल -> इस्कूल, स्टेशन -> इस्टेशन, स्नान -> इस्नान)
    if (clean.startsWith('स्क') || clean.startsWith('स्ट') || clean.startsWith('स्प') || clean.startsWith('स्न')) {
      variants.add('इ$clean');
    }

    variants.remove(clean);
    return variants.toList();
  }

  /// Checks if candidate is an accepted regional variant of target.
  static bool isRegionalVariant(String target, String candidate, {String? regionId}) {
    final cleanT = cleanWord(target);
    final cleanC = cleanWord(candidate);
    if (cleanT == cleanC || cleanT.isEmpty || cleanC.isEmpty) return false;
    final variantsT = getRegionalVariants(cleanT, regionId: regionId);
    if (variantsT.contains(cleanC)) return true;
    final variantsC = getRegionalVariants(cleanC, regionId: regionId);
    return variantsC.contains(cleanT);
  }

  /// Validates that a distractor option never equals a recognized regional variant of target.
  static bool isValidDistractor(String targetWord, String candidateDistractor, {String? regionId}) {
    final cleanT = cleanWord(targetWord);
    final cleanD = cleanWord(candidateDistractor);
    if (cleanT.isEmpty || cleanD.isEmpty) return false;
    if (cleanT == cleanD) return false;
    if (isRegionalVariant(cleanT, cleanD, regionId: regionId)) {
      return false; // MUST NEVER be a valid regional variant!
    }
    return true;
  }

  /// Returns true if the only contrast between options is a dialect difference.
  static bool isDialectOnlyContrast(String targetWord, dynamic distractorOptions, {String? regionId}) {
    if (distractorOptions is String) {
      return isRegionalVariant(targetWord, distractorOptions, regionId: regionId);
    }
    if (distractorOptions is Iterable) {
      for (final d in distractorOptions) {
        if (isRegionalVariant(targetWord, d.toString(), regionId: regionId)) {
          return true;
        }
      }
    }
    return false;
  }

  /// Compares an observed child pronunciation against expected word.
  static PronunciationResult checkPronunciationMatch(
    String expected,
    String observed, {
    String? regionId,
    Iterable<String>? extraAcceptedVariants,
  }) {
    final cleanExp = cleanWord(expected);
    final cleanObs = cleanWord(observed);

    if (cleanExp.isEmpty || cleanObs.isEmpty) {
      return const PronunciationResult(
        isExact: false,
        isAcceptedRegional: false,
        feedbackNote: "कोई इनपुट नहीं मिला",
      );
    }

    if (cleanExp == cleanObs) {
      return const PronunciationResult(
        isExact: true,
        isAcceptedRegional: false,
        feedbackNote: "शुद्ध मानक उच्चारण",
      );
    }

    final regionalVariants = getRegionalVariants(cleanExp, regionId: regionId).toSet();
    if (extraAcceptedVariants != null) {
      regionalVariants.addAll(extraAcceptedVariants.map(cleanWord));
    }

    if (regionalVariants.contains(cleanObs)) {
      return PronunciationResult(
        isExact: false,
        isAcceptedRegional: true,
        matchedRegionalVariant: cleanObs,
        feedbackNote: "मानक क्षेत्रीय बोली उच्चारण ($cleanObs)",
      );
    }

    final mistake = classifyPrimaryMistake(cleanExp, cleanObs);
    return PronunciationResult(
      isExact: false,
      isAcceptedRegional: false,
      detectedErrorType: mistake,
      feedbackNote: "अलग उच्चारण: ${formatFeatureLabel(mistake, inHindi: true)}",
    );
  }

  /// Analyzes a word and returns all phonetic linguistic features present in it.
  static List<String> analyzeFeatures(String word) {
    final features = <String>{};

    if (word.contains(nukta)) {
      features.add('nukta');
    }
    if (word.contains(chandrabindu)) {
      features.add('chandrabindu');
    }
    if (word.contains(anusvara)) {
      features.add('bindu');
    }
    if (word.contains(halant)) {
      features.add('conjunct');
    }

    for (final rune in word.runes) {
      final ch = String.fromCharCode(rune);
      if (shortMatras.contains(ch)) {
        if (ch == '\u093F') features.add('short i matra');
        if (ch == '\u0941') features.add('short u matra');
        if (ch == '\u0943') features.add('ri matra');
        features.add('short matra');
      } else if (longMatras.contains(ch)) {
        if (ch == '\u093E') features.add('aa matra');
        if (ch == '\u0940') features.add('long ee matra');
        if (ch == '\u0942') features.add('long oo matra');
        if (ch == '\u0947' || ch == '\u0948') features.add('e/ai matra');
        if (ch == '\u094B' || ch == '\u094C') features.add('o/au matra');
        features.add('long matra');
      }
    }

    if (features.isEmpty) {
      features.add('consonant');
    }

    return features.toList();
  }

  /// Classifies the primary mistake type when a word is misread or misspelled.
  static String classifyPrimaryMistake(String targetWord, [String? observedWord]) {
    final features = analyzeFeatures(targetWord);

    // Prioritize complex aksharas: conjunct > nukta > chandrabindu > long matra > short matra > consonant
    if (features.contains('conjunct')) return 'conjunct';
    if (features.contains('long ee matra')) return 'long ee matra';
    if (features.contains('long oo matra')) return 'long oo matra';
    if (features.contains('short i matra')) return 'short i matra';
    if (features.contains('bindu')) return 'bindu';
    if (features.contains('chandrabindu')) return 'chandrabindu';
    if (features.contains('nukta')) return 'nukta';
    if (features.contains('long matra')) return 'long matra';
    if (features.contains('short matra')) return 'short matra';
    return 'consonant';
  }

  /// Human-readable label in Hindi and English
  static String formatFeatureLabel(String feature, {bool inHindi = false}) {
    switch (feature) {
      case 'conjunct':
        return inHindi ? 'संयुक्त अक्षर (आधे अक्षर)' : 'conjuncts';
      case 'long ee matra':
        return inHindi ? 'बड़ी ई की मात्रा (ी)' : 'long ee matra';
      case 'long oo matra':
        return inHindi ? 'बड़े ऊ की मात्रा (ू)' : 'long oo matra';
      case 'short i matra':
        return inHindi ? 'छोटी इ की मात्रा (ि)' : 'short i matra';
      case 'bindu':
        return inHindi ? 'अनुस्वार (बिंदु)' : 'bindu / anusvara';
      case 'chandrabindu':
        return inHindi ? 'चंद्रबिंदु (ँ)' : 'chandrabindu';
      case 'nukta':
        return inHindi ? 'नुक्ता (़)' : 'nukta';
      case 'long matra':
        return inHindi ? 'दीर्घ मात्रा' : 'long matra';
      case 'short matra':
        return inHindi ? 'ह्रस्व मात्रा' : 'short matra';
      case 'consonant':
      default:
        return inHindi ? 'व्यंजन पहचान' : 'consonants';
    }
  }
}
