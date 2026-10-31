import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/providers/database_provider.dart';

class MilestonesPage extends ConsumerStatefulWidget {
  const MilestonesPage({super.key});

  @override
  ConsumerState<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends ConsumerState<MilestonesPage> {
  Map<String, dynamic>? _benchmarksData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBenchmarks();
  }

  Future<void> _loadBenchmarks() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/curriculum/benchmarks.json');
      _benchmarksData = jsonDecode(jsonStr);
      setState(() => _loading = false);
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final appLocale = ref.watch(appLanguageProvider);
    final isHindi = appLocale.languageCode == 'hi';

    final grade = activeClass?.grade ?? 3;
    final stateName = activeClass?.curriculum == 'rajasthan'
        ? "Rajasthan"
        : (activeClass?.curriculum == 'ncert' ? "NCERT / National" : "Uttar Pradesh");
    final langName = activeClass?.checkLanguage == 'en' ? "English" : "Hindi";

    final grades = _benchmarksData?['grades'] as Map<String, dynamic>? ?? {};
    final gradeInfo = grades['$grade'] as Map<String, dynamic>? ?? {};

    final hasSpeed = gradeInfo['has_official_speed_target'] == true;
    final targetText = isHindi
        ? (gradeInfo['official_target_text_hi'] ?? gradeInfo['official_target_text_en'] ?? '')
        : (gradeInfo['official_target_text_en'] ?? '');
    final sourceLabel = gradeInfo['source_label'] ?? 'NIPUN Bharat / FLS 2022';
    final explanation = isHindi
        ? (gradeInfo['explanation_hi'] ?? gradeInfo['explanation_en'] ?? '')
        : (gradeInfo['explanation_en'] ?? '');

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(isHindi ? "कक्षा $grade मील के पत्थर" : "Class $grade Milestones"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                children: [
                  // Heading "<State> · <Language>"
                  Text(
                    "$stateName · $langName",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: SamajhColors.textNavy,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Explanation
                  Text(
                    isHindi
                        ? "इस कक्षा के बच्चों से क्या अपेक्षा की जाती है, सरकारी दस्तावेजों के आधार पर। प्रत्येक पंक्ति अपना स्रोत दर्शाती है।"
                        : "What children in this class are expected to be able to do, from government documents. Each line names its source.",
                    style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  // Reading Speed Box
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: SamajhColors.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.speed_rounded, color: SamajhColors.forestGreen, size: 24),
                            const SizedBox(width: 10),
                            Text(
                              isHindi ? "पठन गति (Reading speed)" : "Reading speed",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: SamajhColors.textNavy,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (hasSpeed) ...[
                          Text(
                            targetText,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: SamajhColors.forestGreen,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              Chip(
                                label: Text(sourceLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                                backgroundColor: SamajhColors.paleMint,
                                side: BorderSide.none,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            explanation,
                            style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                          ),
                        ] else ...[
                          Text(
                            isHindi
                                ? "कोई आधिकारिक संख्या नहीं; बच्चे की अपनी पिछली जांचों से तुलना की जाती है।"
                                : "No official number; compared with the child's own earlier checks.",
                            style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted, height: 1.4),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Section: Reading Outcomes
                  _MilestoneSection(
                    title: isHindi ? "पठन (Reading)" : "Reading",
                    icon: Icons.menu_book_rounded,
                    outcomes: [
                      _OutcomeItem(
                        code: "H${grade}01",
                        source: "NIPUN Lakshya",
                        text: isHindi
                            ? "परिचित और अपरिचित शब्दों को धाराप्रवाह पढ़ना और अर्थ समझना।"
                            : "Reads familiar and unfamiliar words fluently with understanding.",
                      ),
                      _OutcomeItem(
                        code: "H${grade}06",
                        source: "UP Basic Shiksha",
                        text: isHindi
                            ? "कम से कम 60 शब्द प्रति मिनट की गति से अपठित गद्यांश पढ़ना।"
                            : "Reads unseen passage at official benchmark speed with meaning.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Section: Writing Outcomes
                  _MilestoneSection(
                    title: isHindi ? "लेखन (Writing)" : "Writing",
                    icon: Icons.edit_note_rounded,
                    outcomes: [
                      _OutcomeItem(
                        code: "W${grade}02",
                        source: "NCERT Elementary",
                        text: isHindi
                            ? "श्रुतलेख के 5 में से 4 शब्दों को सही वर्तनी (मात्राओं) के साथ लिखना।"
                            : "Writes dictated words with correct spelling and matra accuracy.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Section: Listening & Speaking Outcomes
                  _MilestoneSection(
                    title: isHindi ? "सुनना और बोलना (Listening & Speaking)" : "Listening and speaking",
                    icon: Icons.record_voice_over_rounded,
                    outcomes: [
                      _OutcomeItem(
                        code: "L${grade}03",
                        source: "NCF-FS 2022",
                        text: isHindi
                            ? "सुनी गई कहानी को अपने शब्दों में पुनः सुनाना और मुख्य घटनाएं बताना।"
                            : "Retells a heard story in own words and describes key events.",
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
      ),
    );
  }
}

class _MilestoneSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_OutcomeItem> outcomes;

  const _MilestoneSection({
    required this.title,
    required this.icon,
    required this.outcomes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: SamajhColors.forestGreen, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...outcomes.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: SamajhColors.paleMint,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.code,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.source,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.text,
                      style: const TextStyle(fontSize: 13, color: SamajhColors.textNavy, height: 1.4),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _OutcomeItem {
  final String code;
  final String source;
  final String text;

  const _OutcomeItem({
    required this.code,
    required this.source,
    required this.text,
  });
}
