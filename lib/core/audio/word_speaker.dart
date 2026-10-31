import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

/// Why a word could not be spoken, so the teacher sees what to fix.
enum SpeechProblem {
  none,

  /// The phone has no voice for this language at all.
  noVoice,

  /// The phone only has an online voice for this language and is offline.
  needsDownload,

  /// The voice started but failed or timed out.
  failed,
}

/// Says a single word with the phone's own text-to-speech engine. Nothing
/// is sent off the phone by the app. It prefers a voice that is installed on
/// the phone (works offline) over one that streams from the internet. When
/// no voice works, [speak] returns false, [lastProblem] says why, and the
/// teacher says the word instead.
class WordSpeaker {
  WordSpeaker._();
  static final WordSpeaker instance = WordSpeaker._();

  /// A word is short; if nothing is heard by then, treat it as failed.
  static const Duration _limit = Duration(seconds: 6);

  FlutterTts? _tts;

  /// Per language: true when the chosen voice is installed on the phone.
  final Map<String, bool?> _offlineVoice = {};
  Completer<bool>? _failed;

  SpeechProblem lastProblem = SpeechProblem.none;

  /// Locales to try, best first. Many phones only report en-US for English.
  static const _locales = {
    true: ['hi-IN', 'hi'],
    false: ['en-IN', 'en-US', 'en-GB', 'en'],
  };

  /// Google's engine, tried when the phone's default engine has no voice.
  static const _googleEngine = 'com.google.android.tts';

  /// Per language: the locale that works on this phone ('' when none does).
  final Map<bool, String> _locale = {};

  Future<bool> speak(String word, {required bool isHindi}) async {
    try {
      final tts = _tts ??= _create();
      final lang = _locale[isHindi] ??= await _findLocale(tts, isHindi);
      if (lang.isEmpty) {
        lastProblem = SpeechProblem.noVoice;
        return false;
      }
      await tts.setSpeechRate(0.4); // slow and clear for young children
      await tts.awaitSpeakCompletion(true);
      var ok = await _say(tts, word);
      if (!ok && _offlineVoice[lang] != null) {
        // The chosen voice failed: let the engine pick its own voice and retry once.
        _offlineVoice[lang] = null;
        await tts.setLanguage(lang);
        ok = await _say(tts, word);
      }
      lastProblem = ok
          ? SpeechProblem.none
          : (_offlineVoice[lang] == false ? SpeechProblem.needsDownload : SpeechProblem.failed);
      return ok;
    } catch (_) {
      // No engine (or tests without the plugin): fall back to the teacher.
      lastProblem = SpeechProblem.noVoice;
      return false;
    }
  }

  /// The engine reports a failed voice only through the error handler and
  /// then never finishes the speak call, so race the two with a time limit.
  Future<bool> _say(FlutterTts tts, String word) async {
    final failed = _failed = Completer<bool>();
    final spoken = tts.speak(word).then((r) => r == 1);
    return Future.any([spoken, failed.future]).timeout(_limit, onTimeout: () => false);
  }

  /// First locale this phone can speak, on the default engine or else on
  /// Google's engine; '' when there is none.
  Future<String> _findLocale(FlutterTts tts, bool isHindi) async {
    for (var attempt = 0; attempt < 2; attempt++) {
      if (attempt == 1) {
        final engines = await tts.getEngines;
        if (engines is! List || !engines.contains(_googleEngine)) break;
        await tts.setEngine(_googleEngine);
      }
      for (final lang in _locales[isHindi]!) {
        if (await tts.isLanguageAvailable(lang) == true) {
          await tts.setLanguage(lang);
          _offlineVoice[lang] = await _pickVoice(tts, lang);
          return lang;
        }
      }
    }
    return '';
  }

  /// Chooses the best voice for [lang]: installed on the phone first, then
  /// any voice of the same language. Returns true for an installed voice,
  /// false when only an online one exists, null when voices can't be listed.
  Future<bool?> _pickVoice(FlutterTts tts, String lang) async {
    try {
      final voices = await tts.getVoices;
      if (voices is! List) return null;
      final want = lang.toLowerCase();
      final prefix = want.substring(0, 2);
      Map<String, String>? best;
      var bestScore = -1;
      for (final v in voices) {
        if (v is! Map) continue;
        final name = '${v['name'] ?? ''}';
        final locale = '${v['locale'] ?? ''}'.replaceAll('_', '-').toLowerCase();
        if (!locale.startsWith(prefix)) continue;
        final features = '${v['features'] ?? ''}'.toLowerCase();
        if (features.contains('notinstalled')) continue;
        final network = '${v['network_required'] ?? ''}' == '1' || name.toLowerCase().contains('network');
        final score = (network ? 0 : 2) + (locale == want ? 1 : 0);
        if (score > bestScore) {
          bestScore = score;
          best = {'name': name, 'locale': '${v['locale']}'};
        }
      }
      if (best == null) return null;
      await tts.setVoice(best);
      return bestScore >= 2;
    } catch (_) {
      return null;
    }
  }

  FlutterTts _create() {
    final tts = FlutterTts();
    tts.setErrorHandler((_) {
      final failed = _failed;
      if (failed != null && !failed.isCompleted) failed.complete(false);
    });
    return tts;
  }

  Future<void> stop() async {
    try {
      await _tts?.stop();
    } catch (_) {}
  }
}
