import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme.dart';

class KiranMascot extends StatefulWidget {
  final double size;
  final String? spokenText;
  final bool animated;

  const KiranMascot({
    super.key,
    this.size = 120,
    this.spokenText,
    this.animated = true,
  });

  @override
  State<KiranMascot> createState() => _KiranMascotState();
}

class _KiranMascotState extends State<KiranMascot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.animated) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final bounce = widget.animated ? math.sin(_controller.value * math.pi) * 4 : 0.0;
            return Transform.translate(
              offset: Offset(0, bounce),
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _KiranPainter(pulse: _controller.value),
              ),
            );
          },
        ),
        if (widget.spokenText != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: SamajhColors.paleMintDark, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              widget.spokenText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: RegExp(r'[\u0900-\u097F]').hasMatch(widget.spokenText!)
                    ? 'NotoSansDevanagari'
                    : 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: SamajhColors.textNavy,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _KiranPainter extends CustomPainter {
  final double pulse;

  _KiranPainter({required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.32;

    // Draw Sun Rays
    final rayPaint = Paint()
      ..color = SamajhColors.kiranGold
      ..style = PaintingStyle.fill;

    const numRays = 12;
    for (int i = 0; i < numRays; i++) {
      final angle = (i * 2 * math.pi / numRays) + (pulse * 0.1);
      final rayStart = Offset(
        center.dx + math.cos(angle) * (radius * 1.05),
        center.dy + math.sin(angle) * (radius * 1.05),
      );
      final rayLength = radius * 0.28 + (math.sin(pulse * math.pi + i) * 3);
      final rayTip = Offset(
        center.dx + math.cos(angle) * (radius * 1.05 + rayLength),
        center.dy + math.sin(angle) * (radius * 1.05 + rayLength),
      );

      final perpAngle = angle + (math.pi / 2);
      final halfWidth = radius * 0.10;
      final rayP1 = Offset(
        rayStart.dx + math.cos(perpAngle) * halfWidth,
        rayStart.dy + math.sin(perpAngle) * halfWidth,
      );
      final rayP2 = Offset(
        rayStart.dx - math.cos(perpAngle) * halfWidth,
        rayStart.dy - math.sin(perpAngle) * halfWidth,
      );

      final rayPath = Path()
        ..moveTo(rayP1.dx, rayP1.dy)
        ..lineTo(rayTip.dx, rayTip.dy)
        ..lineTo(rayP2.dx, rayP2.dy)
        ..close();

      canvas.drawPath(rayPath, rayPaint);
    }

    // Draw Main Body
    final bodyPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          SamajhColors.kiranGold,
          SamajhColors.kiranAmber,
        ],
        stops: [0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, bodyPaint);

    // Subtle outline
    final outlinePaint = Paint()
      ..color = SamajhColors.kiranOrange.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, outlinePaint);

    // Draw Friendly Eyes (happy arcs or blinking circles)
    final eyePaint = Paint()
      ..color = SamajhColors.textNavy
      ..style = PaintingStyle.fill;

    final leftEye = Offset(center.dx - radius * 0.32, center.dy - radius * 0.08);
    final rightEye = Offset(center.dx + radius * 0.32, center.dy - radius * 0.08);
    final eyeRadius = radius * 0.09;

    canvas.drawCircle(leftEye, eyeRadius, eyePaint);
    canvas.drawCircle(rightEye, eyeRadius, eyePaint);

    // Eye catch-light (white twinkle)
    final twinklePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(leftEye.dx - eyeRadius * 0.3, leftEye.dy - eyeRadius * 0.3),
      eyeRadius * 0.35,
      twinklePaint,
    );
    canvas.drawCircle(
      Offset(rightEye.dx - eyeRadius * 0.3, rightEye.dy - eyeRadius * 0.3),
      eyeRadius * 0.35,
      twinklePaint,
    );

    // Rosy Cheeks
    final cheekPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(leftEye.dx - eyeRadius * 0.8, leftEye.dy + eyeRadius * 1.5),
      eyeRadius * 0.8,
      cheekPaint,
    );
    canvas.drawCircle(
      Offset(rightEye.dx + eyeRadius * 0.8, rightEye.dy + eyeRadius * 1.5),
      eyeRadius * 0.8,
      cheekPaint,
    );

    // Warm Smile
    final smilePaint = Paint()
      ..color = SamajhColors.textNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final smilePath = Path()
      ..moveTo(center.dx - radius * 0.22, center.dy + radius * 0.15)
      ..quadraticBezierTo(
        center.dx,
        center.dy + radius * 0.42,
        center.dx + radius * 0.22,
        center.dy + radius * 0.15,
      );

    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant _KiranPainter oldDelegate) => oldDelegate.pulse != pulse;
}
