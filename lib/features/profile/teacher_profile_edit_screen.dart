import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';

/// Full-page form for the teacher's own details. Everything except the name
/// is optional, and all of it stays on this phone (the profile is not synced).
class TeacherProfileEditScreen extends ConsumerStatefulWidget {
  const TeacherProfileEditScreen({super.key});

  @override
  ConsumerState<TeacherProfileEditScreen> createState() => _TeacherProfileEditScreenState();
}

class _TeacherProfileEditScreenState extends ConsumerState<TeacherProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _callName = TextEditingController();
  final _school = TextEditingController();
  final _udise = TextEditingController();
  final _block = TextEditingController();
  final _district = TextEditingController();
  final _years = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  String? _role;
  String? _state;
  String _language = 'hi';
  bool _loaded = false;
  bool _saving = false;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await ref.read(appDatabaseProvider).getTeacherProfile();
    if (!mounted) return;
    setState(() {
      if (p != null) {
        _name.text = p.teacherName;
        _callName.text = p.displayName ?? '';
        _school.text = p.schoolName ?? '';
        _udise.text = p.udiseCode ?? '';
        _block.text = p.block ?? '';
        _district.text = p.district ?? '';
        _years.text = p.yearsTeaching?.toString() ?? '';
        _phone.text = p.phone ?? '';
        _email.text = p.email ?? '';
        _role = p.role;
        _state = p.state;
        _language = p.preferredLanguage;
      }
      _loaded = true;
    });
  }

  @override
  void dispose() {
    for (final c in [_name, _callName, _school, _udise, _block, _district, _years, _phone, _email]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _opt(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    await ref
        .read(appDatabaseProvider)
        .saveTeacherProfileDetails(
          TeacherProfileTableCompanion(
            teacherName: Value(_name.text.trim()),
            displayName: Value(_opt(_callName)),
            role: Value(_role),
            schoolName: Value(_opt(_school)),
            udiseCode: Value(_opt(_udise)),
            block: Value(_opt(_block)),
            district: Value(_opt(_district)),
            state: Value(_state),
            yearsTeaching: Value(int.tryParse(_years.text.trim())),
            phone: Value(_opt(_phone)),
            email: Value(_opt(_email)),
            preferredLanguage: Value(_language),
          ),
        );
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.profileUpdated)));
    await Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final initial = _name.text.trim().isEmpty ? 'T' : _name.text.trim().characters.first.toUpperCase();

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(title: Text(l10n.profileEditTitle)),
      body: !_loaded
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [Skeleton(height: 96, radius: 28), SizedBox(height: 16), Skeleton(height: 220, radius: 28)],
              ),
            )
          : Form(
              key: _formKey,
              // Every field is built (not lazily), so validation checks all
              // of them, including ones scrolled off screen.
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: SamajhColors.forestGreen,
                        child: Text(
                          initial,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: SamajhSpace.lg),
                    _Section(
                      title: l10n.profileSectionAbout,
                      children: [
                        TextFormField(
                          key: const Key('profile_name_field'),
                          controller: _name,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(labelText: '${l10n.profileFullName} *'),
                          validator: (v) => (v ?? '').trim().isEmpty ? l10n.profileFullNameRequired : null,
                        ),
                        TextFormField(
                          controller: _callName,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: l10n.profileDisplayName,
                            hintText: l10n.profileDisplayNameHint,
                          ),
                        ),
                        _Label(l10n.profileRole),
                        _Choices(
                          value: _role,
                          options: {
                            'teacher': l10n.roleTeacher,
                            'head_teacher': l10n.roleHeadTeacher,
                            'para_teacher': l10n.roleParaTeacher,
                            'other': l10n.roleOther,
                          },
                          onChanged: (v) => setState(() => _role = v),
                        ),
                      ],
                    ),
                    _Section(
                      title: l10n.profileSectionSchool,
                      children: [
                        TextFormField(
                          controller: _school,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: l10n.profileSchoolName),
                        ),
                        TextFormField(
                          controller: _udise,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: l10n.profileUdise, counterText: ''),
                          validator: (v) {
                            final t = (v ?? '').trim();
                            return t.isEmpty || t.length == 11 ? null : l10n.profileUdiseError;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _block,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(labelText: l10n.profileBlock),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _district,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(labelText: l10n.profileDistrict),
                              ),
                            ),
                          ],
                        ),
                        _Label(l10n.profileState),
                        _Choices(
                          value: _state,
                          options: {
                            'rajasthan': l10n.stateRajasthan,
                            'uttar_pradesh': l10n.stateUttarPradesh,
                            'other': l10n.stateOther,
                          },
                          onChanged: (v) => setState(() => _state = v),
                        ),
                        TextFormField(
                          controller: _years,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: l10n.profileYears),
                          validator: (v) {
                            final t = (v ?? '').trim();
                            if (t.isEmpty) return null;
                            final n = int.tryParse(t);
                            return n != null && n <= 60 ? null : l10n.profileYearsError;
                          },
                        ),
                      ],
                    ),
                    _Section(
                      title: l10n.profileSectionContact,
                      children: [
                        TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(labelText: l10n.profilePhone, counterText: ''),
                          validator: (v) {
                            final t = (v ?? '').trim();
                            return t.isEmpty || RegExp(r'^[6-9]\d{9}$').hasMatch(t) ? null : l10n.profilePhoneError;
                          },
                        ),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(labelText: l10n.profileEmail),
                          validator: (v) {
                            final t = (v ?? '').trim();
                            return t.isEmpty || _emailPattern.hasMatch(t) ? null : l10n.profileEmailError;
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.lock_outline_rounded, size: 16, color: SamajhColors.textMuted),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.profileStaysOnPhone,
                            style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
          child: ElevatedButton(
            key: const Key('profile_save_button'),
            onPressed: _loaded && !_saving ? _save : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: SamajhColors.textNavy,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(56),
            ),
            child: Text(l10n.profileSaveButton),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SamajhSpace.lg),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(SamajhRadius.card + 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
          ),
          for (final child in children) ...[const SizedBox(height: 14), child],
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textMuted),
  );
}

/// Pill choices; tapping the chosen one again clears it.
class _Choices extends StatelessWidget {
  final String? value;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  const _Choices({required this.value, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final e in options.entries)
          ChoiceChip(
            label: Text(e.value),
            selected: value == e.key,
            onSelected: (on) => onChanged(on ? e.key : null),
            shape: const StadiumBorder(),
            showCheckmark: false,
            selectedColor: SamajhColors.textNavy,
            backgroundColor: SamajhColors.creamSoft,
            side: BorderSide.none,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: value == e.key ? Colors.white : SamajhColors.textNavy,
            ),
          ),
      ],
    );
  }
}
