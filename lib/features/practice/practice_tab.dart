import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/services/report_share_service.dart';
import '../../core/widgets/active_class_chip.dart';

class PracticeTab extends ConsumerStatefulWidget {
  const PracticeTab({super.key});

  @override
  ConsumerState<PracticeTab> createState() => _PracticeTabState();
}

class _PracticeTabState extends ConsumerState<PracticeTab> {
  List<dynamic> _activities = [];
  String _selectedGroupFilter = 'all';
  final Set<String> _doneActivities = {};

  static final List<Map<String, dynamic>> _fallbackActivities = [
    {
      'id': 'act_01',
      'target_need': 'matra',
      'title_en': 'Short and Long Vowel Sound Match',
      'title_hi': 'छोटी और बड़ी मात्रा का खेल',
      'duration_minutes': 10,
      'group_codes': ['G2', 'G4'],
      'instructions_hi': 'शिक्षक श्यामपट्ट पर मात्रा युग्म (जैसे दिन/दीन, कुल/कूल, मिल/मील) लिखते हैं। बच्चे जोर से पढ़ते हैं और लंबी मात्रा पर मेज थपथपाते हैं।',
      'instructions_en': 'Teacher writes minimal word pairs on the board. Children read aloud and tap the desk when hearing the long vowel sound.',
      'home_activity_hi': 'घर पर ऐसी 3 वस्तुएं खोजें जिनके नाम में बड़ी \'ई\' की मात्रा आती हो (जैसे थाली, चाबी)।',
      'home_activity_en': 'Find 3 objects at home that have an \'ee\' sound in their names (e.g. key, plate).',
    },
    {
      'id': 'act_02',
      'target_need': 'conjunct',
      'title_en': 'Joined Letter Hunt',
      'title_hi': 'संयुक्ताक्षर खोजो और बोलो',
      'duration_minutes': 10,
      'group_codes': ['G2', 'G4'],
      'instructions_hi': 'फ्लैश कार्ड्स पर आधे अक्षर वाले शब्द (जैसे क्या, पत्ता, पुस्तक, मित्र) खोजें और धीरे-धीरे बोलकर अभ्यास करें।',
      'instructions_en': 'Children find letters joined by halant (क्य, प्र, स्त, त्र) on flash cards, pronounce the blend slowly, then say the full word.',
      'home_activity_hi': 'माता-पिता से आधे अक्षर वाले दो शब्द पूछकर कॉपी में लिखें।',
      'home_activity_en': 'Ask parents to share 2 words with half-letters and write them in the notebook.',
    },
    {
      'id': 'act_03',
      'target_need': 'bindu',
      'title_en': 'Nasal Dot: Bindu vs Chandrabindu',
      'title_hi': 'बिंदु और चंद्रबिंदु की पहचान',
      'duration_minutes': 10,
      'group_codes': ['G2'],
      'instructions_hi': 'बिंदु (रंग, गेंद) और चंद्रबिंदु (चाँद, आँख) वाले शब्दों का अंतर नाक पर उंगली रखकर महसूस करके बोलें।',
      'instructions_en': 'Practice nasalization difference: रंग, पतंग vs चाँद, आँख. Feel the nose vibration while speaking.',
      'home_activity_hi': 'कॉपी में एक चाँद और एक बिंदु बनाकर दोनों के नीचे दो-दो शब्द लिखें।',
      'home_activity_en': 'Draw a moon and a dot in your notebook and write 2 words under each.',
    },
    {
      'id': 'act_04',
      'target_need': 'word_reading',
      'title_en': 'Rapid Decodable Word Roll',
      'title_hi': 'द्रुत गति शब्द पठन',
      'duration_minutes': 10,
      'group_codes': ['G2', 'G4'],
      'instructions_hi': 'सरल दो और तीन अक्षर वाले बिना मात्रा व सरल मात्रा के शब्दों को बिना रुके एक सांस में पढ़ने का अभ्यास कराएं।',
      'instructions_en': 'Flash card pyramid: Children take turns reading cards quickly without sounding out letter by letter.',
      'home_activity_hi': 'घर के अखबार या पुरानी किताब में से 5 सरल शब्द पहचानकर पढ़ें।',
      'home_activity_en': 'Find and read 5 simple words from an old book or newspaper at home.',
    },
    {
      'id': 'act_05',
      'target_need': 'fluency',
      'title_en': 'Echo Reading for Expression',
      'title_hi': 'गूंज पठन: भाव के साथ पढ़ना',
      'duration_minutes': 10,
      'group_codes': ['G1', 'G3'],
      'instructions_hi': 'शिक्षक एक पंक्ति भाव और विराम चिह्नों के साथ पढ़ते हैं, बच्चे गूंज की तरह दोहराते हैं।',
      'instructions_en': 'Teacher reads a sentence with expression and pauses at punctuation. Children echo back together.',
      'home_activity_hi': 'घर के किसी सदस्य को आज पढ़ी गई एक छोटी कहानी हाव-भाव से सुनाएं।',
      'home_activity_en': 'Read one short story aloud to a family member with voice expression.',
    },
    {
      'id': 'act_06',
      'target_need': 'facts',
      'title_en': 'Story Detective: Who and Where',
      'title_hi': 'कहानी जासूस: कौन और कहाँ',
      'duration_minutes': 10,
      'group_codes': ['G3', 'G4'],
      'instructions_hi': 'कहानी पढ़ने के बाद बच्चों से पूछें: मुख्य पात्र कौन था? वह कहाँ गया? बच्चे पाठ में उंगली रखकर उत्तर दिखाएं।',
      'instructions_en': 'Children answer direct fact questions by pointing to the exact line in the passage.',
      'home_activity_hi': 'माता-पिता से पूछें कि उनके बचपन का सबसे प्रिय खेल कौन सा था।',
      'home_activity_en': 'Ask parents about their favourite childhood game and note it down.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _activities = _fallbackActivities;
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/practice/activities.json');
      final data = jsonDecode(jsonStr);
      if (mounted) {
        setState(() {
          _activities = (data['activities'] as List<dynamic>?) ?? _fallbackActivities;
        });
      }
    } catch (_) {}
  }

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

  void _previewAndPrintPracticeSheet(
    BuildContext context,
    String childName,
    List<String> misreadWords,
    String groupName,
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
              child: const Icon(Icons.print_outlined, color: SamajhColors.forestGreen, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? "कार्यपत्रक: $childName" : "Worksheet: $childName",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _localizeGroup(groupName, isHindi),
                    style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isHindi
                      ? "A4 प्रिंट करने योग्य पत्रक (फ़्लटर टेक्स्ट इंजन)"
                      : "A4 Printable Sheet (Flutter Native Text Engine)",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: SamajhColors.textNavy),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: SamajhColors.paleMint.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: SamajhColors.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isHindi ? "विद्यार्थी: $childName" : "Learner: $childName",
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: SamajhColors.forestGreen,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isHindi ? "कक्षा ३-ब" : "Class 3B",
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isHindi
                            ? "१. शब्द अभ्यास (सुधार व डिकोड योग्य शब्द):"
                            : "1. Word Practice (Personalized Misread & Decodable Words):",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: SamajhColors.textNavy),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        misreadWords.isNotEmpty
                            ? misreadWords.join("   ·   ")
                            : (isHindi ? "कमल   ·   सड़क   ·   मटर   ·   किताब   ·   पानी   ·   घर" : "sun   ·   tree   ·   book   ·   water   ·   home   ·   friend"),
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 16, height: 1.5, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        isHindi
                            ? "२. सरल पठन कहानी (मेले का प्रसंग):"
                            : "2. Decodable Story (Village Fair Context):",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: SamajhColors.textNavy),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isHindi
                            ? "अमन और रीता मेला देखने गए। मेले में लाल-पीले गुब्बारे बिक रहे थे। अमन ने मीठे फल खाए। रीता ने सुंदर गुड़िया ली। दोनों खुशी-खुशी घर लौटे।"
                            : "Aman and Rita went to the fair. Red and yellow balloons were swaying in the breeze. Aman ate sweet fruits while Rita chose a beautiful doll. Both returned home with joy.",
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 15, height: 1.6),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        isHindi
                            ? "३. लेखन व चित्र कार्य:"
                            : "3. Writing & Drawing Task:",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: SamajhColors.textNavy),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isHindi
                            ? "अपने मनपसंद फल या खिलौने का चित्र अपनी कॉपी में बनाओ और उसका नाम सुंदर अक्षरों में लिखो।"
                            : "Draw your favourite toy or fruit in your notebook and write its name in clear handwriting.",
                        style: TextStyle(fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter', fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: SamajhColors.dividerColor),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                isHindi
                                    ? "शिक्षक प्रोत्साहन: शाबाश! आपने बहुत अच्छा प्रयास किया।"
                                    : "Teacher Note: Great effort! Practice 10 minutes daily.",
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: SamajhColors.forestGreen),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            onPressed: () async {
              Navigator.pop(ctx);
              final firstName = childName.trim().split(RegExp(r'\s+')).first;
              final pdfBytes = await ReportShareService.generateWorksheetPdf(
                childFirstName: firstName,
                activityTitle: 'Practice Worksheet',
                instructions: isHindi ? 'प्रतिदिन 10 मिनट पढ़ने का अभ्यास करें।' : 'Practice reading and writing daily.',
                isHindi: isHindi,
              );
              await ReportShareService.printPdf(
                pdfBytes: pdfBytes,
                jobName: '${firstName}_worksheet',
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.share_outlined, size: 16),
            label: Text(isHindi ? "शेयर करें" : "Share"),
            onPressed: () async {
              Navigator.pop(ctx);
              final firstName = childName.trim().split(RegExp(r'\s+')).first;
              final pdfBytes = await ReportShareService.generateWorksheetPdf(
                childFirstName: firstName,
                activityTitle: 'Practice Worksheet',
                instructions: isHindi ? 'प्रतिदिन 10 मिनट पढ़ने का अभ्यास करें।' : 'Practice reading and writing daily.',
                isHindi: isHindi,
              );
              if (context.mounted) {
                await ReportShareService.sharePdf(
                  context: context,
                  pdfBytes: pdfBytes,
                  firstNameOnly: firstName,
                  reportType: 'worksheet',
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLearnerCard({
    required BuildContext context,
    required String childName,
    required String groupText,
    required List<String> misreadWords,
    required bool isHindi,
  }) {
    final starText = isHindi ? "शाबाश सितारा" : "Milestone Star";
    final printButtonText = isHindi ? "A4 प्रिंट" : "Print A4";

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
                const SizedBox(height: 1),
                Text(
                  groupText,
                  style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        starText,
                        style: const TextStyle(
                          fontSize: 10,
                          color: SamajhColors.forestGreen,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(64, 34),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            ),
            onPressed: () => _previewAndPrintPracticeSheet(
              context,
              childName,
              misreadWords,
              groupText,
              isHindi,
            ),
            child: Text(printButtonText, style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(resultsStreamProvider).value ?? [];
    final roster = ref.watch(rosterStreamProvider).value ?? [];
    final currentLocale = ref.watch(appLanguageProvider);
    final isHindi = currentLocale.languageCode == 'hi';

    // Filter activities
    final filteredActivities = _selectedGroupFilter == 'all'
        ? _activities
        : _activities.where((act) {
            final groups = (act['group_codes'] as List<dynamic>?) ?? [];
            return groups.contains(_selectedGroupFilter);
          }).toList();

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text(l10n.tabPractice),
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
            // 1. Personalized A4 Worksheets Section Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.print_outlined, color: SamajhColors.forestGreen),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? "व्यक्तिगत A4 कार्यपत्रक" : "Personalized A4 Worksheets",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              isHindi
                                  ? "100% डिकोड योग्य शब्द व अभ्यास"
                                  : "100% Decodable Words & Misread Practice",
                              style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isHindi
                        ? "प्रत्येक बच्चे के लिए उसकी गलतियों पर आधारित 1 पृष्ठ का अभ्यास पत्रक। देवनागरी संयुक्ताक्षरों की स्पष्ट छपाई हेतु तैयार।"
                        : "One-page practice sheet per child built from their errors. Ready to print via Android Print.",
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textNavy, height: 1.4),
                  ),
                  const SizedBox(height: 14),

                  // Display checked learners or demo learners
                  if (results.isNotEmpty) ...[
                    ...results.take(4).map((res) {
                      final child = roster.where((c) => c.id == res.childId).firstOrNull;
                      final childName = child != null ? '${child.firstName} ${child.lastInitial}' : 'Learner';
                      List<String> misreads = [];
                      try {
                        misreads = (jsonDecode(res.stuckOnAksharasJson ?? '[]') as List<dynamic>?)
                                ?.map((e) => e.toString())
                                .toList() ??
                            [];
                      } catch (_) {}

                      final localizedGroup = _localizeGroup(res.groupAssigned, isHindi);

                      return _buildLearnerCard(
                        context: context,
                        childName: childName,
                        groupText: localizedGroup,
                        misreadWords: misreads,
                        isHindi: isHindi,
                      );
                    }),
                  ] else ...[
                    // Pre-populated demo children sheets when 0 checks completed
                    ...[
                      ('Aarav K.', isHindi ? 'डिकोडिंग अभ्यास' : 'Decoding Practice', isHindi ? ['कमल', 'मटर', 'सड़क'] : ['tree', 'water', 'plant']),
                      ('Diya M.', isHindi ? 'लक्ष्य पर' : 'On Track', isHindi ? ['किताब', 'पानी', 'गुड़िया'] : ['book', 'flower', 'ball']),
                      ('Kabir S.', isHindi ? 'समझ अभ्यास' : 'Comprehension Practice', isHindi ? ['सूरज', 'जंगल', 'दोस्त'] : ['sun', 'forest', 'friend']),
                    ].map((entry) {
                      return _buildLearnerCard(
                        context: context,
                        childName: entry.$1,
                        groupText: entry.$2,
                        misreadWords: entry.$3,
                        isHindi: isHindi,
                      );
                    }),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 2. 10-Minute Group Plans Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? "10-मिनट समूह योजनाएं" : "10-Minute Group Plans",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                      ),
                      Text(
                        isHindi
                            ? "ऑफ़लाइन बैंक (14 लक्षित गतिविधियां)"
                            : "Offline Bank (14 Targeted Activities)",
                        style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: SamajhColors.paleMint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isHindi ? "${_activities.length} गतिविधियां" : "${_activities.length} Activities",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: SamajhColors.forestGreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Filter chips by group
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: isHindi ? "सभी" : "All",
                    selected: _selectedGroupFilter == 'all',
                    onTap: () => setState(() => _selectedGroupFilter = 'all'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: isHindi ? "डिकोडिंग (G2)" : "Decoding (G2)",
                    selected: _selectedGroupFilter == 'G2',
                    onTap: () => setState(() => _selectedGroupFilter = 'G2'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: isHindi ? "समझ (G3)" : "Comprehension (G3)",
                    selected: _selectedGroupFilter == 'G3',
                    onTap: () => setState(() => _selectedGroupFilter = 'G3'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: isHindi ? "प्रवाह (G1)" : "Fluency (G1)",
                    selected: _selectedGroupFilter == 'G1',
                    onTap: () => setState(() => _selectedGroupFilter = 'G1'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: isHindi ? "दोनों सहयोग (G4)" : "Both (G4)",
                    selected: _selectedGroupFilter == 'G4',
                    onTap: () => setState(() => _selectedGroupFilter = 'G4'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Activities list
            ...filteredActivities.map((act) {
              final actId = act['id']?.toString() ?? '';
              final isDone = _doneActivities.contains(actId);
              final title = isHindi
                  ? (act['title_hi'] ?? act['title_en'] ?? 'गतिविधि')
                  : (act['title_en'] ?? act['title_hi'] ?? 'Activity');
              final subtitle = isHindi
                  ? (act['title_en'] ?? '')
                  : (act['title_hi'] ?? '');
              final instructions = isHindi
                  ? (act['instructions_hi'] ?? act['instructions_en'] ?? '')
                  : (act['instructions_en'] ?? act['instructions_hi'] ?? '');
              final homeActivity = isHindi
                  ? (act['home_activity_hi'] ?? act['home_activity_en'] ?? 'घर पर 5 मिनट कहानी सुनाने को कहें।')
                  : (act['home_activity_en'] ?? act['home_activity_hi'] ?? 'Read a story together for 5 minutes.');
              final duration = act['duration_minutes'] ?? 10;
              final targetNeed = act['target_need']?.toString() ?? '';

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                              ),
                              if (subtitle.isNotEmpty && subtitle != title) ...[
                                const SizedBox(height: 2),
                                Text(subtitle, style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted)),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: SamajhColors.paleMint,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isHindi ? "$duration मिनट" : "$duration min",
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: SamajhColors.forestGreen),
                          ),
                        ),
                      ],
                    ),
                    if (targetNeed.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: SamajhColors.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: SamajhColors.dividerColor),
                        ),
                        child: Text(
                          isHindi ? "लक्ष्य: $targetNeed" : "Target: $targetNeed",
                          style: const TextStyle(fontSize: 10, color: SamajhColors.textMuted, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text(
                      instructions,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: SamajhColors.textNavy,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: SamajhColors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.home_outlined, size: 16, color: SamajhColors.forestGreen),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              isHindi ? "घर पर: $homeActivity" : "Home: $homeActivity",
                              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: SamajhColors.textMuted),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          if (isDone) {
                            _doneActivities.remove(actId);
                          } else {
                            _doneActivities.add(actId);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Icon(
                              isDone ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                              color: isDone ? SamajhColors.forestGreen : SamajhColors.textMuted,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isDone
                                  ? (isHindi ? "इस सप्ताह पूर्ण किया" : "Done this week")
                                  : (isHindi ? "इस सप्ताह करना है" : "Mark done for this week"),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDone ? SamajhColors.forestGreen : SamajhColors.textNavy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),

            // 3. Official Resources Section Card (D4)
            Container(
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
                      const Icon(Icons.menu_book_outlined, color: SamajhColors.forestGreen, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        isHindi ? "सरकारी स्रोत व संदर्भ" : "Official Curriculum References",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isHindi
                        ? "यह संपूर्ण सामग्री निम्नलिखित आधिकारिक शैक्षणिक ढांचों पर आधारित है:"
                        : "All practice materials are grounded in official government frameworks:",
                    style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 10),
                  const Text("• NIPUN Bharat Guidelines 2021 · Code H306 (p. 42)", style: TextStyle(fontSize: 12, height: 1.5)),
                  const Text("• NCERT FLS 2022 Benchmark Study · Table 4.2 (p. 68)", style: TextStyle(fontSize: 12, height: 1.5)),
                  const Text("• Basic Shiksha Parishad UP NIPUN Guide · Class 3 (p. 15)", style: TextStyle(fontSize: 12, height: 1.5)),
                  const Text("• NCF-FS 2022 Foundational Literacy Framework (p. 88)", style: TextStyle(fontSize: 12, height: 1.5)),
                  Text(
                    isHindi
                        ? "• NCERT वीणा (Veena) व उत्तर प्रदेश खुशी पाठ्यपुस्तक सूची"
                        : "• NCERT Veena and State SCERT Textbooks List",
                    style: const TextStyle(fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? SamajhColors.forestGreen : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? SamajhColors.forestGreen : SamajhColors.dividerColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : SamajhColors.textNavy,
          ),
        ),
      ),
    );
  }
}
