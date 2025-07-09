// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple ( $nameArabic ) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey के लिए तफ़्सीर उपलब्ध नहीं है';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'तफ़्सीर यहाँ मिलेगी: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey पर जाएं';
  }

  @override
  String get hizb => 'हिज्ब';

  @override
  String get juz => 'जुज़';

  @override
  String get page => 'पेज';

  @override
  String get ruku => 'रुकू';

  @override
  String get languageSettings => 'भाषा सेटिंग्स';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count आयतें';
  }

  @override
  String get saveAndDownload => 'सहेजें और डाउनलोड करें';

  @override
  String get appLanguage => 'ऐप की भाषा';

  @override
  String get selectAppLanguage => 'ऐप की भाषा चुनें...';

  @override
  String get pleaseSelectOne => 'कृपया एक चुनें';

  @override
  String get quranTranslationLanguage => 'कुरान अनुवाद की भाषा';

  @override
  String get selectTranslationLanguage => 'अनुवाद की भाषा चुनें...';

  @override
  String get quranTranslationBook => 'कुरान अनुवाद की किताब';

  @override
  String get selectTranslationBook => 'अनुवाद की किताब चुनें...';

  @override
  String get quranTafsirLanguage => 'कुरान तफ़्सीर की भाषा';

  @override
  String get selectTafsirLanguage => 'तफ़्सीर की भाषा चुनें...';

  @override
  String get quranTafsirBook => 'कुरान तफ़्सीर की किताब';

  @override
  String get selectTafsirBook => 'तफ़्सीर की किताब चुनें...';

  @override
  String get quranScriptAndStyle => 'कुरान लिपि और शैली';

  @override
  String get justAMoment => 'बस एक पल...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'सफल';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get unableToDownloadResources =>
      'संसाधन डाउनलोड करने में असमर्थ...\nकुछ गलत हो गया';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'खंडित कुरान तिलावत डाउनलोड हो रही है';

  @override
  String get processingSegmentedQuranRecitation =>
      'खंडित कुरान तिलावत संसाधित हो रही है';

  @override
  String get footnote => 'फुटनोट';

  @override
  String get tafsir => 'तफ़्सीर';

  @override
  String get wordByWord => 'शब्द-दर-शब्द';

  @override
  String get pleaseSelectRequiredOption => 'कृपया आवश्यक विकल्प चुनें';

  @override
  String get rememberHomeTab => 'होम टैब याद रखें';

  @override
  String get rememberHomeTabSubtitle =>
      'ऐप होम स्क्रीन में अंतिम खोले गए टैब को याद रखेगा।';

  @override
  String get wakeLock => 'स्क्रीन को जगाए रखें';

  @override
  String get wakeLockSubtitle =>
      'स्क्रीन को स्वचालित रूप से बंद होने से रोकें।';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appTheme => 'ऐप की थीम';

  @override
  String get quranStyle => 'कुरान की शैली';

  @override
  String get changeTheme => 'थीम बदलें';

  @override
  String get verseCount => 'आयतों की संख्या: ';

  @override
  String get translation => 'अनुवाद';

  @override
  String get tafsirNotFound => 'नहीं मिला';

  @override
  String get moreInfo => 'अधिक जानकारी';

  @override
  String get playAudio => 'ऑडियो चलाएं';

  @override
  String get preview => 'पूर्वावलोकन';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get errorFetchingAddress => 'पता प्राप्त करने में त्रुटि';

  @override
  String get addressNotAvailable => 'पता उपलब्ध नहीं है';

  @override
  String get latitude => 'अक्षांश: ';

  @override
  String get longitude => 'देशांतर: ';

  @override
  String get name => 'नाम: ';

  @override
  String get location => 'स्थान: ';

  @override
  String get parameters => 'पैरामीटर: ';

  @override
  String get selectCalculationMethod => 'गणना विधि चुनें';

  @override
  String get shareSelectAyahs => 'चुनी हुई आयतें साझा करें';

  @override
  String get selectionEmpty => 'चयन खाली है';

  @override
  String get generatingImagePleaseWait =>
      'छवि बनायी जा रही है... कृपया प्रतीक्षा करें';

  @override
  String get asImage => 'छवि के रूप में';

  @override
  String get asText => 'पाठ के रूप में';

  @override
  String get playFromSelectedAyah => 'चुनी हुई आयत से चलाएं';

  @override
  String get toTafsir => 'तफ़्सीर पर जाएं';

  @override
  String get selectAyah => 'आयत चुनें';

  @override
  String get toAyah => 'आयत पर जाएं';

  @override
  String get searchForASurah => 'एक सूरह खोजें';

  @override
  String get bugReportTitle => 'बग रिपोर्ट';

  @override
  String get audioCached => 'ऑडियो कैश किया गया';

  @override
  String get others => 'अन्य';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'कुरान|अनुवाद|आयत, एक को सक्षम होना चाहिए';

  @override
  String get quranFontSize => 'कुरान फ़ॉन्ट का आकार';

  @override
  String get quranLineHeight => 'कुरान लाइन की ऊंचाई';

  @override
  String get translationAndTafsirFontSize => 'अनुवाद और तफ़्सीर फ़ॉन्ट का आकार';

  @override
  String get quranAyah => 'कुरान की आयत';

  @override
  String get topToolbar => 'ऊपरी टूलबार';

  @override
  String get keepOpenWordByWord => 'शब्द-दर-शब्द खुला रखें';

  @override
  String get wordByWordHighlight => 'शब्द-दर-शब्द हाइलाइट';

  @override
  String get quranScriptSettings => 'कुरान लिपि सेटिंग्स';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'पेज: ';

  @override
  String get quranResources => 'कुरान संसाधन';

  @override
  String alreadySelected(String name) {
    return 'भाषा \'$name\' पहले से ही चयनित है।';
  }

  @override
  String get unableToGetCompassData => 'कम्पास डेटा प्राप्त करने में असमर्थ';

  @override
  String get deviceDoesNotHaveSensors => 'डिवाइस में सेंसर नहीं हैं!';

  @override
  String get north => 'उ';

  @override
  String get east => 'पू';

  @override
  String get south => 'द';

  @override
  String get west => 'प';

  @override
  String get address => 'पता: ';

  @override
  String get change => 'बदलें';

  @override
  String get calculationMethod => 'गणना विधि: ';

  @override
  String get downloadPrayerTime => 'नमाज़ का समय डाउनलोड करें';

  @override
  String get calculationMethodsListEmpty => 'गणना विधियों की सूची खाली है।';

  @override
  String get noCalculationMethodWithLocationData =>
      'स्थान डेटा के साथ कोई गणना विधि नहीं मिली।';

  @override
  String get prayerSettings => 'नमाज़ सेटिंग्स';

  @override
  String get reminderSettings => 'रिमाइंडर सेटिंग्स';

  @override
  String get adjustReminderTime => 'रिमाइंडर का समय समायोजित करें';

  @override
  String get enforceAlarmSound => 'अलार्म की ध्वनि को लागू करें';

  @override
  String get enforceAlarmSoundDescription =>
      'यदि सक्षम है, तो यह सुविधा आपके फ़ोन की ध्वनि कम होने पर भी, यहाँ निर्धारित वॉल्यूम पर अलार्म बजाएगी। यह सुनिश्चित करता है कि आप कम फ़ोन वॉल्यूम के कारण अलार्म से न चूकें।';

  @override
  String get volume => 'वॉल्यूम';

  @override
  String get atPrayerTime => 'नमाज़ के समय';

  @override
  String minBefore(int minutes) {
    return '$minutes मिनट पहले';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes मिनट बाद';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName का समय $prayerTime है';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'यह $prayerName का समय है';
  }

  @override
  String get stopTheAdhan => 'अज़ान रोकें';

  @override
  String dateFoundEmpty(String date) {
    return '$date खाली मिला';
  }

  @override
  String get today => 'आज';

  @override
  String get left => 'शेष';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName के लिए रिमाइंडर जोड़ा गया';
  }

  @override
  String get allowNotificationPermission =>
      'इस सुविधा का उपयोग करने के लिए कृपया अधिसूचना की अनुमति दें';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName के लिए रिमाइंडर हटा दिया गया';
  }

  @override
  String get getPrayerTimesAndQibla => 'नमाज़ का समय और क़िबला प्राप्त करें';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'किसी भी दिए गए स्थान के लिए नमाज़ का समय और क़िबला की गणना करें।';

  @override
  String get getFromGPS => 'जीपीएस से प्राप्त करें';

  @override
  String get or => 'या';

  @override
  String get selectYourCity => 'अपना शहर चुनें';

  @override
  String get noteAboutGPS =>
      'नोट: यदि आप जीपीएस का उपयोग नहीं करना चाहते हैं या सुरक्षित महसूस नहीं करते हैं, तो आप अपना शहर चुन सकते हैं।';

  @override
  String get downloadingLocationResources =>
      'स्थान संसाधन डाउनलोड हो रहे हैं...';

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get selectYourCountry => 'अपना देश चुनें';

  @override
  String get searchForACountry => 'एक देश खोजें';

  @override
  String get selectYourAdministrator => 'अपना राज्य चुनें';

  @override
  String get searchForAnAdministrator => 'एक राज्य खोजें';

  @override
  String get searchForACity => 'एक शहर खोजें';

  @override
  String get pleaseEnableLocationService => 'कृपया स्थान सेवा सक्षम करें';

  @override
  String get donateUs => 'हमें दान दें';

  @override
  String get underDevelopment => 'विकास के अधीन';

  @override
  String get versionLoading => 'लोड हो रहा है...';

  @override
  String get alQuran => 'अल-क़ुरान';

  @override
  String get mainMenu => 'मुख्य मेनू';

  @override
  String get notes => 'नोट्स';

  @override
  String get pinned => 'पिन किया हुआ';

  @override
  String get jumpToAyah => 'आयत पर जाएं';

  @override
  String get shareMultipleAyah => 'एक से अधिक आयतें साझा करें';

  @override
  String get shareThisApp => 'इस ऐप को साझा करें';

  @override
  String get giveRating => 'रेटिंग दें';

  @override
  String get bugReport => 'बग रिपोर्ट करें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get aboutTheApp => 'ऐप के बारे में';

  @override
  String get resetTheApp => 'ऐप को रीसेट करें';

  @override
  String get resetAppWarningTitle => 'ऐप डेटा रीसेट करें';

  @override
  String get resetAppWarningMessage =>
      'क्या आप वाकई ऐप को रीसेट करना चाहते हैं? आपका सारा डेटा खो जाएगा, और आपको ऐप को शुरू से सेट करना होगा।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get reset => 'रीसेट करें';

  @override
  String get shareAppSubject => 'इस अल-क़ुरान ऐप को देखें!';

  @override
  String shareAppBody(String appLink) {
    return 'अस्सलामुअलैकुम! दैनिक पढ़ने और चिंतन के लिए इस अल-कुरान ऐप को देखें। यह अल्लाह के शब्दों से जुड़ने में मदद करता है। यहाँ से डाउनलोड करें: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ड्रॉवर खोलें';

  @override
  String get quran => 'कुरान';

  @override
  String get prayer => 'नमाज़';

  @override
  String get qibla => 'क़िबला';

  @override
  String get audio => 'ऑडियो';

  @override
  String get surah => 'सूरह';

  @override
  String get pages => 'पेज';

  @override
  String get note => 'नोट:';

  @override
  String get linkedAyahs => 'जुड़ी हुई आयतें:';

  @override
  String get emptyNoteCollection =>
      'यह नोट संग्रह खाली है।\nउन्हें यहाँ देखने के लिए कुछ नोट्स जोड़ें।';

  @override
  String get emptyPinnedCollection =>
      'इस संग्रह में अभी तक कोई आयत पिन नहीं की गई है।\nउन्हें यहाँ देखने के लिए आयतें पिन करें।';

  @override
  String get noContentAvailable => 'कोई सामग्री उपलब्ध नहीं है।';

  @override
  String failedToLoadCollections(String error) {
    return 'संग्रह लोड करने में विफल: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType नाम से खोजें...';
  }

  @override
  String get sortBy => 'इसके अनुसार छांटें';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'अभी तक कोई $collectionType नहीं जोड़ा गया है';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count पिन किए गए आइटम';
  }

  @override
  String notesCount(int count) {
    return '$count नोट्स';
  }

  @override
  String get emptyNameNotAllowed => 'खाली नाम की अनुमति नहीं है';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName में अपडेट किया गया';
  }

  @override
  String get changeName => 'नाम बदलें';

  @override
  String get changeColor => 'रंग बदलें';

  @override
  String get colorUpdated => 'रंग अपडेट किया गया';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName हटा दिया गया';
  }

  @override
  String get delete => 'हटाएं';

  @override
  String get save => 'सहेजें';

  @override
  String get collectionNameCannotBeEmpty => 'संग्रह का नाम खाली नहीं हो सकता।';

  @override
  String get addedNewCollection => 'नया संग्रह जोड़ा गया';

  @override
  String ayahCount(int count) {
    return '$count आयत';
  }

  @override
  String get byNameAtoZ => 'नाम A-Z';

  @override
  String get byNameZtoA => 'नाम Z-A';

  @override
  String get byElementNumberAscending => 'तत्व संख्या आरोही';

  @override
  String get byElementNumberDescending => 'तत्व संख्या अवरोही';

  @override
  String get byUpdateDateAscending => 'अद्यतन तिथि आरोही';

  @override
  String get byUpdateDateDescending => 'अद्यतन तिथि अवरोही';

  @override
  String get byCreateDateAscending => 'निर्माण तिथि आरोही';

  @override
  String get byCreateDateDescending => 'निर्माण तिथि अवरोही';

  @override
  String get translationNotFound => 'अनुवाद नहीं मिला';

  @override
  String get translationTitle => 'अनुवाद:';

  @override
  String get footNoteTitle => 'फुटनोट:';

  @override
  String get wordByWordTranslation => 'शब्द-दर-शब्द अनुवाद:';

  @override
  String get tafsirButton => 'तफ़्सीर';

  @override
  String get shareButton => 'साझा करें';

  @override
  String get addNoteButton => 'नोट जोड़ें';

  @override
  String get pinToCollectionButton => 'संग्रह में पिन करें';

  @override
  String get shareAsText => 'पाठ के रूप में साझा करें';

  @override
  String get copiedWithTafsir => 'तफ़्सीर के साथ कॉपी किया गया';

  @override
  String get shareAsImage => 'छवि के रूप में साझा करें';

  @override
  String get shareWithTafsir => 'तफ़्सीर के साथ साझा करें';

  @override
  String get notFound => 'नहीं मिला';

  @override
  String get noteContentCannotBeEmpty => 'नोट की सामग्री खाली नहीं हो सकती।';

  @override
  String get noteSavedSuccessfully => 'नोट सफलतापूर्वक सहेजा गया!';

  @override
  String get selectCollections => 'संग्रह चुनें';

  @override
  String get addNote => 'नोट जोड़ें';

  @override
  String get writeCollectionName => 'संग्रह का नाम लिखें...';

  @override
  String get noCollectionsYetAddANewOne =>
      'अभी तक कोई संग्रह नहीं है। एक नया जोड़ें!';

  @override
  String get pleaseWriteYourNoteFirst => 'कृपया पहले अपना नोट लिखें।';

  @override
  String get noCollectionSelected => 'कोई संग्रह नहीं चुना गया';

  @override
  String get saveNote => 'नोट सहेजें';

  @override
  String get nextSelectCollections => 'अगला: संग्रह चुनें';

  @override
  String get addToPinned => 'पिन किए गए में जोड़ें';

  @override
  String get pinnedSavedSuccessfully => 'पिन सफलतापूर्वक सहेजा गया!';

  @override
  String get savePinned => 'पिन सहेजें';

  @override
  String get closeAudioController => 'ऑडियो नियंत्रक बंद करें';

  @override
  String get previous => 'पिछला';

  @override
  String get rewind => 'रिवाइंड';

  @override
  String get fastForward => 'फास्ट फॉरवर्ड';

  @override
  String get playNextAyah => 'अगली आयत चलाएं';

  @override
  String get repeat => 'दोहराएं';

  @override
  String get playAsPlaylist => 'प्लेलिस्ट के रूप में चलाएं';

  @override
  String style(String style) {
    return 'शैली: $style';
  }

  @override
  String get stopAndClose => 'रोकें और बंद करें';

  @override
  String get play => 'चलाएं';

  @override
  String get pause => 'रोकें';

  @override
  String get selectReciter => 'कारी चुनें';

  @override
  String source(String source) {
    return 'स्रोत: $source';
  }

  @override
  String get newText => 'नया';

  @override
  String get more => 'अधिक: ';

  @override
  String get cacheNotFound => 'कैश नहीं मिला';

  @override
  String get cacheSize => 'कैश का आकार';

  @override
  String error(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get clean => 'साफ़ करें';

  @override
  String get lastModified => 'अंतिम बार संशोधित';

  @override
  String get oneYearAgo => '1 वर्ष पहले';

  @override
  String monthsAgo(String number) {
    return '$number महीने पहले';
  }

  @override
  String weeksAgo(String number) {
    return '$number सप्ताह पहले';
  }

  @override
  String daysAgo(String number) {
    return '$number दिन पहले';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour घंटे पहले';
  }

  @override
  String get aboutAlQuran => 'अल-कुरान के बारे में';

  @override
  String get appFullName => 'अल-कुरान (तफ़्सीर, नमाज़, क़िबला, ऑडियो)';

  @override
  String get appDescription =>
      'एंड्रॉइड, आईओएस, मैकओएस, वेब, लिनक्स और विंडोज के लिए एक व्यापक इस्लामी एप्लिकेशन, जो तफ़्सीर और कई अनुवादों (शब्द-दर-शब्द सहित) के साथ कुरान पढ़ने, सूचनाओं के साथ दुनिया भर में नमाज़ के समय, क़िबला कंपास और सिंक्रनाइज़ शब्द-दर-शब्द ऑडियो पाठ की पेशकश करता है।';

  @override
  String get dataSourcesNote =>
      'नोट: कुरान के पाठ, तफ़्सीर, अनुवाद, और ऑडियो संसाधन Quran.com, Everyayah.com, और अन्य सत्यापित खुले स्रोतों से लिए गए हैं।';

  @override
  String get adFreePromise =>
      'यह ऐप अल्लाह की खुशी के लिए बनाया गया है। इसलिए, यह पूरी तरह से विज्ञापन-मुक्त है और हमेशा रहेगा।';

  @override
  String get coreFeatures => 'मुख्य विशेषताएं';

  @override
  String get coreFeaturesDescription =>
      'उन प्रमुख कार्यात्मकताओं का अन्वेषण करें जो अल-कुरान v3 को आपकी दैनिक इस्लामी प्रथाओं के लिए एक अनिवार्य उपकरण बनाती हैं:';

  @override
  String get prayerTimesTitle => 'नमाज़ का समय और अलर्ट';

  @override
  String get prayerTimesDescription =>
      'विभिन्न गणना विधियों का उपयोग करके दुनिया भर में किसी भी स्थान के लिए सटीक नमाज़ का समय। अज़ान सूचनाओं के साथ रिमाइंडर सेट करें।';

  @override
  String get qiblaDirectionTitle => 'क़िबला की दिशा';

  @override
  String get qiblaDirectionDescription =>
      'एक स्पष्ट और सटीक कंपास दृश्य के साथ आसानी से क़िबला की दिशा खोजें।';

  @override
  String get translationTafsirTitle => 'कुरान अनुवाद और तफ़्सीर';

  @override
  String get translationTafsirDescription =>
      '69 भाषाओं में 120+ अनुवाद पुस्तकें (शब्द-दर-शब्द सहित), और 30+ तफ़्सीर पुस्तकों तक पहुंचें।';

  @override
  String get wordByWordAudioTitle => 'शब्द-दर-शब्द ऑडियो और हाइलाइटिंग';

  @override
  String get wordByWordAudioDescription =>
      'एक गहन सीखने के अनुभव के लिए सिंक्रनाइज़ शब्द-दर-शब्द ऑडियो पाठ और हाइलाइटिंग के साथ अनुसरण करें।';

  @override
  String get ayahAudioRecitationTitle => 'आयत ऑडियो पाठ';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ से अधिक प्रसिद्ध कारियों से पूर्ण आयत पाठ सुनें।';

  @override
  String get notesCloudBackupTitle => 'क्लाउड बैकअप के साथ नोट्स';

  @override
  String get notesCloudBackupDescription =>
      'व्यक्तिगत नोट्स और प्रतिबिंब सहेजें, सुरक्षित रूप से क्लाउड पर बैकअप (सुविधा विकास में/जल्द ही आ रही है)।';

  @override
  String get crossPlatformSupportTitle => 'क्रॉस-प्लेटफ़ॉर्म समर्थन';

  @override
  String get crossPlatformSupportDescription =>
      'एंड्रॉइड, वेब, लिनक्स और विंडोज पर समर्थित।';

  @override
  String get backgroundAudioPlaybackTitle => 'बैकग्राउंड ऑडियो प्लेबैक';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ऐप बैकग्राउंड में होने पर भी कुरान पाठ सुनना जारी रखें।';

  @override
  String get audioDataCachingTitle => 'ऑडियो और डेटा कैशिंग';

  @override
  String get audioDataCachingDescription =>
      'मजबूत ऑडियो और कुरान डेटा कैशिंग के साथ बेहतर प्लेबैक और ऑफ़लाइन क्षमताएं।';

  @override
  String get minimalisticInterfaceTitle => 'न्यूनतम और स्वच्छ इंटरफ़ेस';

  @override
  String get minimalisticInterfaceDescription =>
      'उपयोगकर्ता अनुभव और पठनीयता पर ध्यान देने के साथ नेविगेट करने में आसान इंटरफ़ेस।';

  @override
  String get optimizedPerformanceTitle => 'अनुकूलित प्रदर्शन और आकार';

  @override
  String get optimizedPerformanceDescription =>
      'एक सुविधा संपन्न एप्लिकेशन जिसे हल्का और प्रदर्शन करने वाला बनाया गया है।';

  @override
  String get languageSupport => 'भाषा समर्थन';

  @override
  String get languageSupportDescription =>
      'यह एप्लिकेशन निम्नलिखित भाषाओं के समर्थन के साथ वैश्विक दर्शकों के लिए सुलभ होने के लिए डिज़ाइन किया गया है (और लगातार और भी जोड़े जा रहे हैं):';

  @override
  String get technologyAndResources => 'प्रौद्योगिकी और संसाधन';

  @override
  String get technologyAndResourcesDescription =>
      'यह ऐप अत्याधुनिक तकनीकों और विश्वसनीय संसाधनों का उपयोग करके बनाया गया है:';

  @override
  String get flutterFrameworkTitle => 'फ्लटर फ्रेमवर्क';

  @override
  String get flutterFrameworkDescription =>
      'एक ही कोडबेस से एक सुंदर, मूल रूप से संकलित, बहु-मंचीय अनुभव के लिए फ्लटर के साथ बनाया गया।';

  @override
  String get advancedAudioEngineTitle => 'उन्नत ऑडियो इंजन';

  @override
  String get advancedAudioEngineDescription =>
      'मजबूत ऑडियो प्लेबैक और नियंत्रण के लिए `just_audio` और `just_audio_background` फ्लटर पैकेज द्वारा संचालित।';

  @override
  String get reliableQuranDataTitle => 'विश्वसनीय कुरान डेटा';

  @override
  String get reliableQuranDataDescription =>
      'अल-कुरान के पाठ, अनुवाद, तफ़्सीर, और ऑडियो Quran.com और Everyayah.com जैसे सत्यापित खुले API और डेटाबेस से लिए गए हैं।';

  @override
  String get prayerTimeEngineTitle => 'नमाज़ समय इंजन';

  @override
  String get prayerTimeEngineDescription =>
      'सटीक नमाज़ समय के लिए स्थापित गणना विधियों का उपयोग करता है। सूचनाएं `flutter_local_notifications` और पृष्ठभूमि कार्यों द्वारा नियंत्रित होती हैं।';

  @override
  String get crossPlatformSupport => 'क्रॉस प्लेटफ़ॉर्म समर्थन';

  @override
  String get crossPlatformSupportDescription2 =>
      'विभिन्न प्लेटफार्मों पर निर्बाध पहुंच का आनंद लें:';

  @override
  String get android => 'एंड्रॉइड';

  @override
  String get ios => 'आईओएस';

  @override
  String get macos => 'मैकओएस';

  @override
  String get web => 'वेब';

  @override
  String get linux => 'लिनक्स';

  @override
  String get windows => 'विंडोज';

  @override
  String get ourLifetimePromise => 'हमारा आजीवन वादा';

  @override
  String get lifetimePromiseDescription =>
      'मैं व्यक्तिगत रूप से अपने पूरे जीवन में इस एप्लिकेशन के लिए निरंतर समर्थन और रखरखाव प्रदान करने का वादा करता हूं, इंशाअल्लाह। मेरा लक्ष्य यह सुनिश्चित करना है कि यह ऐप आने वाले वर्षों के लिए उम्मा के लिए एक फायदेमंद संसाधन बना रहे।';

  @override
  String get fajr => 'फज्र';

  @override
  String get sunrise => 'सूर्योदय';

  @override
  String get dhuhr => 'ज़ुहर';

  @override
  String get asr => 'असर';

  @override
  String get maghrib => 'मग़रिब';

  @override
  String get isha => 'ईशा';

  @override
  String get midnight => 'आधी रात';

  @override
  String get alarm => 'अलार्म';

  @override
  String get notification => 'अधिसूचना';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'तजवीद';

  @override
  String get quranScriptUthmani => 'उस्मानी';

  @override
  String get quranScriptIndopak => 'इंडोपाक';

  @override
  String get sajdaAyah => 'सजदा आयत';

  @override
  String get required => 'अनिवार्य';

  @override
  String get optional => 'वैकल्पिक';

  @override
  String get notificationScheduleWarning =>
      'नोट: आपके फ़ोन के OS बैकग्राउंड प्रोसेस प्रतिबंधों के कारण अनुसूचित अधिसूचना या अनुस्मारक छूट सकता है। उदाहरण के लिए: वीवो का ओरिजिन ओएस, सैमसंग का वन यूआई, ओप्पो का कलरओएस आदि कभी-कभी अनुसूचित अधिसूचना या अनुस्मारक को समाप्त कर देते हैं। कृपया ऐप को बैकग्राउंड प्रोसेस से प्रतिबंधित न करने के लिए अपनी ओएस सेटिंग्स जांचें।';
}
