import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Motion rules for the whole app. Every animation here plays once in answer
/// to something (a screen opening, a tap, a result) and is skipped when the
/// phone asks for less motion (Settings > Accessibility > Remove animations).
class SamajhMotion {
  SamajhMotion._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration base = Duration(milliseconds: 260);
  static const Duration slow = Duration(milliseconds: 420);
  static const Duration count = Duration(milliseconds: 900);

  /// Gap between items of a staggered entrance; capped so long lists never
  /// keep the teacher waiting.
  static const Duration stagger = Duration(milliseconds: 55);
  static const int maxStaggerSteps = 8;

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve spring = Curves.easeOutBack;

  static bool reduced(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}

/// Fades and lifts its child into place once, after `index` stagger steps.
class EntranceFade extends StatelessWidget {
  final Widget child;
  final int index;
  final double offsetY;

  const EntranceFade({super.key, required this.child, this.index = 0, this.offsetY = 14});

  @override
  Widget build(BuildContext context) {
    if (SamajhMotion.reduced(context)) return child;
    final steps = index.clamp(0, SamajhMotion.maxStaggerSteps);
    final delay = SamajhMotion.stagger * steps;
    final total = SamajhMotion.slow + delay;
    final start = delay.inMilliseconds / total.inMilliseconds;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      curve: Interval(start, 1, curve: SamajhMotion.enter),
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, (1 - t) * offsetY), child: child),
      ),
    );
  }
}

/// Slides and fades a new step in from the right. Give it a key that changes
/// with the step so it plays again for each one.
class StepEnter extends StatelessWidget {
  final Widget child;

  const StepEnter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (SamajhMotion.reduced(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: SamajhMotion.base,
      curve: SamajhMotion.enter,
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset((1 - t) * 28, 0), child: child),
      ),
    );
  }
}

/// Shrinks slightly while a finger is down, so every card and button answers
/// the touch immediately. It only listens; taps still reach the child.
class Pressable extends StatefulWidget {
  final Widget child;
  final double pressedScale;

  const Pressable({super.key, required this.child, this.pressedScale = 0.97});

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  void _set(bool down) {
    if (_down != down) setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) {
    if (SamajhMotion.reduced(context)) return widget.child;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.pressedScale : 1,
        duration: SamajhMotion.fast,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// A whole number that counts up to [value] the first time it is shown and
/// rolls to the new value when it changes.
class CountUpText extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final String Function(int)? format;

  const CountUpText(this.value, {super.key, this.style, this.format});

  @override
  Widget build(BuildContext context) {
    final show = format ?? (v) => '$v';
    if (SamajhMotion.reduced(context)) return Text(show(value), style: style);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: SamajhMotion.count,
      curve: SamajhMotion.enter,
      builder: (context, v, _) => Text(show(v.round()), style: style),
    );
  }
}

/// A rounded progress bar that grows to [value] instead of jumping there.
class AnimatedBar extends StatelessWidget {
  final double value;
  final Color color;
  final Color background;
  final double height;

  const AnimatedBar({super.key, required this.value, required this.color, required this.background, this.height = 8});

  @override
  Widget build(BuildContext context) {
    final target = value.clamp(0.0, 1.0);
    Widget bar(double v) => ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: v,
        backgroundColor: background,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: height,
      ),
    );
    if (SamajhMotion.reduced(context)) return bar(target);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: SamajhMotion.count,
      curve: SamajhMotion.enter,
      builder: (context, v, _) => bar(v),
    );
  }
}

/// A ring that fills to [value] (0 to 1) with [center] in the middle.
class ProgressRing extends StatelessWidget {
  final double value;
  final double size;
  final double stroke;
  final Color color;
  final Color track;
  final Widget? center;

  const ProgressRing({
    super.key,
    required this.value,
    required this.color,
    required this.track,
    this.size = 64,
    this.stroke = 7,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    final target = value.clamp(0.0, 1.0);
    Widget ring(double v) => SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(value: v, stroke: stroke, color: color, track: track),
        child: Center(child: center),
      ),
    );
    if (SamajhMotion.reduced(context)) return ring(target);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: SamajhMotion.count,
      curve: SamajhMotion.enter,
      builder: (context, v, _) => ring(v),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double value;
  final double stroke;
  final Color color;
  final Color track;

  _RingPainter({required this.value, required this.stroke, required this.color, required this.track});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(stroke / 2, stroke / 2) & Size(size.width - stroke, size.height - stroke);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, 2 * math.pi, false, paint..color = track);
    if (value > 0) {
      canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * value, false, paint..color = color);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.value != value || old.color != color || old.track != track;
}

/// Grey placeholder blocks with a soft moving shine, shown while real
/// content loads. Without motion it is a still grey block.
class Skeleton extends StatefulWidget {
  final double height;
  final double? width;
  final double radius;

  const Skeleton({super.key, this.height = 16, this.width, this.radius = 10});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (SamajhMotion.reduced(context)) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const base = Color(0xFFEDE9E0);
    const shine = Color(0xFFF8F6F1);
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final x = _c.value * 3 - 1.5;
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(x - 1, 0),
              end: Alignment(x + 1, 0),
              colors: const [base, shine, base],
            ),
          ),
        );
      },
    );
  }
}

/// A short burst of paper confetti that plays once over its child. Used only
/// for real moments: a child finishing their reading, a check being saved.
class ConfettiBurst extends StatefulWidget {
  final Widget child;
  final bool play;

  const ConfettiBurst({super.key, required this.child, this.play = true});

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
  late final List<_Piece> _pieces = _Piece.scatter(36);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started && widget.play && !SamajhMotion.reduced(context)) {
      _started = true;
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _c,
              builder: (context, _) =>
                  _c.isAnimating ? CustomPaint(painter: _ConfettiPainter(_pieces, _c.value)) : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Piece {
  final double x, speed, drift, spin, size;
  final Color color;

  _Piece(this.x, this.speed, this.drift, this.spin, this.size, this.color);

  static const _colors = [
    Color(0xFFFBBF24), // Kiran gold
    Color(0xFF27775A), // board green
    Color(0xFF60A5FA), // notebook-rule blue
    Color(0xFFF97316), // marigold
    Color(0xFFE11D48), // bindi red
  ];

  // Fixed seed: the same pleasant spread every time, nothing random to test.
  static List<_Piece> scatter(int n) {
    final r = math.Random(7);
    return [
      for (var i = 0; i < n; i++)
        _Piece(
          r.nextDouble(),
          0.7 + r.nextDouble() * 0.6,
          (r.nextDouble() - 0.5) * 0.25,
          (r.nextDouble() - 0.5) * 12,
          5 + r.nextDouble() * 5,
          _colors[i % _colors.length],
        ),
    ];
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_Piece> pieces;
  final double t;

  _ConfettiPainter(this.pieces, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final fade = t < 0.75 ? 1.0 : (1 - t) / 0.25;
    for (final p in pieces) {
      final y = -20 + (size.height * 0.75) * Curves.easeOutQuad.transform((t * p.speed).clamp(0, 1));
      final x = size.width * (p.x + p.drift * t);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin * t);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.55),
          const Radius.circular(1.5),
        ),
        Paint()..color = p.color.withValues(alpha: fade),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.t != t;
}

/// Page change used across the app: the new screen slides in a short way
/// from the right while fading in; the old one eases back. Instant when the
/// phone asks for less motion.
class SamajhPageTransitionsBuilder extends PageTransitionsBuilder {
  const SamajhPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (SamajhMotion.reduced(context)) return child;
    final enter = CurvedAnimation(parent: animation, curve: SamajhMotion.enter, reverseCurve: SamajhMotion.exit);
    final under = CurvedAnimation(parent: secondaryAnimation, curve: SamajhMotion.enter);
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: const Offset(-0.06, 0)).animate(under),
      child: FadeTransition(
        opacity: enter,
        child: SlideTransition(
          position: Tween(begin: const Offset(0.08, 0), end: Offset.zero).animate(enter),
          child: child,
        ),
      ),
    );
  }
}
