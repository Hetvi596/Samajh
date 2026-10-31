import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Samajh'**
  String get appTitle;

  /// No description provided for @appTitleDevanagari.
  ///
  /// In en, this message translates to:
  /// **'Samajh समझ'**
  String get appTitleDevanagari;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reading, Understanding & Writing Assessment'**
  String get appSubtitle;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'See what every child understands'**
  String get welcomeHeadline;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check a child\'s reading, understanding, and writing in 4 minutes. Works without internet.'**
  String get welcomeSubtitle;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिंदी (Hindi)'**
  String get hindi;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'मराठी (Marathi)'**
  String get marathi;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @getStartedButton.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStartedButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @yesButton.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButton;

  /// No description provided for @notNowButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNowButton;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacyTitle;

  /// No description provided for @privacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your classroom data stays on this device'**
  String get privacySubtitle;

  /// No description provided for @privacyPoint1Title.
  ///
  /// In en, this message translates to:
  /// **'Everything is stored on this phone, encrypted'**
  String get privacyPoint1Title;

  /// No description provided for @privacyPoint1Desc.
  ///
  /// In en, this message translates to:
  /// **'All data is encrypted locally on this device. Optional cloud sync is off by default, and no data is shared without teacher sign-in.'**
  String get privacyPoint1Desc;

  /// No description provided for @privacyPoint2Title.
  ///
  /// In en, this message translates to:
  /// **'Recordings deleted after checking'**
  String get privacyPoint2Title;

  /// No description provided for @privacyPoint2Desc.
  ///
  /// In en, this message translates to:
  /// **'Reading recordings never leave the phone and are deleted after checking.'**
  String get privacyPoint2Desc;

  /// No description provided for @privacyPoint3Title.
  ///
  /// In en, this message translates to:
  /// **'Minimal information needed'**
  String get privacyPoint3Title;

  /// No description provided for @privacyPoint3Desc.
  ///
  /// In en, this message translates to:
  /// **'Only a first name and initial are needed (no dates of birth, addresses or ID numbers).'**
  String get privacyPoint3Desc;

  /// No description provided for @privacyPoint4Title.
  ///
  /// In en, this message translates to:
  /// **'Your classroom, 100% offline'**
  String get privacyPoint4Title;

  /// No description provided for @privacyPoint4Desc.
  ///
  /// In en, this message translates to:
  /// **'Assess children with full data privacy. Zero trackers, zero ads, and offline-first design with sync off by default.'**
  String get privacyPoint4Desc;

  /// No description provided for @privacyAccept.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get privacyAccept;

  /// No description provided for @privacyConsentStorage.
  ///
  /// In en, this message translates to:
  /// **'I understand this app keeps children\'s data only on this phone, encrypted, and I will not enter real children\'s data until my school approves.'**
  String get privacyConsentStorage;

  /// No description provided for @privacyConsentAudio.
  ///
  /// In en, this message translates to:
  /// **'Allow Samajh to use the microphone to record a child\'s reading. The recording is stored encrypted on this phone and deleted after I mark it.'**
  String get privacyConsentAudio;

  /// No description provided for @passcodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Teacher Passcode'**
  String get passcodeTitle;

  /// No description provided for @passcodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You will use this to open Samajh and to leave the children\'s screens'**
  String get passcodeSubtitle;

  /// No description provided for @enterPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit passcode'**
  String get enterPasscode;

  /// No description provided for @confirmPasscode.
  ///
  /// In en, this message translates to:
  /// **'Enter it again'**
  String get confirmPasscode;

  /// No description provided for @passcodesDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passcodes do not match. Please try again.'**
  String get passcodesDoNotMatch;

  /// No description provided for @passcodeIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect passcode. Please try again.'**
  String get passcodeIncorrect;

  /// No description provided for @passcodeLockedUntil.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Try again in {seconds} seconds.'**
  String passcodeLockedUntil(Object seconds);

  /// No description provided for @enterPasscodeToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Enter passcode to unlock'**
  String get enterPasscodeToUnlock;

  /// No description provided for @enterPasscodeToExitStudent.
  ///
  /// In en, this message translates to:
  /// **'Enter your passcode to leave Student Mode'**
  String get enterPasscodeToExitStudent;

  /// No description provided for @useFingerprintPrompt.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint too?'**
  String get useFingerprintPrompt;

  /// No description provided for @classSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Up Your Class'**
  String get classSetupTitle;

  /// No description provided for @classSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure your classroom details to match curriculum benchmarks'**
  String get classSetupSubtitle;

  /// No description provided for @classNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Class / School Name'**
  String get classNameLabel;

  /// No description provided for @classNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Class 3B or Primary School'**
  String get classNameHint;

  /// No description provided for @gradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Grade / Class'**
  String get gradeLabel;

  /// No description provided for @grade1.
  ///
  /// In en, this message translates to:
  /// **'Class 1'**
  String get grade1;

  /// No description provided for @grade2.
  ///
  /// In en, this message translates to:
  /// **'Class 2'**
  String get grade2;

  /// No description provided for @grade3.
  ///
  /// In en, this message translates to:
  /// **'Class 3'**
  String get grade3;

  /// No description provided for @grade4.
  ///
  /// In en, this message translates to:
  /// **'Class 4'**
  String get grade4;

  /// No description provided for @grade5.
  ///
  /// In en, this message translates to:
  /// **'Class 5'**
  String get grade5;

  /// No description provided for @sectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Section'**
  String get sectionLabel;

  /// No description provided for @boardLabel.
  ///
  /// In en, this message translates to:
  /// **'Board / Curriculum'**
  String get boardLabel;

  /// No description provided for @curriculumLabel.
  ///
  /// In en, this message translates to:
  /// **'Curriculum'**
  String get curriculumLabel;

  /// No description provided for @curriculumNcert.
  ///
  /// In en, this message translates to:
  /// **'NCERT / CBSE'**
  String get curriculumNcert;

  /// No description provided for @curriculumUp.
  ///
  /// In en, this message translates to:
  /// **'Uttar Pradesh Basic Shiksha'**
  String get curriculumUp;

  /// No description provided for @curriculumBihar.
  ///
  /// In en, this message translates to:
  /// **'Bihar SCERT / BSEB'**
  String get curriculumBihar;

  /// No description provided for @curriculumRajasthan.
  ///
  /// In en, this message translates to:
  /// **'Rajasthan RSCERT'**
  String get curriculumRajasthan;

  /// No description provided for @curriculumMp.
  ///
  /// In en, this message translates to:
  /// **'Madhya Pradesh Rajya Shiksha Kendra'**
  String get curriculumMp;

  /// No description provided for @curriculumMaharashtra.
  ///
  /// In en, this message translates to:
  /// **'Maharashtra State Board (Balbharati)'**
  String get curriculumMaharashtra;

  /// No description provided for @curriculumIcse.
  ///
  /// In en, this message translates to:
  /// **'ICSE / CISCE'**
  String get curriculumIcse;

  /// No description provided for @curriculumSchoolOwn.
  ///
  /// In en, this message translates to:
  /// **'School\'s Own Curriculum'**
  String get curriculumSchoolOwn;

  /// No description provided for @schoolLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language of the check'**
  String get schoolLanguageLabel;

  /// No description provided for @mediumOfInstructionLabel.
  ///
  /// In en, this message translates to:
  /// **'Medium of instruction'**
  String get mediumOfInstructionLabel;

  /// No description provided for @createClassButton.
  ///
  /// In en, this message translates to:
  /// **'Create Class & Continue'**
  String get createClassButton;

  /// No description provided for @classProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Class Profile'**
  String get classProfileTitle;

  /// No description provided for @noChildrenInClassYet.
  ///
  /// In en, this message translates to:
  /// **'No children in this class yet'**
  String get noChildrenInClassYet;

  /// No description provided for @addChildPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add students to begin checking reading and comprehension'**
  String get addChildPrompt;

  /// No description provided for @classSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Class settings'**
  String get classSettingsTitle;

  /// No description provided for @saveClassSettings.
  ///
  /// In en, this message translates to:
  /// **'Save class settings'**
  String get saveClassSettings;

  /// No description provided for @classSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Class settings saved'**
  String get classSettingsSaved;

  /// No description provided for @classMilestonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Class {grade} milestones'**
  String classMilestonesTitle(Object grade);

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabClass.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get tabClass;

  /// No description provided for @tabPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get tabPractice;

  /// No description provided for @tabReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get tabReports;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @todayGreeting.
  ///
  /// In en, this message translates to:
  /// **'Namaste, Teacher'**
  String get todayGreeting;

  /// No description provided for @checkNextChild.
  ///
  /// In en, this message translates to:
  /// **'Check next child'**
  String get checkNextChild;

  /// No description provided for @checkNextChildNamed.
  ///
  /// In en, this message translates to:
  /// **'Check next child: {name}'**
  String checkNextChildNamed(Object name);

  /// No description provided for @allChildrenChecked.
  ///
  /// In en, this message translates to:
  /// **'All children checked'**
  String get allChildrenChecked;

  /// No description provided for @addChildrenButton.
  ///
  /// In en, this message translates to:
  /// **'Add children'**
  String get addChildrenButton;

  /// No description provided for @checkedProgress.
  ///
  /// In en, this message translates to:
  /// **'{checked} of {total} children checked'**
  String checkedProgress(Object checked, Object total);

  /// No description provided for @suggestedToday.
  ///
  /// In en, this message translates to:
  /// **'Suggested today: {count} children'**
  String suggestedToday(Object count);

  /// No description provided for @todoTitle.
  ///
  /// In en, this message translates to:
  /// **'To-do List'**
  String get todoTitle;

  /// No description provided for @todoWaitingReview.
  ///
  /// In en, this message translates to:
  /// **'Waiting for review'**
  String get todoWaitingReview;

  /// No description provided for @todoRechecksDue.
  ///
  /// In en, this message translates to:
  /// **'Rechecks due'**
  String get todoRechecksDue;

  /// No description provided for @todoSheetsReady.
  ///
  /// In en, this message translates to:
  /// **'Practice sheets ready'**
  String get todoSheetsReady;

  /// No description provided for @worksOfflineReassurance.
  ///
  /// In en, this message translates to:
  /// **'Works offline'**
  String get worksOfflineReassurance;

  /// No description provided for @backupYourClass.
  ///
  /// In en, this message translates to:
  /// **'Back up your class'**
  String get backupYourClass;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All · {count}'**
  String filterAll(Object count);

  /// No description provided for @filterNotGrouped.
  ///
  /// In en, this message translates to:
  /// **'Not grouped yet · {count}'**
  String filterNotGrouped(Object count);

  /// No description provided for @groupOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get groupOnTrack;

  /// No description provided for @groupNeedsReading.
  ///
  /// In en, this message translates to:
  /// **'Understands, needs help reading words'**
  String get groupNeedsReading;

  /// No description provided for @groupNeedsUnderstanding.
  ///
  /// In en, this message translates to:
  /// **'Reads words, needs help understanding'**
  String get groupNeedsUnderstanding;

  /// No description provided for @groupNeedsBoth.
  ///
  /// In en, this message translates to:
  /// **'Needs help with both'**
  String get groupNeedsBoth;

  /// No description provided for @groupNotGroupedYet.
  ///
  /// In en, this message translates to:
  /// **'Not grouped yet'**
  String get groupNotGroupedYet;

  /// No description provided for @groupHelperText.
  ///
  /// In en, this message translates to:
  /// **'Groups are suggestions from the latest check. You can move any child.'**
  String get groupHelperText;

  /// No description provided for @statusChecked.
  ///
  /// In en, this message translates to:
  /// **'Checked'**
  String get statusChecked;

  /// No description provided for @statusNotChecked.
  ///
  /// In en, this message translates to:
  /// **'Not checked yet'**
  String get statusNotChecked;

  /// No description provided for @statusCheckedToday.
  ///
  /// In en, this message translates to:
  /// **'Checked today'**
  String get statusCheckedToday;

  /// No description provided for @statusCheckedOn.
  ///
  /// In en, this message translates to:
  /// **'Checked on {date}'**
  String statusCheckedOn(Object date);

  /// No description provided for @statusWaitingReview.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your review'**
  String get statusWaitingReview;

  /// No description provided for @statusConsentMissing.
  ///
  /// In en, this message translates to:
  /// **'Consent pending'**
  String get statusConsentMissing;

  /// No description provided for @startCheck.
  ///
  /// In en, this message translates to:
  /// **'Start a check'**
  String get startCheck;

  /// No description provided for @resumeCheck.
  ///
  /// In en, this message translates to:
  /// **'Resume check'**
  String get resumeCheck;

  /// No description provided for @childProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Child Profile'**
  String get childProfileTitle;

  /// No description provided for @consentStatus.
  ///
  /// In en, this message translates to:
  /// **'Parental Consent'**
  String get consentStatus;

  /// No description provided for @consentGiven.
  ///
  /// In en, this message translates to:
  /// **'Consent Given'**
  String get consentGiven;

  /// No description provided for @consentWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Consent Withdrawn'**
  String get consentWithdrawn;

  /// No description provided for @markConsent.
  ///
  /// In en, this message translates to:
  /// **'Record Parental Consent'**
  String get markConsent;

  /// No description provided for @withdrawConsent.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Consent'**
  String get withdrawConsent;

  /// No description provided for @moveToAnotherGroup.
  ///
  /// In en, this message translates to:
  /// **'Move to another group'**
  String get moveToAnotherGroup;

  /// No description provided for @deleteChild.
  ///
  /// In en, this message translates to:
  /// **'Delete this child'**
  String get deleteChild;

  /// No description provided for @addChild.
  ///
  /// In en, this message translates to:
  /// **'Add child'**
  String get addChild;

  /// No description provided for @importCsv.
  ///
  /// In en, this message translates to:
  /// **'Import from CSV'**
  String get importCsv;

  /// No description provided for @beforeHandingOverTitle.
  ///
  /// In en, this message translates to:
  /// **'Give the phone to {name}'**
  String beforeHandingOverTitle(Object name);

  /// No description provided for @beforeHandingOverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Teacher screens stay locked while {name} uses the phone. To come back, tap Teacher and enter your passcode.'**
  String beforeHandingOverSubtitle(Object name);

  /// No description provided for @originalPassageTag.
  ///
  /// In en, this message translates to:
  /// **'Original Samajh passage, awaiting teacher review'**
  String get originalPassageTag;

  /// No description provided for @checkTheRoom.
  ///
  /// In en, this message translates to:
  /// **'Check the room'**
  String get checkTheRoom;

  /// No description provided for @listenFor3Seconds.
  ///
  /// In en, this message translates to:
  /// **'Listen for 3 seconds'**
  String get listenFor3Seconds;

  /// No description provided for @startStudentMode.
  ///
  /// In en, this message translates to:
  /// **'Start Student Mode'**
  String get startStudentMode;

  /// No description provided for @noiseCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Checking classroom noise...'**
  String get noiseCheckTitle;

  /// No description provided for @noiseLevelGood.
  ///
  /// In en, this message translates to:
  /// **'Noise level: Good for check'**
  String get noiseLevelGood;

  /// No description provided for @noiseLevelHigh.
  ///
  /// In en, this message translates to:
  /// **'It is noisy here. Move somewhere quieter if you can.'**
  String get noiseLevelHigh;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @continueAnyway.
  ///
  /// In en, this message translates to:
  /// **'Continue anyway'**
  String get continueAnyway;

  /// No description provided for @markWithoutRecording.
  ///
  /// In en, this message translates to:
  /// **'Mark without recording'**
  String get markWithoutRecording;

  /// No description provided for @handoverInstructions.
  ///
  /// In en, this message translates to:
  /// **'Teacher screens stay locked while using the phone.'**
  String get handoverInstructions;

  /// No description provided for @kiranGreeting.
  ///
  /// In en, this message translates to:
  /// **'नमस्ते! मैं किरण हूँ।'**
  String get kiranGreeting;

  /// No description provided for @kiranInstruction.
  ///
  /// In en, this message translates to:
  /// **'यह कहानी ज़ोर से पढ़ो। आराम से पढ़ना।'**
  String get kiranInstruction;

  /// No description provided for @studentRecordingIndicator.
  ///
  /// In en, this message translates to:
  /// **'रिकॉर्ड हो रहा है'**
  String get studentRecordingIndicator;

  /// No description provided for @studentDoneReading.
  ///
  /// In en, this message translates to:
  /// **'मैंने पढ़ लिया'**
  String get studentDoneReading;

  /// No description provided for @shabaashTitle.
  ///
  /// In en, this message translates to:
  /// **'शाबाश!'**
  String get shabaashTitle;

  /// No description provided for @shabaashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'अब यह फोन शिक्षक जी को वापस दे दीजिए।'**
  String get shabaashSubtitle;

  /// No description provided for @teacherUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'शिक्षक'**
  String get teacherUnlockButton;

  /// No description provided for @markingTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark the reading'**
  String get markingTitle;

  /// No description provided for @playRecording.
  ///
  /// In en, this message translates to:
  /// **'Play Recording'**
  String get playRecording;

  /// No description provided for @pauseRecording.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseRecording;

  /// No description provided for @markingGuide.
  ///
  /// In en, this message translates to:
  /// **'The recording is deleted when you save.'**
  String get markingGuide;

  /// No description provided for @markCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get markCorrect;

  /// No description provided for @markReadAsAnotherWord.
  ///
  /// In en, this message translates to:
  /// **'Read as another word'**
  String get markReadAsAnotherWord;

  /// No description provided for @markSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get markSkipped;

  /// No description provided for @markSelfCorrected.
  ///
  /// In en, this message translates to:
  /// **'Corrected self'**
  String get markSelfCorrected;

  /// No description provided for @markRepeated.
  ///
  /// In en, this message translates to:
  /// **'Repeated'**
  String get markRepeated;

  /// No description provided for @markNotSure.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get markNotSure;

  /// No description provided for @markNotReached.
  ///
  /// In en, this message translates to:
  /// **'Not reached'**
  String get markNotReached;

  /// No description provided for @liveMarkingCount.
  ///
  /// In en, this message translates to:
  /// **'{errors} errors · {notSure} not sure · {wordsRead} words read'**
  String liveMarkingCount(Object errors, Object notSure, Object wordsRead);

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save and continue'**
  String get saveAndContinue;

  /// No description provided for @micPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Audio Recording Permission'**
  String get micPermissionTitle;

  /// No description provided for @micPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Microphone access is needed to record reading so you can check pronunciation. Audio is encrypted locally and deleted on save.'**
  String get micPermissionDesc;

  /// No description provided for @grantMicPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow Microphone Access'**
  String get grantMicPermission;

  /// No description provided for @micReadyBadge.
  ///
  /// In en, this message translates to:
  /// **'Microphone Ready (Encrypted local)'**
  String get micReadyBadge;

  /// No description provided for @pronunciationCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation Check'**
  String get pronunciationCheckTitle;

  /// No description provided for @pronunciationCheckGuide.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation Guide'**
  String get pronunciationCheckGuide;

  /// No description provided for @phoneticBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Syllable and Phonetic Breakdown'**
  String get phoneticBreakdownTitle;

  /// No description provided for @markPronouncedCorrect.
  ///
  /// In en, this message translates to:
  /// **'Pronounced correctly'**
  String get markPronouncedCorrect;

  /// No description provided for @markMispronounced.
  ///
  /// In en, this message translates to:
  /// **'Mispronounced / Read differently'**
  String get markMispronounced;

  /// No description provided for @acceptRegionalPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Accept Regional Accent'**
  String get acceptRegionalPronunciation;

  /// No description provided for @regionalAccentBadge.
  ///
  /// In en, this message translates to:
  /// **'Regional'**
  String get regionalAccentBadge;

  /// No description provided for @regionalAccentExplanation.
  ///
  /// In en, this message translates to:
  /// **'Home dialect accents (e.g. s/sh, v/b, d/r) are accepted without error penalty.'**
  String get regionalAccentExplanation;

  /// No description provided for @commonRegionalVariants.
  ///
  /// In en, this message translates to:
  /// **'Common regional pronunciation: {variants}'**
  String commonRegionalVariants(Object variants);

  /// No description provided for @standardPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Standard pronunciation: {guide}'**
  String standardPronunciation(Object guide);

  /// No description provided for @livePronunciationAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation: {percent}%'**
  String livePronunciationAccuracy(Object percent);

  /// No description provided for @inspectWord.
  ///
  /// In en, this message translates to:
  /// **'Inspect word'**
  String get inspectWord;

  /// No description provided for @nextWord.
  ///
  /// In en, this message translates to:
  /// **'Next word'**
  String get nextWord;

  /// No description provided for @prevWord.
  ///
  /// In en, this message translates to:
  /// **'Previous word'**
  String get prevWord;

  /// No description provided for @errorKindConsonant.
  ///
  /// In en, this message translates to:
  /// **'Consonant error'**
  String get errorKindConsonant;

  /// No description provided for @errorKindShortMatra.
  ///
  /// In en, this message translates to:
  /// **'Short matra error'**
  String get errorKindShortMatra;

  /// No description provided for @errorKindLongMatra.
  ///
  /// In en, this message translates to:
  /// **'Long matra error'**
  String get errorKindLongMatra;

  /// No description provided for @errorKindConjunct.
  ///
  /// In en, this message translates to:
  /// **'Conjunct error'**
  String get errorKindConjunct;

  /// No description provided for @errorKindNukta.
  ///
  /// In en, this message translates to:
  /// **'Nukta error'**
  String get errorKindNukta;

  /// No description provided for @errorKindBindu.
  ///
  /// In en, this message translates to:
  /// **'Bindu / Anusvara error'**
  String get errorKindBindu;

  /// No description provided for @soundErrorType.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation error type'**
  String get soundErrorType;

  /// No description provided for @observedWordPrompt.
  ///
  /// In en, this message translates to:
  /// **'What did the child pronounce?'**
  String get observedWordPrompt;

  /// No description provided for @retellTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell me the story'**
  String get retellTitle;

  /// No description provided for @retellSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask the child to tell the story in their own words. Tick each point they mention, in any language.'**
  String get retellSubtitle;

  /// No description provided for @skipRetelling.
  ///
  /// In en, this message translates to:
  /// **'Skip retelling'**
  String get skipRetelling;

  /// No description provided for @continueToQuestions.
  ///
  /// In en, this message translates to:
  /// **'Continue to questions'**
  String get continueToQuestions;

  /// No description provided for @questionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questionsTitle;

  /// No description provided for @dictationTitle.
  ///
  /// In en, this message translates to:
  /// **'Dictation'**
  String get dictationTitle;

  /// No description provided for @dictationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each item is shown to the teacher with Written correctly and Not correct.'**
  String get dictationSubtitle;

  /// No description provided for @skipDictation.
  ///
  /// In en, this message translates to:
  /// **'Skip dictation'**
  String get skipDictation;

  /// No description provided for @saveAndSeeResult.
  ///
  /// In en, this message translates to:
  /// **'Save and see result'**
  String get saveAndSeeResult;

  /// No description provided for @seeTheResult.
  ///
  /// In en, this message translates to:
  /// **'See the result'**
  String get seeTheResult;

  /// No description provided for @continueToDictation.
  ///
  /// In en, this message translates to:
  /// **'Continue to dictation'**
  String get continueToDictation;

  /// No description provided for @listeningCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Listening Check'**
  String get listeningCheckTitle;

  /// No description provided for @resultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Result in plain words'**
  String get resultsTitle;

  /// No description provided for @officialTarget.
  ///
  /// In en, this message translates to:
  /// **'Official Target ({source})'**
  String officialTarget(Object source);

  /// No description provided for @suggestedGroup.
  ///
  /// In en, this message translates to:
  /// **'Suggested Group'**
  String get suggestedGroup;

  /// No description provided for @readingSpeed.
  ///
  /// In en, this message translates to:
  /// **'Reading speed'**
  String get readingSpeed;

  /// No description provided for @readingAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Reading accuracy'**
  String get readingAccuracy;

  /// No description provided for @understandingScore.
  ///
  /// In en, this message translates to:
  /// **'Understanding'**
  String get understandingScore;

  /// No description provided for @writingScore.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get writingScore;

  /// No description provided for @wordsPerMinute.
  ///
  /// In en, this message translates to:
  /// **'{wpm} words per minute'**
  String wordsPerMinute(Object wpm);

  /// No description provided for @nextTeachingStep.
  ///
  /// In en, this message translates to:
  /// **'One next step'**
  String get nextTeachingStep;

  /// No description provided for @printPracticeSheet.
  ///
  /// In en, this message translates to:
  /// **'Print practice sheet'**
  String get printPracticeSheet;

  /// No description provided for @checkNextStudent.
  ///
  /// In en, this message translates to:
  /// **'Check next child'**
  String get checkNextStudent;

  /// No description provided for @notEnoughEvidence.
  ///
  /// In en, this message translates to:
  /// **'Not enough evidence: no reading could be heard or marked'**
  String get notEnoughEvidence;

  /// No description provided for @correctAMarking.
  ///
  /// In en, this message translates to:
  /// **'Something wrong? Correct a marking'**
  String get correctAMarking;

  /// No description provided for @samajhRubricProvisional.
  ///
  /// In en, this message translates to:
  /// **'Samajh rubric v0.1 (provisional)'**
  String get samajhRubricProvisional;

  /// No description provided for @backToClass.
  ///
  /// In en, this message translates to:
  /// **'Back to class'**
  String get backToClass;

  /// No description provided for @demoModeBanner.
  ///
  /// In en, this message translates to:
  /// **'Demo mode: all children and results are fictional.'**
  String get demoModeBanner;

  /// No description provided for @realModeBanner.
  ///
  /// In en, this message translates to:
  /// **'Real class mode: legal review is pending until a reviewer is recorded.'**
  String get realModeBanner;

  /// No description provided for @realModeBannerApproved.
  ///
  /// In en, this message translates to:
  /// **'Real class mode'**
  String get realModeBannerApproved;

  /// No description provided for @switchToRealMode.
  ///
  /// In en, this message translates to:
  /// **'Enable Real class mode'**
  String get switchToRealMode;

  /// No description provided for @switchToDemoMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Demo class'**
  String get switchToDemoMode;

  /// No description provided for @legalReviewPending.
  ///
  /// In en, this message translates to:
  /// **'Legal review pending: Designed for DPDP'**
  String get legalReviewPending;

  /// No description provided for @resetDemoClass.
  ///
  /// In en, this message translates to:
  /// **'Reset demo class'**
  String get resetDemoClass;

  /// No description provided for @privacyChecklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy checklist'**
  String get privacyChecklistTitle;

  /// No description provided for @privacyChecklistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Before enabling Real class mode, confirm each point:'**
  String get privacyChecklistSubtitle;

  /// No description provided for @privacyChecklist1.
  ///
  /// In en, this message translates to:
  /// **'Parental consent will be marked for every child before any check'**
  String get privacyChecklist1;

  /// No description provided for @privacyChecklist2.
  ///
  /// In en, this message translates to:
  /// **'The phone has a screen lock'**
  String get privacyChecklist2;

  /// No description provided for @privacyChecklist4.
  ///
  /// In en, this message translates to:
  /// **'The school\'s legal and data-protection review for children\'s data is understood to be pending or done'**
  String get privacyChecklist4;

  /// No description provided for @screenPinningTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: turn on Android screen pinning so the child cannot leave the app.'**
  String get screenPinningTip;

  /// No description provided for @passageLabel.
  ///
  /// In en, this message translates to:
  /// **'Passage: {title}'**
  String passageLabel(Object title);

  /// No description provided for @passageWordCountAndLevel.
  ///
  /// In en, this message translates to:
  /// **'Word count: {words} words · Level: {level}'**
  String passageWordCountAndLevel(Object level, Object words);

  /// No description provided for @consentRequiredBeforeCheck.
  ///
  /// In en, this message translates to:
  /// **'Consent must be recorded for {name} before starting.'**
  String consentRequiredBeforeCheck(Object name);

  /// No description provided for @questionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask each question aloud. Accept answers in the child\'s own words and language.'**
  String get questionsSubtitle;

  /// No description provided for @expectedAnswerPrefix.
  ///
  /// In en, this message translates to:
  /// **'Answers like: {answer}'**
  String expectedAnswerPrefix(Object answer);

  /// No description provided for @answerCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get answerCorrect;

  /// No description provided for @answerPartly.
  ///
  /// In en, this message translates to:
  /// **'Partly'**
  String get answerPartly;

  /// No description provided for @answerNotCorrect.
  ///
  /// In en, this message translates to:
  /// **'Not correct'**
  String get answerNotCorrect;

  /// No description provided for @answerNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'No answer'**
  String get answerNoAnswer;

  /// No description provided for @answerNotAsked.
  ///
  /// In en, this message translates to:
  /// **'Not asked'**
  String get answerNotAsked;

  /// No description provided for @questionTypeFact.
  ///
  /// In en, this message translates to:
  /// **'Fact from the text'**
  String get questionTypeFact;

  /// No description provided for @questionTypeWhyHow.
  ///
  /// In en, this message translates to:
  /// **'Why / How'**
  String get questionTypeWhyHow;

  /// No description provided for @questionTypeMainIdea.
  ///
  /// In en, this message translates to:
  /// **'Main idea'**
  String get questionTypeMainIdea;

  /// No description provided for @questionTypeWordMeaning.
  ///
  /// In en, this message translates to:
  /// **'Word meaning'**
  String get questionTypeWordMeaning;

  /// No description provided for @questionTypeCauseEffect.
  ///
  /// In en, this message translates to:
  /// **'Cause and effect'**
  String get questionTypeCauseEffect;

  /// No description provided for @incorrectPasscode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect passcode'**
  String get incorrectPasscode;

  /// No description provided for @scrollDownToReadMore.
  ///
  /// In en, this message translates to:
  /// **'Scroll down to read more'**
  String get scrollDownToReadMore;

  /// No description provided for @wordCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Word check'**
  String get wordCheckTitle;

  /// No description provided for @wordCheckSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Look, listen, and choose the correct option'**
  String get wordCheckSubtitle;

  /// No description provided for @playCue.
  ///
  /// In en, this message translates to:
  /// **'Play cue'**
  String get playCue;

  /// No description provided for @notSureButton.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get notSureButton;

  /// No description provided for @wordCheckLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String wordCheckLevel(int level);

  /// No description provided for @writingPositionItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Which one sits correctly on the line?'**
  String get writingPositionItemTitle;

  /// No description provided for @spellingItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick the correct spelling'**
  String get spellingItemTitle;

  /// No description provided for @soundMatchItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Which one matches the sound you heard?'**
  String get soundMatchItemTitle;

  /// No description provided for @fillBlankItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the word that fits best'**
  String get fillBlankItemTitle;

  /// No description provided for @oddOneOutItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Which one does not belong?'**
  String get oddOneOutItemTitle;

  /// No description provided for @meaningInferenceItemTitle.
  ///
  /// In en, this message translates to:
  /// **'What does this mean in the story?'**
  String get meaningInferenceItemTitle;

  /// No description provided for @sentenceMatchItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Which sentence matches the picture?'**
  String get sentenceMatchItemTitle;

  /// No description provided for @eventSequenceItemTitle.
  ///
  /// In en, this message translates to:
  /// **'What happened first?'**
  String get eventSequenceItemTitle;

  /// No description provided for @levelPromotedMessage.
  ///
  /// In en, this message translates to:
  /// **'Level {level} completed! Moving up.'**
  String levelPromotedMessage(int level);

  /// No description provided for @itemWordTag.
  ///
  /// In en, this message translates to:
  /// **'{index}. Word'**
  String itemWordTag(int index);

  /// No description provided for @itemSentenceTag.
  ///
  /// In en, this message translates to:
  /// **'{index}. Sentence'**
  String itemSentenceTag(int index);

  /// No description provided for @writtenCorrectly.
  ///
  /// In en, this message translates to:
  /// **'Written correctly'**
  String get writtenCorrectly;

  /// No description provided for @notCorrect.
  ///
  /// In en, this message translates to:
  /// **'Not correct'**
  String get notCorrect;

  /// No description provided for @givePhoneToTitle.
  ///
  /// In en, this message translates to:
  /// **'Give the phone to {name}.'**
  String givePhoneToTitle(String name);

  /// No description provided for @givePhoneToSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Teacher screens stay locked while {name} uses the phone. To come back, tap Teacher and enter your passcode.'**
  String givePhoneToSubtitle(String name);

  /// No description provided for @originalPassageReviewNote.
  ///
  /// In en, this message translates to:
  /// **'Original Samajh passage, awaiting teacher review'**
  String get originalPassageReviewNote;

  /// No description provided for @roomTooNoisyWarning.
  ///
  /// In en, this message translates to:
  /// **'Too noisy. Move somewhere quieter, or continue: the result will be marked low confidence.'**
  String get roomTooNoisyWarning;

  /// No description provided for @roomQuietNotice.
  ///
  /// In en, this message translates to:
  /// **'Quiet room. Good for recording.'**
  String get roomQuietNotice;

  /// No description provided for @notEnoughEvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough evidence: no reading could be heard or marked.'**
  String get notEnoughEvidenceTitle;

  /// No description provided for @lowConfidenceExplanation.
  ///
  /// In en, this message translates to:
  /// **'Low confidence: many words were unclear or the room was noisy. Check again before deciding.'**
  String get lowConfidenceExplanation;

  /// No description provided for @readingSection.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get readingSection;

  /// No description provided for @understandingSection.
  ///
  /// In en, this message translates to:
  /// **'Understanding'**
  String get understandingSection;

  /// No description provided for @writingDictationSection.
  ///
  /// In en, this message translates to:
  /// **'Writing (dictation)'**
  String get writingDictationSection;

  /// No description provided for @accuracyPercent.
  ///
  /// In en, this message translates to:
  /// **'Accuracy {percent}%'**
  String accuracyPercent(int percent);

  /// No description provided for @correctWordsPerMinute.
  ///
  /// In en, this message translates to:
  /// **'{wpm} correct words per minute'**
  String correctWordsPerMinute(int wpm);

  /// No description provided for @readingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'{skipped} skipped · {misread} read differently · {selfCorrected} corrected self'**
  String readingBreakdown(int skipped, int misread, int selfCorrected);

  /// No description provided for @flsBenchmarkAbove.
  ///
  /// In en, this message translates to:
  /// **'FLS 2022, Class {grade} benchmark: above the minimum level'**
  String flsBenchmarkAbove(Object grade);

  /// No description provided for @flsBenchmarkMeets.
  ///
  /// In en, this message translates to:
  /// **'FLS 2022, Class {grade} benchmark: meets the minimum level'**
  String flsBenchmarkMeets(Object grade);

  /// No description provided for @flsBenchmarkBelow.
  ///
  /// In en, this message translates to:
  /// **'FLS 2022, Class {grade} benchmark: below the minimum level'**
  String flsBenchmarkBelow(Object grade);

  /// No description provided for @nipunReached.
  ///
  /// In en, this message translates to:
  /// **'UP NIPUN H306: at least 60 words per minute: reached'**
  String get nipunReached;

  /// No description provided for @nipunNotReached.
  ///
  /// In en, this message translates to:
  /// **'UP NIPUN H306: at least 60 words per minute: not reached'**
  String get nipunNotReached;

  /// No description provided for @accuracyGuideNote.
  ///
  /// In en, this message translates to:
  /// **'The 90% accuracy guide is a Samajh provisional threshold, not an official standard.'**
  String get accuracyGuideNote;

  /// No description provided for @storyRetoldScore.
  ///
  /// In en, this message translates to:
  /// **'Story retold: {ticked} of {total}'**
  String storyRetoldScore(int ticked, int total);

  /// No description provided for @dictationScoreSummary.
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} words written correctly'**
  String dictationScoreSummary(int correct, int total);

  /// No description provided for @dictationSkippedSummary.
  ///
  /// In en, this message translates to:
  /// **'Dictation skipped'**
  String get dictationSkippedSummary;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Teacher Profile'**
  String get profileTitle;

  /// No description provided for @teacherNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Teacher Name'**
  String get teacherNameLabel;

  /// No description provided for @teacherNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Sunita Sharma'**
  String get teacherNameHint;

  /// No description provided for @schoolNameLabel.
  ///
  /// In en, this message translates to:
  /// **'School Name (optional)'**
  String get schoolNameLabel;

  /// No description provided for @schoolNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Primary School Rampur'**
  String get schoolNameHint;

  /// No description provided for @preferredLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred App Language'**
  String get preferredLanguageLabel;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changePasscode.
  ///
  /// In en, this message translates to:
  /// **'Change passcode'**
  String get changePasscode;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeLanguage;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @classesITeach.
  ///
  /// In en, this message translates to:
  /// **'Classes I teach'**
  String get classesITeach;

  /// No description provided for @addClassButton.
  ///
  /// In en, this message translates to:
  /// **'Add class'**
  String get addClassButton;

  /// No description provided for @studentCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No students} =1{1 student} other{{count} students}}'**
  String studentCount(int count);

  /// No description provided for @noPendingReviews.
  ///
  /// In en, this message translates to:
  /// **'No checks waiting for review'**
  String get noPendingReviews;

  /// No description provided for @noRechecksDue.
  ///
  /// In en, this message translates to:
  /// **'No rechecks due'**
  String get noRechecksDue;

  /// No description provided for @startCheckShortcuts.
  ///
  /// In en, this message translates to:
  /// **'Start a check'**
  String get startCheckShortcuts;

  /// No description provided for @switchClass.
  ///
  /// In en, this message translates to:
  /// **'Switch class'**
  String get switchClass;

  /// No description provided for @activeClassChip.
  ///
  /// In en, this message translates to:
  /// **'Active: {name}'**
  String activeClassChip(String name);

  /// No description provided for @shareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAction;

  /// No description provided for @printAction.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get printAction;

  /// No description provided for @shareWarningNote.
  ///
  /// In en, this message translates to:
  /// **'Shared files leave this phone. Share only via secure channels.'**
  String get shareWarningNote;

  /// No description provided for @parentReportApprovalPrompt.
  ///
  /// In en, this message translates to:
  /// **'I approve sharing this report with the parent'**
  String get parentReportApprovalPrompt;

  /// No description provided for @parentReportApprovalRequired.
  ///
  /// In en, this message translates to:
  /// **'Teacher approval required before printing or sharing parent reports.'**
  String get parentReportApprovalRequired;

  /// No description provided for @unmarkedWordsCounter.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 word not marked yet} other{{count} words not marked yet}}'**
  String unmarkedWordsCounter(int count);

  /// No description provided for @markRemainingCorrect.
  ///
  /// In en, this message translates to:
  /// **'Mark remaining as correct'**
  String get markRemainingCorrect;

  /// No description provided for @confirmMarkRemainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark Remaining as Correct?'**
  String get confirmMarkRemainingTitle;

  /// No description provided for @confirmMarkRemainingBody.
  ///
  /// In en, this message translates to:
  /// **'All words up to the last-read word that have not been marked will be marked as correct.'**
  String get confirmMarkRemainingBody;

  /// No description provided for @unmarkedWordsWarning.
  ///
  /// In en, this message translates to:
  /// **'Please mark all words up to the last read word, or tap \'Mark remaining as correct\'.'**
  String get unmarkedWordsWarning;

  /// No description provided for @audioConsentWithdrawnMessage.
  ///
  /// In en, this message translates to:
  /// **'Audio recording consent has been withdrawn. Checks cannot record audio until enabled in Settings > Privacy.'**
  String get audioConsentWithdrawnMessage;

  /// No description provided for @audioConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Microphone & Audio Recording'**
  String get audioConsentTitle;

  /// No description provided for @audioConsentDesc.
  ///
  /// In en, this message translates to:
  /// **'Microphone is used to record a child\'s reading for teacher review. The recording is encrypted and deleted once marked.'**
  String get audioConsentDesc;

  /// No description provided for @audioConsentStatusGranted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get audioConsentStatusGranted;

  /// No description provided for @audioConsentStatusWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get audioConsentStatusWithdrawn;

  /// No description provided for @withdrawAudioConsent.
  ///
  /// In en, this message translates to:
  /// **'Withdraw audio consent'**
  String get withdrawAudioConsent;

  /// No description provided for @grantAudioConsent.
  ///
  /// In en, this message translates to:
  /// **'Allow audio recording'**
  String get grantAudioConsent;

  /// No description provided for @storageConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Local Encrypted Storage Consent'**
  String get storageConsentTitle;

  /// No description provided for @storageConsentDesc.
  ///
  /// In en, this message translates to:
  /// **'Children\'s data is kept only on this device, encrypted, until school approves.'**
  String get storageConsentDesc;

  /// No description provided for @storageConsentGiven.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get storageConsentGiven;

  /// No description provided for @markChildStoppedHere.
  ///
  /// In en, this message translates to:
  /// **'Child stopped here (mark rest not reached)'**
  String get markChildStoppedHere;

  /// No description provided for @questionsLevelHint.
  ///
  /// In en, this message translates to:
  /// **'Ask Level 1 first. The next level opens only when the child gets at least half of this level right.'**
  String get questionsLevelHint;

  /// No description provided for @questionLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String questionLevelLabel(int level);

  /// No description provided for @questionsStoppedAt.
  ///
  /// In en, this message translates to:
  /// **'Questions stop at Level {level}. Practise this level before asking harder questions.'**
  String questionsStoppedAt(int level);

  /// No description provided for @questionsNextLocked.
  ///
  /// In en, this message translates to:
  /// **'Level {level} opens after this level is passed.'**
  String questionsNextLocked(int level);

  /// No description provided for @questionTimeSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds} s'**
  String questionTimeSeconds(int seconds);

  /// No description provided for @questionMarkFirst.
  ///
  /// In en, this message translates to:
  /// **'Mark every open question to see the result.'**
  String get questionMarkFirst;

  /// No description provided for @childFeltLabel.
  ///
  /// In en, this message translates to:
  /// **'Child\'s own feeling:'**
  String get childFeltLabel;

  /// No description provided for @typingSection.
  ///
  /// In en, this message translates to:
  /// **'Typing check (child typed the words)'**
  String get typingSection;

  /// No description provided for @typingScoreLine.
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} words typed correctly'**
  String typingScoreLine(int correct, int total);

  /// No description provided for @typingSkipped.
  ///
  /// In en, this message translates to:
  /// **'Typing check not done.'**
  String get typingSkipped;

  /// No description provided for @typedWordRow.
  ///
  /// In en, this message translates to:
  /// **'{target}: typed {typed}'**
  String typedWordRow(String target, String typed);

  /// No description provided for @typedWordNotSure.
  ///
  /// In en, this message translates to:
  /// **'{target}: not sure'**
  String typedWordNotSure(String target);

  /// No description provided for @marksLine.
  ///
  /// In en, this message translates to:
  /// **'Marks: {earned} of {possible}'**
  String marksLine(String earned, String possible);

  /// No description provided for @highestLevelPassed.
  ///
  /// In en, this message translates to:
  /// **'Highest level passed: Level {level}'**
  String highestLevelPassed(int level);

  /// No description provided for @levelOneNotPassed.
  ///
  /// In en, this message translates to:
  /// **'Level 1 not passed yet. Practise Level 1 first.'**
  String get levelOneNotPassed;

  /// No description provided for @weightedMarkingNote.
  ///
  /// In en, this message translates to:
  /// **'Higher levels carry more marks. Answers slower than the expected time earn fewer marks. These weights are provisional.'**
  String get weightedMarkingNote;

  /// No description provided for @selfRatingSection.
  ///
  /// In en, this message translates to:
  /// **'Child\'s own rating and the result'**
  String get selfRatingSection;

  /// No description provided for @selfRatingCounts.
  ///
  /// In en, this message translates to:
  /// **'{up} thumbs up, {down} thumbs down'**
  String selfRatingCounts(int up, int down);

  /// No description provided for @selfRatingUpButWrong.
  ///
  /// In en, this message translates to:
  /// **'Felt good but the answer was wrong: {count}'**
  String selfRatingUpButWrong(int count);

  /// No description provided for @selfRatingDownButCorrect.
  ///
  /// In en, this message translates to:
  /// **'Felt unsure but the answer was right: {count}'**
  String selfRatingDownButCorrect(int count);

  /// No description provided for @selfRatingMatch.
  ///
  /// In en, this message translates to:
  /// **'The child\'s feeling matched the result {percent}% of the time.'**
  String selfRatingMatch(int percent);

  /// No description provided for @selfRatingNone.
  ///
  /// In en, this message translates to:
  /// **'The child did not give any ratings.'**
  String get selfRatingNone;

  /// No description provided for @readingFeltGood.
  ///
  /// In en, this message translates to:
  /// **'At the end of the check: thumbs up'**
  String get readingFeltGood;

  /// No description provided for @readingFeltHard.
  ///
  /// In en, this message translates to:
  /// **'At the end of the check: thumbs down'**
  String get readingFeltHard;

  /// No description provided for @selfRatingNote.
  ///
  /// In en, this message translates to:
  /// **'Ratings show how the child feels. They are not marks.'**
  String get selfRatingNote;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String greetingMorning(String name);

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String greetingAfternoon(String name);

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String greetingEvening(String name);

  /// No description provided for @todayClassesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 class} other{{count} classes}} today'**
  String todayClassesCount(int count);

  /// No description provided for @supportGroupsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support groups'**
  String get supportGroupsTitle;

  /// No description provided for @supportGroupsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who needs which kind of help, from the latest checks'**
  String get supportGroupsSubtitle;

  /// No description provided for @viewClassLink.
  ///
  /// In en, this message translates to:
  /// **'View class'**
  String get viewClassLink;

  /// No description provided for @groupDecodingShort.
  ///
  /// In en, this message translates to:
  /// **'Reading words'**
  String get groupDecodingShort;

  /// No description provided for @groupComprehensionShort.
  ///
  /// In en, this message translates to:
  /// **'Understanding'**
  String get groupComprehensionShort;

  /// No description provided for @groupBothShort.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get groupBothShort;

  /// No description provided for @classCheckedRing.
  ///
  /// In en, this message translates to:
  /// **'{checked} of {total}'**
  String classCheckedRing(int checked, int total);

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get profileEditTitle;

  /// No description provided for @profileSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get profileSectionAbout;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileFullName;

  /// No description provided for @profileFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get profileFullNameRequired;

  /// No description provided for @profileDisplayName.
  ///
  /// In en, this message translates to:
  /// **'What children call you'**
  String get profileDisplayName;

  /// No description provided for @profileDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Sunita ji'**
  String get profileDisplayNameHint;

  /// No description provided for @profileRole.
  ///
  /// In en, this message translates to:
  /// **'Your role'**
  String get profileRole;

  /// No description provided for @roleTeacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get roleTeacher;

  /// No description provided for @roleHeadTeacher.
  ///
  /// In en, this message translates to:
  /// **'Head teacher'**
  String get roleHeadTeacher;

  /// No description provided for @roleParaTeacher.
  ///
  /// In en, this message translates to:
  /// **'Shiksha mitra / para teacher'**
  String get roleParaTeacher;

  /// No description provided for @roleOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get roleOther;

  /// No description provided for @profileSectionSchool.
  ///
  /// In en, this message translates to:
  /// **'Your school'**
  String get profileSectionSchool;

  /// No description provided for @profileSchoolName.
  ///
  /// In en, this message translates to:
  /// **'School name'**
  String get profileSchoolName;

  /// No description provided for @profileUdise.
  ///
  /// In en, this message translates to:
  /// **'UDISE code'**
  String get profileUdise;

  /// No description provided for @profileUdiseError.
  ///
  /// In en, this message translates to:
  /// **'A UDISE code has 11 digits'**
  String get profileUdiseError;

  /// No description provided for @profileBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get profileBlock;

  /// No description provided for @profileDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get profileDistrict;

  /// No description provided for @profileState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get profileState;

  /// No description provided for @stateRajasthan.
  ///
  /// In en, this message translates to:
  /// **'Rajasthan'**
  String get stateRajasthan;

  /// No description provided for @stateUttarPradesh.
  ///
  /// In en, this message translates to:
  /// **'Uttar Pradesh'**
  String get stateUttarPradesh;

  /// No description provided for @stateOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get stateOther;

  /// No description provided for @profileYears.
  ///
  /// In en, this message translates to:
  /// **'Years of teaching'**
  String get profileYears;

  /// No description provided for @profileYearsError.
  ///
  /// In en, this message translates to:
  /// **'Enter a number from 0 to 60'**
  String get profileYearsError;

  /// No description provided for @profileSectionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact (optional)'**
  String get profileSectionContact;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get profilePhone;

  /// No description provided for @profilePhoneError.
  ///
  /// In en, this message translates to:
  /// **'Enter a 10-digit mobile number'**
  String get profilePhoneError;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileEmailError.
  ///
  /// In en, this message translates to:
  /// **'Enter an email like name@example.com'**
  String get profileEmailError;

  /// No description provided for @profileStaysOnPhone.
  ///
  /// In en, this message translates to:
  /// **'Your profile is saved only on this phone. It is not sent anywhere.'**
  String get profileStaysOnPhone;

  /// No description provided for @profileSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get profileSaveButton;

  /// No description provided for @profileDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get profileDetailsTitle;

  /// No description provided for @profileNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Not added'**
  String get profileNotAdded;

  /// No description provided for @profileYearsValue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year} other{{count} years}}'**
  String profileYearsValue(int count);

  /// No description provided for @profileCompleteCta.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get profileCompleteCta;

  /// No description provided for @todayOfTotalChecked.
  ///
  /// In en, this message translates to:
  /// **'of {total} checked'**
  String todayOfTotalChecked(int total);

  /// No description provided for @todayNextChild.
  ///
  /// In en, this message translates to:
  /// **'Next: {name}'**
  String todayNextChild(String name);

  /// No description provided for @todayEveryoneChecked.
  ///
  /// In en, this message translates to:
  /// **'Everyone in this class is checked'**
  String get todayEveryoneChecked;

  /// No description provided for @todayNotCheckedYet.
  ///
  /// In en, this message translates to:
  /// **'Not grouped yet'**
  String get todayNotCheckedYet;

  /// No description provided for @selfRatingOverallUpWell.
  ///
  /// In en, this message translates to:
  /// **'Felt good, and the check went well.'**
  String get selfRatingOverallUpWell;

  /// No description provided for @selfRatingOverallUpHard.
  ///
  /// In en, this message translates to:
  /// **'Felt good, but parts of the check were hard. The child may not notice their own mistakes yet.'**
  String get selfRatingOverallUpHard;

  /// No description provided for @selfRatingOverallDownWell.
  ///
  /// In en, this message translates to:
  /// **'Felt unsure, but did well. The child may need more confidence.'**
  String get selfRatingOverallDownWell;

  /// No description provided for @selfRatingOverallDownHard.
  ///
  /// In en, this message translates to:
  /// **'Felt it was hard, and it was. The child knows where they struggle.'**
  String get selfRatingOverallDownHard;

  /// No description provided for @autoMarkListening.
  ///
  /// In en, this message translates to:
  /// **'Listening to the recording and marking each word…'**
  String get autoMarkListening;

  /// No description provided for @autoMarkAllHeard.
  ///
  /// In en, this message translates to:
  /// **'The app heard every word read correctly. Play the recording if you want to check.'**
  String get autoMarkAllHeard;

  /// No description provided for @autoMarkDone.
  ///
  /// In en, this message translates to:
  /// **'The app marked the reading. It thinks {wrong} words were read wrong. Listen to the {check} words with an orange ring and change any mark you hear differently.'**
  String autoMarkDone(int wrong, int check);

  /// No description provided for @autoMarkFailed.
  ///
  /// In en, this message translates to:
  /// **'The app could not mark this recording. Please mark by listening.'**
  String get autoMarkFailed;

  /// No description provided for @autoMarkUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Automatic marking needs the Android app on a phone. Please mark by listening.'**
  String get autoMarkUnsupported;

  /// No description provided for @autoMarkNoRecording.
  ///
  /// In en, this message translates to:
  /// **'There is no recording, so the app could not mark the reading. Please mark as the child reads.'**
  String get autoMarkNoRecording;

  /// No description provided for @autoMarkNote.
  ///
  /// In en, this message translates to:
  /// **'Marks come from an offline speech model on this phone. It can be wrong, especially with young voices, so your check decides.'**
  String get autoMarkNote;

  /// No description provided for @autoMarkNothingHeard.
  ///
  /// In en, this message translates to:
  /// **'The app did not hear the passage in the recording, so every word is marked not reached. Play the recording and mark by listening.'**
  String get autoMarkNothingHeard;

  /// No description provided for @autoMarkStopped.
  ///
  /// In en, this message translates to:
  /// **'The app heard the first {count} words read correctly, then the reading stopped. Play the recording if you want to check.'**
  String autoMarkStopped(int count);

  /// No description provided for @lowConfidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Result with low confidence'**
  String get lowConfidenceTitle;

  /// No description provided for @lowConfidenceNote.
  ///
  /// In en, this message translates to:
  /// **'The room was noisy or the reading was very short, so reading speed is left out. The rest of the result comes from the child\'s answers.'**
  String get lowConfidenceNote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
