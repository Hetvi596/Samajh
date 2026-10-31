import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/i18n/generated/app_localizations.dart';
import 'core/providers/database_provider.dart';
import 'core/sync/auto_sync_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (.env) containing Supabase credentials
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // If .env is missing or invalid, continue offline
  }

  // Optional cloud backup: credentials come only from the local .env (never
  // from the code). Without them the app runs fully offline.
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  if (supabaseUrl.isNotEmpty &&
      supabaseUrl.startsWith('http') &&
      !supabaseUrl.contains('YOUR_SUPABASE_URL') &&
      supabaseKey.isNotEmpty &&
      !supabaseKey.contains('YOUR_SUPABASE_')) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: supabaseKey,
      );
    } catch (e) {
      debugPrint('[Supabase] Initialization notice: $e');
    }
  }

  runApp(
    const ProviderScope(
      child: SamajhApp(),
    ),
  );
}

class SamajhApp extends ConsumerWidget {
  const SamajhApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Automatically initiates background sync to Supabase whenever online
    ref.watch(autoSyncManagerProvider);
    final currentLocale = ref.watch(appLanguageProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Samajh',
      debugShowCheckedModeBanner: false,
      theme: SamajhTheme.lightTheme,
      routerConfig: router,
      locale: currentLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
