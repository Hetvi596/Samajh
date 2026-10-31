import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../core/analysis/self_rating.dart';
import '../student_mode/kiran_mascot.dart';
import 'check_flow_controller.dart';
import 'widgets/thumbs_rating_row.dart';
import 'word_check_step_view.dart';

/// Child-facing: at the end of Student Mode (after reading, the word check
/// and typing) the child says once how the whole thing felt. Shown only to
/// the teacher later, beside the result.
class ReadingSelfRatingStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const ReadingSelfRatingStepView({super.key, required this.session});

  @override
  ConsumerState<ReadingSelfRatingStepView> createState() => _ReadingSelfRatingStepViewState();
}

class _ReadingSelfRatingStepViewState extends ConsumerState<ReadingSelfRatingStepView> {
  SelfRating? _rating;

  void _showTeacherExitSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StudentPasscodeSheet(
        onSuccess: () {
          Navigator.pop(ctx);
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = widget.session.isPassageHindi;
    final font = isHindi ? 'NotoSansDevanagari' : 'Inter';
    final title = isHindi ? 'तुमने सब पूरा कर लिया!' : 'You finished everything!';
    final question = isHindi ? 'आज का काम तुम्हें कैसा लगा?' : 'How did today feel?';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showTeacherExitSheet();
      },
      child: Scaffold(
        backgroundColor: SamajhColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _showTeacherExitSheet,
                  icon: const Icon(Icons.lock_outline_rounded, size: 16, color: SamajhColors.textMuted),
                  label: Text(
                    isHindi ? 'शिक्षक' : 'Teacher',
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const KiranMascot(size: 120, animated: true),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: font,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: SamajhColors.forestGreen,
                          ),
                        ),
                        const SizedBox(height: 28),
                        ThumbsRatingRow(
                          isHindi: isHindi,
                          value: _rating,
                          question: question,
                          size: 84,
                          onChanged: (r) => setState(() => _rating = r),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: ElevatedButton(
                  key: const Key('reading_self_rating_next'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: SamajhColors.textNavy,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: SamajhColors.creamTrack,
                    disabledForegroundColor: SamajhColors.textMuted,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: _rating == null
                      ? null
                      : () => ref.read(checkFlowControllerProvider.notifier).setReadingSelfRating(_rating!),
                  child: Text(
                    isHindi ? 'आगे बढ़ें' : 'Next',
                    style: TextStyle(fontFamily: font, fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
