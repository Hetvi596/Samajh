import 'package:flutter/material.dart';

import '../../../core/analysis/devanagari_engine.dart';

/// Ways a word can be written on a ruled notebook line. The first four are
/// about position on the line; the rest are about how the letters are formed.
enum WritingPositionStyle {
  correctHanging, // Written correctly (Hindi hangs from the line, English sits on it)
  floatingAbove,  // Floating above the line with empty space
  sinkingBelow,   // Sinking down below the line
  crossingLine,   // Line cutting horizontally across the middle of the letters
  missingShirorekha,  // Hindi letters written without their top line (शिरोरेखा)
  lettersSpreadApart, // Letters far apart, so the word breaks up
  unevenLetters,      // Letters of different sizes, tilted and bouncing
  mirroredLetter,     // English: one letter written back to front (b/d, p/q)
}

/// Reads a `position_style` value from the word check bank.
WritingPositionStyle? parseWritingStyle(String? raw) {
  for (final s in WritingPositionStyle.values) {
    if (s.name == raw) return s;
  }
  return null;
}

/// CustomPainter that renders a ruled notebook line and draws the word in one
/// writing style without using any image assets.
class NotebookLineWordPainter extends CustomPainter {
  final String word;
  final WritingPositionStyle positionStyle;
  final bool isSelected;
  final Color lineColor;
  final Color textColor;
  final double fontSize;

  /// Measured from Noto Sans Devanagari Bold: the top line (शिरोरेखा) spans
  /// 0.28 to 0.39 of the font size below the top of the text box.
  static const double headlineTop = 0.275;
  static const double headlineBottom = 0.395;

  const NotebookLineWordPainter({
    required this.word,
    required this.positionStyle,
    this.isSelected = false,
    this.lineColor = const Color(0xFF60A5FA), // Light blue notebook rule
    this.textColor = const Color(0xFF0F172A),
    this.fontSize = 24.0,
  });

  bool get _isDevanagari => RegExp(r'[ऀ-ॿ]').hasMatch(word);

  TextPainter _layout(String text, {double scale = 1.0}) => TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: _isDevanagari ? 'NotoSansDevanagari' : 'Inter',
            fontSize: fontSize * scale,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

  /// Letters drawn one by one: aksharas for Hindi, characters for English.
  List<String> get _letters => _isDevanagari
      ? DevanagariAksharaEngine.segmentWord(word).map((s) => s.text).toList()
      : word.split('');

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Light notebook page background
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)),
      Paint()..color = isSelected ? const Color(0xFFF0FDF4) : Colors.white,
    );

    // 2. Ruled line, thinner and lighter than the ink so a missing
    // शिरोरेखा is easy to see.
    final ruleY = size.height * 0.42;
    canvas.drawLine(
      Offset(12, ruleY),
      Offset(size.width - 12, ruleY),
      Paint()
        ..color = lineColor
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(12, ruleY + 32),
      Offset(size.width - 12, ruleY + 32),
      Paint()
        ..color = lineColor.withValues(alpha: 0.3)
        ..strokeWidth = 1.0,
    );

    // 3. Where the text box sits when the word is written correctly:
    // Hindi top line on the rule, English baseline on the rule.
    final whole = _layout(word);
    final textHeight = whole.height;
    final baseline = whole.computeDistanceToActualBaseline(TextBaseline.alphabetic);
    final correctY = _isDevanagari
        ? ruleY - fontSize * (headlineTop + headlineBottom) / 2
        : ruleY - baseline;
    final centredX = (size.width - whole.width) / 2.0;

    switch (positionStyle) {
      case WritingPositionStyle.correctHanging:
        whole.paint(canvas, Offset(centredX, correctY));
      case WritingPositionStyle.floatingAbove:
        whole.paint(canvas, Offset(centredX, ruleY - textHeight - 8.0));
      case WritingPositionStyle.sinkingBelow:
        whole.paint(canvas, Offset(centredX, ruleY + 14.0));
      case WritingPositionStyle.crossingLine:
        whole.paint(canvas, Offset(centredX, ruleY - (textHeight * 0.48)));
      case WritingPositionStyle.missingShirorekha:
        // Same place as the correct word, with only the top line rubbed out.
        canvas.saveLayer(null, Paint());
        whole.paint(canvas, Offset(centredX, correctY));
        canvas.drawRect(
          Rect.fromLTWH(
            centredX - 2,
            correctY + fontSize * (headlineTop - 0.01),
            whole.width + 4,
            // A little extra below so no anti-aliased edge of the line is left.
            fontSize * (headlineBottom - headlineTop + 0.025),
          ),
          Paint()..blendMode = BlendMode.clear,
        );
        canvas.restore();
      case WritingPositionStyle.lettersSpreadApart:
        _drawLetters(canvas, size, correctY, baseline, gap: fontSize * 0.6);
      case WritingPositionStyle.unevenLetters:
        _drawLetters(canvas, size, correctY, baseline, gap: fontSize * 0.08, uneven: true);
      case WritingPositionStyle.mirroredLetter:
        _drawLetters(canvas, size, correctY, baseline, gap: 0, mirror: true);
    }

    // 4. If selected, draw active border
    if (isSelected) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)),
        Paint()
          ..color = const Color(0xFF15803D) // forest green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    }
  }

  /// Draws each letter separately on the same line as the correct word.
  void _drawLetters(
    Canvas canvas,
    Size size,
    double correctY,
    double wordBaseline, {
    required double gap,
    bool uneven = false,
    bool mirror = false,
  }) {
    const scales = [1.0, 0.7, 1.3, 0.85, 1.2, 0.75];
    const tilts = [0.0, -0.22, 0.18, -0.12, 0.24, -0.16];
    const lifts = [0.0, -0.2, 0.14, -0.1, 0.2, -0.14];
    const mirrorable = {'b', 'd', 'p', 'q'};

    final letters = _letters;
    final scaleOf = [for (var i = 0; i < letters.length; i++) uneven ? scales[i % scales.length] : 1.0];
    final painters = [for (var i = 0; i < letters.length; i++) _layout(letters[i], scale: scaleOf[i])];
    final total = painters.fold<double>(0, (s, p) => s + p.width) + gap * (painters.length - 1).clamp(0, 99);
    final mirrorAt = mirror ? letters.indexWhere(mirrorable.contains) : -1;

    var x = (size.width - total) / 2.0;
    for (var i = 0; i < painters.length; i++) {
      final p = painters[i];
      // Keep each letter's top line (Hindi) or baseline (English) level
      // with the correct word, whatever its size.
      final top = _isDevanagari
          ? correctY + fontSize * headlineTop * (1 - scaleOf[i])
          : correctY + wordBaseline - p.computeDistanceToActualBaseline(TextBaseline.alphabetic);
      final dy = uneven ? fontSize * lifts[i % lifts.length] : 0.0;

      canvas.save();
      canvas.translate(x + p.width / 2, top + dy + p.height / 2);
      if (uneven) canvas.rotate(tilts[i % tilts.length]);
      if (i == mirrorAt) canvas.scale(-1, 1);
      p.paint(canvas, Offset(-p.width / 2, -p.height / 2));
      canvas.restore();
      x += p.width + gap;
    }
  }

  @override
  bool shouldRepaint(covariant NotebookLineWordPainter oldDelegate) {
    return oldDelegate.word != word ||
        oldDelegate.positionStyle != positionStyle ||
        oldDelegate.isSelected != isSelected ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.textColor != textColor;
  }
}

/// Interactive Card widget presenting one way of writing the word.
class RuledNotebookChoiceCard extends StatelessWidget {
  final String word;
  final WritingPositionStyle positionStyle;
  final bool isSelected;
  final VoidCallback onTap;

  const RuledNotebookChoiceCard({
    super.key,
    required this.word,
    required this.positionStyle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 96,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF15803D) : const Color(0xFFCBD5E1),
              width: isSelected ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomPaint(
            painter: NotebookLineWordPainter(
              word: word,
              positionStyle: positionStyle,
              isSelected: isSelected,
            ),
          ),
        ),
      ),
    );
  }
}
