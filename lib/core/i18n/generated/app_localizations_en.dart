// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Samajh';

  @override
  String get appTitleDevanagari => 'Samajh समझ';

  @override
  String get appSubtitle => 'Reading, Understanding & Writing Assessment';

  @override
  String get welcomeHeadline => 'See what every child understands';

  @override
  String get welcomeSubtitle =>
      'Check a child\'s reading, understanding, and writing in 4 minutes. Works without internet.';

  @override
  String get selectLanguage => 'Select your language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिंदी (Hindi)';

  @override
  String get marathi => 'मराठी (Marathi)';

  @override
  String get continueButton => 'Continue';

  @override
  String get getStartedButton => 'Get started';

  @override
  String get backButton => 'Back';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get doneButton => 'Done';

  @override
  String get closeButton => 'Close';

  @override
  String get nextButton => 'Next';

  @override
  String get none => 'None';

  @override
  String get yesButton => 'Yes';

  @override
  String get notNowButton => 'Not now';

  @override
  String get privacyTitle => 'Privacy';

  @override
  String get privacySubtitle => 'Your classroom data stays on this device';

  @override
  String get privacyPoint1Title =>
      'Everything is stored on this phone, encrypted';

  @override
  String get privacyPoint1Desc =>
      'All data is encrypted locally on this device. Optional cloud sync is off by default, and no data is shared without teacher sign-in.';

  @override
  String get privacyPoint2Title => 'Recordings deleted after checking';

  @override
  String get privacyPoint2Desc =>
      'Reading recordings never leave the phone and are deleted after checking.';

  @override
  String get privacyPoint3Title => 'Minimal information needed';

  @override
  String get privacyPoint3Desc =>
      'Only a first name and initial are needed (no dates of birth, addresses or ID numbers).';

  @override
  String get privacyPoint4Title => 'Your classroom, 100% offline';

  @override
  String get privacyPoint4Desc =>
      'Assess children with full data privacy. Zero trackers, zero ads, and offline-first design with sync off by default.';

  @override
  String get privacyAccept => 'Continue';

  @override
  String get privacyConsentStorage =>
      'I understand this app keeps children\'s data only on this phone, encrypted, and I will not enter real children\'s data until my school approves.';

  @override
  String get privacyConsentAudio =>
      'Allow Samajh to use the microphone to record a child\'s reading. The recording is stored encrypted on this phone and deleted after I mark it.';

  @override
  String get passcodeTitle => 'Create Teacher Passcode';

  @override
  String get passcodeSubtitle =>
      'You will use this to open Samajh and to leave the children\'s screens';

  @override
  String get enterPasscode => 'Enter 6-digit passcode';

  @override
  String get confirmPasscode => 'Enter it again';

  @override
  String get passcodesDoNotMatch => 'Passcodes do not match. Please try again.';

  @override
  String get passcodeIncorrect => 'Incorrect passcode. Please try again.';

  @override
  String passcodeLockedUntil(Object seconds) {
    return 'Too many failed attempts. Try again in $seconds seconds.';
  }

  @override
  String get enterPasscodeToUnlock => 'Enter passcode to unlock';

  @override
  String get enterPasscodeToExitStudent =>
      'Enter your passcode to leave Student Mode';

  @override
  String get useFingerprintPrompt => 'Use fingerprint too?';

  @override
  String get classSetupTitle => 'Set Up Your Class';

  @override
  String get classSetupSubtitle =>
      'Configure your classroom details to match curriculum benchmarks';

  @override
  String get classNameLabel => 'Class / School Name';

  @override
  String get classNameHint => 'e.g., Class 3B or Primary School';

  @override
  String get gradeLabel => 'Grade / Class';

  @override
  String get grade1 => 'Class 1';

  @override
  String get grade2 => 'Class 2';

  @override
  String get grade3 => 'Class 3';

  @override
  String get grade4 => 'Class 4';

  @override
  String get grade5 => 'Class 5';

  @override
  String get sectionLabel => 'Section';

  @override
  String get boardLabel => 'Board / Curriculum';

  @override
  String get curriculumLabel => 'Curriculum';

  @override
  String get curriculumNcert => 'NCERT / CBSE';

  @override
  String get curriculumUp => 'Uttar Pradesh Basic Shiksha';

  @override
  String get curriculumBihar => 'Bihar SCERT / BSEB';

  @override
  String get curriculumRajasthan => 'Rajasthan RSCERT';

  @override
  String get curriculumMp => 'Madhya Pradesh Rajya Shiksha Kendra';

  @override
  String get curriculumMaharashtra => 'Maharashtra State Board (Balbharati)';

  @override
  String get curriculumIcse => 'ICSE / CISCE';

  @override
  String get curriculumSchoolOwn => 'School\'s Own Curriculum';

  @override
  String get schoolLanguageLabel => 'Language of the check';

  @override
  String get mediumOfInstructionLabel => 'Medium of instruction';

  @override
  String get createClassButton => 'Create Class & Continue';

  @override
  String get classProfileTitle => 'Active Class Profile';

  @override
  String get noChildrenInClassYet => 'No children in this class yet';

  @override
  String get addChildPrompt =>
      'Add students to begin checking reading and comprehension';

  @override
  String get classSettingsTitle => 'Class settings';

  @override
  String get saveClassSettings => 'Save class settings';

  @override
  String get classSettingsSaved => 'Class settings saved';

  @override
  String classMilestonesTitle(Object grade) {
    return 'Class $grade milestones';
  }

  @override
  String get tabToday => 'Today';

  @override
  String get tabClass => 'Class';

  @override
  String get tabPractice => 'Practice';

  @override
  String get tabReports => 'Reports';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get todayGreeting => 'Namaste, Teacher';

  @override
  String get checkNextChild => 'Check next child';

  @override
  String checkNextChildNamed(Object name) {
    return 'Check next child: $name';
  }

  @override
  String get allChildrenChecked => 'All children checked';

  @override
  String get addChildrenButton => 'Add children';

  @override
  String checkedProgress(Object checked, Object total) {
    return '$checked of $total children checked';
  }

  @override
  String suggestedToday(Object count) {
    return 'Suggested today: $count children';
  }

  @override
  String get todoTitle => 'To-do List';

  @override
  String get todoWaitingReview => 'Waiting for review';

  @override
  String get todoRechecksDue => 'Rechecks due';

  @override
  String get todoSheetsReady => 'Practice sheets ready';

  @override
  String get worksOfflineReassurance => 'Works offline';

  @override
  String get backupYourClass => 'Back up your class';

  @override
  String filterAll(Object count) {
    return 'All · $count';
  }

  @override
  String filterNotGrouped(Object count) {
    return 'Not grouped yet · $count';
  }

  @override
  String get groupOnTrack => 'On track';

  @override
  String get groupNeedsReading => 'Understands, needs help reading words';

  @override
  String get groupNeedsUnderstanding => 'Reads words, needs help understanding';

  @override
  String get groupNeedsBoth => 'Needs help with both';

  @override
  String get groupNotGroupedYet => 'Not grouped yet';

  @override
  String get groupHelperText =>
      'Groups are suggestions from the latest check. You can move any child.';

  @override
  String get statusChecked => 'Checked';

  @override
  String get statusNotChecked => 'Not checked yet';

  @override
  String get statusCheckedToday => 'Checked today';

  @override
  String statusCheckedOn(Object date) {
    return 'Checked on $date';
  }

  @override
  String get statusWaitingReview => 'Waiting for your review';

  @override
  String get statusConsentMissing => 'Consent pending';

  @override
  String get startCheck => 'Start a check';

  @override
  String get resumeCheck => 'Resume check';

  @override
  String get childProfileTitle => 'Child Profile';

  @override
  String get consentStatus => 'Parental Consent';

  @override
  String get consentGiven => 'Consent Given';

  @override
  String get consentWithdrawn => 'Consent Withdrawn';

  @override
  String get markConsent => 'Record Parental Consent';

  @override
  String get withdrawConsent => 'Withdraw Consent';

  @override
  String get moveToAnotherGroup => 'Move to another group';

  @override
  String get deleteChild => 'Delete this child';

  @override
  String get addChild => 'Add child';

  @override
  String get importCsv => 'Import from CSV';

  @override
  String beforeHandingOverTitle(Object name) {
    return 'Give the phone to $name';
  }

  @override
  String beforeHandingOverSubtitle(Object name) {
    return 'Teacher screens stay locked while $name uses the phone. To come back, tap Teacher and enter your passcode.';
  }

  @override
  String get originalPassageTag =>
      'Original Samajh passage, awaiting teacher review';

  @override
  String get checkTheRoom => 'Check the room';

  @override
  String get listenFor3Seconds => 'Listen for 3 seconds';

  @override
  String get startStudentMode => 'Start Student Mode';

  @override
  String get noiseCheckTitle => 'Checking classroom noise...';

  @override
  String get noiseLevelGood => 'Noise level: Good for check';

  @override
  String get noiseLevelHigh =>
      'It is noisy here. Move somewhere quieter if you can.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get continueAnyway => 'Continue anyway';

  @override
  String get markWithoutRecording => 'Mark without recording';

  @override
  String get handoverInstructions =>
      'Teacher screens stay locked while using the phone.';

  @override
  String get kiranGreeting => 'नमस्ते! मैं किरण हूँ।';

  @override
  String get kiranInstruction => 'यह कहानी ज़ोर से पढ़ो। आराम से पढ़ना।';

  @override
  String get studentRecordingIndicator => 'रिकॉर्ड हो रहा है';

  @override
  String get studentDoneReading => 'मैंने पढ़ लिया';

  @override
  String get shabaashTitle => 'शाबाश!';

  @override
  String get shabaashSubtitle => 'अब यह फोन शिक्षक जी को वापस दे दीजिए।';

  @override
  String get teacherUnlockButton => 'शिक्षक';

  @override
  String get markingTitle => 'Mark the reading';

  @override
  String get playRecording => 'Play Recording';

  @override
  String get pauseRecording => 'Pause';

  @override
  String get markingGuide => 'The recording is deleted when you save.';

  @override
  String get markCorrect => 'Correct';

  @override
  String get markReadAsAnotherWord => 'Read as another word';

  @override
  String get markSkipped => 'Skipped';

  @override
  String get markSelfCorrected => 'Corrected self';

  @override
  String get markRepeated => 'Repeated';

  @override
  String get markNotSure => 'Not sure';

  @override
  String get markNotReached => 'Not reached';

  @override
  String liveMarkingCount(Object errors, Object notSure, Object wordsRead) {
    return '$errors errors · $notSure not sure · $wordsRead words read';
  }

  @override
  String get saveAndContinue => 'Save and continue';

  @override
  String get micPermissionTitle => 'Audio Recording Permission';

  @override
  String get micPermissionDesc =>
      'Microphone access is needed to record reading so you can check pronunciation. Audio is encrypted locally and deleted on save.';

  @override
  String get grantMicPermission => 'Allow Microphone Access';

  @override
  String get micReadyBadge => 'Microphone Ready (Encrypted local)';

  @override
  String get pronunciationCheckTitle => 'Pronunciation Check';

  @override
  String get pronunciationCheckGuide => 'Pronunciation Guide';

  @override
  String get phoneticBreakdownTitle => 'Syllable and Phonetic Breakdown';

  @override
  String get markPronouncedCorrect => 'Pronounced correctly';

  @override
  String get markMispronounced => 'Mispronounced / Read differently';

  @override
  String get acceptRegionalPronunciation => 'Accept Regional Accent';

  @override
  String get regionalAccentBadge => 'Regional';

  @override
  String get regionalAccentExplanation =>
      'Home dialect accents (e.g. s/sh, v/b, d/r) are accepted without error penalty.';

  @override
  String commonRegionalVariants(Object variants) {
    return 'Common regional pronunciation: $variants';
  }

  @override
  String standardPronunciation(Object guide) {
    return 'Standard pronunciation: $guide';
  }

  @override
  String livePronunciationAccuracy(Object percent) {
    return 'Pronunciation: $percent%';
  }

  @override
  String get inspectWord => 'Inspect word';

  @override
  String get nextWord => 'Next word';

  @override
  String get prevWord => 'Previous word';

  @override
  String get errorKindConsonant => 'Consonant error';

  @override
  String get errorKindShortMatra => 'Short matra error';

  @override
  String get errorKindLongMatra => 'Long matra error';

  @override
  String get errorKindConjunct => 'Conjunct error';

  @override
  String get errorKindNukta => 'Nukta error';

  @override
  String get errorKindBindu => 'Bindu / Anusvara error';

  @override
  String get soundErrorType => 'Pronunciation error type';

  @override
  String get observedWordPrompt => 'What did the child pronounce?';

  @override
  String get retellTitle => 'Tell me the story';

  @override
  String get retellSubtitle =>
      'Ask the child to tell the story in their own words. Tick each point they mention, in any language.';

  @override
  String get skipRetelling => 'Skip retelling';

  @override
  String get continueToQuestions => 'Continue to questions';

  @override
  String get questionsTitle => 'Questions';

  @override
  String get dictationTitle => 'Dictation';

  @override
  String get dictationSubtitle =>
      'Each item is shown to the teacher with Written correctly and Not correct.';

  @override
  String get skipDictation => 'Skip dictation';

  @override
  String get saveAndSeeResult => 'Save and see result';

  @override
  String get seeTheResult => 'See the result';

  @override
  String get continueToDictation => 'Continue to dictation';

  @override
  String get listeningCheckTitle => 'Listening Check';

  @override
  String get resultsTitle => 'Result in plain words';

  @override
  String officialTarget(Object source) {
    return 'Official Target ($source)';
  }

  @override
  String get suggestedGroup => 'Suggested Group';

  @override
  String get readingSpeed => 'Reading speed';

  @override
  String get readingAccuracy => 'Reading accuracy';

  @override
  String get understandingScore => 'Understanding';

  @override
  String get writingScore => 'Writing';

  @override
  String wordsPerMinute(Object wpm) {
    return '$wpm words per minute';
  }

  @override
  String get nextTeachingStep => 'One next step';

  @override
  String get printPracticeSheet => 'Print practice sheet';

  @override
  String get checkNextStudent => 'Check next child';

  @override
  String get notEnoughEvidence =>
      'Not enough evidence: no reading could be heard or marked';

  @override
  String get correctAMarking => 'Something wrong? Correct a marking';

  @override
  String get samajhRubricProvisional => 'Samajh rubric v0.1 (provisional)';

  @override
  String get backToClass => 'Back to class';

  @override
  String get demoModeBanner =>
      'Demo mode: all children and results are fictional.';

  @override
  String get realModeBanner =>
      'Real class mode: legal review is pending until a reviewer is recorded.';

  @override
  String get realModeBannerApproved => 'Real class mode';

  @override
  String get switchToRealMode => 'Enable Real class mode';

  @override
  String get switchToDemoMode => 'Switch to Demo class';

  @override
  String get legalReviewPending => 'Legal review pending: Designed for DPDP';

  @override
  String get resetDemoClass => 'Reset demo class';

  @override
  String get privacyChecklistTitle => 'Privacy checklist';

  @override
  String get privacyChecklistSubtitle =>
      'Before enabling Real class mode, confirm each point:';

  @override
  String get privacyChecklist1 =>
      'Parental consent will be marked for every child before any check';

  @override
  String get privacyChecklist2 => 'The phone has a screen lock';

  @override
  String get privacyChecklist4 =>
      'The school\'s legal and data-protection review for children\'s data is understood to be pending or done';

  @override
  String get screenPinningTip =>
      'Tip: turn on Android screen pinning so the child cannot leave the app.';

  @override
  String passageLabel(Object title) {
    return 'Passage: $title';
  }

  @override
  String passageWordCountAndLevel(Object level, Object words) {
    return 'Word count: $words words · Level: $level';
  }

  @override
  String consentRequiredBeforeCheck(Object name) {
    return 'Consent must be recorded for $name before starting.';
  }

  @override
  String get questionsSubtitle =>
      'Ask each question aloud. Accept answers in the child\'s own words and language.';

  @override
  String expectedAnswerPrefix(Object answer) {
    return 'Answers like: $answer';
  }

  @override
  String get answerCorrect => 'Correct';

  @override
  String get answerPartly => 'Partly';

  @override
  String get answerNotCorrect => 'Not correct';

  @override
  String get answerNoAnswer => 'No answer';

  @override
  String get answerNotAsked => 'Not asked';

  @override
  String get questionTypeFact => 'Fact from the text';

  @override
  String get questionTypeWhyHow => 'Why / How';

  @override
  String get questionTypeMainIdea => 'Main idea';

  @override
  String get questionTypeWordMeaning => 'Word meaning';

  @override
  String get questionTypeCauseEffect => 'Cause and effect';

  @override
  String get incorrectPasscode => 'Incorrect passcode';

  @override
  String get scrollDownToReadMore => 'Scroll down to read more';

  @override
  String get wordCheckTitle => 'Word check';

  @override
  String get wordCheckSubtitle => 'Look, listen, and choose the correct option';

  @override
  String get playCue => 'Play cue';

  @override
  String get notSureButton => 'Not sure';

  @override
  String wordCheckLevel(int level) {
    return 'Level $level';
  }

  @override
  String get writingPositionItemTitle =>
      'Which one sits correctly on the line?';

  @override
  String get spellingItemTitle => 'Pick the correct spelling';

  @override
  String get soundMatchItemTitle => 'Which one matches the sound you heard?';

  @override
  String get fillBlankItemTitle => 'Choose the word that fits best';

  @override
  String get oddOneOutItemTitle => 'Which one does not belong?';

  @override
  String get meaningInferenceItemTitle => 'What does this mean in the story?';

  @override
  String get sentenceMatchItemTitle => 'Which sentence matches the picture?';

  @override
  String get eventSequenceItemTitle => 'What happened first?';

  @override
  String levelPromotedMessage(int level) {
    return 'Level $level completed! Moving up.';
  }

  @override
  String itemWordTag(int index) {
    return '$index. Word';
  }

  @override
  String itemSentenceTag(int index) {
    return '$index. Sentence';
  }

  @override
  String get writtenCorrectly => 'Written correctly';

  @override
  String get notCorrect => 'Not correct';

  @override
  String givePhoneToTitle(String name) {
    return 'Give the phone to $name.';
  }

  @override
  String givePhoneToSubtitle(String name) {
    return 'Teacher screens stay locked while $name uses the phone. To come back, tap Teacher and enter your passcode.';
  }

  @override
  String get originalPassageReviewNote =>
      'Original Samajh passage, awaiting teacher review';

  @override
  String get roomTooNoisyWarning =>
      'Too noisy. Move somewhere quieter, or continue: the result will be marked low confidence.';

  @override
  String get roomQuietNotice => 'Quiet room. Good for recording.';

  @override
  String get notEnoughEvidenceTitle =>
      'Not enough evidence: no reading could be heard or marked.';

  @override
  String get lowConfidenceExplanation =>
      'Low confidence: many words were unclear or the room was noisy. Check again before deciding.';

  @override
  String get readingSection => 'Reading';

  @override
  String get understandingSection => 'Understanding';

  @override
  String get writingDictationSection => 'Writing (dictation)';

  @override
  String accuracyPercent(int percent) {
    return 'Accuracy $percent%';
  }

  @override
  String correctWordsPerMinute(int wpm) {
    return '$wpm correct words per minute';
  }

  @override
  String readingBreakdown(int skipped, int misread, int selfCorrected) {
    return '$skipped skipped · $misread read differently · $selfCorrected corrected self';
  }

  @override
  String flsBenchmarkAbove(Object grade) {
    return 'FLS 2022, Class $grade benchmark: above the minimum level';
  }

  @override
  String flsBenchmarkMeets(Object grade) {
    return 'FLS 2022, Class $grade benchmark: meets the minimum level';
  }

  @override
  String flsBenchmarkBelow(Object grade) {
    return 'FLS 2022, Class $grade benchmark: below the minimum level';
  }

  @override
  String get nipunReached =>
      'UP NIPUN H306: at least 60 words per minute: reached';

  @override
  String get nipunNotReached =>
      'UP NIPUN H306: at least 60 words per minute: not reached';

  @override
  String get accuracyGuideNote =>
      'The 90% accuracy guide is a Samajh provisional threshold, not an official standard.';

  @override
  String storyRetoldScore(int ticked, int total) {
    return 'Story retold: $ticked of $total';
  }

  @override
  String dictationScoreSummary(int correct, int total) {
    return '$correct of $total words written correctly';
  }

  @override
  String get dictationSkippedSummary => 'Dictation skipped';

  @override
  String get profileTitle => 'Teacher Profile';

  @override
  String get teacherNameLabel => 'Teacher Name';

  @override
  String get teacherNameHint => 'e.g., Sunita Sharma';

  @override
  String get schoolNameLabel => 'School Name (optional)';

  @override
  String get schoolNameHint => 'e.g., Primary School Rampur';

  @override
  String get preferredLanguageLabel => 'Preferred App Language';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get changePasscode => 'Change passcode';

  @override
  String get changeLanguage => 'Change app language';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get classesITeach => 'Classes I teach';

  @override
  String get addClassButton => 'Add class';

  @override
  String studentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count students',
      one: '1 student',
      zero: 'No students',
    );
    return '$_temp0';
  }

  @override
  String get noPendingReviews => 'No checks waiting for review';

  @override
  String get noRechecksDue => 'No rechecks due';

  @override
  String get startCheckShortcuts => 'Start a check';

  @override
  String get switchClass => 'Switch class';

  @override
  String activeClassChip(String name) {
    return 'Active: $name';
  }

  @override
  String get shareAction => 'Share';

  @override
  String get printAction => 'Print';

  @override
  String get shareWarningNote =>
      'Shared files leave this phone. Share only via secure channels.';

  @override
  String get parentReportApprovalPrompt =>
      'I approve sharing this report with the parent';

  @override
  String get parentReportApprovalRequired =>
      'Teacher approval required before printing or sharing parent reports.';

  @override
  String unmarkedWordsCounter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count words not marked yet',
      one: '1 word not marked yet',
    );
    return '$_temp0';
  }

  @override
  String get markRemainingCorrect => 'Mark remaining as correct';

  @override
  String get confirmMarkRemainingTitle => 'Mark Remaining as Correct?';

  @override
  String get confirmMarkRemainingBody =>
      'All words up to the last-read word that have not been marked will be marked as correct.';

  @override
  String get unmarkedWordsWarning =>
      'Please mark all words up to the last read word, or tap \'Mark remaining as correct\'.';

  @override
  String get audioConsentWithdrawnMessage =>
      'Audio recording consent has been withdrawn. Checks cannot record audio until enabled in Settings > Privacy.';

  @override
  String get audioConsentTitle => 'Microphone & Audio Recording';

  @override
  String get audioConsentDesc =>
      'Microphone is used to record a child\'s reading for teacher review. The recording is encrypted and deleted once marked.';

  @override
  String get audioConsentStatusGranted => 'Granted';

  @override
  String get audioConsentStatusWithdrawn => 'Withdrawn';

  @override
  String get withdrawAudioConsent => 'Withdraw audio consent';

  @override
  String get grantAudioConsent => 'Allow audio recording';

  @override
  String get storageConsentTitle => 'Local Encrypted Storage Consent';

  @override
  String get storageConsentDesc =>
      'Children\'s data is kept only on this device, encrypted, until school approves.';

  @override
  String get storageConsentGiven => 'Approved';

  @override
  String get markChildStoppedHere =>
      'Child stopped here (mark rest not reached)';

  @override
  String get questionsLevelHint =>
      'Ask Level 1 first. The next level opens only when the child gets at least half of this level right.';

  @override
  String questionLevelLabel(int level) {
    return 'Level $level';
  }

  @override
  String questionsStoppedAt(int level) {
    return 'Questions stop at Level $level. Practise this level before asking harder questions.';
  }

  @override
  String questionsNextLocked(int level) {
    return 'Level $level opens after this level is passed.';
  }

  @override
  String questionTimeSeconds(int seconds) {
    return '$seconds s';
  }

  @override
  String get questionMarkFirst => 'Mark every open question to see the result.';

  @override
  String get childFeltLabel => 'Child\'s own feeling:';

  @override
  String get typingSection => 'Typing check (child typed the words)';

  @override
  String typingScoreLine(int correct, int total) {
    return '$correct of $total words typed correctly';
  }

  @override
  String get typingSkipped => 'Typing check not done.';

  @override
  String typedWordRow(String target, String typed) {
    return '$target: typed $typed';
  }

  @override
  String typedWordNotSure(String target) {
    return '$target: not sure';
  }

  @override
  String marksLine(String earned, String possible) {
    return 'Marks: $earned of $possible';
  }

  @override
  String highestLevelPassed(int level) {
    return 'Highest level passed: Level $level';
  }

  @override
  String get levelOneNotPassed =>
      'Level 1 not passed yet. Practise Level 1 first.';

  @override
  String get weightedMarkingNote =>
      'Higher levels carry more marks. Answers slower than the expected time earn fewer marks. These weights are provisional.';

  @override
  String get selfRatingSection => 'Child\'s own rating and the result';

  @override
  String selfRatingCounts(int up, int down) {
    return '$up thumbs up, $down thumbs down';
  }

  @override
  String selfRatingUpButWrong(int count) {
    return 'Felt good but the answer was wrong: $count';
  }

  @override
  String selfRatingDownButCorrect(int count) {
    return 'Felt unsure but the answer was right: $count';
  }

  @override
  String selfRatingMatch(int percent) {
    return 'The child\'s feeling matched the result $percent% of the time.';
  }

  @override
  String get selfRatingNone => 'The child did not give any ratings.';

  @override
  String get readingFeltGood => 'At the end of the check: thumbs up';

  @override
  String get readingFeltHard => 'At the end of the check: thumbs down';

  @override
  String get selfRatingNote =>
      'Ratings show how the child feels. They are not marks.';

  @override
  String greetingMorning(String name) {
    return 'Good morning, $name';
  }

  @override
  String greetingAfternoon(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String greetingEvening(String name) {
    return 'Good evening, $name';
  }

  @override
  String todayClassesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count classes',
      one: '1 class',
    );
    return '$_temp0 today';
  }

  @override
  String get supportGroupsTitle => 'Support groups';

  @override
  String get supportGroupsSubtitle =>
      'Who needs which kind of help, from the latest checks';

  @override
  String get viewClassLink => 'View class';

  @override
  String get groupDecodingShort => 'Reading words';

  @override
  String get groupComprehensionShort => 'Understanding';

  @override
  String get groupBothShort => 'Both';

  @override
  String classCheckedRing(int checked, int total) {
    return '$checked of $total';
  }

  @override
  String get profileEditTitle => 'Your profile';

  @override
  String get profileSectionAbout => 'About you';

  @override
  String get profileFullName => 'Full name';

  @override
  String get profileFullNameRequired => 'Please enter your name';

  @override
  String get profileDisplayName => 'What children call you';

  @override
  String get profileDisplayNameHint => 'For example: Sunita ji';

  @override
  String get profileRole => 'Your role';

  @override
  String get roleTeacher => 'Teacher';

  @override
  String get roleHeadTeacher => 'Head teacher';

  @override
  String get roleParaTeacher => 'Shiksha mitra / para teacher';

  @override
  String get roleOther => 'Other';

  @override
  String get profileSectionSchool => 'Your school';

  @override
  String get profileSchoolName => 'School name';

  @override
  String get profileUdise => 'UDISE code';

  @override
  String get profileUdiseError => 'A UDISE code has 11 digits';

  @override
  String get profileBlock => 'Block';

  @override
  String get profileDistrict => 'District';

  @override
  String get profileState => 'State';

  @override
  String get stateRajasthan => 'Rajasthan';

  @override
  String get stateUttarPradesh => 'Uttar Pradesh';

  @override
  String get stateOther => 'Other';

  @override
  String get profileYears => 'Years of teaching';

  @override
  String get profileYearsError => 'Enter a number from 0 to 60';

  @override
  String get profileSectionContact => 'Contact (optional)';

  @override
  String get profilePhone => 'Mobile number';

  @override
  String get profilePhoneError => 'Enter a 10-digit mobile number';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileEmailError => 'Enter an email like name@example.com';

  @override
  String get profileStaysOnPhone =>
      'Your profile is saved only on this phone. It is not sent anywhere.';

  @override
  String get profileSaveButton => 'Save profile';

  @override
  String get profileDetailsTitle => 'Details';

  @override
  String get profileNotAdded => 'Not added';

  @override
  String profileYearsValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get profileCompleteCta => 'Complete your profile';

  @override
  String todayOfTotalChecked(int total) {
    return 'of $total checked';
  }

  @override
  String todayNextChild(String name) {
    return 'Next: $name';
  }

  @override
  String get todayEveryoneChecked => 'Everyone in this class is checked';

  @override
  String get todayNotCheckedYet => 'Not grouped yet';

  @override
  String get selfRatingOverallUpWell => 'Felt good, and the check went well.';

  @override
  String get selfRatingOverallUpHard =>
      'Felt good, but parts of the check were hard. The child may not notice their own mistakes yet.';

  @override
  String get selfRatingOverallDownWell =>
      'Felt unsure, but did well. The child may need more confidence.';

  @override
  String get selfRatingOverallDownHard =>
      'Felt it was hard, and it was. The child knows where they struggle.';

  @override
  String get autoMarkListening =>
      'Listening to the recording and marking each word…';

  @override
  String get autoMarkAllHeard =>
      'The app heard every word read correctly. Play the recording if you want to check.';

  @override
  String autoMarkDone(int wrong, int check) {
    return 'The app marked the reading. It thinks $wrong words were read wrong. Listen to the $check words with an orange ring and change any mark you hear differently.';
  }

  @override
  String get autoMarkFailed =>
      'The app could not mark this recording. Please mark by listening.';

  @override
  String get autoMarkUnsupported =>
      'Automatic marking needs the Android app on a phone. Please mark by listening.';

  @override
  String get autoMarkNoRecording =>
      'There is no recording, so the app could not mark the reading. Please mark as the child reads.';

  @override
  String get autoMarkNote =>
      'Marks come from an offline speech model on this phone. It can be wrong, especially with young voices, so your check decides.';

  @override
  String get autoMarkNothingHeard =>
      'The app did not hear the passage in the recording, so every word is marked not reached. Play the recording and mark by listening.';

  @override
  String autoMarkStopped(int count) {
    return 'The app heard the first $count words read correctly, then the reading stopped. Play the recording if you want to check.';
  }

  @override
  String get lowConfidenceTitle => 'Result with low confidence';

  @override
  String get lowConfidenceNote =>
      'The room was noisy or the reading was very short, so reading speed is left out. The rest of the result comes from the child\'s answers.';
}
