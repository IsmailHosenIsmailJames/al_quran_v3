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
    return 'ਤਫਸੀਰ ਇੱਥੇ ਮਿਲੇਗੀ: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey \'ਤੇ ਜਾਓ';
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
  String get saveAndDownload => 'ਸੇਵ ਅਤੇ ਡਾਊਨਲੋਡ ਕਰੋ';

  @override
  String get appLanguage => 'ਐਪ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get selectAppLanguage => 'ਐਪ ਦੀ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get pleaseSelectOne => 'ਕਿਰਪਾ ਕਰਕੇ ਇੱਕ ਚੁਣੋ';

  @override
  String get quranTranslationLanguage => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get selectTranslationLanguage => 'ਅਨੁਵਾਦ ਦੀ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get quranTranslationBook => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਦੀ ਕਿਤਾਬ';

  @override
  String get selectTranslationBook => 'ਅਨੁਵਾਦ ਦੀ ਕਿਤਾਬ ਚੁਣੋ...';

  @override
  String get quranTafsirLanguage => 'ਕੁਰਾਨ ਤਫਸੀਰ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get selectTafsirLanguage => 'ਤਫਸੀਰ ਦੀ ਭਾਸ਼ਾ ਚੁਣੋ...';

  @override
  String get quranTafsirBook => 'ਕੁਰਾਨ ਤਫਸੀਰ ਦੀ ਕਿਤਾਬ';

  @override
  String get selectTafsirBook => 'ਤਫਸੀਰ ਦੀ ਕਿਤਾਬ ਚੁਣੋ...';

  @override
  String get quranScriptAndStyle => 'ਕੁਰਾਨ ਲਿਪੀ ਅਤੇ ਸ਼ੈਲੀ';

  @override
  String get justAMoment => 'ਬਸ ਇੱਕ ਪਲ...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'ਸਫਲ';

  @override
  String get retry => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get unableToDownloadResources =>
      'ਸਰੋਤ ਡਾਊਨਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਮਰੱਥ...\nਕੁਝ ਗਲਤ ਹੋ ਗਿਆ';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'ਖੰਡਿਤ ਕੁਰਾਨ ਪਾਠ ਡਾਊਨਲੋਡ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get processingSegmentedQuranRecitation =>
      'ਖੰਡਿਤ ਕੁਰਾਨ ਪਾਠ ਦੀ ਪ੍ਰੋਸੈਸਿੰਗ ਹੋ ਰਹੀ ਹੈ';

  @override
  String get footnote => 'ਫੁਟਨੋਟ';

  @override
  String get tafsir => 'ਤਫਸੀਰ';

  @override
  String get wordByWord => 'ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ';

  @override
  String get pleaseSelectRequiredOption => 'ਕਿਰਪਾ ਕਰਕੇ ਲੋੜੀਂਦਾ ਵਿਕਲਪ ਚੁਣੋ';

  @override
  String get rememberHomeTab => 'ਹੋਮ ਟੈਬ ਨੂੰ ਯਾਦ ਰੱਖੋ';

  @override
  String get rememberHomeTabSubtitle =>
      'ਐਪ ਹੋਮ ਸਕ੍ਰੀਨ \'ਤੇ ਆਖਰੀ ਖੋਲ੍ਹੀ ਗਈ ਟੈਬ ਨੂੰ ਯਾਦ ਰੱਖੇਗੀ।';

  @override
  String get wakeLock => 'ਸਕ੍ਰੀਨ ਨੂੰ ਚਾਲੂ ਰੱਖੋ';

  @override
  String get wakeLockSubtitle => 'ਸਕ੍ਰੀਨ ਨੂੰ ਆਪਣੇ ਆਪ ਬੰਦ ਹੋਣ ਤੋਂ ਰੋਕੋ।';

  @override
  String get settings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get appTheme => 'ਐਪ ਥੀਮ';

  @override
  String get quranStyle => 'ਕੁਰਾਨ ਸ਼ੈਲੀ';

  @override
  String get changeTheme => 'ਥੀਮ ਬਦਲੋ';

  @override
  String get verseCount => 'ਆਇਤਾਂ ਦੀ ਗਿਣਤੀ: ';

  @override
  String get translation => 'ਅਨੁਵਾਦ';

  @override
  String get tafsirNotFound => 'ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get moreInfo => 'ਹੋਰ ਜਾਣਕਾਰੀ';

  @override
  String get playAudio => 'ਆਡੀਓ ਚਲਾਓ';

  @override
  String get preview => 'ਪੂਰਵ-ਦ੍ਰਿਸ਼';

  @override
  String get loading => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get errorFetchingAddress => 'ਪਤਾ ਪ੍ਰਾਪਤ ਕਰਨ ਵਿੱਚ ਗਲਤੀ';

  @override
  String get addressNotAvailable => 'ਪਤਾ ਉਪਲਬਧ ਨਹੀਂ ਹੈ';

  @override
  String get latitude => 'ਅਕਸ਼ਾਂਸ਼: ';

  @override
  String get longitude => 'ਰੇਖਾਂਸ਼: ';

  @override
  String get name => 'ਨਾਮ: ';

  @override
  String get location => 'ਸਥਾਨ: ';

  @override
  String get parameters => 'ਮਾਪਦੰਡ: ';

  @override
  String get selectCalculationMethod => 'ਗਣਨਾ ਵਿਧੀ ਚੁਣੋ';

  @override
  String get shareSelectAyahs => 'ਚੁਣੀਆਂ ਆਇਤਾਂ ਸਾਂਝੀਆਂ ਕਰੋ';

  @override
  String get selectionEmpty => 'ਚੋਣ ਖਾਲੀ ਹੈ';

  @override
  String get generatingImagePleaseWait =>
      'ਚਿੱਤਰ ਬਣਾਇਆ ਜਾ ਰਿਹਾ ਹੈ... ਕਿਰਪਾ ਕਰਕੇ ਉਡੀਕ ਕਰੋ';

  @override
  String get asImage => 'ਚਿੱਤਰ ਵਜੋਂ';

  @override
  String get asText => 'ਟੈਕਸਟ ਵਜੋਂ';

  @override
  String get playFromSelectedAyah => 'ਚੁਣੀ ਹੋਈ ਆਇਤ ਤੋਂ ਚਲਾਓ';

  @override
  String get toTafsir => 'ਤਫਸੀਰ \'ਤੇ ਜਾਓ';

  @override
  String get selectAyah => 'ਆਇਤ ਚੁਣੋ';

  @override
  String get toAyah => 'ਆਇਤ \'ਤੇ ਜਾਓ';

  @override
  String get searchForASurah => 'ਇੱਕ ਸੂਰਾ ਦੀ ਖੋਜ ਕਰੋ';

  @override
  String get bugReportTitle => 'ਬੱਗ ਦੀ ਰਿਪੋਰਟ';

  @override
  String get audioCached => 'ਆਡੀਓ ਕੈਸ਼ ਹੋ ਗਿਆ ਹੈ';

  @override
  String get others => 'ਹੋਰ';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'ਕੁਰਾਨ|ਅਨੁਵਾਦ|ਆਇਤ, ਇੱਕ ਲਾਜ਼ਮੀ ਤੌਰ \'ਤੇ ਯੋਗ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ';

  @override
  String get quranFontSize => 'ਕੁਰਾਨ ਫੌਂਟ ਦਾ ਆਕਾਰ';

  @override
  String get quranLineHeight => 'ਕੁਰਾਨ ਲਾਈਨ ਦੀ ਉਚਾਈ';

  @override
  String get translationAndTafsirFontSize => 'ਅਨੁਵਾਦ ਅਤੇ ਤਫਸੀਰ ਫੌਂਟ ਦਾ ਆਕਾਰ';

  @override
  String get quranAyah => 'ਕੁਰਾਨ ਦੀ ਆਇਤ';

  @override
  String get topToolbar => 'ਸਿਖਰ ਟੂਲਬਾਰ';

  @override
  String get keepOpenWordByWord => 'ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਖੁੱਲ੍ਹਾ ਰੱਖੋ';

  @override
  String get wordByWordHighlight => 'ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਹਾਈਲਾਈਟ';

  @override
  String get quranScriptSettings => 'ਕੁਰਾਨ ਲਿਪੀ ਦੀਆਂ ਸੈਟਿੰਗਾਂ';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'ਸਫ਼ਾ: ';

  @override
  String get quranResources => 'ਕੁਰਾਨ ਦੇ ਸਰੋਤ';

  @override
  String alreadySelected(String name) {
    return 'ਭਾਸ਼ਾ \'$name\' ਪਹਿਲਾਂ ਹੀ ਚੁਣੀ ਹੋਈ ਹੈ।';
  }

  @override
  String get unableToGetCompassData => 'ਕੰਪਾਸ ਡਾਟਾ ਪ੍ਰਾਪਤ ਕਰਨ ਵਿੱਚ ਅਸਮਰੱਥ';

  @override
  String get deviceDoesNotHaveSensors => 'ਡਿਵਾਈਸ ਵਿੱਚ ਸੈਂਸਰ ਨਹੀਂ ਹਨ!';

  @override
  String get north => 'ਉੱ';

  @override
  String get east => 'ਪੂ';

  @override
  String get south => 'ਦੱ';

  @override
  String get west => 'ਪੱ';

  @override
  String get address => 'ਪਤਾ: ';

  @override
  String get change => 'ਬਦਲੋ';

  @override
  String get calculationMethod => 'ਗਣਨਾ ਵਿਧੀ: ';

  @override
  String get downloadPrayerTime => 'ਨਮਾਜ਼ ਦਾ ਸਮਾਂ ਡਾਊਨਲੋਡ ਕਰੋ';

  @override
  String get calculationMethodsListEmpty => 'ਗਣਨਾ ਵਿਧੀਆਂ ਦੀ ਸੂਚੀ ਖਾਲੀ ਹੈ।';

  @override
  String get noCalculationMethodWithLocationData =>
      'ਸਥਾਨ ਡੇਟਾ ਨਾਲ ਕੋਈ ਗਣਨਾ ਵਿਧੀ ਨਹੀਂ ਮਿਲੀ।';

  @override
  String get prayerSettings => 'ਨਮਾਜ਼ ਸੈਟਿੰਗਾਂ';

  @override
  String get reminderSettings => 'ਰੀਮਾਈਂਡਰ ਸੈਟਿੰਗਾਂ';

  @override
  String get adjustReminderTime => 'ਰੀਮਾਈਂਡਰ ਦਾ ਸਮਾਂ ਵਿਵਸਥਿਤ ਕਰੋ';

  @override
  String get enforceAlarmSound => 'ਅਲਾਰਮ ਦੀ ਆਵਾਜ਼ ਨੂੰ ਲਾਗੂ ਕਰੋ';

  @override
  String get enforceAlarmSoundDescription =>
      'ਜੇਕਰ ਚਾਲੂ ਕੀਤਾ ਜਾਵੇ, ਤਾਂ ਇਹ ਵਿਸ਼ੇਸ਼ਤਾ ਅਲਾਰਮ ਨੂੰ ਇੱਥੇ ਸੈੱਟ ਕੀਤੇ ਵਾਲੀਅਮ \'ਤੇ ਵਜਾਏਗੀ, ਭਾਵੇਂ ਤੁਹਾਡੇ ਫ਼ੋਨ ਦਾ ਵਾਲੀਅਮ ਘੱਟ ਹੋਵੇ। ਇਸ ਨਾਲ ਇਹ ਯਕੀਨੀ ਹੋ ਜਾਵੇਗਾ ਕਿ ਤੁਸੀਂ ਫ਼ੋਨ ਦਾ ਵਾਲੀਅਮ ਘੱਟ ਹੋਣ ਕਾਰਨ ਅਲਾਰਮ ਸੁਣਨ ਤੋਂ ਵਾਂਝੇ ਨਹੀਂ ਰਹੋਗੇ।';

  @override
  String get volume => 'ਆਵਾਜ਼';

  @override
  String get atPrayerTime => 'ਨਮਾਜ਼ ਦੇ ਸਮੇਂ';

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
    return '$prayerName ਦਾ ਸਮਾਂ $prayerTime ਵਜੇ ਹੈ';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName ਦਾ ਸਮਾਂ ਹੋ ਗਿਆ ਹੈ';
  }

  @override
  String get stopTheAdhan => 'ਅਜ਼ਾਨ ਨੂੰ ਰੋਕੋ';

  @override
  String dateFoundEmpty(String date) {
    return '$date ਖਾਲੀ ਪਾਇਆ ਗਿਆ';
  }

  @override
  String get today => 'ਅੱਜ';

  @override
  String get left => 'ਬਾਕੀ';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName ਲਈ ਰੀਮਾਈਂਡਰ ਜੋੜਿਆ ਗਿਆ';
  }

  @override
  String get allowNotificationPermission =>
      'ਇਸ ਵਿਸ਼ੇਸ਼ਤਾ ਦੀ ਵਰਤੋਂ ਕਰਨ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਸੂਚਨਾ ਦੀ ਇਜਾਜ਼ਤ ਦਿਓ';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName ਲਈ ਰੀਮਾਈਂਡਰ ਹਟਾ ਦਿੱਤਾ ਗਿਆ';
  }

  @override
  String get getPrayerTimesAndQibla => 'ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਅਤੇ ਕਿਬਲਾ ਪ੍ਰਾਪਤ ਕਰੋ';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'ਕਿਸੇ ਵੀ ਦਿੱਤੇ ਸਥਾਨ ਲਈ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਅਤੇ ਕਿਬਲਾ ਦੀ ਗਣਨਾ ਕਰੋ।';

  @override
  String get getFromGPS => 'GPS ਤੋਂ ਪ੍ਰਾਪਤ ਕਰੋ';

  @override
  String get or => 'ਜਾਂ';

  @override
  String get selectYourCity => 'ਆਪਣਾ ਸ਼ਹਿਰ ਚੁਣੋ';

  @override
  String get noteAboutGPS =>
      'ਨੋਟ: ਜੇਕਰ ਤੁਸੀਂ GPS ਦੀ ਵਰਤੋਂ ਨਹੀਂ ਕਰਨਾ ਚਾਹੁੰਦੇ ਜਾਂ ਸੁਰੱਖਿਅਤ ਮਹਿਸੂਸ ਨਹੀਂ ਕਰਦੇ ਹੋ, ਤਾਂ ਤੁਸੀਂ ਆਪਣਾ ਸ਼ਹਿਰ ਚੁਣ ਸਕਦੇ ਹੋ।';

  @override
  String get downloadingLocationResources =>
      'ਸਥਾਨ ਦੇ ਸਰੋਤ ਡਾਊਨਲੋਡ ਹੋ ਰਹੇ ਹਨ...';

  @override
  String get somethingWentWrong => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ';

  @override
  String get selectYourCountry => 'ਆਪਣਾ ਦੇਸ਼ ਚੁਣੋ';

  @override
  String get searchForACountry => 'ਇੱਕ ਦੇਸ਼ ਦੀ ਖੋਜ ਕਰੋ';

  @override
  String get selectYourAdministrator => 'ਆਪਣਾ ਪ੍ਰਸ਼ਾਸਕ ਚੁਣੋ';

  @override
  String get searchForAnAdministrator => 'ਇੱਕ ਪ੍ਰਸ਼ਾਸਕ ਦੀ ਖੋਜ ਕਰੋ';

  @override
  String get searchForACity => 'ਇੱਕ ਸ਼ਹਿਰ ਦੀ ਖੋਜ ਕਰੋ';

  @override
  String get pleaseEnableLocationService => 'ਕਿਰਪਾ ਕਰਕੇ ਸਥਾਨ ਸੇਵਾ ਨੂੰ ਚਾਲੂ ਕਰੋ';

  @override
  String get donateUs => 'ਸਾਨੂੰ ਦਾਨ ਕਰੋ';

  @override
  String get underDevelopment => 'ਵਿਕਾਸ ਅਧੀਨ';

  @override
  String get versionLoading => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get alQuran => 'ਅਲ ਕੁਰਾਨ';

  @override
  String get mainMenu => 'ਮੁੱਖ ਮੇਨੂ';

  @override
  String get notes => 'ਨੋਟਸ';

  @override
  String get pinned => 'ਪਿੰਨ ਕੀਤਾ';

  @override
  String get jumpToAyah => 'ਆਇਤ \'ਤੇ ਜਾਓ';

  @override
  String get shareMultipleAyah => 'ਕਈ ਆਇਤਾਂ ਸਾਂਝੀਆਂ ਕਰੋ';

  @override
  String get shareThisApp => 'ਇਸ ਐਪ ਨੂੰ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get giveRating => 'ਰੇਟਿੰਗ ਦਿਓ';

  @override
  String get bugReport => 'ਬੱਗ ਦੀ ਰਿਪੋਰਟ ਕਰੋ';

  @override
  String get privacyPolicy => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ';

  @override
  String get aboutTheApp => 'ਐਪ ਬਾਰੇ';

  @override
  String get resetTheApp => 'ਐਪ ਨੂੰ ਰੀਸੈਟ ਕਰੋ';

  @override
  String get resetAppWarningTitle => 'ਐਪ ਡੇਟਾ ਨੂੰ ਰੀਸੈਟ ਕਰੋ';

  @override
  String get resetAppWarningMessage =>
      'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ \'ਤੇ ਐਪ ਨੂੰ ਰੀਸੈਟ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ? ਤੁਹਾਡਾ ਸਾਰਾ ਡੇਟਾ ਮਿਟ ਜਾਵੇਗਾ, ਅਤੇ ਤੁਹਾਨੂੰ ਐਪ ਨੂੰ ਸ਼ੁਰੂ ਤੋਂ ਸੈਟ ਅਪ ਕਰਨ ਦੀ ਲੋੜ ਹੋਵੇਗੀ।';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get reset => 'ਰੀਸੈਟ';

  @override
  String get shareAppSubject => 'ਇਸ ਅਲ ਕੁਰਾਨ ਐਪ ਨੂੰ ਦੇਖੋ!';

  @override
  String shareAppBody(String appLink) {
    return 'ਅਸਲਾਮੁਅਲੈਕੁਮ! ਰੋਜ਼ਾਨਾ ਪੜ੍ਹਨ ਅਤੇ ਵਿਚਾਰ ਕਰਨ ਲਈ ਇਸ ਅਲ ਕੁਰਾਨ ਐਪ ਨੂੰ ਦੇਖੋ। ਇਹ ਅੱਲ੍ਹਾ ਦੇ ਸ਼ਬਦਾਂ ਨਾਲ ਜੁੜਨ ਵਿੱਚ ਮਦਦ ਕਰਦਾ ਹੈ। ਇੱਥੋਂ ਡਾਊਨਲੋਡ ਕਰੋ: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ਦਰਾਜ਼ ਖੋਲ੍ਹੋ';

  @override
  String get quran => 'ਕੁਰਾਨ';

  @override
  String get prayer => 'ਨਮਾਜ਼';

  @override
  String get qibla => 'ਕਿਬਲਾ';

  @override
  String get audio => 'ਆਡੀਓ';

  @override
  String get surah => 'ਸੂਰਾ';

  @override
  String get pages => 'ਸਫ਼ੇ';

  @override
  String get note => 'ਨੋਟ:';

  @override
  String get linkedAyahs => 'ਜੁੜੀਆਂ ਆਇਤਾਂ:';

  @override
  String get emptyNoteCollection =>
      'ਇਹ ਨੋਟ ਸੰਗ੍ਰਹਿ ਖਾਲੀ ਹੈ।\nਇੱਥੇ ਉਹਨਾਂ ਨੂੰ ਦੇਖਣ ਲਈ ਕੁਝ ਨੋਟਸ ਸ਼ਾਮਲ ਕਰੋ।';

  @override
  String get emptyPinnedCollection =>
      'ਇਸ ਸੰਗ੍ਰਹਿ ਵਿੱਚ ਅਜੇ ਤੱਕ ਕੋਈ ਆਇਤ ਪਿੰਨ ਨਹੀਂ ਕੀਤੀ ਗਈ ਹੈ।\nਇੱਥੇ ਉਹਨਾਂ ਨੂੰ ਦੇਖਣ ਲਈ ਆਇਤਾਂ ਨੂੰ ਪਿੰਨ ਕਰੋ।';

  @override
  String get noContentAvailable => 'ਕੋਈ ਸਮੱਗਰੀ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String failedToLoadCollections(String error) {
    return 'ਸੰਗ੍ਰਹਿ ਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType ਨਾਮ ਦੁਆਰਾ ਖੋਜ ਕਰੋ...';
  }

  @override
  String get sortBy => 'ਇਸ ਅਨੁਸਾਰ ਕ੍ਰਮਬੱਧ ਕਰੋ';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'ਅਜੇ ਤੱਕ ਕੋਈ $collectionType ਸ਼ਾਮਲ ਨਹੀਂ ਕੀਤਾ ਗਿਆ ਹੈ';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count ਪਿੰਨ ਕੀਤੀਆਂ ਆਈਟਮਾਂ';
  }

  @override
  String notesCount(int count) {
    return '$count ਨੋਟਸ';
  }

  @override
  String get emptyNameNotAllowed => 'ਖਾਲੀ ਨਾਮ ਦੀ ਇਜਾਜ਼ਤ ਨਹੀਂ ਹੈ';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName ਵਿੱਚ ਅੱਪਡੇਟ ਕੀਤਾ ਗਿਆ';
  }

  @override
  String get changeName => 'ਨਾਮ ਬਦਲੋ';

  @override
  String get changeColor => 'ਰੰਗ ਬਦਲੋ';

  @override
  String get colorUpdated => 'ਰੰਗ ਅੱਪਡੇਟ ਹੋ ਗਿਆ ਹੈ';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ਮਿਟਾਇਆ ਗਿਆ';
  }

  @override
  String get delete => 'ਮਿਟਾਓ';

  @override
  String get save => 'ਸੇਵ ਕਰੋ';

  @override
  String get collectionNameCannotBeEmpty => 'ਸੰਗ੍ਰਹਿ ਦਾ ਨਾਮ ਖਾਲੀ ਨਹੀਂ ਹੋ ਸਕਦਾ।';

  @override
  String get addedNewCollection => 'ਨਵਾਂ ਸੰਗ੍ਰਹਿ ਜੋੜਿਆ ਗਿਆ';

  @override
  String ayahCount(int count) {
    return '$count ਆਇਤ';
  }

  @override
  String get byNameAtoZ => 'ਨਾਮ ਅ-ੜ';

  @override
  String get byNameZtoA => 'ਨਾਮ ੜ-ਅ';

  @override
  String get byElementNumberAscending => 'ਤੱਤ ਨੰਬਰ ਵੱਧਦਾ';

  @override
  String get byElementNumberDescending => 'ਤੱਤ ਨੰਬਰ ਘੱਟਦਾ';

  @override
  String get byUpdateDateAscending => 'ਅੱਪਡੇਟ ਮਿਤੀ ਵੱਧਦੀ';

  @override
  String get byUpdateDateDescending => 'ਅੱਪਡੇਟ ਮਿਤੀ ਘੱਟਦੀ';

  @override
  String get byCreateDateAscending => 'ਬਣਾਉਣ ਦੀ ਮਿਤੀ ਵੱਧਦੀ';

  @override
  String get byCreateDateDescending => 'ਬਣਾਉਣ ਦੀ ਮਿਤੀ ਘੱਟਦੀ';

  @override
  String get translationNotFound => 'ਅਨੁਵਾਦ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get translationTitle => 'ਅਨੁਵਾਦ:';

  @override
  String get footNoteTitle => 'ਫੁਟ ਨੋਟ:';

  @override
  String get wordByWordTranslation => 'ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਅਨੁਵਾਦ:';

  @override
  String get tafsirButton => 'ਤਫਸੀਰ';

  @override
  String get shareButton => 'ਸਾਂਝਾ ਕਰੋ';

  @override
  String get addNoteButton => 'ਨੋਟ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get pinToCollectionButton => 'ਸੰਗ੍ਰਹਿ ਵਿੱਚ ਪਿੰਨ ਕਰੋ';

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
  String get noteContentCannotBeEmpty => 'ਨੋਟ ਦੀ ਸਮੱਗਰੀ ਖਾਲੀ ਨਹੀਂ ਹੋ ਸਕਦੀ।';

  @override
  String get noteSavedSuccessfully => 'ਨੋਟ ਸਫਲਤਾਪੂਰਵਕ ਸੇਵ ਕੀਤਾ ਗਿਆ!';

  @override
  String get selectCollections => 'ਸੰਗ੍ਰਹਿ ਚੁਣੋ';

  @override
  String get addNote => 'ਨੋਟ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get writeCollectionName => 'ਸੰਗ੍ਰਹਿ ਦਾ ਨਾਮ ਲਿਖੋ...';

  @override
  String get noCollectionsYetAddANewOne =>
      'ਅਜੇ ਤੱਕ ਕੋਈ ਸੰਗ੍ਰਹਿ ਨਹੀਂ ਹੈ। ਇੱਕ ਨਵਾਂ ਸ਼ਾਮਲ ਕਰੋ!';

  @override
  String get pleaseWriteYourNoteFirst => 'ਕਿਰਪਾ ਕਰਕੇ ਪਹਿਲਾਂ ਆਪਣਾ ਨੋਟ ਲਿਖੋ।';

  @override
  String get noCollectionSelected => 'ਕੋਈ ਸੰਗ੍ਰਹਿ ਨਹੀਂ ਚੁਣਿਆ ਗਿਆ';

  @override
  String get saveNote => 'ਨੋਟ ਸੇਵ ਕਰੋ';

  @override
  String get nextSelectCollections => 'ਅੱਗੇ: ਸੰਗ੍ਰਹਿ ਚੁਣੋ';

  @override
  String get addToPinned => 'ਪਿੰਨ ਕੀਤੇ ਵਿੱਚ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get pinnedSavedSuccessfully => 'ਪਿੰਨ ਸਫਲਤਾਪੂਰਵਕ ਸੇਵ ਕੀਤਾ ਗਿਆ!';

  @override
  String get savePinned => 'ਪਿੰਨ ਕੀਤੇ ਨੂੰ ਸੇਵ ਕਰੋ';

  @override
  String get closeAudioController => 'ਆਡੀਓ ਕੰਟਰੋਲਰ ਬੰਦ ਕਰੋ';

  @override
  String get previous => 'ਪਿਛਲਾ';

  @override
  String get rewind => 'ਪਿੱਛੇ ਕਰੋ';

  @override
  String get fastForward => 'ਅੱਗੇ ਵਧਾਓ';

  @override
  String get playNextAyah => 'ਅਗਲੀ ਆਇਤ ਚਲਾਓ';

  @override
  String get repeat => 'ਦੁਹਰਾਓ';

  @override
  String get playAsPlaylist => 'ਪਲੇਲਿਸਟ ਵਜੋਂ ਚਲਾਓ';

  @override
  String style(String style) {
    return 'ਸ਼ੈਲੀ: $style';
  }

  @override
  String get stopAndClose => 'ਰੋਕੋ ਅਤੇ ਬੰਦ ਕਰੋ';

  @override
  String get play => 'ਚਲਾਓ';

  @override
  String get pause => 'ਰੋਕੋ';

  @override
  String get selectReciter => 'ਕਰੀ ਚੁਣੋ';

  @override
  String source(String source) {
    return 'ਸਰੋਤ: $source';
  }

  @override
  String get newText => 'ਨਵਾਂ';

  @override
  String get more => 'ਹੋਰ: ';

  @override
  String get cacheNotFound => 'ਕੈਸ਼ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get cacheSize => 'ਕੈਸ਼ ਦਾ ਆਕਾਰ';

  @override
  String error(String error) {
    return 'ਗਲਤੀ: $error';
  }

  @override
  String get clean => 'ਸਾਫ਼ ਕਰੋ';

  @override
  String get lastModified => 'ਆਖਰੀ ਸੋਧ';

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
      'ਐਂਡਰੌਇਡ, ਆਈਓਐਸ, ਮੈਕਓਐਸ, ਵੈੱਬ, ਲੀਨਕਸ ਅਤੇ ਵਿੰਡੋਜ਼ ਲਈ ਇੱਕ ਵਿਆਪਕ ਇਸਲਾਮੀ ਐਪਲੀਕੇਸ਼ਨ, ਜੋ ਤਫਸੀਰ ਅਤੇ ਕਈ ਅਨੁਵਾਦਾਂ (ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਸਮੇਤ) ਨਾਲ ਕੁਰਾਨ ਪੜ੍ਹਨ, ਨੋਟੀਫਿਕੇਸ਼ਨਾਂ ਨਾਲ ਦੁਨੀਆ ਭਰ ਦੇ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ, ਕਿਬਲਾ ਕੰਪਾਸ, ਅਤੇ ਸਮਕਾਲੀ ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਆਡੀਓ ਪਾਠ ਦੀ ਪੇਸ਼ਕਸ਼ ਕਰਦੀ ਹੈ।';

  @override
  String get dataSourcesNote =>
      'ਨੋਟ: ਕੁਰਾਨ ਦੇ ਪਾਠ, ਤਫਸੀਰ, ਅਨੁਵਾਦ, ਅਤੇ ਆਡੀਓ ਸਰੋਤ Quran.com, Everyayah.com, ਅਤੇ ਹੋਰ ਪ੍ਰਮਾਣਿਤ ਖੁੱਲ੍ਹੇ ਸਰੋਤਾਂ ਤੋਂ ਲਏ ਗਏ ਹਨ।';

  @override
  String get adFreePromise =>
      'ਇਹ ਐਪ ਅੱਲ੍ਹਾ ਦੀ ਰਜ਼ਾ ਹਾਸਲ ਕਰਨ ਲਈ ਬਣਾਈ ਗਈ ਹੈ। ਇਸ ਲਈ, ਇਹ ਪੂਰੀ ਤਰ੍ਹਾਂ ਵਿਗਿਆਪਨ-ਮੁਕਤ ਹੈ ਅਤੇ ਹਮੇਸ਼ਾ ਰਹੇਗੀ।';

  @override
  String get coreFeatures => 'ਮੁੱਖ ਵਿਸ਼ੇਸ਼ਤਾਵਾਂ';

  @override
  String get coreFeaturesDescription =>
      'ਉਹਨਾਂ ਮੁੱਖ ਕਾਰਜਕੁਸ਼ਲਤਾਵਾਂ ਦੀ ਪੜਚੋਲ ਕਰੋ ਜੋ ਅਲ ਕੁਰਾਨ v3 ਨੂੰ ਤੁਹਾਡੇ ਰੋਜ਼ਾਨਾ ਇਸਲਾਮੀ ਅਭਿਆਸਾਂ ਲਈ ਇੱਕ ਲਾਜ਼ਮੀ ਸਾਧਨ ਬਣਾਉਂਦੀਆਂ ਹਨ:';

  @override
  String get prayerTimesTitle => 'ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਅਤੇ ਅਲਰਟ';

  @override
  String get prayerTimesDescription =>
      'ਵੱਖ-ਵੱਖ ਗਣਨਾ ਵਿਧੀਆਂ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਦੁਨੀਆ ਭਰ ਦੇ ਕਿਸੇ ਵੀ ਸਥਾਨ ਲਈ ਸਹੀ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ। ਅਜ਼ਾਨ ਸੂਚਨਾਵਾਂ ਨਾਲ ਰੀਮਾਈਂਡਰ ਸੈਟ ਕਰੋ।';

  @override
  String get qiblaDirectionTitle => 'ਕਿਬਲਾ ਦੀ ਦਿਸ਼ਾ';

  @override
  String get qiblaDirectionDescription =>
      'ਇੱਕ ਸਪਸ਼ਟ ਅਤੇ ਸਹੀ ਕੰਪਾਸ ਦ੍ਰਿਸ਼ ਨਾਲ ਕਿਬਲਾ ਦੀ ਦਿਸ਼ਾ ਆਸਾਨੀ ਨਾਲ ਲੱਭੋ।';

  @override
  String get translationTafsirTitle => 'ਕੁਰਾਨ ਅਨੁਵਾਦ ਅਤੇ ਤਫਸੀਰ';

  @override
  String get translationTafsirDescription =>
      '69 ਭਾਸ਼ਾਵਾਂ ਵਿੱਚ 120+ ਅਨੁਵਾਦ ਕਿਤਾਬਾਂ (ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਸਮੇਤ), ਅਤੇ 30+ ਤਫਸੀਰ ਕਿਤਾਬਾਂ ਤੱਕ ਪਹੁੰਚ ਕਰੋ।';

  @override
  String get wordByWordAudioTitle => 'ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਆਡੀਓ ਅਤੇ ਹਾਈਲਾਈਟਿੰਗ';

  @override
  String get wordByWordAudioDescription =>
      'ਇੱਕ ਡੂੰਘੇ ਸਿੱਖਣ ਦੇ ਤਜਰਬੇ ਲਈ ਸਮਕਾਲੀ ਸ਼ਬਦ-ਬ-ਸ਼ਬਦ ਆਡੀਓ ਪਾਠ ਅਤੇ ਹਾਈਲਾਈਟਿੰਗ ਦੇ ਨਾਲ-ਨਾਲ ਚੱਲੋ।';

  @override
  String get ayahAudioRecitationTitle => 'ਆਇਤ ਆਡੀਓ ਪਾਠ';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ ਤੋਂ ਵੱਧ ਪ੍ਰਸਿੱਧ ਕਰੀਆਂ ਤੋਂ ਪੂਰੀ ਆਇਤ ਦੇ ਪਾਠ ਸੁਣੋ।';

  @override
  String get notesCloudBackupTitle => 'ਕਲਾਉਡ ਬੈਕਅਪ ਨਾਲ ਨੋਟਸ';

  @override
  String get notesCloudBackupDescription =>
      'ਨਿੱਜੀ ਨੋਟਸ ਅਤੇ ਵਿਚਾਰਾਂ ਨੂੰ ਸੁਰੱਖਿਅਤ ਕਰੋ, ਕਲਾਉਡ ਵਿੱਚ ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਬੈਕਅੱਪ ਕੀਤਾ ਗਿਆ (ਵਿਸ਼ੇਸ਼ਤਾ ਵਿਕਾਸ ਅਧੀਨ/ਜਲਦੀ ਆ ਰਹੀ ਹੈ)।';

  @override
  String get crossPlatformSupportTitle => 'ਕਰਾਸ-ਪਲੇਟਫਾਰਮ ਸਹਾਇਤਾ';

  @override
  String get crossPlatformSupportDescription =>
      'ਐਂਡਰੌਇਡ, ਵੈੱਬ, ਲੀਨਕਸ, ਅਤੇ ਵਿੰਡੋਜ਼ \'ਤੇ ਸਮਰਥਿਤ।';

  @override
  String get backgroundAudioPlaybackTitle => 'ਬੈਕਗ੍ਰਾਉਂਡ ਆਡੀਓ ਪਲੇਬੈਕ';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ਜਦੋਂ ਐਪ ਬੈਕਗ੍ਰਾਉਂਡ ਵਿੱਚ ਹੋਵੇ ਤਾਂ ਵੀ ਕੁਰਾਨ ਦਾ ਪਾਠ ਸੁਣਨਾ ਜਾਰੀ ਰੱਖੋ।';

  @override
  String get audioDataCachingTitle => 'ਆਡੀਓ ਅਤੇ ਡਾਟਾ ਕੈਸ਼ਿੰਗ';

  @override
  String get audioDataCachingDescription =>
      'ਮਜ਼ਬੂਤ ਆਡੀਓ ਅਤੇ ਕੁਰਾਨ ਡਾਟਾ ਕੈਸ਼ਿੰਗ ਨਾਲ ਬਿਹਤਰ ਪਲੇਬੈਕ ਅਤੇ ਔਫਲਾਈਨ ਸਮਰੱਥਾਵਾਂ।';

  @override
  String get minimalisticInterfaceTitle => 'ਘੱਟੋ-ਘੱਟ ਅਤੇ ਸਾਫ਼ ਇੰਟਰਫੇਸ';

  @override
  String get minimalisticInterfaceDescription =>
      'ਉਪਭੋਗਤਾ ਅਨੁਭਵ ਅਤੇ ਪੜ੍ਹਨਯੋਗਤਾ \'ਤੇ ਧਿਆਨ ਕੇਂਦ੍ਰਤ ਕਰਨ ਵਾਲਾ ਨੈਵੀਗੇਟ ਕਰਨ ਵਿੱਚ ਆਸਾਨ ਇੰਟਰਫੇਸ।';

  @override
  String get optimizedPerformanceTitle => 'ਅਨੁਕੂਲਿਤ ਪ੍ਰਦਰਸ਼ਨ ਅਤੇ ਆਕਾਰ';

  @override
  String get optimizedPerformanceDescription =>
      'ਇੱਕ ਵਿਸ਼ੇਸ਼ਤਾ-ਅਮੀਰ ਐਪਲੀਕੇਸ਼ਨ ਜੋ ਹਲਕਾ ਅਤੇ ਪ੍ਰਦਰਸ਼ਨਕਾਰੀ ਹੋਣ ਲਈ ਤਿਆਰ ਕੀਤੀ ਗਈ ਹੈ।';

  @override
  String get languageSupport => 'ਭਾਸ਼ਾ ਸਹਾਇਤਾ';

  @override
  String get languageSupportDescription =>
      'ਇਹ ਐਪਲੀਕੇਸ਼ਨ ਹੇਠ ਲਿਖੀਆਂ ਭਾਸ਼ਾਵਾਂ (ਅਤੇ ਹੋਰ ਲਗਾਤਾਰ ਸ਼ਾਮਲ ਕੀਤੀਆਂ ਜਾ ਰਹੀਆਂ ਹਨ) ਦੇ ਸਮਰਥਨ ਨਾਲ ਇੱਕ ਗਲੋਬਲ ਦਰਸ਼ਕਾਂ ਲਈ ਪਹੁੰਚਯੋਗ ਹੋਣ ਲਈ ਤਿਆਰ ਕੀਤੀ ਗਈ ਹੈ:';

  @override
  String get technologyAndResources => 'ਤਕਨਾਲੋਜੀ ਅਤੇ ਸਰੋਤ';

  @override
  String get technologyAndResourcesDescription =>
      'ਇਹ ਐਪ ਅਤਿ-ਆਧੁਨਿਕ ਤਕਨਾਲੋਜੀਆਂ ਅਤੇ ਭਰੋਸੇਯੋਗ ਸਰੋਤਾਂ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਬਣਾਈ ਗਈ ਹੈ:';

  @override
  String get flutterFrameworkTitle => 'ਫਲਟਰ ਫਰੇਮਵਰਕ';

  @override
  String get flutterFrameworkDescription =>
      'ਇੱਕ ਸਿੰਗਲ ਕੋਡਬੇਸ ਤੋਂ ਇੱਕ ਸੁੰਦਰ, ਨੇਟਿਵ ਤੌਰ \'ਤੇ ਕੰਪਾਇਲ ਕੀਤੇ, ਬਹੁ-ਪਲੇਟਫਾਰਮ ਅਨੁਭਵ ਲਈ ਫਲਟਰ ਨਾਲ ਬਣਾਇਆ ਗਿਆ ਹੈ।';

  @override
  String get advancedAudioEngineTitle => 'ਉੱਨਤ ਆਡੀਓ ਇੰਜਣ';

  @override
  String get advancedAudioEngineDescription =>
      'ਮਜ਼ਬੂਤ ਆਡੀਓ ਪਲੇਬੈਕ ਅਤੇ ਨਿਯੰਤਰਣ ਲਈ `just_audio` ਅਤੇ `just_audio_background` ਫਲਟਰ ਪੈਕੇਜਾਂ ਦੁਆਰਾ ਸੰਚਾਲਿਤ।';

  @override
  String get reliableQuranDataTitle => 'ਭਰੋਸੇਯੋਗ ਕੁਰਾਨ ਡਾਟਾ';

  @override
  String get reliableQuranDataDescription =>
      'ਅਲ ਕੁਰਾਨ ਦੇ ਪਾਠ, ਅਨੁਵਾਦ, ਤਫਸੀਰ, ਅਤੇ ਆਡੀਓ Quran.com ਅਤੇ Everyayah.com ਵਰਗੇ ਪ੍ਰਮਾਣਿਤ ਖੁੱਲ੍ਹੇ APIs ਅਤੇ ਡੇਟਾਬੇਸ ਤੋਂ ਪ੍ਰਾਪਤ ਕੀਤੇ ਜਾਂਦੇ ਹਨ।';

  @override
  String get prayerTimeEngineTitle => 'ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਦਾ ਇੰਜਣ';

  @override
  String get prayerTimeEngineDescription =>
      'ਸਹੀ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਲਈ ਸਥਾਪਿਤ ਗਣਨਾ ਵਿਧੀਆਂ ਦੀ ਵਰਤੋਂ ਕਰਦਾ ਹੈ। ਸੂਚਨਾਵਾਂ `flutter_local_notifications` ਅਤੇ ਬੈਕਗ੍ਰਾਉਂਡ ਕਾਰਜਾਂ ਦੁਆਰਾ ਸੰਭਾਲੀਆਂ ਜਾਂਦੀਆਂ ਹਨ।';

  @override
  String get crossPlatformSupport => 'ਕਰਾਸ ਪਲੇਟਫਾਰਮ ਸਹਾਇਤਾ';

  @override
  String get crossPlatformSupportDescription2 =>
      'ਵੱਖ-ਵੱਖ ਪਲੇਟਫਾਰਮਾਂ \'ਤੇ ਸਹਿਜ ਪਹੁੰਚ ਦਾ ਆਨੰਦ ਮਾਣੋ:';

  @override
  String get android => 'ਐਂਡਰੌਇਡ';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'ਵੈੱਬ';

  @override
  String get linux => 'ਲੀਨਕਸ';

  @override
  String get windows => 'ਵਿੰਡੋਜ਼';

  @override
  String get ourLifetimePromise => 'ਸਾਡਾ ਜੀਵਨ ਭਰ ਦਾ ਵਾਅਦਾ';

  @override
  String get lifetimePromiseDescription =>
      'ਮੈਂ ਨਿੱਜੀ ਤੌਰ \'ਤੇ ਇਸ ਐਪਲੀਕੇਸ਼ਨ ਲਈ ਆਪਣੀ ਪੂਰੀ ਜ਼ਿੰਦਗੀ, ਇੰਸ਼ਾਅੱਲ੍ਹਾ, ਨਿਰੰਤਰ ਸਹਾਇਤਾ ਅਤੇ ਰੱਖ-ਰਖਾਅ ਪ੍ਰਦਾਨ ਕਰਨ ਦਾ ਵਾਅਦਾ ਕਰਦਾ ਹਾਂ। ਮੇਰਾ ਟੀਚਾ ਇਹ ਯਕੀਨੀ ਬਣਾਉਣਾ ਹੈ ਕਿ ਇਹ ਐਪ ਆਉਣ ਵਾਲੇ ਸਾਲਾਂ ਲਈ ਉੱਮਤ ਲਈ ਇੱਕ ਲਾਭਦਾਇਕ ਸਰੋਤ ਬਣਿਆ ਰਹੇ।';

  @override
  String get fajr => 'ਫਜਰ';

  @override
  String get sunrise => 'ਸੂਰਜ ਚੜ੍ਹਨਾ';

  @override
  String get dhuhr => 'ਜ਼ੁਹਰ';

  @override
  String get asr => 'ਅਸਰ';

  @override
  String get maghrib => 'ਮਗ਼ਰਿਬ';

  @override
  String get isha => 'ਈਸ਼ਾ';

  @override
  String get midnight => 'ਅੱਧੀ ਰਾਤ';

  @override
  String get alarm => 'ਅਲਾਰਮ';

  @override
  String get notification => 'ਸੂਚਨਾ';

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
  String get quranScriptUthmani => 'ਉਸਮਾਨੀ';

  @override
  String get quranScriptIndopak => 'ਇੰਡੋਪਾਕ';

  @override
  String get sajdaAyah => 'ਸਜਦਾ ਆਇਤ';

  @override
  String get required => 'ਜ਼ਰੂਰੀ';

  @override
  String get optional => 'ਵਿਕਲਪਿਕ';

  @override
  String get notificationScheduleWarning =>
      'ਨੋਟ: ਤੁਹਾਡੇ ਫ਼ੋਨ ਦੇ OS ਬੈਕਗ੍ਰਾਊਂਡ ਪ੍ਰਕਿਰਿਆ ਪਾਬੰਦੀਆਂ ਕਾਰਨ ਅਨੁਸੂਚਿਤ ਸੂਚਨਾ ਜਾਂ ਰੀਮਾਈਂਡਰ ਖੁੰਝ ਸਕਦਾ ਹੈ। ਉਦਾਹਰਨ ਲਈ: Vivo ਦਾ Origin OS, Samsung ਦਾ One UI, Oppo ਦਾ ColorOS ਆਦਿ ਕਈ ਵਾਰ ਅਨੁਸੂਚਿਤ ਸੂਚਨਾ ਜਾਂ ਰੀਮਾਈਂਡਰ ਨੂੰ ਬੰਦ ਕਰ ਦਿੰਦੇ ਹਨ। ਕਿਰਪਾ ਕਰਕੇ ਐਪ ਨੂੰ ਬੈਕਗ੍ਰਾਊਂਡ ਪ੍ਰਕਿਰਿਆ ਤੋਂ ਪ੍ਰਤਿਬੰਧਿਤ ਨਾ ਕਰਨ ਲਈ ਆਪਣੀਆਂ OS ਸੈਟਿੰਗਾਂ ਦੀ ਜਾਂਚ ਕਰੋ।';

  @override
  String get scrollWithRecitation => 'ਪਾਠ ਦੇ ਨਾਲ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get quickAccess => 'ਤੁਰੰਤ ਪਹੁੰਚ';

  @override
  String get initiallyScrollAyah => 'ਸ਼ੁਰੂ ਵਿੱਚ ਆਯਾਹ \'ਤੇ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get tajweedGuide => 'ਤਜਵੀਦ ਗਾਈਡ';
}
