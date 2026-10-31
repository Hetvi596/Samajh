import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/security/passcode_service.dart';
import '../student_mode/kiran_mascot.dart';
import 'numeric_keypad.dart';

class UnlockScreen extends ConsumerStatefulWidget {
  const UnlockScreen({super.key});

  @override
  ConsumerState<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends ConsumerState<UnlockScreen> {
  String _enteredCode = '';
  String? _errorMessage;
  bool _isVerifying = false;

  void _onDigitTapped(String digit) {
    if (_isVerifying) return;
    if (_enteredCode.length < 6) {
      setState(() {
        _errorMessage = null;
        _enteredCode += digit;
      });

      if (_enteredCode.length == 6) {
        _verifyCode();
      }
    }
  }

  void _onDeleteTapped() {
    if (_isVerifying) return;
    if (_enteredCode.isNotEmpty) {
      setState(() {
        _errorMessage = null;
        _enteredCode = _enteredCode.substring(0, _enteredCode.length - 1);
      });
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _isVerifying = true;
    });

    final l10n = AppLocalizations.of(context)!;
    final db = ref.read(appDatabaseProvider);
    final settings = await (db.select(db.appSettingsTable)..where((t) => t.id.equals('global_settings'))).getSingleOrNull();
    final savedHash = settings?.passcodeHash;

    final inputHash = ref.read(passcodeProvider.notifier).hashPasscode(_enteredCode);

    if (savedHash == null || inputHash == savedHash) {
      ref.read(isAppUnlockedProvider.notifier).state = true;
      if (mounted) {
        context.go('/app/today');
      }
    } else {
      if (mounted) {
        setState(() {
          _errorMessage = l10n.passcodeIncorrect;
          _enteredCode = '';
          _isVerifying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 32 ? constraints.maxHeight - 32 : 500,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Kiran mascot (smiling sun)
                      const KiranMascot(
                        size: 96,
                        animated: false,
                      ),
                      const SizedBox(height: 16),
                      // App title
                      Text(
                        l10n.appTitleDevanagari,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: SamajhColors.textNavy,
                          letterSpacing: -0.5,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Prompt: Enter passcode to unlock
                      Text(
                        l10n.enterPasscodeToUnlock,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: SamajhColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 6 PIN indicator dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          final isFilled = index < _enteredCode.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFilled ? SamajhColors.forestGreen : Colors.transparent,
                              border: Border.all(
                                color: isFilled ? SamajhColors.forestGreen : SamajhColors.textSubtle,
                                width: 2,
                              ),
                            ),
                          );
                        }),
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: SamajhColors.recordingRed,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      const SizedBox(height: 16),
                      // Numeric keypad
                      NumericKeypad(
                        onDigit: _onDigitTapped,
                        onDelete: _onDeleteTapped,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
