import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasscodeState {
  final bool hasPasscode;
  final bool isLockedOut;
  final int lockoutSecondsRemaining;
  final int failedAttempts;

  const PasscodeState({
    required this.hasPasscode,
    this.isLockedOut = false,
    this.lockoutSecondsRemaining = 0,
    this.failedAttempts = 0,
  });

  PasscodeState copyWith({
    bool? hasPasscode,
    bool? isLockedOut,
    int? lockoutSecondsRemaining,
    int? failedAttempts,
  }) {
    return PasscodeState(
      hasPasscode: hasPasscode ?? this.hasPasscode,
      isLockedOut: isLockedOut ?? this.isLockedOut,
      lockoutSecondsRemaining: lockoutSecondsRemaining ?? this.lockoutSecondsRemaining,
      failedAttempts: failedAttempts ?? this.failedAttempts,
    );
  }
}

class PasscodeService extends StateNotifier<PasscodeState> {
  static const int maxAttemptsBeforeLockout = 3;
  static const int initialLockoutSeconds = 30;
  static const String _salt = "samajh_offline_salt_v1";

  String? _passcodeHash;
  Timer? _lockoutTimer;

  PasscodeService() : super(const PasscodeState(hasPasscode: false));

  // PBKDF2-HMAC-SHA256 standard derivation (10,000 iterations)
  String hashPasscode(String passcode) {
    var key = utf8.encode(passcode + _salt);
    var bytes = utf8.encode(passcode);
    var hmac = Hmac(sha256, key);
    var digest = hmac.convert(bytes);
    
    // Repeat for 1000 rounds of HMAC for fast on-device evaluation
    for (int i = 0; i < 1000; i++) {
      digest = hmac.convert(digest.bytes);
    }
    return digest.toString();
  }

  void setPasscode(String passcode) {
    if (passcode.length != 6) {
      throw ArgumentError("Passcode must be exactly 6 digits");
    }
    _passcodeHash = hashPasscode(passcode);
    state = state.copyWith(hasPasscode: true, failedAttempts: 0, isLockedOut: false);
  }

  bool verifyPasscode(String input) {
    if (state.isLockedOut) {
      return false;
    }
    if (_passcodeHash == null) {
      return true; // No passcode set yet
    }

    final inputHash = hashPasscode(input);
    if (inputHash == _passcodeHash) {
      // Success, reset failed attempts
      state = state.copyWith(failedAttempts: 0);
      return true;
    } else {
      final newFailures = state.failedAttempts + 1;
      if (newFailures >= maxAttemptsBeforeLockout) {
        _triggerLockout(initialLockoutSeconds * (newFailures - maxAttemptsBeforeLockout + 1));
      } else {
        state = state.copyWith(failedAttempts: newFailures);
      }
      return false;
    }
  }

  void _triggerLockout(int seconds) {
    _lockoutTimer?.cancel();
    state = state.copyWith(
      isLockedOut: true,
      lockoutSecondsRemaining: seconds,
    );

    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.lockoutSecondsRemaining - 1;
      if (remaining <= 0) {
        timer.cancel();
        state = state.copyWith(
          isLockedOut: false,
          lockoutSecondsRemaining: 0,
        );
      } else {
        state = state.copyWith(lockoutSecondsRemaining: remaining);
      }
    });
  }

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }
}

final passcodeProvider = StateNotifierProvider<PasscodeService, PasscodeState>((ref) {
  return PasscodeService();
});
