import 'package:flutter/material.dart';

import 'motion.dart';

class SamajhColors {
  // Primary brand palette
  static const Color background = Color(0xFFFFF8EA); // warm cream page
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textNavy = Color(0xFF13294B);
  static const Color textMuted = Color(0xFF5A6E85);
  static const Color textSubtle = Color(0xFF8A9BAE);

  // Action & highlight colors
  static const Color forestGreen = Color(0xFF27775A);
  static const Color forestGreenHover = Color(0xFF1E5E47);
  static const Color paleMint = Color(0xFFE7F4EC);
  static const Color paleMintDark = Color(0xFFC8E6D3);

  // Group & status chips
  static const Color onTrackBg = Color(0xFFE7F4EC);
  static const Color onTrackText = Color(0xFF1B6449);

  static const Color needsHelpBg = Color(0xFFFEF3D6);
  static const Color needsHelpText = Color(0xFF7A4F01);

  static const Color recordingRed = Color(0xFFD9383A);
  static const Color recordingRedBg = Color(0xFFFDE8E8);

  static const Color dividerColor = Color(0xFFEBE6DC);
  static const Color borderColor = Color(0xFFE5DFC9);

  // Mascot colors
  static const Color kiranGold = Color(0xFFFBBF24);
  static const Color kiranAmber = Color(0xFFF59E0B);
  static const Color kiranOrange = Color(0xFFEA580C);

  // Classroom board: the teacher's dashboard header is a green chalkboard.
  static const Color board = Color(0xFF1E4D3C);
  static const Color boardLight = Color(0xFF2A6450);
  static const Color chalk = Color(0xFFF5F2E8);
  static const Color chalkMuted = Color(0xFFBFD3C8);

  // Pebble surfaces: cream track for progress and soft outlines.
  static const Color creamTrack = Color(0xFFF2E3B5);
  static const Color creamLine = Color(0xFFE8D9AE);
  static const Color creamSoft = Color(0xFFFEF3D6);

  // Ruled notebook line, used for small decorative rules.
  static const Color notebookRule = Color(0xFF60A5FA);

  // Semantic colours
  static const Color success = Color(0xFF15803D);
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color warning = Color(0xFFB45309);
  static const Color warningBg = Color(0xFFFFF7ED);
  static const Color info = Color(0xFF1D4ED8);
  static const Color infoBg = Color(0xFFEFF6FF);
}

/// Spacing steps (dp). Use these instead of one-off numbers.
class SamajhSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;
}

/// Corner radii: chips, controls, cards and hero panels each get their own
/// size so the hierarchy shows in the shapes too.
class SamajhRadius {
  static const double chip = 10;
  static const double control = 14;
  static const double card = 20;
  static const double hero = 28;
}

/// Two soft elevations: resting cards and the one active or raised item.
class SamajhShadow {
  static List<BoxShadow> get resting => [
    BoxShadow(color: SamajhColors.textNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4)),
  ];
  static List<BoxShadow> raised(Color tint) => [
    BoxShadow(color: tint.withValues(alpha: 0.16), blurRadius: 18, offset: const Offset(0, 8)),
  ];
}

class SamajhTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: SamajhColors.background,
      colorScheme: const ColorScheme.light(
        primary: SamajhColors.forestGreen,
        onPrimary: Colors.white,
        primaryContainer: SamajhColors.paleMint,
        onPrimaryContainer: SamajhColors.forestGreen,
        surface: SamajhColors.cardBackground,
        onSurface: SamajhColors.textNavy,
        error: SamajhColors.recordingRed,
      ),
      fontFamily: 'Inter',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SamajhPageTransitionsBuilder(),
          TargetPlatform.iOS: SamajhPageTransitionsBuilder(),
          TargetPlatform.windows: SamajhPageTransitionsBuilder(),
        },
      ),
      splashFactory: InkRipple.splashFactory, // cheaper than sparkle on low-end phones
      fontFamilyFallback: const ['NotoSansDevanagari', 'sans-serif'],
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: SamajhColors.textNavy,
          height: 1.25,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: SamajhColors.textNavy, height: 1.3),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: SamajhColors.textNavy, height: 1.35),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: SamajhColors.textNavy, height: 1.4),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: SamajhColors.textNavy, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: SamajhColors.textMuted, height: 1.5),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.2),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: SamajhColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: SamajhColors.textNavy),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: SamajhColors.textNavy,
          fontFamily: 'Inter',
        ),
      ),
      cardTheme: CardThemeData(
        color: SamajhColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26), // Pebble: soft corners, no outline
          side: BorderSide.none,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SamajhColors.forestGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 52), // min 52 dp height, safe in Rows
          shape: const StadiumBorder(),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SamajhColors.forestGreen,
          minimumSize: const Size(64, 52),
          side: const BorderSide(color: SamajhColors.forestGreen, width: 2),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SamajhColors.forestGreen,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SamajhRadius.chip)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: SamajhColors.forestGreen,
          minimumSize: const Size(64, 52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: SamajhColors.textMuted, fontWeight: FontWeight.w500),
        floatingLabelStyle: const TextStyle(color: SamajhColors.forestGreen, fontWeight: FontWeight.w700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SamajhRadius.control),
          borderSide: const BorderSide(color: SamajhColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SamajhRadius.control),
          borderSide: const BorderSide(color: SamajhColors.borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SamajhRadius.control),
          borderSide: const BorderSide(color: SamajhColors.forestGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SamajhRadius.control),
          borderSide: const BorderSide(color: SamajhColors.recordingRed, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: SamajhColors.paleMint,
        side: const BorderSide(color: SamajhColors.borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SamajhRadius.chip)),
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
        checkmarkColor: SamajhColors.forestGreen,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SamajhRadius.hero)),
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: SamajhColors.textNavy,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(SamajhRadius.hero))),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: SamajhColors.textNavy,
        contentTextStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SamajhRadius.control)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.white : SamajhColors.textSubtle,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? SamajhColors.forestGreen : SamajhColors.dividerColor,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? SamajhColors.forestGreen : Colors.transparent,
        ),
        side: const BorderSide(color: SamajhColors.textSubtle, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: SamajhColors.forestGreen,
        linearTrackColor: SamajhColors.dividerColor,
      ),
      dividerTheme: const DividerThemeData(color: SamajhColors.dividerColor, thickness: 1, space: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        height: 70,
        surfaceTintColor: Colors.transparent,
        indicatorColor: SamajhColors.paleMint,
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen);
          }
          return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: SamajhColors.textMuted);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: SamajhColors.forestGreen, size: 26);
          }
          return const IconThemeData(color: SamajhColors.textMuted, size: 24);
        }),
      ),
    );
  }

  // Devanagari text style with generous line-height for student passage
  static TextStyle devanagariReadingStyle({double fontSize = 26}) {
    return TextStyle(
      fontFamily: 'NotoSansDevanagari',
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: SamajhColors.textNavy,
      height: 1.75, // Generous line height so conjuncts and matras are crisp
      letterSpacing: 0, // any spacing breaks the top line (शिरोरेखा) between letters
    );
  }
}
