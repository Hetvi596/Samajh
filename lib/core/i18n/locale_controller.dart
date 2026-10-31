import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleController extends StateNotifier<Locale> {
  LocaleController() : super(const Locale('hi')); // Default Hindi

  void setLocale(Locale newLocale) {
    if (newLocale.languageCode == 'en' ||
        newLocale.languageCode == 'hi' ||
        newLocale.languageCode == 'mr') {
      state = newLocale;
    }
  }

  void toggleLanguage() {
    state = state.languageCode == 'hi' ? const Locale('en') : const Locale('hi');
  }
}

final localeProvider = StateNotifierProvider<LocaleController, Locale>((ref) {
  return LocaleController();
});
