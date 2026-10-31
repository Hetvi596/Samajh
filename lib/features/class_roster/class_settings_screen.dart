import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

class ClassSettingsScreen extends ConsumerStatefulWidget {
  const ClassSettingsScreen({super.key});

  @override
  ConsumerState<ClassSettingsScreen> createState() => _ClassSettingsScreenState();
}

class _ClassSettingsScreenState extends ConsumerState<ClassSettingsScreen> {
  Map<String, dynamic>? _registryData;
  bool _loading = true;

  late String _curriculum;
  late int _grade;
  late String _checkLanguage;
  late String _mediumOfInstruction;
  String? _homeDialect;
  String? _selectedChapter;

  @override
  void initState() {
    super.initState();
    _loadRegistry();
  }

  Future<void> _loadRegistry() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/curriculum/registry.json');
      _registryData = jsonDecode(jsonStr);
    } catch (_) {}

    final activeClass = ref.read(activeClassStreamProvider).value;
    _curriculum = activeClass?.curriculum ?? 'up';
    _grade = activeClass?.grade ?? 3;
    _checkLanguage = activeClass?.checkLanguage ?? 'hi';
    _mediumOfInstruction = activeClass?.mediumOfInstruction ?? 'hi';
    _homeDialect = activeClass?.homeDialect;
    _selectedChapter = activeClass?.currentChapter;

    setState(() => _loading = false);
  }

  Map<String, dynamic>? _findVerifiedTextbook() {
    final textbooks = _registryData?['textbooks'] as List<dynamic>? ?? [];
    for (final tb in textbooks) {
      if (tb['grade'] == _grade) {
        final matchesCurriculum = tb['curriculum_id'] == _curriculum ||
            (_curriculum == 'up' && tb['curriculum_id'] == 'up') ||
            (_curriculum == 'ncert' && tb['curriculum_id'] == 'ncert_cbse');
        if (matchesCurriculum) {
          return tb as Map<String, dynamic>;
        }
      }
    }
    return null;
  }

  String _getStageDescription(int grade, bool isHindi) {
    if (grade <= 2) {
      return isHindi
          ? "बुनियादी स्तर (NEP 2020 / NCF-FS): अक्षर-ध्वनि संबंध, सरल शब्दों को पढ़ना और सुनकर समझना।"
          : "Foundational Stage (NEP 2020 / NCF-FS): Letter-sound correspondence, decoding simple words, and listening comprehension.";
    } else {
      return isHindi
          ? "प्रारंभिक स्तर (कक्षा 3 से 5): प्रवाह और समझ के साथ पढ़ना, वाक्य संरचना और लिखित अभिव्यक्ति।"
          : "Preparatory Stage (Classes 3 to 5): Reading with fluency and understanding, sentence structure, and written expression.";
    }
  }

  Future<void> _saveSettings() async {
    final l10n = AppLocalizations.of(context)!;
    final activeClass = ref.read(activeClassStreamProvider).value;
    if (activeClass == null) return;

    final db = ref.read(appDatabaseProvider);
    final textbook = _findVerifiedTextbook();

    await (db.update(db.classesTable)..where((t) => t.id.equals(activeClass.id))).write(
      ClassesTableCompanion(
        curriculum: drift.Value(_curriculum),
        grade: drift.Value(_grade),
        checkLanguage: drift.Value(_checkLanguage),
        mediumOfInstruction: drift.Value(_mediumOfInstruction),
        homeDialect: drift.Value(_homeDialect),
        textbookId: drift.Value(textbook?['title']),
        currentChapter: drift.Value(_selectedChapter),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );

    // Synchronize reading language settings
    final newReadingLang = _checkLanguage == 'en' ? 'en' : 'hi';
    ref.read(readingLanguageProvider.notifier).state = newReadingLang;
    await db.update(db.appSettingsTable).write(
      AppSettingsTableCompanion(
        readingLanguage: drift.Value(newReadingLang),
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n.classSettingsSaved),
          duration: const Duration(seconds: 2),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.classSettingsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final textbook = _findVerifiedTextbook();
    final chapters = textbook?['sample_chapters'] as List<dynamic>? ?? [];

    final isHindi = Localizations.localeOf(context).languageCode == 'hi';

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.classSettingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // School curriculum
            DropdownButtonFormField<String>(
              initialValue: _curriculum,
              decoration: InputDecoration(
                labelText: l10n.curriculumLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'up', child: Text(l10n.curriculumUp)),
                DropdownMenuItem(value: 'ncert', child: Text(l10n.curriculumNcert)),
                DropdownMenuItem(value: 'rajasthan', child: Text(l10n.curriculumRajasthan)),
                DropdownMenuItem(value: 'school_own', child: Text(l10n.curriculumSchoolOwn)),
              ],
              onChanged: (val) => setState(() {
                _curriculum = val!;
                _selectedChapter = null;
              }),
            ),
            const SizedBox(height: 16),
            // Class (1 to 5)
            DropdownButtonFormField<int>(
              initialValue: _grade,
              decoration: InputDecoration(
                labelText: l10n.gradeLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 1, child: Text(l10n.grade1)),
                DropdownMenuItem(value: 2, child: Text(l10n.grade2)),
                DropdownMenuItem(value: 3, child: Text(l10n.grade3)),
                DropdownMenuItem(value: 4, child: Text(l10n.grade4)),
                DropdownMenuItem(value: 5, child: Text(l10n.grade5)),
              ],
              onChanged: (val) => setState(() {
                _grade = val!;
                _selectedChapter = null;
              }),
            ),
            const SizedBox(height: 6),
            // Plain words stage description line
            Text(
              _getStageDescription(_grade, isHindi),
              style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.4),
            ),
            const SizedBox(height: 16),
            // Language of the check
            DropdownButtonFormField<String>(
              initialValue: _checkLanguage,
              decoration: InputDecoration(
                labelText: l10n.schoolLanguageLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'hi', child: Text(isHindi ? "हिन्दी" : "Hindi")),
                DropdownMenuItem(value: 'en', child: Text(isHindi ? "अंग्रेज़ी" : "English")),
              ],
              onChanged: (val) => setState(() => _checkLanguage = val!),
            ),
            const SizedBox(height: 16),
            // Medium of instruction
            DropdownButtonFormField<String>(
              initialValue: _mediumOfInstruction,
              decoration: InputDecoration(
                labelText: l10n.mediumOfInstructionLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'hi', child: Text(isHindi ? "हिन्दी" : "Hindi")),
                DropdownMenuItem(value: 'en', child: Text(isHindi ? "अंग्रेज़ी" : "English")),
              ],
              onChanged: (val) => setState(() => _mediumOfInstruction = val!),
            ),
            const SizedBox(height: 16),
            // Home / Regional Dialect
            DropdownButtonFormField<String?>(
              initialValue: _homeDialect,
              decoration: InputDecoration(
                labelText: isHindi ? "कक्षा की क्षेत्रीय बोली (वैकल्पिक)" : "Class Regional Dialect (Optional)",
                border: const OutlineInputBorder(),
                helperText: isHindi
                    ? "स्वीकृत बोलियाँ त्रुटि नहीं मानी जाएँगी"
                    : "Accepted regional variants are not marked as errors",
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(isHindi ? "मानक हिन्दी (कोई नहीं)" : "Standard Hindi (None)")),
                DropdownMenuItem(value: 'awadhi_bhojpuri', child: Text(isHindi ? "अवधी / भोजपुरी (पूर्वी उप्र/बिहार)" : "Awadhi / Bhojpuri (UP/Bihar)")),
                DropdownMenuItem(value: 'rajasthani', child: Text(isHindi ? "राजस्थानी (पश्चिमी प्रभाव)" : "Rajasthani (Western influence)")),
                DropdownMenuItem(value: 'marathi_influenced', child: Text(isHindi ? "मराठी-प्रभावित हिन्दी" : "Marathi-influenced Hindi")),
                DropdownMenuItem(value: 'punjabi_influenced', child: Text(isHindi ? "पंजाबी-प्रभावित हिन्दी" : "Punjabi-influenced Hindi")),
              ],
              onChanged: (val) => setState(() => _homeDialect = val),
            ),
            const SizedBox(height: 20),
            // Textbook Card (from registry.json)
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isHindi ? "पाठ्यपुस्तक" : "Textbook",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                      ),
                      if (textbook != null && textbook['verification'] == 'verified')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: SamajhColors.paleMint,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isHindi ? "आधिकारिक स्रोत से सत्यापित" : "Verified from official source",
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (textbook != null) ...[
                    Text(
                      textbook['title'] ?? (isHindi ? 'सत्यापित पाठ्यपुस्तक' : 'Verified Textbook'),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isHindi
                          ? "प्रकाशक: ${textbook['publisher'] ?? 'आधिकारिक राज्य बोर्ड'}"
                          : "Publisher: ${textbook['publisher'] ?? 'Official State Board'}",
                      style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                    ),
                  ] else ...[
                    Text(
                      isHindi
                          ? "इस पाठ्यक्रम और कक्षा संयोजन के लिए कोई सत्यापित आधिकारिक पाठ्यपुस्तक पंजीकृत नहीं है।"
                          : "No verified official textbook registered for this curriculum and grade combination.",
                      style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Current chapter
            if (chapters.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                initialValue: _selectedChapter ?? chapters.first.toString(),
                decoration: InputDecoration(
                  labelText: isHindi ? "वर्तमान अध्याय" : "Current chapter",
                  border: const OutlineInputBorder(),
                ),
                items: chapters.map((ch) {
                  return DropdownMenuItem<String>(
                    value: ch.toString(),
                    child: Text(ch.toString()),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedChapter = val),
              ),
              const SizedBox(height: 24),
            ],
            // Save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              onPressed: _saveSettings,
              child: Text(l10n.saveClassSettings),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
