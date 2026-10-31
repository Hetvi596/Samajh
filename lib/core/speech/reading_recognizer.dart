import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'reading_alignment.dart';

/// Listens to the child's reading recording on the phone with the bundled
/// Vosk Hindi or English model (run by the Android side, see MainActivity.kt).
/// Nothing is sent anywhere. Returns null when recognition cannot run, so the teacher
/// marks by ear as before.
class ReadingRecognizer {
  ReadingRecognizer._();
  static final ReadingRecognizer instance = ReadingRecognizer._();

  static const _channel = MethodChannel('samajh/speech');
  static const _hindiModelAsset = 'assets/models/vosk-model-small-hi-0.22.zip';
  static const _englishModelAsset = 'assets/models/vosk-model-small-en-us-0.15.zip';

  /// Hindi and English models are bundled; only Android runs them.
  bool supports({required bool isHindi}) => Platform.isAndroid;

  /// Words heard in the WAV recording at [wavPath], listening only for the
  /// words of the passage. The first call also unzips the model (a few
  /// seconds, once per install).
  Future<List<HeardWord>?> transcribe(String wavPath, List<String> passageWords, {required bool isHindi}) async {
    try {
      if (!File(wavPath).existsSync()) return null;
      final results = await _channel.invokeListMethod<String>('transcribe', {
        'modelAsset': isHindi ? _hindiModelAsset : _englishModelAsset,
        'wavPath': wavPath,
        'grammar': jsonEncode(recognitionGrammar(passageWords)),
      });
      if (results == null) return null;
      return parseRecognizerResults(results);
    } catch (_) {
      return null;
    }
  }
}
