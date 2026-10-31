import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/services/report_share_service.dart';
import '../../core/widgets/active_class_chip.dart';

class ReportsTab extends ConsumerStatefulWidget {
  const ReportsTab({super.key});

  @override
  ConsumerState<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends ConsumerState<ReportsTab> {
  final Map<String, bool> _parentReportApproved = {};

  String _localizeGroup(String rawGroup, bool isHindi) {
    final lower = rawGroup.toLowerCase();
    if (lower.contains('on_track') || lower.contains('on track') || lower.contains('लक्ष्य')) {
      return isHindi ? "लक्ष्य पर" : "On Track";
    }
    if (lower.contains('decoding') || lower.contains('reading words') || lower.contains('डिकोडिंग')) {
      return isHindi ? "डिकोडिंग अभ्यास" : "Decoding Practice";
    }
    if (lower.contains('comprehension') || lower.contains('understanding') || lower.contains('समझ')) {
      return isHindi ? "समझ अभ्यास" : "Comprehension Practice";
    }
    if (lower.contains('both') || lower.contains('दोनों')) {
      return isHindi ? "दोनों में सहयोग" : "Needs Help with Both";
    }
    return rawGroup;
  }

  void _showParentReportDialog(BuildContext context, String childName, String homeActivity, bool isHindi) {
    bool isApproved = _parentReportApproved[childName] ?? false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SamajhColors.paleMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.family_restroom_rounded, color: SamajhColors.forestGreen, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? "अभिभावक रिपोर्ट: $childName" : "Parent Report: $childName",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      isHindi ? "सरल शब्दों में रिपोर्ट" : "Plain Words Summary",
                      style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isHindi
                      ? "माता-पिता के लिए सरल शब्दों में रिपोर्ट। इसमें कोई अंक, लाल निशान या कक्षा में स्थान (रैंकिंग) शामिल नहीं है।"
                      : "Plain-language summary for parents. Contains zero scores, red marks, or class rankings.",
                  style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.4),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: SamajhColors.paleMint.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: SamajhColors.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi
                            ? "नमस्ते! $childName कक्षा में मन लगाकर पढ़ने का अच्छा प्रयास कर रहे हैं।"
                            : "Namaste! $childName is putting in sincere effort into classroom reading.",
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 15, fontWeight: FontWeight.w700, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isHindi
                            ? "आज के पठन अभ्यास में बच्चे ने बहुत से शब्द सही और आत्मविश्वास से पढ़े। समझ के प्रश्नों का भी अच्छा उत्तर दिया।"
                            : "During today's check, the learner read decodable words confidently and showed good understanding of story questions.",
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 13, height: 1.4, color: SamajhColors.textNavy),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isHindi ? "घर पर करने योग्य गतिविधि:" : "Home Activity:",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        homeActivity,
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: SamajhColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: SamajhColors.dividerColor),
                  ),
                  child: InkWell(
                    onTap: () {
                      setDialogState(() {
                        isApproved = !isApproved;
                        _parentReportApproved[childName] = isApproved;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: SamajhColors.forestGreen,
                          value: isApproved,
                          onChanged: (val) {
                            setDialogState(() {
                              isApproved = val ?? false;
                              _parentReportApproved[childName] = isApproved;
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isHindi
                                    ? "मैंने यह रिपोर्ट देख ली है और इसे स्वीकृत करता/करती हूँ"
                                    : "I have read this report and approve it",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                              ),
                              Text(
                                isHindi
                                    ? "शिक्षक स्वीकृति अनिवार्य है"
                                    : "Teacher approval gate: Must be ticked before sharing",
                                style: const TextStyle(fontSize: 10, color: SamajhColors.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(isHindi ? "बंद करें" : "Close"),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.print_outlined, size: 16),
              label: Text(isHindi ? "प्रिंट करें" : "Print"),
              onPressed: isApproved
                  ? () async {
                      Navigator.pop(ctx);
                      final firstName = childName.trim().split(RegExp(r'\s+')).first;
                      final pdfBytes = await ReportShareService.generateParentReportPdf(
                        childFirstName: firstName,
                        homeActivity: homeActivity,
                        isHindi: isHindi,
                      );
                      await ReportShareService.printPdf(
                        pdfBytes: pdfBytes,
                        jobName: '${firstName}_parent_report',
                      );
                    }
                  : null,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.share_outlined, size: 16),
              label: Text(isHindi ? "शेयर करें" : "Share"),
              onPressed: isApproved
                  ? () async {
                      Navigator.pop(ctx);
                      final firstName = childName.trim().split(RegExp(r'\s+')).first;
                      final pdfBytes = await ReportShareService.generateParentReportPdf(
                        childFirstName: firstName,
                        homeActivity: homeActivity,
                        isHindi: isHindi,
                      );
                      if (context.mounted) {
                        await ReportShareService.sharePdf(
                          context: context,
                          pdfBytes: pdfBytes,
                          firstNameOnly: firstName,
                          reportType: 'parent_report',
                        );
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _exportSchoolSummary(
    BuildContext context,
    int checkedCount,
    int onTrackCount,
    int needsHelpCount,
    int totalCount,
    bool isHindi,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: SamajhColors.paleMint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.picture_as_pdf_outlined, color: SamajhColors.forestGreen, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? "विद्यालय सारांश रिपोर्ट" : "School Summary Report",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    isHindi ? "PDF निर्यात (केवल समग्र गणना)" : "PDF Export · Aggregate Counts",
                    style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isHindi
                  ? "केवल समग्र गणना। इसमें किसी बच्चे का नाम या आवाज़ की रिकॉर्डिंग शामिल नहीं है।"
                  : "Aggregate figures only. Contains zero child names or voice recordings.",
              style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.4),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: SamajhColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    label: isHindi ? "कक्षा:" : "Class:",
                    value: "Class 3B",
                  ),
                  const Divider(color: SamajhColors.dividerColor, height: 16),
                  _SummaryRow(
                    label: isHindi ? "कुल बच्चे:" : "Total Learners:",
                    value: isHindi ? "$totalCount बच्चे" : "$totalCount learners",
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: isHindi ? "जाँच पूर्ण:" : "Checked:",
                    value: isHindi ? "$checkedCount बच्चे" : "$checkedCount learners",
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: isHindi ? "लक्ष्य पर:" : "On Track:",
                    value: isHindi ? "$onTrackCount बच्चे" : "$onTrackCount learners",
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: isHindi ? "सहयोग समूह:" : "Needs Support:",
                    value: isHindi ? "$needsHelpCount बच्चे" : "$needsHelpCount learners",
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(isHindi ? "रद्द करें" : "Cancel"),
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.print_outlined, size: 16),
            label: Text(isHindi ? "प्रिंट करें" : "Print"),
            onPressed: () async {
              Navigator.pop(ctx);
              final pdfBytes = await ReportShareService.generateClassSummaryPdf(
                className: "School Summary",
                checkedCount: checkedCount,
                totalCount: totalCount,
                onTrackCount: onTrackCount,
                needsHelpCount: needsHelpCount,
                isHindi: isHindi,
              );
              await ReportShareService.printPdf(
                pdfBytes: pdfBytes,
                jobName: 'school_summary_report',
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.share_outlined, size: 16),
            label: Text(isHindi ? "शेयर करें" : "Share"),
            onPressed: () async {
              Navigator.pop(ctx);
              final pdfBytes = await ReportShareService.generateClassSummaryPdf(
                className: "School Summary",
                checkedCount: checkedCount,
                totalCount: totalCount,
                onTrackCount: onTrackCount,
                needsHelpCount: needsHelpCount,
                isHindi: isHindi,
              );
              if (context.mounted) {
                await ReportShareService.sharePdf(
                  context: context,
                  pdfBytes: pdfBytes,
                  firstNameOnly: 'school_summary',
                  reportType: 'aggregate',
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(resultsStreamProvider).value ?? [];
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final stats = ref.watch(todayStatsProvider);
    final groupCounts = ref.watch(supportGroupCountsProvider);
    final roster = ref.watch(rosterStreamProvider).value ?? [];
    final currentLocale = ref.watch(appLanguageProvider);
    final isHindi = currentLocale.languageCode == 'hi';

    final checkedCount = stats.checkedChildren;
    final totalCount = stats.totalChildren;
    final onTrackCount = groupCounts.onTrack;
    final needsHelpCount = groupCounts.needsDecoding + groupCounts.needsComprehension + groupCounts.needsBoth;

    // Aggregate misread aksharas
    final aksharaFreq = <String, int>{};
    for (final res in results) {
      try {
        final list = (jsonDecode(res.stuckOnAksharasJson ?? '[]') as List<dynamic>?) ?? [];
        for (final item in list) {
          final str = item.toString();
          aksharaFreq[str] = (aksharaFreq[str] ?? 0) + 1;
        }
      } catch (_) {}
    }

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text(l10n.tabReports),
            const SizedBox(width: 8),
            const ActiveClassHeaderChip(),
          ],
        ),
        actions: [
          IconButton(
            key: const Key('settings_button'),
            icon: const Icon(Icons.settings_outlined, color: SamajhColors.textNavy),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // 1. Class Reading Health Dashboard Card (E1)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          isHindi
                              ? "कक्षा पठन स्वास्थ्य · ${activeClass?.name ?? 'Class 3B'}"
                              : "Class Reading Health · ${activeClass?.name ?? 'Class 3B'}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isHindi ? "यूपी निपुण" : "UP NIPUN",
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: SamajhColors.forestGreen),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _MetricBox(
                        title: isHindi ? "जाँच पूर्ण" : "Checked",
                        value: "$checkedCount / $totalCount",
                        subtitle: totalCount > 0
                            ? (isHindi
                                ? "${((checkedCount / totalCount) * 100).toInt()}% कवरेज"
                                : "${((checkedCount / totalCount) * 100).toInt()}% coverage")
                            : "0%",
                        color: SamajhColors.forestGreen,
                      ),
                      const SizedBox(width: 10),
                      _MetricBox(
                        title: isHindi ? "लक्ष्य पर" : "On Track",
                        value: "$onTrackCount",
                        subtitle: isHindi ? "निपुण 60 WPM" : "NIPUN 60 WPM",
                        color: SamajhColors.forestGreen,
                      ),
                      const SizedBox(width: 10),
                      _MetricBox(
                        title: isHindi ? "सहयोग समूह" : "Needs Help",
                        value: "$needsHelpCount",
                        subtitle: isHindi ? "नियमित अभ्यास" : "Targeted plans",
                        color: SamajhColors.needsHelpText,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: SamajhColors.dividerColor),
                  const SizedBox(height: 10),

                  // Support Groups breakdown bars
                  Text(
                    isHindi ? "सहायता समूह स्थिति:" : "Support Groups Breakdown:",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 10),
                  _GroupProgressRow(
                    label: isHindi ? "१. लक्ष्य पर" : "1. On Track",
                    count: groupCounts.onTrack,
                    total: totalCount > 0 ? totalCount : 1,
                    color: SamajhColors.forestGreen,
                    isHindi: isHindi,
                  ),
                  const SizedBox(height: 6),
                  _GroupProgressRow(
                    label: isHindi ? "२. अर्थ समझ, डिकोडिंग अभ्यास" : "2. Understands, needs decoding",
                    count: groupCounts.needsDecoding,
                    total: totalCount > 0 ? totalCount : 1,
                    color: const Color(0xFFE28743),
                    isHindi: isHindi,
                  ),
                  const SizedBox(height: 6),
                  _GroupProgressRow(
                    label: isHindi ? "३. शब्द पठन, अर्थ समझ अभ्यास" : "3. Reads words, needs comprehension",
                    count: groupCounts.needsComprehension,
                    total: totalCount > 0 ? totalCount : 1,
                    color: const Color(0xFF2A75D3),
                    isHindi: isHindi,
                  ),
                  const SizedBox(height: 6),
                  _GroupProgressRow(
                    label: isHindi ? "४. दोनों में सहयोग आवश्यक" : "4. Needs help with both",
                    count: groupCounts.needsBoth,
                    total: totalCount > 0 ? totalCount : 1,
                    color: SamajhColors.needsHelpText,
                    isHindi: isHindi,
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: SamajhColors.dividerColor),
                  const SizedBox(height: 10),
                  Text(
                    isHindi
                        ? "सर्वाधिक अटके जाने वाले अक्षर व मात्राएं:"
                        : "Most Often Misread Aksharas & Letters:",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: aksharaFreq.isNotEmpty
                        ? aksharaFreq.entries
                            .map((e) => _AksharaTag(
                                label: WordCheckScoringEngine.formatDistractorTag(e.key, isHindi: isHindi),
                                count: e.value))
                            .toList()
                        : (isHindi
                            ? const [
                                _AksharaTag(label: "संयुक्त अक्षर (क्य, प्र)", count: 3),
                                _AksharaTag(label: "बड़ी 'ई' मात्रा", count: 2),
                                _AksharaTag(label: "बिंदु / अनुस्वार", count: 2),
                                _AksharaTag(label: "ह्रस्व 'उ' मात्रा", count: 1),
                              ]
                            : const [
                                _AksharaTag(label: "Conjuncts (क्य, प्र)", count: 3),
                                _AksharaTag(label: "Long 'ee' Matra", count: 2),
                                _AksharaTag(label: "Nasal Dot (Bindu)", count: 2),
                                _AksharaTag(label: "Short 'u' Matra", count: 1),
                              ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Progress Tracking & Early-Warning Flags Card (E2, E3)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timeline_rounded, color: SamajhColors.forestGreen, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          isHindi
                              ? "प्रगति ट्रैकिंग व समय पूर्व चेतावनी"
                              : "Progress Tracking & Early-Warning Flags",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isHindi
                        ? "31 मार्च के आधिकारिक लक्ष्य की ओर प्रगति"
                        : "Linear projection towards 31 March benchmark",
                    style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SamajhColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: SamajhColors.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi
                              ? "आधिकारिक लक्ष्य: 31 मार्च तक 60 शब्द प्रति मिनट समझ सहित (NIPUN Lakshya / UP H306)। NCERT FLS 2022 Meets Band: 35-54 शब्द प्रति मिनट।"
                              : "Official benchmark: 60 correct WPM with comprehension by 31 March (NIPUN Lakshya / UP H306). NCERT FLS 2022 Meets Band: 35 to 54 WPM.",
                          style: const TextStyle(fontSize: 12, height: 1.45, color: SamajhColors.textNavy),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isHindi
                              ? "सावधानी नियम: प्रवृत्ति (ट्रेंड) का अनुमान लगाने हेतु कम से कम 2 तुलनीय जाँच (एक ही गद्यांश श्रेणी, कक्षा और भाषा) आवश्यक हैं।"
                              : "Cautious rule: At least 2 comparable checks (same passage family, grade, and language) are required to project trend.",
                          style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: SamajhColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: SamajhColors.paleMint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: SamajhColors.forestGreen),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            checkedCount >= 2
                                ? (isHindi
                                    ? "कक्षा की प्रारंभिक प्रगति सकारात्मक दिशा में है। 3 सप्ताह बाद पुनः जाँच करें।"
                                    : "Early class progress is positive. Recheck in 3 weeks.")
                                : (isHindi
                                    ? "प्रारंभिक आधारभूत जाँच जारी। पुनः जाँच 3 सप्ताह में अनुशंसित है।"
                                    : "Initial baseline recorded. Recheck recommended in 3 weeks."),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.forestGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Parent Report Section with Approval Gate (F5)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.family_restroom_rounded, color: SamajhColors.forestGreen, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          isHindi
                              ? "अभिभावक रिपोर्ट व घरेलू गतिविधि"
                              : "Parent Report & Home Activity",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isHindi
                        ? "सरल शब्दों में रिपोर्ट। शिक्षक की स्वीकृति के बाद ही साझा करें।"
                        : "Plain-language report without scores. Requires teacher approval.",
                    style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 14),

                  // Display checked learners or demo learners
                  if (results.isNotEmpty) ...[
                    ...results.take(3).map((res) {
                      final child = roster.where((c) => c.id == res.childId).firstOrNull;
                      final childName = child != null ? '${child.firstName} ${child.lastInitial}' : 'Learner';
                      final isApproved = _parentReportApproved[childName] ?? false;
                      final groupText = _localizeGroup(res.groupAssigned, isHindi);

                      return _buildParentReportCard(
                        context: context,
                        childName: childName,
                        groupText: groupText,
                        isApproved: isApproved,
                        isHindi: isHindi,
                      );
                    }),
                  ] else ...[
                    ...[
                      ('Aarav K.', isHindi ? 'डिकोडिंग अभ्यास' : 'Decoding Practice'),
                      ('Diya M.', isHindi ? 'लक्ष्य पर' : 'On Track'),
                      ('Kabir S.', isHindi ? 'समझ अभ्यास' : 'Comprehension Practice'),
                    ].map((entry) {
                      final isApproved = _parentReportApproved[entry.$1] ?? false;
                      return _buildParentReportCard(
                        context: context,
                        childName: entry.$1,
                        groupText: entry.$2,
                        isApproved: isApproved,
                        isHindi: isHindi,
                      );
                    }),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. School Summary Export Card (F7)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _exportSchoolSummary(context, checkedCount, onTrackCount, needsHelpCount, totalCount, isHindi),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.picture_as_pdf_outlined, color: SamajhColors.forestGreen, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "विद्यालय सारांश PDF निर्यात" : "School Summary PDF Export",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                            ),
                            Text(
                              isHindi
                                  ? "केवल समग्र गणना · कोई नाम, रिकॉर्डिंग या फ़ोटो नहीं"
                                  : "Aggregate counts only · No names, audio, or photos",
                              style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 5. Government Milestones Shortcut Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => context.push('/milestones'),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.verified_outlined, color: SamajhColors.forestGreen, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "कक्षा ३ सरकारी मील के पत्थर" : "Class 3 Government Milestones",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                            ),
                            Text(
                              isHindi
                                  ? "NCERT FLS 2022 व निपुण मार्गदर्शिका रजिस्टर"
                                  : "NCERT FLS 2022 & NIPUN Guidelines Register",
                              style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: SamajhColors.textMuted),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildParentReportCard({
    required BuildContext context,
    required String childName,
    required String groupText,
    required bool isApproved,
    required bool isHindi,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: SamajhColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: SamajhColors.paleMint,
            child: Text(
              childName.isNotEmpty ? childName[0] : 'L',
              style: const TextStyle(fontWeight: FontWeight.bold, color: SamajhColors.forestGreen),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  childName,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  groupText,
                  style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isApproved) ...[
                  const SizedBox(height: 2),
                  Text(
                    isHindi ? "स्वीकृत" : "Approved",
                    style: const TextStyle(fontSize: 10, color: SamajhColors.forestGreen, fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 6),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(64, 32),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            ),
            onPressed: () => _showParentReportDialog(
              context,
              childName,
              isHindi
                  ? "बच्चे के साथ रोज़ शाम 5 मिनट उसकी मनपसंद कहानी की किताब पढ़ें और चर्चा करें।"
                  : "Read a storybook together with your child for 5 minutes every evening.",
              isHindi,
            ),
            child: Text(
              isApproved
                  ? (isHindi ? "देखें" : "View")
                  : (isHindi ? "स्वीकृत करें" : "Approve"),
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _MetricBox({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 4),
            // Whole numbers count up; anything else (a ratio, a dash) shows as is.
            int.tryParse(value) != null
                ? CountUpText(int.parse(value),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color))
                : Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: SamajhColors.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _GroupProgressRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;
  final bool isHindi;

  const _GroupProgressRow({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
    required this.isHindi,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = total > 0 ? (count / total).clamp(0.0, 1.0) : 0.0;
    final countLabel = isHindi ? "$count बच्चे" : "$count learners";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(countLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        AnimatedBar(value: fraction, color: color, background: SamajhColors.background, height: 6),
      ],
    );
  }
}

class _AksharaTag extends StatelessWidget {
  final String label;
  final int count;

  const _AksharaTag({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: SamajhColors.paleMint,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.forestGreen),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: SamajhColors.forestGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textNavy)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: SamajhColors.forestGreen)),
      ],
    );
  }
}
