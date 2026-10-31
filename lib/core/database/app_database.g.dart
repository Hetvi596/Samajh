// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeScopeMeta = const VerificationMeta(
    'activeScope',
  );
  @override
  late final GeneratedColumn<String> activeScope = GeneratedColumn<String>(
    'active_scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('demo'),
  );
  static const VerificationMeta _appLanguageMeta = const VerificationMeta(
    'appLanguage',
  );
  @override
  late final GeneratedColumn<String> appLanguage = GeneratedColumn<String>(
    'app_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi'),
  );
  static const VerificationMeta _readingLanguageMeta = const VerificationMeta(
    'readingLanguage',
  );
  @override
  late final GeneratedColumn<String> readingLanguage = GeneratedColumn<String>(
    'reading_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi'),
  );
  static const VerificationMeta _passcodeHashMeta = const VerificationMeta(
    'passcodeHash',
  );
  @override
  late final GeneratedColumn<String> passcodeHash = GeneratedColumn<String>(
    'passcode_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passcodeSaltMeta = const VerificationMeta(
    'passcodeSalt',
  );
  @override
  late final GeneratedColumn<String> passcodeSalt = GeneratedColumn<String>(
    'passcode_salt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failedPasscodeAttemptsMeta =
      const VerificationMeta('failedPasscodeAttempts');
  @override
  late final GeneratedColumn<int> failedPasscodeAttempts = GeneratedColumn<int>(
    'failed_passcode_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lockoutUntilMeta = const VerificationMeta(
    'lockoutUntil',
  );
  @override
  late final GeneratedColumn<DateTime> lockoutUntil = GeneratedColumn<DateTime>(
    'lockout_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _useFingerprintMeta = const VerificationMeta(
    'useFingerprint',
  );
  @override
  late final GeneratedColumn<bool> useFingerprint = GeneratedColumn<bool>(
    'use_fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_fingerprint" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _textSizeScaleMeta = const VerificationMeta(
    'textSizeScale',
  );
  @override
  late final GeneratedColumn<double> textSizeScale = GeneratedColumn<double>(
    'text_size_scale',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _suggestedChecksWindowDaysMeta =
      const VerificationMeta('suggestedChecksWindowDays');
  @override
  late final GeneratedColumn<int> suggestedChecksWindowDays =
      GeneratedColumn<int>(
        'suggested_checks_window_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(5),
      );
  static const VerificationMeta _recheckPeriodWeeksMeta =
      const VerificationMeta('recheckPeriodWeeks');
  @override
  late final GeneratedColumn<int> recheckPeriodWeeks = GeneratedColumn<int>(
    'recheck_period_weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _backupReminderPeriodDaysMeta =
      const VerificationMeta('backupReminderPeriodDays');
  @override
  late final GeneratedColumn<int> backupReminderPeriodDays =
      GeneratedColumn<int>(
        'backup_reminder_period_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(14),
      );
  static const VerificationMeta _lastBackupTimestampMeta =
      const VerificationMeta('lastBackupTimestamp');
  @override
  late final GeneratedColumn<DateTime> lastBackupTimestamp =
      GeneratedColumn<DateTime>(
        'last_backup_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _legalReviewerNameMeta = const VerificationMeta(
    'legalReviewerName',
  );
  @override
  late final GeneratedColumn<String> legalReviewerName =
      GeneratedColumn<String>(
        'legal_reviewer_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _legalReviewDateMeta = const VerificationMeta(
    'legalReviewDate',
  );
  @override
  late final GeneratedColumn<DateTime> legalReviewDate =
      GeneratedColumn<DateTime>(
        'legal_review_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _legalReviewCompletedMeta =
      const VerificationMeta('legalReviewCompleted');
  @override
  late final GeneratedColumn<bool> legalReviewCompleted = GeneratedColumn<bool>(
    'legal_review_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("legal_review_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activeClassIdMeta = const VerificationMeta(
    'activeClassId',
  );
  @override
  late final GeneratedColumn<String> activeClassId = GeneratedColumn<String>(
    'active_class_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceDataConsentGivenMeta =
      const VerificationMeta('deviceDataConsentGiven');
  @override
  late final GeneratedColumn<bool> deviceDataConsentGiven =
      GeneratedColumn<bool>(
        'device_data_consent_given',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("device_data_consent_given" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _deviceDataConsentDateMeta =
      const VerificationMeta('deviceDataConsentDate');
  @override
  late final GeneratedColumn<DateTime> deviceDataConsentDate =
      GeneratedColumn<DateTime>(
        'device_data_consent_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _audioRecordingConsentGivenMeta =
      const VerificationMeta('audioRecordingConsentGiven');
  @override
  late final GeneratedColumn<bool> audioRecordingConsentGiven =
      GeneratedColumn<bool>(
        'audio_recording_consent_given',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("audio_recording_consent_given" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _audioRecordingConsentDateMeta =
      const VerificationMeta('audioRecordingConsentDate');
  @override
  late final GeneratedColumn<DateTime> audioRecordingConsentDate =
      GeneratedColumn<DateTime>(
        'audio_recording_consent_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activeScope,
    appLanguage,
    readingLanguage,
    passcodeHash,
    passcodeSalt,
    failedPasscodeAttempts,
    lockoutUntil,
    useFingerprint,
    textSizeScale,
    suggestedChecksWindowDays,
    recheckPeriodWeeks,
    backupReminderPeriodDays,
    lastBackupTimestamp,
    legalReviewerName,
    legalReviewDate,
    legalReviewCompleted,
    activeClassId,
    deviceDataConsentGiven,
    deviceDataConsentDate,
    audioRecordingConsentGiven,
    audioRecordingConsentDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('active_scope')) {
      context.handle(
        _activeScopeMeta,
        activeScope.isAcceptableOrUnknown(
          data['active_scope']!,
          _activeScopeMeta,
        ),
      );
    }
    if (data.containsKey('app_language')) {
      context.handle(
        _appLanguageMeta,
        appLanguage.isAcceptableOrUnknown(
          data['app_language']!,
          _appLanguageMeta,
        ),
      );
    }
    if (data.containsKey('reading_language')) {
      context.handle(
        _readingLanguageMeta,
        readingLanguage.isAcceptableOrUnknown(
          data['reading_language']!,
          _readingLanguageMeta,
        ),
      );
    }
    if (data.containsKey('passcode_hash')) {
      context.handle(
        _passcodeHashMeta,
        passcodeHash.isAcceptableOrUnknown(
          data['passcode_hash']!,
          _passcodeHashMeta,
        ),
      );
    }
    if (data.containsKey('passcode_salt')) {
      context.handle(
        _passcodeSaltMeta,
        passcodeSalt.isAcceptableOrUnknown(
          data['passcode_salt']!,
          _passcodeSaltMeta,
        ),
      );
    }
    if (data.containsKey('failed_passcode_attempts')) {
      context.handle(
        _failedPasscodeAttemptsMeta,
        failedPasscodeAttempts.isAcceptableOrUnknown(
          data['failed_passcode_attempts']!,
          _failedPasscodeAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('lockout_until')) {
      context.handle(
        _lockoutUntilMeta,
        lockoutUntil.isAcceptableOrUnknown(
          data['lockout_until']!,
          _lockoutUntilMeta,
        ),
      );
    }
    if (data.containsKey('use_fingerprint')) {
      context.handle(
        _useFingerprintMeta,
        useFingerprint.isAcceptableOrUnknown(
          data['use_fingerprint']!,
          _useFingerprintMeta,
        ),
      );
    }
    if (data.containsKey('text_size_scale')) {
      context.handle(
        _textSizeScaleMeta,
        textSizeScale.isAcceptableOrUnknown(
          data['text_size_scale']!,
          _textSizeScaleMeta,
        ),
      );
    }
    if (data.containsKey('suggested_checks_window_days')) {
      context.handle(
        _suggestedChecksWindowDaysMeta,
        suggestedChecksWindowDays.isAcceptableOrUnknown(
          data['suggested_checks_window_days']!,
          _suggestedChecksWindowDaysMeta,
        ),
      );
    }
    if (data.containsKey('recheck_period_weeks')) {
      context.handle(
        _recheckPeriodWeeksMeta,
        recheckPeriodWeeks.isAcceptableOrUnknown(
          data['recheck_period_weeks']!,
          _recheckPeriodWeeksMeta,
        ),
      );
    }
    if (data.containsKey('backup_reminder_period_days')) {
      context.handle(
        _backupReminderPeriodDaysMeta,
        backupReminderPeriodDays.isAcceptableOrUnknown(
          data['backup_reminder_period_days']!,
          _backupReminderPeriodDaysMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_timestamp')) {
      context.handle(
        _lastBackupTimestampMeta,
        lastBackupTimestamp.isAcceptableOrUnknown(
          data['last_backup_timestamp']!,
          _lastBackupTimestampMeta,
        ),
      );
    }
    if (data.containsKey('legal_reviewer_name')) {
      context.handle(
        _legalReviewerNameMeta,
        legalReviewerName.isAcceptableOrUnknown(
          data['legal_reviewer_name']!,
          _legalReviewerNameMeta,
        ),
      );
    }
    if (data.containsKey('legal_review_date')) {
      context.handle(
        _legalReviewDateMeta,
        legalReviewDate.isAcceptableOrUnknown(
          data['legal_review_date']!,
          _legalReviewDateMeta,
        ),
      );
    }
    if (data.containsKey('legal_review_completed')) {
      context.handle(
        _legalReviewCompletedMeta,
        legalReviewCompleted.isAcceptableOrUnknown(
          data['legal_review_completed']!,
          _legalReviewCompletedMeta,
        ),
      );
    }
    if (data.containsKey('active_class_id')) {
      context.handle(
        _activeClassIdMeta,
        activeClassId.isAcceptableOrUnknown(
          data['active_class_id']!,
          _activeClassIdMeta,
        ),
      );
    }
    if (data.containsKey('device_data_consent_given')) {
      context.handle(
        _deviceDataConsentGivenMeta,
        deviceDataConsentGiven.isAcceptableOrUnknown(
          data['device_data_consent_given']!,
          _deviceDataConsentGivenMeta,
        ),
      );
    }
    if (data.containsKey('device_data_consent_date')) {
      context.handle(
        _deviceDataConsentDateMeta,
        deviceDataConsentDate.isAcceptableOrUnknown(
          data['device_data_consent_date']!,
          _deviceDataConsentDateMeta,
        ),
      );
    }
    if (data.containsKey('audio_recording_consent_given')) {
      context.handle(
        _audioRecordingConsentGivenMeta,
        audioRecordingConsentGiven.isAcceptableOrUnknown(
          data['audio_recording_consent_given']!,
          _audioRecordingConsentGivenMeta,
        ),
      );
    }
    if (data.containsKey('audio_recording_consent_date')) {
      context.handle(
        _audioRecordingConsentDateMeta,
        audioRecordingConsentDate.isAcceptableOrUnknown(
          data['audio_recording_consent_date']!,
          _audioRecordingConsentDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      activeScope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_scope'],
      )!,
      appLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_language'],
      )!,
      readingLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_language'],
      )!,
      passcodeHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passcode_hash'],
      ),
      passcodeSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passcode_salt'],
      ),
      failedPasscodeAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_passcode_attempts'],
      )!,
      lockoutUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}lockout_until'],
      ),
      useFingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_fingerprint'],
      )!,
      textSizeScale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}text_size_scale'],
      )!,
      suggestedChecksWindowDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}suggested_checks_window_days'],
      )!,
      recheckPeriodWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recheck_period_weeks'],
      )!,
      backupReminderPeriodDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}backup_reminder_period_days'],
      )!,
      lastBackupTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_timestamp'],
      ),
      legalReviewerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_reviewer_name'],
      ),
      legalReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}legal_review_date'],
      ),
      legalReviewCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}legal_review_completed'],
      )!,
      activeClassId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_class_id'],
      ),
      deviceDataConsentGiven: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}device_data_consent_given'],
      )!,
      deviceDataConsentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}device_data_consent_date'],
      ),
      audioRecordingConsentGiven: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}audio_recording_consent_given'],
      )!,
      audioRecordingConsentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}audio_recording_consent_date'],
      ),
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final String id;
  final String activeScope;
  final String appLanguage;
  final String readingLanguage;
  final String? passcodeHash;
  final String? passcodeSalt;
  final int failedPasscodeAttempts;
  final DateTime? lockoutUntil;
  final bool useFingerprint;
  final double textSizeScale;
  final int suggestedChecksWindowDays;
  final int recheckPeriodWeeks;
  final int backupReminderPeriodDays;
  final DateTime? lastBackupTimestamp;
  final String? legalReviewerName;
  final DateTime? legalReviewDate;
  final bool legalReviewCompleted;
  final String? activeClassId;
  final bool deviceDataConsentGiven;
  final DateTime? deviceDataConsentDate;
  final bool audioRecordingConsentGiven;
  final DateTime? audioRecordingConsentDate;
  const AppSettingsTableData({
    required this.id,
    required this.activeScope,
    required this.appLanguage,
    required this.readingLanguage,
    this.passcodeHash,
    this.passcodeSalt,
    required this.failedPasscodeAttempts,
    this.lockoutUntil,
    required this.useFingerprint,
    required this.textSizeScale,
    required this.suggestedChecksWindowDays,
    required this.recheckPeriodWeeks,
    required this.backupReminderPeriodDays,
    this.lastBackupTimestamp,
    this.legalReviewerName,
    this.legalReviewDate,
    required this.legalReviewCompleted,
    this.activeClassId,
    required this.deviceDataConsentGiven,
    this.deviceDataConsentDate,
    required this.audioRecordingConsentGiven,
    this.audioRecordingConsentDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['active_scope'] = Variable<String>(activeScope);
    map['app_language'] = Variable<String>(appLanguage);
    map['reading_language'] = Variable<String>(readingLanguage);
    if (!nullToAbsent || passcodeHash != null) {
      map['passcode_hash'] = Variable<String>(passcodeHash);
    }
    if (!nullToAbsent || passcodeSalt != null) {
      map['passcode_salt'] = Variable<String>(passcodeSalt);
    }
    map['failed_passcode_attempts'] = Variable<int>(failedPasscodeAttempts);
    if (!nullToAbsent || lockoutUntil != null) {
      map['lockout_until'] = Variable<DateTime>(lockoutUntil);
    }
    map['use_fingerprint'] = Variable<bool>(useFingerprint);
    map['text_size_scale'] = Variable<double>(textSizeScale);
    map['suggested_checks_window_days'] = Variable<int>(
      suggestedChecksWindowDays,
    );
    map['recheck_period_weeks'] = Variable<int>(recheckPeriodWeeks);
    map['backup_reminder_period_days'] = Variable<int>(
      backupReminderPeriodDays,
    );
    if (!nullToAbsent || lastBackupTimestamp != null) {
      map['last_backup_timestamp'] = Variable<DateTime>(lastBackupTimestamp);
    }
    if (!nullToAbsent || legalReviewerName != null) {
      map['legal_reviewer_name'] = Variable<String>(legalReviewerName);
    }
    if (!nullToAbsent || legalReviewDate != null) {
      map['legal_review_date'] = Variable<DateTime>(legalReviewDate);
    }
    map['legal_review_completed'] = Variable<bool>(legalReviewCompleted);
    if (!nullToAbsent || activeClassId != null) {
      map['active_class_id'] = Variable<String>(activeClassId);
    }
    map['device_data_consent_given'] = Variable<bool>(deviceDataConsentGiven);
    if (!nullToAbsent || deviceDataConsentDate != null) {
      map['device_data_consent_date'] = Variable<DateTime>(
        deviceDataConsentDate,
      );
    }
    map['audio_recording_consent_given'] = Variable<bool>(
      audioRecordingConsentGiven,
    );
    if (!nullToAbsent || audioRecordingConsentDate != null) {
      map['audio_recording_consent_date'] = Variable<DateTime>(
        audioRecordingConsentDate,
      );
    }
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      activeScope: Value(activeScope),
      appLanguage: Value(appLanguage),
      readingLanguage: Value(readingLanguage),
      passcodeHash: passcodeHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passcodeHash),
      passcodeSalt: passcodeSalt == null && nullToAbsent
          ? const Value.absent()
          : Value(passcodeSalt),
      failedPasscodeAttempts: Value(failedPasscodeAttempts),
      lockoutUntil: lockoutUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(lockoutUntil),
      useFingerprint: Value(useFingerprint),
      textSizeScale: Value(textSizeScale),
      suggestedChecksWindowDays: Value(suggestedChecksWindowDays),
      recheckPeriodWeeks: Value(recheckPeriodWeeks),
      backupReminderPeriodDays: Value(backupReminderPeriodDays),
      lastBackupTimestamp: lastBackupTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupTimestamp),
      legalReviewerName: legalReviewerName == null && nullToAbsent
          ? const Value.absent()
          : Value(legalReviewerName),
      legalReviewDate: legalReviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(legalReviewDate),
      legalReviewCompleted: Value(legalReviewCompleted),
      activeClassId: activeClassId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeClassId),
      deviceDataConsentGiven: Value(deviceDataConsentGiven),
      deviceDataConsentDate: deviceDataConsentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceDataConsentDate),
      audioRecordingConsentGiven: Value(audioRecordingConsentGiven),
      audioRecordingConsentDate:
          audioRecordingConsentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(audioRecordingConsentDate),
    );
  }

  factory AppSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      id: serializer.fromJson<String>(json['id']),
      activeScope: serializer.fromJson<String>(json['activeScope']),
      appLanguage: serializer.fromJson<String>(json['appLanguage']),
      readingLanguage: serializer.fromJson<String>(json['readingLanguage']),
      passcodeHash: serializer.fromJson<String?>(json['passcodeHash']),
      passcodeSalt: serializer.fromJson<String?>(json['passcodeSalt']),
      failedPasscodeAttempts: serializer.fromJson<int>(
        json['failedPasscodeAttempts'],
      ),
      lockoutUntil: serializer.fromJson<DateTime?>(json['lockoutUntil']),
      useFingerprint: serializer.fromJson<bool>(json['useFingerprint']),
      textSizeScale: serializer.fromJson<double>(json['textSizeScale']),
      suggestedChecksWindowDays: serializer.fromJson<int>(
        json['suggestedChecksWindowDays'],
      ),
      recheckPeriodWeeks: serializer.fromJson<int>(json['recheckPeriodWeeks']),
      backupReminderPeriodDays: serializer.fromJson<int>(
        json['backupReminderPeriodDays'],
      ),
      lastBackupTimestamp: serializer.fromJson<DateTime?>(
        json['lastBackupTimestamp'],
      ),
      legalReviewerName: serializer.fromJson<String?>(
        json['legalReviewerName'],
      ),
      legalReviewDate: serializer.fromJson<DateTime?>(json['legalReviewDate']),
      legalReviewCompleted: serializer.fromJson<bool>(
        json['legalReviewCompleted'],
      ),
      activeClassId: serializer.fromJson<String?>(json['activeClassId']),
      deviceDataConsentGiven: serializer.fromJson<bool>(
        json['deviceDataConsentGiven'],
      ),
      deviceDataConsentDate: serializer.fromJson<DateTime?>(
        json['deviceDataConsentDate'],
      ),
      audioRecordingConsentGiven: serializer.fromJson<bool>(
        json['audioRecordingConsentGiven'],
      ),
      audioRecordingConsentDate: serializer.fromJson<DateTime?>(
        json['audioRecordingConsentDate'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'activeScope': serializer.toJson<String>(activeScope),
      'appLanguage': serializer.toJson<String>(appLanguage),
      'readingLanguage': serializer.toJson<String>(readingLanguage),
      'passcodeHash': serializer.toJson<String?>(passcodeHash),
      'passcodeSalt': serializer.toJson<String?>(passcodeSalt),
      'failedPasscodeAttempts': serializer.toJson<int>(failedPasscodeAttempts),
      'lockoutUntil': serializer.toJson<DateTime?>(lockoutUntil),
      'useFingerprint': serializer.toJson<bool>(useFingerprint),
      'textSizeScale': serializer.toJson<double>(textSizeScale),
      'suggestedChecksWindowDays': serializer.toJson<int>(
        suggestedChecksWindowDays,
      ),
      'recheckPeriodWeeks': serializer.toJson<int>(recheckPeriodWeeks),
      'backupReminderPeriodDays': serializer.toJson<int>(
        backupReminderPeriodDays,
      ),
      'lastBackupTimestamp': serializer.toJson<DateTime?>(lastBackupTimestamp),
      'legalReviewerName': serializer.toJson<String?>(legalReviewerName),
      'legalReviewDate': serializer.toJson<DateTime?>(legalReviewDate),
      'legalReviewCompleted': serializer.toJson<bool>(legalReviewCompleted),
      'activeClassId': serializer.toJson<String?>(activeClassId),
      'deviceDataConsentGiven': serializer.toJson<bool>(deviceDataConsentGiven),
      'deviceDataConsentDate': serializer.toJson<DateTime?>(
        deviceDataConsentDate,
      ),
      'audioRecordingConsentGiven': serializer.toJson<bool>(
        audioRecordingConsentGiven,
      ),
      'audioRecordingConsentDate': serializer.toJson<DateTime?>(
        audioRecordingConsentDate,
      ),
    };
  }

  AppSettingsTableData copyWith({
    String? id,
    String? activeScope,
    String? appLanguage,
    String? readingLanguage,
    Value<String?> passcodeHash = const Value.absent(),
    Value<String?> passcodeSalt = const Value.absent(),
    int? failedPasscodeAttempts,
    Value<DateTime?> lockoutUntil = const Value.absent(),
    bool? useFingerprint,
    double? textSizeScale,
    int? suggestedChecksWindowDays,
    int? recheckPeriodWeeks,
    int? backupReminderPeriodDays,
    Value<DateTime?> lastBackupTimestamp = const Value.absent(),
    Value<String?> legalReviewerName = const Value.absent(),
    Value<DateTime?> legalReviewDate = const Value.absent(),
    bool? legalReviewCompleted,
    Value<String?> activeClassId = const Value.absent(),
    bool? deviceDataConsentGiven,
    Value<DateTime?> deviceDataConsentDate = const Value.absent(),
    bool? audioRecordingConsentGiven,
    Value<DateTime?> audioRecordingConsentDate = const Value.absent(),
  }) => AppSettingsTableData(
    id: id ?? this.id,
    activeScope: activeScope ?? this.activeScope,
    appLanguage: appLanguage ?? this.appLanguage,
    readingLanguage: readingLanguage ?? this.readingLanguage,
    passcodeHash: passcodeHash.present ? passcodeHash.value : this.passcodeHash,
    passcodeSalt: passcodeSalt.present ? passcodeSalt.value : this.passcodeSalt,
    failedPasscodeAttempts:
        failedPasscodeAttempts ?? this.failedPasscodeAttempts,
    lockoutUntil: lockoutUntil.present ? lockoutUntil.value : this.lockoutUntil,
    useFingerprint: useFingerprint ?? this.useFingerprint,
    textSizeScale: textSizeScale ?? this.textSizeScale,
    suggestedChecksWindowDays:
        suggestedChecksWindowDays ?? this.suggestedChecksWindowDays,
    recheckPeriodWeeks: recheckPeriodWeeks ?? this.recheckPeriodWeeks,
    backupReminderPeriodDays:
        backupReminderPeriodDays ?? this.backupReminderPeriodDays,
    lastBackupTimestamp: lastBackupTimestamp.present
        ? lastBackupTimestamp.value
        : this.lastBackupTimestamp,
    legalReviewerName: legalReviewerName.present
        ? legalReviewerName.value
        : this.legalReviewerName,
    legalReviewDate: legalReviewDate.present
        ? legalReviewDate.value
        : this.legalReviewDate,
    legalReviewCompleted: legalReviewCompleted ?? this.legalReviewCompleted,
    activeClassId: activeClassId.present
        ? activeClassId.value
        : this.activeClassId,
    deviceDataConsentGiven:
        deviceDataConsentGiven ?? this.deviceDataConsentGiven,
    deviceDataConsentDate: deviceDataConsentDate.present
        ? deviceDataConsentDate.value
        : this.deviceDataConsentDate,
    audioRecordingConsentGiven:
        audioRecordingConsentGiven ?? this.audioRecordingConsentGiven,
    audioRecordingConsentDate: audioRecordingConsentDate.present
        ? audioRecordingConsentDate.value
        : this.audioRecordingConsentDate,
  );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      activeScope: data.activeScope.present
          ? data.activeScope.value
          : this.activeScope,
      appLanguage: data.appLanguage.present
          ? data.appLanguage.value
          : this.appLanguage,
      readingLanguage: data.readingLanguage.present
          ? data.readingLanguage.value
          : this.readingLanguage,
      passcodeHash: data.passcodeHash.present
          ? data.passcodeHash.value
          : this.passcodeHash,
      passcodeSalt: data.passcodeSalt.present
          ? data.passcodeSalt.value
          : this.passcodeSalt,
      failedPasscodeAttempts: data.failedPasscodeAttempts.present
          ? data.failedPasscodeAttempts.value
          : this.failedPasscodeAttempts,
      lockoutUntil: data.lockoutUntil.present
          ? data.lockoutUntil.value
          : this.lockoutUntil,
      useFingerprint: data.useFingerprint.present
          ? data.useFingerprint.value
          : this.useFingerprint,
      textSizeScale: data.textSizeScale.present
          ? data.textSizeScale.value
          : this.textSizeScale,
      suggestedChecksWindowDays: data.suggestedChecksWindowDays.present
          ? data.suggestedChecksWindowDays.value
          : this.suggestedChecksWindowDays,
      recheckPeriodWeeks: data.recheckPeriodWeeks.present
          ? data.recheckPeriodWeeks.value
          : this.recheckPeriodWeeks,
      backupReminderPeriodDays: data.backupReminderPeriodDays.present
          ? data.backupReminderPeriodDays.value
          : this.backupReminderPeriodDays,
      lastBackupTimestamp: data.lastBackupTimestamp.present
          ? data.lastBackupTimestamp.value
          : this.lastBackupTimestamp,
      legalReviewerName: data.legalReviewerName.present
          ? data.legalReviewerName.value
          : this.legalReviewerName,
      legalReviewDate: data.legalReviewDate.present
          ? data.legalReviewDate.value
          : this.legalReviewDate,
      legalReviewCompleted: data.legalReviewCompleted.present
          ? data.legalReviewCompleted.value
          : this.legalReviewCompleted,
      activeClassId: data.activeClassId.present
          ? data.activeClassId.value
          : this.activeClassId,
      deviceDataConsentGiven: data.deviceDataConsentGiven.present
          ? data.deviceDataConsentGiven.value
          : this.deviceDataConsentGiven,
      deviceDataConsentDate: data.deviceDataConsentDate.present
          ? data.deviceDataConsentDate.value
          : this.deviceDataConsentDate,
      audioRecordingConsentGiven: data.audioRecordingConsentGiven.present
          ? data.audioRecordingConsentGiven.value
          : this.audioRecordingConsentGiven,
      audioRecordingConsentDate: data.audioRecordingConsentDate.present
          ? data.audioRecordingConsentDate.value
          : this.audioRecordingConsentDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('id: $id, ')
          ..write('activeScope: $activeScope, ')
          ..write('appLanguage: $appLanguage, ')
          ..write('readingLanguage: $readingLanguage, ')
          ..write('passcodeHash: $passcodeHash, ')
          ..write('passcodeSalt: $passcodeSalt, ')
          ..write('failedPasscodeAttempts: $failedPasscodeAttempts, ')
          ..write('lockoutUntil: $lockoutUntil, ')
          ..write('useFingerprint: $useFingerprint, ')
          ..write('textSizeScale: $textSizeScale, ')
          ..write('suggestedChecksWindowDays: $suggestedChecksWindowDays, ')
          ..write('recheckPeriodWeeks: $recheckPeriodWeeks, ')
          ..write('backupReminderPeriodDays: $backupReminderPeriodDays, ')
          ..write('lastBackupTimestamp: $lastBackupTimestamp, ')
          ..write('legalReviewerName: $legalReviewerName, ')
          ..write('legalReviewDate: $legalReviewDate, ')
          ..write('legalReviewCompleted: $legalReviewCompleted, ')
          ..write('activeClassId: $activeClassId, ')
          ..write('deviceDataConsentGiven: $deviceDataConsentGiven, ')
          ..write('deviceDataConsentDate: $deviceDataConsentDate, ')
          ..write('audioRecordingConsentGiven: $audioRecordingConsentGiven, ')
          ..write('audioRecordingConsentDate: $audioRecordingConsentDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    activeScope,
    appLanguage,
    readingLanguage,
    passcodeHash,
    passcodeSalt,
    failedPasscodeAttempts,
    lockoutUntil,
    useFingerprint,
    textSizeScale,
    suggestedChecksWindowDays,
    recheckPeriodWeeks,
    backupReminderPeriodDays,
    lastBackupTimestamp,
    legalReviewerName,
    legalReviewDate,
    legalReviewCompleted,
    activeClassId,
    deviceDataConsentGiven,
    deviceDataConsentDate,
    audioRecordingConsentGiven,
    audioRecordingConsentDate,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.id == this.id &&
          other.activeScope == this.activeScope &&
          other.appLanguage == this.appLanguage &&
          other.readingLanguage == this.readingLanguage &&
          other.passcodeHash == this.passcodeHash &&
          other.passcodeSalt == this.passcodeSalt &&
          other.failedPasscodeAttempts == this.failedPasscodeAttempts &&
          other.lockoutUntil == this.lockoutUntil &&
          other.useFingerprint == this.useFingerprint &&
          other.textSizeScale == this.textSizeScale &&
          other.suggestedChecksWindowDays == this.suggestedChecksWindowDays &&
          other.recheckPeriodWeeks == this.recheckPeriodWeeks &&
          other.backupReminderPeriodDays == this.backupReminderPeriodDays &&
          other.lastBackupTimestamp == this.lastBackupTimestamp &&
          other.legalReviewerName == this.legalReviewerName &&
          other.legalReviewDate == this.legalReviewDate &&
          other.legalReviewCompleted == this.legalReviewCompleted &&
          other.activeClassId == this.activeClassId &&
          other.deviceDataConsentGiven == this.deviceDataConsentGiven &&
          other.deviceDataConsentDate == this.deviceDataConsentDate &&
          other.audioRecordingConsentGiven == this.audioRecordingConsentGiven &&
          other.audioRecordingConsentDate == this.audioRecordingConsentDate);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<String> id;
  final Value<String> activeScope;
  final Value<String> appLanguage;
  final Value<String> readingLanguage;
  final Value<String?> passcodeHash;
  final Value<String?> passcodeSalt;
  final Value<int> failedPasscodeAttempts;
  final Value<DateTime?> lockoutUntil;
  final Value<bool> useFingerprint;
  final Value<double> textSizeScale;
  final Value<int> suggestedChecksWindowDays;
  final Value<int> recheckPeriodWeeks;
  final Value<int> backupReminderPeriodDays;
  final Value<DateTime?> lastBackupTimestamp;
  final Value<String?> legalReviewerName;
  final Value<DateTime?> legalReviewDate;
  final Value<bool> legalReviewCompleted;
  final Value<String?> activeClassId;
  final Value<bool> deviceDataConsentGiven;
  final Value<DateTime?> deviceDataConsentDate;
  final Value<bool> audioRecordingConsentGiven;
  final Value<DateTime?> audioRecordingConsentDate;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.activeScope = const Value.absent(),
    this.appLanguage = const Value.absent(),
    this.readingLanguage = const Value.absent(),
    this.passcodeHash = const Value.absent(),
    this.passcodeSalt = const Value.absent(),
    this.failedPasscodeAttempts = const Value.absent(),
    this.lockoutUntil = const Value.absent(),
    this.useFingerprint = const Value.absent(),
    this.textSizeScale = const Value.absent(),
    this.suggestedChecksWindowDays = const Value.absent(),
    this.recheckPeriodWeeks = const Value.absent(),
    this.backupReminderPeriodDays = const Value.absent(),
    this.lastBackupTimestamp = const Value.absent(),
    this.legalReviewerName = const Value.absent(),
    this.legalReviewDate = const Value.absent(),
    this.legalReviewCompleted = const Value.absent(),
    this.activeClassId = const Value.absent(),
    this.deviceDataConsentGiven = const Value.absent(),
    this.deviceDataConsentDate = const Value.absent(),
    this.audioRecordingConsentGiven = const Value.absent(),
    this.audioRecordingConsentDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String id,
    this.activeScope = const Value.absent(),
    this.appLanguage = const Value.absent(),
    this.readingLanguage = const Value.absent(),
    this.passcodeHash = const Value.absent(),
    this.passcodeSalt = const Value.absent(),
    this.failedPasscodeAttempts = const Value.absent(),
    this.lockoutUntil = const Value.absent(),
    this.useFingerprint = const Value.absent(),
    this.textSizeScale = const Value.absent(),
    this.suggestedChecksWindowDays = const Value.absent(),
    this.recheckPeriodWeeks = const Value.absent(),
    this.backupReminderPeriodDays = const Value.absent(),
    this.lastBackupTimestamp = const Value.absent(),
    this.legalReviewerName = const Value.absent(),
    this.legalReviewDate = const Value.absent(),
    this.legalReviewCompleted = const Value.absent(),
    this.activeClassId = const Value.absent(),
    this.deviceDataConsentGiven = const Value.absent(),
    this.deviceDataConsentDate = const Value.absent(),
    this.audioRecordingConsentGiven = const Value.absent(),
    this.audioRecordingConsentDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AppSettingsTableData> custom({
    Expression<String>? id,
    Expression<String>? activeScope,
    Expression<String>? appLanguage,
    Expression<String>? readingLanguage,
    Expression<String>? passcodeHash,
    Expression<String>? passcodeSalt,
    Expression<int>? failedPasscodeAttempts,
    Expression<DateTime>? lockoutUntil,
    Expression<bool>? useFingerprint,
    Expression<double>? textSizeScale,
    Expression<int>? suggestedChecksWindowDays,
    Expression<int>? recheckPeriodWeeks,
    Expression<int>? backupReminderPeriodDays,
    Expression<DateTime>? lastBackupTimestamp,
    Expression<String>? legalReviewerName,
    Expression<DateTime>? legalReviewDate,
    Expression<bool>? legalReviewCompleted,
    Expression<String>? activeClassId,
    Expression<bool>? deviceDataConsentGiven,
    Expression<DateTime>? deviceDataConsentDate,
    Expression<bool>? audioRecordingConsentGiven,
    Expression<DateTime>? audioRecordingConsentDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activeScope != null) 'active_scope': activeScope,
      if (appLanguage != null) 'app_language': appLanguage,
      if (readingLanguage != null) 'reading_language': readingLanguage,
      if (passcodeHash != null) 'passcode_hash': passcodeHash,
      if (passcodeSalt != null) 'passcode_salt': passcodeSalt,
      if (failedPasscodeAttempts != null)
        'failed_passcode_attempts': failedPasscodeAttempts,
      if (lockoutUntil != null) 'lockout_until': lockoutUntil,
      if (useFingerprint != null) 'use_fingerprint': useFingerprint,
      if (textSizeScale != null) 'text_size_scale': textSizeScale,
      if (suggestedChecksWindowDays != null)
        'suggested_checks_window_days': suggestedChecksWindowDays,
      if (recheckPeriodWeeks != null)
        'recheck_period_weeks': recheckPeriodWeeks,
      if (backupReminderPeriodDays != null)
        'backup_reminder_period_days': backupReminderPeriodDays,
      if (lastBackupTimestamp != null)
        'last_backup_timestamp': lastBackupTimestamp,
      if (legalReviewerName != null) 'legal_reviewer_name': legalReviewerName,
      if (legalReviewDate != null) 'legal_review_date': legalReviewDate,
      if (legalReviewCompleted != null)
        'legal_review_completed': legalReviewCompleted,
      if (activeClassId != null) 'active_class_id': activeClassId,
      if (deviceDataConsentGiven != null)
        'device_data_consent_given': deviceDataConsentGiven,
      if (deviceDataConsentDate != null)
        'device_data_consent_date': deviceDataConsentDate,
      if (audioRecordingConsentGiven != null)
        'audio_recording_consent_given': audioRecordingConsentGiven,
      if (audioRecordingConsentDate != null)
        'audio_recording_consent_date': audioRecordingConsentDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? activeScope,
    Value<String>? appLanguage,
    Value<String>? readingLanguage,
    Value<String?>? passcodeHash,
    Value<String?>? passcodeSalt,
    Value<int>? failedPasscodeAttempts,
    Value<DateTime?>? lockoutUntil,
    Value<bool>? useFingerprint,
    Value<double>? textSizeScale,
    Value<int>? suggestedChecksWindowDays,
    Value<int>? recheckPeriodWeeks,
    Value<int>? backupReminderPeriodDays,
    Value<DateTime?>? lastBackupTimestamp,
    Value<String?>? legalReviewerName,
    Value<DateTime?>? legalReviewDate,
    Value<bool>? legalReviewCompleted,
    Value<String?>? activeClassId,
    Value<bool>? deviceDataConsentGiven,
    Value<DateTime?>? deviceDataConsentDate,
    Value<bool>? audioRecordingConsentGiven,
    Value<DateTime?>? audioRecordingConsentDate,
    Value<int>? rowid,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      activeScope: activeScope ?? this.activeScope,
      appLanguage: appLanguage ?? this.appLanguage,
      readingLanguage: readingLanguage ?? this.readingLanguage,
      passcodeHash: passcodeHash ?? this.passcodeHash,
      passcodeSalt: passcodeSalt ?? this.passcodeSalt,
      failedPasscodeAttempts:
          failedPasscodeAttempts ?? this.failedPasscodeAttempts,
      lockoutUntil: lockoutUntil ?? this.lockoutUntil,
      useFingerprint: useFingerprint ?? this.useFingerprint,
      textSizeScale: textSizeScale ?? this.textSizeScale,
      suggestedChecksWindowDays:
          suggestedChecksWindowDays ?? this.suggestedChecksWindowDays,
      recheckPeriodWeeks: recheckPeriodWeeks ?? this.recheckPeriodWeeks,
      backupReminderPeriodDays:
          backupReminderPeriodDays ?? this.backupReminderPeriodDays,
      lastBackupTimestamp: lastBackupTimestamp ?? this.lastBackupTimestamp,
      legalReviewerName: legalReviewerName ?? this.legalReviewerName,
      legalReviewDate: legalReviewDate ?? this.legalReviewDate,
      legalReviewCompleted: legalReviewCompleted ?? this.legalReviewCompleted,
      activeClassId: activeClassId ?? this.activeClassId,
      deviceDataConsentGiven:
          deviceDataConsentGiven ?? this.deviceDataConsentGiven,
      deviceDataConsentDate:
          deviceDataConsentDate ?? this.deviceDataConsentDate,
      audioRecordingConsentGiven:
          audioRecordingConsentGiven ?? this.audioRecordingConsentGiven,
      audioRecordingConsentDate:
          audioRecordingConsentDate ?? this.audioRecordingConsentDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (activeScope.present) {
      map['active_scope'] = Variable<String>(activeScope.value);
    }
    if (appLanguage.present) {
      map['app_language'] = Variable<String>(appLanguage.value);
    }
    if (readingLanguage.present) {
      map['reading_language'] = Variable<String>(readingLanguage.value);
    }
    if (passcodeHash.present) {
      map['passcode_hash'] = Variable<String>(passcodeHash.value);
    }
    if (passcodeSalt.present) {
      map['passcode_salt'] = Variable<String>(passcodeSalt.value);
    }
    if (failedPasscodeAttempts.present) {
      map['failed_passcode_attempts'] = Variable<int>(
        failedPasscodeAttempts.value,
      );
    }
    if (lockoutUntil.present) {
      map['lockout_until'] = Variable<DateTime>(lockoutUntil.value);
    }
    if (useFingerprint.present) {
      map['use_fingerprint'] = Variable<bool>(useFingerprint.value);
    }
    if (textSizeScale.present) {
      map['text_size_scale'] = Variable<double>(textSizeScale.value);
    }
    if (suggestedChecksWindowDays.present) {
      map['suggested_checks_window_days'] = Variable<int>(
        suggestedChecksWindowDays.value,
      );
    }
    if (recheckPeriodWeeks.present) {
      map['recheck_period_weeks'] = Variable<int>(recheckPeriodWeeks.value);
    }
    if (backupReminderPeriodDays.present) {
      map['backup_reminder_period_days'] = Variable<int>(
        backupReminderPeriodDays.value,
      );
    }
    if (lastBackupTimestamp.present) {
      map['last_backup_timestamp'] = Variable<DateTime>(
        lastBackupTimestamp.value,
      );
    }
    if (legalReviewerName.present) {
      map['legal_reviewer_name'] = Variable<String>(legalReviewerName.value);
    }
    if (legalReviewDate.present) {
      map['legal_review_date'] = Variable<DateTime>(legalReviewDate.value);
    }
    if (legalReviewCompleted.present) {
      map['legal_review_completed'] = Variable<bool>(
        legalReviewCompleted.value,
      );
    }
    if (activeClassId.present) {
      map['active_class_id'] = Variable<String>(activeClassId.value);
    }
    if (deviceDataConsentGiven.present) {
      map['device_data_consent_given'] = Variable<bool>(
        deviceDataConsentGiven.value,
      );
    }
    if (deviceDataConsentDate.present) {
      map['device_data_consent_date'] = Variable<DateTime>(
        deviceDataConsentDate.value,
      );
    }
    if (audioRecordingConsentGiven.present) {
      map['audio_recording_consent_given'] = Variable<bool>(
        audioRecordingConsentGiven.value,
      );
    }
    if (audioRecordingConsentDate.present) {
      map['audio_recording_consent_date'] = Variable<DateTime>(
        audioRecordingConsentDate.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('activeScope: $activeScope, ')
          ..write('appLanguage: $appLanguage, ')
          ..write('readingLanguage: $readingLanguage, ')
          ..write('passcodeHash: $passcodeHash, ')
          ..write('passcodeSalt: $passcodeSalt, ')
          ..write('failedPasscodeAttempts: $failedPasscodeAttempts, ')
          ..write('lockoutUntil: $lockoutUntil, ')
          ..write('useFingerprint: $useFingerprint, ')
          ..write('textSizeScale: $textSizeScale, ')
          ..write('suggestedChecksWindowDays: $suggestedChecksWindowDays, ')
          ..write('recheckPeriodWeeks: $recheckPeriodWeeks, ')
          ..write('backupReminderPeriodDays: $backupReminderPeriodDays, ')
          ..write('lastBackupTimestamp: $lastBackupTimestamp, ')
          ..write('legalReviewerName: $legalReviewerName, ')
          ..write('legalReviewDate: $legalReviewDate, ')
          ..write('legalReviewCompleted: $legalReviewCompleted, ')
          ..write('activeClassId: $activeClassId, ')
          ..write('deviceDataConsentGiven: $deviceDataConsentGiven, ')
          ..write('deviceDataConsentDate: $deviceDataConsentDate, ')
          ..write('audioRecordingConsentGiven: $audioRecordingConsentGiven, ')
          ..write('audioRecordingConsentDate: $audioRecordingConsentDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassesTableTable extends ClassesTable
    with TableInfo<$ClassesTableTable, ClassesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _curriculumMeta = const VerificationMeta(
    'curriculum',
  );
  @override
  late final GeneratedColumn<String> curriculum = GeneratedColumn<String>(
    'curriculum',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkLanguageMeta = const VerificationMeta(
    'checkLanguage',
  );
  @override
  late final GeneratedColumn<String> checkLanguage = GeneratedColumn<String>(
    'check_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumOfInstructionMeta =
      const VerificationMeta('mediumOfInstruction');
  @override
  late final GeneratedColumn<String> mediumOfInstruction =
      GeneratedColumn<String>(
        'medium_of_instruction',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _textbookIdMeta = const VerificationMeta(
    'textbookId',
  );
  @override
  late final GeneratedColumn<String> textbookId = GeneratedColumn<String>(
    'textbook_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentChapterMeta = const VerificationMeta(
    'currentChapter',
  );
  @override
  late final GeneratedColumn<String> currentChapter = GeneratedColumn<String>(
    'current_chapter',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeDialectMeta = const VerificationMeta(
    'homeDialect',
  );
  @override
  late final GeneratedColumn<String> homeDialect = GeneratedColumn<String>(
    'home_dialect',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scope,
    name,
    grade,
    section,
    curriculum,
    checkLanguage,
    mediumOfInstruction,
    textbookId,
    currentChapter,
    homeDialect,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('curriculum')) {
      context.handle(
        _curriculumMeta,
        curriculum.isAcceptableOrUnknown(data['curriculum']!, _curriculumMeta),
      );
    } else if (isInserting) {
      context.missing(_curriculumMeta);
    }
    if (data.containsKey('check_language')) {
      context.handle(
        _checkLanguageMeta,
        checkLanguage.isAcceptableOrUnknown(
          data['check_language']!,
          _checkLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checkLanguageMeta);
    }
    if (data.containsKey('medium_of_instruction')) {
      context.handle(
        _mediumOfInstructionMeta,
        mediumOfInstruction.isAcceptableOrUnknown(
          data['medium_of_instruction']!,
          _mediumOfInstructionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediumOfInstructionMeta);
    }
    if (data.containsKey('textbook_id')) {
      context.handle(
        _textbookIdMeta,
        textbookId.isAcceptableOrUnknown(data['textbook_id']!, _textbookIdMeta),
      );
    }
    if (data.containsKey('current_chapter')) {
      context.handle(
        _currentChapterMeta,
        currentChapter.isAcceptableOrUnknown(
          data['current_chapter']!,
          _currentChapterMeta,
        ),
      );
    }
    if (data.containsKey('home_dialect')) {
      context.handle(
        _homeDialectMeta,
        homeDialect.isAcceptableOrUnknown(
          data['home_dialect']!,
          _homeDialectMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClassesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grade'],
      )!,
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      )!,
      curriculum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}curriculum'],
      )!,
      checkLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_language'],
      )!,
      mediumOfInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medium_of_instruction'],
      )!,
      textbookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}textbook_id'],
      ),
      currentChapter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_chapter'],
      ),
      homeDialect: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_dialect'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClassesTableTable createAlias(String alias) {
    return $ClassesTableTable(attachedDatabase, alias);
  }
}

class ClassesTableData extends DataClass
    implements Insertable<ClassesTableData> {
  final String id;
  final String scope;
  final String name;
  final int grade;
  final String section;
  final String curriculum;
  final String checkLanguage;
  final String mediumOfInstruction;
  final String? textbookId;
  final String? currentChapter;
  final String? homeDialect;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ClassesTableData({
    required this.id,
    required this.scope,
    required this.name,
    required this.grade,
    required this.section,
    required this.curriculum,
    required this.checkLanguage,
    required this.mediumOfInstruction,
    this.textbookId,
    this.currentChapter,
    this.homeDialect,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scope'] = Variable<String>(scope);
    map['name'] = Variable<String>(name);
    map['grade'] = Variable<int>(grade);
    map['section'] = Variable<String>(section);
    map['curriculum'] = Variable<String>(curriculum);
    map['check_language'] = Variable<String>(checkLanguage);
    map['medium_of_instruction'] = Variable<String>(mediumOfInstruction);
    if (!nullToAbsent || textbookId != null) {
      map['textbook_id'] = Variable<String>(textbookId);
    }
    if (!nullToAbsent || currentChapter != null) {
      map['current_chapter'] = Variable<String>(currentChapter);
    }
    if (!nullToAbsent || homeDialect != null) {
      map['home_dialect'] = Variable<String>(homeDialect);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClassesTableCompanion toCompanion(bool nullToAbsent) {
    return ClassesTableCompanion(
      id: Value(id),
      scope: Value(scope),
      name: Value(name),
      grade: Value(grade),
      section: Value(section),
      curriculum: Value(curriculum),
      checkLanguage: Value(checkLanguage),
      mediumOfInstruction: Value(mediumOfInstruction),
      textbookId: textbookId == null && nullToAbsent
          ? const Value.absent()
          : Value(textbookId),
      currentChapter: currentChapter == null && nullToAbsent
          ? const Value.absent()
          : Value(currentChapter),
      homeDialect: homeDialect == null && nullToAbsent
          ? const Value.absent()
          : Value(homeDialect),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ClassesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassesTableData(
      id: serializer.fromJson<String>(json['id']),
      scope: serializer.fromJson<String>(json['scope']),
      name: serializer.fromJson<String>(json['name']),
      grade: serializer.fromJson<int>(json['grade']),
      section: serializer.fromJson<String>(json['section']),
      curriculum: serializer.fromJson<String>(json['curriculum']),
      checkLanguage: serializer.fromJson<String>(json['checkLanguage']),
      mediumOfInstruction: serializer.fromJson<String>(
        json['mediumOfInstruction'],
      ),
      textbookId: serializer.fromJson<String?>(json['textbookId']),
      currentChapter: serializer.fromJson<String?>(json['currentChapter']),
      homeDialect: serializer.fromJson<String?>(json['homeDialect']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scope': serializer.toJson<String>(scope),
      'name': serializer.toJson<String>(name),
      'grade': serializer.toJson<int>(grade),
      'section': serializer.toJson<String>(section),
      'curriculum': serializer.toJson<String>(curriculum),
      'checkLanguage': serializer.toJson<String>(checkLanguage),
      'mediumOfInstruction': serializer.toJson<String>(mediumOfInstruction),
      'textbookId': serializer.toJson<String?>(textbookId),
      'currentChapter': serializer.toJson<String?>(currentChapter),
      'homeDialect': serializer.toJson<String?>(homeDialect),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ClassesTableData copyWith({
    String? id,
    String? scope,
    String? name,
    int? grade,
    String? section,
    String? curriculum,
    String? checkLanguage,
    String? mediumOfInstruction,
    Value<String?> textbookId = const Value.absent(),
    Value<String?> currentChapter = const Value.absent(),
    Value<String?> homeDialect = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ClassesTableData(
    id: id ?? this.id,
    scope: scope ?? this.scope,
    name: name ?? this.name,
    grade: grade ?? this.grade,
    section: section ?? this.section,
    curriculum: curriculum ?? this.curriculum,
    checkLanguage: checkLanguage ?? this.checkLanguage,
    mediumOfInstruction: mediumOfInstruction ?? this.mediumOfInstruction,
    textbookId: textbookId.present ? textbookId.value : this.textbookId,
    currentChapter: currentChapter.present
        ? currentChapter.value
        : this.currentChapter,
    homeDialect: homeDialect.present ? homeDialect.value : this.homeDialect,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ClassesTableData copyWithCompanion(ClassesTableCompanion data) {
    return ClassesTableData(
      id: data.id.present ? data.id.value : this.id,
      scope: data.scope.present ? data.scope.value : this.scope,
      name: data.name.present ? data.name.value : this.name,
      grade: data.grade.present ? data.grade.value : this.grade,
      section: data.section.present ? data.section.value : this.section,
      curriculum: data.curriculum.present
          ? data.curriculum.value
          : this.curriculum,
      checkLanguage: data.checkLanguage.present
          ? data.checkLanguage.value
          : this.checkLanguage,
      mediumOfInstruction: data.mediumOfInstruction.present
          ? data.mediumOfInstruction.value
          : this.mediumOfInstruction,
      textbookId: data.textbookId.present
          ? data.textbookId.value
          : this.textbookId,
      currentChapter: data.currentChapter.present
          ? data.currentChapter.value
          : this.currentChapter,
      homeDialect: data.homeDialect.present
          ? data.homeDialect.value
          : this.homeDialect,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassesTableData(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('name: $name, ')
          ..write('grade: $grade, ')
          ..write('section: $section, ')
          ..write('curriculum: $curriculum, ')
          ..write('checkLanguage: $checkLanguage, ')
          ..write('mediumOfInstruction: $mediumOfInstruction, ')
          ..write('textbookId: $textbookId, ')
          ..write('currentChapter: $currentChapter, ')
          ..write('homeDialect: $homeDialect, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scope,
    name,
    grade,
    section,
    curriculum,
    checkLanguage,
    mediumOfInstruction,
    textbookId,
    currentChapter,
    homeDialect,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassesTableData &&
          other.id == this.id &&
          other.scope == this.scope &&
          other.name == this.name &&
          other.grade == this.grade &&
          other.section == this.section &&
          other.curriculum == this.curriculum &&
          other.checkLanguage == this.checkLanguage &&
          other.mediumOfInstruction == this.mediumOfInstruction &&
          other.textbookId == this.textbookId &&
          other.currentChapter == this.currentChapter &&
          other.homeDialect == this.homeDialect &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClassesTableCompanion extends UpdateCompanion<ClassesTableData> {
  final Value<String> id;
  final Value<String> scope;
  final Value<String> name;
  final Value<int> grade;
  final Value<String> section;
  final Value<String> curriculum;
  final Value<String> checkLanguage;
  final Value<String> mediumOfInstruction;
  final Value<String?> textbookId;
  final Value<String?> currentChapter;
  final Value<String?> homeDialect;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ClassesTableCompanion({
    this.id = const Value.absent(),
    this.scope = const Value.absent(),
    this.name = const Value.absent(),
    this.grade = const Value.absent(),
    this.section = const Value.absent(),
    this.curriculum = const Value.absent(),
    this.checkLanguage = const Value.absent(),
    this.mediumOfInstruction = const Value.absent(),
    this.textbookId = const Value.absent(),
    this.currentChapter = const Value.absent(),
    this.homeDialect = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassesTableCompanion.insert({
    required String id,
    required String scope,
    required String name,
    required int grade,
    required String section,
    required String curriculum,
    required String checkLanguage,
    required String mediumOfInstruction,
    this.textbookId = const Value.absent(),
    this.currentChapter = const Value.absent(),
    this.homeDialect = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       scope = Value(scope),
       name = Value(name),
       grade = Value(grade),
       section = Value(section),
       curriculum = Value(curriculum),
       checkLanguage = Value(checkLanguage),
       mediumOfInstruction = Value(mediumOfInstruction),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ClassesTableData> custom({
    Expression<String>? id,
    Expression<String>? scope,
    Expression<String>? name,
    Expression<int>? grade,
    Expression<String>? section,
    Expression<String>? curriculum,
    Expression<String>? checkLanguage,
    Expression<String>? mediumOfInstruction,
    Expression<String>? textbookId,
    Expression<String>? currentChapter,
    Expression<String>? homeDialect,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scope != null) 'scope': scope,
      if (name != null) 'name': name,
      if (grade != null) 'grade': grade,
      if (section != null) 'section': section,
      if (curriculum != null) 'curriculum': curriculum,
      if (checkLanguage != null) 'check_language': checkLanguage,
      if (mediumOfInstruction != null)
        'medium_of_instruction': mediumOfInstruction,
      if (textbookId != null) 'textbook_id': textbookId,
      if (currentChapter != null) 'current_chapter': currentChapter,
      if (homeDialect != null) 'home_dialect': homeDialect,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? scope,
    Value<String>? name,
    Value<int>? grade,
    Value<String>? section,
    Value<String>? curriculum,
    Value<String>? checkLanguage,
    Value<String>? mediumOfInstruction,
    Value<String?>? textbookId,
    Value<String?>? currentChapter,
    Value<String?>? homeDialect,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ClassesTableCompanion(
      id: id ?? this.id,
      scope: scope ?? this.scope,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      section: section ?? this.section,
      curriculum: curriculum ?? this.curriculum,
      checkLanguage: checkLanguage ?? this.checkLanguage,
      mediumOfInstruction: mediumOfInstruction ?? this.mediumOfInstruction,
      textbookId: textbookId ?? this.textbookId,
      currentChapter: currentChapter ?? this.currentChapter,
      homeDialect: homeDialect ?? this.homeDialect,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (curriculum.present) {
      map['curriculum'] = Variable<String>(curriculum.value);
    }
    if (checkLanguage.present) {
      map['check_language'] = Variable<String>(checkLanguage.value);
    }
    if (mediumOfInstruction.present) {
      map['medium_of_instruction'] = Variable<String>(
        mediumOfInstruction.value,
      );
    }
    if (textbookId.present) {
      map['textbook_id'] = Variable<String>(textbookId.value);
    }
    if (currentChapter.present) {
      map['current_chapter'] = Variable<String>(currentChapter.value);
    }
    if (homeDialect.present) {
      map['home_dialect'] = Variable<String>(homeDialect.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassesTableCompanion(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('name: $name, ')
          ..write('grade: $grade, ')
          ..write('section: $section, ')
          ..write('curriculum: $curriculum, ')
          ..write('checkLanguage: $checkLanguage, ')
          ..write('mediumOfInstruction: $mediumOfInstruction, ')
          ..write('textbookId: $textbookId, ')
          ..write('currentChapter: $currentChapter, ')
          ..write('homeDialect: $homeDialect, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChildrenTableTable extends ChildrenTable
    with TableInfo<$ChildrenTableTable, ChildrenTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildrenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastInitialMeta = const VerificationMeta(
    'lastInitial',
  );
  @override
  late final GeneratedColumn<String> lastInitial = GeneratedColumn<String>(
    'last_initial',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeLanguageMeta = const VerificationMeta(
    'homeLanguage',
  );
  @override
  late final GeneratedColumn<String> homeLanguage = GeneratedColumn<String>(
    'home_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeDialectMeta = const VerificationMeta(
    'homeDialect',
  );
  @override
  late final GeneratedColumn<String> homeDialect = GeneratedColumn<String>(
    'home_dialect',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentGroupMeta = const VerificationMeta(
    'currentGroup',
  );
  @override
  late final GeneratedColumn<String> currentGroup = GeneratedColumn<String>(
    'current_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('not_grouped'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classId,
    scope,
    firstName,
    lastInitial,
    homeLanguage,
    homeDialect,
    currentGroup,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'children_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChildrenTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_initial')) {
      context.handle(
        _lastInitialMeta,
        lastInitial.isAcceptableOrUnknown(
          data['last_initial']!,
          _lastInitialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastInitialMeta);
    }
    if (data.containsKey('home_language')) {
      context.handle(
        _homeLanguageMeta,
        homeLanguage.isAcceptableOrUnknown(
          data['home_language']!,
          _homeLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeLanguageMeta);
    }
    if (data.containsKey('home_dialect')) {
      context.handle(
        _homeDialectMeta,
        homeDialect.isAcceptableOrUnknown(
          data['home_dialect']!,
          _homeDialectMeta,
        ),
      );
    }
    if (data.containsKey('current_group')) {
      context.handle(
        _currentGroupMeta,
        currentGroup.isAcceptableOrUnknown(
          data['current_group']!,
          _currentGroupMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChildrenTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildrenTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastInitial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_initial'],
      )!,
      homeLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_language'],
      )!,
      homeDialect: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_dialect'],
      ),
      currentGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_group'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChildrenTableTable createAlias(String alias) {
    return $ChildrenTableTable(attachedDatabase, alias);
  }
}

class ChildrenTableData extends DataClass
    implements Insertable<ChildrenTableData> {
  final String id;
  final String classId;
  final String scope;
  final String firstName;
  final String lastInitial;
  final String homeLanguage;
  final String? homeDialect;
  final String currentGroup;
  final DateTime createdAt;
  const ChildrenTableData({
    required this.id,
    required this.classId,
    required this.scope,
    required this.firstName,
    required this.lastInitial,
    required this.homeLanguage,
    this.homeDialect,
    required this.currentGroup,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['class_id'] = Variable<String>(classId);
    map['scope'] = Variable<String>(scope);
    map['first_name'] = Variable<String>(firstName);
    map['last_initial'] = Variable<String>(lastInitial);
    map['home_language'] = Variable<String>(homeLanguage);
    if (!nullToAbsent || homeDialect != null) {
      map['home_dialect'] = Variable<String>(homeDialect);
    }
    map['current_group'] = Variable<String>(currentGroup);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChildrenTableCompanion toCompanion(bool nullToAbsent) {
    return ChildrenTableCompanion(
      id: Value(id),
      classId: Value(classId),
      scope: Value(scope),
      firstName: Value(firstName),
      lastInitial: Value(lastInitial),
      homeLanguage: Value(homeLanguage),
      homeDialect: homeDialect == null && nullToAbsent
          ? const Value.absent()
          : Value(homeDialect),
      currentGroup: Value(currentGroup),
      createdAt: Value(createdAt),
    );
  }

  factory ChildrenTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildrenTableData(
      id: serializer.fromJson<String>(json['id']),
      classId: serializer.fromJson<String>(json['classId']),
      scope: serializer.fromJson<String>(json['scope']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastInitial: serializer.fromJson<String>(json['lastInitial']),
      homeLanguage: serializer.fromJson<String>(json['homeLanguage']),
      homeDialect: serializer.fromJson<String?>(json['homeDialect']),
      currentGroup: serializer.fromJson<String>(json['currentGroup']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'classId': serializer.toJson<String>(classId),
      'scope': serializer.toJson<String>(scope),
      'firstName': serializer.toJson<String>(firstName),
      'lastInitial': serializer.toJson<String>(lastInitial),
      'homeLanguage': serializer.toJson<String>(homeLanguage),
      'homeDialect': serializer.toJson<String?>(homeDialect),
      'currentGroup': serializer.toJson<String>(currentGroup),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChildrenTableData copyWith({
    String? id,
    String? classId,
    String? scope,
    String? firstName,
    String? lastInitial,
    String? homeLanguage,
    Value<String?> homeDialect = const Value.absent(),
    String? currentGroup,
    DateTime? createdAt,
  }) => ChildrenTableData(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    scope: scope ?? this.scope,
    firstName: firstName ?? this.firstName,
    lastInitial: lastInitial ?? this.lastInitial,
    homeLanguage: homeLanguage ?? this.homeLanguage,
    homeDialect: homeDialect.present ? homeDialect.value : this.homeDialect,
    currentGroup: currentGroup ?? this.currentGroup,
    createdAt: createdAt ?? this.createdAt,
  );
  ChildrenTableData copyWithCompanion(ChildrenTableCompanion data) {
    return ChildrenTableData(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      scope: data.scope.present ? data.scope.value : this.scope,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastInitial: data.lastInitial.present
          ? data.lastInitial.value
          : this.lastInitial,
      homeLanguage: data.homeLanguage.present
          ? data.homeLanguage.value
          : this.homeLanguage,
      homeDialect: data.homeDialect.present
          ? data.homeDialect.value
          : this.homeDialect,
      currentGroup: data.currentGroup.present
          ? data.currentGroup.value
          : this.currentGroup,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableData(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('firstName: $firstName, ')
          ..write('lastInitial: $lastInitial, ')
          ..write('homeLanguage: $homeLanguage, ')
          ..write('homeDialect: $homeDialect, ')
          ..write('currentGroup: $currentGroup, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    classId,
    scope,
    firstName,
    lastInitial,
    homeLanguage,
    homeDialect,
    currentGroup,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildrenTableData &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.scope == this.scope &&
          other.firstName == this.firstName &&
          other.lastInitial == this.lastInitial &&
          other.homeLanguage == this.homeLanguage &&
          other.homeDialect == this.homeDialect &&
          other.currentGroup == this.currentGroup &&
          other.createdAt == this.createdAt);
}

class ChildrenTableCompanion extends UpdateCompanion<ChildrenTableData> {
  final Value<String> id;
  final Value<String> classId;
  final Value<String> scope;
  final Value<String> firstName;
  final Value<String> lastInitial;
  final Value<String> homeLanguage;
  final Value<String?> homeDialect;
  final Value<String> currentGroup;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChildrenTableCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.scope = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastInitial = const Value.absent(),
    this.homeLanguage = const Value.absent(),
    this.homeDialect = const Value.absent(),
    this.currentGroup = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChildrenTableCompanion.insert({
    required String id,
    required String classId,
    required String scope,
    required String firstName,
    required String lastInitial,
    required String homeLanguage,
    this.homeDialect = const Value.absent(),
    this.currentGroup = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       classId = Value(classId),
       scope = Value(scope),
       firstName = Value(firstName),
       lastInitial = Value(lastInitial),
       homeLanguage = Value(homeLanguage),
       createdAt = Value(createdAt);
  static Insertable<ChildrenTableData> custom({
    Expression<String>? id,
    Expression<String>? classId,
    Expression<String>? scope,
    Expression<String>? firstName,
    Expression<String>? lastInitial,
    Expression<String>? homeLanguage,
    Expression<String>? homeDialect,
    Expression<String>? currentGroup,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (scope != null) 'scope': scope,
      if (firstName != null) 'first_name': firstName,
      if (lastInitial != null) 'last_initial': lastInitial,
      if (homeLanguage != null) 'home_language': homeLanguage,
      if (homeDialect != null) 'home_dialect': homeDialect,
      if (currentGroup != null) 'current_group': currentGroup,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChildrenTableCompanion copyWith({
    Value<String>? id,
    Value<String>? classId,
    Value<String>? scope,
    Value<String>? firstName,
    Value<String>? lastInitial,
    Value<String>? homeLanguage,
    Value<String?>? homeDialect,
    Value<String>? currentGroup,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ChildrenTableCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      scope: scope ?? this.scope,
      firstName: firstName ?? this.firstName,
      lastInitial: lastInitial ?? this.lastInitial,
      homeLanguage: homeLanguage ?? this.homeLanguage,
      homeDialect: homeDialect ?? this.homeDialect,
      currentGroup: currentGroup ?? this.currentGroup,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastInitial.present) {
      map['last_initial'] = Variable<String>(lastInitial.value);
    }
    if (homeLanguage.present) {
      map['home_language'] = Variable<String>(homeLanguage.value);
    }
    if (homeDialect.present) {
      map['home_dialect'] = Variable<String>(homeDialect.value);
    }
    if (currentGroup.present) {
      map['current_group'] = Variable<String>(currentGroup.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenTableCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('firstName: $firstName, ')
          ..write('lastInitial: $lastInitial, ')
          ..write('homeLanguage: $homeLanguage, ')
          ..write('homeDialect: $homeDialect, ')
          ..write('currentGroup: $currentGroup, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConsentsTableTable extends ConsentsTable
    with TableInfo<$ConsentsTableTable, ConsentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consentGivenMeta = const VerificationMeta(
    'consentGiven',
  );
  @override
  late final GeneratedColumn<bool> consentGiven = GeneratedColumn<bool>(
    'consent_given',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("consent_given" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _consentDateMeta = const VerificationMeta(
    'consentDate',
  );
  @override
  late final GeneratedColumn<DateTime> consentDate = GeneratedColumn<DateTime>(
    'consent_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withdrawnMeta = const VerificationMeta(
    'withdrawn',
  );
  @override
  late final GeneratedColumn<bool> withdrawn = GeneratedColumn<bool>(
    'withdrawn',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("withdrawn" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _withdrawnDateMeta = const VerificationMeta(
    'withdrawnDate',
  );
  @override
  late final GeneratedColumn<DateTime> withdrawnDate =
      GeneratedColumn<DateTime>(
        'withdrawn_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    childId,
    scope,
    consentGiven,
    consentDate,
    withdrawn,
    withdrawnDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consents_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('consent_given')) {
      context.handle(
        _consentGivenMeta,
        consentGiven.isAcceptableOrUnknown(
          data['consent_given']!,
          _consentGivenMeta,
        ),
      );
    }
    if (data.containsKey('consent_date')) {
      context.handle(
        _consentDateMeta,
        consentDate.isAcceptableOrUnknown(
          data['consent_date']!,
          _consentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_consentDateMeta);
    }
    if (data.containsKey('withdrawn')) {
      context.handle(
        _withdrawnMeta,
        withdrawn.isAcceptableOrUnknown(data['withdrawn']!, _withdrawnMeta),
      );
    }
    if (data.containsKey('withdrawn_date')) {
      context.handle(
        _withdrawnDateMeta,
        withdrawnDate.isAcceptableOrUnknown(
          data['withdrawn_date']!,
          _withdrawnDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      consentGiven: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}consent_given'],
      )!,
      consentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}consent_date'],
      )!,
      withdrawn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}withdrawn'],
      )!,
      withdrawnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}withdrawn_date'],
      ),
    );
  }

  @override
  $ConsentsTableTable createAlias(String alias) {
    return $ConsentsTableTable(attachedDatabase, alias);
  }
}

class ConsentsTableData extends DataClass
    implements Insertable<ConsentsTableData> {
  final String id;
  final String childId;
  final String scope;
  final bool consentGiven;
  final DateTime consentDate;
  final bool withdrawn;
  final DateTime? withdrawnDate;
  const ConsentsTableData({
    required this.id,
    required this.childId,
    required this.scope,
    required this.consentGiven,
    required this.consentDate,
    required this.withdrawn,
    this.withdrawnDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['scope'] = Variable<String>(scope);
    map['consent_given'] = Variable<bool>(consentGiven);
    map['consent_date'] = Variable<DateTime>(consentDate);
    map['withdrawn'] = Variable<bool>(withdrawn);
    if (!nullToAbsent || withdrawnDate != null) {
      map['withdrawn_date'] = Variable<DateTime>(withdrawnDate);
    }
    return map;
  }

  ConsentsTableCompanion toCompanion(bool nullToAbsent) {
    return ConsentsTableCompanion(
      id: Value(id),
      childId: Value(childId),
      scope: Value(scope),
      consentGiven: Value(consentGiven),
      consentDate: Value(consentDate),
      withdrawn: Value(withdrawn),
      withdrawnDate: withdrawnDate == null && nullToAbsent
          ? const Value.absent()
          : Value(withdrawnDate),
    );
  }

  factory ConsentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsentsTableData(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      scope: serializer.fromJson<String>(json['scope']),
      consentGiven: serializer.fromJson<bool>(json['consentGiven']),
      consentDate: serializer.fromJson<DateTime>(json['consentDate']),
      withdrawn: serializer.fromJson<bool>(json['withdrawn']),
      withdrawnDate: serializer.fromJson<DateTime?>(json['withdrawnDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'scope': serializer.toJson<String>(scope),
      'consentGiven': serializer.toJson<bool>(consentGiven),
      'consentDate': serializer.toJson<DateTime>(consentDate),
      'withdrawn': serializer.toJson<bool>(withdrawn),
      'withdrawnDate': serializer.toJson<DateTime?>(withdrawnDate),
    };
  }

  ConsentsTableData copyWith({
    String? id,
    String? childId,
    String? scope,
    bool? consentGiven,
    DateTime? consentDate,
    bool? withdrawn,
    Value<DateTime?> withdrawnDate = const Value.absent(),
  }) => ConsentsTableData(
    id: id ?? this.id,
    childId: childId ?? this.childId,
    scope: scope ?? this.scope,
    consentGiven: consentGiven ?? this.consentGiven,
    consentDate: consentDate ?? this.consentDate,
    withdrawn: withdrawn ?? this.withdrawn,
    withdrawnDate: withdrawnDate.present
        ? withdrawnDate.value
        : this.withdrawnDate,
  );
  ConsentsTableData copyWithCompanion(ConsentsTableCompanion data) {
    return ConsentsTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      scope: data.scope.present ? data.scope.value : this.scope,
      consentGiven: data.consentGiven.present
          ? data.consentGiven.value
          : this.consentGiven,
      consentDate: data.consentDate.present
          ? data.consentDate.value
          : this.consentDate,
      withdrawn: data.withdrawn.present ? data.withdrawn.value : this.withdrawn,
      withdrawnDate: data.withdrawnDate.present
          ? data.withdrawnDate.value
          : this.withdrawnDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsentsTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('consentGiven: $consentGiven, ')
          ..write('consentDate: $consentDate, ')
          ..write('withdrawn: $withdrawn, ')
          ..write('withdrawnDate: $withdrawnDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    childId,
    scope,
    consentGiven,
    consentDate,
    withdrawn,
    withdrawnDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsentsTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.scope == this.scope &&
          other.consentGiven == this.consentGiven &&
          other.consentDate == this.consentDate &&
          other.withdrawn == this.withdrawn &&
          other.withdrawnDate == this.withdrawnDate);
}

class ConsentsTableCompanion extends UpdateCompanion<ConsentsTableData> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> scope;
  final Value<bool> consentGiven;
  final Value<DateTime> consentDate;
  final Value<bool> withdrawn;
  final Value<DateTime?> withdrawnDate;
  final Value<int> rowid;
  const ConsentsTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.scope = const Value.absent(),
    this.consentGiven = const Value.absent(),
    this.consentDate = const Value.absent(),
    this.withdrawn = const Value.absent(),
    this.withdrawnDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConsentsTableCompanion.insert({
    required String id,
    required String childId,
    required String scope,
    this.consentGiven = const Value.absent(),
    required DateTime consentDate,
    this.withdrawn = const Value.absent(),
    this.withdrawnDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       childId = Value(childId),
       scope = Value(scope),
       consentDate = Value(consentDate);
  static Insertable<ConsentsTableData> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? scope,
    Expression<bool>? consentGiven,
    Expression<DateTime>? consentDate,
    Expression<bool>? withdrawn,
    Expression<DateTime>? withdrawnDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (scope != null) 'scope': scope,
      if (consentGiven != null) 'consent_given': consentGiven,
      if (consentDate != null) 'consent_date': consentDate,
      if (withdrawn != null) 'withdrawn': withdrawn,
      if (withdrawnDate != null) 'withdrawn_date': withdrawnDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConsentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? childId,
    Value<String>? scope,
    Value<bool>? consentGiven,
    Value<DateTime>? consentDate,
    Value<bool>? withdrawn,
    Value<DateTime?>? withdrawnDate,
    Value<int>? rowid,
  }) {
    return ConsentsTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      scope: scope ?? this.scope,
      consentGiven: consentGiven ?? this.consentGiven,
      consentDate: consentDate ?? this.consentDate,
      withdrawn: withdrawn ?? this.withdrawn,
      withdrawnDate: withdrawnDate ?? this.withdrawnDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (consentGiven.present) {
      map['consent_given'] = Variable<bool>(consentGiven.value);
    }
    if (consentDate.present) {
      map['consent_date'] = Variable<DateTime>(consentDate.value);
    }
    if (withdrawn.present) {
      map['withdrawn'] = Variable<bool>(withdrawn.value);
    }
    if (withdrawnDate.present) {
      map['withdrawn_date'] = Variable<DateTime>(withdrawnDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsentsTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('consentGiven: $consentGiven, ')
          ..write('consentDate: $consentDate, ')
          ..write('withdrawn: $withdrawn, ')
          ..write('withdrawnDate: $withdrawnDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupAssignmentsTableTable extends GroupAssignmentsTable
    with TableInfo<$GroupAssignmentsTableTable, GroupAssignmentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupAssignmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromGroupMeta = const VerificationMeta(
    'fromGroup',
  );
  @override
  late final GeneratedColumn<String> fromGroup = GeneratedColumn<String>(
    'from_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toGroupMeta = const VerificationMeta(
    'toGroup',
  );
  @override
  late final GeneratedColumn<String> toGroup = GeneratedColumn<String>(
    'to_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _movedAtMeta = const VerificationMeta(
    'movedAt',
  );
  @override
  late final GeneratedColumn<DateTime> movedAt = GeneratedColumn<DateTime>(
    'moved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    childId,
    scope,
    fromGroup,
    toGroup,
    reason,
    movedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_assignments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupAssignmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('from_group')) {
      context.handle(
        _fromGroupMeta,
        fromGroup.isAcceptableOrUnknown(data['from_group']!, _fromGroupMeta),
      );
    } else if (isInserting) {
      context.missing(_fromGroupMeta);
    }
    if (data.containsKey('to_group')) {
      context.handle(
        _toGroupMeta,
        toGroup.isAcceptableOrUnknown(data['to_group']!, _toGroupMeta),
      );
    } else if (isInserting) {
      context.missing(_toGroupMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('moved_at')) {
      context.handle(
        _movedAtMeta,
        movedAt.isAcceptableOrUnknown(data['moved_at']!, _movedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_movedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupAssignmentsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupAssignmentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      fromGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_group'],
      )!,
      toGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_group'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      movedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}moved_at'],
      )!,
    );
  }

  @override
  $GroupAssignmentsTableTable createAlias(String alias) {
    return $GroupAssignmentsTableTable(attachedDatabase, alias);
  }
}

class GroupAssignmentsTableData extends DataClass
    implements Insertable<GroupAssignmentsTableData> {
  final String id;
  final String childId;
  final String scope;
  final String fromGroup;
  final String toGroup;
  final String? reason;
  final DateTime movedAt;
  const GroupAssignmentsTableData({
    required this.id,
    required this.childId,
    required this.scope,
    required this.fromGroup,
    required this.toGroup,
    this.reason,
    required this.movedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['scope'] = Variable<String>(scope);
    map['from_group'] = Variable<String>(fromGroup);
    map['to_group'] = Variable<String>(toGroup);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['moved_at'] = Variable<DateTime>(movedAt);
    return map;
  }

  GroupAssignmentsTableCompanion toCompanion(bool nullToAbsent) {
    return GroupAssignmentsTableCompanion(
      id: Value(id),
      childId: Value(childId),
      scope: Value(scope),
      fromGroup: Value(fromGroup),
      toGroup: Value(toGroup),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      movedAt: Value(movedAt),
    );
  }

  factory GroupAssignmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupAssignmentsTableData(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      scope: serializer.fromJson<String>(json['scope']),
      fromGroup: serializer.fromJson<String>(json['fromGroup']),
      toGroup: serializer.fromJson<String>(json['toGroup']),
      reason: serializer.fromJson<String?>(json['reason']),
      movedAt: serializer.fromJson<DateTime>(json['movedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'scope': serializer.toJson<String>(scope),
      'fromGroup': serializer.toJson<String>(fromGroup),
      'toGroup': serializer.toJson<String>(toGroup),
      'reason': serializer.toJson<String?>(reason),
      'movedAt': serializer.toJson<DateTime>(movedAt),
    };
  }

  GroupAssignmentsTableData copyWith({
    String? id,
    String? childId,
    String? scope,
    String? fromGroup,
    String? toGroup,
    Value<String?> reason = const Value.absent(),
    DateTime? movedAt,
  }) => GroupAssignmentsTableData(
    id: id ?? this.id,
    childId: childId ?? this.childId,
    scope: scope ?? this.scope,
    fromGroup: fromGroup ?? this.fromGroup,
    toGroup: toGroup ?? this.toGroup,
    reason: reason.present ? reason.value : this.reason,
    movedAt: movedAt ?? this.movedAt,
  );
  GroupAssignmentsTableData copyWithCompanion(
    GroupAssignmentsTableCompanion data,
  ) {
    return GroupAssignmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      scope: data.scope.present ? data.scope.value : this.scope,
      fromGroup: data.fromGroup.present ? data.fromGroup.value : this.fromGroup,
      toGroup: data.toGroup.present ? data.toGroup.value : this.toGroup,
      reason: data.reason.present ? data.reason.value : this.reason,
      movedAt: data.movedAt.present ? data.movedAt.value : this.movedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupAssignmentsTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('fromGroup: $fromGroup, ')
          ..write('toGroup: $toGroup, ')
          ..write('reason: $reason, ')
          ..write('movedAt: $movedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, childId, scope, fromGroup, toGroup, reason, movedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupAssignmentsTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.scope == this.scope &&
          other.fromGroup == this.fromGroup &&
          other.toGroup == this.toGroup &&
          other.reason == this.reason &&
          other.movedAt == this.movedAt);
}

class GroupAssignmentsTableCompanion
    extends UpdateCompanion<GroupAssignmentsTableData> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> scope;
  final Value<String> fromGroup;
  final Value<String> toGroup;
  final Value<String?> reason;
  final Value<DateTime> movedAt;
  final Value<int> rowid;
  const GroupAssignmentsTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.scope = const Value.absent(),
    this.fromGroup = const Value.absent(),
    this.toGroup = const Value.absent(),
    this.reason = const Value.absent(),
    this.movedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupAssignmentsTableCompanion.insert({
    required String id,
    required String childId,
    required String scope,
    required String fromGroup,
    required String toGroup,
    this.reason = const Value.absent(),
    required DateTime movedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       childId = Value(childId),
       scope = Value(scope),
       fromGroup = Value(fromGroup),
       toGroup = Value(toGroup),
       movedAt = Value(movedAt);
  static Insertable<GroupAssignmentsTableData> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? scope,
    Expression<String>? fromGroup,
    Expression<String>? toGroup,
    Expression<String>? reason,
    Expression<DateTime>? movedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (scope != null) 'scope': scope,
      if (fromGroup != null) 'from_group': fromGroup,
      if (toGroup != null) 'to_group': toGroup,
      if (reason != null) 'reason': reason,
      if (movedAt != null) 'moved_at': movedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupAssignmentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? childId,
    Value<String>? scope,
    Value<String>? fromGroup,
    Value<String>? toGroup,
    Value<String?>? reason,
    Value<DateTime>? movedAt,
    Value<int>? rowid,
  }) {
    return GroupAssignmentsTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      scope: scope ?? this.scope,
      fromGroup: fromGroup ?? this.fromGroup,
      toGroup: toGroup ?? this.toGroup,
      reason: reason ?? this.reason,
      movedAt: movedAt ?? this.movedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (fromGroup.present) {
      map['from_group'] = Variable<String>(fromGroup.value);
    }
    if (toGroup.present) {
      map['to_group'] = Variable<String>(toGroup.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (movedAt.present) {
      map['moved_at'] = Variable<DateTime>(movedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupAssignmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('fromGroup: $fromGroup, ')
          ..write('toGroup: $toGroup, ')
          ..write('reason: $reason, ')
          ..write('movedAt: $movedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecksTableTable extends ChecksTable
    with TableInfo<$ChecksTableTable, ChecksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStepMeta = const VerificationMeta(
    'currentStep',
  );
  @override
  late final GeneratedColumn<String> currentStep = GeneratedColumn<String>(
    'current_step',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passageIdMeta = const VerificationMeta(
    'passageId',
  );
  @override
  late final GeneratedColumn<String> passageId = GeneratedColumn<String>(
    'passage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passageTitleMeta = const VerificationMeta(
    'passageTitle',
  );
  @override
  late final GeneratedColumn<String> passageTitle = GeneratedColumn<String>(
    'passage_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passageLevelMeta = const VerificationMeta(
    'passageLevel',
  );
  @override
  late final GeneratedColumn<int> passageLevel = GeneratedColumn<int>(
    'passage_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noiseLevelMeta = const VerificationMeta(
    'noiseLevel',
  );
  @override
  late final GeneratedColumn<double> noiseLevel = GeneratedColumn<double>(
    'noise_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLowConfidenceMeta = const VerificationMeta(
    'isLowConfidence',
  );
  @override
  late final GeneratedColumn<bool> isLowConfidence = GeneratedColumn<bool>(
    'is_low_confidence',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_low_confidence" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markedWithoutRecordingMeta =
      const VerificationMeta('markedWithoutRecording');
  @override
  late final GeneratedColumn<bool> markedWithoutRecording =
      GeneratedColumn<bool>(
        'marked_without_recording',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("marked_without_recording" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _benchmarkUsedJsonMeta = const VerificationMeta(
    'benchmarkUsedJson',
  );
  @override
  late final GeneratedColumn<String> benchmarkUsedJson =
      GeneratedColumn<String>(
        'benchmark_used_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rubricVersionMeta = const VerificationMeta(
    'rubricVersion',
  );
  @override
  late final GeneratedColumn<String> rubricVersion = GeneratedColumn<String>(
    'rubric_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('v0.1'),
  );
  static const VerificationMeta _readingDurationSecondsMeta =
      const VerificationMeta('readingDurationSeconds');
  @override
  late final GeneratedColumn<double> readingDurationSeconds =
      GeneratedColumn<double>(
        'reading_duration_seconds',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readingSelfRatingMeta = const VerificationMeta(
    'readingSelfRating',
  );
  @override
  late final GeneratedColumn<String> readingSelfRating =
      GeneratedColumn<String>(
        'reading_self_rating',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    childId,
    classId,
    scope,
    status,
    currentStep,
    passageId,
    passageTitle,
    passageLevel,
    noiseLevel,
    isLowConfidence,
    audioPath,
    markedWithoutRecording,
    benchmarkUsedJson,
    rubricVersion,
    readingDurationSeconds,
    startedAt,
    completedAt,
    readingSelfRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('current_step')) {
      context.handle(
        _currentStepMeta,
        currentStep.isAcceptableOrUnknown(
          data['current_step']!,
          _currentStepMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentStepMeta);
    }
    if (data.containsKey('passage_id')) {
      context.handle(
        _passageIdMeta,
        passageId.isAcceptableOrUnknown(data['passage_id']!, _passageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_passageIdMeta);
    }
    if (data.containsKey('passage_title')) {
      context.handle(
        _passageTitleMeta,
        passageTitle.isAcceptableOrUnknown(
          data['passage_title']!,
          _passageTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passageTitleMeta);
    }
    if (data.containsKey('passage_level')) {
      context.handle(
        _passageLevelMeta,
        passageLevel.isAcceptableOrUnknown(
          data['passage_level']!,
          _passageLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passageLevelMeta);
    }
    if (data.containsKey('noise_level')) {
      context.handle(
        _noiseLevelMeta,
        noiseLevel.isAcceptableOrUnknown(data['noise_level']!, _noiseLevelMeta),
      );
    }
    if (data.containsKey('is_low_confidence')) {
      context.handle(
        _isLowConfidenceMeta,
        isLowConfidence.isAcceptableOrUnknown(
          data['is_low_confidence']!,
          _isLowConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    if (data.containsKey('marked_without_recording')) {
      context.handle(
        _markedWithoutRecordingMeta,
        markedWithoutRecording.isAcceptableOrUnknown(
          data['marked_without_recording']!,
          _markedWithoutRecordingMeta,
        ),
      );
    }
    if (data.containsKey('benchmark_used_json')) {
      context.handle(
        _benchmarkUsedJsonMeta,
        benchmarkUsedJson.isAcceptableOrUnknown(
          data['benchmark_used_json']!,
          _benchmarkUsedJsonMeta,
        ),
      );
    }
    if (data.containsKey('rubric_version')) {
      context.handle(
        _rubricVersionMeta,
        rubricVersion.isAcceptableOrUnknown(
          data['rubric_version']!,
          _rubricVersionMeta,
        ),
      );
    }
    if (data.containsKey('reading_duration_seconds')) {
      context.handle(
        _readingDurationSecondsMeta,
        readingDurationSeconds.isAcceptableOrUnknown(
          data['reading_duration_seconds']!,
          _readingDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('reading_self_rating')) {
      context.handle(
        _readingSelfRatingMeta,
        readingSelfRating.isAcceptableOrUnknown(
          data['reading_self_rating']!,
          _readingSelfRatingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      currentStep: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_step'],
      )!,
      passageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passage_id'],
      )!,
      passageTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passage_title'],
      )!,
      passageLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passage_level'],
      )!,
      noiseLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}noise_level'],
      ),
      isLowConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_low_confidence'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
      markedWithoutRecording: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}marked_without_recording'],
      )!,
      benchmarkUsedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}benchmark_used_json'],
      ),
      rubricVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rubric_version'],
      )!,
      readingDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_duration_seconds'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      readingSelfRating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_self_rating'],
      ),
    );
  }

  @override
  $ChecksTableTable createAlias(String alias) {
    return $ChecksTableTable(attachedDatabase, alias);
  }
}

class ChecksTableData extends DataClass implements Insertable<ChecksTableData> {
  final String id;
  final String childId;
  final String classId;
  final String scope;
  final String status;
  final String currentStep;
  final String passageId;
  final String passageTitle;
  final int passageLevel;
  final double? noiseLevel;
  final bool isLowConfidence;
  final String? audioPath;
  final bool markedWithoutRecording;
  final String? benchmarkUsedJson;
  final String rubricVersion;
  final double? readingDurationSeconds;
  final DateTime startedAt;
  final DateTime? completedAt;

  /// v7: child's own thumbs up / down after reading aloud
  /// ('thumbs_up' | 'thumbs_down' | 'not_recorded').
  final String? readingSelfRating;
  const ChecksTableData({
    required this.id,
    required this.childId,
    required this.classId,
    required this.scope,
    required this.status,
    required this.currentStep,
    required this.passageId,
    required this.passageTitle,
    required this.passageLevel,
    this.noiseLevel,
    required this.isLowConfidence,
    this.audioPath,
    required this.markedWithoutRecording,
    this.benchmarkUsedJson,
    required this.rubricVersion,
    this.readingDurationSeconds,
    required this.startedAt,
    this.completedAt,
    this.readingSelfRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['class_id'] = Variable<String>(classId);
    map['scope'] = Variable<String>(scope);
    map['status'] = Variable<String>(status);
    map['current_step'] = Variable<String>(currentStep);
    map['passage_id'] = Variable<String>(passageId);
    map['passage_title'] = Variable<String>(passageTitle);
    map['passage_level'] = Variable<int>(passageLevel);
    if (!nullToAbsent || noiseLevel != null) {
      map['noise_level'] = Variable<double>(noiseLevel);
    }
    map['is_low_confidence'] = Variable<bool>(isLowConfidence);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    map['marked_without_recording'] = Variable<bool>(markedWithoutRecording);
    if (!nullToAbsent || benchmarkUsedJson != null) {
      map['benchmark_used_json'] = Variable<String>(benchmarkUsedJson);
    }
    map['rubric_version'] = Variable<String>(rubricVersion);
    if (!nullToAbsent || readingDurationSeconds != null) {
      map['reading_duration_seconds'] = Variable<double>(
        readingDurationSeconds,
      );
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || readingSelfRating != null) {
      map['reading_self_rating'] = Variable<String>(readingSelfRating);
    }
    return map;
  }

  ChecksTableCompanion toCompanion(bool nullToAbsent) {
    return ChecksTableCompanion(
      id: Value(id),
      childId: Value(childId),
      classId: Value(classId),
      scope: Value(scope),
      status: Value(status),
      currentStep: Value(currentStep),
      passageId: Value(passageId),
      passageTitle: Value(passageTitle),
      passageLevel: Value(passageLevel),
      noiseLevel: noiseLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(noiseLevel),
      isLowConfidence: Value(isLowConfidence),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      markedWithoutRecording: Value(markedWithoutRecording),
      benchmarkUsedJson: benchmarkUsedJson == null && nullToAbsent
          ? const Value.absent()
          : Value(benchmarkUsedJson),
      rubricVersion: Value(rubricVersion),
      readingDurationSeconds: readingDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(readingDurationSeconds),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      readingSelfRating: readingSelfRating == null && nullToAbsent
          ? const Value.absent()
          : Value(readingSelfRating),
    );
  }

  factory ChecksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecksTableData(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      classId: serializer.fromJson<String>(json['classId']),
      scope: serializer.fromJson<String>(json['scope']),
      status: serializer.fromJson<String>(json['status']),
      currentStep: serializer.fromJson<String>(json['currentStep']),
      passageId: serializer.fromJson<String>(json['passageId']),
      passageTitle: serializer.fromJson<String>(json['passageTitle']),
      passageLevel: serializer.fromJson<int>(json['passageLevel']),
      noiseLevel: serializer.fromJson<double?>(json['noiseLevel']),
      isLowConfidence: serializer.fromJson<bool>(json['isLowConfidence']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      markedWithoutRecording: serializer.fromJson<bool>(
        json['markedWithoutRecording'],
      ),
      benchmarkUsedJson: serializer.fromJson<String?>(
        json['benchmarkUsedJson'],
      ),
      rubricVersion: serializer.fromJson<String>(json['rubricVersion']),
      readingDurationSeconds: serializer.fromJson<double?>(
        json['readingDurationSeconds'],
      ),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      readingSelfRating: serializer.fromJson<String?>(
        json['readingSelfRating'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'classId': serializer.toJson<String>(classId),
      'scope': serializer.toJson<String>(scope),
      'status': serializer.toJson<String>(status),
      'currentStep': serializer.toJson<String>(currentStep),
      'passageId': serializer.toJson<String>(passageId),
      'passageTitle': serializer.toJson<String>(passageTitle),
      'passageLevel': serializer.toJson<int>(passageLevel),
      'noiseLevel': serializer.toJson<double?>(noiseLevel),
      'isLowConfidence': serializer.toJson<bool>(isLowConfidence),
      'audioPath': serializer.toJson<String?>(audioPath),
      'markedWithoutRecording': serializer.toJson<bool>(markedWithoutRecording),
      'benchmarkUsedJson': serializer.toJson<String?>(benchmarkUsedJson),
      'rubricVersion': serializer.toJson<String>(rubricVersion),
      'readingDurationSeconds': serializer.toJson<double?>(
        readingDurationSeconds,
      ),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'readingSelfRating': serializer.toJson<String?>(readingSelfRating),
    };
  }

  ChecksTableData copyWith({
    String? id,
    String? childId,
    String? classId,
    String? scope,
    String? status,
    String? currentStep,
    String? passageId,
    String? passageTitle,
    int? passageLevel,
    Value<double?> noiseLevel = const Value.absent(),
    bool? isLowConfidence,
    Value<String?> audioPath = const Value.absent(),
    bool? markedWithoutRecording,
    Value<String?> benchmarkUsedJson = const Value.absent(),
    String? rubricVersion,
    Value<double?> readingDurationSeconds = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> readingSelfRating = const Value.absent(),
  }) => ChecksTableData(
    id: id ?? this.id,
    childId: childId ?? this.childId,
    classId: classId ?? this.classId,
    scope: scope ?? this.scope,
    status: status ?? this.status,
    currentStep: currentStep ?? this.currentStep,
    passageId: passageId ?? this.passageId,
    passageTitle: passageTitle ?? this.passageTitle,
    passageLevel: passageLevel ?? this.passageLevel,
    noiseLevel: noiseLevel.present ? noiseLevel.value : this.noiseLevel,
    isLowConfidence: isLowConfidence ?? this.isLowConfidence,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
    markedWithoutRecording:
        markedWithoutRecording ?? this.markedWithoutRecording,
    benchmarkUsedJson: benchmarkUsedJson.present
        ? benchmarkUsedJson.value
        : this.benchmarkUsedJson,
    rubricVersion: rubricVersion ?? this.rubricVersion,
    readingDurationSeconds: readingDurationSeconds.present
        ? readingDurationSeconds.value
        : this.readingDurationSeconds,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    readingSelfRating: readingSelfRating.present
        ? readingSelfRating.value
        : this.readingSelfRating,
  );
  ChecksTableData copyWithCompanion(ChecksTableCompanion data) {
    return ChecksTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      classId: data.classId.present ? data.classId.value : this.classId,
      scope: data.scope.present ? data.scope.value : this.scope,
      status: data.status.present ? data.status.value : this.status,
      currentStep: data.currentStep.present
          ? data.currentStep.value
          : this.currentStep,
      passageId: data.passageId.present ? data.passageId.value : this.passageId,
      passageTitle: data.passageTitle.present
          ? data.passageTitle.value
          : this.passageTitle,
      passageLevel: data.passageLevel.present
          ? data.passageLevel.value
          : this.passageLevel,
      noiseLevel: data.noiseLevel.present
          ? data.noiseLevel.value
          : this.noiseLevel,
      isLowConfidence: data.isLowConfidence.present
          ? data.isLowConfidence.value
          : this.isLowConfidence,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      markedWithoutRecording: data.markedWithoutRecording.present
          ? data.markedWithoutRecording.value
          : this.markedWithoutRecording,
      benchmarkUsedJson: data.benchmarkUsedJson.present
          ? data.benchmarkUsedJson.value
          : this.benchmarkUsedJson,
      rubricVersion: data.rubricVersion.present
          ? data.rubricVersion.value
          : this.rubricVersion,
      readingDurationSeconds: data.readingDurationSeconds.present
          ? data.readingDurationSeconds.value
          : this.readingDurationSeconds,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      readingSelfRating: data.readingSelfRating.present
          ? data.readingSelfRating.value
          : this.readingSelfRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecksTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('status: $status, ')
          ..write('currentStep: $currentStep, ')
          ..write('passageId: $passageId, ')
          ..write('passageTitle: $passageTitle, ')
          ..write('passageLevel: $passageLevel, ')
          ..write('noiseLevel: $noiseLevel, ')
          ..write('isLowConfidence: $isLowConfidence, ')
          ..write('audioPath: $audioPath, ')
          ..write('markedWithoutRecording: $markedWithoutRecording, ')
          ..write('benchmarkUsedJson: $benchmarkUsedJson, ')
          ..write('rubricVersion: $rubricVersion, ')
          ..write('readingDurationSeconds: $readingDurationSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('readingSelfRating: $readingSelfRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    childId,
    classId,
    scope,
    status,
    currentStep,
    passageId,
    passageTitle,
    passageLevel,
    noiseLevel,
    isLowConfidence,
    audioPath,
    markedWithoutRecording,
    benchmarkUsedJson,
    rubricVersion,
    readingDurationSeconds,
    startedAt,
    completedAt,
    readingSelfRating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecksTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.classId == this.classId &&
          other.scope == this.scope &&
          other.status == this.status &&
          other.currentStep == this.currentStep &&
          other.passageId == this.passageId &&
          other.passageTitle == this.passageTitle &&
          other.passageLevel == this.passageLevel &&
          other.noiseLevel == this.noiseLevel &&
          other.isLowConfidence == this.isLowConfidence &&
          other.audioPath == this.audioPath &&
          other.markedWithoutRecording == this.markedWithoutRecording &&
          other.benchmarkUsedJson == this.benchmarkUsedJson &&
          other.rubricVersion == this.rubricVersion &&
          other.readingDurationSeconds == this.readingDurationSeconds &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.readingSelfRating == this.readingSelfRating);
}

class ChecksTableCompanion extends UpdateCompanion<ChecksTableData> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> classId;
  final Value<String> scope;
  final Value<String> status;
  final Value<String> currentStep;
  final Value<String> passageId;
  final Value<String> passageTitle;
  final Value<int> passageLevel;
  final Value<double?> noiseLevel;
  final Value<bool> isLowConfidence;
  final Value<String?> audioPath;
  final Value<bool> markedWithoutRecording;
  final Value<String?> benchmarkUsedJson;
  final Value<String> rubricVersion;
  final Value<double?> readingDurationSeconds;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String?> readingSelfRating;
  final Value<int> rowid;
  const ChecksTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.classId = const Value.absent(),
    this.scope = const Value.absent(),
    this.status = const Value.absent(),
    this.currentStep = const Value.absent(),
    this.passageId = const Value.absent(),
    this.passageTitle = const Value.absent(),
    this.passageLevel = const Value.absent(),
    this.noiseLevel = const Value.absent(),
    this.isLowConfidence = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.markedWithoutRecording = const Value.absent(),
    this.benchmarkUsedJson = const Value.absent(),
    this.rubricVersion = const Value.absent(),
    this.readingDurationSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.readingSelfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecksTableCompanion.insert({
    required String id,
    required String childId,
    required String classId,
    required String scope,
    required String status,
    required String currentStep,
    required String passageId,
    required String passageTitle,
    required int passageLevel,
    this.noiseLevel = const Value.absent(),
    this.isLowConfidence = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.markedWithoutRecording = const Value.absent(),
    this.benchmarkUsedJson = const Value.absent(),
    this.rubricVersion = const Value.absent(),
    this.readingDurationSeconds = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.readingSelfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       childId = Value(childId),
       classId = Value(classId),
       scope = Value(scope),
       status = Value(status),
       currentStep = Value(currentStep),
       passageId = Value(passageId),
       passageTitle = Value(passageTitle),
       passageLevel = Value(passageLevel),
       startedAt = Value(startedAt);
  static Insertable<ChecksTableData> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? classId,
    Expression<String>? scope,
    Expression<String>? status,
    Expression<String>? currentStep,
    Expression<String>? passageId,
    Expression<String>? passageTitle,
    Expression<int>? passageLevel,
    Expression<double>? noiseLevel,
    Expression<bool>? isLowConfidence,
    Expression<String>? audioPath,
    Expression<bool>? markedWithoutRecording,
    Expression<String>? benchmarkUsedJson,
    Expression<String>? rubricVersion,
    Expression<double>? readingDurationSeconds,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? readingSelfRating,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (classId != null) 'class_id': classId,
      if (scope != null) 'scope': scope,
      if (status != null) 'status': status,
      if (currentStep != null) 'current_step': currentStep,
      if (passageId != null) 'passage_id': passageId,
      if (passageTitle != null) 'passage_title': passageTitle,
      if (passageLevel != null) 'passage_level': passageLevel,
      if (noiseLevel != null) 'noise_level': noiseLevel,
      if (isLowConfidence != null) 'is_low_confidence': isLowConfidence,
      if (audioPath != null) 'audio_path': audioPath,
      if (markedWithoutRecording != null)
        'marked_without_recording': markedWithoutRecording,
      if (benchmarkUsedJson != null) 'benchmark_used_json': benchmarkUsedJson,
      if (rubricVersion != null) 'rubric_version': rubricVersion,
      if (readingDurationSeconds != null)
        'reading_duration_seconds': readingDurationSeconds,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (readingSelfRating != null) 'reading_self_rating': readingSelfRating,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? childId,
    Value<String>? classId,
    Value<String>? scope,
    Value<String>? status,
    Value<String>? currentStep,
    Value<String>? passageId,
    Value<String>? passageTitle,
    Value<int>? passageLevel,
    Value<double?>? noiseLevel,
    Value<bool>? isLowConfidence,
    Value<String?>? audioPath,
    Value<bool>? markedWithoutRecording,
    Value<String?>? benchmarkUsedJson,
    Value<String>? rubricVersion,
    Value<double?>? readingDurationSeconds,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String?>? readingSelfRating,
    Value<int>? rowid,
  }) {
    return ChecksTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      classId: classId ?? this.classId,
      scope: scope ?? this.scope,
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      passageId: passageId ?? this.passageId,
      passageTitle: passageTitle ?? this.passageTitle,
      passageLevel: passageLevel ?? this.passageLevel,
      noiseLevel: noiseLevel ?? this.noiseLevel,
      isLowConfidence: isLowConfidence ?? this.isLowConfidence,
      audioPath: audioPath ?? this.audioPath,
      markedWithoutRecording:
          markedWithoutRecording ?? this.markedWithoutRecording,
      benchmarkUsedJson: benchmarkUsedJson ?? this.benchmarkUsedJson,
      rubricVersion: rubricVersion ?? this.rubricVersion,
      readingDurationSeconds:
          readingDurationSeconds ?? this.readingDurationSeconds,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      readingSelfRating: readingSelfRating ?? this.readingSelfRating,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currentStep.present) {
      map['current_step'] = Variable<String>(currentStep.value);
    }
    if (passageId.present) {
      map['passage_id'] = Variable<String>(passageId.value);
    }
    if (passageTitle.present) {
      map['passage_title'] = Variable<String>(passageTitle.value);
    }
    if (passageLevel.present) {
      map['passage_level'] = Variable<int>(passageLevel.value);
    }
    if (noiseLevel.present) {
      map['noise_level'] = Variable<double>(noiseLevel.value);
    }
    if (isLowConfidence.present) {
      map['is_low_confidence'] = Variable<bool>(isLowConfidence.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (markedWithoutRecording.present) {
      map['marked_without_recording'] = Variable<bool>(
        markedWithoutRecording.value,
      );
    }
    if (benchmarkUsedJson.present) {
      map['benchmark_used_json'] = Variable<String>(benchmarkUsedJson.value);
    }
    if (rubricVersion.present) {
      map['rubric_version'] = Variable<String>(rubricVersion.value);
    }
    if (readingDurationSeconds.present) {
      map['reading_duration_seconds'] = Variable<double>(
        readingDurationSeconds.value,
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (readingSelfRating.present) {
      map['reading_self_rating'] = Variable<String>(readingSelfRating.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecksTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('status: $status, ')
          ..write('currentStep: $currentStep, ')
          ..write('passageId: $passageId, ')
          ..write('passageTitle: $passageTitle, ')
          ..write('passageLevel: $passageLevel, ')
          ..write('noiseLevel: $noiseLevel, ')
          ..write('isLowConfidence: $isLowConfidence, ')
          ..write('audioPath: $audioPath, ')
          ..write('markedWithoutRecording: $markedWithoutRecording, ')
          ..write('benchmarkUsedJson: $benchmarkUsedJson, ')
          ..write('rubricVersion: $rubricVersion, ')
          ..write('readingDurationSeconds: $readingDurationSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('readingSelfRating: $readingSelfRating, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordMarksTableTable extends WordMarksTable
    with TableInfo<$WordMarksTableTable, WordMarksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordMarksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordIndexMeta = const VerificationMeta(
    'wordIndex',
  );
  @override
  late final GeneratedColumn<int> wordIndex = GeneratedColumn<int>(
    'word_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedWordMeta = const VerificationMeta(
    'expectedWord',
  );
  @override
  late final GeneratedColumn<String> expectedWord = GeneratedColumn<String>(
    'expected_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualWordMeta = const VerificationMeta(
    'actualWord',
  );
  @override
  late final GeneratedColumn<String> actualWord = GeneratedColumn<String>(
    'actual_word',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markMeta = const VerificationMeta('mark');
  @override
  late final GeneratedColumn<String> mark = GeneratedColumn<String>(
    'mark',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorSubtypeMeta = const VerificationMeta(
    'errorSubtype',
  );
  @override
  late final GeneratedColumn<String> errorSubtype = GeneratedColumn<String>(
    'error_subtype',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    wordIndex,
    expectedWord,
    actualWord,
    mark,
    errorSubtype,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_marks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordMarksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('word_index')) {
      context.handle(
        _wordIndexMeta,
        wordIndex.isAcceptableOrUnknown(data['word_index']!, _wordIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIndexMeta);
    }
    if (data.containsKey('expected_word')) {
      context.handle(
        _expectedWordMeta,
        expectedWord.isAcceptableOrUnknown(
          data['expected_word']!,
          _expectedWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedWordMeta);
    }
    if (data.containsKey('actual_word')) {
      context.handle(
        _actualWordMeta,
        actualWord.isAcceptableOrUnknown(data['actual_word']!, _actualWordMeta),
      );
    }
    if (data.containsKey('mark')) {
      context.handle(
        _markMeta,
        mark.isAcceptableOrUnknown(data['mark']!, _markMeta),
      );
    } else if (isInserting) {
      context.missing(_markMeta);
    }
    if (data.containsKey('error_subtype')) {
      context.handle(
        _errorSubtypeMeta,
        errorSubtype.isAcceptableOrUnknown(
          data['error_subtype']!,
          _errorSubtypeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WordMarksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordMarksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      wordIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_index'],
      )!,
      expectedWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_word'],
      )!,
      actualWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actual_word'],
      ),
      mark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mark'],
      )!,
      errorSubtype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_subtype'],
      ),
    );
  }

  @override
  $WordMarksTableTable createAlias(String alias) {
    return $WordMarksTableTable(attachedDatabase, alias);
  }
}

class WordMarksTableData extends DataClass
    implements Insertable<WordMarksTableData> {
  final String id;
  final String checkId;
  final int wordIndex;
  final String expectedWord;
  final String? actualWord;
  final String mark;
  final String? errorSubtype;
  const WordMarksTableData({
    required this.id,
    required this.checkId,
    required this.wordIndex,
    required this.expectedWord,
    this.actualWord,
    required this.mark,
    this.errorSubtype,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['word_index'] = Variable<int>(wordIndex);
    map['expected_word'] = Variable<String>(expectedWord);
    if (!nullToAbsent || actualWord != null) {
      map['actual_word'] = Variable<String>(actualWord);
    }
    map['mark'] = Variable<String>(mark);
    if (!nullToAbsent || errorSubtype != null) {
      map['error_subtype'] = Variable<String>(errorSubtype);
    }
    return map;
  }

  WordMarksTableCompanion toCompanion(bool nullToAbsent) {
    return WordMarksTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      wordIndex: Value(wordIndex),
      expectedWord: Value(expectedWord),
      actualWord: actualWord == null && nullToAbsent
          ? const Value.absent()
          : Value(actualWord),
      mark: Value(mark),
      errorSubtype: errorSubtype == null && nullToAbsent
          ? const Value.absent()
          : Value(errorSubtype),
    );
  }

  factory WordMarksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordMarksTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      wordIndex: serializer.fromJson<int>(json['wordIndex']),
      expectedWord: serializer.fromJson<String>(json['expectedWord']),
      actualWord: serializer.fromJson<String?>(json['actualWord']),
      mark: serializer.fromJson<String>(json['mark']),
      errorSubtype: serializer.fromJson<String?>(json['errorSubtype']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'wordIndex': serializer.toJson<int>(wordIndex),
      'expectedWord': serializer.toJson<String>(expectedWord),
      'actualWord': serializer.toJson<String?>(actualWord),
      'mark': serializer.toJson<String>(mark),
      'errorSubtype': serializer.toJson<String?>(errorSubtype),
    };
  }

  WordMarksTableData copyWith({
    String? id,
    String? checkId,
    int? wordIndex,
    String? expectedWord,
    Value<String?> actualWord = const Value.absent(),
    String? mark,
    Value<String?> errorSubtype = const Value.absent(),
  }) => WordMarksTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    wordIndex: wordIndex ?? this.wordIndex,
    expectedWord: expectedWord ?? this.expectedWord,
    actualWord: actualWord.present ? actualWord.value : this.actualWord,
    mark: mark ?? this.mark,
    errorSubtype: errorSubtype.present ? errorSubtype.value : this.errorSubtype,
  );
  WordMarksTableData copyWithCompanion(WordMarksTableCompanion data) {
    return WordMarksTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      wordIndex: data.wordIndex.present ? data.wordIndex.value : this.wordIndex,
      expectedWord: data.expectedWord.present
          ? data.expectedWord.value
          : this.expectedWord,
      actualWord: data.actualWord.present
          ? data.actualWord.value
          : this.actualWord,
      mark: data.mark.present ? data.mark.value : this.mark,
      errorSubtype: data.errorSubtype.present
          ? data.errorSubtype.value
          : this.errorSubtype,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordMarksTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('wordIndex: $wordIndex, ')
          ..write('expectedWord: $expectedWord, ')
          ..write('actualWord: $actualWord, ')
          ..write('mark: $mark, ')
          ..write('errorSubtype: $errorSubtype')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    wordIndex,
    expectedWord,
    actualWord,
    mark,
    errorSubtype,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordMarksTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.wordIndex == this.wordIndex &&
          other.expectedWord == this.expectedWord &&
          other.actualWord == this.actualWord &&
          other.mark == this.mark &&
          other.errorSubtype == this.errorSubtype);
}

class WordMarksTableCompanion extends UpdateCompanion<WordMarksTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<int> wordIndex;
  final Value<String> expectedWord;
  final Value<String?> actualWord;
  final Value<String> mark;
  final Value<String?> errorSubtype;
  final Value<int> rowid;
  const WordMarksTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.wordIndex = const Value.absent(),
    this.expectedWord = const Value.absent(),
    this.actualWord = const Value.absent(),
    this.mark = const Value.absent(),
    this.errorSubtype = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordMarksTableCompanion.insert({
    required String id,
    required String checkId,
    required int wordIndex,
    required String expectedWord,
    this.actualWord = const Value.absent(),
    required String mark,
    this.errorSubtype = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       wordIndex = Value(wordIndex),
       expectedWord = Value(expectedWord),
       mark = Value(mark);
  static Insertable<WordMarksTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<int>? wordIndex,
    Expression<String>? expectedWord,
    Expression<String>? actualWord,
    Expression<String>? mark,
    Expression<String>? errorSubtype,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (wordIndex != null) 'word_index': wordIndex,
      if (expectedWord != null) 'expected_word': expectedWord,
      if (actualWord != null) 'actual_word': actualWord,
      if (mark != null) 'mark': mark,
      if (errorSubtype != null) 'error_subtype': errorSubtype,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordMarksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<int>? wordIndex,
    Value<String>? expectedWord,
    Value<String?>? actualWord,
    Value<String>? mark,
    Value<String?>? errorSubtype,
    Value<int>? rowid,
  }) {
    return WordMarksTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      wordIndex: wordIndex ?? this.wordIndex,
      expectedWord: expectedWord ?? this.expectedWord,
      actualWord: actualWord ?? this.actualWord,
      mark: mark ?? this.mark,
      errorSubtype: errorSubtype ?? this.errorSubtype,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (wordIndex.present) {
      map['word_index'] = Variable<int>(wordIndex.value);
    }
    if (expectedWord.present) {
      map['expected_word'] = Variable<String>(expectedWord.value);
    }
    if (actualWord.present) {
      map['actual_word'] = Variable<String>(actualWord.value);
    }
    if (mark.present) {
      map['mark'] = Variable<String>(mark.value);
    }
    if (errorSubtype.present) {
      map['error_subtype'] = Variable<String>(errorSubtype.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordMarksTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('wordIndex: $wordIndex, ')
          ..write('expectedWord: $expectedWord, ')
          ..write('actualWord: $actualWord, ')
          ..write('mark: $mark, ')
          ..write('errorSubtype: $errorSubtype, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RetellPointsTableTable extends RetellPointsTable
    with TableInfo<$RetellPointsTableTable, RetellPointsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetellPointsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointIndexMeta = const VerificationMeta(
    'pointIndex',
  );
  @override
  late final GeneratedColumn<int> pointIndex = GeneratedColumn<int>(
    'point_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointTextMeta = const VerificationMeta(
    'pointText',
  );
  @override
  late final GeneratedColumn<String> pointText = GeneratedColumn<String>(
    'point_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isMentionedMeta = const VerificationMeta(
    'isMentioned',
  );
  @override
  late final GeneratedColumn<bool> isMentioned = GeneratedColumn<bool>(
    'is_mentioned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mentioned" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    pointIndex,
    pointText,
    isMentioned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retell_points_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RetellPointsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('point_index')) {
      context.handle(
        _pointIndexMeta,
        pointIndex.isAcceptableOrUnknown(data['point_index']!, _pointIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pointIndexMeta);
    }
    if (data.containsKey('point_text')) {
      context.handle(
        _pointTextMeta,
        pointText.isAcceptableOrUnknown(data['point_text']!, _pointTextMeta),
      );
    } else if (isInserting) {
      context.missing(_pointTextMeta);
    }
    if (data.containsKey('is_mentioned')) {
      context.handle(
        _isMentionedMeta,
        isMentioned.isAcceptableOrUnknown(
          data['is_mentioned']!,
          _isMentionedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isMentionedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RetellPointsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RetellPointsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      pointIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_index'],
      )!,
      pointText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_text'],
      )!,
      isMentioned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mentioned'],
      )!,
    );
  }

  @override
  $RetellPointsTableTable createAlias(String alias) {
    return $RetellPointsTableTable(attachedDatabase, alias);
  }
}

class RetellPointsTableData extends DataClass
    implements Insertable<RetellPointsTableData> {
  final String id;
  final String checkId;
  final int pointIndex;
  final String pointText;
  final bool isMentioned;
  const RetellPointsTableData({
    required this.id,
    required this.checkId,
    required this.pointIndex,
    required this.pointText,
    required this.isMentioned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['point_index'] = Variable<int>(pointIndex);
    map['point_text'] = Variable<String>(pointText);
    map['is_mentioned'] = Variable<bool>(isMentioned);
    return map;
  }

  RetellPointsTableCompanion toCompanion(bool nullToAbsent) {
    return RetellPointsTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      pointIndex: Value(pointIndex),
      pointText: Value(pointText),
      isMentioned: Value(isMentioned),
    );
  }

  factory RetellPointsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RetellPointsTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      pointIndex: serializer.fromJson<int>(json['pointIndex']),
      pointText: serializer.fromJson<String>(json['pointText']),
      isMentioned: serializer.fromJson<bool>(json['isMentioned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'pointIndex': serializer.toJson<int>(pointIndex),
      'pointText': serializer.toJson<String>(pointText),
      'isMentioned': serializer.toJson<bool>(isMentioned),
    };
  }

  RetellPointsTableData copyWith({
    String? id,
    String? checkId,
    int? pointIndex,
    String? pointText,
    bool? isMentioned,
  }) => RetellPointsTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    pointIndex: pointIndex ?? this.pointIndex,
    pointText: pointText ?? this.pointText,
    isMentioned: isMentioned ?? this.isMentioned,
  );
  RetellPointsTableData copyWithCompanion(RetellPointsTableCompanion data) {
    return RetellPointsTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      pointIndex: data.pointIndex.present
          ? data.pointIndex.value
          : this.pointIndex,
      pointText: data.pointText.present ? data.pointText.value : this.pointText,
      isMentioned: data.isMentioned.present
          ? data.isMentioned.value
          : this.isMentioned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RetellPointsTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('pointIndex: $pointIndex, ')
          ..write('pointText: $pointText, ')
          ..write('isMentioned: $isMentioned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, checkId, pointIndex, pointText, isMentioned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RetellPointsTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.pointIndex == this.pointIndex &&
          other.pointText == this.pointText &&
          other.isMentioned == this.isMentioned);
}

class RetellPointsTableCompanion
    extends UpdateCompanion<RetellPointsTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<int> pointIndex;
  final Value<String> pointText;
  final Value<bool> isMentioned;
  final Value<int> rowid;
  const RetellPointsTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.pointIndex = const Value.absent(),
    this.pointText = const Value.absent(),
    this.isMentioned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RetellPointsTableCompanion.insert({
    required String id,
    required String checkId,
    required int pointIndex,
    required String pointText,
    required bool isMentioned,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       pointIndex = Value(pointIndex),
       pointText = Value(pointText),
       isMentioned = Value(isMentioned);
  static Insertable<RetellPointsTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<int>? pointIndex,
    Expression<String>? pointText,
    Expression<bool>? isMentioned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (pointIndex != null) 'point_index': pointIndex,
      if (pointText != null) 'point_text': pointText,
      if (isMentioned != null) 'is_mentioned': isMentioned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RetellPointsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<int>? pointIndex,
    Value<String>? pointText,
    Value<bool>? isMentioned,
    Value<int>? rowid,
  }) {
    return RetellPointsTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      pointIndex: pointIndex ?? this.pointIndex,
      pointText: pointText ?? this.pointText,
      isMentioned: isMentioned ?? this.isMentioned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (pointIndex.present) {
      map['point_index'] = Variable<int>(pointIndex.value);
    }
    if (pointText.present) {
      map['point_text'] = Variable<String>(pointText.value);
    }
    if (isMentioned.present) {
      map['is_mentioned'] = Variable<bool>(isMentioned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetellPointsTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('pointIndex: $pointIndex, ')
          ..write('pointText: $pointText, ')
          ..write('isMentioned: $isMentioned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionAnswersTableTable extends QuestionAnswersTable
    with TableInfo<$QuestionAnswersTableTable, QuestionAnswersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionAnswersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionTypeMeta = const VerificationMeta(
    'questionType',
  );
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
    'question_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerStatusMeta = const VerificationMeta(
    'answerStatus',
  );
  @override
  late final GeneratedColumn<String> answerStatus = GeneratedColumn<String>(
    'answer_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _timeMsMeta = const VerificationMeta('timeMs');
  @override
  late final GeneratedColumn<int> timeMs = GeneratedColumn<int>(
    'time_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _marksMeta = const VerificationMeta('marks');
  @override
  late final GeneratedColumn<double> marks = GeneratedColumn<double>(
    'marks',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxMarksMeta = const VerificationMeta(
    'maxMarks',
  );
  @override
  late final GeneratedColumn<double> maxMarks = GeneratedColumn<double>(
    'max_marks',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selfRatingMeta = const VerificationMeta(
    'selfRating',
  );
  @override
  late final GeneratedColumn<String> selfRating = GeneratedColumn<String>(
    'self_rating',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    questionId,
    questionType,
    answerStatus,
    level,
    timeMs,
    marks,
    maxMarks,
    selfRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_answers_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionAnswersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
        _questionTypeMeta,
        questionType.isAcceptableOrUnknown(
          data['question_type']!,
          _questionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('answer_status')) {
      context.handle(
        _answerStatusMeta,
        answerStatus.isAcceptableOrUnknown(
          data['answer_status']!,
          _answerStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answerStatusMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('time_ms')) {
      context.handle(
        _timeMsMeta,
        timeMs.isAcceptableOrUnknown(data['time_ms']!, _timeMsMeta),
      );
    }
    if (data.containsKey('marks')) {
      context.handle(
        _marksMeta,
        marks.isAcceptableOrUnknown(data['marks']!, _marksMeta),
      );
    }
    if (data.containsKey('max_marks')) {
      context.handle(
        _maxMarksMeta,
        maxMarks.isAcceptableOrUnknown(data['max_marks']!, _maxMarksMeta),
      );
    }
    if (data.containsKey('self_rating')) {
      context.handle(
        _selfRatingMeta,
        selfRating.isAcceptableOrUnknown(data['self_rating']!, _selfRatingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionAnswersTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionAnswersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      questionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_type'],
      )!,
      answerStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_status'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      timeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_ms'],
      ),
      marks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}marks'],
      ),
      maxMarks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_marks'],
      ),
      selfRating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}self_rating'],
      ),
    );
  }

  @override
  $QuestionAnswersTableTable createAlias(String alias) {
    return $QuestionAnswersTableTable(attachedDatabase, alias);
  }
}

class QuestionAnswersTableData extends DataClass
    implements Insertable<QuestionAnswersTableData> {
  final String id;
  final String checkId;
  final String questionId;
  final String questionType;
  final String answerStatus;
  final int level;
  final int? timeMs;
  final double? marks;
  final double? maxMarks;
  final String? selfRating;
  const QuestionAnswersTableData({
    required this.id,
    required this.checkId,
    required this.questionId,
    required this.questionType,
    required this.answerStatus,
    required this.level,
    this.timeMs,
    this.marks,
    this.maxMarks,
    this.selfRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['question_id'] = Variable<String>(questionId);
    map['question_type'] = Variable<String>(questionType);
    map['answer_status'] = Variable<String>(answerStatus);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || timeMs != null) {
      map['time_ms'] = Variable<int>(timeMs);
    }
    if (!nullToAbsent || marks != null) {
      map['marks'] = Variable<double>(marks);
    }
    if (!nullToAbsent || maxMarks != null) {
      map['max_marks'] = Variable<double>(maxMarks);
    }
    if (!nullToAbsent || selfRating != null) {
      map['self_rating'] = Variable<String>(selfRating);
    }
    return map;
  }

  QuestionAnswersTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionAnswersTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      questionId: Value(questionId),
      questionType: Value(questionType),
      answerStatus: Value(answerStatus),
      level: Value(level),
      timeMs: timeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(timeMs),
      marks: marks == null && nullToAbsent
          ? const Value.absent()
          : Value(marks),
      maxMarks: maxMarks == null && nullToAbsent
          ? const Value.absent()
          : Value(maxMarks),
      selfRating: selfRating == null && nullToAbsent
          ? const Value.absent()
          : Value(selfRating),
    );
  }

  factory QuestionAnswersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionAnswersTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      questionType: serializer.fromJson<String>(json['questionType']),
      answerStatus: serializer.fromJson<String>(json['answerStatus']),
      level: serializer.fromJson<int>(json['level']),
      timeMs: serializer.fromJson<int?>(json['timeMs']),
      marks: serializer.fromJson<double?>(json['marks']),
      maxMarks: serializer.fromJson<double?>(json['maxMarks']),
      selfRating: serializer.fromJson<String?>(json['selfRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'questionId': serializer.toJson<String>(questionId),
      'questionType': serializer.toJson<String>(questionType),
      'answerStatus': serializer.toJson<String>(answerStatus),
      'level': serializer.toJson<int>(level),
      'timeMs': serializer.toJson<int?>(timeMs),
      'marks': serializer.toJson<double?>(marks),
      'maxMarks': serializer.toJson<double?>(maxMarks),
      'selfRating': serializer.toJson<String?>(selfRating),
    };
  }

  QuestionAnswersTableData copyWith({
    String? id,
    String? checkId,
    String? questionId,
    String? questionType,
    String? answerStatus,
    int? level,
    Value<int?> timeMs = const Value.absent(),
    Value<double?> marks = const Value.absent(),
    Value<double?> maxMarks = const Value.absent(),
    Value<String?> selfRating = const Value.absent(),
  }) => QuestionAnswersTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    questionId: questionId ?? this.questionId,
    questionType: questionType ?? this.questionType,
    answerStatus: answerStatus ?? this.answerStatus,
    level: level ?? this.level,
    timeMs: timeMs.present ? timeMs.value : this.timeMs,
    marks: marks.present ? marks.value : this.marks,
    maxMarks: maxMarks.present ? maxMarks.value : this.maxMarks,
    selfRating: selfRating.present ? selfRating.value : this.selfRating,
  );
  QuestionAnswersTableData copyWithCompanion(
    QuestionAnswersTableCompanion data,
  ) {
    return QuestionAnswersTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      answerStatus: data.answerStatus.present
          ? data.answerStatus.value
          : this.answerStatus,
      level: data.level.present ? data.level.value : this.level,
      timeMs: data.timeMs.present ? data.timeMs.value : this.timeMs,
      marks: data.marks.present ? data.marks.value : this.marks,
      maxMarks: data.maxMarks.present ? data.maxMarks.value : this.maxMarks,
      selfRating: data.selfRating.present
          ? data.selfRating.value
          : this.selfRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionAnswersTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('questionId: $questionId, ')
          ..write('questionType: $questionType, ')
          ..write('answerStatus: $answerStatus, ')
          ..write('level: $level, ')
          ..write('timeMs: $timeMs, ')
          ..write('marks: $marks, ')
          ..write('maxMarks: $maxMarks, ')
          ..write('selfRating: $selfRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    questionId,
    questionType,
    answerStatus,
    level,
    timeMs,
    marks,
    maxMarks,
    selfRating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionAnswersTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.questionId == this.questionId &&
          other.questionType == this.questionType &&
          other.answerStatus == this.answerStatus &&
          other.level == this.level &&
          other.timeMs == this.timeMs &&
          other.marks == this.marks &&
          other.maxMarks == this.maxMarks &&
          other.selfRating == this.selfRating);
}

class QuestionAnswersTableCompanion
    extends UpdateCompanion<QuestionAnswersTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<String> questionId;
  final Value<String> questionType;
  final Value<String> answerStatus;
  final Value<int> level;
  final Value<int?> timeMs;
  final Value<double?> marks;
  final Value<double?> maxMarks;
  final Value<String?> selfRating;
  final Value<int> rowid;
  const QuestionAnswersTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.questionType = const Value.absent(),
    this.answerStatus = const Value.absent(),
    this.level = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.marks = const Value.absent(),
    this.maxMarks = const Value.absent(),
    this.selfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionAnswersTableCompanion.insert({
    required String id,
    required String checkId,
    required String questionId,
    required String questionType,
    required String answerStatus,
    this.level = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.marks = const Value.absent(),
    this.maxMarks = const Value.absent(),
    this.selfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       questionId = Value(questionId),
       questionType = Value(questionType),
       answerStatus = Value(answerStatus);
  static Insertable<QuestionAnswersTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<String>? questionId,
    Expression<String>? questionType,
    Expression<String>? answerStatus,
    Expression<int>? level,
    Expression<int>? timeMs,
    Expression<double>? marks,
    Expression<double>? maxMarks,
    Expression<String>? selfRating,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (questionId != null) 'question_id': questionId,
      if (questionType != null) 'question_type': questionType,
      if (answerStatus != null) 'answer_status': answerStatus,
      if (level != null) 'level': level,
      if (timeMs != null) 'time_ms': timeMs,
      if (marks != null) 'marks': marks,
      if (maxMarks != null) 'max_marks': maxMarks,
      if (selfRating != null) 'self_rating': selfRating,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionAnswersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<String>? questionId,
    Value<String>? questionType,
    Value<String>? answerStatus,
    Value<int>? level,
    Value<int?>? timeMs,
    Value<double?>? marks,
    Value<double?>? maxMarks,
    Value<String?>? selfRating,
    Value<int>? rowid,
  }) {
    return QuestionAnswersTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      questionId: questionId ?? this.questionId,
      questionType: questionType ?? this.questionType,
      answerStatus: answerStatus ?? this.answerStatus,
      level: level ?? this.level,
      timeMs: timeMs ?? this.timeMs,
      marks: marks ?? this.marks,
      maxMarks: maxMarks ?? this.maxMarks,
      selfRating: selfRating ?? this.selfRating,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (answerStatus.present) {
      map['answer_status'] = Variable<String>(answerStatus.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (timeMs.present) {
      map['time_ms'] = Variable<int>(timeMs.value);
    }
    if (marks.present) {
      map['marks'] = Variable<double>(marks.value);
    }
    if (maxMarks.present) {
      map['max_marks'] = Variable<double>(maxMarks.value);
    }
    if (selfRating.present) {
      map['self_rating'] = Variable<String>(selfRating.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionAnswersTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('questionId: $questionId, ')
          ..write('questionType: $questionType, ')
          ..write('answerStatus: $answerStatus, ')
          ..write('level: $level, ')
          ..write('timeMs: $timeMs, ')
          ..write('marks: $marks, ')
          ..write('maxMarks: $maxMarks, ')
          ..write('selfRating: $selfRating, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DictationItemsTableTable extends DictationItemsTable
    with TableInfo<$DictationItemsTableTable, DictationItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictationItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIndexMeta = const VerificationMeta(
    'itemIndex',
  );
  @override
  late final GeneratedColumn<int> itemIndex = GeneratedColumn<int>(
    'item_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isSkippedMeta = const VerificationMeta(
    'isSkipped',
  );
  @override
  late final GeneratedColumn<bool> isSkipped = GeneratedColumn<bool>(
    'is_skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _errorTypeMeta = const VerificationMeta(
    'errorType',
  );
  @override
  late final GeneratedColumn<String> errorType = GeneratedColumn<String>(
    'error_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    itemIndex,
    word,
    isCorrect,
    isSkipped,
    errorType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictation_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DictationItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('item_index')) {
      context.handle(
        _itemIndexMeta,
        itemIndex.isAcceptableOrUnknown(data['item_index']!, _itemIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIndexMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('is_skipped')) {
      context.handle(
        _isSkippedMeta,
        isSkipped.isAcceptableOrUnknown(data['is_skipped']!, _isSkippedMeta),
      );
    }
    if (data.containsKey('error_type')) {
      context.handle(
        _errorTypeMeta,
        errorType.isAcceptableOrUnknown(data['error_type']!, _errorTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DictationItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictationItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      itemIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_index'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      isSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_skipped'],
      )!,
      errorType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_type'],
      ),
    );
  }

  @override
  $DictationItemsTableTable createAlias(String alias) {
    return $DictationItemsTableTable(attachedDatabase, alias);
  }
}

class DictationItemsTableData extends DataClass
    implements Insertable<DictationItemsTableData> {
  final String id;
  final String checkId;
  final int itemIndex;
  final String word;
  final bool isCorrect;
  final bool isSkipped;
  final String? errorType;
  const DictationItemsTableData({
    required this.id,
    required this.checkId,
    required this.itemIndex,
    required this.word,
    required this.isCorrect,
    required this.isSkipped,
    this.errorType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['item_index'] = Variable<int>(itemIndex);
    map['word'] = Variable<String>(word);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['is_skipped'] = Variable<bool>(isSkipped);
    if (!nullToAbsent || errorType != null) {
      map['error_type'] = Variable<String>(errorType);
    }
    return map;
  }

  DictationItemsTableCompanion toCompanion(bool nullToAbsent) {
    return DictationItemsTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      itemIndex: Value(itemIndex),
      word: Value(word),
      isCorrect: Value(isCorrect),
      isSkipped: Value(isSkipped),
      errorType: errorType == null && nullToAbsent
          ? const Value.absent()
          : Value(errorType),
    );
  }

  factory DictationItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictationItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      itemIndex: serializer.fromJson<int>(json['itemIndex']),
      word: serializer.fromJson<String>(json['word']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      isSkipped: serializer.fromJson<bool>(json['isSkipped']),
      errorType: serializer.fromJson<String?>(json['errorType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'itemIndex': serializer.toJson<int>(itemIndex),
      'word': serializer.toJson<String>(word),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'isSkipped': serializer.toJson<bool>(isSkipped),
      'errorType': serializer.toJson<String?>(errorType),
    };
  }

  DictationItemsTableData copyWith({
    String? id,
    String? checkId,
    int? itemIndex,
    String? word,
    bool? isCorrect,
    bool? isSkipped,
    Value<String?> errorType = const Value.absent(),
  }) => DictationItemsTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    itemIndex: itemIndex ?? this.itemIndex,
    word: word ?? this.word,
    isCorrect: isCorrect ?? this.isCorrect,
    isSkipped: isSkipped ?? this.isSkipped,
    errorType: errorType.present ? errorType.value : this.errorType,
  );
  DictationItemsTableData copyWithCompanion(DictationItemsTableCompanion data) {
    return DictationItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      itemIndex: data.itemIndex.present ? data.itemIndex.value : this.itemIndex,
      word: data.word.present ? data.word.value : this.word,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      isSkipped: data.isSkipped.present ? data.isSkipped.value : this.isSkipped,
      errorType: data.errorType.present ? data.errorType.value : this.errorType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictationItemsTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('itemIndex: $itemIndex, ')
          ..write('word: $word, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('isSkipped: $isSkipped, ')
          ..write('errorType: $errorType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    itemIndex,
    word,
    isCorrect,
    isSkipped,
    errorType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictationItemsTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.itemIndex == this.itemIndex &&
          other.word == this.word &&
          other.isCorrect == this.isCorrect &&
          other.isSkipped == this.isSkipped &&
          other.errorType == this.errorType);
}

class DictationItemsTableCompanion
    extends UpdateCompanion<DictationItemsTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<int> itemIndex;
  final Value<String> word;
  final Value<bool> isCorrect;
  final Value<bool> isSkipped;
  final Value<String?> errorType;
  final Value<int> rowid;
  const DictationItemsTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.itemIndex = const Value.absent(),
    this.word = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.isSkipped = const Value.absent(),
    this.errorType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DictationItemsTableCompanion.insert({
    required String id,
    required String checkId,
    required int itemIndex,
    required String word,
    required bool isCorrect,
    this.isSkipped = const Value.absent(),
    this.errorType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       itemIndex = Value(itemIndex),
       word = Value(word),
       isCorrect = Value(isCorrect);
  static Insertable<DictationItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<int>? itemIndex,
    Expression<String>? word,
    Expression<bool>? isCorrect,
    Expression<bool>? isSkipped,
    Expression<String>? errorType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (itemIndex != null) 'item_index': itemIndex,
      if (word != null) 'word': word,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (isSkipped != null) 'is_skipped': isSkipped,
      if (errorType != null) 'error_type': errorType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DictationItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<int>? itemIndex,
    Value<String>? word,
    Value<bool>? isCorrect,
    Value<bool>? isSkipped,
    Value<String?>? errorType,
    Value<int>? rowid,
  }) {
    return DictationItemsTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      itemIndex: itemIndex ?? this.itemIndex,
      word: word ?? this.word,
      isCorrect: isCorrect ?? this.isCorrect,
      isSkipped: isSkipped ?? this.isSkipped,
      errorType: errorType ?? this.errorType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (itemIndex.present) {
      map['item_index'] = Variable<int>(itemIndex.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (isSkipped.present) {
      map['is_skipped'] = Variable<bool>(isSkipped.value);
    }
    if (errorType.present) {
      map['error_type'] = Variable<String>(errorType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictationItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('itemIndex: $itemIndex, ')
          ..write('word: $word, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('isSkipped: $isSkipped, ')
          ..write('errorType: $errorType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListeningChecksTableTable extends ListeningChecksTable
    with TableInfo<$ListeningChecksTableTable, ListeningChecksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListeningChecksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOfferedMeta = const VerificationMeta(
    'isOffered',
  );
  @override
  late final GeneratedColumn<bool> isOffered = GeneratedColumn<bool>(
    'is_offered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_offered" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _pointsEarnedMeta = const VerificationMeta(
    'pointsEarned',
  );
  @override
  late final GeneratedColumn<int> pointsEarned = GeneratedColumn<int>(
    'points_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    isOffered,
    isCompleted,
    pointsEarned,
    totalPoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listening_checks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ListeningChecksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('is_offered')) {
      context.handle(
        _isOfferedMeta,
        isOffered.isAcceptableOrUnknown(data['is_offered']!, _isOfferedMeta),
      );
    } else if (isInserting) {
      context.missing(_isOfferedMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('points_earned')) {
      context.handle(
        _pointsEarnedMeta,
        pointsEarned.isAcceptableOrUnknown(
          data['points_earned']!,
          _pointsEarnedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointsEarnedMeta);
    }
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListeningChecksTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListeningChecksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      isOffered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_offered'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      pointsEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_earned'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
    );
  }

  @override
  $ListeningChecksTableTable createAlias(String alias) {
    return $ListeningChecksTableTable(attachedDatabase, alias);
  }
}

class ListeningChecksTableData extends DataClass
    implements Insertable<ListeningChecksTableData> {
  final String id;
  final String checkId;
  final bool isOffered;
  final bool isCompleted;
  final int pointsEarned;
  final int totalPoints;
  const ListeningChecksTableData({
    required this.id,
    required this.checkId,
    required this.isOffered,
    required this.isCompleted,
    required this.pointsEarned,
    required this.totalPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['is_offered'] = Variable<bool>(isOffered);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['points_earned'] = Variable<int>(pointsEarned);
    map['total_points'] = Variable<int>(totalPoints);
    return map;
  }

  ListeningChecksTableCompanion toCompanion(bool nullToAbsent) {
    return ListeningChecksTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      isOffered: Value(isOffered),
      isCompleted: Value(isCompleted),
      pointsEarned: Value(pointsEarned),
      totalPoints: Value(totalPoints),
    );
  }

  factory ListeningChecksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListeningChecksTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      isOffered: serializer.fromJson<bool>(json['isOffered']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      pointsEarned: serializer.fromJson<int>(json['pointsEarned']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'isOffered': serializer.toJson<bool>(isOffered),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'pointsEarned': serializer.toJson<int>(pointsEarned),
      'totalPoints': serializer.toJson<int>(totalPoints),
    };
  }

  ListeningChecksTableData copyWith({
    String? id,
    String? checkId,
    bool? isOffered,
    bool? isCompleted,
    int? pointsEarned,
    int? totalPoints,
  }) => ListeningChecksTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    isOffered: isOffered ?? this.isOffered,
    isCompleted: isCompleted ?? this.isCompleted,
    pointsEarned: pointsEarned ?? this.pointsEarned,
    totalPoints: totalPoints ?? this.totalPoints,
  );
  ListeningChecksTableData copyWithCompanion(
    ListeningChecksTableCompanion data,
  ) {
    return ListeningChecksTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      isOffered: data.isOffered.present ? data.isOffered.value : this.isOffered,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      pointsEarned: data.pointsEarned.present
          ? data.pointsEarned.value
          : this.pointsEarned,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListeningChecksTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('isOffered: $isOffered, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('pointsEarned: $pointsEarned, ')
          ..write('totalPoints: $totalPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    isOffered,
    isCompleted,
    pointsEarned,
    totalPoints,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListeningChecksTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.isOffered == this.isOffered &&
          other.isCompleted == this.isCompleted &&
          other.pointsEarned == this.pointsEarned &&
          other.totalPoints == this.totalPoints);
}

class ListeningChecksTableCompanion
    extends UpdateCompanion<ListeningChecksTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<bool> isOffered;
  final Value<bool> isCompleted;
  final Value<int> pointsEarned;
  final Value<int> totalPoints;
  final Value<int> rowid;
  const ListeningChecksTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.isOffered = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.pointsEarned = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ListeningChecksTableCompanion.insert({
    required String id,
    required String checkId,
    required bool isOffered,
    required bool isCompleted,
    required int pointsEarned,
    required int totalPoints,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       isOffered = Value(isOffered),
       isCompleted = Value(isCompleted),
       pointsEarned = Value(pointsEarned),
       totalPoints = Value(totalPoints);
  static Insertable<ListeningChecksTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<bool>? isOffered,
    Expression<bool>? isCompleted,
    Expression<int>? pointsEarned,
    Expression<int>? totalPoints,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (isOffered != null) 'is_offered': isOffered,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (pointsEarned != null) 'points_earned': pointsEarned,
      if (totalPoints != null) 'total_points': totalPoints,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ListeningChecksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<bool>? isOffered,
    Value<bool>? isCompleted,
    Value<int>? pointsEarned,
    Value<int>? totalPoints,
    Value<int>? rowid,
  }) {
    return ListeningChecksTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      isOffered: isOffered ?? this.isOffered,
      isCompleted: isCompleted ?? this.isCompleted,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      totalPoints: totalPoints ?? this.totalPoints,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (isOffered.present) {
      map['is_offered'] = Variable<bool>(isOffered.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (pointsEarned.present) {
      map['points_earned'] = Variable<int>(pointsEarned.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListeningChecksTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('isOffered: $isOffered, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('pointsEarned: $pointsEarned, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ResultsTableTable extends ResultsTable
    with TableInfo<$ResultsTableTable, ResultsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupAssignedMeta = const VerificationMeta(
    'groupAssigned',
  );
  @override
  late final GeneratedColumn<String> groupAssigned = GeneratedColumn<String>(
    'group_assigned',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupReasonMeta = const VerificationMeta(
    'groupReason',
  );
  @override
  late final GeneratedColumn<String> groupReason = GeneratedColumn<String>(
    'group_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextStepRecommendationMeta =
      const VerificationMeta('nextStepRecommendation');
  @override
  late final GeneratedColumn<String> nextStepRecommendation =
      GeneratedColumn<String>(
        'next_step_recommendation',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalWordsMeta = const VerificationMeta(
    'totalWords',
  );
  @override
  late final GeneratedColumn<int> totalWords = GeneratedColumn<int>(
    'total_words',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptedWordsMeta = const VerificationMeta(
    'attemptedWords',
  );
  @override
  late final GeneratedColumn<int> attemptedWords = GeneratedColumn<int>(
    'attempted_words',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctWordsMeta = const VerificationMeta(
    'correctWords',
  );
  @override
  late final GeneratedColumn<int> correctWords = GeneratedColumn<int>(
    'correct_words',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyPercentageMeta =
      const VerificationMeta('accuracyPercentage');
  @override
  late final GeneratedColumn<double> accuracyPercentage =
      GeneratedColumn<double>(
        'accuracy_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _readingSpeedWpmMeta = const VerificationMeta(
    'readingSpeedWpm',
  );
  @override
  late final GeneratedColumn<double> readingSpeedWpm = GeneratedColumn<double>(
    'reading_speed_wpm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedHasEvidenceMeta = const VerificationMeta(
    'speedHasEvidence',
  );
  @override
  late final GeneratedColumn<bool> speedHasEvidence = GeneratedColumn<bool>(
    'speed_has_evidence',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("speed_has_evidence" IN (0, 1))',
    ),
  );
  static const VerificationMeta _speedTargetOfficialMeta =
      const VerificationMeta('speedTargetOfficial');
  @override
  late final GeneratedColumn<String> speedTargetOfficial =
      GeneratedColumn<String>(
        'speed_target_official',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _comprehensionFactScoreMeta =
      const VerificationMeta('comprehensionFactScore');
  @override
  late final GeneratedColumn<String> comprehensionFactScore =
      GeneratedColumn<String>(
        'comprehension_fact_score',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _retellScoreMeta = const VerificationMeta(
    'retellScore',
  );
  @override
  late final GeneratedColumn<String> retellScore = GeneratedColumn<String>(
    'retell_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dictationScoreMeta = const VerificationMeta(
    'dictationScore',
  );
  @override
  late final GeneratedColumn<String> dictationScore = GeneratedColumn<String>(
    'dictation_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stuckOnAksharasJsonMeta =
      const VerificationMeta('stuckOnAksharasJson');
  @override
  late final GeneratedColumn<String> stuckOnAksharasJson =
      GeneratedColumn<String>(
        'stuck_on_aksharas_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _typingScoreMeta = const VerificationMeta(
    'typingScore',
  );
  @override
  late final GeneratedColumn<String> typingScore = GeneratedColumn<String>(
    'typing_score',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selfRatingSummaryJsonMeta =
      const VerificationMeta('selfRatingSummaryJson');
  @override
  late final GeneratedColumn<String> selfRatingSummaryJson =
      GeneratedColumn<String>(
        'self_rating_summary_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isLowConfidenceMeta = const VerificationMeta(
    'isLowConfidence',
  );
  @override
  late final GeneratedColumn<bool> isLowConfidence = GeneratedColumn<bool>(
    'is_low_confidence',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_low_confidence" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    childId,
    scope,
    groupAssigned,
    groupReason,
    nextStepRecommendation,
    totalWords,
    attemptedWords,
    correctWords,
    accuracyPercentage,
    readingSpeedWpm,
    speedHasEvidence,
    speedTargetOfficial,
    comprehensionFactScore,
    retellScore,
    dictationScore,
    stuckOnAksharasJson,
    typingScore,
    selfRatingSummaryJson,
    isLowConfidence,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'results_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResultsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('group_assigned')) {
      context.handle(
        _groupAssignedMeta,
        groupAssigned.isAcceptableOrUnknown(
          data['group_assigned']!,
          _groupAssignedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_groupAssignedMeta);
    }
    if (data.containsKey('group_reason')) {
      context.handle(
        _groupReasonMeta,
        groupReason.isAcceptableOrUnknown(
          data['group_reason']!,
          _groupReasonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_groupReasonMeta);
    }
    if (data.containsKey('next_step_recommendation')) {
      context.handle(
        _nextStepRecommendationMeta,
        nextStepRecommendation.isAcceptableOrUnknown(
          data['next_step_recommendation']!,
          _nextStepRecommendationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextStepRecommendationMeta);
    }
    if (data.containsKey('total_words')) {
      context.handle(
        _totalWordsMeta,
        totalWords.isAcceptableOrUnknown(data['total_words']!, _totalWordsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalWordsMeta);
    }
    if (data.containsKey('attempted_words')) {
      context.handle(
        _attemptedWordsMeta,
        attemptedWords.isAcceptableOrUnknown(
          data['attempted_words']!,
          _attemptedWordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedWordsMeta);
    }
    if (data.containsKey('correct_words')) {
      context.handle(
        _correctWordsMeta,
        correctWords.isAcceptableOrUnknown(
          data['correct_words']!,
          _correctWordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctWordsMeta);
    }
    if (data.containsKey('accuracy_percentage')) {
      context.handle(
        _accuracyPercentageMeta,
        accuracyPercentage.isAcceptableOrUnknown(
          data['accuracy_percentage']!,
          _accuracyPercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accuracyPercentageMeta);
    }
    if (data.containsKey('reading_speed_wpm')) {
      context.handle(
        _readingSpeedWpmMeta,
        readingSpeedWpm.isAcceptableOrUnknown(
          data['reading_speed_wpm']!,
          _readingSpeedWpmMeta,
        ),
      );
    }
    if (data.containsKey('speed_has_evidence')) {
      context.handle(
        _speedHasEvidenceMeta,
        speedHasEvidence.isAcceptableOrUnknown(
          data['speed_has_evidence']!,
          _speedHasEvidenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_speedHasEvidenceMeta);
    }
    if (data.containsKey('speed_target_official')) {
      context.handle(
        _speedTargetOfficialMeta,
        speedTargetOfficial.isAcceptableOrUnknown(
          data['speed_target_official']!,
          _speedTargetOfficialMeta,
        ),
      );
    }
    if (data.containsKey('comprehension_fact_score')) {
      context.handle(
        _comprehensionFactScoreMeta,
        comprehensionFactScore.isAcceptableOrUnknown(
          data['comprehension_fact_score']!,
          _comprehensionFactScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_comprehensionFactScoreMeta);
    }
    if (data.containsKey('retell_score')) {
      context.handle(
        _retellScoreMeta,
        retellScore.isAcceptableOrUnknown(
          data['retell_score']!,
          _retellScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_retellScoreMeta);
    }
    if (data.containsKey('dictation_score')) {
      context.handle(
        _dictationScoreMeta,
        dictationScore.isAcceptableOrUnknown(
          data['dictation_score']!,
          _dictationScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dictationScoreMeta);
    }
    if (data.containsKey('stuck_on_aksharas_json')) {
      context.handle(
        _stuckOnAksharasJsonMeta,
        stuckOnAksharasJson.isAcceptableOrUnknown(
          data['stuck_on_aksharas_json']!,
          _stuckOnAksharasJsonMeta,
        ),
      );
    }
    if (data.containsKey('typing_score')) {
      context.handle(
        _typingScoreMeta,
        typingScore.isAcceptableOrUnknown(
          data['typing_score']!,
          _typingScoreMeta,
        ),
      );
    }
    if (data.containsKey('self_rating_summary_json')) {
      context.handle(
        _selfRatingSummaryJsonMeta,
        selfRatingSummaryJson.isAcceptableOrUnknown(
          data['self_rating_summary_json']!,
          _selfRatingSummaryJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_low_confidence')) {
      context.handle(
        _isLowConfidenceMeta,
        isLowConfidence.isAcceptableOrUnknown(
          data['is_low_confidence']!,
          _isLowConfidenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isLowConfidenceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResultsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResultsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      groupAssigned: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_assigned'],
      )!,
      groupReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_reason'],
      )!,
      nextStepRecommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_step_recommendation'],
      )!,
      totalWords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_words'],
      )!,
      attemptedWords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempted_words'],
      )!,
      correctWords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_words'],
      )!,
      accuracyPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_percentage'],
      )!,
      readingSpeedWpm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_speed_wpm'],
      ),
      speedHasEvidence: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}speed_has_evidence'],
      )!,
      speedTargetOfficial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}speed_target_official'],
      ),
      comprehensionFactScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comprehension_fact_score'],
      )!,
      retellScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}retell_score'],
      )!,
      dictationScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dictation_score'],
      )!,
      stuckOnAksharasJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stuck_on_aksharas_json'],
      ),
      typingScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}typing_score'],
      ),
      selfRatingSummaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}self_rating_summary_json'],
      ),
      isLowConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_low_confidence'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ResultsTableTable createAlias(String alias) {
    return $ResultsTableTable(attachedDatabase, alias);
  }
}

class ResultsTableData extends DataClass
    implements Insertable<ResultsTableData> {
  final String id;
  final String checkId;
  final String childId;
  final String scope;
  final String groupAssigned;
  final String groupReason;
  final String nextStepRecommendation;
  final int totalWords;
  final int attemptedWords;
  final int correctWords;
  final double accuracyPercentage;
  final double? readingSpeedWpm;
  final bool speedHasEvidence;
  final String? speedTargetOfficial;
  final String comprehensionFactScore;
  final String retellScore;
  final String dictationScore;
  final String? stuckOnAksharasJson;
  final String? typingScore;
  final String? selfRatingSummaryJson;
  final bool isLowConfidence;
  final DateTime createdAt;
  const ResultsTableData({
    required this.id,
    required this.checkId,
    required this.childId,
    required this.scope,
    required this.groupAssigned,
    required this.groupReason,
    required this.nextStepRecommendation,
    required this.totalWords,
    required this.attemptedWords,
    required this.correctWords,
    required this.accuracyPercentage,
    this.readingSpeedWpm,
    required this.speedHasEvidence,
    this.speedTargetOfficial,
    required this.comprehensionFactScore,
    required this.retellScore,
    required this.dictationScore,
    this.stuckOnAksharasJson,
    this.typingScore,
    this.selfRatingSummaryJson,
    required this.isLowConfidence,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['child_id'] = Variable<String>(childId);
    map['scope'] = Variable<String>(scope);
    map['group_assigned'] = Variable<String>(groupAssigned);
    map['group_reason'] = Variable<String>(groupReason);
    map['next_step_recommendation'] = Variable<String>(nextStepRecommendation);
    map['total_words'] = Variable<int>(totalWords);
    map['attempted_words'] = Variable<int>(attemptedWords);
    map['correct_words'] = Variable<int>(correctWords);
    map['accuracy_percentage'] = Variable<double>(accuracyPercentage);
    if (!nullToAbsent || readingSpeedWpm != null) {
      map['reading_speed_wpm'] = Variable<double>(readingSpeedWpm);
    }
    map['speed_has_evidence'] = Variable<bool>(speedHasEvidence);
    if (!nullToAbsent || speedTargetOfficial != null) {
      map['speed_target_official'] = Variable<String>(speedTargetOfficial);
    }
    map['comprehension_fact_score'] = Variable<String>(comprehensionFactScore);
    map['retell_score'] = Variable<String>(retellScore);
    map['dictation_score'] = Variable<String>(dictationScore);
    if (!nullToAbsent || stuckOnAksharasJson != null) {
      map['stuck_on_aksharas_json'] = Variable<String>(stuckOnAksharasJson);
    }
    if (!nullToAbsent || typingScore != null) {
      map['typing_score'] = Variable<String>(typingScore);
    }
    if (!nullToAbsent || selfRatingSummaryJson != null) {
      map['self_rating_summary_json'] = Variable<String>(selfRatingSummaryJson);
    }
    map['is_low_confidence'] = Variable<bool>(isLowConfidence);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ResultsTableCompanion toCompanion(bool nullToAbsent) {
    return ResultsTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      childId: Value(childId),
      scope: Value(scope),
      groupAssigned: Value(groupAssigned),
      groupReason: Value(groupReason),
      nextStepRecommendation: Value(nextStepRecommendation),
      totalWords: Value(totalWords),
      attemptedWords: Value(attemptedWords),
      correctWords: Value(correctWords),
      accuracyPercentage: Value(accuracyPercentage),
      readingSpeedWpm: readingSpeedWpm == null && nullToAbsent
          ? const Value.absent()
          : Value(readingSpeedWpm),
      speedHasEvidence: Value(speedHasEvidence),
      speedTargetOfficial: speedTargetOfficial == null && nullToAbsent
          ? const Value.absent()
          : Value(speedTargetOfficial),
      comprehensionFactScore: Value(comprehensionFactScore),
      retellScore: Value(retellScore),
      dictationScore: Value(dictationScore),
      stuckOnAksharasJson: stuckOnAksharasJson == null && nullToAbsent
          ? const Value.absent()
          : Value(stuckOnAksharasJson),
      typingScore: typingScore == null && nullToAbsent
          ? const Value.absent()
          : Value(typingScore),
      selfRatingSummaryJson: selfRatingSummaryJson == null && nullToAbsent
          ? const Value.absent()
          : Value(selfRatingSummaryJson),
      isLowConfidence: Value(isLowConfidence),
      createdAt: Value(createdAt),
    );
  }

  factory ResultsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResultsTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      childId: serializer.fromJson<String>(json['childId']),
      scope: serializer.fromJson<String>(json['scope']),
      groupAssigned: serializer.fromJson<String>(json['groupAssigned']),
      groupReason: serializer.fromJson<String>(json['groupReason']),
      nextStepRecommendation: serializer.fromJson<String>(
        json['nextStepRecommendation'],
      ),
      totalWords: serializer.fromJson<int>(json['totalWords']),
      attemptedWords: serializer.fromJson<int>(json['attemptedWords']),
      correctWords: serializer.fromJson<int>(json['correctWords']),
      accuracyPercentage: serializer.fromJson<double>(
        json['accuracyPercentage'],
      ),
      readingSpeedWpm: serializer.fromJson<double?>(json['readingSpeedWpm']),
      speedHasEvidence: serializer.fromJson<bool>(json['speedHasEvidence']),
      speedTargetOfficial: serializer.fromJson<String?>(
        json['speedTargetOfficial'],
      ),
      comprehensionFactScore: serializer.fromJson<String>(
        json['comprehensionFactScore'],
      ),
      retellScore: serializer.fromJson<String>(json['retellScore']),
      dictationScore: serializer.fromJson<String>(json['dictationScore']),
      stuckOnAksharasJson: serializer.fromJson<String?>(
        json['stuckOnAksharasJson'],
      ),
      typingScore: serializer.fromJson<String?>(json['typingScore']),
      selfRatingSummaryJson: serializer.fromJson<String?>(
        json['selfRatingSummaryJson'],
      ),
      isLowConfidence: serializer.fromJson<bool>(json['isLowConfidence']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'childId': serializer.toJson<String>(childId),
      'scope': serializer.toJson<String>(scope),
      'groupAssigned': serializer.toJson<String>(groupAssigned),
      'groupReason': serializer.toJson<String>(groupReason),
      'nextStepRecommendation': serializer.toJson<String>(
        nextStepRecommendation,
      ),
      'totalWords': serializer.toJson<int>(totalWords),
      'attemptedWords': serializer.toJson<int>(attemptedWords),
      'correctWords': serializer.toJson<int>(correctWords),
      'accuracyPercentage': serializer.toJson<double>(accuracyPercentage),
      'readingSpeedWpm': serializer.toJson<double?>(readingSpeedWpm),
      'speedHasEvidence': serializer.toJson<bool>(speedHasEvidence),
      'speedTargetOfficial': serializer.toJson<String?>(speedTargetOfficial),
      'comprehensionFactScore': serializer.toJson<String>(
        comprehensionFactScore,
      ),
      'retellScore': serializer.toJson<String>(retellScore),
      'dictationScore': serializer.toJson<String>(dictationScore),
      'stuckOnAksharasJson': serializer.toJson<String?>(stuckOnAksharasJson),
      'typingScore': serializer.toJson<String?>(typingScore),
      'selfRatingSummaryJson': serializer.toJson<String?>(
        selfRatingSummaryJson,
      ),
      'isLowConfidence': serializer.toJson<bool>(isLowConfidence),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ResultsTableData copyWith({
    String? id,
    String? checkId,
    String? childId,
    String? scope,
    String? groupAssigned,
    String? groupReason,
    String? nextStepRecommendation,
    int? totalWords,
    int? attemptedWords,
    int? correctWords,
    double? accuracyPercentage,
    Value<double?> readingSpeedWpm = const Value.absent(),
    bool? speedHasEvidence,
    Value<String?> speedTargetOfficial = const Value.absent(),
    String? comprehensionFactScore,
    String? retellScore,
    String? dictationScore,
    Value<String?> stuckOnAksharasJson = const Value.absent(),
    Value<String?> typingScore = const Value.absent(),
    Value<String?> selfRatingSummaryJson = const Value.absent(),
    bool? isLowConfidence,
    DateTime? createdAt,
  }) => ResultsTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    childId: childId ?? this.childId,
    scope: scope ?? this.scope,
    groupAssigned: groupAssigned ?? this.groupAssigned,
    groupReason: groupReason ?? this.groupReason,
    nextStepRecommendation:
        nextStepRecommendation ?? this.nextStepRecommendation,
    totalWords: totalWords ?? this.totalWords,
    attemptedWords: attemptedWords ?? this.attemptedWords,
    correctWords: correctWords ?? this.correctWords,
    accuracyPercentage: accuracyPercentage ?? this.accuracyPercentage,
    readingSpeedWpm: readingSpeedWpm.present
        ? readingSpeedWpm.value
        : this.readingSpeedWpm,
    speedHasEvidence: speedHasEvidence ?? this.speedHasEvidence,
    speedTargetOfficial: speedTargetOfficial.present
        ? speedTargetOfficial.value
        : this.speedTargetOfficial,
    comprehensionFactScore:
        comprehensionFactScore ?? this.comprehensionFactScore,
    retellScore: retellScore ?? this.retellScore,
    dictationScore: dictationScore ?? this.dictationScore,
    stuckOnAksharasJson: stuckOnAksharasJson.present
        ? stuckOnAksharasJson.value
        : this.stuckOnAksharasJson,
    typingScore: typingScore.present ? typingScore.value : this.typingScore,
    selfRatingSummaryJson: selfRatingSummaryJson.present
        ? selfRatingSummaryJson.value
        : this.selfRatingSummaryJson,
    isLowConfidence: isLowConfidence ?? this.isLowConfidence,
    createdAt: createdAt ?? this.createdAt,
  );
  ResultsTableData copyWithCompanion(ResultsTableCompanion data) {
    return ResultsTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      childId: data.childId.present ? data.childId.value : this.childId,
      scope: data.scope.present ? data.scope.value : this.scope,
      groupAssigned: data.groupAssigned.present
          ? data.groupAssigned.value
          : this.groupAssigned,
      groupReason: data.groupReason.present
          ? data.groupReason.value
          : this.groupReason,
      nextStepRecommendation: data.nextStepRecommendation.present
          ? data.nextStepRecommendation.value
          : this.nextStepRecommendation,
      totalWords: data.totalWords.present
          ? data.totalWords.value
          : this.totalWords,
      attemptedWords: data.attemptedWords.present
          ? data.attemptedWords.value
          : this.attemptedWords,
      correctWords: data.correctWords.present
          ? data.correctWords.value
          : this.correctWords,
      accuracyPercentage: data.accuracyPercentage.present
          ? data.accuracyPercentage.value
          : this.accuracyPercentage,
      readingSpeedWpm: data.readingSpeedWpm.present
          ? data.readingSpeedWpm.value
          : this.readingSpeedWpm,
      speedHasEvidence: data.speedHasEvidence.present
          ? data.speedHasEvidence.value
          : this.speedHasEvidence,
      speedTargetOfficial: data.speedTargetOfficial.present
          ? data.speedTargetOfficial.value
          : this.speedTargetOfficial,
      comprehensionFactScore: data.comprehensionFactScore.present
          ? data.comprehensionFactScore.value
          : this.comprehensionFactScore,
      retellScore: data.retellScore.present
          ? data.retellScore.value
          : this.retellScore,
      dictationScore: data.dictationScore.present
          ? data.dictationScore.value
          : this.dictationScore,
      stuckOnAksharasJson: data.stuckOnAksharasJson.present
          ? data.stuckOnAksharasJson.value
          : this.stuckOnAksharasJson,
      typingScore: data.typingScore.present
          ? data.typingScore.value
          : this.typingScore,
      selfRatingSummaryJson: data.selfRatingSummaryJson.present
          ? data.selfRatingSummaryJson.value
          : this.selfRatingSummaryJson,
      isLowConfidence: data.isLowConfidence.present
          ? data.isLowConfidence.value
          : this.isLowConfidence,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResultsTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('groupAssigned: $groupAssigned, ')
          ..write('groupReason: $groupReason, ')
          ..write('nextStepRecommendation: $nextStepRecommendation, ')
          ..write('totalWords: $totalWords, ')
          ..write('attemptedWords: $attemptedWords, ')
          ..write('correctWords: $correctWords, ')
          ..write('accuracyPercentage: $accuracyPercentage, ')
          ..write('readingSpeedWpm: $readingSpeedWpm, ')
          ..write('speedHasEvidence: $speedHasEvidence, ')
          ..write('speedTargetOfficial: $speedTargetOfficial, ')
          ..write('comprehensionFactScore: $comprehensionFactScore, ')
          ..write('retellScore: $retellScore, ')
          ..write('dictationScore: $dictationScore, ')
          ..write('stuckOnAksharasJson: $stuckOnAksharasJson, ')
          ..write('typingScore: $typingScore, ')
          ..write('selfRatingSummaryJson: $selfRatingSummaryJson, ')
          ..write('isLowConfidence: $isLowConfidence, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    checkId,
    childId,
    scope,
    groupAssigned,
    groupReason,
    nextStepRecommendation,
    totalWords,
    attemptedWords,
    correctWords,
    accuracyPercentage,
    readingSpeedWpm,
    speedHasEvidence,
    speedTargetOfficial,
    comprehensionFactScore,
    retellScore,
    dictationScore,
    stuckOnAksharasJson,
    typingScore,
    selfRatingSummaryJson,
    isLowConfidence,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResultsTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.childId == this.childId &&
          other.scope == this.scope &&
          other.groupAssigned == this.groupAssigned &&
          other.groupReason == this.groupReason &&
          other.nextStepRecommendation == this.nextStepRecommendation &&
          other.totalWords == this.totalWords &&
          other.attemptedWords == this.attemptedWords &&
          other.correctWords == this.correctWords &&
          other.accuracyPercentage == this.accuracyPercentage &&
          other.readingSpeedWpm == this.readingSpeedWpm &&
          other.speedHasEvidence == this.speedHasEvidence &&
          other.speedTargetOfficial == this.speedTargetOfficial &&
          other.comprehensionFactScore == this.comprehensionFactScore &&
          other.retellScore == this.retellScore &&
          other.dictationScore == this.dictationScore &&
          other.stuckOnAksharasJson == this.stuckOnAksharasJson &&
          other.typingScore == this.typingScore &&
          other.selfRatingSummaryJson == this.selfRatingSummaryJson &&
          other.isLowConfidence == this.isLowConfidence &&
          other.createdAt == this.createdAt);
}

class ResultsTableCompanion extends UpdateCompanion<ResultsTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<String> childId;
  final Value<String> scope;
  final Value<String> groupAssigned;
  final Value<String> groupReason;
  final Value<String> nextStepRecommendation;
  final Value<int> totalWords;
  final Value<int> attemptedWords;
  final Value<int> correctWords;
  final Value<double> accuracyPercentage;
  final Value<double?> readingSpeedWpm;
  final Value<bool> speedHasEvidence;
  final Value<String?> speedTargetOfficial;
  final Value<String> comprehensionFactScore;
  final Value<String> retellScore;
  final Value<String> dictationScore;
  final Value<String?> stuckOnAksharasJson;
  final Value<String?> typingScore;
  final Value<String?> selfRatingSummaryJson;
  final Value<bool> isLowConfidence;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ResultsTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.childId = const Value.absent(),
    this.scope = const Value.absent(),
    this.groupAssigned = const Value.absent(),
    this.groupReason = const Value.absent(),
    this.nextStepRecommendation = const Value.absent(),
    this.totalWords = const Value.absent(),
    this.attemptedWords = const Value.absent(),
    this.correctWords = const Value.absent(),
    this.accuracyPercentage = const Value.absent(),
    this.readingSpeedWpm = const Value.absent(),
    this.speedHasEvidence = const Value.absent(),
    this.speedTargetOfficial = const Value.absent(),
    this.comprehensionFactScore = const Value.absent(),
    this.retellScore = const Value.absent(),
    this.dictationScore = const Value.absent(),
    this.stuckOnAksharasJson = const Value.absent(),
    this.typingScore = const Value.absent(),
    this.selfRatingSummaryJson = const Value.absent(),
    this.isLowConfidence = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResultsTableCompanion.insert({
    required String id,
    required String checkId,
    required String childId,
    required String scope,
    required String groupAssigned,
    required String groupReason,
    required String nextStepRecommendation,
    required int totalWords,
    required int attemptedWords,
    required int correctWords,
    required double accuracyPercentage,
    this.readingSpeedWpm = const Value.absent(),
    required bool speedHasEvidence,
    this.speedTargetOfficial = const Value.absent(),
    required String comprehensionFactScore,
    required String retellScore,
    required String dictationScore,
    this.stuckOnAksharasJson = const Value.absent(),
    this.typingScore = const Value.absent(),
    this.selfRatingSummaryJson = const Value.absent(),
    required bool isLowConfidence,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       childId = Value(childId),
       scope = Value(scope),
       groupAssigned = Value(groupAssigned),
       groupReason = Value(groupReason),
       nextStepRecommendation = Value(nextStepRecommendation),
       totalWords = Value(totalWords),
       attemptedWords = Value(attemptedWords),
       correctWords = Value(correctWords),
       accuracyPercentage = Value(accuracyPercentage),
       speedHasEvidence = Value(speedHasEvidence),
       comprehensionFactScore = Value(comprehensionFactScore),
       retellScore = Value(retellScore),
       dictationScore = Value(dictationScore),
       isLowConfidence = Value(isLowConfidence),
       createdAt = Value(createdAt);
  static Insertable<ResultsTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<String>? childId,
    Expression<String>? scope,
    Expression<String>? groupAssigned,
    Expression<String>? groupReason,
    Expression<String>? nextStepRecommendation,
    Expression<int>? totalWords,
    Expression<int>? attemptedWords,
    Expression<int>? correctWords,
    Expression<double>? accuracyPercentage,
    Expression<double>? readingSpeedWpm,
    Expression<bool>? speedHasEvidence,
    Expression<String>? speedTargetOfficial,
    Expression<String>? comprehensionFactScore,
    Expression<String>? retellScore,
    Expression<String>? dictationScore,
    Expression<String>? stuckOnAksharasJson,
    Expression<String>? typingScore,
    Expression<String>? selfRatingSummaryJson,
    Expression<bool>? isLowConfidence,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (childId != null) 'child_id': childId,
      if (scope != null) 'scope': scope,
      if (groupAssigned != null) 'group_assigned': groupAssigned,
      if (groupReason != null) 'group_reason': groupReason,
      if (nextStepRecommendation != null)
        'next_step_recommendation': nextStepRecommendation,
      if (totalWords != null) 'total_words': totalWords,
      if (attemptedWords != null) 'attempted_words': attemptedWords,
      if (correctWords != null) 'correct_words': correctWords,
      if (accuracyPercentage != null) 'accuracy_percentage': accuracyPercentage,
      if (readingSpeedWpm != null) 'reading_speed_wpm': readingSpeedWpm,
      if (speedHasEvidence != null) 'speed_has_evidence': speedHasEvidence,
      if (speedTargetOfficial != null)
        'speed_target_official': speedTargetOfficial,
      if (comprehensionFactScore != null)
        'comprehension_fact_score': comprehensionFactScore,
      if (retellScore != null) 'retell_score': retellScore,
      if (dictationScore != null) 'dictation_score': dictationScore,
      if (stuckOnAksharasJson != null)
        'stuck_on_aksharas_json': stuckOnAksharasJson,
      if (typingScore != null) 'typing_score': typingScore,
      if (selfRatingSummaryJson != null)
        'self_rating_summary_json': selfRatingSummaryJson,
      if (isLowConfidence != null) 'is_low_confidence': isLowConfidence,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResultsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<String>? childId,
    Value<String>? scope,
    Value<String>? groupAssigned,
    Value<String>? groupReason,
    Value<String>? nextStepRecommendation,
    Value<int>? totalWords,
    Value<int>? attemptedWords,
    Value<int>? correctWords,
    Value<double>? accuracyPercentage,
    Value<double?>? readingSpeedWpm,
    Value<bool>? speedHasEvidence,
    Value<String?>? speedTargetOfficial,
    Value<String>? comprehensionFactScore,
    Value<String>? retellScore,
    Value<String>? dictationScore,
    Value<String?>? stuckOnAksharasJson,
    Value<String?>? typingScore,
    Value<String?>? selfRatingSummaryJson,
    Value<bool>? isLowConfidence,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ResultsTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      childId: childId ?? this.childId,
      scope: scope ?? this.scope,
      groupAssigned: groupAssigned ?? this.groupAssigned,
      groupReason: groupReason ?? this.groupReason,
      nextStepRecommendation:
          nextStepRecommendation ?? this.nextStepRecommendation,
      totalWords: totalWords ?? this.totalWords,
      attemptedWords: attemptedWords ?? this.attemptedWords,
      correctWords: correctWords ?? this.correctWords,
      accuracyPercentage: accuracyPercentage ?? this.accuracyPercentage,
      readingSpeedWpm: readingSpeedWpm ?? this.readingSpeedWpm,
      speedHasEvidence: speedHasEvidence ?? this.speedHasEvidence,
      speedTargetOfficial: speedTargetOfficial ?? this.speedTargetOfficial,
      comprehensionFactScore:
          comprehensionFactScore ?? this.comprehensionFactScore,
      retellScore: retellScore ?? this.retellScore,
      dictationScore: dictationScore ?? this.dictationScore,
      stuckOnAksharasJson: stuckOnAksharasJson ?? this.stuckOnAksharasJson,
      typingScore: typingScore ?? this.typingScore,
      selfRatingSummaryJson:
          selfRatingSummaryJson ?? this.selfRatingSummaryJson,
      isLowConfidence: isLowConfidence ?? this.isLowConfidence,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (groupAssigned.present) {
      map['group_assigned'] = Variable<String>(groupAssigned.value);
    }
    if (groupReason.present) {
      map['group_reason'] = Variable<String>(groupReason.value);
    }
    if (nextStepRecommendation.present) {
      map['next_step_recommendation'] = Variable<String>(
        nextStepRecommendation.value,
      );
    }
    if (totalWords.present) {
      map['total_words'] = Variable<int>(totalWords.value);
    }
    if (attemptedWords.present) {
      map['attempted_words'] = Variable<int>(attemptedWords.value);
    }
    if (correctWords.present) {
      map['correct_words'] = Variable<int>(correctWords.value);
    }
    if (accuracyPercentage.present) {
      map['accuracy_percentage'] = Variable<double>(accuracyPercentage.value);
    }
    if (readingSpeedWpm.present) {
      map['reading_speed_wpm'] = Variable<double>(readingSpeedWpm.value);
    }
    if (speedHasEvidence.present) {
      map['speed_has_evidence'] = Variable<bool>(speedHasEvidence.value);
    }
    if (speedTargetOfficial.present) {
      map['speed_target_official'] = Variable<String>(
        speedTargetOfficial.value,
      );
    }
    if (comprehensionFactScore.present) {
      map['comprehension_fact_score'] = Variable<String>(
        comprehensionFactScore.value,
      );
    }
    if (retellScore.present) {
      map['retell_score'] = Variable<String>(retellScore.value);
    }
    if (dictationScore.present) {
      map['dictation_score'] = Variable<String>(dictationScore.value);
    }
    if (stuckOnAksharasJson.present) {
      map['stuck_on_aksharas_json'] = Variable<String>(
        stuckOnAksharasJson.value,
      );
    }
    if (typingScore.present) {
      map['typing_score'] = Variable<String>(typingScore.value);
    }
    if (selfRatingSummaryJson.present) {
      map['self_rating_summary_json'] = Variable<String>(
        selfRatingSummaryJson.value,
      );
    }
    if (isLowConfidence.present) {
      map['is_low_confidence'] = Variable<bool>(isLowConfidence.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultsTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('groupAssigned: $groupAssigned, ')
          ..write('groupReason: $groupReason, ')
          ..write('nextStepRecommendation: $nextStepRecommendation, ')
          ..write('totalWords: $totalWords, ')
          ..write('attemptedWords: $attemptedWords, ')
          ..write('correctWords: $correctWords, ')
          ..write('accuracyPercentage: $accuracyPercentage, ')
          ..write('readingSpeedWpm: $readingSpeedWpm, ')
          ..write('speedHasEvidence: $speedHasEvidence, ')
          ..write('speedTargetOfficial: $speedTargetOfficial, ')
          ..write('comprehensionFactScore: $comprehensionFactScore, ')
          ..write('retellScore: $retellScore, ')
          ..write('dictationScore: $dictationScore, ')
          ..write('stuckOnAksharasJson: $stuckOnAksharasJson, ')
          ..write('typingScore: $typingScore, ')
          ..write('selfRatingSummaryJson: $selfRatingSummaryJson, ')
          ..write('isLowConfidence: $isLowConfidence, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PracticeNeedsTableTable extends PracticeNeedsTable
    with TableInfo<$PracticeNeedsTableTable, PracticeNeedsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeNeedsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gapTypeMeta = const VerificationMeta(
    'gapType',
  );
  @override
  late final GeneratedColumn<String> gapType = GeneratedColumn<String>(
    'gap_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gapDetailMeta = const VerificationMeta(
    'gapDetail',
  );
  @override
  late final GeneratedColumn<String> gapDetail = GeneratedColumn<String>(
    'gap_detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSheetPrintedMeta = const VerificationMeta(
    'isSheetPrinted',
  );
  @override
  late final GeneratedColumn<bool> isSheetPrinted = GeneratedColumn<bool>(
    'is_sheet_printed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sheet_printed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastPrintedAtMeta = const VerificationMeta(
    'lastPrintedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastPrintedAt =
      GeneratedColumn<DateTime>(
        'last_printed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    childId,
    scope,
    gapType,
    gapDetail,
    activityId,
    isSheetPrinted,
    lastPrintedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_needs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PracticeNeedsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('gap_type')) {
      context.handle(
        _gapTypeMeta,
        gapType.isAcceptableOrUnknown(data['gap_type']!, _gapTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_gapTypeMeta);
    }
    if (data.containsKey('gap_detail')) {
      context.handle(
        _gapDetailMeta,
        gapDetail.isAcceptableOrUnknown(data['gap_detail']!, _gapDetailMeta),
      );
    } else if (isInserting) {
      context.missing(_gapDetailMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('is_sheet_printed')) {
      context.handle(
        _isSheetPrintedMeta,
        isSheetPrinted.isAcceptableOrUnknown(
          data['is_sheet_printed']!,
          _isSheetPrintedMeta,
        ),
      );
    }
    if (data.containsKey('last_printed_at')) {
      context.handle(
        _lastPrintedAtMeta,
        lastPrintedAt.isAcceptableOrUnknown(
          data['last_printed_at']!,
          _lastPrintedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PracticeNeedsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeNeedsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      gapType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gap_type'],
      )!,
      gapDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gap_detail'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      isSheetPrinted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sheet_printed'],
      )!,
      lastPrintedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_printed_at'],
      ),
    );
  }

  @override
  $PracticeNeedsTableTable createAlias(String alias) {
    return $PracticeNeedsTableTable(attachedDatabase, alias);
  }
}

class PracticeNeedsTableData extends DataClass
    implements Insertable<PracticeNeedsTableData> {
  final String id;
  final String childId;
  final String scope;
  final String gapType;
  final String gapDetail;
  final String activityId;
  final bool isSheetPrinted;
  final DateTime? lastPrintedAt;
  const PracticeNeedsTableData({
    required this.id,
    required this.childId,
    required this.scope,
    required this.gapType,
    required this.gapDetail,
    required this.activityId,
    required this.isSheetPrinted,
    this.lastPrintedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['child_id'] = Variable<String>(childId);
    map['scope'] = Variable<String>(scope);
    map['gap_type'] = Variable<String>(gapType);
    map['gap_detail'] = Variable<String>(gapDetail);
    map['activity_id'] = Variable<String>(activityId);
    map['is_sheet_printed'] = Variable<bool>(isSheetPrinted);
    if (!nullToAbsent || lastPrintedAt != null) {
      map['last_printed_at'] = Variable<DateTime>(lastPrintedAt);
    }
    return map;
  }

  PracticeNeedsTableCompanion toCompanion(bool nullToAbsent) {
    return PracticeNeedsTableCompanion(
      id: Value(id),
      childId: Value(childId),
      scope: Value(scope),
      gapType: Value(gapType),
      gapDetail: Value(gapDetail),
      activityId: Value(activityId),
      isSheetPrinted: Value(isSheetPrinted),
      lastPrintedAt: lastPrintedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPrintedAt),
    );
  }

  factory PracticeNeedsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeNeedsTableData(
      id: serializer.fromJson<String>(json['id']),
      childId: serializer.fromJson<String>(json['childId']),
      scope: serializer.fromJson<String>(json['scope']),
      gapType: serializer.fromJson<String>(json['gapType']),
      gapDetail: serializer.fromJson<String>(json['gapDetail']),
      activityId: serializer.fromJson<String>(json['activityId']),
      isSheetPrinted: serializer.fromJson<bool>(json['isSheetPrinted']),
      lastPrintedAt: serializer.fromJson<DateTime?>(json['lastPrintedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'childId': serializer.toJson<String>(childId),
      'scope': serializer.toJson<String>(scope),
      'gapType': serializer.toJson<String>(gapType),
      'gapDetail': serializer.toJson<String>(gapDetail),
      'activityId': serializer.toJson<String>(activityId),
      'isSheetPrinted': serializer.toJson<bool>(isSheetPrinted),
      'lastPrintedAt': serializer.toJson<DateTime?>(lastPrintedAt),
    };
  }

  PracticeNeedsTableData copyWith({
    String? id,
    String? childId,
    String? scope,
    String? gapType,
    String? gapDetail,
    String? activityId,
    bool? isSheetPrinted,
    Value<DateTime?> lastPrintedAt = const Value.absent(),
  }) => PracticeNeedsTableData(
    id: id ?? this.id,
    childId: childId ?? this.childId,
    scope: scope ?? this.scope,
    gapType: gapType ?? this.gapType,
    gapDetail: gapDetail ?? this.gapDetail,
    activityId: activityId ?? this.activityId,
    isSheetPrinted: isSheetPrinted ?? this.isSheetPrinted,
    lastPrintedAt: lastPrintedAt.present
        ? lastPrintedAt.value
        : this.lastPrintedAt,
  );
  PracticeNeedsTableData copyWithCompanion(PracticeNeedsTableCompanion data) {
    return PracticeNeedsTableData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      scope: data.scope.present ? data.scope.value : this.scope,
      gapType: data.gapType.present ? data.gapType.value : this.gapType,
      gapDetail: data.gapDetail.present ? data.gapDetail.value : this.gapDetail,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      isSheetPrinted: data.isSheetPrinted.present
          ? data.isSheetPrinted.value
          : this.isSheetPrinted,
      lastPrintedAt: data.lastPrintedAt.present
          ? data.lastPrintedAt.value
          : this.lastPrintedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PracticeNeedsTableData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('gapType: $gapType, ')
          ..write('gapDetail: $gapDetail, ')
          ..write('activityId: $activityId, ')
          ..write('isSheetPrinted: $isSheetPrinted, ')
          ..write('lastPrintedAt: $lastPrintedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    childId,
    scope,
    gapType,
    gapDetail,
    activityId,
    isSheetPrinted,
    lastPrintedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeNeedsTableData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.scope == this.scope &&
          other.gapType == this.gapType &&
          other.gapDetail == this.gapDetail &&
          other.activityId == this.activityId &&
          other.isSheetPrinted == this.isSheetPrinted &&
          other.lastPrintedAt == this.lastPrintedAt);
}

class PracticeNeedsTableCompanion
    extends UpdateCompanion<PracticeNeedsTableData> {
  final Value<String> id;
  final Value<String> childId;
  final Value<String> scope;
  final Value<String> gapType;
  final Value<String> gapDetail;
  final Value<String> activityId;
  final Value<bool> isSheetPrinted;
  final Value<DateTime?> lastPrintedAt;
  final Value<int> rowid;
  const PracticeNeedsTableCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.scope = const Value.absent(),
    this.gapType = const Value.absent(),
    this.gapDetail = const Value.absent(),
    this.activityId = const Value.absent(),
    this.isSheetPrinted = const Value.absent(),
    this.lastPrintedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PracticeNeedsTableCompanion.insert({
    required String id,
    required String childId,
    required String scope,
    required String gapType,
    required String gapDetail,
    required String activityId,
    this.isSheetPrinted = const Value.absent(),
    this.lastPrintedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       childId = Value(childId),
       scope = Value(scope),
       gapType = Value(gapType),
       gapDetail = Value(gapDetail),
       activityId = Value(activityId);
  static Insertable<PracticeNeedsTableData> custom({
    Expression<String>? id,
    Expression<String>? childId,
    Expression<String>? scope,
    Expression<String>? gapType,
    Expression<String>? gapDetail,
    Expression<String>? activityId,
    Expression<bool>? isSheetPrinted,
    Expression<DateTime>? lastPrintedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (scope != null) 'scope': scope,
      if (gapType != null) 'gap_type': gapType,
      if (gapDetail != null) 'gap_detail': gapDetail,
      if (activityId != null) 'activity_id': activityId,
      if (isSheetPrinted != null) 'is_sheet_printed': isSheetPrinted,
      if (lastPrintedAt != null) 'last_printed_at': lastPrintedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PracticeNeedsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? childId,
    Value<String>? scope,
    Value<String>? gapType,
    Value<String>? gapDetail,
    Value<String>? activityId,
    Value<bool>? isSheetPrinted,
    Value<DateTime?>? lastPrintedAt,
    Value<int>? rowid,
  }) {
    return PracticeNeedsTableCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      scope: scope ?? this.scope,
      gapType: gapType ?? this.gapType,
      gapDetail: gapDetail ?? this.gapDetail,
      activityId: activityId ?? this.activityId,
      isSheetPrinted: isSheetPrinted ?? this.isSheetPrinted,
      lastPrintedAt: lastPrintedAt ?? this.lastPrintedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (gapType.present) {
      map['gap_type'] = Variable<String>(gapType.value);
    }
    if (gapDetail.present) {
      map['gap_detail'] = Variable<String>(gapDetail.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (isSheetPrinted.present) {
      map['is_sheet_printed'] = Variable<bool>(isSheetPrinted.value);
    }
    if (lastPrintedAt.present) {
      map['last_printed_at'] = Variable<DateTime>(lastPrintedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeNeedsTableCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('gapType: $gapType, ')
          ..write('gapDetail: $gapDetail, ')
          ..write('activityId: $activityId, ')
          ..write('isSheetPrinted: $isSheetPrinted, ')
          ..write('lastPrintedAt: $lastPrintedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyPlanTicksTableTable extends WeeklyPlanTicksTable
    with TableInfo<$WeeklyPlanTicksTableTable, WeeklyPlanTicksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyPlanTicksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> weekStartDate =
      GeneratedColumn<DateTime>(
        'week_start_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    classId,
    scope,
    weekStartDate,
    groupName,
    activityId,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_plan_ticks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyPlanTicksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyPlanTicksTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyPlanTicksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start_date'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $WeeklyPlanTicksTableTable createAlias(String alias) {
    return $WeeklyPlanTicksTableTable(attachedDatabase, alias);
  }
}

class WeeklyPlanTicksTableData extends DataClass
    implements Insertable<WeeklyPlanTicksTableData> {
  final String id;
  final String classId;
  final String scope;
  final DateTime weekStartDate;
  final String groupName;
  final String activityId;
  final bool isCompleted;
  final DateTime? completedAt;
  const WeeklyPlanTicksTableData({
    required this.id,
    required this.classId,
    required this.scope,
    required this.weekStartDate,
    required this.groupName,
    required this.activityId,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['class_id'] = Variable<String>(classId);
    map['scope'] = Variable<String>(scope);
    map['week_start_date'] = Variable<DateTime>(weekStartDate);
    map['group_name'] = Variable<String>(groupName);
    map['activity_id'] = Variable<String>(activityId);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  WeeklyPlanTicksTableCompanion toCompanion(bool nullToAbsent) {
    return WeeklyPlanTicksTableCompanion(
      id: Value(id),
      classId: Value(classId),
      scope: Value(scope),
      weekStartDate: Value(weekStartDate),
      groupName: Value(groupName),
      activityId: Value(activityId),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory WeeklyPlanTicksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyPlanTicksTableData(
      id: serializer.fromJson<String>(json['id']),
      classId: serializer.fromJson<String>(json['classId']),
      scope: serializer.fromJson<String>(json['scope']),
      weekStartDate: serializer.fromJson<DateTime>(json['weekStartDate']),
      groupName: serializer.fromJson<String>(json['groupName']),
      activityId: serializer.fromJson<String>(json['activityId']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'classId': serializer.toJson<String>(classId),
      'scope': serializer.toJson<String>(scope),
      'weekStartDate': serializer.toJson<DateTime>(weekStartDate),
      'groupName': serializer.toJson<String>(groupName),
      'activityId': serializer.toJson<String>(activityId),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  WeeklyPlanTicksTableData copyWith({
    String? id,
    String? classId,
    String? scope,
    DateTime? weekStartDate,
    String? groupName,
    String? activityId,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => WeeklyPlanTicksTableData(
    id: id ?? this.id,
    classId: classId ?? this.classId,
    scope: scope ?? this.scope,
    weekStartDate: weekStartDate ?? this.weekStartDate,
    groupName: groupName ?? this.groupName,
    activityId: activityId ?? this.activityId,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  WeeklyPlanTicksTableData copyWithCompanion(
    WeeklyPlanTicksTableCompanion data,
  ) {
    return WeeklyPlanTicksTableData(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      scope: data.scope.present ? data.scope.value : this.scope,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyPlanTicksTableData(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('groupName: $groupName, ')
          ..write('activityId: $activityId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    classId,
    scope,
    weekStartDate,
    groupName,
    activityId,
    isCompleted,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyPlanTicksTableData &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.scope == this.scope &&
          other.weekStartDate == this.weekStartDate &&
          other.groupName == this.groupName &&
          other.activityId == this.activityId &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class WeeklyPlanTicksTableCompanion
    extends UpdateCompanion<WeeklyPlanTicksTableData> {
  final Value<String> id;
  final Value<String> classId;
  final Value<String> scope;
  final Value<DateTime> weekStartDate;
  final Value<String> groupName;
  final Value<String> activityId;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const WeeklyPlanTicksTableCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.scope = const Value.absent(),
    this.weekStartDate = const Value.absent(),
    this.groupName = const Value.absent(),
    this.activityId = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyPlanTicksTableCompanion.insert({
    required String id,
    required String classId,
    required String scope,
    required DateTime weekStartDate,
    required String groupName,
    required String activityId,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       classId = Value(classId),
       scope = Value(scope),
       weekStartDate = Value(weekStartDate),
       groupName = Value(groupName),
       activityId = Value(activityId);
  static Insertable<WeeklyPlanTicksTableData> custom({
    Expression<String>? id,
    Expression<String>? classId,
    Expression<String>? scope,
    Expression<DateTime>? weekStartDate,
    Expression<String>? groupName,
    Expression<String>? activityId,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (scope != null) 'scope': scope,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
      if (groupName != null) 'group_name': groupName,
      if (activityId != null) 'activity_id': activityId,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyPlanTicksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? classId,
    Value<String>? scope,
    Value<DateTime>? weekStartDate,
    Value<String>? groupName,
    Value<String>? activityId,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return WeeklyPlanTicksTableCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      scope: scope ?? this.scope,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      groupName: groupName ?? this.groupName,
      activityId: activityId ?? this.activityId,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<DateTime>(weekStartDate.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyPlanTicksTableCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('scope: $scope, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('groupName: $groupName, ')
          ..write('activityId: $activityId, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParentReportsTableTable extends ParentReportsTable
    with TableInfo<$ParentReportsTableTable, ParentReportsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParentReportsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _childIdMeta = const VerificationMeta(
    'childId',
  );
  @override
  late final GeneratedColumn<String> childId = GeneratedColumn<String>(
    'child_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teacherApprovedMeta = const VerificationMeta(
    'teacherApproved',
  );
  @override
  late final GeneratedColumn<bool> teacherApproved = GeneratedColumn<bool>(
    'teacher_approved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("teacher_approved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    childId,
    scope,
    teacherApproved,
    approvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parent_reports_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParentReportsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('child_id')) {
      context.handle(
        _childIdMeta,
        childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta),
      );
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('teacher_approved')) {
      context.handle(
        _teacherApprovedMeta,
        teacherApproved.isAcceptableOrUnknown(
          data['teacher_approved']!,
          _teacherApprovedMeta,
        ),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParentReportsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParentReportsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      childId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}child_id'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      teacherApproved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}teacher_approved'],
      )!,
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      ),
    );
  }

  @override
  $ParentReportsTableTable createAlias(String alias) {
    return $ParentReportsTableTable(attachedDatabase, alias);
  }
}

class ParentReportsTableData extends DataClass
    implements Insertable<ParentReportsTableData> {
  final String id;
  final String checkId;
  final String childId;
  final String scope;
  final bool teacherApproved;
  final DateTime? approvedAt;
  const ParentReportsTableData({
    required this.id,
    required this.checkId,
    required this.childId,
    required this.scope,
    required this.teacherApproved,
    this.approvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['child_id'] = Variable<String>(childId);
    map['scope'] = Variable<String>(scope);
    map['teacher_approved'] = Variable<bool>(teacherApproved);
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    return map;
  }

  ParentReportsTableCompanion toCompanion(bool nullToAbsent) {
    return ParentReportsTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      childId: Value(childId),
      scope: Value(scope),
      teacherApproved: Value(teacherApproved),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
    );
  }

  factory ParentReportsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParentReportsTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      childId: serializer.fromJson<String>(json['childId']),
      scope: serializer.fromJson<String>(json['scope']),
      teacherApproved: serializer.fromJson<bool>(json['teacherApproved']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'childId': serializer.toJson<String>(childId),
      'scope': serializer.toJson<String>(scope),
      'teacherApproved': serializer.toJson<bool>(teacherApproved),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
    };
  }

  ParentReportsTableData copyWith({
    String? id,
    String? checkId,
    String? childId,
    String? scope,
    bool? teacherApproved,
    Value<DateTime?> approvedAt = const Value.absent(),
  }) => ParentReportsTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    childId: childId ?? this.childId,
    scope: scope ?? this.scope,
    teacherApproved: teacherApproved ?? this.teacherApproved,
    approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
  );
  ParentReportsTableData copyWithCompanion(ParentReportsTableCompanion data) {
    return ParentReportsTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      childId: data.childId.present ? data.childId.value : this.childId,
      scope: data.scope.present ? data.scope.value : this.scope,
      teacherApproved: data.teacherApproved.present
          ? data.teacherApproved.value
          : this.teacherApproved,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParentReportsTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('teacherApproved: $teacherApproved, ')
          ..write('approvedAt: $approvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, checkId, childId, scope, teacherApproved, approvedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParentReportsTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.childId == this.childId &&
          other.scope == this.scope &&
          other.teacherApproved == this.teacherApproved &&
          other.approvedAt == this.approvedAt);
}

class ParentReportsTableCompanion
    extends UpdateCompanion<ParentReportsTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<String> childId;
  final Value<String> scope;
  final Value<bool> teacherApproved;
  final Value<DateTime?> approvedAt;
  final Value<int> rowid;
  const ParentReportsTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.childId = const Value.absent(),
    this.scope = const Value.absent(),
    this.teacherApproved = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParentReportsTableCompanion.insert({
    required String id,
    required String checkId,
    required String childId,
    required String scope,
    this.teacherApproved = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       childId = Value(childId),
       scope = Value(scope);
  static Insertable<ParentReportsTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<String>? childId,
    Expression<String>? scope,
    Expression<bool>? teacherApproved,
    Expression<DateTime>? approvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (childId != null) 'child_id': childId,
      if (scope != null) 'scope': scope,
      if (teacherApproved != null) 'teacher_approved': teacherApproved,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParentReportsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<String>? childId,
    Value<String>? scope,
    Value<bool>? teacherApproved,
    Value<DateTime?>? approvedAt,
    Value<int>? rowid,
  }) {
    return ParentReportsTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      childId: childId ?? this.childId,
      scope: scope ?? this.scope,
      teacherApproved: teacherApproved ?? this.teacherApproved,
      approvedAt: approvedAt ?? this.approvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<String>(childId.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (teacherApproved.present) {
      map['teacher_approved'] = Variable<bool>(teacherApproved.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParentReportsTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('childId: $childId, ')
          ..write('scope: $scope, ')
          ..write('teacherApproved: $teacherApproved, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AcceptedPronunciationsTableTable extends AcceptedPronunciationsTable
    with
        TableInfo<
          $AcceptedPronunciationsTableTable,
          AcceptedPronunciationsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AcceptedPronunciationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _standardWordMeta = const VerificationMeta(
    'standardWord',
  );
  @override
  late final GeneratedColumn<String> standardWord = GeneratedColumn<String>(
    'standard_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionalVariantMeta = const VerificationMeta(
    'regionalVariant',
  );
  @override
  late final GeneratedColumn<String> regionalVariant = GeneratedColumn<String>(
    'regional_variant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _acceptedAtMeta = const VerificationMeta(
    'acceptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acceptedAt = GeneratedColumn<DateTime>(
    'accepted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    standardWord,
    regionalVariant,
    scope,
    acceptedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accepted_pronunciations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AcceptedPronunciationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('standard_word')) {
      context.handle(
        _standardWordMeta,
        standardWord.isAcceptableOrUnknown(
          data['standard_word']!,
          _standardWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_standardWordMeta);
    }
    if (data.containsKey('regional_variant')) {
      context.handle(
        _regionalVariantMeta,
        regionalVariant.isAcceptableOrUnknown(
          data['regional_variant']!,
          _regionalVariantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_regionalVariantMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('accepted_at')) {
      context.handle(
        _acceptedAtMeta,
        acceptedAt.isAcceptableOrUnknown(data['accepted_at']!, _acceptedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_acceptedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AcceptedPronunciationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AcceptedPronunciationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      standardWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}standard_word'],
      )!,
      regionalVariant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}regional_variant'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      acceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}accepted_at'],
      )!,
    );
  }

  @override
  $AcceptedPronunciationsTableTable createAlias(String alias) {
    return $AcceptedPronunciationsTableTable(attachedDatabase, alias);
  }
}

class AcceptedPronunciationsTableData extends DataClass
    implements Insertable<AcceptedPronunciationsTableData> {
  final String id;
  final String standardWord;
  final String regionalVariant;
  final String scope;
  final DateTime acceptedAt;
  const AcceptedPronunciationsTableData({
    required this.id,
    required this.standardWord,
    required this.regionalVariant,
    required this.scope,
    required this.acceptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['standard_word'] = Variable<String>(standardWord);
    map['regional_variant'] = Variable<String>(regionalVariant);
    map['scope'] = Variable<String>(scope);
    map['accepted_at'] = Variable<DateTime>(acceptedAt);
    return map;
  }

  AcceptedPronunciationsTableCompanion toCompanion(bool nullToAbsent) {
    return AcceptedPronunciationsTableCompanion(
      id: Value(id),
      standardWord: Value(standardWord),
      regionalVariant: Value(regionalVariant),
      scope: Value(scope),
      acceptedAt: Value(acceptedAt),
    );
  }

  factory AcceptedPronunciationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AcceptedPronunciationsTableData(
      id: serializer.fromJson<String>(json['id']),
      standardWord: serializer.fromJson<String>(json['standardWord']),
      regionalVariant: serializer.fromJson<String>(json['regionalVariant']),
      scope: serializer.fromJson<String>(json['scope']),
      acceptedAt: serializer.fromJson<DateTime>(json['acceptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'standardWord': serializer.toJson<String>(standardWord),
      'regionalVariant': serializer.toJson<String>(regionalVariant),
      'scope': serializer.toJson<String>(scope),
      'acceptedAt': serializer.toJson<DateTime>(acceptedAt),
    };
  }

  AcceptedPronunciationsTableData copyWith({
    String? id,
    String? standardWord,
    String? regionalVariant,
    String? scope,
    DateTime? acceptedAt,
  }) => AcceptedPronunciationsTableData(
    id: id ?? this.id,
    standardWord: standardWord ?? this.standardWord,
    regionalVariant: regionalVariant ?? this.regionalVariant,
    scope: scope ?? this.scope,
    acceptedAt: acceptedAt ?? this.acceptedAt,
  );
  AcceptedPronunciationsTableData copyWithCompanion(
    AcceptedPronunciationsTableCompanion data,
  ) {
    return AcceptedPronunciationsTableData(
      id: data.id.present ? data.id.value : this.id,
      standardWord: data.standardWord.present
          ? data.standardWord.value
          : this.standardWord,
      regionalVariant: data.regionalVariant.present
          ? data.regionalVariant.value
          : this.regionalVariant,
      scope: data.scope.present ? data.scope.value : this.scope,
      acceptedAt: data.acceptedAt.present
          ? data.acceptedAt.value
          : this.acceptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AcceptedPronunciationsTableData(')
          ..write('id: $id, ')
          ..write('standardWord: $standardWord, ')
          ..write('regionalVariant: $regionalVariant, ')
          ..write('scope: $scope, ')
          ..write('acceptedAt: $acceptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, standardWord, regionalVariant, scope, acceptedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AcceptedPronunciationsTableData &&
          other.id == this.id &&
          other.standardWord == this.standardWord &&
          other.regionalVariant == this.regionalVariant &&
          other.scope == this.scope &&
          other.acceptedAt == this.acceptedAt);
}

class AcceptedPronunciationsTableCompanion
    extends UpdateCompanion<AcceptedPronunciationsTableData> {
  final Value<String> id;
  final Value<String> standardWord;
  final Value<String> regionalVariant;
  final Value<String> scope;
  final Value<DateTime> acceptedAt;
  final Value<int> rowid;
  const AcceptedPronunciationsTableCompanion({
    this.id = const Value.absent(),
    this.standardWord = const Value.absent(),
    this.regionalVariant = const Value.absent(),
    this.scope = const Value.absent(),
    this.acceptedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AcceptedPronunciationsTableCompanion.insert({
    required String id,
    required String standardWord,
    required String regionalVariant,
    required String scope,
    required DateTime acceptedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       standardWord = Value(standardWord),
       regionalVariant = Value(regionalVariant),
       scope = Value(scope),
       acceptedAt = Value(acceptedAt);
  static Insertable<AcceptedPronunciationsTableData> custom({
    Expression<String>? id,
    Expression<String>? standardWord,
    Expression<String>? regionalVariant,
    Expression<String>? scope,
    Expression<DateTime>? acceptedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (standardWord != null) 'standard_word': standardWord,
      if (regionalVariant != null) 'regional_variant': regionalVariant,
      if (scope != null) 'scope': scope,
      if (acceptedAt != null) 'accepted_at': acceptedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AcceptedPronunciationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? standardWord,
    Value<String>? regionalVariant,
    Value<String>? scope,
    Value<DateTime>? acceptedAt,
    Value<int>? rowid,
  }) {
    return AcceptedPronunciationsTableCompanion(
      id: id ?? this.id,
      standardWord: standardWord ?? this.standardWord,
      regionalVariant: regionalVariant ?? this.regionalVariant,
      scope: scope ?? this.scope,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (standardWord.present) {
      map['standard_word'] = Variable<String>(standardWord.value);
    }
    if (regionalVariant.present) {
      map['regional_variant'] = Variable<String>(regionalVariant.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (acceptedAt.present) {
      map['accepted_at'] = Variable<DateTime>(acceptedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AcceptedPronunciationsTableCompanion(')
          ..write('id: $id, ')
          ..write('standardWord: $standardWord, ')
          ..write('regionalVariant: $regionalVariant, ')
          ..write('scope: $scope, ')
          ..write('acceptedAt: $acceptedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaIndexTableTable extends MediaIndexTable
    with TableInfo<$MediaIndexTableTable, MediaIndexTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaIndexTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPurgedMeta = const VerificationMeta(
    'isPurged',
  );
  @override
  late final GeneratedColumn<bool> isPurged = GeneratedColumn<bool>(
    'is_purged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_purged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    mediaType,
    filePath,
    createdAt,
    expiresAt,
    isPurged,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_index_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaIndexTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaTypeMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('is_purged')) {
      context.handle(
        _isPurgedMeta,
        isPurged.isAcceptableOrUnknown(data['is_purged']!, _isPurgedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaIndexTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaIndexTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      isPurged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_purged'],
      )!,
    );
  }

  @override
  $MediaIndexTableTable createAlias(String alias) {
    return $MediaIndexTableTable(attachedDatabase, alias);
  }
}

class MediaIndexTableData extends DataClass
    implements Insertable<MediaIndexTableData> {
  final String id;
  final String checkId;
  final String mediaType;
  final String filePath;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isPurged;
  const MediaIndexTableData({
    required this.id,
    required this.checkId,
    required this.mediaType,
    required this.filePath,
    required this.createdAt,
    required this.expiresAt,
    required this.isPurged,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['media_type'] = Variable<String>(mediaType);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['is_purged'] = Variable<bool>(isPurged);
    return map;
  }

  MediaIndexTableCompanion toCompanion(bool nullToAbsent) {
    return MediaIndexTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      mediaType: Value(mediaType),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
      isPurged: Value(isPurged),
    );
  }

  factory MediaIndexTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaIndexTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      isPurged: serializer.fromJson<bool>(json['isPurged']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'mediaType': serializer.toJson<String>(mediaType),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'isPurged': serializer.toJson<bool>(isPurged),
    };
  }

  MediaIndexTableData copyWith({
    String? id,
    String? checkId,
    String? mediaType,
    String? filePath,
    DateTime? createdAt,
    DateTime? expiresAt,
    bool? isPurged,
  }) => MediaIndexTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    mediaType: mediaType ?? this.mediaType,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
    isPurged: isPurged ?? this.isPurged,
  );
  MediaIndexTableData copyWithCompanion(MediaIndexTableCompanion data) {
    return MediaIndexTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isPurged: data.isPurged.present ? data.isPurged.value : this.isPurged,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaIndexTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('mediaType: $mediaType, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isPurged: $isPurged')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    mediaType,
    filePath,
    createdAt,
    expiresAt,
    isPurged,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaIndexTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.mediaType == this.mediaType &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt &&
          other.isPurged == this.isPurged);
}

class MediaIndexTableCompanion extends UpdateCompanion<MediaIndexTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<String> mediaType;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  final Value<DateTime> expiresAt;
  final Value<bool> isPurged;
  final Value<int> rowid;
  const MediaIndexTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isPurged = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaIndexTableCompanion.insert({
    required String id,
    required String checkId,
    required String mediaType,
    required String filePath,
    required DateTime createdAt,
    required DateTime expiresAt,
    this.isPurged = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       mediaType = Value(mediaType),
       filePath = Value(filePath),
       createdAt = Value(createdAt),
       expiresAt = Value(expiresAt);
  static Insertable<MediaIndexTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<String>? mediaType,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
    Expression<bool>? isPurged,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (mediaType != null) 'media_type': mediaType,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isPurged != null) 'is_purged': isPurged,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaIndexTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<String>? mediaType,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
    Value<DateTime>? expiresAt,
    Value<bool>? isPurged,
    Value<int>? rowid,
  }) {
    return MediaIndexTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      mediaType: mediaType ?? this.mediaType,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isPurged: isPurged ?? this.isPurged,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (isPurged.present) {
      map['is_purged'] = Variable<bool>(isPurged.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaIndexTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('mediaType: $mediaType, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isPurged: $isPurged, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditEventsTableTable extends AuditEventsTable
    with TableInfo<$AuditEventsTableTable, AuditEventsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditEventsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, eventType, details, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_events_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditEventsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEventsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEventsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $AuditEventsTableTable createAlias(String alias) {
    return $AuditEventsTableTable(attachedDatabase, alias);
  }
}

class AuditEventsTableData extends DataClass
    implements Insertable<AuditEventsTableData> {
  final String id;
  final String eventType;
  final String? details;
  final DateTime timestamp;
  const AuditEventsTableData({
    required this.id,
    required this.eventType,
    this.details,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  AuditEventsTableCompanion toCompanion(bool nullToAbsent) {
    return AuditEventsTableCompanion(
      id: Value(id),
      eventType: Value(eventType),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      timestamp: Value(timestamp),
    );
  }

  factory AuditEventsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEventsTableData(
      id: serializer.fromJson<String>(json['id']),
      eventType: serializer.fromJson<String>(json['eventType']),
      details: serializer.fromJson<String?>(json['details']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventType': serializer.toJson<String>(eventType),
      'details': serializer.toJson<String?>(details),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  AuditEventsTableData copyWith({
    String? id,
    String? eventType,
    Value<String?> details = const Value.absent(),
    DateTime? timestamp,
  }) => AuditEventsTableData(
    id: id ?? this.id,
    eventType: eventType ?? this.eventType,
    details: details.present ? details.value : this.details,
    timestamp: timestamp ?? this.timestamp,
  );
  AuditEventsTableData copyWithCompanion(AuditEventsTableCompanion data) {
    return AuditEventsTableData(
      id: data.id.present ? data.id.value : this.id,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      details: data.details.present ? data.details.value : this.details,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsTableData(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('details: $details, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventType, details, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEventsTableData &&
          other.id == this.id &&
          other.eventType == this.eventType &&
          other.details == this.details &&
          other.timestamp == this.timestamp);
}

class AuditEventsTableCompanion extends UpdateCompanion<AuditEventsTableData> {
  final Value<String> id;
  final Value<String> eventType;
  final Value<String?> details;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const AuditEventsTableCompanion({
    this.id = const Value.absent(),
    this.eventType = const Value.absent(),
    this.details = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditEventsTableCompanion.insert({
    required String id,
    required String eventType,
    this.details = const Value.absent(),
    required DateTime timestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventType = Value(eventType),
       timestamp = Value(timestamp);
  static Insertable<AuditEventsTableData> custom({
    Expression<String>? id,
    Expression<String>? eventType,
    Expression<String>? details,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventType != null) 'event_type': eventType,
      if (details != null) 'details': details,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditEventsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? eventType,
    Value<String?>? details,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return AuditEventsTableCompanion(
      id: id ?? this.id,
      eventType: eventType ?? this.eventType,
      details: details ?? this.details,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsTableCompanion(')
          ..write('id: $id, ')
          ..write('eventType: $eventType, ')
          ..write('details: $details, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChoiceResponsesTableTable extends ChoiceResponsesTable
    with TableInfo<$ChoiceResponsesTableTable, ChoiceResponsesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChoiceResponsesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkIdMeta = const VerificationMeta(
    'checkId',
  );
  @override
  late final GeneratedColumn<String> checkId = GeneratedColumn<String>(
    'check_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstChoiceMeta = const VerificationMeta(
    'firstChoice',
  );
  @override
  late final GeneratedColumn<String> firstChoice = GeneratedColumn<String>(
    'first_choice',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalChoiceMeta = const VerificationMeta(
    'finalChoice',
  );
  @override
  late final GeneratedColumn<String> finalChoice = GeneratedColumn<String>(
    'final_choice',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeMsMeta = const VerificationMeta('timeMs');
  @override
  late final GeneratedColumn<int> timeMs = GeneratedColumn<int>(
    'time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeCountMeta = const VerificationMeta(
    'changeCount',
  );
  @override
  late final GeneratedColumn<int> changeCount = GeneratedColumn<int>(
    'change_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _distractorTagMeta = const VerificationMeta(
    'distractorTag',
  );
  @override
  late final GeneratedColumn<String> distractorTag = GeneratedColumn<String>(
    'distractor_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxMarksMeta = const VerificationMeta(
    'maxMarks',
  );
  @override
  late final GeneratedColumn<double> maxMarks = GeneratedColumn<double>(
    'max_marks',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _selfRatingMeta = const VerificationMeta(
    'selfRating',
  );
  @override
  late final GeneratedColumn<String> selfRating = GeneratedColumn<String>(
    'self_rating',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checkId,
    itemId,
    level,
    type,
    firstChoice,
    finalChoice,
    timeMs,
    changeCount,
    distractorTag,
    weight,
    reason,
    createdAt,
    maxMarks,
    selfRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'choice_responses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChoiceResponsesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('check_id')) {
      context.handle(
        _checkIdMeta,
        checkId.isAcceptableOrUnknown(data['check_id']!, _checkIdMeta),
      );
    } else if (isInserting) {
      context.missing(_checkIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('first_choice')) {
      context.handle(
        _firstChoiceMeta,
        firstChoice.isAcceptableOrUnknown(
          data['first_choice']!,
          _firstChoiceMeta,
        ),
      );
    }
    if (data.containsKey('final_choice')) {
      context.handle(
        _finalChoiceMeta,
        finalChoice.isAcceptableOrUnknown(
          data['final_choice']!,
          _finalChoiceMeta,
        ),
      );
    }
    if (data.containsKey('time_ms')) {
      context.handle(
        _timeMsMeta,
        timeMs.isAcceptableOrUnknown(data['time_ms']!, _timeMsMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMsMeta);
    }
    if (data.containsKey('change_count')) {
      context.handle(
        _changeCountMeta,
        changeCount.isAcceptableOrUnknown(
          data['change_count']!,
          _changeCountMeta,
        ),
      );
    }
    if (data.containsKey('distractor_tag')) {
      context.handle(
        _distractorTagMeta,
        distractorTag.isAcceptableOrUnknown(
          data['distractor_tag']!,
          _distractorTagMeta,
        ),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('max_marks')) {
      context.handle(
        _maxMarksMeta,
        maxMarks.isAcceptableOrUnknown(data['max_marks']!, _maxMarksMeta),
      );
    }
    if (data.containsKey('self_rating')) {
      context.handle(
        _selfRatingMeta,
        selfRating.isAcceptableOrUnknown(data['self_rating']!, _selfRatingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChoiceResponsesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChoiceResponsesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checkId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      firstChoice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_choice'],
      ),
      finalChoice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}final_choice'],
      ),
      timeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_ms'],
      )!,
      changeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}change_count'],
      )!,
      distractorTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}distractor_tag'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      maxMarks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_marks'],
      )!,
      selfRating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}self_rating'],
      ),
    );
  }

  @override
  $ChoiceResponsesTableTable createAlias(String alias) {
    return $ChoiceResponsesTableTable(attachedDatabase, alias);
  }
}

class ChoiceResponsesTableData extends DataClass
    implements Insertable<ChoiceResponsesTableData> {
  final String id;
  final String checkId;
  final String itemId;
  final int level;
  final String type;
  final String? firstChoice;
  final String? finalChoice;
  final int timeMs;
  final int changeCount;
  final String? distractorTag;
  final double weight;
  final String? reason;
  final DateTime createdAt;
  final double maxMarks;
  final String? selfRating;
  const ChoiceResponsesTableData({
    required this.id,
    required this.checkId,
    required this.itemId,
    required this.level,
    required this.type,
    this.firstChoice,
    this.finalChoice,
    required this.timeMs,
    required this.changeCount,
    this.distractorTag,
    required this.weight,
    this.reason,
    required this.createdAt,
    required this.maxMarks,
    this.selfRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['check_id'] = Variable<String>(checkId);
    map['item_id'] = Variable<String>(itemId);
    map['level'] = Variable<int>(level);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || firstChoice != null) {
      map['first_choice'] = Variable<String>(firstChoice);
    }
    if (!nullToAbsent || finalChoice != null) {
      map['final_choice'] = Variable<String>(finalChoice);
    }
    map['time_ms'] = Variable<int>(timeMs);
    map['change_count'] = Variable<int>(changeCount);
    if (!nullToAbsent || distractorTag != null) {
      map['distractor_tag'] = Variable<String>(distractorTag);
    }
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['max_marks'] = Variable<double>(maxMarks);
    if (!nullToAbsent || selfRating != null) {
      map['self_rating'] = Variable<String>(selfRating);
    }
    return map;
  }

  ChoiceResponsesTableCompanion toCompanion(bool nullToAbsent) {
    return ChoiceResponsesTableCompanion(
      id: Value(id),
      checkId: Value(checkId),
      itemId: Value(itemId),
      level: Value(level),
      type: Value(type),
      firstChoice: firstChoice == null && nullToAbsent
          ? const Value.absent()
          : Value(firstChoice),
      finalChoice: finalChoice == null && nullToAbsent
          ? const Value.absent()
          : Value(finalChoice),
      timeMs: Value(timeMs),
      changeCount: Value(changeCount),
      distractorTag: distractorTag == null && nullToAbsent
          ? const Value.absent()
          : Value(distractorTag),
      weight: Value(weight),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
      maxMarks: Value(maxMarks),
      selfRating: selfRating == null && nullToAbsent
          ? const Value.absent()
          : Value(selfRating),
    );
  }

  factory ChoiceResponsesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChoiceResponsesTableData(
      id: serializer.fromJson<String>(json['id']),
      checkId: serializer.fromJson<String>(json['checkId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      level: serializer.fromJson<int>(json['level']),
      type: serializer.fromJson<String>(json['type']),
      firstChoice: serializer.fromJson<String?>(json['firstChoice']),
      finalChoice: serializer.fromJson<String?>(json['finalChoice']),
      timeMs: serializer.fromJson<int>(json['timeMs']),
      changeCount: serializer.fromJson<int>(json['changeCount']),
      distractorTag: serializer.fromJson<String?>(json['distractorTag']),
      weight: serializer.fromJson<double>(json['weight']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      maxMarks: serializer.fromJson<double>(json['maxMarks']),
      selfRating: serializer.fromJson<String?>(json['selfRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checkId': serializer.toJson<String>(checkId),
      'itemId': serializer.toJson<String>(itemId),
      'level': serializer.toJson<int>(level),
      'type': serializer.toJson<String>(type),
      'firstChoice': serializer.toJson<String?>(firstChoice),
      'finalChoice': serializer.toJson<String?>(finalChoice),
      'timeMs': serializer.toJson<int>(timeMs),
      'changeCount': serializer.toJson<int>(changeCount),
      'distractorTag': serializer.toJson<String?>(distractorTag),
      'weight': serializer.toJson<double>(weight),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'maxMarks': serializer.toJson<double>(maxMarks),
      'selfRating': serializer.toJson<String?>(selfRating),
    };
  }

  ChoiceResponsesTableData copyWith({
    String? id,
    String? checkId,
    String? itemId,
    int? level,
    String? type,
    Value<String?> firstChoice = const Value.absent(),
    Value<String?> finalChoice = const Value.absent(),
    int? timeMs,
    int? changeCount,
    Value<String?> distractorTag = const Value.absent(),
    double? weight,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
    double? maxMarks,
    Value<String?> selfRating = const Value.absent(),
  }) => ChoiceResponsesTableData(
    id: id ?? this.id,
    checkId: checkId ?? this.checkId,
    itemId: itemId ?? this.itemId,
    level: level ?? this.level,
    type: type ?? this.type,
    firstChoice: firstChoice.present ? firstChoice.value : this.firstChoice,
    finalChoice: finalChoice.present ? finalChoice.value : this.finalChoice,
    timeMs: timeMs ?? this.timeMs,
    changeCount: changeCount ?? this.changeCount,
    distractorTag: distractorTag.present
        ? distractorTag.value
        : this.distractorTag,
    weight: weight ?? this.weight,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
    maxMarks: maxMarks ?? this.maxMarks,
    selfRating: selfRating.present ? selfRating.value : this.selfRating,
  );
  ChoiceResponsesTableData copyWithCompanion(
    ChoiceResponsesTableCompanion data,
  ) {
    return ChoiceResponsesTableData(
      id: data.id.present ? data.id.value : this.id,
      checkId: data.checkId.present ? data.checkId.value : this.checkId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      level: data.level.present ? data.level.value : this.level,
      type: data.type.present ? data.type.value : this.type,
      firstChoice: data.firstChoice.present
          ? data.firstChoice.value
          : this.firstChoice,
      finalChoice: data.finalChoice.present
          ? data.finalChoice.value
          : this.finalChoice,
      timeMs: data.timeMs.present ? data.timeMs.value : this.timeMs,
      changeCount: data.changeCount.present
          ? data.changeCount.value
          : this.changeCount,
      distractorTag: data.distractorTag.present
          ? data.distractorTag.value
          : this.distractorTag,
      weight: data.weight.present ? data.weight.value : this.weight,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      maxMarks: data.maxMarks.present ? data.maxMarks.value : this.maxMarks,
      selfRating: data.selfRating.present
          ? data.selfRating.value
          : this.selfRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceResponsesTableData(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('itemId: $itemId, ')
          ..write('level: $level, ')
          ..write('type: $type, ')
          ..write('firstChoice: $firstChoice, ')
          ..write('finalChoice: $finalChoice, ')
          ..write('timeMs: $timeMs, ')
          ..write('changeCount: $changeCount, ')
          ..write('distractorTag: $distractorTag, ')
          ..write('weight: $weight, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('maxMarks: $maxMarks, ')
          ..write('selfRating: $selfRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checkId,
    itemId,
    level,
    type,
    firstChoice,
    finalChoice,
    timeMs,
    changeCount,
    distractorTag,
    weight,
    reason,
    createdAt,
    maxMarks,
    selfRating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoiceResponsesTableData &&
          other.id == this.id &&
          other.checkId == this.checkId &&
          other.itemId == this.itemId &&
          other.level == this.level &&
          other.type == this.type &&
          other.firstChoice == this.firstChoice &&
          other.finalChoice == this.finalChoice &&
          other.timeMs == this.timeMs &&
          other.changeCount == this.changeCount &&
          other.distractorTag == this.distractorTag &&
          other.weight == this.weight &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt &&
          other.maxMarks == this.maxMarks &&
          other.selfRating == this.selfRating);
}

class ChoiceResponsesTableCompanion
    extends UpdateCompanion<ChoiceResponsesTableData> {
  final Value<String> id;
  final Value<String> checkId;
  final Value<String> itemId;
  final Value<int> level;
  final Value<String> type;
  final Value<String?> firstChoice;
  final Value<String?> finalChoice;
  final Value<int> timeMs;
  final Value<int> changeCount;
  final Value<String?> distractorTag;
  final Value<double> weight;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<double> maxMarks;
  final Value<String?> selfRating;
  final Value<int> rowid;
  const ChoiceResponsesTableCompanion({
    this.id = const Value.absent(),
    this.checkId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.level = const Value.absent(),
    this.type = const Value.absent(),
    this.firstChoice = const Value.absent(),
    this.finalChoice = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.changeCount = const Value.absent(),
    this.distractorTag = const Value.absent(),
    this.weight = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.maxMarks = const Value.absent(),
    this.selfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChoiceResponsesTableCompanion.insert({
    required String id,
    required String checkId,
    required String itemId,
    required int level,
    required String type,
    this.firstChoice = const Value.absent(),
    this.finalChoice = const Value.absent(),
    required int timeMs,
    this.changeCount = const Value.absent(),
    this.distractorTag = const Value.absent(),
    this.weight = const Value.absent(),
    this.reason = const Value.absent(),
    required DateTime createdAt,
    this.maxMarks = const Value.absent(),
    this.selfRating = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checkId = Value(checkId),
       itemId = Value(itemId),
       level = Value(level),
       type = Value(type),
       timeMs = Value(timeMs),
       createdAt = Value(createdAt);
  static Insertable<ChoiceResponsesTableData> custom({
    Expression<String>? id,
    Expression<String>? checkId,
    Expression<String>? itemId,
    Expression<int>? level,
    Expression<String>? type,
    Expression<String>? firstChoice,
    Expression<String>? finalChoice,
    Expression<int>? timeMs,
    Expression<int>? changeCount,
    Expression<String>? distractorTag,
    Expression<double>? weight,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<double>? maxMarks,
    Expression<String>? selfRating,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkId != null) 'check_id': checkId,
      if (itemId != null) 'item_id': itemId,
      if (level != null) 'level': level,
      if (type != null) 'type': type,
      if (firstChoice != null) 'first_choice': firstChoice,
      if (finalChoice != null) 'final_choice': finalChoice,
      if (timeMs != null) 'time_ms': timeMs,
      if (changeCount != null) 'change_count': changeCount,
      if (distractorTag != null) 'distractor_tag': distractorTag,
      if (weight != null) 'weight': weight,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (maxMarks != null) 'max_marks': maxMarks,
      if (selfRating != null) 'self_rating': selfRating,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChoiceResponsesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? checkId,
    Value<String>? itemId,
    Value<int>? level,
    Value<String>? type,
    Value<String?>? firstChoice,
    Value<String?>? finalChoice,
    Value<int>? timeMs,
    Value<int>? changeCount,
    Value<String?>? distractorTag,
    Value<double>? weight,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
    Value<double>? maxMarks,
    Value<String?>? selfRating,
    Value<int>? rowid,
  }) {
    return ChoiceResponsesTableCompanion(
      id: id ?? this.id,
      checkId: checkId ?? this.checkId,
      itemId: itemId ?? this.itemId,
      level: level ?? this.level,
      type: type ?? this.type,
      firstChoice: firstChoice ?? this.firstChoice,
      finalChoice: finalChoice ?? this.finalChoice,
      timeMs: timeMs ?? this.timeMs,
      changeCount: changeCount ?? this.changeCount,
      distractorTag: distractorTag ?? this.distractorTag,
      weight: weight ?? this.weight,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      maxMarks: maxMarks ?? this.maxMarks,
      selfRating: selfRating ?? this.selfRating,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checkId.present) {
      map['check_id'] = Variable<String>(checkId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (firstChoice.present) {
      map['first_choice'] = Variable<String>(firstChoice.value);
    }
    if (finalChoice.present) {
      map['final_choice'] = Variable<String>(finalChoice.value);
    }
    if (timeMs.present) {
      map['time_ms'] = Variable<int>(timeMs.value);
    }
    if (changeCount.present) {
      map['change_count'] = Variable<int>(changeCount.value);
    }
    if (distractorTag.present) {
      map['distractor_tag'] = Variable<String>(distractorTag.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (maxMarks.present) {
      map['max_marks'] = Variable<double>(maxMarks.value);
    }
    if (selfRating.present) {
      map['self_rating'] = Variable<String>(selfRating.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceResponsesTableCompanion(')
          ..write('id: $id, ')
          ..write('checkId: $checkId, ')
          ..write('itemId: $itemId, ')
          ..write('level: $level, ')
          ..write('type: $type, ')
          ..write('firstChoice: $firstChoice, ')
          ..write('finalChoice: $finalChoice, ')
          ..write('timeMs: $timeMs, ')
          ..write('changeCount: $changeCount, ')
          ..write('distractorTag: $distractorTag, ')
          ..write('weight: $weight, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('maxMarks: $maxMarks, ')
          ..write('selfRating: $selfRating, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeacherProfileTableTable extends TeacherProfileTable
    with TableInfo<$TeacherProfileTableTable, TeacherProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeacherProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teacherNameMeta = const VerificationMeta(
    'teacherName',
  );
  @override
  late final GeneratedColumn<String> teacherName = GeneratedColumn<String>(
    'teacher_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolNameMeta = const VerificationMeta(
    'schoolName',
  );
  @override
  late final GeneratedColumn<String> schoolName = GeneratedColumn<String>(
    'school_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredLanguageMeta = const VerificationMeta(
    'preferredLanguage',
  );
  @override
  late final GeneratedColumn<String> preferredLanguage =
      GeneratedColumn<String>(
        'preferred_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('hi'),
      );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _udiseCodeMeta = const VerificationMeta(
    'udiseCode',
  );
  @override
  late final GeneratedColumn<String> udiseCode = GeneratedColumn<String>(
    'udise_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockMeta = const VerificationMeta('block');
  @override
  late final GeneratedColumn<String> block = GeneratedColumn<String>(
    'block',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearsTeachingMeta = const VerificationMeta(
    'yearsTeaching',
  );
  @override
  late final GeneratedColumn<int> yearsTeaching = GeneratedColumn<int>(
    'years_teaching',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teacherName,
    schoolName,
    preferredLanguage,
    displayName,
    role,
    udiseCode,
    block,
    district,
    state,
    yearsTeaching,
    phone,
    email,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teacher_profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeacherProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('teacher_name')) {
      context.handle(
        _teacherNameMeta,
        teacherName.isAcceptableOrUnknown(
          data['teacher_name']!,
          _teacherNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_teacherNameMeta);
    }
    if (data.containsKey('school_name')) {
      context.handle(
        _schoolNameMeta,
        schoolName.isAcceptableOrUnknown(data['school_name']!, _schoolNameMeta),
      );
    }
    if (data.containsKey('preferred_language')) {
      context.handle(
        _preferredLanguageMeta,
        preferredLanguage.isAcceptableOrUnknown(
          data['preferred_language']!,
          _preferredLanguageMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('udise_code')) {
      context.handle(
        _udiseCodeMeta,
        udiseCode.isAcceptableOrUnknown(data['udise_code']!, _udiseCodeMeta),
      );
    }
    if (data.containsKey('block')) {
      context.handle(
        _blockMeta,
        block.isAcceptableOrUnknown(data['block']!, _blockMeta),
      );
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('years_teaching')) {
      context.handle(
        _yearsTeachingMeta,
        yearsTeaching.isAcceptableOrUnknown(
          data['years_teaching']!,
          _yearsTeachingMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeacherProfileTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeacherProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teacherName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_name'],
      )!,
      schoolName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school_name'],
      ),
      preferredLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_language'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      ),
      udiseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}udise_code'],
      ),
      block: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block'],
      ),
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      yearsTeaching: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}years_teaching'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TeacherProfileTableTable createAlias(String alias) {
    return $TeacherProfileTableTable(attachedDatabase, alias);
  }
}

class TeacherProfileTableData extends DataClass
    implements Insertable<TeacherProfileTableData> {
  final String id;
  final String teacherName;
  final String? schoolName;
  final String preferredLanguage;
  final String? displayName;
  final String? role;
  final String? udiseCode;
  final String? block;
  final String? district;
  final String? state;
  final int? yearsTeaching;
  final String? phone;
  final String? email;
  final DateTime updatedAt;
  const TeacherProfileTableData({
    required this.id,
    required this.teacherName,
    this.schoolName,
    required this.preferredLanguage,
    this.displayName,
    this.role,
    this.udiseCode,
    this.block,
    this.district,
    this.state,
    this.yearsTeaching,
    this.phone,
    this.email,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['teacher_name'] = Variable<String>(teacherName);
    if (!nullToAbsent || schoolName != null) {
      map['school_name'] = Variable<String>(schoolName);
    }
    map['preferred_language'] = Variable<String>(preferredLanguage);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || udiseCode != null) {
      map['udise_code'] = Variable<String>(udiseCode);
    }
    if (!nullToAbsent || block != null) {
      map['block'] = Variable<String>(block);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || yearsTeaching != null) {
      map['years_teaching'] = Variable<int>(yearsTeaching);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeacherProfileTableCompanion toCompanion(bool nullToAbsent) {
    return TeacherProfileTableCompanion(
      id: Value(id),
      teacherName: Value(teacherName),
      schoolName: schoolName == null && nullToAbsent
          ? const Value.absent()
          : Value(schoolName),
      preferredLanguage: Value(preferredLanguage),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      udiseCode: udiseCode == null && nullToAbsent
          ? const Value.absent()
          : Value(udiseCode),
      block: block == null && nullToAbsent
          ? const Value.absent()
          : Value(block),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      yearsTeaching: yearsTeaching == null && nullToAbsent
          ? const Value.absent()
          : Value(yearsTeaching),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      updatedAt: Value(updatedAt),
    );
  }

  factory TeacherProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherProfileTableData(
      id: serializer.fromJson<String>(json['id']),
      teacherName: serializer.fromJson<String>(json['teacherName']),
      schoolName: serializer.fromJson<String?>(json['schoolName']),
      preferredLanguage: serializer.fromJson<String>(json['preferredLanguage']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      role: serializer.fromJson<String?>(json['role']),
      udiseCode: serializer.fromJson<String?>(json['udiseCode']),
      block: serializer.fromJson<String?>(json['block']),
      district: serializer.fromJson<String?>(json['district']),
      state: serializer.fromJson<String?>(json['state']),
      yearsTeaching: serializer.fromJson<int?>(json['yearsTeaching']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teacherName': serializer.toJson<String>(teacherName),
      'schoolName': serializer.toJson<String?>(schoolName),
      'preferredLanguage': serializer.toJson<String>(preferredLanguage),
      'displayName': serializer.toJson<String?>(displayName),
      'role': serializer.toJson<String?>(role),
      'udiseCode': serializer.toJson<String?>(udiseCode),
      'block': serializer.toJson<String?>(block),
      'district': serializer.toJson<String?>(district),
      'state': serializer.toJson<String?>(state),
      'yearsTeaching': serializer.toJson<int?>(yearsTeaching),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TeacherProfileTableData copyWith({
    String? id,
    String? teacherName,
    Value<String?> schoolName = const Value.absent(),
    String? preferredLanguage,
    Value<String?> displayName = const Value.absent(),
    Value<String?> role = const Value.absent(),
    Value<String?> udiseCode = const Value.absent(),
    Value<String?> block = const Value.absent(),
    Value<String?> district = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<int?> yearsTeaching = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    DateTime? updatedAt,
  }) => TeacherProfileTableData(
    id: id ?? this.id,
    teacherName: teacherName ?? this.teacherName,
    schoolName: schoolName.present ? schoolName.value : this.schoolName,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    displayName: displayName.present ? displayName.value : this.displayName,
    role: role.present ? role.value : this.role,
    udiseCode: udiseCode.present ? udiseCode.value : this.udiseCode,
    block: block.present ? block.value : this.block,
    district: district.present ? district.value : this.district,
    state: state.present ? state.value : this.state,
    yearsTeaching: yearsTeaching.present
        ? yearsTeaching.value
        : this.yearsTeaching,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TeacherProfileTableData copyWithCompanion(TeacherProfileTableCompanion data) {
    return TeacherProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      teacherName: data.teacherName.present
          ? data.teacherName.value
          : this.teacherName,
      schoolName: data.schoolName.present
          ? data.schoolName.value
          : this.schoolName,
      preferredLanguage: data.preferredLanguage.present
          ? data.preferredLanguage.value
          : this.preferredLanguage,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      role: data.role.present ? data.role.value : this.role,
      udiseCode: data.udiseCode.present ? data.udiseCode.value : this.udiseCode,
      block: data.block.present ? data.block.value : this.block,
      district: data.district.present ? data.district.value : this.district,
      state: data.state.present ? data.state.value : this.state,
      yearsTeaching: data.yearsTeaching.present
          ? data.yearsTeaching.value
          : this.yearsTeaching,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherProfileTableData(')
          ..write('id: $id, ')
          ..write('teacherName: $teacherName, ')
          ..write('schoolName: $schoolName, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('udiseCode: $udiseCode, ')
          ..write('block: $block, ')
          ..write('district: $district, ')
          ..write('state: $state, ')
          ..write('yearsTeaching: $yearsTeaching, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teacherName,
    schoolName,
    preferredLanguage,
    displayName,
    role,
    udiseCode,
    block,
    district,
    state,
    yearsTeaching,
    phone,
    email,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherProfileTableData &&
          other.id == this.id &&
          other.teacherName == this.teacherName &&
          other.schoolName == this.schoolName &&
          other.preferredLanguage == this.preferredLanguage &&
          other.displayName == this.displayName &&
          other.role == this.role &&
          other.udiseCode == this.udiseCode &&
          other.block == this.block &&
          other.district == this.district &&
          other.state == this.state &&
          other.yearsTeaching == this.yearsTeaching &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.updatedAt == this.updatedAt);
}

class TeacherProfileTableCompanion
    extends UpdateCompanion<TeacherProfileTableData> {
  final Value<String> id;
  final Value<String> teacherName;
  final Value<String?> schoolName;
  final Value<String> preferredLanguage;
  final Value<String?> displayName;
  final Value<String?> role;
  final Value<String?> udiseCode;
  final Value<String?> block;
  final Value<String?> district;
  final Value<String?> state;
  final Value<int?> yearsTeaching;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TeacherProfileTableCompanion({
    this.id = const Value.absent(),
    this.teacherName = const Value.absent(),
    this.schoolName = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.udiseCode = const Value.absent(),
    this.block = const Value.absent(),
    this.district = const Value.absent(),
    this.state = const Value.absent(),
    this.yearsTeaching = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeacherProfileTableCompanion.insert({
    required String id,
    required String teacherName,
    this.schoolName = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.udiseCode = const Value.absent(),
    this.block = const Value.absent(),
    this.district = const Value.absent(),
    this.state = const Value.absent(),
    this.yearsTeaching = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teacherName = Value(teacherName),
       updatedAt = Value(updatedAt);
  static Insertable<TeacherProfileTableData> custom({
    Expression<String>? id,
    Expression<String>? teacherName,
    Expression<String>? schoolName,
    Expression<String>? preferredLanguage,
    Expression<String>? displayName,
    Expression<String>? role,
    Expression<String>? udiseCode,
    Expression<String>? block,
    Expression<String>? district,
    Expression<String>? state,
    Expression<int>? yearsTeaching,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teacherName != null) 'teacher_name': teacherName,
      if (schoolName != null) 'school_name': schoolName,
      if (preferredLanguage != null) 'preferred_language': preferredLanguage,
      if (displayName != null) 'display_name': displayName,
      if (role != null) 'role': role,
      if (udiseCode != null) 'udise_code': udiseCode,
      if (block != null) 'block': block,
      if (district != null) 'district': district,
      if (state != null) 'state': state,
      if (yearsTeaching != null) 'years_teaching': yearsTeaching,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeacherProfileTableCompanion copyWith({
    Value<String>? id,
    Value<String>? teacherName,
    Value<String?>? schoolName,
    Value<String>? preferredLanguage,
    Value<String?>? displayName,
    Value<String?>? role,
    Value<String?>? udiseCode,
    Value<String?>? block,
    Value<String?>? district,
    Value<String?>? state,
    Value<int?>? yearsTeaching,
    Value<String?>? phone,
    Value<String?>? email,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TeacherProfileTableCompanion(
      id: id ?? this.id,
      teacherName: teacherName ?? this.teacherName,
      schoolName: schoolName ?? this.schoolName,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      udiseCode: udiseCode ?? this.udiseCode,
      block: block ?? this.block,
      district: district ?? this.district,
      state: state ?? this.state,
      yearsTeaching: yearsTeaching ?? this.yearsTeaching,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teacherName.present) {
      map['teacher_name'] = Variable<String>(teacherName.value);
    }
    if (schoolName.present) {
      map['school_name'] = Variable<String>(schoolName.value);
    }
    if (preferredLanguage.present) {
      map['preferred_language'] = Variable<String>(preferredLanguage.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (udiseCode.present) {
      map['udise_code'] = Variable<String>(udiseCode.value);
    }
    if (block.present) {
      map['block'] = Variable<String>(block.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (yearsTeaching.present) {
      map['years_teaching'] = Variable<int>(yearsTeaching.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('teacherName: $teacherName, ')
          ..write('schoolName: $schoolName, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('udiseCode: $udiseCode, ')
          ..write('block: $block, ')
          ..write('district: $district, ')
          ..write('state: $state, ')
          ..write('yearsTeaching: $yearsTeaching, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  late final $ClassesTableTable classesTable = $ClassesTableTable(this);
  late final $ChildrenTableTable childrenTable = $ChildrenTableTable(this);
  late final $ConsentsTableTable consentsTable = $ConsentsTableTable(this);
  late final $GroupAssignmentsTableTable groupAssignmentsTable =
      $GroupAssignmentsTableTable(this);
  late final $ChecksTableTable checksTable = $ChecksTableTable(this);
  late final $WordMarksTableTable wordMarksTable = $WordMarksTableTable(this);
  late final $RetellPointsTableTable retellPointsTable =
      $RetellPointsTableTable(this);
  late final $QuestionAnswersTableTable questionAnswersTable =
      $QuestionAnswersTableTable(this);
  late final $DictationItemsTableTable dictationItemsTable =
      $DictationItemsTableTable(this);
  late final $ListeningChecksTableTable listeningChecksTable =
      $ListeningChecksTableTable(this);
  late final $ResultsTableTable resultsTable = $ResultsTableTable(this);
  late final $PracticeNeedsTableTable practiceNeedsTable =
      $PracticeNeedsTableTable(this);
  late final $WeeklyPlanTicksTableTable weeklyPlanTicksTable =
      $WeeklyPlanTicksTableTable(this);
  late final $ParentReportsTableTable parentReportsTable =
      $ParentReportsTableTable(this);
  late final $AcceptedPronunciationsTableTable acceptedPronunciationsTable =
      $AcceptedPronunciationsTableTable(this);
  late final $MediaIndexTableTable mediaIndexTable = $MediaIndexTableTable(
    this,
  );
  late final $AuditEventsTableTable auditEventsTable = $AuditEventsTableTable(
    this,
  );
  late final $ChoiceResponsesTableTable choiceResponsesTable =
      $ChoiceResponsesTableTable(this);
  late final $TeacherProfileTableTable teacherProfileTable =
      $TeacherProfileTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettingsTable,
    classesTable,
    childrenTable,
    consentsTable,
    groupAssignmentsTable,
    checksTable,
    wordMarksTable,
    retellPointsTable,
    questionAnswersTable,
    dictationItemsTable,
    listeningChecksTable,
    resultsTable,
    practiceNeedsTable,
    weeklyPlanTicksTable,
    parentReportsTable,
    acceptedPronunciationsTable,
    mediaIndexTable,
    auditEventsTable,
    choiceResponsesTable,
    teacherProfileTable,
  ];
}

typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      required String id,
      Value<String> activeScope,
      Value<String> appLanguage,
      Value<String> readingLanguage,
      Value<String?> passcodeHash,
      Value<String?> passcodeSalt,
      Value<int> failedPasscodeAttempts,
      Value<DateTime?> lockoutUntil,
      Value<bool> useFingerprint,
      Value<double> textSizeScale,
      Value<int> suggestedChecksWindowDays,
      Value<int> recheckPeriodWeeks,
      Value<int> backupReminderPeriodDays,
      Value<DateTime?> lastBackupTimestamp,
      Value<String?> legalReviewerName,
      Value<DateTime?> legalReviewDate,
      Value<bool> legalReviewCompleted,
      Value<String?> activeClassId,
      Value<bool> deviceDataConsentGiven,
      Value<DateTime?> deviceDataConsentDate,
      Value<bool> audioRecordingConsentGiven,
      Value<DateTime?> audioRecordingConsentDate,
      Value<int> rowid,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> id,
      Value<String> activeScope,
      Value<String> appLanguage,
      Value<String> readingLanguage,
      Value<String?> passcodeHash,
      Value<String?> passcodeSalt,
      Value<int> failedPasscodeAttempts,
      Value<DateTime?> lockoutUntil,
      Value<bool> useFingerprint,
      Value<double> textSizeScale,
      Value<int> suggestedChecksWindowDays,
      Value<int> recheckPeriodWeeks,
      Value<int> backupReminderPeriodDays,
      Value<DateTime?> lastBackupTimestamp,
      Value<String?> legalReviewerName,
      Value<DateTime?> legalReviewDate,
      Value<bool> legalReviewCompleted,
      Value<String?> activeClassId,
      Value<bool> deviceDataConsentGiven,
      Value<DateTime?> deviceDataConsentDate,
      Value<bool> audioRecordingConsentGiven,
      Value<DateTime?> audioRecordingConsentDate,
      Value<int> rowid,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeScope => $composableBuilder(
    column: $table.activeScope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appLanguage => $composableBuilder(
    column: $table.appLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingLanguage => $composableBuilder(
    column: $table.readingLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passcodeHash => $composableBuilder(
    column: $table.passcodeHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passcodeSalt => $composableBuilder(
    column: $table.passcodeSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedPasscodeAttempts => $composableBuilder(
    column: $table.failedPasscodeAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lockoutUntil => $composableBuilder(
    column: $table.lockoutUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useFingerprint => $composableBuilder(
    column: $table.useFingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get textSizeScale => $composableBuilder(
    column: $table.textSizeScale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get suggestedChecksWindowDays => $composableBuilder(
    column: $table.suggestedChecksWindowDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recheckPeriodWeeks => $composableBuilder(
    column: $table.recheckPeriodWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get backupReminderPeriodDays => $composableBuilder(
    column: $table.backupReminderPeriodDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalReviewerName => $composableBuilder(
    column: $table.legalReviewerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get legalReviewDate => $composableBuilder(
    column: $table.legalReviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get legalReviewCompleted => $composableBuilder(
    column: $table.legalReviewCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeClassId => $composableBuilder(
    column: $table.activeClassId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deviceDataConsentGiven => $composableBuilder(
    column: $table.deviceDataConsentGiven,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deviceDataConsentDate => $composableBuilder(
    column: $table.deviceDataConsentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get audioRecordingConsentGiven => $composableBuilder(
    column: $table.audioRecordingConsentGiven,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get audioRecordingConsentDate => $composableBuilder(
    column: $table.audioRecordingConsentDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeScope => $composableBuilder(
    column: $table.activeScope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appLanguage => $composableBuilder(
    column: $table.appLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingLanguage => $composableBuilder(
    column: $table.readingLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passcodeHash => $composableBuilder(
    column: $table.passcodeHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passcodeSalt => $composableBuilder(
    column: $table.passcodeSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedPasscodeAttempts => $composableBuilder(
    column: $table.failedPasscodeAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lockoutUntil => $composableBuilder(
    column: $table.lockoutUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useFingerprint => $composableBuilder(
    column: $table.useFingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get textSizeScale => $composableBuilder(
    column: $table.textSizeScale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get suggestedChecksWindowDays => $composableBuilder(
    column: $table.suggestedChecksWindowDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recheckPeriodWeeks => $composableBuilder(
    column: $table.recheckPeriodWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backupReminderPeriodDays => $composableBuilder(
    column: $table.backupReminderPeriodDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalReviewerName => $composableBuilder(
    column: $table.legalReviewerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get legalReviewDate => $composableBuilder(
    column: $table.legalReviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get legalReviewCompleted => $composableBuilder(
    column: $table.legalReviewCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeClassId => $composableBuilder(
    column: $table.activeClassId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deviceDataConsentGiven => $composableBuilder(
    column: $table.deviceDataConsentGiven,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deviceDataConsentDate => $composableBuilder(
    column: $table.deviceDataConsentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get audioRecordingConsentGiven => $composableBuilder(
    column: $table.audioRecordingConsentGiven,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get audioRecordingConsentDate => $composableBuilder(
    column: $table.audioRecordingConsentDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activeScope => $composableBuilder(
    column: $table.activeScope,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appLanguage => $composableBuilder(
    column: $table.appLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingLanguage => $composableBuilder(
    column: $table.readingLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passcodeHash => $composableBuilder(
    column: $table.passcodeHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passcodeSalt => $composableBuilder(
    column: $table.passcodeSalt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failedPasscodeAttempts => $composableBuilder(
    column: $table.failedPasscodeAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lockoutUntil => $composableBuilder(
    column: $table.lockoutUntil,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get useFingerprint => $composableBuilder(
    column: $table.useFingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get textSizeScale => $composableBuilder(
    column: $table.textSizeScale,
    builder: (column) => column,
  );

  GeneratedColumn<int> get suggestedChecksWindowDays => $composableBuilder(
    column: $table.suggestedChecksWindowDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recheckPeriodWeeks => $composableBuilder(
    column: $table.recheckPeriodWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get backupReminderPeriodDays => $composableBuilder(
    column: $table.backupReminderPeriodDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get legalReviewerName => $composableBuilder(
    column: $table.legalReviewerName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get legalReviewDate => $composableBuilder(
    column: $table.legalReviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get legalReviewCompleted => $composableBuilder(
    column: $table.legalReviewCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activeClassId => $composableBuilder(
    column: $table.activeClassId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deviceDataConsentGiven => $composableBuilder(
    column: $table.deviceDataConsentGiven,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deviceDataConsentDate => $composableBuilder(
    column: $table.deviceDataConsentDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get audioRecordingConsentGiven => $composableBuilder(
    column: $table.audioRecordingConsentGiven,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get audioRecordingConsentDate => $composableBuilder(
    column: $table.audioRecordingConsentDate,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsTableData
            >,
          ),
          AppSettingsTableData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> activeScope = const Value.absent(),
                Value<String> appLanguage = const Value.absent(),
                Value<String> readingLanguage = const Value.absent(),
                Value<String?> passcodeHash = const Value.absent(),
                Value<String?> passcodeSalt = const Value.absent(),
                Value<int> failedPasscodeAttempts = const Value.absent(),
                Value<DateTime?> lockoutUntil = const Value.absent(),
                Value<bool> useFingerprint = const Value.absent(),
                Value<double> textSizeScale = const Value.absent(),
                Value<int> suggestedChecksWindowDays = const Value.absent(),
                Value<int> recheckPeriodWeeks = const Value.absent(),
                Value<int> backupReminderPeriodDays = const Value.absent(),
                Value<DateTime?> lastBackupTimestamp = const Value.absent(),
                Value<String?> legalReviewerName = const Value.absent(),
                Value<DateTime?> legalReviewDate = const Value.absent(),
                Value<bool> legalReviewCompleted = const Value.absent(),
                Value<String?> activeClassId = const Value.absent(),
                Value<bool> deviceDataConsentGiven = const Value.absent(),
                Value<DateTime?> deviceDataConsentDate = const Value.absent(),
                Value<bool> audioRecordingConsentGiven = const Value.absent(),
                Value<DateTime?> audioRecordingConsentDate =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                activeScope: activeScope,
                appLanguage: appLanguage,
                readingLanguage: readingLanguage,
                passcodeHash: passcodeHash,
                passcodeSalt: passcodeSalt,
                failedPasscodeAttempts: failedPasscodeAttempts,
                lockoutUntil: lockoutUntil,
                useFingerprint: useFingerprint,
                textSizeScale: textSizeScale,
                suggestedChecksWindowDays: suggestedChecksWindowDays,
                recheckPeriodWeeks: recheckPeriodWeeks,
                backupReminderPeriodDays: backupReminderPeriodDays,
                lastBackupTimestamp: lastBackupTimestamp,
                legalReviewerName: legalReviewerName,
                legalReviewDate: legalReviewDate,
                legalReviewCompleted: legalReviewCompleted,
                activeClassId: activeClassId,
                deviceDataConsentGiven: deviceDataConsentGiven,
                deviceDataConsentDate: deviceDataConsentDate,
                audioRecordingConsentGiven: audioRecordingConsentGiven,
                audioRecordingConsentDate: audioRecordingConsentDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> activeScope = const Value.absent(),
                Value<String> appLanguage = const Value.absent(),
                Value<String> readingLanguage = const Value.absent(),
                Value<String?> passcodeHash = const Value.absent(),
                Value<String?> passcodeSalt = const Value.absent(),
                Value<int> failedPasscodeAttempts = const Value.absent(),
                Value<DateTime?> lockoutUntil = const Value.absent(),
                Value<bool> useFingerprint = const Value.absent(),
                Value<double> textSizeScale = const Value.absent(),
                Value<int> suggestedChecksWindowDays = const Value.absent(),
                Value<int> recheckPeriodWeeks = const Value.absent(),
                Value<int> backupReminderPeriodDays = const Value.absent(),
                Value<DateTime?> lastBackupTimestamp = const Value.absent(),
                Value<String?> legalReviewerName = const Value.absent(),
                Value<DateTime?> legalReviewDate = const Value.absent(),
                Value<bool> legalReviewCompleted = const Value.absent(),
                Value<String?> activeClassId = const Value.absent(),
                Value<bool> deviceDataConsentGiven = const Value.absent(),
                Value<DateTime?> deviceDataConsentDate = const Value.absent(),
                Value<bool> audioRecordingConsentGiven = const Value.absent(),
                Value<DateTime?> audioRecordingConsentDate =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                activeScope: activeScope,
                appLanguage: appLanguage,
                readingLanguage: readingLanguage,
                passcodeHash: passcodeHash,
                passcodeSalt: passcodeSalt,
                failedPasscodeAttempts: failedPasscodeAttempts,
                lockoutUntil: lockoutUntil,
                useFingerprint: useFingerprint,
                textSizeScale: textSizeScale,
                suggestedChecksWindowDays: suggestedChecksWindowDays,
                recheckPeriodWeeks: recheckPeriodWeeks,
                backupReminderPeriodDays: backupReminderPeriodDays,
                lastBackupTimestamp: lastBackupTimestamp,
                legalReviewerName: legalReviewerName,
                legalReviewDate: legalReviewDate,
                legalReviewCompleted: legalReviewCompleted,
                activeClassId: activeClassId,
                deviceDataConsentGiven: deviceDataConsentGiven,
                deviceDataConsentDate: deviceDataConsentDate,
                audioRecordingConsentGiven: audioRecordingConsentGiven,
                audioRecordingConsentDate: audioRecordingConsentDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTableTable, AppSettingsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTableTable,
                    AppSettingsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsTableData,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData
        >,
      ),
      AppSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$ClassesTableTableCreateCompanionBuilder =
    ClassesTableCompanion Function({
      required String id,
      required String scope,
      required String name,
      required int grade,
      required String section,
      required String curriculum,
      required String checkLanguage,
      required String mediumOfInstruction,
      Value<String?> textbookId,
      Value<String?> currentChapter,
      Value<String?> homeDialect,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ClassesTableTableUpdateCompanionBuilder =
    ClassesTableCompanion Function({
      Value<String> id,
      Value<String> scope,
      Value<String> name,
      Value<int> grade,
      Value<String> section,
      Value<String> curriculum,
      Value<String> checkLanguage,
      Value<String> mediumOfInstruction,
      Value<String?> textbookId,
      Value<String?> currentChapter,
      Value<String?> homeDialect,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ClassesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClassesTableTable> {
  $$ClassesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkLanguage => $composableBuilder(
    column: $table.checkLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediumOfInstruction => $composableBuilder(
    column: $table.mediumOfInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textbookId => $composableBuilder(
    column: $table.textbookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentChapter => $composableBuilder(
    column: $table.currentChapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClassesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassesTableTable> {
  $$ClassesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkLanguage => $composableBuilder(
    column: $table.checkLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediumOfInstruction => $composableBuilder(
    column: $table.mediumOfInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textbookId => $composableBuilder(
    column: $table.textbookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentChapter => $composableBuilder(
    column: $table.currentChapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClassesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassesTableTable> {
  $$ClassesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get curriculum => $composableBuilder(
    column: $table.curriculum,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkLanguage => $composableBuilder(
    column: $table.checkLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediumOfInstruction => $composableBuilder(
    column: $table.mediumOfInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textbookId => $composableBuilder(
    column: $table.textbookId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentChapter => $composableBuilder(
    column: $table.currentChapter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClassesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassesTableTable,
          ClassesTableData,
          $$ClassesTableTableFilterComposer,
          $$ClassesTableTableOrderingComposer,
          $$ClassesTableTableAnnotationComposer,
          $$ClassesTableTableCreateCompanionBuilder,
          $$ClassesTableTableUpdateCompanionBuilder,
          (
            ClassesTableData,
            BaseReferences<_$AppDatabase, $ClassesTableTable, ClassesTableData>,
          ),
          ClassesTableData,
          PrefetchHooks Function()
        > {
  $$ClassesTableTableTableManager(_$AppDatabase db, $ClassesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> grade = const Value.absent(),
                Value<String> section = const Value.absent(),
                Value<String> curriculum = const Value.absent(),
                Value<String> checkLanguage = const Value.absent(),
                Value<String> mediumOfInstruction = const Value.absent(),
                Value<String?> textbookId = const Value.absent(),
                Value<String?> currentChapter = const Value.absent(),
                Value<String?> homeDialect = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassesTableCompanion(
                id: id,
                scope: scope,
                name: name,
                grade: grade,
                section: section,
                curriculum: curriculum,
                checkLanguage: checkLanguage,
                mediumOfInstruction: mediumOfInstruction,
                textbookId: textbookId,
                currentChapter: currentChapter,
                homeDialect: homeDialect,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String scope,
                required String name,
                required int grade,
                required String section,
                required String curriculum,
                required String checkLanguage,
                required String mediumOfInstruction,
                Value<String?> textbookId = const Value.absent(),
                Value<String?> currentChapter = const Value.absent(),
                Value<String?> homeDialect = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ClassesTableCompanion.insert(
                id: id,
                scope: scope,
                name: name,
                grade: grade,
                section: section,
                curriculum: curriculum,
                checkLanguage: checkLanguage,
                mediumOfInstruction: mediumOfInstruction,
                textbookId: textbookId,
                currentChapter: currentChapter,
                homeDialect: homeDialect,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClassesTableTable, ClassesTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ClassesTableTable,
                    ClassesTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClassesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassesTableTable,
      ClassesTableData,
      $$ClassesTableTableFilterComposer,
      $$ClassesTableTableOrderingComposer,
      $$ClassesTableTableAnnotationComposer,
      $$ClassesTableTableCreateCompanionBuilder,
      $$ClassesTableTableUpdateCompanionBuilder,
      (
        ClassesTableData,
        BaseReferences<_$AppDatabase, $ClassesTableTable, ClassesTableData>,
      ),
      ClassesTableData,
      PrefetchHooks Function()
    >;
typedef $$ChildrenTableTableCreateCompanionBuilder =
    ChildrenTableCompanion Function({
      required String id,
      required String classId,
      required String scope,
      required String firstName,
      required String lastInitial,
      required String homeLanguage,
      Value<String?> homeDialect,
      Value<String> currentGroup,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ChildrenTableTableUpdateCompanionBuilder =
    ChildrenTableCompanion Function({
      Value<String> id,
      Value<String> classId,
      Value<String> scope,
      Value<String> firstName,
      Value<String> lastInitial,
      Value<String> homeLanguage,
      Value<String?> homeDialect,
      Value<String> currentGroup,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ChildrenTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastInitial => $composableBuilder(
    column: $table.lastInitial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeLanguage => $composableBuilder(
    column: $table.homeLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentGroup => $composableBuilder(
    column: $table.currentGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChildrenTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastInitial => $composableBuilder(
    column: $table.lastInitial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeLanguage => $composableBuilder(
    column: $table.homeLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentGroup => $composableBuilder(
    column: $table.currentGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChildrenTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildrenTableTable> {
  $$ChildrenTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastInitial => $composableBuilder(
    column: $table.lastInitial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeLanguage => $composableBuilder(
    column: $table.homeLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeDialect => $composableBuilder(
    column: $table.homeDialect,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentGroup => $composableBuilder(
    column: $table.currentGroup,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ChildrenTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChildrenTableTable,
          ChildrenTableData,
          $$ChildrenTableTableFilterComposer,
          $$ChildrenTableTableOrderingComposer,
          $$ChildrenTableTableAnnotationComposer,
          $$ChildrenTableTableCreateCompanionBuilder,
          $$ChildrenTableTableUpdateCompanionBuilder,
          (
            ChildrenTableData,
            BaseReferences<
              _$AppDatabase,
              $ChildrenTableTable,
              ChildrenTableData
            >,
          ),
          ChildrenTableData,
          PrefetchHooks Function()
        > {
  $$ChildrenTableTableTableManager(_$AppDatabase db, $ChildrenTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildrenTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildrenTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildrenTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastInitial = const Value.absent(),
                Value<String> homeLanguage = const Value.absent(),
                Value<String?> homeDialect = const Value.absent(),
                Value<String> currentGroup = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChildrenTableCompanion(
                id: id,
                classId: classId,
                scope: scope,
                firstName: firstName,
                lastInitial: lastInitial,
                homeLanguage: homeLanguage,
                homeDialect: homeDialect,
                currentGroup: currentGroup,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String classId,
                required String scope,
                required String firstName,
                required String lastInitial,
                required String homeLanguage,
                Value<String?> homeDialect = const Value.absent(),
                Value<String> currentGroup = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ChildrenTableCompanion.insert(
                id: id,
                classId: classId,
                scope: scope,
                firstName: firstName,
                lastInitial: lastInitial,
                homeLanguage: homeLanguage,
                homeDialect: homeDialect,
                currentGroup: currentGroup,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChildrenTableTable, ChildrenTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ChildrenTableTable,
                    ChildrenTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChildrenTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChildrenTableTable,
      ChildrenTableData,
      $$ChildrenTableTableFilterComposer,
      $$ChildrenTableTableOrderingComposer,
      $$ChildrenTableTableAnnotationComposer,
      $$ChildrenTableTableCreateCompanionBuilder,
      $$ChildrenTableTableUpdateCompanionBuilder,
      (
        ChildrenTableData,
        BaseReferences<_$AppDatabase, $ChildrenTableTable, ChildrenTableData>,
      ),
      ChildrenTableData,
      PrefetchHooks Function()
    >;
typedef $$ConsentsTableTableCreateCompanionBuilder =
    ConsentsTableCompanion Function({
      required String id,
      required String childId,
      required String scope,
      Value<bool> consentGiven,
      required DateTime consentDate,
      Value<bool> withdrawn,
      Value<DateTime?> withdrawnDate,
      Value<int> rowid,
    });
typedef $$ConsentsTableTableUpdateCompanionBuilder =
    ConsentsTableCompanion Function({
      Value<String> id,
      Value<String> childId,
      Value<String> scope,
      Value<bool> consentGiven,
      Value<DateTime> consentDate,
      Value<bool> withdrawn,
      Value<DateTime?> withdrawnDate,
      Value<int> rowid,
    });

class $$ConsentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConsentsTableTable> {
  $$ConsentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get consentGiven => $composableBuilder(
    column: $table.consentGiven,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get consentDate => $composableBuilder(
    column: $table.consentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withdrawn => $composableBuilder(
    column: $table.withdrawn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get withdrawnDate => $composableBuilder(
    column: $table.withdrawnDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConsentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsentsTableTable> {
  $$ConsentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get consentGiven => $composableBuilder(
    column: $table.consentGiven,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get consentDate => $composableBuilder(
    column: $table.consentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withdrawn => $composableBuilder(
    column: $table.withdrawn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get withdrawnDate => $composableBuilder(
    column: $table.withdrawnDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConsentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsentsTableTable> {
  $$ConsentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<bool> get consentGiven => $composableBuilder(
    column: $table.consentGiven,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get consentDate => $composableBuilder(
    column: $table.consentDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get withdrawn =>
      $composableBuilder(column: $table.withdrawn, builder: (column) => column);

  GeneratedColumn<DateTime> get withdrawnDate => $composableBuilder(
    column: $table.withdrawnDate,
    builder: (column) => column,
  );
}

class $$ConsentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsentsTableTable,
          ConsentsTableData,
          $$ConsentsTableTableFilterComposer,
          $$ConsentsTableTableOrderingComposer,
          $$ConsentsTableTableAnnotationComposer,
          $$ConsentsTableTableCreateCompanionBuilder,
          $$ConsentsTableTableUpdateCompanionBuilder,
          (
            ConsentsTableData,
            BaseReferences<
              _$AppDatabase,
              $ConsentsTableTable,
              ConsentsTableData
            >,
          ),
          ConsentsTableData,
          PrefetchHooks Function()
        > {
  $$ConsentsTableTableTableManager(_$AppDatabase db, $ConsentsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<bool> consentGiven = const Value.absent(),
                Value<DateTime> consentDate = const Value.absent(),
                Value<bool> withdrawn = const Value.absent(),
                Value<DateTime?> withdrawnDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsentsTableCompanion(
                id: id,
                childId: childId,
                scope: scope,
                consentGiven: consentGiven,
                consentDate: consentDate,
                withdrawn: withdrawn,
                withdrawnDate: withdrawnDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String childId,
                required String scope,
                Value<bool> consentGiven = const Value.absent(),
                required DateTime consentDate,
                Value<bool> withdrawn = const Value.absent(),
                Value<DateTime?> withdrawnDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConsentsTableCompanion.insert(
                id: id,
                childId: childId,
                scope: scope,
                consentGiven: consentGiven,
                consentDate: consentDate,
                withdrawn: withdrawn,
                withdrawnDate: withdrawnDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ConsentsTableTable, ConsentsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ConsentsTableTable,
                    ConsentsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConsentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsentsTableTable,
      ConsentsTableData,
      $$ConsentsTableTableFilterComposer,
      $$ConsentsTableTableOrderingComposer,
      $$ConsentsTableTableAnnotationComposer,
      $$ConsentsTableTableCreateCompanionBuilder,
      $$ConsentsTableTableUpdateCompanionBuilder,
      (
        ConsentsTableData,
        BaseReferences<_$AppDatabase, $ConsentsTableTable, ConsentsTableData>,
      ),
      ConsentsTableData,
      PrefetchHooks Function()
    >;
typedef $$GroupAssignmentsTableTableCreateCompanionBuilder =
    GroupAssignmentsTableCompanion Function({
      required String id,
      required String childId,
      required String scope,
      required String fromGroup,
      required String toGroup,
      Value<String?> reason,
      required DateTime movedAt,
      Value<int> rowid,
    });
typedef $$GroupAssignmentsTableTableUpdateCompanionBuilder =
    GroupAssignmentsTableCompanion Function({
      Value<String> id,
      Value<String> childId,
      Value<String> scope,
      Value<String> fromGroup,
      Value<String> toGroup,
      Value<String?> reason,
      Value<DateTime> movedAt,
      Value<int> rowid,
    });

class $$GroupAssignmentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupAssignmentsTableTable> {
  $$GroupAssignmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromGroup => $composableBuilder(
    column: $table.fromGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toGroup => $composableBuilder(
    column: $table.toGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get movedAt => $composableBuilder(
    column: $table.movedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GroupAssignmentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupAssignmentsTableTable> {
  $$GroupAssignmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromGroup => $composableBuilder(
    column: $table.fromGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toGroup => $composableBuilder(
    column: $table.toGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get movedAt => $composableBuilder(
    column: $table.movedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupAssignmentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupAssignmentsTableTable> {
  $$GroupAssignmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get fromGroup =>
      $composableBuilder(column: $table.fromGroup, builder: (column) => column);

  GeneratedColumn<String> get toGroup =>
      $composableBuilder(column: $table.toGroup, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get movedAt =>
      $composableBuilder(column: $table.movedAt, builder: (column) => column);
}

class $$GroupAssignmentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupAssignmentsTableTable,
          GroupAssignmentsTableData,
          $$GroupAssignmentsTableTableFilterComposer,
          $$GroupAssignmentsTableTableOrderingComposer,
          $$GroupAssignmentsTableTableAnnotationComposer,
          $$GroupAssignmentsTableTableCreateCompanionBuilder,
          $$GroupAssignmentsTableTableUpdateCompanionBuilder,
          (
            GroupAssignmentsTableData,
            BaseReferences<
              _$AppDatabase,
              $GroupAssignmentsTableTable,
              GroupAssignmentsTableData
            >,
          ),
          GroupAssignmentsTableData,
          PrefetchHooks Function()
        > {
  $$GroupAssignmentsTableTableTableManager(
    _$AppDatabase db,
    $GroupAssignmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupAssignmentsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GroupAssignmentsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GroupAssignmentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> fromGroup = const Value.absent(),
                Value<String> toGroup = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> movedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupAssignmentsTableCompanion(
                id: id,
                childId: childId,
                scope: scope,
                fromGroup: fromGroup,
                toGroup: toGroup,
                reason: reason,
                movedAt: movedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String childId,
                required String scope,
                required String fromGroup,
                required String toGroup,
                Value<String?> reason = const Value.absent(),
                required DateTime movedAt,
                Value<int> rowid = const Value.absent(),
              }) => GroupAssignmentsTableCompanion.insert(
                id: id,
                childId: childId,
                scope: scope,
                fromGroup: fromGroup,
                toGroup: toGroup,
                reason: reason,
                movedAt: movedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $GroupAssignmentsTableTable,
                    GroupAssignmentsTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GroupAssignmentsTableTable,
                    GroupAssignmentsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GroupAssignmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupAssignmentsTableTable,
      GroupAssignmentsTableData,
      $$GroupAssignmentsTableTableFilterComposer,
      $$GroupAssignmentsTableTableOrderingComposer,
      $$GroupAssignmentsTableTableAnnotationComposer,
      $$GroupAssignmentsTableTableCreateCompanionBuilder,
      $$GroupAssignmentsTableTableUpdateCompanionBuilder,
      (
        GroupAssignmentsTableData,
        BaseReferences<
          _$AppDatabase,
          $GroupAssignmentsTableTable,
          GroupAssignmentsTableData
        >,
      ),
      GroupAssignmentsTableData,
      PrefetchHooks Function()
    >;
typedef $$ChecksTableTableCreateCompanionBuilder =
    ChecksTableCompanion Function({
      required String id,
      required String childId,
      required String classId,
      required String scope,
      required String status,
      required String currentStep,
      required String passageId,
      required String passageTitle,
      required int passageLevel,
      Value<double?> noiseLevel,
      Value<bool> isLowConfidence,
      Value<String?> audioPath,
      Value<bool> markedWithoutRecording,
      Value<String?> benchmarkUsedJson,
      Value<String> rubricVersion,
      Value<double?> readingDurationSeconds,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      Value<String?> readingSelfRating,
      Value<int> rowid,
    });
typedef $$ChecksTableTableUpdateCompanionBuilder =
    ChecksTableCompanion Function({
      Value<String> id,
      Value<String> childId,
      Value<String> classId,
      Value<String> scope,
      Value<String> status,
      Value<String> currentStep,
      Value<String> passageId,
      Value<String> passageTitle,
      Value<int> passageLevel,
      Value<double?> noiseLevel,
      Value<bool> isLowConfidence,
      Value<String?> audioPath,
      Value<bool> markedWithoutRecording,
      Value<String?> benchmarkUsedJson,
      Value<String> rubricVersion,
      Value<double?> readingDurationSeconds,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> readingSelfRating,
      Value<int> rowid,
    });

class $$ChecksTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChecksTableTable> {
  $$ChecksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passageId => $composableBuilder(
    column: $table.passageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passageTitle => $composableBuilder(
    column: $table.passageTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passageLevel => $composableBuilder(
    column: $table.passageLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get noiseLevel => $composableBuilder(
    column: $table.noiseLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get markedWithoutRecording => $composableBuilder(
    column: $table.markedWithoutRecording,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get benchmarkUsedJson => $composableBuilder(
    column: $table.benchmarkUsedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rubricVersion => $composableBuilder(
    column: $table.rubricVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get readingDurationSeconds => $composableBuilder(
    column: $table.readingDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingSelfRating => $composableBuilder(
    column: $table.readingSelfRating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecksTableTable> {
  $$ChecksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passageId => $composableBuilder(
    column: $table.passageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passageTitle => $composableBuilder(
    column: $table.passageTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passageLevel => $composableBuilder(
    column: $table.passageLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get noiseLevel => $composableBuilder(
    column: $table.noiseLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get markedWithoutRecording => $composableBuilder(
    column: $table.markedWithoutRecording,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get benchmarkUsedJson => $composableBuilder(
    column: $table.benchmarkUsedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rubricVersion => $composableBuilder(
    column: $table.rubricVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get readingDurationSeconds => $composableBuilder(
    column: $table.readingDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingSelfRating => $composableBuilder(
    column: $table.readingSelfRating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecksTableTable> {
  $$ChecksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passageId =>
      $composableBuilder(column: $table.passageId, builder: (column) => column);

  GeneratedColumn<String> get passageTitle => $composableBuilder(
    column: $table.passageTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get passageLevel => $composableBuilder(
    column: $table.passageLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get noiseLevel => $composableBuilder(
    column: $table.noiseLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<bool> get markedWithoutRecording => $composableBuilder(
    column: $table.markedWithoutRecording,
    builder: (column) => column,
  );

  GeneratedColumn<String> get benchmarkUsedJson => $composableBuilder(
    column: $table.benchmarkUsedJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rubricVersion => $composableBuilder(
    column: $table.rubricVersion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get readingDurationSeconds => $composableBuilder(
    column: $table.readingDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingSelfRating => $composableBuilder(
    column: $table.readingSelfRating,
    builder: (column) => column,
  );
}

class $$ChecksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecksTableTable,
          ChecksTableData,
          $$ChecksTableTableFilterComposer,
          $$ChecksTableTableOrderingComposer,
          $$ChecksTableTableAnnotationComposer,
          $$ChecksTableTableCreateCompanionBuilder,
          $$ChecksTableTableUpdateCompanionBuilder,
          (
            ChecksTableData,
            BaseReferences<_$AppDatabase, $ChecksTableTable, ChecksTableData>,
          ),
          ChecksTableData,
          PrefetchHooks Function()
        > {
  $$ChecksTableTableTableManager(_$AppDatabase db, $ChecksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> currentStep = const Value.absent(),
                Value<String> passageId = const Value.absent(),
                Value<String> passageTitle = const Value.absent(),
                Value<int> passageLevel = const Value.absent(),
                Value<double?> noiseLevel = const Value.absent(),
                Value<bool> isLowConfidence = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<bool> markedWithoutRecording = const Value.absent(),
                Value<String?> benchmarkUsedJson = const Value.absent(),
                Value<String> rubricVersion = const Value.absent(),
                Value<double?> readingDurationSeconds = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> readingSelfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecksTableCompanion(
                id: id,
                childId: childId,
                classId: classId,
                scope: scope,
                status: status,
                currentStep: currentStep,
                passageId: passageId,
                passageTitle: passageTitle,
                passageLevel: passageLevel,
                noiseLevel: noiseLevel,
                isLowConfidence: isLowConfidence,
                audioPath: audioPath,
                markedWithoutRecording: markedWithoutRecording,
                benchmarkUsedJson: benchmarkUsedJson,
                rubricVersion: rubricVersion,
                readingDurationSeconds: readingDurationSeconds,
                startedAt: startedAt,
                completedAt: completedAt,
                readingSelfRating: readingSelfRating,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String childId,
                required String classId,
                required String scope,
                required String status,
                required String currentStep,
                required String passageId,
                required String passageTitle,
                required int passageLevel,
                Value<double?> noiseLevel = const Value.absent(),
                Value<bool> isLowConfidence = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<bool> markedWithoutRecording = const Value.absent(),
                Value<String?> benchmarkUsedJson = const Value.absent(),
                Value<String> rubricVersion = const Value.absent(),
                Value<double?> readingDurationSeconds = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> readingSelfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecksTableCompanion.insert(
                id: id,
                childId: childId,
                classId: classId,
                scope: scope,
                status: status,
                currentStep: currentStep,
                passageId: passageId,
                passageTitle: passageTitle,
                passageLevel: passageLevel,
                noiseLevel: noiseLevel,
                isLowConfidence: isLowConfidence,
                audioPath: audioPath,
                markedWithoutRecording: markedWithoutRecording,
                benchmarkUsedJson: benchmarkUsedJson,
                rubricVersion: rubricVersion,
                readingDurationSeconds: readingDurationSeconds,
                startedAt: startedAt,
                completedAt: completedAt,
                readingSelfRating: readingSelfRating,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChecksTableTable, ChecksTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ChecksTableTable,
                    ChecksTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecksTableTable,
      ChecksTableData,
      $$ChecksTableTableFilterComposer,
      $$ChecksTableTableOrderingComposer,
      $$ChecksTableTableAnnotationComposer,
      $$ChecksTableTableCreateCompanionBuilder,
      $$ChecksTableTableUpdateCompanionBuilder,
      (
        ChecksTableData,
        BaseReferences<_$AppDatabase, $ChecksTableTable, ChecksTableData>,
      ),
      ChecksTableData,
      PrefetchHooks Function()
    >;
typedef $$WordMarksTableTableCreateCompanionBuilder =
    WordMarksTableCompanion Function({
      required String id,
      required String checkId,
      required int wordIndex,
      required String expectedWord,
      Value<String?> actualWord,
      required String mark,
      Value<String?> errorSubtype,
      Value<int> rowid,
    });
typedef $$WordMarksTableTableUpdateCompanionBuilder =
    WordMarksTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<int> wordIndex,
      Value<String> expectedWord,
      Value<String?> actualWord,
      Value<String> mark,
      Value<String?> errorSubtype,
      Value<int> rowid,
    });

class $$WordMarksTableTableFilterComposer
    extends Composer<_$AppDatabase, $WordMarksTableTable> {
  $$WordMarksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordIndex => $composableBuilder(
    column: $table.wordIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedWord => $composableBuilder(
    column: $table.expectedWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualWord => $composableBuilder(
    column: $table.actualWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mark => $composableBuilder(
    column: $table.mark,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorSubtype => $composableBuilder(
    column: $table.errorSubtype,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordMarksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WordMarksTableTable> {
  $$WordMarksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordIndex => $composableBuilder(
    column: $table.wordIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedWord => $composableBuilder(
    column: $table.expectedWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualWord => $composableBuilder(
    column: $table.actualWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mark => $composableBuilder(
    column: $table.mark,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorSubtype => $composableBuilder(
    column: $table.errorSubtype,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordMarksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordMarksTableTable> {
  $$WordMarksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<int> get wordIndex =>
      $composableBuilder(column: $table.wordIndex, builder: (column) => column);

  GeneratedColumn<String> get expectedWord => $composableBuilder(
    column: $table.expectedWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actualWord => $composableBuilder(
    column: $table.actualWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mark =>
      $composableBuilder(column: $table.mark, builder: (column) => column);

  GeneratedColumn<String> get errorSubtype => $composableBuilder(
    column: $table.errorSubtype,
    builder: (column) => column,
  );
}

class $$WordMarksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordMarksTableTable,
          WordMarksTableData,
          $$WordMarksTableTableFilterComposer,
          $$WordMarksTableTableOrderingComposer,
          $$WordMarksTableTableAnnotationComposer,
          $$WordMarksTableTableCreateCompanionBuilder,
          $$WordMarksTableTableUpdateCompanionBuilder,
          (
            WordMarksTableData,
            BaseReferences<
              _$AppDatabase,
              $WordMarksTableTable,
              WordMarksTableData
            >,
          ),
          WordMarksTableData,
          PrefetchHooks Function()
        > {
  $$WordMarksTableTableTableManager(
    _$AppDatabase db,
    $WordMarksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordMarksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordMarksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordMarksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<int> wordIndex = const Value.absent(),
                Value<String> expectedWord = const Value.absent(),
                Value<String?> actualWord = const Value.absent(),
                Value<String> mark = const Value.absent(),
                Value<String?> errorSubtype = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordMarksTableCompanion(
                id: id,
                checkId: checkId,
                wordIndex: wordIndex,
                expectedWord: expectedWord,
                actualWord: actualWord,
                mark: mark,
                errorSubtype: errorSubtype,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required int wordIndex,
                required String expectedWord,
                Value<String?> actualWord = const Value.absent(),
                required String mark,
                Value<String?> errorSubtype = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordMarksTableCompanion.insert(
                id: id,
                checkId: checkId,
                wordIndex: wordIndex,
                expectedWord: expectedWord,
                actualWord: actualWord,
                mark: mark,
                errorSubtype: errorSubtype,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordMarksTableTable, WordMarksTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WordMarksTableTable,
                    WordMarksTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordMarksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordMarksTableTable,
      WordMarksTableData,
      $$WordMarksTableTableFilterComposer,
      $$WordMarksTableTableOrderingComposer,
      $$WordMarksTableTableAnnotationComposer,
      $$WordMarksTableTableCreateCompanionBuilder,
      $$WordMarksTableTableUpdateCompanionBuilder,
      (
        WordMarksTableData,
        BaseReferences<_$AppDatabase, $WordMarksTableTable, WordMarksTableData>,
      ),
      WordMarksTableData,
      PrefetchHooks Function()
    >;
typedef $$RetellPointsTableTableCreateCompanionBuilder =
    RetellPointsTableCompanion Function({
      required String id,
      required String checkId,
      required int pointIndex,
      required String pointText,
      required bool isMentioned,
      Value<int> rowid,
    });
typedef $$RetellPointsTableTableUpdateCompanionBuilder =
    RetellPointsTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<int> pointIndex,
      Value<String> pointText,
      Value<bool> isMentioned,
      Value<int> rowid,
    });

class $$RetellPointsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RetellPointsTableTable> {
  $$RetellPointsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointIndex => $composableBuilder(
    column: $table.pointIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pointText => $composableBuilder(
    column: $table.pointText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMentioned => $composableBuilder(
    column: $table.isMentioned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RetellPointsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RetellPointsTableTable> {
  $$RetellPointsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointIndex => $composableBuilder(
    column: $table.pointIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pointText => $composableBuilder(
    column: $table.pointText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMentioned => $composableBuilder(
    column: $table.isMentioned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RetellPointsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetellPointsTableTable> {
  $$RetellPointsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<int> get pointIndex => $composableBuilder(
    column: $table.pointIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pointText =>
      $composableBuilder(column: $table.pointText, builder: (column) => column);

  GeneratedColumn<bool> get isMentioned => $composableBuilder(
    column: $table.isMentioned,
    builder: (column) => column,
  );
}

class $$RetellPointsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetellPointsTableTable,
          RetellPointsTableData,
          $$RetellPointsTableTableFilterComposer,
          $$RetellPointsTableTableOrderingComposer,
          $$RetellPointsTableTableAnnotationComposer,
          $$RetellPointsTableTableCreateCompanionBuilder,
          $$RetellPointsTableTableUpdateCompanionBuilder,
          (
            RetellPointsTableData,
            BaseReferences<
              _$AppDatabase,
              $RetellPointsTableTable,
              RetellPointsTableData
            >,
          ),
          RetellPointsTableData,
          PrefetchHooks Function()
        > {
  $$RetellPointsTableTableTableManager(
    _$AppDatabase db,
    $RetellPointsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetellPointsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetellPointsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RetellPointsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<int> pointIndex = const Value.absent(),
                Value<String> pointText = const Value.absent(),
                Value<bool> isMentioned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RetellPointsTableCompanion(
                id: id,
                checkId: checkId,
                pointIndex: pointIndex,
                pointText: pointText,
                isMentioned: isMentioned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required int pointIndex,
                required String pointText,
                required bool isMentioned,
                Value<int> rowid = const Value.absent(),
              }) => RetellPointsTableCompanion.insert(
                id: id,
                checkId: checkId,
                pointIndex: pointIndex,
                pointText: pointText,
                isMentioned: isMentioned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RetellPointsTableTable, RetellPointsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $RetellPointsTableTable,
                    RetellPointsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RetellPointsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetellPointsTableTable,
      RetellPointsTableData,
      $$RetellPointsTableTableFilterComposer,
      $$RetellPointsTableTableOrderingComposer,
      $$RetellPointsTableTableAnnotationComposer,
      $$RetellPointsTableTableCreateCompanionBuilder,
      $$RetellPointsTableTableUpdateCompanionBuilder,
      (
        RetellPointsTableData,
        BaseReferences<
          _$AppDatabase,
          $RetellPointsTableTable,
          RetellPointsTableData
        >,
      ),
      RetellPointsTableData,
      PrefetchHooks Function()
    >;
typedef $$QuestionAnswersTableTableCreateCompanionBuilder =
    QuestionAnswersTableCompanion Function({
      required String id,
      required String checkId,
      required String questionId,
      required String questionType,
      required String answerStatus,
      Value<int> level,
      Value<int?> timeMs,
      Value<double?> marks,
      Value<double?> maxMarks,
      Value<String?> selfRating,
      Value<int> rowid,
    });
typedef $$QuestionAnswersTableTableUpdateCompanionBuilder =
    QuestionAnswersTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<String> questionId,
      Value<String> questionType,
      Value<String> answerStatus,
      Value<int> level,
      Value<int?> timeMs,
      Value<double?> marks,
      Value<double?> maxMarks,
      Value<String?> selfRating,
      Value<int> rowid,
    });

class $$QuestionAnswersTableTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionAnswersTableTable> {
  $$QuestionAnswersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerStatus => $composableBuilder(
    column: $table.answerStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marks => $composableBuilder(
    column: $table.marks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxMarks => $composableBuilder(
    column: $table.maxMarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionAnswersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionAnswersTableTable> {
  $$QuestionAnswersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerStatus => $composableBuilder(
    column: $table.answerStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marks => $composableBuilder(
    column: $table.marks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxMarks => $composableBuilder(
    column: $table.maxMarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionAnswersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionAnswersTableTable> {
  $$QuestionAnswersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerStatus => $composableBuilder(
    column: $table.answerStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get timeMs =>
      $composableBuilder(column: $table.timeMs, builder: (column) => column);

  GeneratedColumn<double> get marks =>
      $composableBuilder(column: $table.marks, builder: (column) => column);

  GeneratedColumn<double> get maxMarks =>
      $composableBuilder(column: $table.maxMarks, builder: (column) => column);

  GeneratedColumn<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => column,
  );
}

class $$QuestionAnswersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionAnswersTableTable,
          QuestionAnswersTableData,
          $$QuestionAnswersTableTableFilterComposer,
          $$QuestionAnswersTableTableOrderingComposer,
          $$QuestionAnswersTableTableAnnotationComposer,
          $$QuestionAnswersTableTableCreateCompanionBuilder,
          $$QuestionAnswersTableTableUpdateCompanionBuilder,
          (
            QuestionAnswersTableData,
            BaseReferences<
              _$AppDatabase,
              $QuestionAnswersTableTable,
              QuestionAnswersTableData
            >,
          ),
          QuestionAnswersTableData,
          PrefetchHooks Function()
        > {
  $$QuestionAnswersTableTableTableManager(
    _$AppDatabase db,
    $QuestionAnswersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionAnswersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionAnswersTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$QuestionAnswersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> questionType = const Value.absent(),
                Value<String> answerStatus = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int?> timeMs = const Value.absent(),
                Value<double?> marks = const Value.absent(),
                Value<double?> maxMarks = const Value.absent(),
                Value<String?> selfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionAnswersTableCompanion(
                id: id,
                checkId: checkId,
                questionId: questionId,
                questionType: questionType,
                answerStatus: answerStatus,
                level: level,
                timeMs: timeMs,
                marks: marks,
                maxMarks: maxMarks,
                selfRating: selfRating,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required String questionId,
                required String questionType,
                required String answerStatus,
                Value<int> level = const Value.absent(),
                Value<int?> timeMs = const Value.absent(),
                Value<double?> marks = const Value.absent(),
                Value<double?> maxMarks = const Value.absent(),
                Value<String?> selfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionAnswersTableCompanion.insert(
                id: id,
                checkId: checkId,
                questionId: questionId,
                questionType: questionType,
                answerStatus: answerStatus,
                level: level,
                timeMs: timeMs,
                marks: marks,
                maxMarks: maxMarks,
                selfRating: selfRating,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $QuestionAnswersTableTable,
                    QuestionAnswersTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $QuestionAnswersTableTable,
                    QuestionAnswersTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionAnswersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionAnswersTableTable,
      QuestionAnswersTableData,
      $$QuestionAnswersTableTableFilterComposer,
      $$QuestionAnswersTableTableOrderingComposer,
      $$QuestionAnswersTableTableAnnotationComposer,
      $$QuestionAnswersTableTableCreateCompanionBuilder,
      $$QuestionAnswersTableTableUpdateCompanionBuilder,
      (
        QuestionAnswersTableData,
        BaseReferences<
          _$AppDatabase,
          $QuestionAnswersTableTable,
          QuestionAnswersTableData
        >,
      ),
      QuestionAnswersTableData,
      PrefetchHooks Function()
    >;
typedef $$DictationItemsTableTableCreateCompanionBuilder =
    DictationItemsTableCompanion Function({
      required String id,
      required String checkId,
      required int itemIndex,
      required String word,
      required bool isCorrect,
      Value<bool> isSkipped,
      Value<String?> errorType,
      Value<int> rowid,
    });
typedef $$DictationItemsTableTableUpdateCompanionBuilder =
    DictationItemsTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<int> itemIndex,
      Value<String> word,
      Value<bool> isCorrect,
      Value<bool> isSkipped,
      Value<String?> errorType,
      Value<int> rowid,
    });

class $$DictationItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DictationItemsTableTable> {
  $$DictationItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itemIndex => $composableBuilder(
    column: $table.itemIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSkipped => $composableBuilder(
    column: $table.isSkipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorType => $composableBuilder(
    column: $table.errorType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DictationItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DictationItemsTableTable> {
  $$DictationItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itemIndex => $composableBuilder(
    column: $table.itemIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSkipped => $composableBuilder(
    column: $table.isSkipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorType => $composableBuilder(
    column: $table.errorType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DictationItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DictationItemsTableTable> {
  $$DictationItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<int> get itemIndex =>
      $composableBuilder(column: $table.itemIndex, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<bool> get isSkipped =>
      $composableBuilder(column: $table.isSkipped, builder: (column) => column);

  GeneratedColumn<String> get errorType =>
      $composableBuilder(column: $table.errorType, builder: (column) => column);
}

class $$DictationItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DictationItemsTableTable,
          DictationItemsTableData,
          $$DictationItemsTableTableFilterComposer,
          $$DictationItemsTableTableOrderingComposer,
          $$DictationItemsTableTableAnnotationComposer,
          $$DictationItemsTableTableCreateCompanionBuilder,
          $$DictationItemsTableTableUpdateCompanionBuilder,
          (
            DictationItemsTableData,
            BaseReferences<
              _$AppDatabase,
              $DictationItemsTableTable,
              DictationItemsTableData
            >,
          ),
          DictationItemsTableData,
          PrefetchHooks Function()
        > {
  $$DictationItemsTableTableTableManager(
    _$AppDatabase db,
    $DictationItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictationItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictationItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DictationItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<int> itemIndex = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<bool> isSkipped = const Value.absent(),
                Value<String?> errorType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DictationItemsTableCompanion(
                id: id,
                checkId: checkId,
                itemIndex: itemIndex,
                word: word,
                isCorrect: isCorrect,
                isSkipped: isSkipped,
                errorType: errorType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required int itemIndex,
                required String word,
                required bool isCorrect,
                Value<bool> isSkipped = const Value.absent(),
                Value<String?> errorType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DictationItemsTableCompanion.insert(
                id: id,
                checkId: checkId,
                itemIndex: itemIndex,
                word: word,
                isCorrect: isCorrect,
                isSkipped: isSkipped,
                errorType: errorType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DictationItemsTableTable,
                    DictationItemsTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DictationItemsTableTable,
                    DictationItemsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DictationItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DictationItemsTableTable,
      DictationItemsTableData,
      $$DictationItemsTableTableFilterComposer,
      $$DictationItemsTableTableOrderingComposer,
      $$DictationItemsTableTableAnnotationComposer,
      $$DictationItemsTableTableCreateCompanionBuilder,
      $$DictationItemsTableTableUpdateCompanionBuilder,
      (
        DictationItemsTableData,
        BaseReferences<
          _$AppDatabase,
          $DictationItemsTableTable,
          DictationItemsTableData
        >,
      ),
      DictationItemsTableData,
      PrefetchHooks Function()
    >;
typedef $$ListeningChecksTableTableCreateCompanionBuilder =
    ListeningChecksTableCompanion Function({
      required String id,
      required String checkId,
      required bool isOffered,
      required bool isCompleted,
      required int pointsEarned,
      required int totalPoints,
      Value<int> rowid,
    });
typedef $$ListeningChecksTableTableUpdateCompanionBuilder =
    ListeningChecksTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<bool> isOffered,
      Value<bool> isCompleted,
      Value<int> pointsEarned,
      Value<int> totalPoints,
      Value<int> rowid,
    });

class $$ListeningChecksTableTableFilterComposer
    extends Composer<_$AppDatabase, $ListeningChecksTableTable> {
  $$ListeningChecksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOffered => $composableBuilder(
    column: $table.isOffered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointsEarned => $composableBuilder(
    column: $table.pointsEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListeningChecksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ListeningChecksTableTable> {
  $$ListeningChecksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOffered => $composableBuilder(
    column: $table.isOffered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointsEarned => $composableBuilder(
    column: $table.pointsEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListeningChecksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListeningChecksTableTable> {
  $$ListeningChecksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<bool> get isOffered =>
      $composableBuilder(column: $table.isOffered, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pointsEarned => $composableBuilder(
    column: $table.pointsEarned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );
}

class $$ListeningChecksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListeningChecksTableTable,
          ListeningChecksTableData,
          $$ListeningChecksTableTableFilterComposer,
          $$ListeningChecksTableTableOrderingComposer,
          $$ListeningChecksTableTableAnnotationComposer,
          $$ListeningChecksTableTableCreateCompanionBuilder,
          $$ListeningChecksTableTableUpdateCompanionBuilder,
          (
            ListeningChecksTableData,
            BaseReferences<
              _$AppDatabase,
              $ListeningChecksTableTable,
              ListeningChecksTableData
            >,
          ),
          ListeningChecksTableData,
          PrefetchHooks Function()
        > {
  $$ListeningChecksTableTableTableManager(
    _$AppDatabase db,
    $ListeningChecksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListeningChecksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListeningChecksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ListeningChecksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<bool> isOffered = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> pointsEarned = const Value.absent(),
                Value<int> totalPoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ListeningChecksTableCompanion(
                id: id,
                checkId: checkId,
                isOffered: isOffered,
                isCompleted: isCompleted,
                pointsEarned: pointsEarned,
                totalPoints: totalPoints,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required bool isOffered,
                required bool isCompleted,
                required int pointsEarned,
                required int totalPoints,
                Value<int> rowid = const Value.absent(),
              }) => ListeningChecksTableCompanion.insert(
                id: id,
                checkId: checkId,
                isOffered: isOffered,
                isCompleted: isCompleted,
                pointsEarned: pointsEarned,
                totalPoints: totalPoints,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ListeningChecksTableTable,
                    ListeningChecksTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ListeningChecksTableTable,
                    ListeningChecksTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListeningChecksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListeningChecksTableTable,
      ListeningChecksTableData,
      $$ListeningChecksTableTableFilterComposer,
      $$ListeningChecksTableTableOrderingComposer,
      $$ListeningChecksTableTableAnnotationComposer,
      $$ListeningChecksTableTableCreateCompanionBuilder,
      $$ListeningChecksTableTableUpdateCompanionBuilder,
      (
        ListeningChecksTableData,
        BaseReferences<
          _$AppDatabase,
          $ListeningChecksTableTable,
          ListeningChecksTableData
        >,
      ),
      ListeningChecksTableData,
      PrefetchHooks Function()
    >;
typedef $$ResultsTableTableCreateCompanionBuilder =
    ResultsTableCompanion Function({
      required String id,
      required String checkId,
      required String childId,
      required String scope,
      required String groupAssigned,
      required String groupReason,
      required String nextStepRecommendation,
      required int totalWords,
      required int attemptedWords,
      required int correctWords,
      required double accuracyPercentage,
      Value<double?> readingSpeedWpm,
      required bool speedHasEvidence,
      Value<String?> speedTargetOfficial,
      required String comprehensionFactScore,
      required String retellScore,
      required String dictationScore,
      Value<String?> stuckOnAksharasJson,
      Value<String?> typingScore,
      Value<String?> selfRatingSummaryJson,
      required bool isLowConfidence,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ResultsTableTableUpdateCompanionBuilder =
    ResultsTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<String> childId,
      Value<String> scope,
      Value<String> groupAssigned,
      Value<String> groupReason,
      Value<String> nextStepRecommendation,
      Value<int> totalWords,
      Value<int> attemptedWords,
      Value<int> correctWords,
      Value<double> accuracyPercentage,
      Value<double?> readingSpeedWpm,
      Value<bool> speedHasEvidence,
      Value<String?> speedTargetOfficial,
      Value<String> comprehensionFactScore,
      Value<String> retellScore,
      Value<String> dictationScore,
      Value<String?> stuckOnAksharasJson,
      Value<String?> typingScore,
      Value<String?> selfRatingSummaryJson,
      Value<bool> isLowConfidence,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ResultsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ResultsTableTable> {
  $$ResultsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupAssigned => $composableBuilder(
    column: $table.groupAssigned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupReason => $composableBuilder(
    column: $table.groupReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextStepRecommendation => $composableBuilder(
    column: $table.nextStepRecommendation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptedWords => $composableBuilder(
    column: $table.attemptedWords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctWords => $composableBuilder(
    column: $table.correctWords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyPercentage => $composableBuilder(
    column: $table.accuracyPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get readingSpeedWpm => $composableBuilder(
    column: $table.readingSpeedWpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get speedHasEvidence => $composableBuilder(
    column: $table.speedHasEvidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speedTargetOfficial => $composableBuilder(
    column: $table.speedTargetOfficial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comprehensionFactScore => $composableBuilder(
    column: $table.comprehensionFactScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get retellScore => $composableBuilder(
    column: $table.retellScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dictationScore => $composableBuilder(
    column: $table.dictationScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stuckOnAksharasJson => $composableBuilder(
    column: $table.stuckOnAksharasJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typingScore => $composableBuilder(
    column: $table.typingScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selfRatingSummaryJson => $composableBuilder(
    column: $table.selfRatingSummaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResultsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultsTableTable> {
  $$ResultsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupAssigned => $composableBuilder(
    column: $table.groupAssigned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupReason => $composableBuilder(
    column: $table.groupReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextStepRecommendation => $composableBuilder(
    column: $table.nextStepRecommendation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptedWords => $composableBuilder(
    column: $table.attemptedWords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctWords => $composableBuilder(
    column: $table.correctWords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyPercentage => $composableBuilder(
    column: $table.accuracyPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get readingSpeedWpm => $composableBuilder(
    column: $table.readingSpeedWpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get speedHasEvidence => $composableBuilder(
    column: $table.speedHasEvidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speedTargetOfficial => $composableBuilder(
    column: $table.speedTargetOfficial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comprehensionFactScore => $composableBuilder(
    column: $table.comprehensionFactScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get retellScore => $composableBuilder(
    column: $table.retellScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dictationScore => $composableBuilder(
    column: $table.dictationScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stuckOnAksharasJson => $composableBuilder(
    column: $table.stuckOnAksharasJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typingScore => $composableBuilder(
    column: $table.typingScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfRatingSummaryJson => $composableBuilder(
    column: $table.selfRatingSummaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResultsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultsTableTable> {
  $$ResultsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get groupAssigned => $composableBuilder(
    column: $table.groupAssigned,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupReason => $composableBuilder(
    column: $table.groupReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextStepRecommendation => $composableBuilder(
    column: $table.nextStepRecommendation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptedWords => $composableBuilder(
    column: $table.attemptedWords,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctWords => $composableBuilder(
    column: $table.correctWords,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyPercentage => $composableBuilder(
    column: $table.accuracyPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get readingSpeedWpm => $composableBuilder(
    column: $table.readingSpeedWpm,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get speedHasEvidence => $composableBuilder(
    column: $table.speedHasEvidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get speedTargetOfficial => $composableBuilder(
    column: $table.speedTargetOfficial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comprehensionFactScore => $composableBuilder(
    column: $table.comprehensionFactScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get retellScore => $composableBuilder(
    column: $table.retellScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dictationScore => $composableBuilder(
    column: $table.dictationScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stuckOnAksharasJson => $composableBuilder(
    column: $table.stuckOnAksharasJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get typingScore => $composableBuilder(
    column: $table.typingScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selfRatingSummaryJson => $composableBuilder(
    column: $table.selfRatingSummaryJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLowConfidence => $composableBuilder(
    column: $table.isLowConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ResultsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultsTableTable,
          ResultsTableData,
          $$ResultsTableTableFilterComposer,
          $$ResultsTableTableOrderingComposer,
          $$ResultsTableTableAnnotationComposer,
          $$ResultsTableTableCreateCompanionBuilder,
          $$ResultsTableTableUpdateCompanionBuilder,
          (
            ResultsTableData,
            BaseReferences<_$AppDatabase, $ResultsTableTable, ResultsTableData>,
          ),
          ResultsTableData,
          PrefetchHooks Function()
        > {
  $$ResultsTableTableTableManager(_$AppDatabase db, $ResultsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> groupAssigned = const Value.absent(),
                Value<String> groupReason = const Value.absent(),
                Value<String> nextStepRecommendation = const Value.absent(),
                Value<int> totalWords = const Value.absent(),
                Value<int> attemptedWords = const Value.absent(),
                Value<int> correctWords = const Value.absent(),
                Value<double> accuracyPercentage = const Value.absent(),
                Value<double?> readingSpeedWpm = const Value.absent(),
                Value<bool> speedHasEvidence = const Value.absent(),
                Value<String?> speedTargetOfficial = const Value.absent(),
                Value<String> comprehensionFactScore = const Value.absent(),
                Value<String> retellScore = const Value.absent(),
                Value<String> dictationScore = const Value.absent(),
                Value<String?> stuckOnAksharasJson = const Value.absent(),
                Value<String?> typingScore = const Value.absent(),
                Value<String?> selfRatingSummaryJson = const Value.absent(),
                Value<bool> isLowConfidence = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultsTableCompanion(
                id: id,
                checkId: checkId,
                childId: childId,
                scope: scope,
                groupAssigned: groupAssigned,
                groupReason: groupReason,
                nextStepRecommendation: nextStepRecommendation,
                totalWords: totalWords,
                attemptedWords: attemptedWords,
                correctWords: correctWords,
                accuracyPercentage: accuracyPercentage,
                readingSpeedWpm: readingSpeedWpm,
                speedHasEvidence: speedHasEvidence,
                speedTargetOfficial: speedTargetOfficial,
                comprehensionFactScore: comprehensionFactScore,
                retellScore: retellScore,
                dictationScore: dictationScore,
                stuckOnAksharasJson: stuckOnAksharasJson,
                typingScore: typingScore,
                selfRatingSummaryJson: selfRatingSummaryJson,
                isLowConfidence: isLowConfidence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required String childId,
                required String scope,
                required String groupAssigned,
                required String groupReason,
                required String nextStepRecommendation,
                required int totalWords,
                required int attemptedWords,
                required int correctWords,
                required double accuracyPercentage,
                Value<double?> readingSpeedWpm = const Value.absent(),
                required bool speedHasEvidence,
                Value<String?> speedTargetOfficial = const Value.absent(),
                required String comprehensionFactScore,
                required String retellScore,
                required String dictationScore,
                Value<String?> stuckOnAksharasJson = const Value.absent(),
                Value<String?> typingScore = const Value.absent(),
                Value<String?> selfRatingSummaryJson = const Value.absent(),
                required bool isLowConfidence,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ResultsTableCompanion.insert(
                id: id,
                checkId: checkId,
                childId: childId,
                scope: scope,
                groupAssigned: groupAssigned,
                groupReason: groupReason,
                nextStepRecommendation: nextStepRecommendation,
                totalWords: totalWords,
                attemptedWords: attemptedWords,
                correctWords: correctWords,
                accuracyPercentage: accuracyPercentage,
                readingSpeedWpm: readingSpeedWpm,
                speedHasEvidence: speedHasEvidence,
                speedTargetOfficial: speedTargetOfficial,
                comprehensionFactScore: comprehensionFactScore,
                retellScore: retellScore,
                dictationScore: dictationScore,
                stuckOnAksharasJson: stuckOnAksharasJson,
                typingScore: typingScore,
                selfRatingSummaryJson: selfRatingSummaryJson,
                isLowConfidence: isLowConfidence,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ResultsTableTable, ResultsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ResultsTableTable,
                    ResultsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResultsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultsTableTable,
      ResultsTableData,
      $$ResultsTableTableFilterComposer,
      $$ResultsTableTableOrderingComposer,
      $$ResultsTableTableAnnotationComposer,
      $$ResultsTableTableCreateCompanionBuilder,
      $$ResultsTableTableUpdateCompanionBuilder,
      (
        ResultsTableData,
        BaseReferences<_$AppDatabase, $ResultsTableTable, ResultsTableData>,
      ),
      ResultsTableData,
      PrefetchHooks Function()
    >;
typedef $$PracticeNeedsTableTableCreateCompanionBuilder =
    PracticeNeedsTableCompanion Function({
      required String id,
      required String childId,
      required String scope,
      required String gapType,
      required String gapDetail,
      required String activityId,
      Value<bool> isSheetPrinted,
      Value<DateTime?> lastPrintedAt,
      Value<int> rowid,
    });
typedef $$PracticeNeedsTableTableUpdateCompanionBuilder =
    PracticeNeedsTableCompanion Function({
      Value<String> id,
      Value<String> childId,
      Value<String> scope,
      Value<String> gapType,
      Value<String> gapDetail,
      Value<String> activityId,
      Value<bool> isSheetPrinted,
      Value<DateTime?> lastPrintedAt,
      Value<int> rowid,
    });

class $$PracticeNeedsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PracticeNeedsTableTable> {
  $$PracticeNeedsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gapType => $composableBuilder(
    column: $table.gapType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gapDetail => $composableBuilder(
    column: $table.gapDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSheetPrinted => $composableBuilder(
    column: $table.isSheetPrinted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPrintedAt => $composableBuilder(
    column: $table.lastPrintedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PracticeNeedsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PracticeNeedsTableTable> {
  $$PracticeNeedsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gapType => $composableBuilder(
    column: $table.gapType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gapDetail => $composableBuilder(
    column: $table.gapDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSheetPrinted => $composableBuilder(
    column: $table.isSheetPrinted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPrintedAt => $composableBuilder(
    column: $table.lastPrintedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PracticeNeedsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PracticeNeedsTableTable> {
  $$PracticeNeedsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get gapType =>
      $composableBuilder(column: $table.gapType, builder: (column) => column);

  GeneratedColumn<String> get gapDetail =>
      $composableBuilder(column: $table.gapDetail, builder: (column) => column);

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSheetPrinted => $composableBuilder(
    column: $table.isSheetPrinted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPrintedAt => $composableBuilder(
    column: $table.lastPrintedAt,
    builder: (column) => column,
  );
}

class $$PracticeNeedsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PracticeNeedsTableTable,
          PracticeNeedsTableData,
          $$PracticeNeedsTableTableFilterComposer,
          $$PracticeNeedsTableTableOrderingComposer,
          $$PracticeNeedsTableTableAnnotationComposer,
          $$PracticeNeedsTableTableCreateCompanionBuilder,
          $$PracticeNeedsTableTableUpdateCompanionBuilder,
          (
            PracticeNeedsTableData,
            BaseReferences<
              _$AppDatabase,
              $PracticeNeedsTableTable,
              PracticeNeedsTableData
            >,
          ),
          PracticeNeedsTableData,
          PrefetchHooks Function()
        > {
  $$PracticeNeedsTableTableTableManager(
    _$AppDatabase db,
    $PracticeNeedsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PracticeNeedsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PracticeNeedsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PracticeNeedsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> gapType = const Value.absent(),
                Value<String> gapDetail = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<bool> isSheetPrinted = const Value.absent(),
                Value<DateTime?> lastPrintedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PracticeNeedsTableCompanion(
                id: id,
                childId: childId,
                scope: scope,
                gapType: gapType,
                gapDetail: gapDetail,
                activityId: activityId,
                isSheetPrinted: isSheetPrinted,
                lastPrintedAt: lastPrintedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String childId,
                required String scope,
                required String gapType,
                required String gapDetail,
                required String activityId,
                Value<bool> isSheetPrinted = const Value.absent(),
                Value<DateTime?> lastPrintedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PracticeNeedsTableCompanion.insert(
                id: id,
                childId: childId,
                scope: scope,
                gapType: gapType,
                gapDetail: gapDetail,
                activityId: activityId,
                isSheetPrinted: isSheetPrinted,
                lastPrintedAt: lastPrintedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PracticeNeedsTableTable, PracticeNeedsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $PracticeNeedsTableTable,
                    PracticeNeedsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PracticeNeedsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PracticeNeedsTableTable,
      PracticeNeedsTableData,
      $$PracticeNeedsTableTableFilterComposer,
      $$PracticeNeedsTableTableOrderingComposer,
      $$PracticeNeedsTableTableAnnotationComposer,
      $$PracticeNeedsTableTableCreateCompanionBuilder,
      $$PracticeNeedsTableTableUpdateCompanionBuilder,
      (
        PracticeNeedsTableData,
        BaseReferences<
          _$AppDatabase,
          $PracticeNeedsTableTable,
          PracticeNeedsTableData
        >,
      ),
      PracticeNeedsTableData,
      PrefetchHooks Function()
    >;
typedef $$WeeklyPlanTicksTableTableCreateCompanionBuilder =
    WeeklyPlanTicksTableCompanion Function({
      required String id,
      required String classId,
      required String scope,
      required DateTime weekStartDate,
      required String groupName,
      required String activityId,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$WeeklyPlanTicksTableTableUpdateCompanionBuilder =
    WeeklyPlanTicksTableCompanion Function({
      Value<String> id,
      Value<String> classId,
      Value<String> scope,
      Value<DateTime> weekStartDate,
      Value<String> groupName,
      Value<String> activityId,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$WeeklyPlanTicksTableTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyPlanTicksTableTable> {
  $$WeeklyPlanTicksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeeklyPlanTicksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyPlanTicksTableTable> {
  $$WeeklyPlanTicksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyPlanTicksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyPlanTicksTableTable> {
  $$WeeklyPlanTicksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$WeeklyPlanTicksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyPlanTicksTableTable,
          WeeklyPlanTicksTableData,
          $$WeeklyPlanTicksTableTableFilterComposer,
          $$WeeklyPlanTicksTableTableOrderingComposer,
          $$WeeklyPlanTicksTableTableAnnotationComposer,
          $$WeeklyPlanTicksTableTableCreateCompanionBuilder,
          $$WeeklyPlanTicksTableTableUpdateCompanionBuilder,
          (
            WeeklyPlanTicksTableData,
            BaseReferences<
              _$AppDatabase,
              $WeeklyPlanTicksTableTable,
              WeeklyPlanTicksTableData
            >,
          ),
          WeeklyPlanTicksTableData,
          PrefetchHooks Function()
        > {
  $$WeeklyPlanTicksTableTableTableManager(
    _$AppDatabase db,
    $WeeklyPlanTicksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyPlanTicksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyPlanTicksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WeeklyPlanTicksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> classId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<DateTime> weekStartDate = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyPlanTicksTableCompanion(
                id: id,
                classId: classId,
                scope: scope,
                weekStartDate: weekStartDate,
                groupName: groupName,
                activityId: activityId,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String classId,
                required String scope,
                required DateTime weekStartDate,
                required String groupName,
                required String activityId,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyPlanTicksTableCompanion.insert(
                id: id,
                classId: classId,
                scope: scope,
                weekStartDate: weekStartDate,
                groupName: groupName,
                activityId: activityId,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $WeeklyPlanTicksTableTable,
                    WeeklyPlanTicksTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WeeklyPlanTicksTableTable,
                    WeeklyPlanTicksTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeeklyPlanTicksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyPlanTicksTableTable,
      WeeklyPlanTicksTableData,
      $$WeeklyPlanTicksTableTableFilterComposer,
      $$WeeklyPlanTicksTableTableOrderingComposer,
      $$WeeklyPlanTicksTableTableAnnotationComposer,
      $$WeeklyPlanTicksTableTableCreateCompanionBuilder,
      $$WeeklyPlanTicksTableTableUpdateCompanionBuilder,
      (
        WeeklyPlanTicksTableData,
        BaseReferences<
          _$AppDatabase,
          $WeeklyPlanTicksTableTable,
          WeeklyPlanTicksTableData
        >,
      ),
      WeeklyPlanTicksTableData,
      PrefetchHooks Function()
    >;
typedef $$ParentReportsTableTableCreateCompanionBuilder =
    ParentReportsTableCompanion Function({
      required String id,
      required String checkId,
      required String childId,
      required String scope,
      Value<bool> teacherApproved,
      Value<DateTime?> approvedAt,
      Value<int> rowid,
    });
typedef $$ParentReportsTableTableUpdateCompanionBuilder =
    ParentReportsTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<String> childId,
      Value<String> scope,
      Value<bool> teacherApproved,
      Value<DateTime?> approvedAt,
      Value<int> rowid,
    });

class $$ParentReportsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ParentReportsTableTable> {
  $$ParentReportsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get teacherApproved => $composableBuilder(
    column: $table.teacherApproved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ParentReportsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ParentReportsTableTable> {
  $$ParentReportsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get childId => $composableBuilder(
    column: $table.childId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get teacherApproved => $composableBuilder(
    column: $table.teacherApproved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ParentReportsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParentReportsTableTable> {
  $$ParentReportsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<String> get childId =>
      $composableBuilder(column: $table.childId, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<bool> get teacherApproved => $composableBuilder(
    column: $table.teacherApproved,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );
}

class $$ParentReportsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParentReportsTableTable,
          ParentReportsTableData,
          $$ParentReportsTableTableFilterComposer,
          $$ParentReportsTableTableOrderingComposer,
          $$ParentReportsTableTableAnnotationComposer,
          $$ParentReportsTableTableCreateCompanionBuilder,
          $$ParentReportsTableTableUpdateCompanionBuilder,
          (
            ParentReportsTableData,
            BaseReferences<
              _$AppDatabase,
              $ParentReportsTableTable,
              ParentReportsTableData
            >,
          ),
          ParentReportsTableData,
          PrefetchHooks Function()
        > {
  $$ParentReportsTableTableTableManager(
    _$AppDatabase db,
    $ParentReportsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParentReportsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParentReportsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParentReportsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<String> childId = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<bool> teacherApproved = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParentReportsTableCompanion(
                id: id,
                checkId: checkId,
                childId: childId,
                scope: scope,
                teacherApproved: teacherApproved,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required String childId,
                required String scope,
                Value<bool> teacherApproved = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParentReportsTableCompanion.insert(
                id: id,
                checkId: checkId,
                childId: childId,
                scope: scope,
                teacherApproved: teacherApproved,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParentReportsTableTable, ParentReportsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ParentReportsTableTable,
                    ParentReportsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ParentReportsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParentReportsTableTable,
      ParentReportsTableData,
      $$ParentReportsTableTableFilterComposer,
      $$ParentReportsTableTableOrderingComposer,
      $$ParentReportsTableTableAnnotationComposer,
      $$ParentReportsTableTableCreateCompanionBuilder,
      $$ParentReportsTableTableUpdateCompanionBuilder,
      (
        ParentReportsTableData,
        BaseReferences<
          _$AppDatabase,
          $ParentReportsTableTable,
          ParentReportsTableData
        >,
      ),
      ParentReportsTableData,
      PrefetchHooks Function()
    >;
typedef $$AcceptedPronunciationsTableTableCreateCompanionBuilder =
    AcceptedPronunciationsTableCompanion Function({
      required String id,
      required String standardWord,
      required String regionalVariant,
      required String scope,
      required DateTime acceptedAt,
      Value<int> rowid,
    });
typedef $$AcceptedPronunciationsTableTableUpdateCompanionBuilder =
    AcceptedPronunciationsTableCompanion Function({
      Value<String> id,
      Value<String> standardWord,
      Value<String> regionalVariant,
      Value<String> scope,
      Value<DateTime> acceptedAt,
      Value<int> rowid,
    });

class $$AcceptedPronunciationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AcceptedPronunciationsTableTable> {
  $$AcceptedPronunciationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get standardWord => $composableBuilder(
    column: $table.standardWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionalVariant => $composableBuilder(
    column: $table.regionalVariant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AcceptedPronunciationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AcceptedPronunciationsTableTable> {
  $$AcceptedPronunciationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get standardWord => $composableBuilder(
    column: $table.standardWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionalVariant => $composableBuilder(
    column: $table.regionalVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AcceptedPronunciationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AcceptedPronunciationsTableTable> {
  $$AcceptedPronunciationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get standardWord => $composableBuilder(
    column: $table.standardWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionalVariant => $composableBuilder(
    column: $table.regionalVariant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<DateTime> get acceptedAt => $composableBuilder(
    column: $table.acceptedAt,
    builder: (column) => column,
  );
}

class $$AcceptedPronunciationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AcceptedPronunciationsTableTable,
          AcceptedPronunciationsTableData,
          $$AcceptedPronunciationsTableTableFilterComposer,
          $$AcceptedPronunciationsTableTableOrderingComposer,
          $$AcceptedPronunciationsTableTableAnnotationComposer,
          $$AcceptedPronunciationsTableTableCreateCompanionBuilder,
          $$AcceptedPronunciationsTableTableUpdateCompanionBuilder,
          (
            AcceptedPronunciationsTableData,
            BaseReferences<
              _$AppDatabase,
              $AcceptedPronunciationsTableTable,
              AcceptedPronunciationsTableData
            >,
          ),
          AcceptedPronunciationsTableData,
          PrefetchHooks Function()
        > {
  $$AcceptedPronunciationsTableTableTableManager(
    _$AppDatabase db,
    $AcceptedPronunciationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AcceptedPronunciationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AcceptedPronunciationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AcceptedPronunciationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> standardWord = const Value.absent(),
                Value<String> regionalVariant = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<DateTime> acceptedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AcceptedPronunciationsTableCompanion(
                id: id,
                standardWord: standardWord,
                regionalVariant: regionalVariant,
                scope: scope,
                acceptedAt: acceptedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String standardWord,
                required String regionalVariant,
                required String scope,
                required DateTime acceptedAt,
                Value<int> rowid = const Value.absent(),
              }) => AcceptedPronunciationsTableCompanion.insert(
                id: id,
                standardWord: standardWord,
                regionalVariant: regionalVariant,
                scope: scope,
                acceptedAt: acceptedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $AcceptedPronunciationsTableTable,
                    AcceptedPronunciationsTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AcceptedPronunciationsTableTable,
                    AcceptedPronunciationsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AcceptedPronunciationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AcceptedPronunciationsTableTable,
      AcceptedPronunciationsTableData,
      $$AcceptedPronunciationsTableTableFilterComposer,
      $$AcceptedPronunciationsTableTableOrderingComposer,
      $$AcceptedPronunciationsTableTableAnnotationComposer,
      $$AcceptedPronunciationsTableTableCreateCompanionBuilder,
      $$AcceptedPronunciationsTableTableUpdateCompanionBuilder,
      (
        AcceptedPronunciationsTableData,
        BaseReferences<
          _$AppDatabase,
          $AcceptedPronunciationsTableTable,
          AcceptedPronunciationsTableData
        >,
      ),
      AcceptedPronunciationsTableData,
      PrefetchHooks Function()
    >;
typedef $$MediaIndexTableTableCreateCompanionBuilder =
    MediaIndexTableCompanion Function({
      required String id,
      required String checkId,
      required String mediaType,
      required String filePath,
      required DateTime createdAt,
      required DateTime expiresAt,
      Value<bool> isPurged,
      Value<int> rowid,
    });
typedef $$MediaIndexTableTableUpdateCompanionBuilder =
    MediaIndexTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<String> mediaType,
      Value<String> filePath,
      Value<DateTime> createdAt,
      Value<DateTime> expiresAt,
      Value<bool> isPurged,
      Value<int> rowid,
    });

class $$MediaIndexTableTableFilterComposer
    extends Composer<_$AppDatabase, $MediaIndexTableTable> {
  $$MediaIndexTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPurged => $composableBuilder(
    column: $table.isPurged,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MediaIndexTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaIndexTableTable> {
  $$MediaIndexTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPurged => $composableBuilder(
    column: $table.isPurged,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MediaIndexTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaIndexTableTable> {
  $$MediaIndexTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get isPurged =>
      $composableBuilder(column: $table.isPurged, builder: (column) => column);
}

class $$MediaIndexTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaIndexTableTable,
          MediaIndexTableData,
          $$MediaIndexTableTableFilterComposer,
          $$MediaIndexTableTableOrderingComposer,
          $$MediaIndexTableTableAnnotationComposer,
          $$MediaIndexTableTableCreateCompanionBuilder,
          $$MediaIndexTableTableUpdateCompanionBuilder,
          (
            MediaIndexTableData,
            BaseReferences<
              _$AppDatabase,
              $MediaIndexTableTable,
              MediaIndexTableData
            >,
          ),
          MediaIndexTableData,
          PrefetchHooks Function()
        > {
  $$MediaIndexTableTableTableManager(
    _$AppDatabase db,
    $MediaIndexTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaIndexTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaIndexTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaIndexTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<bool> isPurged = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaIndexTableCompanion(
                id: id,
                checkId: checkId,
                mediaType: mediaType,
                filePath: filePath,
                createdAt: createdAt,
                expiresAt: expiresAt,
                isPurged: isPurged,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required String mediaType,
                required String filePath,
                required DateTime createdAt,
                required DateTime expiresAt,
                Value<bool> isPurged = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaIndexTableCompanion.insert(
                id: id,
                checkId: checkId,
                mediaType: mediaType,
                filePath: filePath,
                createdAt: createdAt,
                expiresAt: expiresAt,
                isPurged: isPurged,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MediaIndexTableTable, MediaIndexTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $MediaIndexTableTable,
                    MediaIndexTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MediaIndexTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaIndexTableTable,
      MediaIndexTableData,
      $$MediaIndexTableTableFilterComposer,
      $$MediaIndexTableTableOrderingComposer,
      $$MediaIndexTableTableAnnotationComposer,
      $$MediaIndexTableTableCreateCompanionBuilder,
      $$MediaIndexTableTableUpdateCompanionBuilder,
      (
        MediaIndexTableData,
        BaseReferences<
          _$AppDatabase,
          $MediaIndexTableTable,
          MediaIndexTableData
        >,
      ),
      MediaIndexTableData,
      PrefetchHooks Function()
    >;
typedef $$AuditEventsTableTableCreateCompanionBuilder =
    AuditEventsTableCompanion Function({
      required String id,
      required String eventType,
      Value<String?> details,
      required DateTime timestamp,
      Value<int> rowid,
    });
typedef $$AuditEventsTableTableUpdateCompanionBuilder =
    AuditEventsTableCompanion Function({
      Value<String> id,
      Value<String> eventType,
      Value<String?> details,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

class $$AuditEventsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditEventsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditEventsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$AuditEventsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditEventsTableTable,
          AuditEventsTableData,
          $$AuditEventsTableTableFilterComposer,
          $$AuditEventsTableTableOrderingComposer,
          $$AuditEventsTableTableAnnotationComposer,
          $$AuditEventsTableTableCreateCompanionBuilder,
          $$AuditEventsTableTableUpdateCompanionBuilder,
          (
            AuditEventsTableData,
            BaseReferences<
              _$AppDatabase,
              $AuditEventsTableTable,
              AuditEventsTableData
            >,
          ),
          AuditEventsTableData,
          PrefetchHooks Function()
        > {
  $$AuditEventsTableTableTableManager(
    _$AppDatabase db,
    $AuditEventsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditEventsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditEventsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditEventsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsTableCompanion(
                id: id,
                eventType: eventType,
                details: details,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventType,
                Value<String?> details = const Value.absent(),
                required DateTime timestamp,
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsTableCompanion.insert(
                id: id,
                eventType: eventType,
                details: details,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditEventsTableTable, AuditEventsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $AuditEventsTableTable,
                    AuditEventsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditEventsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditEventsTableTable,
      AuditEventsTableData,
      $$AuditEventsTableTableFilterComposer,
      $$AuditEventsTableTableOrderingComposer,
      $$AuditEventsTableTableAnnotationComposer,
      $$AuditEventsTableTableCreateCompanionBuilder,
      $$AuditEventsTableTableUpdateCompanionBuilder,
      (
        AuditEventsTableData,
        BaseReferences<
          _$AppDatabase,
          $AuditEventsTableTable,
          AuditEventsTableData
        >,
      ),
      AuditEventsTableData,
      PrefetchHooks Function()
    >;
typedef $$ChoiceResponsesTableTableCreateCompanionBuilder =
    ChoiceResponsesTableCompanion Function({
      required String id,
      required String checkId,
      required String itemId,
      required int level,
      required String type,
      Value<String?> firstChoice,
      Value<String?> finalChoice,
      required int timeMs,
      Value<int> changeCount,
      Value<String?> distractorTag,
      Value<double> weight,
      Value<String?> reason,
      required DateTime createdAt,
      Value<double> maxMarks,
      Value<String?> selfRating,
      Value<int> rowid,
    });
typedef $$ChoiceResponsesTableTableUpdateCompanionBuilder =
    ChoiceResponsesTableCompanion Function({
      Value<String> id,
      Value<String> checkId,
      Value<String> itemId,
      Value<int> level,
      Value<String> type,
      Value<String?> firstChoice,
      Value<String?> finalChoice,
      Value<int> timeMs,
      Value<int> changeCount,
      Value<String?> distractorTag,
      Value<double> weight,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<double> maxMarks,
      Value<String?> selfRating,
      Value<int> rowid,
    });

class $$ChoiceResponsesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChoiceResponsesTableTable> {
  $$ChoiceResponsesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstChoice => $composableBuilder(
    column: $table.firstChoice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finalChoice => $composableBuilder(
    column: $table.finalChoice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get changeCount => $composableBuilder(
    column: $table.changeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get distractorTag => $composableBuilder(
    column: $table.distractorTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxMarks => $composableBuilder(
    column: $table.maxMarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChoiceResponsesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChoiceResponsesTableTable> {
  $$ChoiceResponsesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkId => $composableBuilder(
    column: $table.checkId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstChoice => $composableBuilder(
    column: $table.firstChoice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finalChoice => $composableBuilder(
    column: $table.finalChoice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get changeCount => $composableBuilder(
    column: $table.changeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get distractorTag => $composableBuilder(
    column: $table.distractorTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxMarks => $composableBuilder(
    column: $table.maxMarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChoiceResponsesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChoiceResponsesTableTable> {
  $$ChoiceResponsesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkId =>
      $composableBuilder(column: $table.checkId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get firstChoice => $composableBuilder(
    column: $table.firstChoice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get finalChoice => $composableBuilder(
    column: $table.finalChoice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeMs =>
      $composableBuilder(column: $table.timeMs, builder: (column) => column);

  GeneratedColumn<int> get changeCount => $composableBuilder(
    column: $table.changeCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get distractorTag => $composableBuilder(
    column: $table.distractorTag,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get maxMarks =>
      $composableBuilder(column: $table.maxMarks, builder: (column) => column);

  GeneratedColumn<String> get selfRating => $composableBuilder(
    column: $table.selfRating,
    builder: (column) => column,
  );
}

class $$ChoiceResponsesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChoiceResponsesTableTable,
          ChoiceResponsesTableData,
          $$ChoiceResponsesTableTableFilterComposer,
          $$ChoiceResponsesTableTableOrderingComposer,
          $$ChoiceResponsesTableTableAnnotationComposer,
          $$ChoiceResponsesTableTableCreateCompanionBuilder,
          $$ChoiceResponsesTableTableUpdateCompanionBuilder,
          (
            ChoiceResponsesTableData,
            BaseReferences<
              _$AppDatabase,
              $ChoiceResponsesTableTable,
              ChoiceResponsesTableData
            >,
          ),
          ChoiceResponsesTableData,
          PrefetchHooks Function()
        > {
  $$ChoiceResponsesTableTableTableManager(
    _$AppDatabase db,
    $ChoiceResponsesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChoiceResponsesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChoiceResponsesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChoiceResponsesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checkId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> firstChoice = const Value.absent(),
                Value<String?> finalChoice = const Value.absent(),
                Value<int> timeMs = const Value.absent(),
                Value<int> changeCount = const Value.absent(),
                Value<String?> distractorTag = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> maxMarks = const Value.absent(),
                Value<String?> selfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChoiceResponsesTableCompanion(
                id: id,
                checkId: checkId,
                itemId: itemId,
                level: level,
                type: type,
                firstChoice: firstChoice,
                finalChoice: finalChoice,
                timeMs: timeMs,
                changeCount: changeCount,
                distractorTag: distractorTag,
                weight: weight,
                reason: reason,
                createdAt: createdAt,
                maxMarks: maxMarks,
                selfRating: selfRating,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checkId,
                required String itemId,
                required int level,
                required String type,
                Value<String?> firstChoice = const Value.absent(),
                Value<String?> finalChoice = const Value.absent(),
                required int timeMs,
                Value<int> changeCount = const Value.absent(),
                Value<String?> distractorTag = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required DateTime createdAt,
                Value<double> maxMarks = const Value.absent(),
                Value<String?> selfRating = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChoiceResponsesTableCompanion.insert(
                id: id,
                checkId: checkId,
                itemId: itemId,
                level: level,
                type: type,
                firstChoice: firstChoice,
                finalChoice: finalChoice,
                timeMs: timeMs,
                changeCount: changeCount,
                distractorTag: distractorTag,
                weight: weight,
                reason: reason,
                createdAt: createdAt,
                maxMarks: maxMarks,
                selfRating: selfRating,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ChoiceResponsesTableTable,
                    ChoiceResponsesTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ChoiceResponsesTableTable,
                    ChoiceResponsesTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChoiceResponsesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChoiceResponsesTableTable,
      ChoiceResponsesTableData,
      $$ChoiceResponsesTableTableFilterComposer,
      $$ChoiceResponsesTableTableOrderingComposer,
      $$ChoiceResponsesTableTableAnnotationComposer,
      $$ChoiceResponsesTableTableCreateCompanionBuilder,
      $$ChoiceResponsesTableTableUpdateCompanionBuilder,
      (
        ChoiceResponsesTableData,
        BaseReferences<
          _$AppDatabase,
          $ChoiceResponsesTableTable,
          ChoiceResponsesTableData
        >,
      ),
      ChoiceResponsesTableData,
      PrefetchHooks Function()
    >;
typedef $$TeacherProfileTableTableCreateCompanionBuilder =
    TeacherProfileTableCompanion Function({
      required String id,
      required String teacherName,
      Value<String?> schoolName,
      Value<String> preferredLanguage,
      Value<String?> displayName,
      Value<String?> role,
      Value<String?> udiseCode,
      Value<String?> block,
      Value<String?> district,
      Value<String?> state,
      Value<int?> yearsTeaching,
      Value<String?> phone,
      Value<String?> email,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TeacherProfileTableTableUpdateCompanionBuilder =
    TeacherProfileTableCompanion Function({
      Value<String> id,
      Value<String> teacherName,
      Value<String?> schoolName,
      Value<String> preferredLanguage,
      Value<String?> displayName,
      Value<String?> role,
      Value<String?> udiseCode,
      Value<String?> block,
      Value<String?> district,
      Value<String?> state,
      Value<int?> yearsTeaching,
      Value<String?> phone,
      Value<String?> email,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TeacherProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $TeacherProfileTableTable> {
  $$TeacherProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teacherName => $composableBuilder(
    column: $table.teacherName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get udiseCode => $composableBuilder(
    column: $table.udiseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get block => $composableBuilder(
    column: $table.block,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearsTeaching => $composableBuilder(
    column: $table.yearsTeaching,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeacherProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TeacherProfileTableTable> {
  $$TeacherProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teacherName => $composableBuilder(
    column: $table.teacherName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get udiseCode => $composableBuilder(
    column: $table.udiseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get block => $composableBuilder(
    column: $table.block,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearsTeaching => $composableBuilder(
    column: $table.yearsTeaching,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeacherProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeacherProfileTableTable> {
  $$TeacherProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teacherName => $composableBuilder(
    column: $table.teacherName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schoolName => $composableBuilder(
    column: $table.schoolName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get udiseCode =>
      $composableBuilder(column: $table.udiseCode, builder: (column) => column);

  GeneratedColumn<String> get block =>
      $composableBuilder(column: $table.block, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get yearsTeaching => $composableBuilder(
    column: $table.yearsTeaching,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TeacherProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeacherProfileTableTable,
          TeacherProfileTableData,
          $$TeacherProfileTableTableFilterComposer,
          $$TeacherProfileTableTableOrderingComposer,
          $$TeacherProfileTableTableAnnotationComposer,
          $$TeacherProfileTableTableCreateCompanionBuilder,
          $$TeacherProfileTableTableUpdateCompanionBuilder,
          (
            TeacherProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $TeacherProfileTableTable,
              TeacherProfileTableData
            >,
          ),
          TeacherProfileTableData,
          PrefetchHooks Function()
        > {
  $$TeacherProfileTableTableTableManager(
    _$AppDatabase db,
    $TeacherProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeacherProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeacherProfileTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TeacherProfileTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teacherName = const Value.absent(),
                Value<String?> schoolName = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<String?> udiseCode = const Value.absent(),
                Value<String?> block = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<int?> yearsTeaching = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeacherProfileTableCompanion(
                id: id,
                teacherName: teacherName,
                schoolName: schoolName,
                preferredLanguage: preferredLanguage,
                displayName: displayName,
                role: role,
                udiseCode: udiseCode,
                block: block,
                district: district,
                state: state,
                yearsTeaching: yearsTeaching,
                phone: phone,
                email: email,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teacherName,
                Value<String?> schoolName = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<String?> udiseCode = const Value.absent(),
                Value<String?> block = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<int?> yearsTeaching = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TeacherProfileTableCompanion.insert(
                id: id,
                teacherName: teacherName,
                schoolName: schoolName,
                preferredLanguage: preferredLanguage,
                displayName: displayName,
                role: role,
                udiseCode: udiseCode,
                block: block,
                district: district,
                state: state,
                yearsTeaching: yearsTeaching,
                phone: phone,
                email: email,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $TeacherProfileTableTable,
                    TeacherProfileTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TeacherProfileTableTable,
                    TeacherProfileTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeacherProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeacherProfileTableTable,
      TeacherProfileTableData,
      $$TeacherProfileTableTableFilterComposer,
      $$TeacherProfileTableTableOrderingComposer,
      $$TeacherProfileTableTableAnnotationComposer,
      $$TeacherProfileTableTableCreateCompanionBuilder,
      $$TeacherProfileTableTableUpdateCompanionBuilder,
      (
        TeacherProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $TeacherProfileTableTable,
          TeacherProfileTableData
        >,
      ),
      TeacherProfileTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
  $$ClassesTableTableTableManager get classesTable =>
      $$ClassesTableTableTableManager(_db, _db.classesTable);
  $$ChildrenTableTableTableManager get childrenTable =>
      $$ChildrenTableTableTableManager(_db, _db.childrenTable);
  $$ConsentsTableTableTableManager get consentsTable =>
      $$ConsentsTableTableTableManager(_db, _db.consentsTable);
  $$GroupAssignmentsTableTableTableManager get groupAssignmentsTable =>
      $$GroupAssignmentsTableTableTableManager(_db, _db.groupAssignmentsTable);
  $$ChecksTableTableTableManager get checksTable =>
      $$ChecksTableTableTableManager(_db, _db.checksTable);
  $$WordMarksTableTableTableManager get wordMarksTable =>
      $$WordMarksTableTableTableManager(_db, _db.wordMarksTable);
  $$RetellPointsTableTableTableManager get retellPointsTable =>
      $$RetellPointsTableTableTableManager(_db, _db.retellPointsTable);
  $$QuestionAnswersTableTableTableManager get questionAnswersTable =>
      $$QuestionAnswersTableTableTableManager(_db, _db.questionAnswersTable);
  $$DictationItemsTableTableTableManager get dictationItemsTable =>
      $$DictationItemsTableTableTableManager(_db, _db.dictationItemsTable);
  $$ListeningChecksTableTableTableManager get listeningChecksTable =>
      $$ListeningChecksTableTableTableManager(_db, _db.listeningChecksTable);
  $$ResultsTableTableTableManager get resultsTable =>
      $$ResultsTableTableTableManager(_db, _db.resultsTable);
  $$PracticeNeedsTableTableTableManager get practiceNeedsTable =>
      $$PracticeNeedsTableTableTableManager(_db, _db.practiceNeedsTable);
  $$WeeklyPlanTicksTableTableTableManager get weeklyPlanTicksTable =>
      $$WeeklyPlanTicksTableTableTableManager(_db, _db.weeklyPlanTicksTable);
  $$ParentReportsTableTableTableManager get parentReportsTable =>
      $$ParentReportsTableTableTableManager(_db, _db.parentReportsTable);
  $$AcceptedPronunciationsTableTableTableManager
  get acceptedPronunciationsTable =>
      $$AcceptedPronunciationsTableTableTableManager(
        _db,
        _db.acceptedPronunciationsTable,
      );
  $$MediaIndexTableTableTableManager get mediaIndexTable =>
      $$MediaIndexTableTableTableManager(_db, _db.mediaIndexTable);
  $$AuditEventsTableTableTableManager get auditEventsTable =>
      $$AuditEventsTableTableTableManager(_db, _db.auditEventsTable);
  $$ChoiceResponsesTableTableTableManager get choiceResponsesTable =>
      $$ChoiceResponsesTableTableTableManager(_db, _db.choiceResponsesTable);
  $$TeacherProfileTableTableTableManager get teacherProfileTable =>
      $$TeacherProfileTableTableTableManager(_db, _db.teacherProfileTable);
}
