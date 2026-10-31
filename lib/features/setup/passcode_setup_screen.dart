import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/security/passcode_service.dart';
import 'numeric_keypad.dart';

class PasscodeSetupScreen extends ConsumerStatefulWidget {
  const PasscodeSetupScreen({super.key});

  @override
  ConsumerState<PasscodeSetupScreen> createState() => _PasscodeSetupScreenState();
}

class _PasscodeSetupScreenState extends ConsumerState<PasscodeSetupScreen> {
  String _firstEntry = '';
  String _confirmEntry = '';
  bool _isConfirming = false;
  String? _errorMessage;

  void _onDigitTapped(String digit) {
    setState(() {
      _errorMessage = null;
      if (!_isConfirming) {
        if (_firstEntry.length < 6) {
          _firstEntry += digit;
          if (_firstEntry.length == 6) {
            _isConfirming = true;
          }
        }
      } else {
        if (_confirmEntry.length < 6) {
          _confirmEntry += digit;
          if (_confirmEntry.length == 6) {
            _verifyAndSave();
          }
        }
      }
    });
  }

  void _onDeleteTapped() {
    setState(() {
      _errorMessage = null;
      if (_isConfirming) {
        if (_confirmEntry.isNotEmpty) {
          _confirmEntry = _confirmEntry.substring(0, _confirmEntry.length - 1);
        } else {
          _isConfirming = false;
        }
      } else {
        if (_firstEntry.isNotEmpty) {
          _firstEntry = _firstEntry.substring(0, _firstEntry.length - 1);
        }
      }
    });
  }

  Future<void> _verifyAndSave() async {
    final l10n = AppLocalizations.of(context)!;
    if (_firstEntry == _confirmEntry) {
      ref.read(passcodeProvider.notifier).setPasscode(_firstEntry);

      // Persist PBKDF2 hash to database
      final db = ref.read(appDatabaseProvider);
      final hash = ref.read(passcodeProvider.notifier).hashPasscode(_firstEntry);
      await db.update(db.appSettingsTable).write(
        AppSettingsTableCompanion(
          passcodeHash: drift.Value(hash),
        ),
      );

      // Mark session as unlocked for the user
      ref.read(isAppUnlockedProvider.notifier).state = true;

      if (mounted) {
        // First-time teacher flow: proceed to class setup
        context.go('/class_setup');
      }
    } else {
      setState(() {
        _errorMessage = l10n.passcodesDoNotMatch;
        _confirmEntry = '';
        _firstEntry = '';
        _isConfirming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentCode = _isConfirming ? _confirmEntry : _firstEntry;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.passcodeTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 24 ? constraints.maxHeight - 24 : 450,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _isConfirming ? l10n.confirmPasscode : l10n.passcodeSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: SamajhColors.textNavy,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 6-digit PIN Indicator Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          final isFilled = index < currentCode.length;
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
                        const SizedBox(height: 12),
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
                      // Numeric Keypad
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

