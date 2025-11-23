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
    return '$ayahKey के लिए तफ़सीर उपलब्ध नहीं है';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'तफ़सीर यहां मिलेगा: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey पर जाएं';
  }

  @override
  String get hizb => 'हिज़्ब';

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
  String get saveAndDownload => 'सेव और डाउनलोड करें';

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
  String get quranTafsirLanguage => 'कुरान तफ़सीर की भाषा';

  @override
  String get selectTafsirLanguage => 'तफ़सीर की भाषा चुनें...';

  @override
  String get quranTafsirBook => 'कुरान तफ़सीर की किताब';

  @override
  String get selectTafsirBook => 'तफ़सीर की किताब चुनें...';

  @override
  String get quranScriptAndStyle => 'कुरान स्क्रिप्ट और स्टाइल';

  @override
  String get justAMoment => 'बस एक पल...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'सफल';

  @override
  String get retry => 'फिर से कोशिश करें';

  @override
  String get unableToDownloadResources =>
      'रिसोर्स डाउनलोड करने में असमर्थ...\nकुछ गड़बड़ हो गई';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'सेगमेंटेड कुरान तिलावत डाउनलोड कर रहे हैं';

  @override
  String get processingSegmentedQuranRecitation =>
      'सेगमेंटेड कुरान तिलावत प्रोसेस कर रहे हैं';

  @override
  String get footnote => 'फुटनोट';

  @override
  String get tafsir => 'तफ़सीर';

  @override
  String get wordByWord => 'शब्द दर शब्द';

  @override
  String get pleaseSelectRequiredOption => 'कृपया जरूरी ऑप्शन चुनें';

  @override
  String get rememberHomeTab => 'होम टैब याद रखें';

  @override
  String get rememberHomeTabSubtitle =>
      'ऐप होम स्क्रीन में आखिरी खोले गए टैब को याद रखेगा।';

  @override
  String get wakeLock => 'वेक लॉक';

  @override
  String get wakeLockSubtitle => 'स्क्रीन को खुद बंद होने से रोकें।';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appTheme => 'ऐप थीम';

  @override
  String get quranStyle => 'कुरान स्टाइल';

  @override
  String get changeTheme => 'थीम बदलें';

  @override
  String get verseCount => 'आयतों की संख्या: ';

  @override
  String get translation => 'अनुवाद';

  @override
  String get tafsirNotFound => 'नहीं मिला';

  @override
  String get moreInfo => 'और जानकारी';

  @override
  String get playAudio => 'ऑडियो चलाएं';

  @override
  String get preview => 'पूर्वावलोकन';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get errorFetchingAddress => 'पता लाने में त्रुटि';

  @override
  String get addressNotAvailable => 'पता उपलब्ध नहीं';

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
  String get selectCalculationMethod => 'कैलकुलेशन मेथड चुनें';

  @override
  String get shareSelectAyahs => 'चुनी हुई आयतें शेयर करें';

  @override
  String get selectionEmpty => 'चयन खाली है';

  @override
  String get generatingImagePleaseWait =>
      'इमेज बना रहे हैं... कृपया इंतजार करें';

  @override
  String get asImage => 'इमेज के रूप में';

  @override
  String get asText => 'टेक्स्ट के रूप में';

  @override
  String get playFromSelectedAyah => 'चुनी हुई आयत से चलाएं';

  @override
  String get toTafsir => 'तफ़सीर पर';

  @override
  String get selectAyah => 'आयत चुनें';

  @override
  String get toAyah => 'आयत पर';

  @override
  String get searchForASurah => 'सूरह खोजें';

  @override
  String get bugReportTitle => 'बग रिपोर्ट';

  @override
  String get audioCached => 'ऑडियो कैश्ड';

  @override
  String get others => 'अन्य';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'कुरान|अनुवाद|आयत, एक को चालू रखना जरूरी है';

  @override
  String get quranFontSize => 'कुरान फॉन्ट साइज';

  @override
  String get quranLineHeight => 'कुरान लाइन हाइट';

  @override
  String get translationAndTafsirFontSize => 'अनुवाद और तफ़सीर फॉन्ट साइज';

  @override
  String get quranAyah => 'कुरान आयत';

  @override
  String get topToolbar => 'टॉप टूलबार';

  @override
  String get keepOpenWordByWord => 'शब्द दर शब्द खुला रखें';

  @override
  String get wordByWordHighlight => 'शब्द दर शब्द हाइलाइट';

  @override
  String get quranScriptSettings => 'कुरान स्क्रिप्ट सेटिंग्स';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'पेज: ';

  @override
  String get quranResources => 'कुरान रिसोर्स';

  @override
  String alreadySelected(String name) {
    return 'भाषा \'$name\' पहले से चुनी हुई है।';
  }

  @override
  String get unableToGetCompassData => 'कंपास डेटा पाने में असमर्थ';

  @override
  String get deviceDoesNotHaveSensors => 'डिवाइस में सेंसर नहीं हैं!';

  @override
  String get north => 'उत्तर';

  @override
  String get east => 'पूर्व';

  @override
  String get south => 'दक्षिण';

  @override
  String get west => 'पश्चिम';

  @override
  String get address => 'पता: ';

  @override
  String get change => 'बदलें';

  @override
  String get calculationMethod => 'कैलकुलेशन मेथड: ';

  @override
  String get downloadPrayerTime => 'नमाज के समय डाउनलोड करें';

  @override
  String get calculationMethodsListEmpty =>
      'कैलकुलेशन मेथड्स की लिस्ट खाली है।';

  @override
  String get noCalculationMethodWithLocationData =>
      'लोकेशन डेटा के साथ कोई कैलकुलेशन मेथड नहीं मिला।';

  @override
  String get prayerSettings => 'नमाज सेटिंग्स';

  @override
  String get reminderSettings => 'रिमाइंडर सेटिंग्स';

  @override
  String get adjustReminderTime => 'रिमाइंडर टाइम एडजस्ट करें';

  @override
  String get enforceAlarmSound => 'अलार्म साउंड को लागू करें';

  @override
  String get enforceAlarmSoundDescription =>
      'अगर चालू किया, तो यह फीचर अलार्म को यहां सेट वॉल्यूम पर बजाएगा, भले फोन का साउंड कम हो। इससे अलार्म मिस नहीं होगा।';

  @override
  String get volume => 'वॉल्यूम';

  @override
  String get atPrayerTime => 'नमाज के समय पर';

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
    return '$prayerName का समय हो गया है';
  }

  @override
  String get stopTheAdhan => 'अजान रोकें';

  @override
  String dateFoundEmpty(String date) {
    return '$date खाली मिला';
  }

  @override
  String get today => 'आज';

  @override
  String get left => 'बाकी';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName के लिए रिमाइंडर जोड़ा गया';
  }

  @override
  String get allowNotificationPermission =>
      'इस फीचर को इस्तेमाल करने के लिए नोटिफिकेशन परमिशन दें';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName का रिमाइंडर हटाया गया';
  }

  @override
  String get getPrayerTimesAndQibla => 'नमाज के समय और किबला पाएं';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'किसी भी लोकेशन के लिए नमाज के समय और किबला कैलकुलेट करें।';

  @override
  String get getFromGPS => 'जीपीएस से पाएं';

  @override
  String get or => 'या';

  @override
  String get selectYourCity => 'अपना शहर चुनें';

  @override
  String get noteAboutGPS =>
      'नोट: अगर आप जीपीएस इस्तेमाल नहीं करना चाहते या सुरक्षित नहीं लगता, तो अपना शहर चुन सकते हैं।';

  @override
  String get downloadingLocationResources =>
      'लोकेशन रिसोर्स डाउनलोड कर रहे हैं...';

  @override
  String get somethingWentWrong => 'कुछ गड़बड़ हो गई';

  @override
  String get selectYourCountry => 'अपना देश चुनें';

  @override
  String get searchForACountry => 'देश खोजें';

  @override
  String get selectYourAdministrator => 'अपना एडमिनिस्ट्रेटर चुनें';

  @override
  String get searchForAnAdministrator => 'एडमिनिस्ट्रेटर खोजें';

  @override
  String get searchForACity => 'शहर खोजें';

  @override
  String get pleaseEnableLocationService => 'कृपया लोकेशन सर्विस चालू करें';

  @override
  String get donateUs => 'हमें दान दें';

  @override
  String get underDevelopment => 'डेवलपमेंट में';

  @override
  String get versionLoading => 'लोड हो रहा है...';

  @override
  String get alQuran => 'अल कुरान';

  @override
  String get mainMenu => 'मेन मेन्यू';

  @override
  String get notes => 'नोट्स';

  @override
  String get pinned => 'पिन किए हुए';

  @override
  String get jumpToAyah => 'आयत पर जाएं';

  @override
  String get shareMultipleAyah => 'कई आयतें शेयर करें';

  @override
  String get shareThisApp => 'यह ऐप शेयर करें';

  @override
  String get giveRating => 'रेटिंग दें';

  @override
  String get bugReport => 'बग रिपोर्ट';

  @override
  String get privacyPolicy => 'प्राइवेसी पॉलिसी';

  @override
  String get aboutTheApp => 'ऐप के बारे में';

  @override
  String get resetTheApp => 'ऐप रीसेट करें';

  @override
  String get resetAppWarningTitle => 'ऐप डेटा रीसेट करें';

  @override
  String get resetAppWarningMessage =>
      'क्या आप ऐप रीसेट करना चाहते हैं? आपका सारा डेटा खो जाएगा, और आपको ऐप फिर से सेटअप करना पड़ेगा।';

  @override
  String get cancel => 'कैंसल';

  @override
  String get reset => 'रीसेट';

  @override
  String get shareAppSubject => 'यह अल कुरान ऐप देखें!';

  @override
  String shareAppBody(String appLink) {
    return 'अस्सलामुअलैकुम! यह अल कुरान ऐप रोज पढ़ने और सोचने के लिए देखें। यह अल्लाह के कलाम से जुड़ने में मदद करता है। यहां डाउनलोड करें: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ड्रावर खोलें';

  @override
  String get quran => 'कुरान';

  @override
  String get prayer => 'नमाज';

  @override
  String get qibla => 'किबला';

  @override
  String get audio => 'ऑडियो';

  @override
  String get surah => 'सूरह';

  @override
  String get pages => 'पेज';

  @override
  String get note => 'नोट:';

  @override
  String get linkedAyahs => 'लिंक्ड आयतें:';

  @override
  String get emptyNoteCollection =>
      'यह नोट कलेक्शन खाली है।\nयहां देखने के लिए कुछ नोट्स जोड़ें।';

  @override
  String get emptyPinnedCollection =>
      'इस कलेक्शन में अभी कोई आयत पिन नहीं की गई।\nदेखने के लिए आयतें पिन करें।';

  @override
  String get noContentAvailable => 'कोई कंटेंट उपलब्ध नहीं।';

  @override
  String failedToLoadCollections(String error) {
    return 'कलेक्शन लोड करने में फेल: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType नाम से खोजें...';
  }

  @override
  String get sortBy => 'सॉर्ट बाय';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'अभी कोई $collectionType नहीं जोड़ा गया';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count पिन किए हुए आइटम';
  }

  @override
  String notesCount(int count) {
    return '$count नोट्स';
  }

  @override
  String get emptyNameNotAllowed => 'खाली नाम allowed नहीं';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName में अपडेट किया गया';
  }

  @override
  String get changeName => 'नाम बदलें';

  @override
  String get changeColor => 'कलर बदलें';

  @override
  String get colorUpdated => 'कलर अपडेट किया गया';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName डिलीट किया गया';
  }

  @override
  String get delete => 'डिलीट';

  @override
  String get save => 'सेव';

  @override
  String get collectionNameCannotBeEmpty => 'कलेक्शन नाम खाली नहीं हो सकता।';

  @override
  String get addedNewCollection => 'नया कलेक्शन जोड़ा गया';

  @override
  String ayahCount(int count) {
    return '$count आयत';
  }

  @override
  String get byNameAtoZ => 'नाम A-Z';

  @override
  String get byNameZtoA => 'नाम Z-A';

  @override
  String get byElementNumberAscending => 'एलीमेंट नंबर बढ़ते क्रम में';

  @override
  String get byElementNumberDescending => 'एलीमेंट नंबर घटते क्रम में';

  @override
  String get byUpdateDateAscending => 'अपडेट डेट बढ़ते क्रम में';

  @override
  String get byUpdateDateDescending => 'अपडेट डेट घटते क्रम में';

  @override
  String get byCreateDateAscending => 'क्रिएट डेट बढ़ते क्रम में';

  @override
  String get byCreateDateDescending => 'क्रिएट डेट घटते क्रम में';

  @override
  String get translationNotFound => 'अनुवाद नहीं मिला';

  @override
  String get translationTitle => 'अनुवाद:';

  @override
  String get footNoteTitle => 'फुट नोट:';

  @override
  String get wordByWordTranslation => 'शब्द दर शब्द अनुवाद:';

  @override
  String get tafsirButton => 'तफ़सीर';

  @override
  String get shareButton => 'शेयर';

  @override
  String get addNoteButton => 'नोट जोड़ें';

  @override
  String get pinToCollectionButton => 'कलेक्शन में पिन करें';

  @override
  String get shareAsText => 'टेक्स्ट के रूप में शेयर करें';

  @override
  String get copiedWithTafsir => 'तफ़सीर के साथ कॉपी किया गया';

  @override
  String get shareAsImage => 'इमेज के रूप में शेयर करें';

  @override
  String get shareWithTafsir => 'तफ़सीर के साथ शेयर करें';

  @override
  String get notFound => 'नहीं मिला';

  @override
  String get noteContentCannotBeEmpty => 'नोट कंटेंट खाली नहीं हो सकता।';

  @override
  String get noteSavedSuccessfully => 'नोट सफलतापूर्वक सेव किया गया!';

  @override
  String get selectCollections => 'कलेक्शन चुनें';

  @override
  String get addNote => 'नोट जोड़ें';

  @override
  String get writeCollectionName => 'कलेक्शन नाम लिखें...';

  @override
  String get noCollectionsYetAddANewOne => 'अभी कोई कलेक्शन नहीं। नया जोड़ें!';

  @override
  String get pleaseWriteYourNoteFirst => 'कृपया पहले अपना नोट लिखें।';

  @override
  String get noCollectionSelected => 'कोई कलेक्शन चुना नहीं गया';

  @override
  String get saveNote => 'नोट सेव करें';

  @override
  String get nextSelectCollections => 'अगला: कलेक्शन चुनें';

  @override
  String get addToPinned => 'पिन में जोड़ें';

  @override
  String get pinnedSavedSuccessfully => 'पिन सफलतापूर्वक सेव किया गया!';

  @override
  String get savePinned => 'पिन सेव करें';

  @override
  String get closeAudioController => 'ऑडियो कंट्रोलर बंद करें';

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
    return 'स्टाइल: $style';
  }

  @override
  String get stopAndClose => 'रोकें और बंद करें';

  @override
  String get play => 'चलाएं';

  @override
  String get pause => 'पॉज';

  @override
  String get selectReciter => 'तिलावत करने वाला चुनें';

  @override
  String source(String source) {
    return 'सोर्स: $source';
  }

  @override
  String get newText => 'नया';

  @override
  String get more => 'और: ';

  @override
  String get cacheNotFound => 'कैश नहीं मिला';

  @override
  String get cacheSize => 'कैश साइज';

  @override
  String error(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get clean => 'साफ करें';

  @override
  String get lastModified => 'आखिरी बार बदला गया';

  @override
  String get oneYearAgo => '1 साल पहले';

  @override
  String monthsAgo(String number) {
    return '$number महीने पहले';
  }

  @override
  String weeksAgo(String number) {
    return '$number हफ्ते पहले';
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
  String get aboutAlQuran => 'अल कुरान के बारे में';

  @override
  String get appFullName => 'अल कुरान (तफ़सीर, नमाज, किबला, ऑडियो)';

  @override
  String get appDescription =>
      'एक पूरा इस्लामी ऐप एंड्रॉयड, आईओएस, मैकओएस, वेब, लिनक्स और विंडोज के लिए, जिसमें कुरान पढ़ना तफ़सीर और कई अनुवादों (शब्द दर शब्द सहित) के साथ, दुनिया भर में नमाज के समय नोटिफिकेशन के साथ, किबला कंपास, और शब्द दर शब्द ऑडियो तिलावत।';

  @override
  String get dataSourcesNote =>
      'नोट: कुरान टेक्स्ट, तफ़सीर, अनुवाद, और ऑडियो रिसोर्स Quran.com, Everyayah.com, और अन्य वेरीफाइड ओपन सोर्स से लिए गए हैं।';

  @override
  String get adFreePromise =>
      'यह ऐप अल्लाह की रजा के लिए बनाया गया है। इसलिए, यह हमेशा पूरी तरह से ऐड-फ्री रहेगा।';

  @override
  String get coreFeatures => 'मुख्य फीचर्स';

  @override
  String get coreFeaturesDescription =>
      'अल कुरान v3 के मुख्य फंक्शन देखें जो आपके रोज के इस्लामी अमलों के लिए जरूरी टूल है:';

  @override
  String get prayerTimesTitle => 'नमाज के समय और अलर्ट';

  @override
  String get prayerTimesDescription =>
      'दुनिया के किसी भी लोकेशन के लिए सटीक नमाज के समय विभिन्न कैलकुलेशन मेथड्स से। अजान नोटिफिकेशन के साथ रिमाइंडर सेट करें।';

  @override
  String get qiblaDirectionTitle => 'किबला दिशा';

  @override
  String get qiblaDirectionDescription =>
      'किबला दिशा आसानी से पाएं साफ और सटीक कंपास व्यू से।';

  @override
  String get translationTafsirTitle => 'कुरान अनुवाद और तफ़सीर';

  @override
  String get translationTafsirDescription =>
      '69 भाषाओं में 120+ अनुवाद किताबें (शब्द दर शब्द सहित), और 30+ तफ़सीर किताबें।';

  @override
  String get wordByWordAudioTitle => 'शब्द दर शब्द ऑडियो और हाइलाइटिंग';

  @override
  String get wordByWordAudioDescription =>
      'शब्द दर शब्द ऑडियो तिलावत और हाइलाइटिंग के साथ फॉलो करें सीखने के लिए।';

  @override
  String get ayahAudioRecitationTitle => 'आयत ऑडियो तिलावत';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ मशहूर कारी से पूरी आयत तिलावत सुनें।';

  @override
  String get notesCloudBackupTitle => 'नोट्स क्लाउड बैकअप के साथ';

  @override
  String get notesCloudBackupDescription =>
      'पर्सनल नोट्स और रिफ्लेक्शन सेव करें, क्लाउड में सिक्योर बैकअप (फीचर डेवलपमेंट में/जल्द आ रहा है)।';

  @override
  String get crossPlatformSupportTitle => 'क्रॉस-प्लेटफॉर्म सपोर्ट';

  @override
  String get crossPlatformSupportDescription =>
      'एंड्रॉयड, वेब, लिनक्स, और विंडोज पर सपोर्टेड।';

  @override
  String get backgroundAudioPlaybackTitle => 'बैकग्राउंड ऑडियो प्लेबैक';

  @override
  String get backgroundAudioPlaybackDescription =>
      'कुरान तिलावत सुनते रहें भले ऐप बैकग्राउंड में हो।';

  @override
  String get audioDataCachingTitle => 'ऑडियो और डेटा कैशिंग';

  @override
  String get audioDataCachingDescription =>
      'बेहतर प्लेबैक और ऑफलाइन कैपेबिलिटी ऑडियो और कुरान डेटा कैशिंग से।';

  @override
  String get minimalisticInterfaceTitle => 'मिनिमलिस्टिक और क्लीन इंटरफेस';

  @override
  String get minimalisticInterfaceDescription =>
      'आसान नेविगेशन इंटरफेस यूजर एक्सपीरियंस और पढ़ने पर फोकस के साथ।';

  @override
  String get optimizedPerformanceTitle => 'ऑप्टिमाइज्ड परफॉर्मेंस और साइज';

  @override
  String get optimizedPerformanceDescription =>
      'फीचर-रिच ऐप जो लाइटवेट और परफॉर्मेंट है।';

  @override
  String get languageSupport => 'भाषा सपोर्ट';

  @override
  String get languageSupportDescription =>
      'यह ऐप ग्लोबल ऑडियंस के लिए डिजाइन किया गया है इन भाषाओं में सपोर्ट के साथ (और और जोड़े जा रहे हैं):';

  @override
  String get technologyAndResources => 'टेक्नोलॉजी और रिसोर्स';

  @override
  String get technologyAndResourcesDescription =>
      'यह ऐप कटिंग-एज टेक्नोलॉजी और भरोसेमंद रिसोर्स से बना है:';

  @override
  String get flutterFrameworkTitle => 'फ्लटर फ्रेमवर्क';

  @override
  String get flutterFrameworkDescription =>
      'फ्लटर से बना ब्यूटीफुल, नेटिवली कंपाइल्ड, मल्टी-प्लेटफॉर्म एक्सपीरियंस सिंगल कोडबेस से।';

  @override
  String get advancedAudioEngineTitle => 'एडवांस्ड ऑडियो इंजन';

  @override
  String get advancedAudioEngineDescription =>
      'just_audio और just_audio_background फ्लटर पैकेज से पावर्ड रॉबस्ट ऑडियो प्लेबैक और कंट्रोल के लिए।';

  @override
  String get reliableQuranDataTitle => 'भरोसेमंद कुरान डेटा';

  @override
  String get reliableQuranDataDescription =>
      'अल कुरान टेक्स्ट, अनुवाद, तफ़सीर, और ऑडियो वेरीफाइड ओपन APIs और डेटाबेस जैसे Quran.com & Everyayah.com से।';

  @override
  String get prayerTimeEngineTitle => 'नमाज टाइम इंजन';

  @override
  String get prayerTimeEngineDescription =>
      'सटीक नमाज समय के लिए स्थापित कैलकुलेशन मेथड्स इस्तेमाल करता है। नोटिफिकेशन flutter_local_notifications और बैकग्राउंड टास्क से हैंडल।';

  @override
  String get crossPlatformSupport => 'क्रॉस प्लेटफॉर्म सपोर्ट';

  @override
  String get crossPlatformSupportDescription2 =>
      'विभिन्न प्लेटफॉर्म पर सीमलेस एक्सेस का मजा लें:';

  @override
  String get android => 'एंड्रॉयड';

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
  String get ourLifetimePromise => 'हमारा लाइफटाइम प्रॉमिस';

  @override
  String get lifetimePromiseDescription =>
      'मैं पर्सनली इस ऐप को अपनी जिंदगी भर सपोर्ट और मेंटेनेंस देने का वादा करता हूं, इंशा अल्लाह। मेरा गोल है कि यह ऐप उम्माह के लिए सालों तक फायदेमंद रिसोर्स बने।';

  @override
  String get fajr => 'फज्र';

  @override
  String get sunrise => 'सूर्योदय';

  @override
  String get dhuhr => 'जुहर';

  @override
  String get asr => 'अस्र';

  @override
  String get maghrib => 'मग़रिब';

  @override
  String get isha => 'इशा';

  @override
  String get midnight => 'आधी रात';

  @override
  String get alarm => 'अलार्म';

  @override
  String get notification => 'नोटिफिकेशन';

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
  String get required => 'जरूरी';

  @override
  String get optional => 'ऑप्शनल';

  @override
  String get notificationScheduleWarning =>
      'नोट: शेड्यूल्ड नोटिफिकेशन या रिमाइंडर आपके फोन के OS बैकग्राउंड प्रोसेस रेस्ट्रिक्शन से मिस हो सकते हैं। उदाहरण: Vivo का Origin OS, Samsung का One UI, Oppo का ColorOS आदि कभी-कभी शेड्यूल्ड नोटिफिकेशन या रिमाइंडर को किल कर देते हैं। कृपया अपने OS सेटिंग्स चेक करें ऐप को बैकग्राउंड प्रोसेस से रेस्ट्रिक्ट न करने के लिए।';

  @override
  String get scrollWithRecitation => 'तिलावत के साथ स्क्रॉल';

  @override
  String get quickAccess => 'क्विक एक्सेस';

  @override
  String get initiallyScrollAyah => 'शुरुआत में आयत पर स्क्रॉल';

  @override
  String get tajweedGuide => 'तजवीद गाइड';

  @override
  String get scrollWithRecitationDesc =>
      'चालू करने पर, कुरान आयत ऑडियो तिलावत के साथ ऑटोमैटिक स्क्रॉल होगी।';

  @override
  String get configuration => 'कॉन्फिगरेशन';

  @override
  String get restoreFromBackup => 'बैकअप से रिस्टोर';

  @override
  String get history => 'हिस्ट्री';

  @override
  String get search => 'खोजें';

  @override
  String get useAudioStream => 'ऑडियो स्ट्रीम इस्तेमाल करें';

  @override
  String get useAudioStreamDesc =>
      'ऑडियो इंटरनेट से डायरेक्ट स्ट्रीम करें डाउनलोड करने की बजाय।';

  @override
  String get notUseAudioStreamDesc =>
      'ऑफलाइन इस्तेमाल के लिए ऑडियो डाउनलोड करें और डेटा कम खर्च करें।';

  @override
  String get audioSettings => 'ऑडियो सेटिंग्स';

  @override
  String get playbackSpeed => 'प्लेबैक स्पीड';

  @override
  String get playbackSpeedDesc => 'कुरान तिलावत की स्पीड एडजस्ट करें।';

  @override
  String get waitForCurrentDownloadToFinish =>
      'कृपया करंट डाउनलोड खत्म होने का इंतजार करें।';

  @override
  String get areYouSure => 'क्या आप श्योर हैं?';

  @override
  String get checkYourInternetConnection => 'अपना इंटरनेट कनेक्शन चेक करें।';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount आयतों में से $requiredDownload डाउनलोड करने की जरूरत है।';
  }

  @override
  String get download => 'डाउनलोड';

  @override
  String get audioDownload => 'ऑडियो डाउनलोड';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'कुरान स्क्रिप्ट ऑप्टिमाइज कर रहे हैं';

  @override
  String get supportOnGithub => 'गिटहब पर समर्थन करें';
}
