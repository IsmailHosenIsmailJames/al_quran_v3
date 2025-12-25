// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

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
    return '$ayahKey வசனத்திற்கு தஃப்ஸீர் இல்லை';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'தஃப்ஸீர் இங்கே காணப்படும் : $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey க்குச் செல்க';
  }

  @override
  String get hizb => 'ஹிஸ்பு';

  @override
  String get juz => 'ஜுஸ்';

  @override
  String get page => 'பக்கம்';

  @override
  String get ruku => 'ருகூ';

  @override
  String get languageSettings => 'மொழி அமைப்புகள்';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count ஆயத்துகள்';
  }

  @override
  String get saveAndDownload => 'சேமித்து பதிவிறக்கவும்';

  @override
  String get appLanguage => 'பயன்பாட்டின் மொழி';

  @override
  String get selectAppLanguage => 'பயன்பாட்டின் மொழியைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get pleaseSelectOne => 'தயவுசெய்து ஒன்றைத் தேர்ந்தெடுக்கவும்';

  @override
  String get quranTranslationLanguage => 'குர்ஆன் மொழிபெயர்ப்பு மொழி';

  @override
  String get selectTranslationLanguage =>
      'மொழிபெயர்ப்பு மொழியைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get quranTranslationBook => 'குர்ஆன் மொழிபெயர்ப்பு நூல்';

  @override
  String get selectTranslationBook =>
      'மொழிபெயர்ப்பு நூலைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get quranTafsirLanguage => 'குர்ஆன் தஃப்ஸீர் மொழி';

  @override
  String get selectTafsirLanguage => 'தஃப்ஸீர் மொழியைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get quranTafsirBook => 'குர்ஆன் தஃப்ஸீர் நூல்';

  @override
  String get selectTafsirBook => 'தஃப்ஸீர் நூலைத் தேர்ந்தெடுக்கவும்...';

  @override
  String get quranScriptAndStyle => 'குர்ஆன் எழுத்துரு & உடை';

  @override
  String get justAMoment => 'ஒரு கணம்...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'வெற்றி';

  @override
  String get retry => 'மீண்டும் முயலவும்';

  @override
  String get unableToDownloadResources =>
      'வளங்களைப் பதிவிறக்க முடியவில்லை...\nஏதோ தவறு நடந்துவிட்டது';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'பிரித்த குர்ஆன் ஓதலைப் பதிவிறக்குகிறது';

  @override
  String get processingSegmentedQuranRecitation =>
      'பிரித்த குர்ஆன் ஓதலைச் செயல்படுத்துகிறது';

  @override
  String get footnote => 'அடிக்குறிப்பு';

  @override
  String get tafsir => 'தஃப்ஸீர்';

  @override
  String get wordByWord => 'வார்த்தைக்கு வார்த்தை';

  @override
  String get pleaseSelectRequiredOption =>
      'தேவையான விருப்பத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get rememberHomeTab => 'முகப்புப் பக்கத்தை நினைவில் கொள்க';

  @override
  String get rememberHomeTabSubtitle =>
      'செயலி முகப்புத் திரையில் கடைசியாகத் திறந்த பக்கத்தை நினைவில் வைத்திருக்கும்.';

  @override
  String get wakeLock => 'திரை விழிப்புப் பூட்டு';

  @override
  String get wakeLockSubtitle => 'திரை தானாக அணைவதைத் தடுக்கவும்.';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get appTheme => 'செயலியின் தீம்';

  @override
  String get quranStyle => 'குர்ஆன் உடை';

  @override
  String get changeTheme => 'தீம் மாற்றவும்';

  @override
  String get verseCount => 'வசன எண்ணிக்கை: ';

  @override
  String get translation => 'மொழிபெயர்ப்பு';

  @override
  String get tafsirNotFound => 'காணப்படவில்லை';

  @override
  String get moreInfo => 'மேலும் தகவல்';

  @override
  String get playAudio => 'ஆடியோவை இயக்கு';

  @override
  String get preview => 'முன்னோட்டம்';

  @override
  String get loading => 'ஏற்றுகிறது...';

  @override
  String get errorFetchingAddress => 'முகவரியைப் பெறுவதில் பிழை';

  @override
  String get addressNotAvailable => 'முகவரி கிடைக்கவில்லை';

  @override
  String get latitude => 'அட்சரேகை: ';

  @override
  String get longitude => 'தீர்க்கரேகை: ';

  @override
  String get name => 'பெயர்: ';

  @override
  String get location => 'இருப்பிடம்: ';

  @override
  String get parameters => 'அளபுருக்கள்: ';

  @override
  String get selectCalculationMethod => 'கணக்கீட்டு முறையைத் தேர்ந்தெடுக்கவும்';

  @override
  String get shareSelectAyahs => 'தேர்ந்தெடுத்த ஆயத்துகளைப் பகிரவும்';

  @override
  String get selectionEmpty => 'தேர்வு காலியாக உள்ளது';

  @override
  String get generatingImagePleaseWait =>
      'படம் உருவாக்கப்படுகிறது... தயவுசெய்து காத்திருக்கவும்';

  @override
  String get asImage => 'படமாக';

  @override
  String get asText => 'உரையாக';

  @override
  String get playFromSelectedAyah => 'தேர்ந்தெடுத்த ஆயத்திலிருந்து இயக்கு';

  @override
  String get toTafsir => 'தஃப்ஸீருக்கு';

  @override
  String get selectAyah => 'ஆயத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get toAyah => 'ஆயத்திற்கு';

  @override
  String get searchForASurah => 'ஒரு சூராவைத் தேடவும்';

  @override
  String get bugReportTitle => 'பிழை அறிக்கை';

  @override
  String get audioCached => 'ஆடியோ தற்காலிகமாகச் சேமிக்கப்பட்டது';

  @override
  String get others => 'மற்றவை';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'குர்ஆன் | மொழிபெயர்ப்பு | ஆயத், ஒன்றாவது இயக்கப்பட்டிருக்க வேண்டும்';

  @override
  String get quranFontSize => 'குர்ஆன் எழுத்துரு அளவு';

  @override
  String get quranLineHeight => 'குர்ஆன் வரி உயரம்';

  @override
  String get translationAndTafsirFontSize =>
      'மொழிபெயர்ப்பு & தஃப்ஸீர் எழுத்துரு அளவு';

  @override
  String get quranAyah => 'குர்ஆன் ஆயத்';

  @override
  String get topToolbar => 'மேல் கருவிப்பட்டி';

  @override
  String get keepOpenWordByWord =>
      'வார்த்தைக்கு வார்த்தை மொழிபெயர்ப்பைத் திறந்து வைக்கவும்';

  @override
  String get wordByWordHighlight => 'வார்த்தைக்கு வார்த்தை தனிப்படுத்தல்';

  @override
  String get quranScriptSettings => 'குர்ஆன் எழுத்துரு அமைப்புகள்';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'பக்கம்: ';

  @override
  String get quranResources => 'குர்ஆன் வளங்கள்';

  @override
  String alreadySelected(String name) {
    return '\'$name\' மொழி ஏற்கனவே தேர்ந்தெடுக்கப்பட்டுள்ளது.';
  }

  @override
  String get unableToGetCompassData => 'திசைகாட்டித் தரவைப் பெற முடியவில்லை';

  @override
  String get deviceDoesNotHaveSensors => 'சாதனத்தில் சென்சார்கள் இல்லை!';

  @override
  String get north => 'வ';

  @override
  String get east => 'கி';

  @override
  String get south => 'தெ';

  @override
  String get west => 'மே';

  @override
  String get address => 'முகவரி: ';

  @override
  String get change => 'மாற்று';

  @override
  String get calculationMethod => 'கணக்கீட்டு முறை: ';

  @override
  String get downloadPrayerTime => 'தொழுகை நேரத்தைப் பதிவிறக்கவும்';

  @override
  String get calculationMethodsListEmpty =>
      'கணக்கீட்டு முறைகளின் பட்டியல் காலியாக உள்ளது.';

  @override
  String get noCalculationMethodWithLocationData =>
      'இருப்பிடத் தரவுகளுடன் எந்த கணக்கீட்டு முறையையும் கண்டுபிடிக்க முடியவில்லை.';

  @override
  String get prayerSettings => 'தொழுகை அமைப்புகள்';

  @override
  String get reminderSettings => 'நினைவூட்டல் அமைப்புகள்';

  @override
  String get adjustReminderTime => 'நினைவூட்டல் நேரத்தைச் சரிசெய்யவும்';

  @override
  String get enforceAlarmSound => 'அலாரம் ஒலியை அமல்படுத்து';

  @override
  String get enforceAlarmSoundDescription =>
      'இயக்கப்பட்டால், உங்கள் தொலைபேசியின் ஒலி குறைவாக இருந்தாலும், இந்த அம்சம் இங்கே அமைக்கப்பட்ட ஒலியில் அலாரத்தை ஒலிக்கும். இது குறைந்த தொலைபேசி ஒலியால் அலாரத்தைத் தவறவிடுவதைத் தடுக்கிறது.';

  @override
  String get volume => 'ஒலி அளவு';

  @override
  String get atPrayerTime => 'தொழுகை நேரத்தில்';

  @override
  String minBefore(int minutes) {
    return '$minutes நிமிடங்களுக்கு முன்';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes நிமிடங்களுக்குப் பிறகு';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName நேரம் $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'இது $prayerName நேரம்';
  }

  @override
  String get stopTheAdhan => 'பாங்கை நிறுத்து';

  @override
  String dateFoundEmpty(String date) {
    return '$date காலியாகக் கண்டறியப்பட்டது';
  }

  @override
  String get today => 'இன்று';

  @override
  String get left => 'மீதமுள்ளது';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName க்கான நினைவூட்டல் சேர்க்கப்பட்டது';
  }

  @override
  String get allowNotificationPermission =>
      'இந்த அம்சத்தைப் பயன்படுத்த அறிவிப்பு அனுமதியை அனுமதிக்கவும்';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName க்கான நினைவூட்டல் அகற்றப்பட்டது';
  }

  @override
  String get getPrayerTimesAndQibla =>
      'தொழுகை நேரங்கள் மற்றும் கிப்லாவைப் பெறுங்கள்';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'கொடுக்கப்பட்ட எந்த இருப்பிடத்திற்கும் தொழுகை நேரங்கள் மற்றும் கிப்லாவைக் கணக்கிடுங்கள்.';

  @override
  String get getFromGPS => 'ஜி.பி.எஸ் இலிருந்து பெறு';

  @override
  String get or => 'அல்லது';

  @override
  String get selectYourCity => 'உங்கள் நகரத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get noteAboutGPS =>
      'குறிப்பு: நீங்கள் ஜி.பி.எஸ் பயன்படுத்த விரும்பவில்லை அல்லது பாதுகாப்பாக உணரவில்லை என்றால், உங்கள் நகரத்தைத் தேர்ந்தெடுக்கலாம்.';

  @override
  String get downloadingLocationResources =>
      'இருப்பிட வளங்களைப் பதிவிறக்குகிறது...';

  @override
  String get somethingWentWrong => 'ஏதோ தவறு நடந்துவிட்டது';

  @override
  String get selectYourCountry => 'உங்கள் நாட்டைத் தேர்ந்தெடுக்கவும்';

  @override
  String get searchForACountry => 'ஒரு நாட்டைத் தேடவும்';

  @override
  String get selectYourAdministrator =>
      'உங்கள் நிர்வாகப் பகுதியத் தேர்ந்தெடுக்கவும்';

  @override
  String get searchForAnAdministrator => 'ஒரு நிர்வாகப் பகுதியத் தேடவும்';

  @override
  String get searchForACity => 'ஒரு நகரத்தைத் தேடவும்';

  @override
  String get pleaseEnableLocationService =>
      'தயவுசெய்து இருப்பிடச் சேவையை இயக்கவும்';

  @override
  String get donateUs => 'எங்களுக்கு நன்கொடை அளியுங்கள்';

  @override
  String get underDevelopment => 'உருவாக்கத்தில் உள்ளது';

  @override
  String get versionLoading => 'ஏற்றுகிறது...';

  @override
  String get alQuran => 'அல் குர்ஆன்';

  @override
  String get mainMenu => 'முதன்மை பட்டியல்';

  @override
  String get notes => 'குறிப்புகள்';

  @override
  String get pinned => 'பின் செய்யப்பட்டவை';

  @override
  String get jumpToAyah => 'ஆயத்திற்குச் செல்க';

  @override
  String get shareMultipleAyah => 'பல ஆயத்துகளைப் பகிரவும்';

  @override
  String get shareThisApp => 'இந்த பயன்பாட்டைப் பகிரவும்';

  @override
  String get giveRating => 'மதிப்பீடு வழங்கவும்';

  @override
  String get bugReport => 'பிழை அறிக்கை';

  @override
  String get privacyPolicy => 'தனியுரிமைக் கொள்கை';

  @override
  String get aboutTheApp => 'பயன்பாட்டைப் பற்றி';

  @override
  String get resetTheApp => 'பயன்பாட்டை மீட்டமை';

  @override
  String get resetAppWarningTitle => 'பயன்பாட்டுத் தரவை மீட்டமை';

  @override
  String get resetAppWarningMessage =>
      'பயன்பாட்டை மீட்டமைக்க விரும்புகிறீர்களா? உங்கள் எல்லா தரவுகளும் இழக்கப்படும், மேலும் நீங்கள் பயன்பாட்டை ஆரம்பத்தில் இருந்து அமைக்க வேண்டும்.';

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get reset => 'மீட்டமை';

  @override
  String get shareAppSubject => 'இந்த அல் குர்ஆன் செயலியைப் பாருங்கள்!';

  @override
  String shareAppBody(String appLink) {
    return 'அஸ்ஸலாமு அலைக்கும்! தினசரி ஓதுவதற்கும் சிந்திப்பதற்கும் இந்த அல் குர்ஆன் செயலியைப் பாருங்கள். இது அல்லாஹ்வின் வார்த்தைகளுடன் தொடர்பு கொள்ள உதவுகிறது. இங்கே பதிவிறக்கவும்: $appLink';
  }

  @override
  String get openDrawerTooltip => 'பட்டியலைத் திற';

  @override
  String get quran => 'குர்ஆன்';

  @override
  String get prayer => 'தொழுகை';

  @override
  String get qibla => 'கிப்லா';

  @override
  String get audio => 'ஆடியோ';

  @override
  String get surah => 'சூரா';

  @override
  String get pages => 'பக்கங்கள்';

  @override
  String get note => 'குறிப்பு:';

  @override
  String get linkedAyahs => 'இணைக்கப்பட்ட ஆயத்துகள்:';

  @override
  String get emptyNoteCollection =>
      'இந்த குறிப்புத் தொகுப்பு காலியாக உள்ளது.\nஅவற்றை இங்கே காண சில குறிப்புகளைச் சேர்க்கவும்.';

  @override
  String get emptyPinnedCollection =>
      'இந்த தொகுப்பில் இன்னும் ஆயத்துகள் எதுவும் பின் செய்யப்படவில்லை.\nஅவற்றை இங்கே காண ஆயத்துகளைப் பின் செய்யவும்.';

  @override
  String get noContentAvailable => 'உள்ளடக்கம் எதுவும் கிடைக்கவில்லை.';

  @override
  String failedToLoadCollections(String error) {
    return 'தொகுப்புகளை ஏற்றுவதில் தோல்வி: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType பெயரால் தேடவும்...';
  }

  @override
  String get sortBy => 'வரிசைப்படுத்து';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'இன்னும் $collectionType எதுவும் சேர்க்கப்படவில்லை';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count பின் செய்யப்பட்டவை';
  }

  @override
  String notesCount(int count) {
    return '$count குறிப்புகள்';
  }

  @override
  String get emptyNameNotAllowed => 'காலிப் பெயர் அனுமதிக்கப்படாது';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName ஆகப் புதுப்பிக்கப்பட்டது';
  }

  @override
  String get changeName => 'பெயரை மாற்று';

  @override
  String get changeColor => 'நிறத்தை மாற்று';

  @override
  String get colorUpdated => 'நிறம் புதுப்பிக்கப்பட்டது';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName நீக்கப்பட்டது';
  }

  @override
  String get delete => 'நீக்கு';

  @override
  String get save => 'சேமி';

  @override
  String get collectionNameCannotBeEmpty =>
      'தொகுப்பின் பெயர் காலியாக இருக்கக்கூடாது.';

  @override
  String get addedNewCollection => 'புதிய தொகுப்பு சேர்க்கப்பட்டது';

  @override
  String ayahCount(int count) {
    return '$count ஆயத்';
  }

  @override
  String get byNameAtoZ => 'பெயர் அ-Z';

  @override
  String get byNameZtoA => 'பெயர் Z-அ';

  @override
  String get byElementNumberAscending => 'உறுப்பு எண் ஏறுவரிசை';

  @override
  String get byElementNumberDescending => 'உறுப்பு எண் இறங்குவரிசை';

  @override
  String get byUpdateDateAscending => 'புதுப்பித்த தேதி ஏறுவரிசை';

  @override
  String get byUpdateDateDescending => 'புதுப்பித்த தேதி இறங்குவரிசை';

  @override
  String get byCreateDateAscending => 'உருவாக்கிய தேதி ஏறுவரிசை';

  @override
  String get byCreateDateDescending => 'உருவாக்கிய தேதி இறங்குவரிசை';

  @override
  String get translationNotFound => 'மொழிபெயர்ப்பு காணப்படவில்லை';

  @override
  String get translationTitle => 'மொழிபெயர்ப்பு:';

  @override
  String get footNoteTitle => 'அடிக்குறிப்பு:';

  @override
  String get wordByWordTranslation => 'வார்த்தைக்கு வார்த்தை மொழிபெயர்ப்பு:';

  @override
  String get tafsirButton => 'தஃப்ஸீர்';

  @override
  String get shareButton => 'பகிர்';

  @override
  String get addNoteButton => 'குறிப்பு சேர்';

  @override
  String get pinToCollectionButton => 'தொகுப்பில் பின் செய்';

  @override
  String get shareAsText => 'உரையாகப் பகிரவும்';

  @override
  String get copiedWithTafsir => 'தஃப்ஸீருடன் நகலெடுக்கப்பட்டது';

  @override
  String get shareAsImage => 'படமாகப் பகிரவும்';

  @override
  String get shareWithTafsir => 'தஃப்ஸீருடன் பகிரவும்';

  @override
  String get notFound => 'காணப்படவில்லை';

  @override
  String get noteContentCannotBeEmpty =>
      'குறிப்பின் உள்ளடக்கம் காலியாக இருக்கக்கூடாது.';

  @override
  String get noteSavedSuccessfully => 'குறிப்பு வெற்றிகரமாகச் சேமிக்கப்பட்டது!';

  @override
  String get selectCollections => 'தொகுப்புகளைத் தேர்ந்தெடுக்கவும்';

  @override
  String get addNote => 'குறிப்பு சேர்';

  @override
  String get writeCollectionName => 'தொகுப்பின் பெயரை எழுதவும்...';

  @override
  String get noCollectionsYetAddANewOne =>
      'இன்னும் தொகுப்புகள் இல்லை. ஒன்றைப் புதிதாகச் சேர்க்கவும்!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'தயவுசெய்து முதலில் உங்கள் குறிப்பை எழுதவும்.';

  @override
  String get noCollectionSelected => 'தொகுப்பு எதுவும் தேர்ந்தெடுக்கப்படவில்லை';

  @override
  String get saveNote => 'குறிப்பைச் சேமி';

  @override
  String get nextSelectCollections =>
      'அடுத்து: தொகுப்புகளைத் தேர்ந்தெடுக்கவும்';

  @override
  String get addToPinned => 'பின் செய்தவற்றில் சேர்';

  @override
  String get pinnedSavedSuccessfully =>
      'பின் செய்தது வெற்றிகரமாகச் சேமிக்கப்பட்டது!';

  @override
  String get savePinned => 'பின் செய்ததைச் சேமி';

  @override
  String get closeAudioController => 'ஆடியோ கட்டுப்பாட்டாளரை மூடு';

  @override
  String get previous => 'முந்தையது';

  @override
  String get rewind => 'பின்செல்';

  @override
  String get fastForward => 'முன்செல்';

  @override
  String get playNextAyah => 'அடுத்த ஆயத்தை இயக்கு';

  @override
  String get repeat => 'திரும்பச் செய்';

  @override
  String get playAsPlaylist => 'பட்டியலாக இயக்கு';

  @override
  String style(String style) {
    return 'உடை: $style';
  }

  @override
  String get stopAndClose => 'நிறுத்தி மூடு';

  @override
  String get play => 'இயக்கு';

  @override
  String get pause => 'இடைநிறுத்து';

  @override
  String get selectReciter => 'ஓதுபவரைத் தேர்ந்தெடுக்கவும்';

  @override
  String source(String source) {
    return 'மூலம்: $source';
  }

  @override
  String get newText => 'புதியது';

  @override
  String get more => 'மேலும்: ';

  @override
  String get cacheNotFound => 'தற்காலிகச் சேமிப்பு காணப்படவில்லை';

  @override
  String get cacheSize => 'தற்காலிகச் சேமிப்பு அளவு';

  @override
  String error(String error) {
    return 'பிழை: $error';
  }

  @override
  String get clean => 'சுத்தம் செய்';

  @override
  String get lastModified => 'கடைசியாக மாற்றப்பட்டது';

  @override
  String get oneYearAgo => '1 வருடத்திற்கு முன்';

  @override
  String monthsAgo(String number) {
    return '$number மாதங்களுக்கு முன்';
  }

  @override
  String weeksAgo(String number) {
    return '$number வாரங்களுக்கு முன்';
  }

  @override
  String daysAgo(String number) {
    return '$number நாட்களுக்கு முன்';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour மணி நேரங்களுக்கு முன்';
  }

  @override
  String get aboutAlQuran => 'அல் குர்ஆனைப் பற்றி';

  @override
  String get appFullName => 'அல் குர்ஆன் (தஃப்ஸீர், தொழுகை, கிப்லா, ஆடியோ)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux மற்றும் Windows-க்கான ஒரு விரிவான இஸ்லாமியப் பயன்பாடு. தஃப்ஸீர் மற்றும் பல மொழிபெயர்ப்புகளுடன் (வார்த்தைக்கு வார்த்தை உட்பட) குர்ஆனை ஓதுதல், அறிவிப்புகளுடன் உலகளாவிய தொழுகை நேரங்கள், கிப்லா திசைகாட்டி மற்றும் ஒத்திசைக்கப்பட்ட வார்த்தைக்கு வார்த்தை ஆடியோ ஓதுதல் ஆகியவற்றை வழங்குகிறது.';

  @override
  String get dataSourcesNote =>
      'குறிப்பு: குர்ஆன் உரைகள், தஃப்ஸீர், மொழிபெயர்ப்புகள் மற்றும் ஆடியோ வளங்கள் Quran.com, Everyayah.com மற்றும் பிற சரிபார்க்கப்பட்ட திறந்த மூலங்களிலிருந்து பெறப்படுகின்றன.';

  @override
  String get adFreePromise =>
      'இந்த செயலி அல்லாஹ்வின் திருப்பொருத்தத்தை நாடி உருவாக்கப்பட்டது. எனவே, இது இப்போதும் எப்போதும் முற்றிலும் விளம்பரங்கள் இல்லாததாக இருக்கும்.';

  @override
  String get coreFeatures => 'முக்கிய அம்சங்கள்';

  @override
  String get coreFeaturesDescription =>
      'அல் குர்ஆன் v3 ஐ உங்கள் தினசரி இஸ்லாமிய நடைமுறைகளுக்கு ஒரு தவிர்க்க முடியாத கருவியாக்கும் முக்கிய செயல்பாடுகளை ஆராயுங்கள்:';

  @override
  String get prayerTimesTitle => 'தொழுகை நேரங்கள் & எச்சரிக்கைகள்';

  @override
  String get prayerTimesDescription =>
      'பல்வேறு கணக்கீட்டு முறைகளைப் பயன்படுத்தி உலகெங்கிலும் உள்ள எந்த இடத்திற்கும் துல்லியமான தொழுகை நேரங்கள். பாங்கு அறிவிப்புகளுடன் நினைவூட்டல்களை அமைக்கவும்.';

  @override
  String get qiblaDirectionTitle => 'கிப்லா திசை';

  @override
  String get qiblaDirectionDescription =>
      'தெளிவான மற்றும் துல்லியமான திசைகாட்டி மூலம் கிப்லா திசையை எளிதாகக் கண்டறியவும்.';

  @override
  String get translationTafsirTitle => 'குர்ஆன் மொழிபெயர்ப்பு & தஃப்ஸீர்';

  @override
  String get translationTafsirDescription =>
      '69 மொழிகளில் 120+ க்கும் மேற்பட்ட மொழிபெயர்ப்பு நூல்களையும் (வார்த்தைக்கு வார்த்தை உட்பட) மற்றும் 30+ தஃப்ஸீர் நூல்களையும் அணுகவும்.';

  @override
  String get wordByWordAudioTitle =>
      'வார்த்தைக்கு வார்த்தை ஆடியோ & தனிப்படுத்தல்';

  @override
  String get wordByWordAudioDescription =>
      'ஒரு ஆழமான கற்றல் அனுபவத்திற்காக, ஒத்திசைக்கப்பட்ட வார்த்தைக்கு வார்த்தை ஆடியோ ஓதுதல் மற்றும் தனிப்படுத்தலுடன் தொடரவும்.';

  @override
  String get ayahAudioRecitationTitle => 'ஆயத் ஆடியோ ஓதுதல்';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ க்கும் மேற்பட்ட புகழ்பெற்ற ஓதுபவர்களின் முழு ஆயத் ஓதுதலைக் கேளுங்கள்.';

  @override
  String get notesCloudBackupTitle => 'கிளவுட் காப்புப்பிரதியுடன் குறிப்புகள்';

  @override
  String get notesCloudBackupDescription =>
      'தனிப்பட்ட குறிப்புகளையும் பிரதிபலிப்புகளையும் சேமிக்கவும், கிளவுடிற்குப் பாதுகாப்பாக காப்புப் பிரதி எடுக்கப்படும் (அம்சம் உருவாக்கத்தில்/விரைவில் வரும்).';

  @override
  String get crossPlatformSupportTitle => 'பல தள ஆதரவு';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux மற்றும் Windows இல் ஆதரிக்கப்படுகிறது.';

  @override
  String get backgroundAudioPlaybackTitle => 'பின்னணி ஆடியோ இயக்கம்';

  @override
  String get backgroundAudioPlaybackDescription =>
      'செயலி பின்னணியில் இருக்கும்போதும் குர்ஆன் ஓதுதலைத் தொடர்ந்து கேட்கவும்.';

  @override
  String get audioDataCachingTitle => 'ஆடியோ & தரவு தற்காலிகச் சேமிப்பு';

  @override
  String get audioDataCachingDescription =>
      'வலுவான ஆடியோ மற்றும் குர்ஆன் தரவு தற்காலிகச் சேமிப்புடன் மேம்படுத்தப்பட்ட இயக்கம் மற்றும் ஆஃப்லைன் திறன்கள்.';

  @override
  String get minimalisticInterfaceTitle => 'குறைந்தபட்ச & தூய்மையான இடைமுகம்';

  @override
  String get minimalisticInterfaceDescription =>
      'பயனர் அனுபவம் மற்றும் வாசிப்புத்திறனில் கவனம் செலுத்தி எளிதாக வழிசெலுத்தக்கூடிய இடைமுகம்.';

  @override
  String get optimizedPerformanceTitle => 'உகந்த செயல்திறன் & அளவு';

  @override
  String get optimizedPerformanceDescription =>
      'இலகுரகமாகவும் செயல்திறன் மிக்கதாகவும் வடிவமைக்கப்பட்ட அம்சம் நிறைந்த பயன்பாடு.';

  @override
  String get languageSupport => 'மொழி ஆதரவு';

  @override
  String get languageSupportDescription =>
      'இந்த பயன்பாடு பின்வரும் மொழிகளுக்கான ஆதரவுடன் உலகளாவிய பார்வையாளர்களுக்கு அணுகக்கூடியதாக வடிவமைக்கப்பட்டுள்ளது (மேலும் பல தொடர்ந்து சேர்க்கப்படுகின்றன):';

  @override
  String get technologyAndResources => 'தொழில்நுட்பம் & வளங்கள்';

  @override
  String get technologyAndResourcesDescription =>
      'இந்த செயலி அதிநவீன தொழில்நுட்பங்கள் மற்றும் நம்பகமான வளங்களைப் பயன்படுத்தி உருவாக்கப்பட்டுள்ளது:';

  @override
  String get flutterFrameworkTitle => 'Flutter Framework';

  @override
  String get flutterFrameworkDescription =>
      'ஒற்றைக் குறியீட்டுத் தளத்திலிருந்து அழகான, இயல்பாகத் தொகுக்கப்பட்ட, பல-தள அனுபவத்திற்காக Flutter மூலம் உருவாக்கப்பட்டது.';

  @override
  String get advancedAudioEngineTitle => 'மேம்பட்ட ஆடியோ இயந்திரம்';

  @override
  String get advancedAudioEngineDescription =>
      'வலுவான ஆடியோ இயக்கம் மற்றும் கட்டுப்பாட்டிற்காக `just_audio` மற்றும் `just_audio_background` Flutter தொகுப்புகளால் இயக்கப்படுகிறது.';

  @override
  String get reliableQuranDataTitle => 'நம்பகமான குர்ஆன் தரவு';

  @override
  String get reliableQuranDataDescription =>
      'அல் குர்ஆன் உரைகள், மொழிபெயர்ப்புகள், தஃப்ஸீர்கள் மற்றும் ஆடியோ ஆகியவை Quran.com & Everyayah.com போன்ற சரிபார்க்கப்பட்ட திறந்த ஏபிஐகள் மற்றும் தரவுத்தளங்களிலிருந்து பெறப்படுகின்றன.';

  @override
  String get prayerTimeEngineTitle => 'தொழுகை நேர இயந்திரம்';

  @override
  String get prayerTimeEngineDescription =>
      'துல்லியமான தொழுகை நேரங்களுக்காக நிறுவப்பட்ட கணக்கீட்டு முறைகளைப் பயன்படுத்துகிறது. அறிவிப்புகள் `flutter_local_notifications` மற்றும் பின்னணிப் பணிகள் மூலம் கையாளப்படுகின்றன.';

  @override
  String get crossPlatformSupport => 'பல தள ஆதரவு';

  @override
  String get crossPlatformSupportDescription2 =>
      'பல்வேறு தளங்களில் தடையற்ற அணுகலை அனுபவிக்கவும்:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'Web';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'எங்கள் வாழ்நாள் வாக்குறுதி';

  @override
  String get lifetimePromiseDescription =>
      'இன்ஷா அல்லாஹ், என் வாழ்நாள் முழுவதும் இந்த பயன்பாட்டிற்கான தொடர்ச்சியான ஆதரவையும் பராமரிப்பையும் வழங்குவதாக நான் தனிப்பட்ட முறையில் உறுதியளிக்கிறேன். இந்த செயலி உம்மத்திற்கு பல ஆண்டுகளாக ஒரு பயனுள்ள ஆதாரமாக இருப்பதை உறுதி செய்வதே எனது குறிக்கோள்.';

  @override
  String get fajr => 'ஃபஜ்ர்';

  @override
  String get sunrise => 'சூரிய உதயம்';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'ളുஹர்';

  @override
  String get asr => 'அஸர்';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'மஃரிப்';

  @override
  String get isha => 'இஷா';

  @override
  String get midnight => 'நள்ளிரவு';

  @override
  String get alarm => 'அலாரம்';

  @override
  String get notification => 'அறிவிப்பு';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'தஜ்வீத்';

  @override
  String get quranScriptUthmani => 'உத்மானி';

  @override
  String get quranScriptIndopak => 'இந்தோபாக்';

  @override
  String get sajdaAyah => 'சஜ்தா ஆயத்';

  @override
  String get required => 'கட்டாயம்';

  @override
  String get optional => 'விருப்பத்திற்குரியது';

  @override
  String get notificationScheduleWarning =>
      'குறிப்பு: உங்கள் தொலைபேசியின் OS பின்னணி செயல்முறை கட்டுப்பாடுகள் காரணமாக திட்டமிடப்பட்ட அறிவிப்பு அல்லது நினைவூட்டல் தவறவிடப்படலாம். எடுத்துக்காட்டாக: Vivo-வின் Origin OS, Samsung-ன் One UI, Oppo-வின் ColorOS போன்றவை சில நேரங்களில் திட்டமிடப்பட்ட அறிவிப்பு அல்லது நினைவூட்டலைக் கொன்றுவிடுகின்றன. பயன்பாட்டை பின்னணி செயல்முறையிலிருந்து கட்டுப்படுத்தாமல் இருக்க உங்கள் OS அமைப்புகளைச் சரிபார்க்கவும்.';

  @override
  String get scrollWithRecitation => 'పారాయణంతో స్క్రోల్ చేయండి';

  @override
  String get quickAccess => 'விரைவான அணுகல்';

  @override
  String get initiallyScrollAyah => 'ஆரம்பத்தில் ஆயாவுக்கு உருட்டவும்';

  @override
  String get tajweedGuide => 'தஜ்வீத் வழிகாட்டி';

  @override
  String get scrollWithRecitationDesc =>
      'இயக்கப்பட்டால், குர்ஆன் ஆயா ஆடியோ பாராயணத்துடன் ஒத்திசைந்து தானாகவே உருட்டும்.';

  @override
  String get configuration => 'கட்டமைப்பு';

  @override
  String get restoreFromBackup => 'காப்புப்பிரதியிலிருந்து மீட்டமை';

  @override
  String get history => 'வரலாறு';

  @override
  String get search => 'தேடு';

  @override
  String get useAudioStream => 'ஆடியோ ஸ்ட்ரீமைப் பயன்படுத்தவும்';

  @override
  String get useAudioStreamDesc =>
      'பதிவிறக்குவதற்குப் பதிலாக இணையத்திலிருந்து நேரடியாக ஆடியோவை ஸ்ட்ரீம் செய்யவும்.';

  @override
  String get notUseAudioStreamDesc =>
      'ஆஃப்லைன் பயன்பாட்டிற்காக ஆடியோவைப் பதிவிறக்கி, டேட்டா நுகர்வைக் குறைக்கவும்.';

  @override
  String get audioSettings => 'ஆடியோ அமைப்புகள்';

  @override
  String get playbackSpeed => 'பின்னணி வேகம்';

  @override
  String get playbackSpeedDesc =>
      'குர்ஆன் பாராயணத்தின் வேகத்தைச் சரிசெய்யவும்.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'தற்போதைய பதிவிறக்கம் முடிவடையும் வரை காத்திருக்கவும்.';

  @override
  String get areYouSure => 'உனக்கு உறுதியாக தெரியுமா?';

  @override
  String get checkYourInternetConnection =>
      'உங்கள் இணைய இணைப்பைச் சரிபார்க்கவும்.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount வசனங்களில் $requiredDownload வசனங்களைப் பதிவிறக்க வேண்டும்.';
  }

  @override
  String get download => 'பதிவிறக்க';

  @override
  String get audioDownload => 'ஆடியோ பதிவிறக்கம்';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'குர்ஆன் ஸ்கிரிப்டை மேம்படுத்துகிறது';

  @override
  String get supportOnGithub => 'GitHub-இல் ஆதரவு';

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

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';
}
