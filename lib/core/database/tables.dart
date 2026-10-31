import 'package:drift/drift.dart';

// 1. App Settings Table
class AppSettingsTable extends Table {
  TextColumn get id => text()();
  TextColumn get activeScope => text().withDefault(const Constant('demo'))(); // 'demo' or 'real'
  TextColumn get appLanguage => text().withDefault(const Constant('hi'))(); // 'hi' or 'en'
  TextColumn get readingLanguage => text().withDefault(const Constant('hi'))(); // 'hi' or 'en'
  TextColumn get passcodeHash => text().nullable()();
  TextColumn get passcodeSalt => text().nullable()();
  IntColumn get failedPasscodeAttempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get lockoutUntil => dateTime().nullable()();
  BoolColumn get useFingerprint => boolean().withDefault(const Constant(false))();
  RealColumn get textSizeScale => real().withDefault(const Constant(1.0))();
  IntColumn get suggestedChecksWindowDays => integer().withDefault(const Constant(5))();
  IntColumn get recheckPeriodWeeks => integer().withDefault(const Constant(3))();
  IntColumn get backupReminderPeriodDays => integer().withDefault(const Constant(14))();
  DateTimeColumn get lastBackupTimestamp => dateTime().nullable()();
  TextColumn get legalReviewerName => text().nullable()();
  DateTimeColumn get legalReviewDate => dateTime().nullable()();
  BoolColumn get legalReviewCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get activeClassId => text().nullable()();
  BoolColumn get deviceDataConsentGiven => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deviceDataConsentDate => dateTime().nullable()();
  BoolColumn get audioRecordingConsentGiven => boolean().withDefault(const Constant(false))();
  DateTimeColumn get audioRecordingConsentDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 2. Classes Table
class ClassesTable extends Table {
  TextColumn get id => text()();
  TextColumn get scope => text()(); // 'demo' or 'real'
  TextColumn get name => text()(); // e.g., 'Class 3B'
  IntColumn get grade => integer()(); // 1 to 5
  TextColumn get section => text()(); // e.g., 'B'
  TextColumn get curriculum => text()(); // 'up', 'ncert', 'rajasthan', 'own'
  TextColumn get checkLanguage => text()(); // 'hi' or 'en'
  TextColumn get mediumOfInstruction => text()(); // 'hi' or 'en'
  TextColumn get textbookId => text().nullable()();
  TextColumn get currentChapter => text().nullable()();
  TextColumn get homeDialect => text().nullable()(); // 'awadhi_bhojpuri', 'rajasthani', 'marathi_influenced', 'punjabi_influenced'
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. Children Table
class ChildrenTable extends Table {
  TextColumn get id => text()();
  TextColumn get classId => text()();
  TextColumn get scope => text()(); // 'demo' or 'real'
  TextColumn get firstName => text()();
  TextColumn get lastInitial => text()();
  TextColumn get homeLanguage => text()(); // e.g. 'hi'
  TextColumn get homeDialect => text().nullable()();
  TextColumn get currentGroup => text().withDefault(const Constant('not_grouped'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 4. Consents Table
class ConsentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get scope => text()();
  BoolColumn get consentGiven => boolean().withDefault(const Constant(false))();
  DateTimeColumn get consentDate => dateTime()();
  BoolColumn get withdrawn => boolean().withDefault(const Constant(false))();
  DateTimeColumn get withdrawnDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 5. Group Assignments History Table
class GroupAssignmentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get scope => text()();
  TextColumn get fromGroup => text()();
  TextColumn get toGroup => text()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get movedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 6. Checks Table (Continuous, resumable assessment flow)
class ChecksTable extends Table {
  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get classId => text()();
  TextColumn get scope => text()();
  TextColumn get status => text()(); // 'in_progress', 'completed', 'abandoned'
  TextColumn get currentStep => text()(); // 'handover', 'student_mode', 'mark_reading', 'retell', 'questions', 'dictation', 'listening', 'result'
  TextColumn get passageId => text()();
  TextColumn get passageTitle => text()();
  IntColumn get passageLevel => integer()();
  RealColumn get noiseLevel => real().nullable()();
  BoolColumn get isLowConfidence => boolean().withDefault(const Constant(false))();
  TextColumn get audioPath => text().nullable()();
  BoolColumn get markedWithoutRecording => boolean().withDefault(const Constant(false))();
  TextColumn get benchmarkUsedJson => text().nullable()();
  TextColumn get rubricVersion => text().withDefault(const Constant('v0.1'))();
  RealColumn get readingDurationSeconds => real().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// v7: child's own thumbs up / down after reading aloud
  /// ('thumbs_up' | 'thumbs_down' | 'not_recorded').
  TextColumn get readingSelfRating => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 7. Word Marks Table
class WordMarksTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  IntColumn get wordIndex => integer()();
  TextColumn get expectedWord => text()();
  TextColumn get actualWord => text().nullable()();
  TextColumn get mark => text()(); // 'correct', 'other_word', 'skipped', 'self_corrected', 'repeated', 'not_sure', 'not_reached'
  TextColumn get errorSubtype => text().nullable()(); // 'consonant', 'short_matra', 'long_matra', 'conjunct', 'halant', 'bindu', 'chandrabindu', 'nukta'

  @override
  Set<Column> get primaryKey => {id};
}

// 8. Retell Points Table
class RetellPointsTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  IntColumn get pointIndex => integer()();
  TextColumn get pointText => text()();
  BoolColumn get isMentioned => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

// 9. Question Answers Table
class QuestionAnswersTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  TextColumn get questionId => text()();
  TextColumn get questionType => text()(); // 'fact', 'cause_effect', 'word_meaning', 'why_how'
  TextColumn get answerStatus => text()(); // 'correct', 'partly', 'not_correct', 'no_answer', 'not_asked'

  // v7: level-wise questions with weighted, time-adjusted marks.
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get timeMs => integer().nullable()();
  RealColumn get marks => real().nullable()();
  RealColumn get maxMarks => real().nullable()();
  TextColumn get selfRating => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 10. Dictation Items Table
class DictationItemsTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  IntColumn get itemIndex => integer()();
  TextColumn get word => text()();
  BoolColumn get isCorrect => boolean()();
  BoolColumn get isSkipped => boolean().withDefault(const Constant(false))();
  TextColumn get errorType => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 11. Listening Checks Table
class ListeningChecksTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  BoolColumn get isOffered => boolean()();
  BoolColumn get isCompleted => boolean()();
  IntColumn get pointsEarned => integer()();
  IntColumn get totalPoints => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 12. Results Table
class ResultsTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  TextColumn get childId => text()();
  TextColumn get scope => text()();
  TextColumn get groupAssigned => text()();
  TextColumn get groupReason => text()();
  TextColumn get nextStepRecommendation => text()();
  IntColumn get totalWords => integer()();
  IntColumn get attemptedWords => integer()();
  IntColumn get correctWords => integer()();
  RealColumn get accuracyPercentage => real()();
  RealColumn get readingSpeedWpm => real().nullable()();
  BoolColumn get speedHasEvidence => boolean()();
  TextColumn get speedTargetOfficial => text().nullable()();
  TextColumn get comprehensionFactScore => text()(); // e.g. '2 of 2'
  TextColumn get retellScore => text()(); // e.g. '3 of 4'
  TextColumn get dictationScore => text()(); // e.g. '4 of 5' or 'Skipped'
  TextColumn get stuckOnAksharasJson => text().nullable()();

  // v7: child typing check summary and the child's own ratings (JSON).
  TextColumn get typingScore => text().nullable()();
  TextColumn get selfRatingSummaryJson => text().nullable()();
  BoolColumn get isLowConfidence => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 13. Practice Needs Table
class PracticeNeedsTable extends Table {
  TextColumn get id => text()();
  TextColumn get childId => text()();
  TextColumn get scope => text()();
  TextColumn get gapType => text()();
  TextColumn get gapDetail => text()();
  TextColumn get activityId => text()();
  BoolColumn get isSheetPrinted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastPrintedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 14. Weekly Plan Ticks Table
class WeeklyPlanTicksTable extends Table {
  TextColumn get id => text()();
  TextColumn get classId => text()();
  TextColumn get scope => text()();
  DateTimeColumn get weekStartDate => dateTime()();
  TextColumn get groupName => text()();
  TextColumn get activityId => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 15. Parent Reports Table
class ParentReportsTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  TextColumn get childId => text()();
  TextColumn get scope => text()();
  BoolColumn get teacherApproved => boolean().withDefault(const Constant(false))();
  DateTimeColumn get approvedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 16. Accepted Pronunciations Table
class AcceptedPronunciationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get standardWord => text()();
  TextColumn get regionalVariant => text()();
  TextColumn get scope => text()();
  DateTimeColumn get acceptedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 17. Media Index Table (Encrypted Vault tracking & purging)
class MediaIndexTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  TextColumn get mediaType => text()(); // 'audio' (strictly audio only; no photos or OCR)
  TextColumn get filePath => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();
  BoolColumn get isPurged => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// 18. Audit Events Table (Strictly NO personal data)
class AuditEventsTable extends Table {
  TextColumn get id => text()();
  TextColumn get eventType => text()(); // 'mode_switched_real', 'mode_switched_demo', 'passcode_changed', 'data_purged', 'backup_exported'
  TextColumn get details => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 19. Choice Responses Table (Child-Facing Word Check & Formative Assessment Items)
class ChoiceResponsesTable extends Table {
  TextColumn get id => text()();
  TextColumn get checkId => text()();
  TextColumn get itemId => text()();
  IntColumn get level => integer()();
  TextColumn get type => text()(); // 'writing_position', 'spelling', 'sound_recognition', 'fill_blank', 'odd_one_out', 'meaning_inference', 'sentence_match', etc.
  TextColumn get firstChoice => text().nullable()();
  TextColumn get finalChoice => text().nullable()();
  IntColumn get timeMs => integer()();
  IntColumn get changeCount => integer().withDefault(const Constant(0))();
  TextColumn get distractorTag => text().nullable()();
  RealColumn get weight => real().withDefault(const Constant(1.0))();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  // v7: the most the item could earn (its level weight), and the child's own
  // thumbs up / down. Typed spelling items use type 'typed_spelling'.
  RealColumn get maxMarks => real().withDefault(const Constant(1.0))();
  TextColumn get selfRating => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 20. Teacher Profile Table
class TeacherProfileTable extends Table {
  TextColumn get id => text()(); // 'teacher_profile_single'
  TextColumn get teacherName => text()();
  TextColumn get schoolName => text().nullable()();
  TextColumn get preferredLanguage => text().withDefault(const Constant('hi'))(); // 'hi' or 'en'
  // Profile details (v8). All optional and kept only on this phone.
  TextColumn get displayName => text().nullable()(); // what children call the teacher, e.g. "Sunita ji"
  TextColumn get role => text().nullable()(); // 'teacher' | 'head_teacher' | 'para_teacher' | 'other'
  TextColumn get udiseCode => text().nullable()(); // 11-digit school code
  TextColumn get block => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get state => text().nullable()(); // 'rajasthan' | 'uttar_pradesh' | 'other'
  IntColumn get yearsTeaching => integer().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
