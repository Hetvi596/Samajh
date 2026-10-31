// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'समझ';

  @override
  String get appTitleDevanagari => 'समझ';

  @override
  String get appSubtitle => 'पठन, समझ और लेखन मूल्यांकन';

  @override
  String get welcomeHeadline => 'समझें कि हर बच्चा क्या समझता है';

  @override
  String get welcomeSubtitle =>
      '4 मिनट में बच्चे के पठन, समझ और लेखन की जांच करें। बिना इंटरनेट के काम करता है।';

  @override
  String get selectLanguage => 'अपनी भाषा चुनें';

  @override
  String get english => 'English (अंग्रेज़ी)';

  @override
  String get hindi => 'हिंदी';

  @override
  String get marathi => 'मराठी';

  @override
  String get continueButton => 'आगे बढ़ें';

  @override
  String get getStartedButton => 'शुरू करें';

  @override
  String get backButton => 'पीछे जाएं';

  @override
  String get saveButton => 'सुरक्षित करें';

  @override
  String get cancelButton => 'रद्द करें';

  @override
  String get doneButton => 'पूर्ण';

  @override
  String get closeButton => 'बंद करें';

  @override
  String get nextButton => 'अगला';

  @override
  String get none => 'कोई नहीं';

  @override
  String get yesButton => 'हाँ';

  @override
  String get notNowButton => 'अभी नहीं';

  @override
  String get privacyTitle => 'गोपनीयता';

  @override
  String get privacySubtitle => 'कक्षा का डेटा इसी फ़ोन में सुरक्षित रहता है';

  @override
  String get privacyPoint1Title =>
      'सब कुछ इसी फ़ोन पर सुरक्षित और एन्क्रिप्टेड रहता है';

  @override
  String get privacyPoint1Desc =>
      'सारा डेटा इसी डिवाइस पर एन्क्रिप्टेड रहता है। वैकल्पिक क्लाउड सिंक डिफ़ॉल्ट रूप से बंद है और बिना शिक्षक लॉगिन के कोई डेटा कहीं नहीं भेजा जाता।';

  @override
  String get privacyPoint2Title => 'जांच के बाद रिकॉर्डिंग हटा दी जाती है';

  @override
  String get privacyPoint2Desc =>
      'पढ़ने की रिकॉर्डिंग कभी फ़ोन से बाहर नहीं जाती और जांच के बाद मिटा दी जाती है।';

  @override
  String get privacyPoint3Title => 'केवल न्यूनतम जानकारी की आवश्यकता';

  @override
  String get privacyPoint3Desc =>
      'केवल पहला नाम और उपनाम का पहला अक्षर चाहिए (जन्म तिथि, पता या पहचान पत्र नहीं)।';

  @override
  String get privacyPoint4Title => 'आपकी कक्षा, 100% ऑफलाइन';

  @override
  String get privacyPoint4Desc =>
      'पूरी डेटा गोपनीयता के साथ बच्चों का आकलन करें। शून्य ट्रैकर, शून्य विज्ञापन और डिफ़ॉल्ट रूप से सिंक बंद।';

  @override
  String get privacyAccept => 'आगे बढ़ें';

  @override
  String get privacyConsentStorage =>
      'मैं समझता/समझती हूँ कि यह ऐप बच्चों का डेटा केवल इसी फ़ोन पर एन्क्रिप्टेड रखता है, और जब तक मेरे विद्यालय से अनुमति नहीं मिलती, मैं बच्चों का वास्तविक डेटा दर्ज नहीं करूँगा/करूँगी।';

  @override
  String get privacyConsentAudio =>
      'समझ को बच्चे के पठन को रिकॉर्ड करने के लिए माइक्रोफ़ोन का उपयोग करने दें। रिकॉर्डिंग इसी फ़ोन पर सुरक्षित रखी जाती है और मेरे द्वारा जांचने के बाद मिटा दी जाती है।';

  @override
  String get passcodeTitle => 'शिक्षक पासकोड बनाएं';

  @override
  String get passcodeSubtitle =>
      'इसका उपयोग आप समझ खोलने और बच्चों की स्क्रीन से बाहर निकलने के लिए करेंगे';

  @override
  String get enterPasscode => '6 अंकों का पासकोड दर्ज करें';

  @override
  String get confirmPasscode => 'पुष्टि के लिए फिर से दर्ज करें';

  @override
  String get passcodesDoNotMatch =>
      'पासकोड मेल नहीं खाते। कृपया पुनः प्रयास करें।';

  @override
  String get passcodeIncorrect => 'गलत पासकोड। कृपया पुनः प्रयास करें।';

  @override
  String passcodeLockedUntil(Object seconds) {
    return 'अत्यधिक असफल प्रयास। कृपया $seconds सेकंड बाद प्रयास करें।';
  }

  @override
  String get enterPasscodeToUnlock => 'अनलॉक करने के लिए पासकोड डालें';

  @override
  String get enterPasscodeToExitStudent =>
      'विद्यार्थी मोड से बाहर निकलने के लिए अपना पासकोड दर्ज करें';

  @override
  String get useFingerprintPrompt => 'फिंगरप्रिंट का भी उपयोग करें?';

  @override
  String get classSetupTitle => 'अपनी कक्षा निर्धारित करें';

  @override
  String get classSetupSubtitle =>
      'पाठ्यक्रम और आधिकारिक मानकों के अनुसार अपनी कक्षा का विवरण चुनें';

  @override
  String get classNameLabel => 'कक्षा / विद्यालय का नाम';

  @override
  String get classNameHint => 'जैसे: कक्षा 3B या प्राथमिक विद्यालय';

  @override
  String get gradeLabel => 'कक्षा / स्तर';

  @override
  String get grade1 => 'कक्षा 1';

  @override
  String get grade2 => 'कक्षा 2';

  @override
  String get grade3 => 'कक्षा 3';

  @override
  String get grade4 => 'कक्षा 4';

  @override
  String get grade5 => 'कक्षा 5';

  @override
  String get sectionLabel => 'वर्ग / सेक्शन';

  @override
  String get boardLabel => 'बोर्ड / पाठ्यक्रम';

  @override
  String get curriculumLabel => 'पाठ्यक्रम';

  @override
  String get curriculumNcert => 'एनसीईआरटी / सीबीएसई';

  @override
  String get curriculumUp => 'उत्तर प्रदेश बेसिक शिक्षा';

  @override
  String get curriculumBihar => 'बिहार राज्य शिक्षा शोध परिषद (SCERT)';

  @override
  String get curriculumRajasthan => 'राजस्थान आरएससीईआरटी';

  @override
  String get curriculumMp => 'मध्य प्रदेश राज्य शिक्षा केन्द्र';

  @override
  String get curriculumMaharashtra => 'महाराष्ट्र राज्य शिक्षण मंडळ (बालभारती)';

  @override
  String get curriculumIcse => 'सी.आई.एस.सी.ई. (ICSE)';

  @override
  String get curriculumSchoolOwn => 'विद्यालय का अपना पाठ्यक्रम';

  @override
  String get schoolLanguageLabel => 'जांच की भाषा';

  @override
  String get mediumOfInstructionLabel => 'शिक्षण का माध्यम';

  @override
  String get createClassButton => 'कक्षा बनाएं और आगे बढ़ें';

  @override
  String get classProfileTitle => 'सक्रिय कक्षा का विवरण';

  @override
  String get noChildrenInClassYet => 'इस कक्षा में अभी कोई बच्चा नहीं है';

  @override
  String get addChildPrompt =>
      'पठन और समझ की जांच शुरू करने के लिए बच्चे जोड़ें';

  @override
  String get classSettingsTitle => 'कक्षा सेटिंग्स';

  @override
  String get saveClassSettings => 'कक्षा सेटिंग्स सहेजें';

  @override
  String get classSettingsSaved => 'कक्षा सेटिंग्स सहेजी गईं';

  @override
  String classMilestonesTitle(Object grade) {
    return 'कक्षा $grade के मानक';
  }

  @override
  String get tabToday => 'आज';

  @override
  String get tabClass => 'कक्षा';

  @override
  String get tabPractice => 'अभ्यास';

  @override
  String get tabReports => 'रिपोर्ट';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get todayGreeting => 'नमस्ते, शिक्षक जी';

  @override
  String get checkNextChild => 'अगले बच्चे की जांच करें';

  @override
  String checkNextChildNamed(Object name) {
    return 'अगले बच्चे की जांच करें: $name';
  }

  @override
  String get allChildrenChecked => 'सभी बच्चों की जांच पूर्ण';

  @override
  String get addChildrenButton => 'बच्चे जोड़ें';

  @override
  String checkedProgress(Object checked, Object total) {
    return '$total में से $checked बच्चों की जांच पूर्ण';
  }

  @override
  String suggestedToday(Object count) {
    return 'आज के लिए सुझाव: $count बच्चे';
  }

  @override
  String get todoTitle => 'कार्य सूची';

  @override
  String get todoWaitingReview => 'समीक्षा की प्रतीक्षा में';

  @override
  String get todoRechecksDue => 'पुनः जांच देय';

  @override
  String get todoSheetsReady => 'अभ्यास पत्रक तैयार';

  @override
  String get worksOfflineReassurance => 'बिना इंटरनेट के काम करता है';

  @override
  String get backupYourClass => 'अपनी कक्षा का बैकअप लें';

  @override
  String filterAll(Object count) {
    return 'सभी · $count';
  }

  @override
  String filterNotGrouped(Object count) {
    return 'अभी समूह नहीं बना · $count';
  }

  @override
  String get groupOnTrack => 'सही गति और समझ';

  @override
  String get groupNeedsReading => 'समझता है, शब्द पढ़ने में मदद चाहिए';

  @override
  String get groupNeedsUnderstanding => 'शब्द पढ़ता है, समझने में मदद चाहिए';

  @override
  String get groupNeedsBoth => 'दोनों में मदद चाहिए';

  @override
  String get groupNotGroupedYet => 'अभी समूह नहीं बना';

  @override
  String get groupHelperText =>
      'समूह नवीनतम जांच के आधार पर केवल सुझाव हैं। आप किसी भी बच्चे का समूह बदल सकते हैं।';

  @override
  String get statusChecked => 'जांच पूर्ण';

  @override
  String get statusNotChecked => 'अभी जांच नहीं हुई';

  @override
  String get statusCheckedToday => 'आज जांच हुई';

  @override
  String statusCheckedOn(Object date) {
    return '$date को जांच हुई';
  }

  @override
  String get statusWaitingReview => 'समीक्षा बाकी';

  @override
  String get statusConsentMissing => 'सहमति बाकी';

  @override
  String get startCheck => 'जांच शुरू करें';

  @override
  String get resumeCheck => 'जांच जारी रखें';

  @override
  String get childProfileTitle => 'बच्चे का विवरण';

  @override
  String get consentStatus => 'अभिभावक सहमति';

  @override
  String get consentGiven => 'सहमति प्राप्त';

  @override
  String get consentWithdrawn => 'सहमति वापस ली गई';

  @override
  String get markConsent => 'अभिभावक सहमति दर्ज करें';

  @override
  String get withdrawConsent => 'सहमति वापस लें';

  @override
  String get moveToAnotherGroup => 'दूसरे समूह में ले जाएं';

  @override
  String get deleteChild => 'इस बच्चे का विवरण हटाएं';

  @override
  String get addChild => 'बच्चा जोड़ें';

  @override
  String get importCsv => 'CSV से आयात करें';

  @override
  String beforeHandingOverTitle(Object name) {
    return 'फोन $name को दें';
  }

  @override
  String beforeHandingOverSubtitle(Object name) {
    return 'जब तक $name फोन का उपयोग कर रहा है, शिक्षक स्क्रीन लॉक रहेगी। वापस आने के लिए \'शिक्षक\' पर टैप करें और अपना पासकोड दर्ज करें।';
  }

  @override
  String get originalPassageTag => 'मूल समझ गद्यांश, शिक्षक समीक्षा प्रतीक्षित';

  @override
  String get checkTheRoom => 'कमरे की जांच करें';

  @override
  String get listenFor3Seconds => '3 सेकंड के लिए सुनें';

  @override
  String get startStudentMode => 'विद्यार्थी मोड शुरू करें';

  @override
  String get noiseCheckTitle => 'कमरे का शोर मापा जा रहा है...';

  @override
  String get noiseLevelGood => 'शोर का स्तर: जांच के लिए उपयुक्त';

  @override
  String get noiseLevelHigh =>
      'यहाँ बहुत शोर है। यदि संभव हो तो किसी शांत जगह पर जाएं।';

  @override
  String get tryAgain => 'फिर से प्रयास करें';

  @override
  String get continueAnyway => 'फिर भी जारी रखें';

  @override
  String get markWithoutRecording => 'बिना रिकॉर्डिंग के अंकन करें';

  @override
  String get handoverInstructions =>
      'जब तक फोन का उपयोग हो रहा है, शिक्षक स्क्रीन लॉक रहेगी।';

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
  String get markingTitle => 'पठन का अंकन करें';

  @override
  String get playRecording => 'रिकॉर्डिंग सुनें';

  @override
  String get pauseRecording => 'रोकें';

  @override
  String get markingGuide => 'सुरक्षित करते ही रिकॉर्डिंग मिटा दी जाएगी।';

  @override
  String get markCorrect => 'सही';

  @override
  String get markReadAsAnotherWord => 'अलग शब्द पढ़ा';

  @override
  String get markSkipped => 'छोड़ दिया';

  @override
  String get markSelfCorrected => 'स्वयं सुधारा';

  @override
  String get markRepeated => 'दोहराया';

  @override
  String get markNotSure => 'निश्चित नहीं';

  @override
  String get markNotReached => 'यहाँ तक नहीं पढ़ा';

  @override
  String liveMarkingCount(Object errors, Object notSure, Object wordsRead) {
    return '$errors गलतियां · $notSure अनिश्चित · $wordsRead पढ़े गए शब्द';
  }

  @override
  String get saveAndContinue => 'सुरक्षित करें और आगे बढ़ें';

  @override
  String get micPermissionTitle => 'ऑडियो रिकॉर्डिंग की अनुमति';

  @override
  String get micPermissionDesc =>
      'पठन और उच्चारण की जांच के लिए माइक्रोफ़ोन की अनुमति आवश्यक है। रिकॉर्डिंग सुरक्षित रहती है और मिटा दी जाती है।';

  @override
  String get grantMicPermission => 'ऑडियो अनुमति दें';

  @override
  String get micReadyBadge => 'माइक तैयार है (सुरक्षित स्थानीय)';

  @override
  String get pronunciationCheckTitle => 'उच्चारण जांच';

  @override
  String get pronunciationCheckGuide => 'उच्चारण मार्गदर्शिका';

  @override
  String get phoneticBreakdownTitle => 'वर्ण और मात्रा विश्लेषण';

  @override
  String get markPronouncedCorrect => 'सही उच्चारण';

  @override
  String get markMispronounced => 'गलत उच्चारण / अलग पढ़ा';

  @override
  String get acceptRegionalPronunciation => 'क्षेत्रीय उच्चारण स्वीकारें';

  @override
  String get regionalAccentBadge => 'क्षेत्रीय';

  @override
  String get regionalAccentExplanation =>
      'क्षेत्रीय बोलियों के उच्चारण (जैसे स/श, व/ब, ड/ड़) बिना अंक काटे स्वीकार किए जाते हैं।';

  @override
  String commonRegionalVariants(Object variants) {
    return 'सामान्य क्षेत्रीय उच्चारण: $variants';
  }

  @override
  String standardPronunciation(Object guide) {
    return 'मानक उच्चारण: $guide';
  }

  @override
  String livePronunciationAccuracy(Object percent) {
    return 'उच्चारण शुद्धता: $percent%';
  }

  @override
  String get inspectWord => 'शब्द जांचें';

  @override
  String get nextWord => 'अगला शब्द';

  @override
  String get prevWord => 'पिछला शब्द';

  @override
  String get errorKindConsonant => 'व्यंजन त्रुटि';

  @override
  String get errorKindShortMatra => 'ह्रस्व मात्रा त्रुटि';

  @override
  String get errorKindLongMatra => 'दीर्घ मात्रा त्रुटि';

  @override
  String get errorKindConjunct => 'संयुक्त अक्षर त्रुटि';

  @override
  String get errorKindNukta => 'नुक्ता त्रुटि';

  @override
  String get errorKindBindu => 'अनुस्वार त्रुटि';

  @override
  String get soundErrorType => 'उच्चारण त्रुटि का प्रकार';

  @override
  String get observedWordPrompt => 'बच्चे ने क्या उच्चारण किया?';

  @override
  String get retellTitle => 'कहानी पुनर्कथन';

  @override
  String get retellSubtitle =>
      'बच्चे से अपने शब्दों में कहानी सुनाने को कहें। बच्चा जिस बिंदु का उल्लेख करे, उस पर सही का निशान लगाएं (किसी भी भाषा में)।';

  @override
  String get skipRetelling => 'पुनर्कथन छोड़ें';

  @override
  String get continueToQuestions => 'प्रश्नों पर जाएं';

  @override
  String get questionsTitle => 'प्रश्न';

  @override
  String get dictationTitle => 'श्रुतलेख';

  @override
  String get dictationSubtitle =>
      'प्रत्येक शब्द शिक्षक को \'सही लिखा\' और \'गलत लिखा\' विकल्पों के साथ दिखाया जाता है।';

  @override
  String get skipDictation => 'श्रुतलेख छोड़ें';

  @override
  String get saveAndSeeResult => 'सुरक्षित करें और परिणाम देखें';

  @override
  String get seeTheResult => 'परिणाम देखें';

  @override
  String get continueToDictation => 'श्रुतलेख पर जाएं';

  @override
  String get listeningCheckTitle => 'श्रवण जांच';

  @override
  String get resultsTitle => 'परिणाम सीधे शब्दों में';

  @override
  String officialTarget(Object source) {
    return 'आधिकारिक मानक ($source)';
  }

  @override
  String get suggestedGroup => 'सुझाया गया समूह';

  @override
  String get readingSpeed => 'पठन गति';

  @override
  String get readingAccuracy => 'पठन शुद्धता';

  @override
  String get understandingScore => 'समझ';

  @override
  String get writingScore => 'लेखन';

  @override
  String wordsPerMinute(Object wpm) {
    return '$wpm शब्द प्रति मिनट';
  }

  @override
  String get nextTeachingStep => 'शिक्षण का अगला कदम';

  @override
  String get printPracticeSheet => 'अभ्यास पत्रक प्रिंट करें';

  @override
  String get checkNextStudent => 'अगले बच्चे की जांच करें';

  @override
  String get notEnoughEvidence =>
      'पर्याप्त साक्ष्य नहीं: पढ़ाई सुनी या जाँची नहीं जा सकी';

  @override
  String get correctAMarking => 'कुछ गलत लगा? अंकन सुधारें';

  @override
  String get samajhRubricProvisional => 'समझ रूब्रिक v0.1 (अनंतिम)';

  @override
  String get backToClass => 'कक्षा पर लौटें';

  @override
  String get demoModeBanner => 'डेमो मोड: सभी बच्चे और परिणाम काल्पनिक हैं।';

  @override
  String get realModeBanner =>
      'वास्तविक कक्षा मोड: कानूनी समीक्षा लंबित है जब तक समीक्षक दर्ज न हो।';

  @override
  String get realModeBannerApproved => 'वास्तविक कक्षा मोड';

  @override
  String get switchToRealMode => 'वास्तविक कक्षा मोड चालू करें';

  @override
  String get switchToDemoMode => 'डेमो कक्षा पर लौटें';

  @override
  String get legalReviewPending =>
      'कानूनी समीक्षा लंबित: DPDP अनुरूप अभिकल्पित';

  @override
  String get resetDemoClass => 'डेमो कक्षा रीसेट करें';

  @override
  String get privacyChecklistTitle => 'गोपनीयता चेकलिस्ट';

  @override
  String get privacyChecklistSubtitle =>
      'वास्तविक कक्षा मोड सक्षम करने से पहले, प्रत्येक बिंदु की पुष्टि करें:';

  @override
  String get privacyChecklist1 =>
      'किसी भी जांच से पहले प्रत्येक बच्चे के लिए अभिभावक सहमति दर्ज की जाएगी';

  @override
  String get privacyChecklist2 => 'फ़ोन में स्क्रीन लॉक सक्रिय है';

  @override
  String get privacyChecklist4 =>
      'बच्चों के डेटा के लिए स्कूल की कानूनी और डेटा-सुरक्षा समीक्षा लंबित या पूर्ण समझी जाती है';

  @override
  String get screenPinningTip =>
      'सुझाव: एंड्रॉइड स्क्रीन पिनिंग चालू करें ताकि बच्चा ऐप से बाहर न जा सके।';

  @override
  String passageLabel(Object title) {
    return 'गद्यांश: $title';
  }

  @override
  String passageWordCountAndLevel(Object level, Object words) {
    return 'कुल शब्द: $words · स्तर: $level';
  }

  @override
  String consentRequiredBeforeCheck(Object name) {
    return 'जांच शुरू करने से पहले $name के लिए अभिभावक सहमति दर्ज होनी चाहिए।';
  }

  @override
  String get questionsSubtitle =>
      'प्रत्येक प्रश्न बोलकर पूछें। बच्चे के अपने शब्दों और भाषा में उत्तर स्वीकार करें।';

  @override
  String expectedAnswerPrefix(Object answer) {
    return 'उत्तर जैसे: $answer';
  }

  @override
  String get answerCorrect => 'सही';

  @override
  String get answerPartly => 'आंशिक';

  @override
  String get answerNotCorrect => 'गलत';

  @override
  String get answerNoAnswer => 'उत्तर नहीं दिया';

  @override
  String get answerNotAsked => 'नहीं पूछा';

  @override
  String get questionTypeFact => 'पाठ पर आधारित तथ्य';

  @override
  String get questionTypeWhyHow => 'कारण और प्रक्रिया';

  @override
  String get questionTypeMainIdea => 'मुख्य विचार';

  @override
  String get questionTypeWordMeaning => 'शब्दार्थ';

  @override
  String get questionTypeCauseEffect => 'कारण और प्रभाव';

  @override
  String get incorrectPasscode => 'गलत पासकोड';

  @override
  String get scrollDownToReadMore => 'और पढ़ने के लिए नीचे स्क्रॉल करें';

  @override
  String get wordCheckTitle => 'शब्द जांच';

  @override
  String get wordCheckSubtitle => 'देखें, सुनें और सही विकल्प चुनें';

  @override
  String get playCue => 'सुनें';

  @override
  String get notSureButton => 'मुझे नहीं पता';

  @override
  String wordCheckLevel(int level) {
    return 'स्तर $level';
  }

  @override
  String get writingPositionItemTitle => 'कॉपी की लाइन पर कौन सा सही लिखा है?';

  @override
  String get spellingItemTitle => 'सही वर्तनी चुनें';

  @override
  String get soundMatchItemTitle => 'सुनी गई आवाज़ से कौन सा मेल खाता है?';

  @override
  String get fillBlankItemTitle => 'रिक्त स्थान के लिए सबसे सही शब्द चुनें';

  @override
  String get oddOneOutItemTitle => 'इनमें से कौन सा अलग है?';

  @override
  String get meaningInferenceItemTitle => 'कहानी के अनुसार इसका क्या अर्थ है?';

  @override
  String get sentenceMatchItemTitle => 'चित्र से कौन सा वाक्य मेल खाता है?';

  @override
  String get eventSequenceItemTitle => 'पहले क्या हुआ?';

  @override
  String levelPromotedMessage(int level) {
    return 'स्तर $level पूर्ण! आगे बढ़ रहे हैं।';
  }

  @override
  String itemWordTag(int index) {
    return '$index. शब्द';
  }

  @override
  String itemSentenceTag(int index) {
    return '$index. वाक्य';
  }

  @override
  String get writtenCorrectly => 'सही लिखा';

  @override
  String get notCorrect => 'गलत लिखा';

  @override
  String givePhoneToTitle(String name) {
    return 'फ़ोन $name को दें।';
  }

  @override
  String givePhoneToSubtitle(String name) {
    return 'जब तक $name फ़ोन का उपयोग कर रहा है, शिक्षक स्क्रीन लॉक रहेगी। वापस आने के लिए, शिक्षक पर टैप करें और अपना पासकोड दर्ज करें।';
  }

  @override
  String get originalPassageReviewNote =>
      'मूल समझ गद्यांश, शिक्षक समीक्षा की प्रतीक्षा में';

  @override
  String get roomTooNoisyWarning =>
      'यहाँ बहुत शोर है। किसी शांत जगह पर जाएं, या जारी रखें: परिणाम कम विश्वास का माना जाएगा।';

  @override
  String get roomQuietNotice => 'कमरे में शांति है। रिकॉर्डिंग के लिए उपयुक्त।';

  @override
  String get notEnoughEvidenceTitle =>
      'पर्याप्त साक्ष्य नहीं: पढ़ाई सुनी या जाँची नहीं जा सकी।';

  @override
  String get lowConfidenceExplanation =>
      'कम विश्वास: कई शब्द स्पष्ट नहीं थे या कमरे में शोर था। निर्णय लेने से पहले दोबारा जाँच करें।';

  @override
  String get readingSection => 'पढ़ना';

  @override
  String get understandingSection => 'समझ';

  @override
  String get writingDictationSection => 'लेखन (श्रुतलेख)';

  @override
  String accuracyPercent(int percent) {
    return 'सटीकता $percent%';
  }

  @override
  String correctWordsPerMinute(int wpm) {
    return '$wpm सही शब्द प्रति मिनट';
  }

  @override
  String readingBreakdown(int skipped, int misread, int selfCorrected) {
    return '$skipped छोड़े गए · $misread अलग पढ़े गए · $selfCorrected स्वतः सुधारे';
  }

  @override
  String flsBenchmarkAbove(Object grade) {
    return 'FLS 2022, कक्षा $grade बेंचमार्क: न्यूनतम स्तर से ऊपर';
  }

  @override
  String flsBenchmarkMeets(Object grade) {
    return 'FLS 2022, कक्षा $grade बेंचमार्क: न्यूनतम स्तर के अनुसार';
  }

  @override
  String flsBenchmarkBelow(Object grade) {
    return 'FLS 2022, कक्षा $grade बेंचमार्क: न्यूनतम स्तर से नीचे';
  }

  @override
  String get nipunReached =>
      'UP NIPUN H306: कम से कम 60 शब्द प्रति मिनट: हासिल किया';

  @override
  String get nipunNotReached =>
      'UP NIPUN H306: कम से कम 60 शब्द प्रति मिनट: हासिल नहीं हुआ';

  @override
  String get accuracyGuideNote =>
      '90% सटीकता गाइड एक समझ अनंतिम सीमा है, कोई आधिकारिक मानक नहीं।';

  @override
  String storyRetoldScore(int ticked, int total) {
    return 'कहानी पुनः सुनाई: $total में से $ticked';
  }

  @override
  String dictationScoreSummary(int correct, int total) {
    return '$total में से $correct शब्द सही लिखे गए';
  }

  @override
  String get dictationSkippedSummary => 'श्रुतलेख छोड़ दिया गया';

  @override
  String get profileTitle => 'शिक्षक प्रोफ़ाइल';

  @override
  String get teacherNameLabel => 'शिक्षक का नाम';

  @override
  String get teacherNameHint => 'जैसे: सुनीता शर्मा';

  @override
  String get schoolNameLabel => 'विद्यालय का नाम (वैकल्पिक)';

  @override
  String get schoolNameHint => 'जैसे: प्राथमिक विद्यालय रामपुर';

  @override
  String get preferredLanguageLabel => 'पसंदीदा ऐप भाषा';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get changePasscode => 'पासकोड बदलें';

  @override
  String get changeLanguage => 'ऐप भाषा बदलें';

  @override
  String get profileUpdated => 'प्रोफ़ाइल अपडेट हो गई';

  @override
  String get classesITeach => 'कक्षाएं जो मैं पढ़ाता/पढ़ाती हूँ';

  @override
  String get addClassButton => 'कक्षा जोड़ें';

  @override
  String studentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count विद्यार्थी',
      one: '1 विद्यार्थी',
      zero: 'कोई विद्यार्थी नहीं',
    );
    return '$_temp0';
  }

  @override
  String get noPendingReviews => 'समीक्षा के लिए कोई जांच लंबित नहीं है';

  @override
  String get noRechecksDue => 'कोई पुनः जांच देय नहीं है';

  @override
  String get startCheckShortcuts => 'जांच शुरू करें';

  @override
  String get switchClass => 'कक्षा बदलें';

  @override
  String activeClassChip(String name) {
    return 'सक्रिय: $name';
  }

  @override
  String get shareAction => 'शेयर करें';

  @override
  String get printAction => 'प्रिंट करें';

  @override
  String get shareWarningNote =>
      'साझा की गई फ़ाइलें इस फ़ोन से बाहर जाती हैं। केवल सुरक्षित माध्यमों से साझा करें।';

  @override
  String get parentReportApprovalPrompt =>
      'मैं इस रिपोर्ट को अभिभावक के साथ साझा करने की स्वीकृति देता/देती हूँ';

  @override
  String get parentReportApprovalRequired =>
      'अभिभावक रिपोर्ट प्रिंट या शेयर करने से पहले शिक्षक की स्वीकृति आवश्यक है।';

  @override
  String unmarkedWordsCounter(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शब्द अभी जाँचे नहीं गए',
      one: '1 शब्द अभी जाँचा नहीं गया',
    );
    return '$_temp0';
  }

  @override
  String get markRemainingCorrect => 'शेष शब्दों को सही चिह्नित करें';

  @override
  String get confirmMarkRemainingTitle =>
      'क्या शेष शब्दों को सही चिह्नित करें?';

  @override
  String get confirmMarkRemainingBody =>
      'अंतिम पढ़े गए शब्द तक के सभी बिना जाँचे शब्द सही के रूप में चिह्नित किए जाएँगे।';

  @override
  String get unmarkedWordsWarning =>
      'कृपया अंतिम पढ़े गए शब्द तक सभी शब्दों को चिह्नित करें, या \'शेष शब्दों को सही चिह्नित करें\' दबाएं।';

  @override
  String get audioConsentWithdrawnMessage =>
      'ऑडियो रिकॉर्डिंग की सहमति वापस ले ली गई है। सेटिंग्स > गोपनीयता में सक्षम करने तक जांच में ऑडियो रिकॉर्ड नहीं किया जा सकता।';

  @override
  String get audioConsentTitle => 'माइक्रोफ़ोन और ऑडियो रिकॉर्डिंग';

  @override
  String get audioConsentDesc =>
      'शिक्षक समीक्षा के लिए बच्चे के पठन को रिकॉर्ड करने हेतु माइक्रोफ़ोन का उपयोग किया जाता है। रिकॉर्डिंग एन्क्रिप्टेड रहती है और जांचने के बाद मिटा दी जाती है।';

  @override
  String get audioConsentStatusGranted => 'अनुमति प्राप्त';

  @override
  String get audioConsentStatusWithdrawn => 'वापस ली गई';

  @override
  String get withdrawAudioConsent => 'ऑडियो सहमति वापस लें';

  @override
  String get grantAudioConsent => 'ऑडियो रिकॉर्डिंग की अनुमति दें';

  @override
  String get storageConsentTitle => 'स्थानीय एन्क्रिप्टेड डेटा सहमति';

  @override
  String get storageConsentDesc =>
      'विद्यालय से अनुमति मिलने तक बच्चों का डेटा केवल इसी डिवाइस पर सुरक्षित और एन्क्रिप्टेड रखा जाता है।';

  @override
  String get storageConsentGiven => 'स्वीकृत';

  @override
  String get markChildStoppedHere =>
      'बच्चा यहाँ रुक गया (बाकी को \'पहुँच नहीं\' चिह्नित करें)';

  @override
  String get questionsLevelHint =>
      'पहले स्तर 1 के प्रश्न पूछें। अगला स्तर तभी खुलेगा जब बच्चा इस स्तर के कम से कम आधे प्रश्न सही करे।';

  @override
  String questionLevelLabel(int level) {
    return 'स्तर $level';
  }

  @override
  String questionsStoppedAt(int level) {
    return 'प्रश्न स्तर $level पर रुकते हैं। कठिन प्रश्नों से पहले इसी स्तर का अभ्यास कराएँ।';
  }

  @override
  String questionsNextLocked(int level) {
    return 'यह स्तर पास होने पर स्तर $level खुलेगा।';
  }

  @override
  String questionTimeSeconds(int seconds) {
    return '$seconds सेकंड';
  }

  @override
  String get questionMarkFirst =>
      'परिणाम देखने के लिए हर खुले प्रश्न को अंकित करें।';

  @override
  String get childFeltLabel => 'बच्चे की अपनी राय:';

  @override
  String get typingSection => 'टाइपिंग जाँच (बच्चे ने शब्द लिखे)';

  @override
  String typingScoreLine(int correct, int total) {
    return '$total में से $correct शब्द सही लिखे';
  }

  @override
  String get typingSkipped => 'टाइपिंग जाँच नहीं हुई।';

  @override
  String typedWordRow(String target, String typed) {
    return '$target: लिखा $typed';
  }

  @override
  String typedWordNotSure(String target) {
    return '$target: पता नहीं';
  }

  @override
  String marksLine(String earned, String possible) {
    return 'अंक: $possible में से $earned';
  }

  @override
  String highestLevelPassed(int level) {
    return 'पास किया गया उच्चतम स्तर: स्तर $level';
  }

  @override
  String get levelOneNotPassed =>
      'स्तर 1 अभी पास नहीं हुआ। पहले स्तर 1 का अभ्यास कराएँ।';

  @override
  String get weightedMarkingNote =>
      'ऊँचे स्तर के प्रश्नों के अंक अधिक हैं। अपेक्षित समय से धीमे उत्तर को कम अंक मिलते हैं। ये भार अस्थायी हैं।';

  @override
  String get selfRatingSection => 'बच्चे की अपनी राय और परिणाम';

  @override
  String selfRatingCounts(int up, int down) {
    return '$up बार 👍, $down बार 👎';
  }

  @override
  String selfRatingUpButWrong(int count) {
    return 'अच्छा लगा पर उत्तर गलत था: $count';
  }

  @override
  String selfRatingDownButCorrect(int count) {
    return 'मुश्किल लगा पर उत्तर सही था: $count';
  }

  @override
  String selfRatingMatch(int percent) {
    return '$percent% बार बच्चे की राय परिणाम से मेल खाई।';
  }

  @override
  String get selfRatingNone => 'बच्चे ने कोई राय नहीं दी।';

  @override
  String get readingFeltGood => 'जाँच के अंत में: 👍';

  @override
  String get readingFeltHard => 'जाँच के अंत में: 👎';

  @override
  String get selfRatingNote =>
      'राय से पता चलता है कि बच्चा कैसा महसूस करता है। इनसे अंक नहीं बनते।';

  @override
  String greetingMorning(String name) {
    return 'सुप्रभात, $name';
  }

  @override
  String greetingAfternoon(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String greetingEvening(String name) {
    return 'शुभ संध्या, $name';
  }

  @override
  String todayClassesCount(int count) {
    return 'आज $count कक्षाएँ';
  }

  @override
  String get supportGroupsTitle => 'सहायता समूह';

  @override
  String get supportGroupsSubtitle =>
      'पिछली जाँच के अनुसार किसे किस तरह की मदद चाहिए';

  @override
  String get viewClassLink => 'कक्षा देखें';

  @override
  String get groupDecodingShort => 'शब्द पढ़ना';

  @override
  String get groupComprehensionShort => 'समझना';

  @override
  String get groupBothShort => 'दोनों';

  @override
  String classCheckedRing(int checked, int total) {
    return '$total में से $checked';
  }

  @override
  String get profileEditTitle => 'आपकी प्रोफ़ाइल';

  @override
  String get profileSectionAbout => 'आपके बारे में';

  @override
  String get profileFullName => 'पूरा नाम';

  @override
  String get profileFullNameRequired => 'कृपया अपना नाम लिखें';

  @override
  String get profileDisplayName => 'बच्चे आपको क्या कहते हैं';

  @override
  String get profileDisplayNameHint => 'जैसे: सुनीता जी';

  @override
  String get profileRole => 'आपकी भूमिका';

  @override
  String get roleTeacher => 'शिक्षक';

  @override
  String get roleHeadTeacher => 'प्रधानाध्यापक';

  @override
  String get roleParaTeacher => 'शिक्षा मित्र / अनुदेशक';

  @override
  String get roleOther => 'अन्य';

  @override
  String get profileSectionSchool => 'आपका विद्यालय';

  @override
  String get profileSchoolName => 'विद्यालय का नाम';

  @override
  String get profileUdise => 'UDISE कोड';

  @override
  String get profileUdiseError => 'UDISE कोड में 11 अंक होते हैं';

  @override
  String get profileBlock => 'ब्लॉक';

  @override
  String get profileDistrict => 'ज़िला';

  @override
  String get profileState => 'राज्य';

  @override
  String get stateRajasthan => 'राजस्थान';

  @override
  String get stateUttarPradesh => 'उत्तर प्रदेश';

  @override
  String get stateOther => 'अन्य';

  @override
  String get profileYears => 'पढ़ाने के वर्ष';

  @override
  String get profileYearsError => '0 से 60 तक की संख्या लिखें';

  @override
  String get profileSectionContact => 'संपर्क (वैकल्पिक)';

  @override
  String get profilePhone => 'मोबाइल नंबर';

  @override
  String get profilePhoneError => '10 अंकों का मोबाइल नंबर लिखें';

  @override
  String get profileEmail => 'ईमेल';

  @override
  String get profileEmailError => 'ईमेल इस तरह लिखें: name@example.com';

  @override
  String get profileStaysOnPhone =>
      'आपकी प्रोफ़ाइल केवल इसी फ़ोन में रहती है। यह कहीं नहीं भेजी जाती।';

  @override
  String get profileSaveButton => 'प्रोफ़ाइल सहेजें';

  @override
  String get profileDetailsTitle => 'विवरण';

  @override
  String get profileNotAdded => 'नहीं जोड़ा';

  @override
  String profileYearsValue(int count) {
    return '$count वर्ष';
  }

  @override
  String get profileCompleteCta => 'अपनी प्रोफ़ाइल पूरी करें';

  @override
  String todayOfTotalChecked(int total) {
    return '/ $total की जाँच हुई';
  }

  @override
  String todayNextChild(String name) {
    return 'अगला: $name';
  }

  @override
  String get todayEveryoneChecked => 'इस कक्षा में सबकी जाँच हो गई';

  @override
  String get todayNotCheckedYet => 'अभी समूह नहीं';

  @override
  String get selfRatingOverallUpWell => 'अच्छा लगा, और जाँच भी अच्छी रही।';

  @override
  String get selfRatingOverallUpHard =>
      'अच्छा लगा, पर जाँच के कुछ हिस्से कठिन थे। बच्चा शायद अभी अपनी गलतियाँ नहीं पहचान पाता।';

  @override
  String get selfRatingOverallDownWell =>
      'पक्का नहीं था, पर अच्छा किया। बच्चे को आत्मविश्वास की ज़रूरत हो सकती है।';

  @override
  String get selfRatingOverallDownHard =>
      'कठिन लगा, और सच में कठिन था। बच्चा जानता है कि उसे कहाँ मुश्किल होती है।';

  @override
  String get autoMarkListening => 'रिकॉर्डिंग सुनकर हर शब्द जाँचा जा रहा है…';

  @override
  String get autoMarkAllHeard =>
      'ऐप ने हर शब्द सही पढ़ा हुआ सुना। जाँचना हो तो रिकॉर्डिंग चलाएँ।';

  @override
  String autoMarkDone(int wrong, int check) {
    return 'ऐप ने पढ़ाई जाँच ली। उसके अनुसार $wrong शब्द गलत पढ़े गए। नारंगी घेरे वाले $check शब्द सुनें और जो अलग सुनाई दे, उसका निशान बदल दें।';
  }

  @override
  String get autoMarkFailed =>
      'ऐप यह रिकॉर्डिंग नहीं जाँच सका। कृपया सुनकर निशान लगाएँ।';

  @override
  String get autoMarkUnsupported =>
      'अपने-आप जाँच फ़ोन पर Android ऐप में ही चलती है। कृपया सुनकर निशान लगाएँ।';

  @override
  String get autoMarkNoRecording =>
      'रिकॉर्डिंग नहीं है, इसलिए ऐप जाँच नहीं कर सका। बच्चे के पढ़ते समय निशान लगाएँ।';

  @override
  String get autoMarkNote =>
      'निशान इसी फ़ोन पर चलने वाले बिना इंटरनेट के आवाज़-मॉडल से आते हैं। यह गलत हो सकता है, खासकर छोटे बच्चों की आवाज़ में, इसलिए आपकी जाँच ही अंतिम है।';

  @override
  String get autoMarkNothingHeard =>
      'ऐप को रिकॉर्डिंग में पाठ सुनाई नहीं दिया, इसलिए सभी शब्द \'नहीं पहुँचे\' हैं। रिकॉर्डिंग चलाकर सुनें और निशान लगाएँ।';

  @override
  String autoMarkStopped(int count) {
    return 'ऐप ने पहले $count शब्द सही पढ़े हुए सुने, फिर पढ़ना रुक गया। जाँचना हो तो रिकॉर्डिंग चलाएँ।';
  }

  @override
  String get lowConfidenceTitle => 'कम भरोसे वाला परिणाम';

  @override
  String get lowConfidenceNote =>
      'कमरे में शोर था या पढ़ाई बहुत छोटी थी, इसलिए पढ़ने की गति नहीं गिनी गई। बाकी परिणाम बच्चे के उत्तरों से बना है।';
}
