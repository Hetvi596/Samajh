import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/sync/auto_sync_manager.dart';

class ActiveClassState {
  final String name;
  final int grade;
  final String curriculum;
  final String schoolLanguage;

  const ActiveClassState({
    this.name = 'Class 3A',
    this.grade = 3,
    this.curriculum = 'up',
    this.schoolLanguage = 'hi',
  });

  ActiveClassState copyWith({
    String? name,
    int? grade,
    String? curriculum,
    String? schoolLanguage,
  }) {
    return ActiveClassState(
      name: name ?? this.name,
      grade: grade ?? this.grade,
      curriculum: curriculum ?? this.curriculum,
      schoolLanguage: schoolLanguage ?? this.schoolLanguage,
    );
  }
}

class ClassController extends StateNotifier<ActiveClassState> {
  ClassController() : super(const ActiveClassState());

  void updateClass({
    String? name,
    int? grade,
    String? curriculum,
    String? schoolLanguage,
  }) {
    state = state.copyWith(
      name: name,
      grade: grade,
      curriculum: curriculum,
      schoolLanguage: schoolLanguage,
    );
  }
}

final activeClassProvider = StateNotifierProvider<ClassController, ActiveClassState>((ref) {
  return ClassController();
});

class ClassSetupScreen extends ConsumerStatefulWidget {
  const ClassSetupScreen({super.key});

  @override
  ConsumerState<ClassSetupScreen> createState() => _ClassSetupScreenState();
}

class _ClassSetupScreenState extends ConsumerState<ClassSetupScreen> {
  late TextEditingController _nameController;
  int _selectedGrade = 3;
  String _selectedSection = 'A';
  String _selectedCurriculum = 'up';
  String _selectedLanguage = 'hi';
  bool _isCustomNameEdited = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Class 3A');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateDefaultNameIfNeeded() {
    if (!_isCustomNameEdited) {
      _nameController.text = 'Class $_selectedGrade$_selectedSection';
    }
  }

  Future<void> _createClassAndProceed() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      final db = ref.read(appDatabaseProvider);
      final now = DateTime.now();
      final classId = 'class_${now.millisecondsSinceEpoch}';
      final enteredName = _nameController.text.trim();
      final finalName = enteredName.isEmpty ? 'Class $_selectedGrade$_selectedSection' : enteredName;

      // 1. Insert new class with scope: 'real'
      await db.into(db.classesTable).insert(
        ClassesTableCompanion.insert(
          id: classId,
          scope: 'real',
          name: finalName,
          grade: _selectedGrade,
          section: _selectedSection,
          curriculum: _selectedCurriculum,
          checkLanguage: _selectedLanguage,
          mediumOfInstruction: _selectedLanguage,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // 2. Set activeScope and activeClassId in global settings to 'real'
      await db.update(db.appSettingsTable).write(
        AppSettingsTableCompanion(
          activeClassId: drift.Value(classId),
          activeScope: const drift.Value('real'),
          legalReviewCompleted: const drift.Value(true),
          readingLanguage: drift.Value(_selectedLanguage == 'en' ? 'en' : 'hi'),
        ),
      );

      // 3. Update legacy in-memory provider for test compatibility
      ref.read(activeClassProvider.notifier).updateClass(
            name: finalName,
            grade: _selectedGrade,
            curriculum: _selectedCurriculum,
            schoolLanguage: _selectedLanguage,
          );

      // 4. Update activeScope, selectedClassId, and readingLanguage state providers
      ref.read(selectedClassIdProvider.notifier).state = classId;
      ref.read(activeScopeProvider.notifier).state = 'real';
      ref.read(readingLanguageProvider.notifier).state = _selectedLanguage == 'en' ? 'en' : 'hi';

      // 5. Trigger direct background sync to Supabase if connected
      ref.read(autoSyncManagerProvider).triggerSync();

      if (mounted) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop(classId);
        } else {
          context.go('/app/today');
        }
      }
    } catch (e) {
      debugPrint('Error creating class: $e');
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating class: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.classSetupTitle),
        automaticallyImplyLeading: Navigator.of(context).canPop(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SamajhColors.paleMint,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: SamajhColors.forestGreen.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.school, color: SamajhColors.forestGreen, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.classSetupSubtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: SamajhColors.forestGreen,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 1. Grade / Standard Selector (1 to 5)
            Text(
              l10n.gradeLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                final grade = index + 1;
                final isSelected = _selectedGrade == grade;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index == 4 ? 0 : 8.0),
                    child: InkWell(
                      key: Key('grade_chip_$grade'),
                      onTap: () {
                        setState(() {
                          _selectedGrade = grade;
                          _updateDefaultNameIfNeeded();
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? SamajhColors.forestGreen : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? SamajhColors.forestGreen : SamajhColors.dividerColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: SamajhColors.forestGreen.withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  )
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            "$grade",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: isSelected ? Colors.white : SamajhColors.textNavy,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // 2. Section Selector (A, B, C, D)
            Text(
              l10n.sectionLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: ['A', 'B', 'C', 'D'].map((sec) {
                final isSelected = _selectedSection == sec;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      key: Key('section_chip_$sec'),
                      onTap: () {
                        setState(() {
                          _selectedSection = sec;
                          _updateDefaultNameIfNeeded();
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? SamajhColors.forestGreen : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? SamajhColors.forestGreen : SamajhColors.dividerColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            sec,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : SamajhColors.textNavy,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 3. Board / Curriculum Dropdown
            Text(
              l10n.boardLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  key: const Key('curriculum_dropdown'),
                  value: _selectedCurriculum,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: SamajhColors.forestGreen),
                  items: [
                    DropdownMenuItem(value: 'up', child: Text(l10n.curriculumUp)),
                    DropdownMenuItem(value: 'ncert_cbse', child: Text(l10n.curriculumNcert)),
                    DropdownMenuItem(value: 'bihar', child: Text(l10n.curriculumBihar)),
                    DropdownMenuItem(value: 'rajasthan', child: Text(l10n.curriculumRajasthan)),
                    DropdownMenuItem(value: 'mp', child: Text(l10n.curriculumMp)),
                    DropdownMenuItem(value: 'maharashtra', child: Text(l10n.curriculumMaharashtra)),
                    DropdownMenuItem(value: 'icse', child: Text(l10n.curriculumIcse)),
                    DropdownMenuItem(value: 'school_own', child: Text(l10n.curriculumSchoolOwn)),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCurriculum = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Medium of Instruction / Language
            Text(
              l10n.mediumOfInstructionLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  key: const Key('school_language_dropdown'),
                  value: _selectedLanguage,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: SamajhColors.forestGreen),
                  items: [
                    DropdownMenuItem(value: 'hi', child: Text(l10n.hindi)),
                    DropdownMenuItem(value: 'en', child: Text(l10n.english)),
                    DropdownMenuItem(value: 'mr', child: Text(l10n.marathi)),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLanguage = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 5. Class / School Name
            Text(
              l10n.classNameLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const Key('class_name_field'),
              controller: _nameController,
              onChanged: (_) {
                _isCustomNameEdited = true;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: l10n.classNameHint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: SamajhColors.dividerColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: SamajhColors.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: SamajhColors.forestGreen, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 6. Create Class Button
            ElevatedButton(
              key: const Key('create_class_button'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _isSubmitting ? null : _createClassAndProceed,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(l10n.createClassButton),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
