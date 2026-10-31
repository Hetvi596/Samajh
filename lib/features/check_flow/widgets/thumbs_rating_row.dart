import 'package:flutter/material.dart';

import '../../../app/motion.dart';
import '../../../app/theme.dart';
import '../../../core/analysis/self_rating.dart';

/// Child-facing "How did you feel?" row with two big thumbs. The rating is
/// the child's own feeling; it is never marked right or wrong on screen and
/// only the teacher sees it, next to the real result.
class ThumbsRatingRow extends StatelessWidget {
  final bool isHindi;
  final SelfRating? value;
  final ValueChanged<SelfRating> onChanged;
  final String? question;
  final double size;

  const ThumbsRatingRow({
    super.key,
    required this.isHindi,
    required this.value,
    required this.onChanged,
    this.question,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    final prompt = question ?? (isHindi ? 'तुम्हें कैसा लगा?' : 'How do you feel about it?');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          prompt,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: SamajhColors.textNavy,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: _ThumbButton(
                key: const Key('self_rating_thumbs_up'),
                emoji: '👍',
                label: isHindi ? 'अच्छा किया' : 'I did well',
                isHindi: isHindi,
                selected: value == SelfRating.thumbsUp,
                colour: const Color(0xFF15803D),
                size: size,
                onTap: () => onChanged(SelfRating.thumbsUp),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: _ThumbButton(
                key: const Key('self_rating_thumbs_down'),
                emoji: '👎',
                label: isHindi ? 'मुश्किल लगा' : 'It was hard',
                isHindi: isHindi,
                selected: value == SelfRating.thumbsDown,
                colour: const Color(0xFFB45309),
                size: size,
                onTap: () => onChanged(SelfRating.thumbsDown),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ThumbButton extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isHindi;
  final bool selected;
  final Color colour;
  final double size;
  final VoidCallback onTap;

  const _ThumbButton({
    super.key,
    required this.emoji,
    required this.label,
    required this.isHindi,
    required this.selected,
    required this.colour,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Pressable(
        pressedScale: 0.94,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: SamajhMotion.base,
            curve: SamajhMotion.enter,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? colour.withValues(alpha: 0.12) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? colour : const Color(0xFFE2E8F0), width: selected ? 3 : 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The thumb pops when chosen, so the child sees their tap counted.
                AnimatedScale(
                  scale: selected ? 1.18 : 1,
                  duration: SamajhMotion.slow,
                  curve: Curves.elasticOut,
                  child: Text(emoji, style: TextStyle(fontSize: size * 0.6)),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? colour : SamajhColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
