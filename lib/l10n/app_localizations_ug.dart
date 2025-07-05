// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uighur Uyghur (`ug`).
class AppLocalizationsUg extends AppLocalizations {
  AppLocalizationsUg([String locale = 'ug']) : super(locale);

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
    return '$ayahKey ئۈچۈن تەپسىر يوق';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تەپسىرنى بۇ يەردىن تاپالايسىز: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey غا ئۆتۈش';
  }

  @override
  String get hizb => 'ھىزب';

  @override
  String get juz => 'جۈز';

  @override
  String get page => 'بەت';

  @override
  String get ruku => 'رۇكۇ';

  @override
  String get languageSettings => 'تىل تەڭشىكى';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count ئايەت';
  }

  @override
  String get saveAndDownload => 'ساقلاش ۋە چۈشۈرۈش';

  @override
  String get appLanguage => 'ئەپ تىلى';

  @override
  String get selectAppLanguage => 'ئەپ تىلىنى تاللاڭ...';

  @override
  String get pleaseSelectOne => 'بىرنى تاللاڭ';

  @override
  String get quranTranslationLanguage => 'قۇرئان تەرجىمە تىلى';

  @override
  String get selectTranslationLanguage => 'تەرجىمە تىلىنى تاللاڭ...';

  @override
  String get quranTranslationBook => 'قۇرئان تەرجىمە كىتابى';

  @override
  String get selectTranslationBook => 'تەرجىمە كىتابىنى تاللاڭ...';

  @override
  String get quranTafsirLanguage => 'قۇرئان تەپسىر تىلى';

  @override
  String get selectTafsirLanguage => 'تەپسىر تىلىنى تاللاڭ...';

  @override
  String get quranTafsirBook => 'قۇرئان تەپسىر كىتابى';

  @override
  String get selectTafsirBook => 'تەپسىر كىتابىنى تاللاڭ...';

  @override
  String get quranScriptAndStyle => 'قۇرئان خەت نۇسخىسى ۋە ئۇسلۇبى';

  @override
  String get justAMoment => 'سەل ساقلاڭ...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'مۇۋەپپەقىيەتلىك';

  @override
  String get retry => 'قايتا سىناش';

  @override
  String get unableToDownloadResources =>
      'مەنبەلەرنى چۈشۈرگىلى بولمىدى...\nخاتالىق كۆرۈلدى';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'بۆلەكلەنگەن قۇرئان تىلاۋىتى چۈشۈرۈلۈۋاتىدۇ';

  @override
  String get processingSegmentedQuranRecitation =>
      'بۆلەكلەنگەن قۇرئان تىلاۋىتى بىر تەرەپ قىلىنىۋاتىدۇ';

  @override
  String get footnote => 'ئىزاھات';

  @override
  String get tafsir => 'تەپسىر';

  @override
  String get wordByWord => 'سۆزمۇ-سۆز';

  @override
  String get pleaseSelectRequiredOption => 'كېرەكلىك تاللاشنى تاللاڭ';

  @override
  String get rememberHomeTab => 'باش بەتنى ئەستە تۇتۇش';

  @override
  String get rememberHomeTabSubtitle =>
      'ئەپ باش بەتتە ئەڭ ئاخىرقى قېتىم ئېچىلغان بەتنى ئەستە ساقلايدۇ.';

  @override
  String get wakeLock => 'ئېكراننى يورۇق تۇتۇش';

  @override
  String get wakeLockSubtitle =>
      'ئېكراننىڭ ئاپتوماتىك ئۆچۈپ قېلىشىنىڭ ئالدىنى ئالىدۇ.';

  @override
  String get settings => 'تەڭشەكلەر';

  @override
  String get appTheme => 'ئەپ باش تېمىسى';

  @override
  String get quranStyle => 'قۇرئان ئۇسلۇبى';

  @override
  String get changeTheme => 'باش تېمىنى ئۆزگەرتىش';

  @override
  String get verseCount => 'ئايەت سانى: ';

  @override
  String get translation => 'تەرجىمە';

  @override
  String get tafsirNotFound => 'تاپالمىدى';

  @override
  String get moreInfo => 'تېخىمۇ كۆپ مەلۇمات';

  @override
  String get playAudio => 'ئاۋاز قويۇش';

  @override
  String get preview => 'ئالدىن كۆرۈش';

  @override
  String get loading => 'يۈكلىنىۋاتىدۇ...';

  @override
  String get errorFetchingAddress => 'ئادرېسنى ئېلىشتا خاتالىق كۆرۈلدى';

  @override
  String get addressNotAvailable => 'ئادرېس يوق';

  @override
  String get latitude => 'كەڭلىك: ';

  @override
  String get longitude => 'ئۇزۇنلۇق: ';

  @override
  String get name => 'ئىسمى: ';

  @override
  String get location => 'ئورنى: ';

  @override
  String get parameters => 'پارامېتىرلار: ';

  @override
  String get selectCalculationMethod => 'ھېسابلاش ئۇسۇلىنى تاللاڭ';

  @override
  String get shareSelectAyahs => 'تاللانغان ئايەتلەرنى ھەمبەھىرلەش';

  @override
  String get selectionEmpty => 'تاللانمىدى';

  @override
  String get generatingImagePleaseWait =>
      'رەسىم ھاسىل قىلىنىۋاتىدۇ... سەل ساقلاڭ';

  @override
  String get asImage => 'رەسىم قىلىپ';

  @override
  String get asText => 'تېكىست قىلىپ';

  @override
  String get playFromSelectedAyah => 'تاللانغان ئايەتتىن باشلاپ قويۇش';

  @override
  String get toTafsir => 'تەپسىرگە';

  @override
  String get selectAyah => 'ئايەت تاللاش';

  @override
  String get toAyah => 'ئايەتكە';

  @override
  String get searchForASurah => 'سۈرە ئىزدەش';

  @override
  String get bugReportTitle => 'خاتالىق مەلۇم قىلىش';

  @override
  String get audioCached => 'ئاۋاز ساقلاندى';

  @override
  String get others => 'باشقىلار';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قۇرئان|تەرجىمە|ئايەت، كەم دېگەندە بىرسىنى تاللاش كېرەك';

  @override
  String get quranFontSize => 'قۇرئان خەت چوڭلۇقى';

  @override
  String get quranLineHeight => 'قۇرئان قۇر ئارىلىقى';

  @override
  String get translationAndTafsirFontSize => 'تەرجىمە ۋە تەپسىر خەت چوڭلۇقى';

  @override
  String get quranAyah => 'قۇرئان ئايىتى';

  @override
  String get topToolbar => 'يۇقىرى قورال ستونى';

  @override
  String get keepOpenWordByWord => 'سۆزمۇ-سۆز تەرجىمىنى ئوچۇق تۇتۇش';

  @override
  String get wordByWordHighlight => 'سۆزمۇ-سۆز يورۇتۇش';

  @override
  String get quranScriptSettings => 'قۇرئان خەت نۇسخىسى تەڭشىكى';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'بەت: ';

  @override
  String get quranResources => 'قۇرئan مەنبەلىرى';

  @override
  String alreadySelected(String name) {
    return '\'$name\' تىلى تاللىنىپ بولدى.';
  }

  @override
  String get unableToGetCompassData => 'كومپاس ئۇچۇرىنى ئالغىلى بولمىدى';

  @override
  String get deviceDoesNotHaveSensors => 'بۇ ئۈسكۈنىدە سېنزور يوق!';

  @override
  String get north => 'ش';

  @override
  String get east => 'ق';

  @override
  String get south => 'ج';

  @override
  String get west => 'غ';

  @override
  String get address => 'ئادرېس: ';

  @override
  String get change => 'ئۆزگەرتىش';

  @override
  String get calculationMethod => 'ھېسابلاش ئۇسۇلى: ';

  @override
  String get downloadPrayerTime => 'ناماز ۋاقىتلىرىنى چۈشۈرۈش';

  @override
  String get calculationMethodsListEmpty =>
      'ھېسابلاش ئۇسۇللىرى تىزىملىكى قۇرۇق.';

  @override
  String get noCalculationMethodWithLocationData =>
      'ئورۇن ئۇچۇرى بىلەن ھېچقانداق ھېسابلاش ئۇسۇلى تېپىلمىدى.';

  @override
  String get prayerSettings => 'ناماز تەڭشەكلىرى';

  @override
  String get reminderSettings => 'ئەسكەرتىش تەڭشەكلىرى';

  @override
  String get adjustReminderTime => 'ئەسكەرتىش ۋاقتىنى تەڭشەش';

  @override
  String get enforceAlarmSound => 'قوڭغۇراق ئاۋازىنى مەجبۇرىيلاش';

  @override
  String get enforceAlarmSoundDescription =>
      'ئەگەر قوزغىتىلسا، تېلېفونىڭىزنىڭ ئاۋازى تۆۋەن بولسىمۇ، بۇ ئىقتىدار قوڭغۇراقنى بۇ يەردە بەلگىلەنگەن ئاۋاز بىلەن چالدىۇ. بۇ تېلېفون ئاۋازىنىڭ تۆۋەنلىكى سەۋەبىدىن قوڭغۇراقنى ئاڭلىماي قېلىشنىڭ ئالدىنى ئالىدۇ.';

  @override
  String get volume => 'ئاۋاز';

  @override
  String get atPrayerTime => 'ناماز ۋاقتىدا';

  @override
  String minBefore(int minutes) {
    return '$minutes مىنۇت بۇرۇن';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes مىنۇت كېيىن';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName ۋاقتى $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'ھازىر $prayerName ۋاقتى';
  }

  @override
  String get stopTheAdhan => 'ئەزاننى توختىتىش';

  @override
  String dateFoundEmpty(String date) {
    return '$date ئۈچۈن ئۇچۇر يوق';
  }

  @override
  String get today => 'بۈگۈن';

  @override
  String get left => 'قالدى';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName ئۈچۈن ئەسكەرتىش قوشۇلدى';
  }

  @override
  String get allowNotificationPermission =>
      'بۇ ئىقتىdarنى ئىشلىتىش ئۈچۈن ئۇقتۇرۇش ھوقۇقىنى بېرىڭ';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName ئۈچۈن ئەسكەرتىش ئۆچۈرۈلدى';
  }

  @override
  String get getPrayerTimesAndQibla => 'ناماز ۋاقىتلىرى ۋە قىبلەنى ئېلىش';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'بېرىلگەن ئورۇن ئۈچۈن ناماز ۋاقىتلىرى ۋە قىبلەنى ھېسابلاڭ.';

  @override
  String get getFromGPS => 'GPS دىن ئېلىش';

  @override
  String get or => 'ياكى';

  @override
  String get selectYourCity => 'شەھىرىڭىزنى تاللاڭ';

  @override
  String get noteAboutGPS =>
      'ئەسكەرتىش: ئەگەر GPS نى ئىشلەتمەكچى بولمىسىڭىز ياكى بىخەتەر ھېس قىلمىسىڭىز، شەھىرىڭىزنى تاللىسىڭىزمۇ بولىدۇ.';

  @override
  String get downloadingLocationResources =>
      'ئورۇن مەنبەلىرى چۈشۈرۈلۈۋاتىدۇ...';

  @override
  String get somethingWentWrong => 'خاتالىق كۆرۈلدى';

  @override
  String get selectYourCountry => 'دۆلىتىڭىزنى تاللاڭ';

  @override
  String get searchForACountry => 'دۆلەت ئىزدەش';

  @override
  String get selectYourAdministrator => 'ۋىلايىتىڭىزنى تاللاڭ';

  @override
  String get searchForAnAdministrator => 'ۋىلايەت ئىزدەش';

  @override
  String get searchForACity => 'شەھەر ئىزدەش';

  @override
  String get pleaseEnableLocationService => 'ئورۇن مۇلازىمىتىنى قوزغىتىڭ';

  @override
  String get donateUs => 'بىزگە ئىئانە قىلىڭ';

  @override
  String get underDevelopment => 'ئىجاد قىلىنىۋاتىدۇ';

  @override
  String get versionLoading => 'يۈكلىنىۋاتىدۇ...';

  @override
  String get alQuran => 'ئەل قۇرئان';

  @override
  String get mainMenu => 'ئاساسىي تىزىملىك';

  @override
  String get notes => 'خاتىرىلەر';

  @override
  String get pinned => 'قادالغانلار';

  @override
  String get jumpToAyah => 'ئايەتكە ئۆتۈش';

  @override
  String get shareMultipleAyah => 'بىر نەچچە ئايەتنى ھەمبەھىرلەش';

  @override
  String get shareThisApp => 'بۇ ئەپنى ھەمبەھىرلەش';

  @override
  String get giveRating => 'باھا بېرىش';

  @override
  String get bugReport => 'خاتالىق مەلۇم قىلىش';

  @override
  String get privacyPolicy => 'مەخپىيەتلىك سىياسىتى';

  @override
  String get aboutTheApp => 'ئەپ ھەققىدە';

  @override
  String get resetTheApp => 'ئەپنى قايتا قۇرۇش';

  @override
  String get resetAppWarningTitle => 'ئەپ سانلىق مەلۇماتىنى قايتا قۇرۇش';

  @override
  String get resetAppWarningMessage =>
      'ئەپنى قايتا قۇرماقچىمۇ؟ بارلىق سانلىق مەلۇماتلىرىڭىز يوقىلىدۇ، ھەمدە ئەپنى باشتىن-ئاخىر قايتا تەڭشىشىڭىز كېرەك.';

  @override
  String get cancel => 'بىكار قىلىش';

  @override
  String get reset => 'قايتا قۇرۇش';

  @override
  String get shareAppSubject => 'بۇ ئەل قۇرئان ئەپىنى سىناپ بېقىڭ!';

  @override
  String shareAppBody(String appLink) {
    return 'ئەسسالامۇ ئەلەيكۇم! كۈندىلىك ئوقۇش ۋە تەپەككۇر قىلىش ئۈچۈن بۇ ئەل قۇرئان ئەپىنى سىناپ بېقىڭ. ئۇ ئاللاھنىڭ سۆزلىرى بىلەن باغلىنىشقا ياردەم بېرىدۇ. بۇ يەردىن چۈشۈرۈڭ: $appLink';
  }

  @override
  String get openDrawerTooltip => 'تىزىملىكنى ئېچىش';

  @override
  String get quran => 'قۇرئان';

  @override
  String get prayer => 'ناماز';

  @override
  String get qibla => 'قىبلە';

  @override
  String get audio => 'ئاۋاز';

  @override
  String get surah => 'سۈرە';

  @override
  String get pages => 'بەتلەر';

  @override
  String get note => 'خاتىرە:';

  @override
  String get linkedAyahs => 'باغلانغان ئايەتلەر:';

  @override
  String get emptyNoteCollection =>
      'بۇ خاتىرە توپلىمى قۇرۇق.\nبۇ يەردە كۆرۈش ئۈچۈن خاتىرە قوشۇڭ.';

  @override
  String get emptyPinnedCollection =>
      'بۇ توپلامغا تېخى ھېچقانداق ئايەت قادالمىدى.\nبۇ يەردە كۆرۈش ئۈچۈن ئايەتلەرنى قاداڭ.';

  @override
  String get noContentAvailable => 'مەزمۇن يوق.';

  @override
  String failedToLoadCollections(String error) {
    return 'توپلاملارنى يۈكلىيەلمىدى: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType ئىسمى بويىچە ئىزدەش...';
  }

  @override
  String get sortBy => 'تەرتىپلەش';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'تېخى ھېچقانداق $collectionType قوشۇلمىدى';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count قادالغان تۈر';
  }

  @override
  String notesCount(int count) {
    return '$count خاتىرە';
  }

  @override
  String get emptyNameNotAllowed => 'قۇرۇق ئىسىم بولمايدۇ';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName غا يېڭىلاندى';
  }

  @override
  String get changeName => 'ئىسمىنى ئۆزگەرتىش';

  @override
  String get changeColor => 'رەڭگىنى ئۆزگەرتىش';

  @override
  String get colorUpdated => 'رەڭ يېڭىلاندى';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ئۆچۈرۈلدى';
  }

  @override
  String get delete => 'ئۆچۈرۈش';

  @override
  String get save => 'ساقلاش';

  @override
  String get collectionNameCannotBeEmpty =>
      'توپلام ئىسمى قۇرۇق بولسا بولمايدۇ.';

  @override
  String get addedNewCollection => 'يېڭى توپلام قوشۇلدى';

  @override
  String ayahCount(int count) {
    return '$count ئايەت';
  }

  @override
  String get byNameAtoZ => 'ئىسىم بويىچە A-Z';

  @override
  String get byNameZtoA => 'ئىسىم بويىچە Z-A';

  @override
  String get byElementNumberAscending => 'ئېلېمېنت سانى بويىچە ئۆرلەش';

  @override
  String get byElementNumberDescending => 'ئېلېمېنت سانى بويىچە تۆۋەنلەش';

  @override
  String get byUpdateDateAscending => 'يېڭىلانغان ۋاقتى بويىچە ئۆرلەش';

  @override
  String get byUpdateDateDescending => 'يېڭىلانغان ۋاقتى بويىچە تۆۋەنلەش';

  @override
  String get byCreateDateAscending => 'قۇرۇلغان ۋاقتى بويىچە ئۆرلەش';

  @override
  String get byCreateDateDescending => 'قۇرۇلغان ۋاقتى بويىچە تۆۋەنلەش';

  @override
  String get translationNotFound => 'تەرجىمە تېپىلمىدى';

  @override
  String get translationTitle => 'تەرجىمە:';

  @override
  String get footNoteTitle => 'ئىزاھات:';

  @override
  String get wordByWordTranslation => 'سۆزمۇ-سۆز تەرجىمە:';

  @override
  String get tafsirButton => 'تەپسىر';

  @override
  String get shareButton => 'ھەمبەھىرلەش';

  @override
  String get addNoteButton => 'خاتىرە قوشۇش';

  @override
  String get pinToCollectionButton => 'توپلامغا قاداش';

  @override
  String get shareAsText => 'تېكىست قىلىپ ھەمبەھىرلەش';

  @override
  String get copiedWithTafsir => 'تەپسىر بىلەن كۆچۈرۈلدى';

  @override
  String get shareAsImage => 'رەسىم قىلىپ ھەمبەھىرلەش';

  @override
  String get shareWithTafsir => 'تەپسىر بىلەن ھەمبەھىرلەش';

  @override
  String get notFound => 'تاپالمىدى';

  @override
  String get noteContentCannotBeEmpty => 'خاتىرە مەزمۇنى قۇرۇق بولسا بولمايدۇ.';

  @override
  String get noteSavedSuccessfully => 'خاتىرە مۇۋەپپەقىيەتلىك ساقلاندى!';

  @override
  String get selectCollections => 'توپلاملارنى تاللاش';

  @override
  String get addNote => 'خاتىرە قوشۇش';

  @override
  String get writeCollectionName => 'توپلام ئىسمىنى يېزىڭ...';

  @override
  String get noCollectionsYetAddANewOne => 'تېخى توپلام يوق. يېڭى بىرنى قوشۇڭ!';

  @override
  String get pleaseWriteYourNoteFirst => 'ئالدى بىلەن خاتىرىڭىزنى يېزىڭ.';

  @override
  String get noCollectionSelected => 'ھېچقانداق توپلام تاللانمىدى';

  @override
  String get saveNote => 'خاتىرە ساقلاش';

  @override
  String get nextSelectCollections => 'كېيىنكى: توپلاملارنى تاللاش';

  @override
  String get addToPinned => 'قادالغانلارغا قوشۇش';

  @override
  String get pinnedSavedSuccessfully =>
      'قادالغانلارغا مۇۋەپپەقىيەتلىك ساقلاندى!';

  @override
  String get savePinned => 'قادالغاننى ساقلاش';

  @override
  String get closeAudioController => 'ئاۋاز كونتروللىغۇچنى تاقاش';

  @override
  String get previous => 'ئالدىنقى';

  @override
  String get rewind => 'ئارقىغا يۆتكەش';

  @override
  String get fastForward => 'ئالدىغا يۆتكەش';

  @override
  String get playNextAyah => 'كېيىنكى ئايەتنى قويۇش';

  @override
  String get repeat => 'تەكرارلاش';

  @override
  String get playAsPlaylist => 'تىزىملىك بويىچە قويۇش';

  @override
  String style(String style) {
    return 'ئۇسلۇب: $style';
  }

  @override
  String get stopAndClose => 'توختىتىش ۋە تاقاش';

  @override
  String get play => 'قويۇش';

  @override
  String get pause => 'ۋاقىتلىق توختىتىش';

  @override
  String get selectReciter => 'قارىنى تاللاش';

  @override
  String source(String source) {
    return 'مەنبە: $source';
  }

  @override
  String get newText => 'يېڭى';

  @override
  String get more => 'تېخىمۇ كۆپ: ';

  @override
  String get cacheNotFound => 'غەملەك تېپىلمىدى';

  @override
  String get cacheSize => 'غەملەك چوڭلۇقى';

  @override
  String error(String error) {
    return 'خاتالىق: $error';
  }

  @override
  String get clean => 'تازىلاش';

  @override
  String get lastModified => 'ئاخىرقى ئۆزگەرتىش';

  @override
  String get oneYearAgo => 'بىر يىل ئىلگىرى';

  @override
  String monthsAgo(String number) {
    return '$number ئاي ئىلگىرى';
  }

  @override
  String weeksAgo(String number) {
    return '$number ھەپتە ئىلگىرى';
  }

  @override
  String daysAgo(String number) {
    return '$number كۈن ئىلگىرى';
  }

  @override
  String hoursAgo(Object hour) {
    return '$hour سائەت ئىلگىرى';
  }

  @override
  String get aboutAlQuran => 'ئەل قۇرئان ھەققىدە';

  @override
  String get appFullName => 'ئەل قۇرئان (تەپسىر، ناماز، قىبلە، ئاۋاز)';

  @override
  String get appDescription =>
      'ئاندروئىد، iOS، MacOS، تور، لىنۇكس ۋە Windows ئۈچۈن ياسالغان ئۇنىۋېرسال ئىسلامىي ئەپ بولۇپ، تەپسىر ۋە كۆپ خىل تەرجىمىلەر (سۆزمۇ-سۆز تەرجىمىنى ئۆز ئىچىگە ئالىدۇ) بىلەن قۇرئان ئوقۇش، دۇنيا مىقياسىدا ئۇقتۇرۇش بىلەن ناماز ۋاقىتلىرى، قىبلە كومپاسى ۋە ماس قەدەملىك سۆزمۇ-سۆز ئاۋازلىق تىلاۋەت قىلىش ئىقتىدارلىرىنى تەمىنلەيدۇ.';

  @override
  String get dataSourcesNote =>
      'ئەسكەرتىش: قۇرئان تېكىستلىرى، تەپسىر، تەرجىمىلەر ۋە ئاۋاز مەنبەلىرى Quran.com، Everyayah.com ۋە باشقا دەلىللەنگەن ئوچۇق مەنبەلەردىن ئېلىنغان.';

  @override
  String get adFreePromise =>
      'بۇ ئەپ ئاللاھنىڭ رازىلىقىنى ئۈچۈن ياسالغان. شۇڭلاشقا، ئۇ پۈتۈنلەي ئېلانسىز بولۇپ، مەڭگۈ شۇنداق بولىدۇ.';

  @override
  String get coreFeatures => 'يادرولۇق ئىقتىدارلىرى';

  @override
  String get coreFeaturesDescription =>
      'ئەل قۇرئان v3 نى كۈندىلىك ئىسلامىي ئەمەلىيىتىڭىز ئۈچۈن كەم بولسا بولمايدىغان قورالغا ئايلاندۇرىدىغان ئاساسلىق ئىقتىدارلارنى كۆرۈپ بېقىڭ:';

  @override
  String get prayerTimesTitle => 'ناماز ۋاقىتلىرى ۋە ئەسكەرتىشلەر';

  @override
  String get prayerTimesDescription =>
      'ھەرخىل ھېسابلاش ئۇسۇللىرى ئارقىلىق دۇنيانىڭ ھەرقانداق يېرىدىكى توغرا ناماز ۋاقىتلىرى. ئەزان ئۇقتۇرۇشى بىلەن ئەسكەرتىش تەڭشەش.';

  @override
  String get qiblaDirectionTitle => 'قىبلە يۆنىلىشى';

  @override
  String get qiblaDirectionDescription =>
      'ئېنىق ۋە توغرا كومپاس كۆرۈنۈشى ئارقىلىق قىبلە يۆنىلىشىنى ئاسانلا تېپىڭ.';

  @override
  String get translationTafsirTitle => 'قۇرئان تەرجىمىسى ۋە تەپسىرى';

  @override
  String get translationTafsirDescription =>
      '69 تىلدىكى 120 دىن ئارتۇق تەرجىمە كىتابى (سۆزمۇ-سۆزنى ئۆز ئىچىگە ئالىدۇ) ۋە 30 دىن ئارتۇق تەپسىر كىتابىنى زىيارەت قىلىڭ.';

  @override
  String get wordByWordAudioTitle => 'سۆزمۇ-سۆز ئاۋاز ۋە يورۇتۇش';

  @override
  String get wordByWordAudioDescription =>
      'چۆكۈپ ئۆگىنىش تەجرىبىسى ئۈچۈن ماس قەدەملىك سۆزمۇ-سۆز ئاۋازلىق تىلاۋەت ۋە يورۇتۇشقا ئەگىشىڭ.';

  @override
  String get ayahAudioRecitationTitle => 'ئايەت ئاۋازلىق تىلاۋىتى';

  @override
  String get ayahAudioRecitationDescription =>
      '40 تىن ئارتۇق داڭلىق قارىنىڭ تولۇق ئايەت تىلاۋىتىنى ئاڭلاڭ.';

  @override
  String get notesCloudBackupTitle => 'بۇلۇت زاپاسلىمىسى بار خاتىرىلەر';

  @override
  String get notesCloudBackupDescription =>
      'شەخسىي خاتىرىلər ۋە تەپەككۇرلارنى ساقلاڭ، بىخەتەر ھالدا بۇلۇتقا زاپاسلاڭ (بۇ ئىقتىدار تەرەققىي قىلدۇرۇلۇۋاتىدۇ / يېقىندا چىقىدۇ).';

  @override
  String get crossPlatformSupportTitle => 'سۇپىلار ئارا قوللاش';

  @override
  String get crossPlatformSupportDescription =>
      'ئاندروئىد، تور، لىنۇكس ۋە Windows دا قوللىنىدۇ.';

  @override
  String get backgroundAudioPlaybackTitle => 'ئارقا كۆرۈنۈشتە ئاۋاز قويۇش';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ئەپ ئارقا كۆرۈنۈشتە تۇرسىمۇ قۇرئان تىلاۋىتىنى داۋاملىق ئاڭلاڭ.';

  @override
  String get audioDataCachingTitle => 'ئاۋاز ۋە سانلىق مەلۇماتلارنى غەملەش';

  @override
  String get audioDataCachingDescription =>
      'كۈچلۈك ئاۋاز ۋە قۇرئان سانلىq مەلۇماتلىرىنى غەملەش ئارقىلىق قويۇش ۋە تورسىز ئىقتىدارلارنى ياخشىلاش.';

  @override
  String get minimalisticInterfaceTitle => 'ئاددىي ۋە پاكىز كۆرۈنمە يۈزى';

  @override
  String get minimalisticInterfaceDescription =>
      'ئىشلەتكۈچى تەجرىبىسى ۋە ئوقۇشقا ئەھمىيەت بېرىلگەن، باشقۇرۇش ئاسان كۆرۈنمە يۈزى.';

  @override
  String get optimizedPerformanceTitle =>
      'يۇقىرى ئۈنۈملۈك ئىقتىدار ۋە چوڭ-كىچىكلىك';

  @override
  String get optimizedPerformanceDescription =>
      'يېنىك ۋە يۇقىرى ئۈنۈملۈك بولۇش ئۈچۈن لايىھەلەنگەن كۆپ ئىقتىدارلىق ئەپ.';

  @override
  String get languageSupport => 'تىل قوللاش';

  @override
  String get languageSupportDescription =>
      'بۇ ئەپ تۆۋەندىكى تىللارنى قوللاش ئارقىلىق دۇنياۋى ئابونتلارغا قۇلايلىق بولۇش ئۈچۈن لايىھەلەنگەن (ۋە تېخىمۇ كۆپلىرى ئۈزلۈكسىز قوشۇلۇۋاتىدۇ):';

  @override
  String get technologyAndResources => 'تېخنىكا ۋە مەنبەلەر';

  @override
  String get technologyAndResourcesDescription =>
      'بۇ ئەپ ئەڭ يېڭى تېخنىكىلار ۋە ئىشەنچلىك مەنبەلەردىن پايدىلىنىپ ياسالغان:';

  @override
  String get flutterFrameworkTitle => 'Flutter رامكىسى';

  @override
  String get flutterFrameworkDescription =>
      'بىر كود ئاساسىدىن گۈزەل، يەرلىك تۈزۈلگەن، كۆپ سۇپىلىق تەجرىبە ئۈچۈن Flutter بىلەن ياسالغان.';

  @override
  String get advancedAudioEngineTitle => 'ئىلغار ئاۋاز ماتورى';

  @override
  String get advancedAudioEngineDescription =>
      'كۈچلۈك ئاۋاز قويۇش ۋە كونترول قىلىش ئۈچۈن «just_audio» ۋە «just_audio_background» Flutter بولاقلىرى تەرىپىدىن قوزغىتىلغان.';

  @override
  String get reliableQuranDataTitle => 'ئىشەنچلىك قۇرئان سانلىق مەلۇماتلىرى';

  @override
  String get reliableQuranDataDescription =>
      'ئەل قۇرئان تېكىستلىرى، تەرجىمىلىرى، تەپسىرلىرى ۋە ئاۋازلىرى Quran.com & Everyayah.com غا ئوخشاش دەلىللەنگەن ئوچۇق API ۋە سانلىق مەلۇمات ئامبىرىدىن ئېلىنغان.';

  @override
  String get prayerTimeEngineTitle => 'ناماز ۋاقتى ماتورى';

  @override
  String get prayerTimeEngineDescription =>
      'توغرا ناماز ۋاقىتلىرى ئۈچۈن بېكىتىلگەن ھېسابلاش ئۇسۇللىرىنى قوللىنىدۇ. ئۇقتۇرۇشلار «flutter_local_notifications» ۋە ئارقا كۆرۈنۈش ۋەزىپىلىرى تەرىپىدىن بىر تەرەپ قىلىنىدۇ.';

  @override
  String get crossPlatformSupport => 'سۇپىلار ئارا قوللاش';

  @override
  String get crossPlatformSupportDescription2 =>
      'ھەرخىل سۇپىلاردا راۋان زىيارەتتىن ھۇزۇرلىنىڭ:';

  @override
  String get android => 'ئاندروئىد';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'تور';

  @override
  String get linux => 'لىنۇكس';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'بىزنىڭ ئۆمۈرلۈك ۋەدىمىز';

  @override
  String get lifetimePromiseDescription =>
      'مەن شەخسەن ئۆمرۈمنىڭ ئاخىرىغىچە، ئىنشائاللاھ، بۇ ئەپ ئۈچۈن ئۈزلۈكسىز قوللاش ۋە ئاسراش بىلەن تەمىنلەشكە ۋەدە بېرىمەن. مەقسىتىم بۇ ئەپنىڭ كەلگۈسى يىللاردا ئۈممەت ئۈچۈن پايدىلىق مەنبە بولۇپ قېلىشىغا كاپالەتلىك قىلىش.';

  @override
  String get fajr => 'بامداد';

  @override
  String get sunrise => 'كۈن چىقىش';

  @override
  String get dhuhr => 'پېشىن';

  @override
  String get asr => 'دىگەر';

  @override
  String get maghrib => 'شام';

  @override
  String get isha => 'خۇپتەن';

  @override
  String get midnight => 'يېرىم كېچە';

  @override
  String get alarm => 'قوڭغۇراق';

  @override
  String get notification => 'ئۇقتۇرۇش';

  @override
  String formattedAddress(
    Object administrativeArea,
    Object country,
    Object subAdministrativeArea,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'تەجۋىد';

  @override
  String get quranScriptUthmani => 'ئوسمانى';

  @override
  String get quranScriptIndopak => 'ھىندى-پاك';
}
