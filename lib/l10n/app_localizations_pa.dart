// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

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
    return '$ayahKey ਲਈ ਤਫਸੀਰ ਉਪਲਬਧ ਨਹੀਂ ਹੈ';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'ਤਫਸੀਰ ਮਿਲੇਗੀ: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey ਵੱਲ ਜਾਓ';
  }

  @override
  String get hizb => 'ਹਿਜ਼ਬ';

  @override
  String get juz => 'ਜੁਜ਼';

  @override
  String get page => 'ਸਫ਼ਾ';

  @override
  String get ruku => 'ਰੁਕੂ';

  @override
  String get languageSettings => 'ਭਾਸ਼ਾ ਸੈਟਿੰਗਾਂ';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count ਆਇਤਾਂ';
  }

  @override
  String get saveAndDownload => 'ਸੇਵ ਅਤੇ ਡਾਊਨਲੋਡ';

  @override
  String get appLanguage => 'ਐਪ ਭਾਸ਼ਾ';

  @override
  String get selectAppLanguage => 'ਐਪ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get pleaseSelectOne => 'ਕਿਰਪਾ ਕਰਕੇ ਇੱਕ ਚੁਣੋ';

  @override
  String get quranTranslationLanguage => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਭਾਸ਼ਾ';

  @override
  String get selectTranslationLanguage => 'ਅਨੁਵਾਦ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get quranTranslationBook => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਕਿਤਾਬ';

  @override
  String get selectTranslationBook => 'ਅਨੁਵਾਦ ਕਿਤਾਬ ਚੁਣੋ...';

  @override
  String get quranTafsirLanguage => 'ਕੁਰਾਨ ਤਫਸੀਰ ਭਾਸ਼ਾ';

  @override
  String get selectTafsirLanguage => 'ਤਫਸੀਰ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get quranTafsirBook => 'ਕੁਰਾਨ ਤਫਸੀਰ ਕਿਤਾਬ';

  @override
  String get selectTafsirBook => 'ਤਫਸੀਰ ਕਿਤਾਬ ਚੁਣੋ...';

  @override
  String get quranScriptAndStyle => 'ਕੁਰਾਨ ਸਕ੍ਰਿਪਟ ਅਤੇ ਸਟਾਈਲ';

  @override
  String get justAMoment => 'ਬੱਸ ਇੱਕ ਪਲ...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'ਸਫਲਤਾ';

  @override
  String get retry => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get unableToDownloadResources =>
      'ਸਰੋਤ ਡਾਊਨਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਮਰੱਥ...\nਕੁਝ ਗਲਤ ਹੋ ਗਿਆ';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'ਸੈਗਮੈਂਟਿਡ ਕੁਰਾਨ ਤਲਾਵਤ ਡਾਊਨਲੋਡ ਕਰ ਰਿਹਾ ਹੈ';

  @override
  String get processingSegmentedQuranRecitation =>
      'ਸੈਗਮੈਂਟਿਡ ਕੁਰਾਨ ਤਲਾਵਤ ਪ੍ਰੋਸੈਸਿੰਗ ਕਰ ਰਿਹਾ ਹੈ';

  @override
  String get footnote => 'ਫੁਟਨੋਟ';

  @override
  String get tafsir => 'ਤਫਸੀਰ';

  @override
  String get wordByWord => 'ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ';

  @override
  String get pleaseSelectRequiredOption => 'ਕਿਰਪਾ ਕਰਕੇ ਲੋੜੀਂਦਾ ਵਿਕਲਪ ਚੁਣੋ';

  @override
  String get rememberHomeTab => 'ਹੋਮ ਟੈਬ ਯਾਦ ਰੱਖੋ';

  @override
  String get rememberHomeTabSubtitle =>
      'ਐਪ ਹੋਮ ਸਕ੍ਰੀਨ ਵਿੱਚ ਆਖਰੀ ਖੋਲ੍ਹੀ ਟੈਬ ਨੂੰ ਯਾਦ ਰੱਖੇਗੀ।';

  @override
  String get wakeLock => 'ਵੇਕ ਲਾਕ';

  @override
  String get wakeLockSubtitle => 'ਸਕ੍ਰੀਨ ਨੂੰ ਆਪਣੇ ਆਪ ਬੰਦ ਹੋਣ ਤੋਂ ਰੋਕੋ।';

  @override
  String get settings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get appTheme => 'ਐਪ ਥੀਮ';

  @override
  String get quranStyle => 'ਕੁਰਾਨ ਸਟਾਈਲ';

  @override
  String get changeTheme => 'ਥੀਮ ਬਦਲੋ';

  @override
  String get verseCount => 'ਆਇਤ ਗਿਣਤੀ: ';

  @override
  String get translation => 'ਅਨੁਵਾਦ';

  @override
  String get tafsirNotFound => 'ਨਹੀਂ ਮਿਲੀ';

  @override
  String get moreInfo => 'ਹੋਰ ਜਾਣਕਾਰੀ';

  @override
  String get playAudio => 'ਆਡੀਓ ਚਲਾਓ';

  @override
  String get preview => 'ਪ੍ਰੀਵਿਊ';

  @override
  String get loading => 'ਲੋਡਿੰਗ...';

  @override
  String get errorFetchingAddress => 'ਪਤਾ ਲੈਣ ਵਿੱਚ ਗਲਤੀ';

  @override
  String get addressNotAvailable => 'ਪਤਾ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String get latitude => 'ਲੈਟੀਟਿਊਡ: ';

  @override
  String get longitude => 'ਲੌਂਗੀਟਿਊਡ: ';

  @override
  String get name => 'ਨਾਮ: ';

  @override
  String get location => 'ਸਥਾਨ: ';

  @override
  String get parameters => 'ਪੈਰਾਮੀਟਰ: ';

  @override
  String get selectCalculationMethod => 'ਗਣਨਾ ਵਿਧੀ ਚੁਣੋ';

  @override
  String get shareSelectAyahs => 'ਚੁਣੀਆਂ ਆਇਤਾਂ ਸਾਂਝੀਆਂ ਕਰੋ';

  @override
  String get selectionEmpty => 'ਚੋਣ ਖਾਲੀ ਹੈ';

  @override
  String get generatingImagePleaseWait =>
      'ਚਿੱਤਰ ਬਣਾ ਰਿਹਾ ਹੈ... ਕਿਰਪਾ ਕਰਕੇ ਉਡੀਕ ਕਰੋ';

  @override
  String get asImage => 'ਚਿੱਤਰ ਵਜੋਂ';

  @override
  String get asText => 'ਟੈਕਸਟ ਵਜੋਂ';

  @override
  String get playFromSelectedAyah => 'ਚੁਣੀ ਆਇਤ ਤੋਂ ਚਲਾਓ';

  @override
  String get toTafsir => 'ਤਫਸੀਰ ਵੱਲ';

  @override
  String get selectAyah => 'ਆਇਤ ਚੁਣੋ';

  @override
  String get toAyah => 'ਆਇਤ ਵੱਲ';

  @override
  String get searchForASurah => 'ਸੂਰਹ ਖੋਜੋ';

  @override
  String get bugReportTitle => 'ਬੱਗ ਰਿਪੋਰਟ';

  @override
  String get audioCached => 'ਆਡੀਓ ਕੈਸ਼ ਕੀਤੀ ਗਈ';

  @override
  String get others => 'ਹੋਰ';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'ਕੁਰਾਨ|ਅਨੁਵਾਦ|ਆਇਤ, ਇੱਕ ਨੂੰ ਚਾਲੂ ਕਰਨਾ ਲਾਜ਼ਮੀ ਹੈ';

  @override
  String get quranFontSize => 'ਕੁਰਾਨ ਫੌਂਟ ਸਾਈਜ਼';

  @override
  String get quranLineHeight => 'ਕੁਰਾਨ ਲਾਈਨ ਉਚਾਈ';

  @override
  String get translationAndTafsirFontSize => 'ਅਨੁਵਾਦ ਅਤੇ ਤਫਸੀਰ ਫੌਂਟ ਸਾਈਜ਼';

  @override
  String get quranAyah => 'ਕੁਰਾਨ ਆਇਤ';

  @override
  String get topToolbar => 'ਟਾਪ ਟੂਲਬਾਰ';

  @override
  String get keepOpenWordByWord => 'ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਖੁੱਲ੍ਹਾ ਰੱਖੋ';

  @override
  String get wordByWordHighlight => 'ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਹਾਈਲਾਈਟ';

  @override
  String get quranScriptSettings => 'ਕੁਰਾਨ ਸਕ੍ਰਿਪਟ ਸੈਟਿੰਗਾਂ';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'ਸਫ਼ਾ: ';

  @override
  String get quranResources => 'ਕੁਰਾਨ ਸਰੋਤ';

  @override
  String alreadySelected(String name) {
    return 'ਭਾਸ਼ਾ \'$name\' ਪਹਿਲਾਂ ਹੀ ਚੁਣੀ ਗਈ ਹੈ।';
  }

  @override
  String get unableToGetCompassData => 'ਕੰਪਾਸ ਡਾਟਾ ਲੈਣ ਵਿੱਚ ਅਸਮਰੱਥ';

  @override
  String get deviceDoesNotHaveSensors => 'ਡਿਵਾਈਸ ਵਿੱਚ ਸੈਂਸਰ ਨਹੀਂ ਹਨ!';

  @override
  String get north => 'ਉੱਤਰ';

  @override
  String get east => 'ਪੂਰਬ';

  @override
  String get south => 'ਦੱਖਣ';

  @override
  String get west => 'ਪੱਛਮ';

  @override
  String get address => 'ਪਤਾ: ';

  @override
  String get change => 'ਬਦਲੋ';

  @override
  String get calculationMethod => 'ਗਣਨਾ ਵਿਧੀ: ';

  @override
  String get downloadPrayerTime => 'ਨਮਾਜ਼ ਸਮਾਂ ਡਾਊਨਲੋਡ ਕਰੋ';

  @override
  String get calculationMethodsListEmpty => 'ਗਣਨਾ ਵਿਧੀਆਂ ਦੀ ਸੂਚੀ ਖਾਲੀ ਹੈ।';

  @override
  String get noCalculationMethodWithLocationData =>
      'ਸਥਾਨ ਡਾਟਾ ਨਾਲ ਕੋਈ ਗਣਨਾ ਵਿਧੀ ਨਹੀਂ ਮਿਲੀ।';

  @override
  String get prayerSettings => 'ਨਮਾਜ਼ ਸੈਟਿੰਗਾਂ';

  @override
  String get reminderSettings => 'ਰਿਮਾਈਂਡਰ ਸੈਟਿੰਗਾਂ';

  @override
  String get adjustReminderTime => 'ਰਿਮਾਈਂਡਰ ਸਮਾਂ ਅਡਜੱਸਟ ਕਰੋ';

  @override
  String get enforceAlarmSound => 'ਅਲਾਰਮ ਦੀ ਆਵਾਜ਼ ਨੂੰ ਲਾਗੂ ਕਰੋ';

  @override
  String get enforceAlarmSoundDescription =>
      'ਜੇ ਚਾਲੂ ਕੀਤਾ ਗਿਆ, ਤਾਂ ਇਹ ਫੀਚਰ ਅਲਾਰਮ ਨੂੰ ਇੱਥੇ ਸੈੱਟ ਵਾਲੀ ਵਾਲੀਊਮ ਤੇ ਚਲਾਏਗਾ, ਭਾਵੇਂ ਤੁਹਾਡੇ ਫੋਨ ਦੀ ਆਵਾਜ਼ ਘੱਟ ਹੋਵੇ। ਇਹ ਯਕੀਨੀ ਬਣਾਉਂਦਾ ਹੈ ਕਿ ਤੁਸੀਂ ਘੱਟ ਫੋਨ ਵਾਲੀਊਮ ਕਰਕੇ ਅਲਾਰਮ ਨੂੰ ਮਿਸ ਨਾ ਕਰੋ।';

  @override
  String get volume => 'ਵਾਲੀਊਮ';

  @override
  String get atPrayerTime => 'ਨਮਾਜ਼ ਸਮੇਂ ਤੇ';

  @override
  String minBefore(int minutes) {
    return '$minutes ਮਿੰਟ ਪਹਿਲਾਂ';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes ਮਿੰਟ ਬਾਅਦ';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName $prayerTime ਤੇ ਹੈ';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName ਦਾ ਸਮਾਂ ਹੈ';
  }

  @override
  String get stopTheAdhan => 'ਅਜ਼ਾਨ ਰੋਕੋ';

  @override
  String dateFoundEmpty(String date) {
    return '$date ਖਾਲੀ ਮਿਲੀ';
  }

  @override
  String get today => 'ਅੱਜ';

  @override
  String get left => 'ਬਾਕੀ';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName ਲਈ ਰਿਮਾਈਂਡਰ ਜੋੜਿਆ ਗਿਆ';
  }

  @override
  String get allowNotificationPermission =>
      'ਇਸ ਫੀਚਰ ਨੂੰ ਵਰਤਣ ਲਈ ਨੋਟੀਫਿਕੇਸ਼ਨ ਪਰਮਿਸ਼ਨ ਨੂੰ ਮਨਜ਼ੂਰ ਕਰੋ';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName ਲਈ ਰਿਮਾਈਂਡਰ ਹਟਾਇਆ ਗਿਆ';
  }

  @override
  String get getPrayerTimesAndQibla => 'ਨਮਾਜ਼ ਸਮਾਂ ਅਤੇ ਕਿਬਲਾ ਲਵੋ';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'ਕਿਸੇ ਵੀ ਦਿੱਤੇ ਸਥਾਨ ਲਈ ਨਮਾਜ਼ ਸਮਾਂ ਅਤੇ ਕਿਬਲਾ ਗਣਨਾ ਕਰੋ।';

  @override
  String get getFromGPS => 'ਜੀਪੀਐੱਸ ਤੋਂ ਲਵੋ';

  @override
  String get or => 'ਜਾਂ';

  @override
  String get selectYourCity => 'ਆਪਣਾ ਸ਼ਹਿਰ ਚੁਣੋ';

  @override
  String get noteAboutGPS =>
      'ਨੋਟ: ਜੇ ਤੁਸੀਂ ਜੀਪੀਐੱਸ ਨੂੰ ਵਰਤਣਾ ਨਹੀਂ ਚਾਹੁੰਦੇ ਜਾਂ ਸੁਰੱਖਿਅਤ ਨਹੀਂ ਮਹਿਸੂਸ ਕਰਦੇ, ਤਾਂ ਤੁਸੀਂ ਆਪਣਾ ਸ਼ਹਿਰ ਚੁਣ ਸਕਦੇ ਹੋ।';

  @override
  String get downloadingLocationResources => 'ਸਥਾਨ ਸਰੋਤ ਡਾਊਨਲੋਡ ਕਰ ਰਿਹਾ ਹੈ...';

  @override
  String get somethingWentWrong => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ';

  @override
  String get selectYourCountry => 'ਆਪਣਾ ਦੇਸ਼ ਚੁਣੋ';

  @override
  String get searchForACountry => 'ਦੇਸ਼ ਖੋਜੋ';

  @override
  String get selectYourAdministrator => 'ਆਪਣਾ ਐਡਮਿਨਿਸਟ੍ਰੇਟਰ ਚੁਣੋ';

  @override
  String get searchForAnAdministrator => 'ਐਡਮਿਨਿਸਟ੍ਰੇਟਰ ਖੋਜੋ';

  @override
  String get searchForACity => 'ਸ਼ਹਿਰ ਖੋਜੋ';

  @override
  String get pleaseEnableLocationService => 'ਕਿਰਪਾ ਕਰਕੇ ਸਥਾਨ ਸੇਵਾ ਚਾਲੂ ਕਰੋ';

  @override
  String get donateUs => 'ਸਾਨੂੰ ਦਾਨ ਕਰੋ';

  @override
  String get underDevelopment => 'ਵਿਕਾਸ ਅਧੀਨ';

  @override
  String get versionLoading => 'ਲੋਡਿੰਗ...';

  @override
  String get alQuran => 'ਅਲ ਕੁਰਾਨ';

  @override
  String get mainMenu => 'ਮੁੱਖ ਮੀਨੂੰ';

  @override
  String get notes => 'ਨੋਟਸ';

  @override
  String get pinned => 'ਪਿੰਨ ਕੀਤੇ';

  @override
  String get jumpToAyah => 'ਆਇਤ ਵੱਲ ਜਾਓ';

  @override
  String get shareMultipleAyah => 'ਕਈ ਆਇਤਾਂ ਸਾਂਝੀਆਂ ਕਰੋ';

  @override
  String get shareThisApp => 'ਇਸ ਐਪ ਨੂੰ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get giveRating => 'ਰੇਟਿੰਗ ਦਿਓ';

  @override
  String get bugReport => 'ਬੱਗ ਰਿਪੋਰਟ';

  @override
  String get privacyPolicy => 'ਪ੍ਰਾਈਵੇਸੀ ਪਾਲਿਸੀ';

  @override
  String get aboutTheApp => 'ਐਪ ਬਾਰੇ';

  @override
  String get resetTheApp => 'ਐਪ ਰੀਸੈੱਟ ਕਰੋ';

  @override
  String get resetAppWarningTitle => 'ਐਪ ਡਾਟਾ ਰੀਸੈੱਟ ਕਰੋ';

  @override
  String get resetAppWarningMessage =>
      'ਕੀ ਤੁਸੀਂ ਐਪ ਨੂੰ ਰੀਸੈੱਟ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ? ਤੁਹਾਡਾ ਸਾਰਾ ਡਾਟਾ ਗੁਆਚ ਜਾਵੇਗਾ, ਅਤੇ ਤੁਹਾਨੂੰ ਐਪ ਨੂੰ ਸ਼ੁਰੂ ਤੋਂ ਸੈੱਟ ਅੱਪ ਕਰਨਾ ਪਵੇਗਾ।';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get reset => 'ਰੀਸੈੱਟ';

  @override
  String get shareAppSubject => 'ਇਸ ਅਲ ਕੁਰਾਨ ਐਪ ਨੂੰ ਵੇਖੋ!';

  @override
  String shareAppBody(String appLink) {
    return 'ਅੱਸਲਾਮੁ ਅਲੈਕੁਮ! ਰੋਜ਼ਾਨਾ ਪੜ੍ਹਨ ਅਤੇ ਵਿਚਾਰ ਲਈ ਇਸ ਅਲ ਕੁਰਾਨ ਐਪ ਨੂੰ ਵੇਖੋ। ਇਹ ਅੱਲ੍ਹਾ ਦੇ ਸ਼ਬਦਾਂ ਨਾਲ ਜੁੜਨ ਵਿੱਚ ਮਦਦ ਕਰਦੀ ਹੈ। ਇੱਥੇ ਡਾਊਨਲੋਡ ਕਰੋ: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ਡ੍ਰਾਅਰ ਖੋਲ੍ਹੋ';

  @override
  String get quran => 'ਕੁਰਾਨ';

  @override
  String get prayer => 'ਨਮਾਜ਼';

  @override
  String get qibla => 'ਕਿਬਲਾ';

  @override
  String get audio => 'ਆਡੀਓ';

  @override
  String get surah => 'ਸੂਰਹ';

  @override
  String get pages => 'ਸਫ਼ੇ';

  @override
  String get note => 'ਨੋਟ:';

  @override
  String get linkedAyahs => 'ਲਿੰਕ ਕੀਤੀਆਂ ਆਇਤਾਂ:';

  @override
  String get emptyNoteCollection =>
      'ਇਹ ਨੋਟ ਕਲੈਕਸ਼ਨ ਖਾਲੀ ਹੈ।\nਇੱਥੇ ਵੇਖਣ ਲਈ ਕੁਝ ਨੋਟ ਜੋੜੋ।';

  @override
  String get emptyPinnedCollection =>
      'ਇਸ ਕਲੈਕਸ਼ਨ ਵਿੱਚ ਅਜੇ ਕੋਈ ਆਇਤ ਪਿੰਨ ਨਹੀਂ ਕੀਤੀ।\nਇੱਥੇ ਵੇਖਣ ਲਈ ਆਇਤਾਂ ਪਿੰਨ ਕਰੋ।';

  @override
  String get noContentAvailable => 'ਕੋਈ ਸਮੱਗਰੀ ਉਪਲਬਧ ਨਹੀਂ।';

  @override
  String failedToLoadCollections(String error) {
    return 'ਕਲੈਕਸ਼ਨ ਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType ਨਾਮ ਨਾਲ ਖੋਜੋ...';
  }

  @override
  String get sortBy => 'ਸੌਰਟ ਕਰੋ';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'ਅਜੇ ਕੋਈ $collectionType ਨਹੀਂ ਜੋੜਿਆ ਗਿਆ';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count ਪਿੰਨ ਕੀਤੇ ਆਈਟਮ';
  }

  @override
  String notesCount(int count) {
    return '$count ਨੋਟਸ';
  }

  @override
  String get emptyNameNotAllowed => 'ਖਾਲੀ ਨਾਮ ਮਨਜ਼ੂਰ ਨਹੀਂ';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName ਵਿੱਚ ਅਪਡੇਟ ਕੀਤਾ ਗਿਆ';
  }

  @override
  String get changeName => 'ਨਾਮ ਬਦਲੋ';

  @override
  String get changeColor => 'ਰੰਗ ਬਦਲੋ';

  @override
  String get colorUpdated => 'ਰੰਗ ਅਪਡੇਟ ਕੀਤਾ ਗਿਆ';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ਮਿਟਾਇਆ ਗਿਆ';
  }

  @override
  String get delete => 'ਮਿਟਾਓ';

  @override
  String get save => 'ਸੇਵ';

  @override
  String get collectionNameCannotBeEmpty => 'ਕਲੈਕਸ਼ਨ ਨਾਮ ਖਾਲੀ ਨਹੀਂ ਹੋ ਸਕਦਾ।';

  @override
  String get addedNewCollection => 'ਨਵੀਂ ਕਲੈਕਸ਼ਨ ਜੋੜੀ ਗਈ';

  @override
  String ayahCount(int count) {
    return '$count ਆਇਤ';
  }

  @override
  String get byNameAtoZ => 'ਨਾਮ A-Z';

  @override
  String get byNameZtoA => 'ਨਾਮ Z-A';

  @override
  String get byElementNumberAscending => 'ਐਲੀਮੈਂਟ ਨੰਬਰ ਵਧਦਾ';

  @override
  String get byElementNumberDescending => 'ਐਲੀਮੈਂਟ ਨੰਬਰ ਘਟਦਾ';

  @override
  String get byUpdateDateAscending => 'ਅਪਡੇਟ ਮਿਤੀ ਵਧਦੀ';

  @override
  String get byUpdateDateDescending => 'ਅਪਡੇਟ ਮਿਤੀ ਘਟਦੀ';

  @override
  String get byCreateDateAscending => 'ਬਣਾਉਣ ਮਿਤੀ ਵਧਦੀ';

  @override
  String get byCreateDateDescending => 'ਬਣਾਉਣ ਮਿਤੀ ਘਟਦੀ';

  @override
  String get translationNotFound => 'ਅਨੁਵਾਦ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get translationTitle => 'ਅਨੁਵਾਦ:';

  @override
  String get footNoteTitle => 'ਫੁਟ ਨੋਟ:';

  @override
  String get wordByWordTranslation => 'ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਅਨੁਵਾਦ:';

  @override
  String get tafsirButton => 'ਤਫਸੀਰ';

  @override
  String get shareButton => 'ਸਾਂਝਾ ਕਰੋ';

  @override
  String get addNoteButton => 'ਨੋਟ ਜੋੜੋ';

  @override
  String get pinToCollectionButton => 'ਕਲੈਕਸ਼ਨ ਵਿੱਚ ਪਿੰਨ ਕਰੋ';

  @override
  String get shareAsText => 'ਟੈਕਸਟ ਵਜੋਂ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get copiedWithTafsir => 'ਤਫਸੀਰ ਨਾਲ ਕਾਪੀ ਕੀਤਾ ਗਿਆ';

  @override
  String get shareAsImage => 'ਚਿੱਤਰ ਵਜੋਂ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get shareWithTafsir => 'ਤਫਸੀਰ ਨਾਲ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get notFound => 'ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get noteContentCannotBeEmpty => 'ਨੋਟ ਸਮੱਗਰੀ ਖਾਲੀ ਨਹੀਂ ਹੋ ਸਕਦੀ।';

  @override
  String get noteSavedSuccessfully => 'ਨੋਟ ਸਫਲਤਾਪੂਰਵਕ ਸੇਵ ਕੀਤਾ ਗਿਆ!';

  @override
  String get selectCollections => 'ਕਲੈਕਸ਼ਨ ਚੁਣੋ';

  @override
  String get addNote => 'ਨੋਟ ਜੋੜੋ';

  @override
  String get writeCollectionName => 'ਕਲੈਕਸ਼ਨ ਨਾਮ ਲਿਖੋ...';

  @override
  String get noCollectionsYetAddANewOne => 'ਅਜੇ ਕੋਈ ਕਲੈਕਸ਼ਨ ਨਹੀਂ। ਨਵੀਂ ਜੋੜੋ!';

  @override
  String get pleaseWriteYourNoteFirst => 'ਕਿਰਪਾ ਕਰਕੇ ਪਹਿਲਾਂ ਆਪਣਾ ਨੋਟ ਲਿਖੋ।';

  @override
  String get noCollectionSelected => 'ਕੋਈ ਕਲੈਕਸ਼ਨ ਚੁਣੀ ਨਹੀਂ ਗਈ';

  @override
  String get saveNote => 'ਨੋਟ ਸੇਵ ਕਰੋ';

  @override
  String get nextSelectCollections => 'ਅਗਲਾ: ਕਲੈਕਸ਼ਨ ਚੁਣੋ';

  @override
  String get addToPinned => 'ਪਿੰਨ ਵਿੱਚ ਜੋੜੋ';

  @override
  String get pinnedSavedSuccessfully => 'ਪਿੰਨ ਸਫਲਤਾਪੂਰਵਕ ਸੇਵ ਕੀਤਾ ਗਿਆ!';

  @override
  String get savePinned => 'ਪਿੰਨ ਸੇਵ ਕਰੋ';

  @override
  String get closeAudioController => 'ਆਡੀਓ ਕੰਟਰੋਲਰ ਬੰਦ ਕਰੋ';

  @override
  String get previous => 'ਪਿਛਲਾ';

  @override
  String get rewind => 'ਰੀਵਾਈਂਡ';

  @override
  String get fastForward => 'ਫਾਸਟ ਫਾਰਵਰਡ';

  @override
  String get playNextAyah => 'ਅਗਲੀ ਆਇਤ ਚਲਾਓ';

  @override
  String get repeat => 'ਦੁਹਰਾਓ';

  @override
  String get playAsPlaylist => 'ਪਲੇਲਿਸਟ ਵਜੋਂ ਚਲਾਓ';

  @override
  String style(String style) {
    return 'ਸਟਾਈਲ: $style';
  }

  @override
  String get stopAndClose => 'ਰੋਕੋ ਅਤੇ ਬੰਦ ਕਰੋ';

  @override
  String get play => 'ਚਲਾਓ';

  @override
  String get pause => 'ਰੋਕੋ';

  @override
  String get selectReciter => 'ਕਾਰੀ ਚੁਣੋ';

  @override
  String source(String source) {
    return 'ਸਰੋਤ: $source';
  }

  @override
  String get newText => 'ਨਵਾਂ';

  @override
  String get more => 'ਹੋਰ: ';

  @override
  String get cacheNotFound => 'ਕੈਸ਼ ਨਹੀਂ ਮਿਲੀ';

  @override
  String get cacheSize => 'ਕੈਸ਼ ਸਾਈਜ਼';

  @override
  String error(String error) {
    return 'ਗਲਤੀ: $error';
  }

  @override
  String get clean => 'ਸਾਫ਼ ਕਰੋ';

  @override
  String get lastModified => 'ਆਖਰੀ ਸੰਸ਼ੋਧਿਤ';

  @override
  String get oneYearAgo => '1 ਸਾਲ ਪਹਿਲਾਂ';

  @override
  String monthsAgo(String number) {
    return '$number ਮਹੀਨੇ ਪਹਿਲਾਂ';
  }

  @override
  String weeksAgo(String number) {
    return '$number ਹਫ਼ਤੇ ਪਹਿਲਾਂ';
  }

  @override
  String daysAgo(String number) {
    return '$number ਦਿਨ ਪਹਿਲਾਂ';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour ਘੰਟੇ ਪਹਿਲਾਂ';
  }

  @override
  String get aboutAlQuran => 'ਅਲ ਕੁਰਾਨ ਬਾਰੇ';

  @override
  String get appFullName => 'ਅਲ ਕੁਰਾਨ (ਤਫਸੀਰ, ਨਮਾਜ਼, ਕਿਬਲਾ, ਆਡੀਓ)';

  @override
  String get appDescription =>
      'ਐਂਡਰਾਇਡ, ਆਈਓਐੱਸ, ਮੈਕਓਐੱਸ, ਵੈੱਬ, ਲਿਨਕਸ ਅਤੇ ਵਿੰਡੋਜ਼ ਲਈ ਇੱਕ ਵਿਆਪਕ ਇਸਲਾਮੀ ਐਪਲੀਕੇਸ਼ਨ, ਜੋ ਕੁਰਾਨ ਪੜ੍ਹਨ ਨਾਲ ਤਫਸੀਰ ਅਤੇ ਕਈ ਅਨੁਵਾਦਾਂ (ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਸਮੇਤ), ਵਿਸ਼ਵ ਵਿਆਪੀ ਨਮਾਜ਼ ਸਮਾਂ ਨਾਲ ਨੋਟੀਫਿਕੇਸ਼ਨਾਂ, ਕਿਬਲਾ ਕੰਪਾਸ, ਅਤੇ ਸਿੰਕ੍ਰੋਨਾਈਜ਼ਡ ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਆਡੀਓ ਤਲਾਵਤ ਪ੍ਰਦਾਨ ਕਰਦੀ ਹੈ।';

  @override
  String get dataSourcesNote =>
      'ਨੋਟ: ਕੁਰਾਨ ਟੈਕਸਟ, ਤਫਸੀਰ, ਅਨੁਵਾਦ ਅਤੇ ਆਡੀਓ ਸਰੋਤ ਕੁਰਾਨ.ਕਾਮ, ਏਵਰੀਆਯਾਹ.ਕਾਮ ਅਤੇ ਹੋਰ ਪ੍ਰਮਾਣਿਤ ਓਪਨ ਸਰੋਤਾਂ ਤੋਂ ਲਏ ਗਏ ਹਨ।';

  @override
  String get adFreePromise =>
      'ਇਹ ਐਪ ਅੱਲ੍ਹਾ ਦੀ ਖੁਸ਼ੀ ਲਈ ਬਣਾਈ ਗਈ ਹੈ। ਇਸ ਲਈ, ਇਹ ਪੂਰੀ ਤਰ੍ਹਾਂ ਵਿਗਿਆਪਨ-ਮੁਕਤ ਹੈ ਅਤੇ ਹਮੇਸ਼ਾ ਰਹੇਗੀ।';

  @override
  String get coreFeatures => 'ਮੁੱਖ ਫੀਚਰਾਂ';

  @override
  String get coreFeaturesDescription =>
      'ਅਲ ਕੁਰਾਨ v3 ਨੂੰ ਤੁਹਾਡੀ ਰੋਜ਼ਾਨਾ ਇਸਲਾਮੀ ਅਭਿਆਸਾਂ ਲਈ ਇੱਕ ਅਨਿੱਖੜਵਾਂ ਔਜ਼ਾਰ ਬਣਾਉਣ ਵਾਲੀਆਂ ਮੁੱਖ ਵਿਸ਼ੇਸ਼ਤਾਵਾਂ ਦੀ ਪੜਚੋਲ ਕਰੋ:';

  @override
  String get prayerTimesTitle => 'ਨਮਾਜ਼ ਸਮਾਂ ਅਤੇ ਅਲਰਟਸ';

  @override
  String get prayerTimesDescription =>
      'ਕਿਸੇ ਵੀ ਸਥਾਨ ਲਈ ਵੱਖ ਵੱਖ ਗਣਨਾ ਵਿਧੀਆਂ ਵਰਤ ਕੇ ਸਹੀ ਨਮਾਜ਼ ਸਮਾਂ। ਅਜ਼ਾਨ ਨੋਟੀਫਿਕੇਸ਼ਨਾਂ ਨਾਲ ਰਿਮਾਈਂਡਰ ਸੈੱਟ ਕਰੋ।';

  @override
  String get qiblaDirectionTitle => 'ਕਿਬਲਾ ਦਿਸ਼ਾ';

  @override
  String get qiblaDirectionDescription =>
      'ਸਾਫ਼ ਅਤੇ ਸਹੀ ਕੰਪਾਸ ਵਿਊ ਨਾਲ ਕਿਬਲਾ ਦਿਸ਼ਾ ਆਸਾਨੀ ਨਾਲ ਲੱਭੋ।';

  @override
  String get translationTafsirTitle => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਅਤੇ ਤਫਸੀਰ';

  @override
  String get translationTafsirDescription =>
      '69 ਭਾਸ਼ਾਵਾਂ ਵਿੱਚ 120+ ਅਨੁਵਾਦ ਕਿਤਾਬਾਂ (ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਸਮੇਤ), ਅਤੇ 30+ ਤਫਸੀਰ ਕਿਤਾਬਾਂ ਤੱਕ ਪਹੁੰਚ।';

  @override
  String get wordByWordAudioTitle => 'ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਆਡੀਓ ਅਤੇ ਹਾਈਲਾਈਟਿੰਗ';

  @override
  String get wordByWordAudioDescription =>
      'ਇੱਕ ਡੂੰਘੀ ਸਿੱਖਣ ਅਨੁਭਵ ਲਈ ਸਿੰਕ੍ਰੋਨਾਈਜ਼ਡ ਸ਼ਬਦ ਨਾਲ ਸ਼ਬਦ ਆਡੀਓ ਤਲਾਵਤ ਅਤੇ ਹਾਈਲਾਈਟਿੰਗ ਨਾਲ ਨਾਲ ਚੱਲੋ।';

  @override
  String get ayahAudioRecitationTitle => 'ਆਇਤ ਆਡੀਓ ਤਲਾਵਤ';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ ਪ੍ਰਸਿੱਧ ਰੈਸਾਈਟਰਾਂ ਤੋਂ ਪੂਰੀ ਆਇਤ ਤਲਾਵਤਾਂ ਸੁਣੋ।';

  @override
  String get notesCloudBackupTitle => 'ਨੋਟਸ ਨਾਲ ਕਲਾਊਡ ਬੈਕਅੱਪ';

  @override
  String get notesCloudBackupDescription =>
      'ਨਿੱਜੀ ਨੋਟਸ ਅਤੇ ਵਿਚਾਰ ਸੇਵ ਕਰੋ, ਕਲਾਊਡ ਵਿੱਚ ਸੁਰੱਖਿਅਤ ਬੈਕਅੱਪ (ਫੀਚਰ ਵਿਕਾਸ ਅਧੀਨ/ਜਲਦੀ ਆ ਰਿਹਾ ਹੈ)।';

  @override
  String get crossPlatformSupportTitle => 'ਕਰਾਸ-ਪਲੇਟਫਾਰਮ ਸਪੋਰਟ';

  @override
  String get crossPlatformSupportDescription =>
      'ਐਂਡਰਾਇਡ, ਵੈੱਬ, ਲਿਨਕਸ ਅਤੇ ਵਿੰਡੋਜ਼ ਤੇ ਸਪੋਰਟ ਕੀਤਾ ਗਿਆ।';

  @override
  String get backgroundAudioPlaybackTitle => 'ਬੈਕਗ੍ਰਾਊਂਡ ਆਡੀਓ ਪਲੇਬੈਕ';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ਐਪ ਬੈਕਗ੍ਰਾਊਂਡ ਵਿੱਚ ਹੋਣ ਤੇ ਵੀ ਕੁਰਾਨ ਤਲਾਵਤ ਸੁਣਨਾ ਜਾਰੀ ਰੱਖੋ।';

  @override
  String get audioDataCachingTitle => 'ਆਡੀਓ ਅਤੇ ਡਾਟਾ ਕੈਸ਼ਿੰਗ';

  @override
  String get audioDataCachingDescription =>
      'ਮਜ਼ਬੂਤ ਆਡੀਓ ਅਤੇ ਕੁਰਾਨ ਡਾਟਾ ਕੈਸ਼ਿੰਗ ਨਾਲ ਬਿਹਤਰ ਪਲੇਬੈਕ ਅਤੇ ਆਫਲਾਈਨ ਸਮਰੱਥਾਵਾਂ।';

  @override
  String get minimalisticInterfaceTitle => 'ਮਿਨੀਮਲਿਸਟਿਕ ਅਤੇ ਸਾਫ਼ ਇੰਟਰਫੇਸ';

  @override
  String get minimalisticInterfaceDescription =>
      'ਯੂਜ਼ਰ ਅਨੁਭਵ ਅਤੇ ਪੜ੍ਹਨਯੋਗਤਾ ਤੇ ਧਿਆਨ ਨਾਲ ਆਸਾਨ ਨੈਵੀਗੇਸ਼ਨ ਇੰਟਰਫੇਸ।';

  @override
  String get optimizedPerformanceTitle => 'ਅਨੁਕੂਲਿਤ ਪ੍ਰਦਰਸ਼ਨ ਅਤੇ ਸਾਈਜ਼';

  @override
  String get optimizedPerformanceDescription =>
      'ਇੱਕ ਫੀਚਰ-ਰਿਚ ਐਪਲੀਕੇਸ਼ਨ ਜੋ ਹਲਕੀ ਅਤੇ ਪ੍ਰਦਰਸ਼ਨਸ਼ੀਲ ਬਣਾਈ ਗਈ ਹੈ।';

  @override
  String get languageSupport => 'ਭਾਸ਼ਾ ਸਪੋਰਟ';

  @override
  String get languageSupportDescription =>
      'ਇਹ ਐਪਲੀਕੇਸ਼ਨ ਵਿਸ਼ਵ ਵਿਆਪੀ ਦਰਸ਼ਕਾਂ ਲਈ ਪਹੁੰਚਯੋਗ ਬਣਾਈ ਗਈ ਹੈ ਜਿਸ ਵਿੱਚ ਹੇਠ ਲਿਖੀਆਂ ਭਾਸ਼ਾਵਾਂ ਲਈ ਸਪੋਰਟ ਹੈ (ਅਤੇ ਹੋਰ ਨਿਰੰਤਰ ਜੋੜੀਆਂ ਜਾ ਰਹੀਆਂ ਹਨ):';

  @override
  String get technologyAndResources => 'ਤਕਨਾਲੋਜੀ ਅਤੇ ਸਰੋਤ';

  @override
  String get technologyAndResourcesDescription =>
      'ਇਹ ਐਪ ਅੱਤ ਅਧੁਨਿਕ ਤਕਨਾਲੋਜੀਆਂ ਅਤੇ ਭਰੋਸੇਯੋਗ ਸਰੋਤਾਂ ਨਾਲ ਬਣਾਈ ਗਈ ਹੈ:';

  @override
  String get flutterFrameworkTitle => 'ਫਲੱਟਰ ਫਰੇਮਵਰਕ';

  @override
  String get flutterFrameworkDescription =>
      'ਫਲੱਟਰ ਨਾਲ ਬਣਾਈ ਗਈ ਇੱਕ ਸੁੰਦਰ, ਨੇਟਿਵਲੀ ਕੰਪਾਇਲਡ, ਮਲਟੀ-ਪਲੇਟਫਾਰਮ ਅਨੁਭਵ ਲਈ ਇੱਕ ਸਿੰਗਲ ਕੋਡਬੇਸ ਤੋਂ।';

  @override
  String get advancedAudioEngineTitle => 'ਅਡਵਾਂਸਡ ਆਡੀਓ ਇੰਜਣ';

  @override
  String get advancedAudioEngineDescription =>
      'ਜਸਟ_ਆਡੀਓ ਅਤੇ ਜਸਟ_ਆਡੀਓ_ਬੈਕਗ੍ਰਾਊਂਡ ਫਲੱਟਰ ਪੈਕੇਜਾਂ ਨਾਲ ਸੰਚਾਲਿਤ ਮਜ਼ਬੂਤ ਆਡੀਓ ਪਲੇਬੈਕ ਅਤੇ ਕੰਟਰੋਲ ਲਈ।';

  @override
  String get reliableQuranDataTitle => 'ਭਰੋਸੇਯੋਗ ਕੁਰਾਨ ਡਾਟਾ';

  @override
  String get reliableQuranDataDescription =>
      'ਅਲ ਕੁਰਾਨ ਟੈਕਸਟ, ਅਨੁਵਾਦ, ਤਫਸੀਰ ਅਤੇ ਆਡੀਓ ਪ੍ਰਮਾਣਿਤ ਓਪਨ ਏਪੀਆਈ ਅਤੇ ਡੇਟਾਬੇਸ ਜਿਵੇਂ ਕੁਰਾਨ.ਕਾਮ ਅਤੇ ਏਵਰੀਆਯਾਹ.ਕਾਮ ਤੋਂ ਲਏ ਗਏ ਹਨ।';

  @override
  String get prayerTimeEngineTitle => 'ਨਮਾਜ਼ ਸਮਾਂ ਇੰਜਣ';

  @override
  String get prayerTimeEngineDescription =>
      'ਸਹੀ ਨਮਾਜ਼ ਸਮਾਂ ਲਈ ਸਥਾਪਿਤ ਗਣਨਾ ਵਿਧੀਆਂ ਵਰਤਦਾ ਹੈ। ਨੋਟੀਫਿਕੇਸ਼ਨਾਂ ਫਲੱਟਰ_ਲੋਕਲ_ਨੋਟੀਫਿਕੇਸ਼ਨਾਂ ਅਤੇ ਬੈਕਗ੍ਰਾਊਂਡ ਟਾਸਕਾਂ ਨਾਲ ਸੰਭਾਲੀਆਂ ਜਾਂਦੀਆਂ ਹਨ।';

  @override
  String get crossPlatformSupport => 'ਕਰਾਸ ਪਲੇਟਫਾਰਮ ਸਪੋਰਟ';

  @override
  String get crossPlatformSupportDescription2 =>
      'ਵੱਖ ਵੱਖ ਪਲੇਟਫਾਰਮਾਂ ਤੇ ਸੀਮਲੈੱਸ ਪਹੁੰਚ ਦਾ ਆਨੰਦ ਲਓ:';

  @override
  String get android => 'ਐਂਡਰਾਇਡ';

  @override
  String get ios => 'ਆਈਓਐੱਸ';

  @override
  String get macos => 'ਮੈਕਓਐੱਸ';

  @override
  String get web => 'ਵੈੱਬ';

  @override
  String get linux => 'ਲਿਨਕਸ';

  @override
  String get windows => 'ਵਿੰਡੋਜ਼';

  @override
  String get ourLifetimePromise => 'ਸਾਡਾ ਜੀਵਨ ਭਰ ਦਾ ਵਾਅਦਾ';

  @override
  String get lifetimePromiseDescription =>
      'ਮੈਂ ਵਿਅਕਤੀਗਤ ਤੌਰ ਤੇ ਇਸ ਐਪਲੀਕੇਸ਼ਨ ਲਈ ਨਿਰੰਤਰ ਸਪੋਰਟ ਅਤੇ ਮੇਨਟੇਨੈਂਸ ਪ੍ਰਦਾਨ ਕਰਨ ਦਾ ਵਾਅਦਾ ਕਰਦਾ ਹਾਂ, ਇੰਸ਼ਾ ਅੱਲ੍ਹਾ। ਮੇਰਾ ਟੀਚਾ ਇਹ ਯਕੀਨੀ ਬਣਾਉਣਾ ਹੈ ਕਿ ਇਹ ਐਪ ਆਉਣ ਵਾਲੇ ਸਾਲਾਂ ਲਈ ਉਮਮਾ ਲਈ ਲਾਭਕਾਰੀ ਸਰੋਤ ਰਹੇ।';

  @override
  String get fajr => 'ਫਜਰ';

  @override
  String get sunrise => 'ਸੂਰਜ ਚੜ੍ਹਨਾ';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'ਜ਼ੋਹਰ';

  @override
  String get asr => 'ਅਸਰ';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'ਮਗਰਿਬ';

  @override
  String get isha => 'ਇਸ਼ਾ';

  @override
  String get midnight => 'ਅੱਧੀ ਰਾਤ';

  @override
  String get alarm => 'ਅਲਾਰਮ';

  @override
  String get notification => 'ਨੋਟੀਫਿਕੇਸ਼ਨ';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'ਤਜਵੀਦ';

  @override
  String get quranScriptUthmani => 'ਉਥਮਾਨੀ';

  @override
  String get quranScriptIndopak => 'ਇੰਡੋਪਾਕ';

  @override
  String get sajdaAyah => 'ਸਜਦਾ ਆਇਤ';

  @override
  String get required => 'ਲੋੜੀਂਦਾ';

  @override
  String get optional => 'ਵਿਕਲਪੀ';

  @override
  String get notificationScheduleWarning =>
      'ਨੋਟ: ਸ਼ੈਡਿਊਲਡ ਨੋਟੀਫਿਕੇਸ਼ਨ ਜਾਂ ਰਿਮਾਈਂਡਰ ਤੁਹਾਡੇ ਫੋਨ ਦੇ ਓਐੱਸ ਬੈਕਗ੍ਰਾਊਂਡ ਪ੍ਰੋਸੈੱਸ ਪਾਬੰਦੀਆਂ ਕਰਕੇ ਮਿਸ ਹੋ ਸਕਦੇ ਹਨ। ਉਦਾਹਰਣ ਵਜੋਂ: ਵੀਵੋ ਦਾ ਓਰਿਜਿਨ ਓਐੱਸ, ਸੈਮਸੰਗ ਦਾ ਵਨ ਯੂਆਈ, ਓਪੋ ਦਾ ਕਲਰਓਐੱਸ ਆਦਿ ਕਈ ਵਾਰ ਸ਼ੈਡਿਊਲਡ ਨੋਟੀਫਿਕੇਸ਼ਨ ਜਾਂ ਰਿਮਾਈਂਡਰ ਨੂੰ ਮਾਰ ਦਿੰਦੇ ਹਨ। ਕਿਰਪਾ ਕਰਕੇ ਆਪਣੇ ਓਐੱਸ ਸੈਟਿੰਗਾਂ ਨੂੰ ਚੈੱਕ ਕਰੋ ਤਾਂ ਜੋ ਐਪ ਨੂੰ ਬੈਕਗ੍ਰਾਊਂਡ ਪ੍ਰੋਸੈੱਸ ਤੋਂ ਪਾਬੰਦੀ ਨਾ ਲਗਾਈ ਜਾਵੇ।';

  @override
  String get scrollWithRecitation => 'ਤਲਾਵਤ ਨਾਲ ਸਕ੍ਰੌਲ ਕਰੋ';

  @override
  String get quickAccess => 'ਤੇਜ਼ ਪਹੁੰਚ';

  @override
  String get initiallyScrollAyah => 'ਸ਼ੁਰੂ ਵਿੱਚ ਆਇਤ ਵੱਲ ਸਕ੍ਰੌਲ ਕਰੋ';

  @override
  String get tajweedGuide => 'ਤਜਵੀਦ ਗਾਈਡ';

  @override
  String get scrollWithRecitationDesc =>
      'ਚਾਲੂ ਕੀਤੇ ਜਾਣ ਤੇ, ਕੁਰਾਨ ਆਇਤ ਆਡੀਓ ਤਲਾਵਤ ਨਾਲ ਸਿੰਕ ਵਿੱਚ ਆਪਣੇ ਆਪ ਸਕ੍ਰੌਲ ਕਰੇਗੀ।';

  @override
  String get configuration => 'ਕੌਂਫਿਗਰੇਸ਼ਨ';

  @override
  String get restoreFromBackup => 'ਬੈਕਅੱਪ ਤੋਂ ਰੀਸਟੋਰ ਕਰੋ';

  @override
  String get history => 'ਇਤਿਹਾਸ';

  @override
  String get search => 'ਖੋਜ';

  @override
  String get useAudioStream => 'ਆਡੀਓ ਸਟ੍ਰੀਮ ਵਰਤੋ';

  @override
  String get useAudioStreamDesc =>
      'ਡਾਊਨਲੋਡ ਕਰਨ ਦੀ ਬਜਾਏ ਇੰਟਰਨੈੱਟ ਤੋਂ ਸਿੱਧਾ ਆਡੀਓ ਸਟ੍ਰੀਮ ਕਰੋ।';

  @override
  String get notUseAudioStreamDesc =>
      'ਆਫਲਾਈਨ ਵਰਤੋਂ ਲਈ ਆਡੀਓ ਡਾਊਨਲੋਡ ਕਰੋ ਅਤੇ ਡਾਟਾ ਖਪਤ ਘਟਾਓ।';

  @override
  String get audioSettings => 'ਆਡੀਓ ਸੈਟਿੰਗਾਂ';

  @override
  String get playbackSpeed => 'ਪਲੇਬੈਕ ਸਪੀਡ';

  @override
  String get playbackSpeedDesc => 'ਕੁਰਾਨ ਤਲਾਵਤ ਦੀ ਸਪੀਡ ਅਡਜੱਸਟ ਕਰੋ।';

  @override
  String get waitForCurrentDownloadToFinish =>
      'ਕਿਰਪਾ ਕਰਕੇ ਮੌਜੂਦਾ ਡਾਊਨਲੋਡ ਪੂਰਾ ਹੋਣ ਦੀ ਉਡੀਕ ਕਰੋ।';

  @override
  String get areYouSure => 'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਹੋ?';

  @override
  String get checkYourInternetConnection => 'ਆਪਣਾ ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਚੈੱਕ ਕਰੋ।';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount ਆਇਤਾਂ ਵਿੱਚੋਂ $requiredDownload ਡਾਊਨਲੋਡ ਕਰਨ ਦੀ ਲੋੜ ਹੈ।';
  }

  @override
  String get download => 'ਡਾਊਨਲੋਡ';

  @override
  String get audioDownload => 'ਆਡੀਓ ਡਾਊਨਲੋਡ';

  @override
  String get am => 'ਸਵੇਰੇ';

  @override
  String get pm => 'ਸ਼ਾਮ ਨੂੰ';

  @override
  String get optimizingQuranScript => 'ਕੁਰਾਨ ਸਕ੍ਰਿਪਟ ਨੂੰ ਅਨੁਕੂਲਿਤ ਕਰ ਰਿਹਾ ਹੈ';

  @override
  String get supportOnGithub => 'GitHub \'ਤੇ ਸਮਰਥਨ';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafieMalikiHanbali => 'Shafie, Maliki, Hanbali';

  @override
  String get suhurEndTime => 'Suhur End Time';

  @override
  String get iftarStartTime => 'Iftar Start Time';

  @override
  String get tahajjudStartTime => 'Tahajjud Start Time';
}
