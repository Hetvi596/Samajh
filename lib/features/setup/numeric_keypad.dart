import 'package:flutter/material.dart';
import '../../app/theme.dart';

class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onDelete;

  const NumericKeypad({
    super.key,
    required this.onDigit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeypadButton(digit: '1', onTap: () => onDigit('1')),
              KeypadButton(digit: '2', onTap: () => onDigit('2')),
              KeypadButton(digit: '3', onTap: () => onDigit('3')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeypadButton(digit: '4', onTap: () => onDigit('4')),
              KeypadButton(digit: '5', onTap: () => onDigit('5')),
              KeypadButton(digit: '6', onTap: () => onDigit('6')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeypadButton(digit: '7', onTap: () => onDigit('7')),
              KeypadButton(digit: '8', onTap: () => onDigit('8')),
              KeypadButton(digit: '9', onTap: () => onDigit('9')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 64, height: 64),
              KeypadButton(digit: '0', onTap: () => onDigit('0')),
              SizedBox(
                width: 64,
                height: 64,
                child: Center(
                  child: IconButton(
                    key: const Key('keypad_delete_button'),
                    iconSize: 28,
                    icon: const Icon(Icons.backspace_outlined, color: SamajhColors.textNavy),
                    onPressed: onDelete,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KeypadButton extends StatelessWidget {
  final String digit;
  final VoidCallback onTap;

  const KeypadButton({super.key, required this.digit, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(color: SamajhColors.dividerColor),
      ),
      elevation: 0,
      child: InkWell(
        key: Key('digit_button_$digit'),
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: SamajhColors.textNavy,
            ),
          ),
        ),
      ),
    );
  }
}
