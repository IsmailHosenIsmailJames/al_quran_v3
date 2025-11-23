// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

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
    return '$ayahKey үшін тәпсір жоқ';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Тәпсір мына жерде: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey өту';
  }

  @override
  String get hizb => 'Хизб';

  @override
  String get juz => 'Жүз';

  @override
  String get page => 'Бет';

  @override
  String get ruku => 'Рүкуғ';

  @override
  String get languageSettings => 'Тіл параметрлері';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count аят';
  }

  @override
  String get saveAndDownload => 'Сақтау және жүктеу';

  @override
  String get appLanguage => 'Қолданба тілі';

  @override
  String get selectAppLanguage => 'Қолданба тілін таңдаңыз...';

  @override
  String get pleaseSelectOne => 'Бірін таңдаңыз';

  @override
  String get quranTranslationLanguage => 'Құран аудармасының тілі';

  @override
  String get selectTranslationLanguage => 'Аударма тілін таңдаңыз...';

  @override
  String get quranTranslationBook => 'Құран аудармасы кітабы';

  @override
  String get selectTranslationBook => 'Аударма кітабын таңдаңыз...';

  @override
  String get quranTafsirLanguage => 'Құран тәпсірінің тілі';

  @override
  String get selectTafsirLanguage => 'Тәпсір тілін таңдаңыз...';

  @override
  String get quranTafsirBook => 'Құран тәпсірі кітабы';

  @override
  String get selectTafsirBook => 'Тәпсір кітабын таңдаңыз...';

  @override
  String get quranScriptAndStyle => 'Құран жазуы және стилі';

  @override
  String get justAMoment => 'Бір сәт күтіңіз...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Сәтті';

  @override
  String get retry => 'Қайталау';

  @override
  String get unableToDownloadResources =>
      'Ресурстарды жүктеу мүмкін емес...\nБірдеңе қате кетті';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Бөлінген Құран оқуы жүктелуде';

  @override
  String get processingSegmentedQuranRecitation =>
      'Бөлінген Құран оқуы өңделуде';

  @override
  String get footnote => 'Ескерту';

  @override
  String get tafsir => 'Тәпсір';

  @override
  String get wordByWord => 'Сөзбе-сөз';

  @override
  String get pleaseSelectRequiredOption => 'Қажетті опцияны таңдаңыз';

  @override
  String get rememberHomeTab => 'Басты бет қойындысын есте сақтау';

  @override
  String get rememberHomeTabSubtitle =>
      'Қолданба басты экрандағы соңғы ашылған қойындыны есте сақтайды.';

  @override
  String get wakeLock => 'Экранды өшірмеу';

  @override
  String get wakeLockSubtitle => 'Экранның автоматты түрде өшуін болдырмау.';

  @override
  String get settings => 'Параметрлер';

  @override
  String get appTheme => 'Қолданба тақырыбы';

  @override
  String get quranStyle => 'Құран стилі';

  @override
  String get changeTheme => 'Тақырыпты өзгерту';

  @override
  String get verseCount => 'Аят саны: ';

  @override
  String get translation => 'Аударма';

  @override
  String get tafsirNotFound => 'Табылмады';

  @override
  String get moreInfo => 'қосымша ақпарат';

  @override
  String get playAudio => 'Аудионы ойнату';

  @override
  String get preview => 'Алдын ала қарау';

  @override
  String get loading => 'Жүктелуде...';

  @override
  String get errorFetchingAddress => 'Мекенжайды алу қатесі';

  @override
  String get addressNotAvailable => 'Мекенжай қолжетімді емес';

  @override
  String get latitude => 'Ендік: ';

  @override
  String get longitude => 'Бойлық: ';

  @override
  String get name => 'Аты: ';

  @override
  String get location => 'Орналасқан жері: ';

  @override
  String get parameters => 'Параметрлер: ';

  @override
  String get selectCalculationMethod => 'Есептеу әдісін таңдаңыз';

  @override
  String get shareSelectAyahs => 'Таңдалған аяттарды бөлісу';

  @override
  String get selectionEmpty => 'Таңдау бос';

  @override
  String get generatingImagePleaseWait => 'Сурет жасалуда... Күтіңіз';

  @override
  String get asImage => 'Сурет ретінде';

  @override
  String get asText => 'Мәтін ретінде';

  @override
  String get playFromSelectedAyah => 'Таңдалған аяттан ойнату';

  @override
  String get toTafsir => 'Тәпсірге';

  @override
  String get selectAyah => 'Аят таңдау';

  @override
  String get toAyah => 'Аятқа';

  @override
  String get searchForASurah => 'Сүрені іздеу';

  @override
  String get bugReportTitle => 'Қате туралы есеп';

  @override
  String get audioCached => 'Аудио кэштелген';

  @override
  String get others => 'Басқалар';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Құран|Аударма|Аят, Біреуі қосулы болуы керек';

  @override
  String get quranFontSize => 'Құран қаріп өлшемі';

  @override
  String get quranLineHeight => 'Құран жол биіктігі';

  @override
  String get translationAndTafsirFontSize => 'Аударма және тәпсір қаріп өлшемі';

  @override
  String get quranAyah => 'Құран аяты';

  @override
  String get topToolbar => 'Жоғарғы құралдар панелі';

  @override
  String get keepOpenWordByWord => 'Сөзбе-сөз ашық ұстау';

  @override
  String get wordByWordHighlight => 'Сөзбе-сөз ерекшелеу';

  @override
  String get quranScriptSettings => 'Құран жазу параметрлері';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Бет: ';

  @override
  String get quranResources => 'Құран ресурстары';

  @override
  String alreadySelected(String name) {
    return '\'$name\' тілі қазірдің өзінде таңдалған.';
  }

  @override
  String get unableToGetCompassData => 'Компас деректерін алу мүмкін емес';

  @override
  String get deviceDoesNotHaveSensors => 'Құрылғыда сенсорлар жоқ!';

  @override
  String get north => 'С';

  @override
  String get east => 'Ш';

  @override
  String get south => 'О';

  @override
  String get west => 'Б';

  @override
  String get address => 'Мекенжай: ';

  @override
  String get change => 'Өзгерту';

  @override
  String get calculationMethod => 'Есептеу әдісі: ';

  @override
  String get downloadPrayerTime => 'Намаз уақытын жүктеу';

  @override
  String get calculationMethodsListEmpty => 'Есептеу әдістерінің тізімі бос.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Орналасу деректері бар есептеу әдісі табылмады.';

  @override
  String get prayerSettings => 'Намаз параметрлері';

  @override
  String get reminderSettings => 'Еске салу параметрлері';

  @override
  String get adjustReminderTime => 'Еске салу уақытын реттеу';

  @override
  String get enforceAlarmSound => 'Дабыл дыбысын мәжбүрлеу';

  @override
  String get enforceAlarmSoundDescription =>
      'Қосылса, бұл мүмкіндік дабылды осында орнатылған дыбыс деңгейінде ойнатады, тіпті телефонның дыбысы төмен болса да. Бұл телефонның төмен дыбысына байланысты дабылды жіберіп алмауыңызды қамтамасыз етеді.';

  @override
  String get volume => 'Дыбыс деңгейі';

  @override
  String get atPrayerTime => 'Намаз уақытында';

  @override
  String minBefore(int minutes) {
    return '$minutes мин бұрын';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes мин кейін';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName $prayerTime уақытында';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName уақыты келді';
  }

  @override
  String get stopTheAdhan => 'Азанды тоқтату';

  @override
  String dateFoundEmpty(String date) {
    return '$date бос табылды';
  }

  @override
  String get today => 'Бүгін';

  @override
  String get left => 'Қалды';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName үшін еске салу қосылды';
  }

  @override
  String get allowNotificationPermission =>
      'Бұл мүмкіндікті пайдалану үшін хабарландыру рұқсатын рұқсат етіңіз';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName үшін еске салу жойылды';
  }

  @override
  String get getPrayerTimesAndQibla => 'Намаз уақыттары мен Қыбланы алу';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Кез келген орналасу үшін намаз уақыттары мен Қыбланы есептеу.';

  @override
  String get getFromGPS => 'GPS-тен алу';

  @override
  String get or => 'Немесе';

  @override
  String get selectYourCity => 'Қалаңызды таңдаңыз';

  @override
  String get noteAboutGPS =>
      'Ескерту: GPS-ті пайдаланғыңыз келмесе немесе қауіпсіздік сезінбесеңіз, қалаңызды таңдай аласыз.';

  @override
  String get downloadingLocationResources => 'Орналасу ресурстарын жүктеу...';

  @override
  String get somethingWentWrong => 'Бірдеңе қате кетті';

  @override
  String get selectYourCountry => 'Еліңізді таңдаңыз';

  @override
  String get searchForACountry => 'Елді іздеу';

  @override
  String get selectYourAdministrator => 'Әкімшіңізді таңдаңыз';

  @override
  String get searchForAnAdministrator => 'Әкімшіні іздеу';

  @override
  String get searchForACity => 'Қаланы іздеу';

  @override
  String get pleaseEnableLocationService => 'Орналасу қызметін қосыңыз';

  @override
  String get donateUs => 'Бізге қайырымдылық жасаңыз';

  @override
  String get underDevelopment => 'Әзірлеу үстінде';

  @override
  String get versionLoading => 'Жүктелуде...';

  @override
  String get alQuran => 'Әл Құран';

  @override
  String get mainMenu => 'Басты мәзір';

  @override
  String get notes => 'Ескертпелер';

  @override
  String get pinned => 'Бекітілген';

  @override
  String get jumpToAyah => 'Аятқа өту';

  @override
  String get shareMultipleAyah => 'Бірнеше аятты бөлісу';

  @override
  String get shareThisApp => 'Бұл қолданбаны бөлісу';

  @override
  String get giveRating => 'Баға беру';

  @override
  String get bugReport => 'Қате туралы есеп';

  @override
  String get privacyPolicy => 'Құпиялылық саясаты';

  @override
  String get aboutTheApp => 'Қолданба туралы';

  @override
  String get resetTheApp => 'Қолданбаны қалпына келтіру';

  @override
  String get resetAppWarningTitle => 'Қолданба деректерін қалпына келтіру';

  @override
  String get resetAppWarningMessage =>
      'Қолданбаны қалпына келтіргіңіз келеді ме? Барлық деректеріңіз жоғалады, және қолданбаны басынан орнатуыңыз керек.';

  @override
  String get cancel => 'Болдырмау';

  @override
  String get reset => 'Қалпына келтіру';

  @override
  String get shareAppSubject => 'Бұл Әл Құран қолданбасын қараңыз!';

  @override
  String shareAppBody(String appLink) {
    return 'Ассалаумағалейкум! Күнделікті оқу және ойлану үшін бұл Әл Құран қолданбасын қараңыз. Ол Алланың сөздерімен байланысуға көмектеседі. Мұнда жүктеңіз: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Тартпаны ашу';

  @override
  String get quran => 'Құран';

  @override
  String get prayer => 'Намаз';

  @override
  String get qibla => 'Қыбла';

  @override
  String get audio => 'Аудио';

  @override
  String get surah => 'Сүре';

  @override
  String get pages => 'Беттер';

  @override
  String get note => 'Ескерту:';

  @override
  String get linkedAyahs => 'Байланысты аяттар:';

  @override
  String get emptyNoteCollection =>
      'Бұл ескертпе жинағы бос.\nМұнда көру үшін кейбір ескертпелер қосыңыз.';

  @override
  String get emptyPinnedCollection =>
      'Бұл жинаққа әлі аяттар бекітілмеген.\nМұнда көру үшін аяттарды бекітіңіз.';

  @override
  String get noContentAvailable => 'Мазмұн жоқ.';

  @override
  String failedToLoadCollections(String error) {
    return 'Жинақтарды жүктеу сәтсіз: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType аты бойынша іздеу...';
  }

  @override
  String get sortBy => 'Сұрыптау';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Әлі $collectionType қосылмаған';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count бекітілген элемент';
  }

  @override
  String notesCount(int count) {
    return '$count ескертпе';
  }

  @override
  String get emptyNameNotAllowed => 'Бос ат рұқсат етілмейді';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName жаңартылды';
  }

  @override
  String get changeName => 'Атын өзгерту';

  @override
  String get changeColor => 'Түсті өзгерту';

  @override
  String get colorUpdated => 'Түс жаңартылды';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName жойылды';
  }

  @override
  String get delete => 'Жою';

  @override
  String get save => 'Сақтау';

  @override
  String get collectionNameCannotBeEmpty => 'Жинақ аты бос болмауы керек.';

  @override
  String get addedNewCollection => 'Жаңа жинақ қосылды';

  @override
  String ayahCount(int count) {
    return '$count аят';
  }

  @override
  String get byNameAtoZ => 'Ат бойынша A-дан Z-ға';

  @override
  String get byNameZtoA => 'Ат бойынша Z-дан A-ға';

  @override
  String get byElementNumberAscending => 'Элемент нөмірі өсуі бойынша';

  @override
  String get byElementNumberDescending => 'Элемент нөмірі кемуі бойынша';

  @override
  String get byUpdateDateAscending => 'Жаңарту күні өсуі бойынша';

  @override
  String get byUpdateDateDescending => 'Жаңарту күні кемуі бойынша';

  @override
  String get byCreateDateAscending => 'Құру күні өсуі бойынша';

  @override
  String get byCreateDateDescending => 'Құру күні кемуі бойынша';

  @override
  String get translationNotFound => 'Аударма табылмады';

  @override
  String get translationTitle => 'Аударма:';

  @override
  String get footNoteTitle => 'Ескерту:';

  @override
  String get wordByWordTranslation => 'Сөзбе-сөз аударма:';

  @override
  String get tafsirButton => 'Тәпсір';

  @override
  String get shareButton => 'Бөлісу';

  @override
  String get addNoteButton => 'Ескертпе қосу';

  @override
  String get pinToCollectionButton => 'Жинаққа бекіту';

  @override
  String get shareAsText => 'Мәтін ретінде бөлісу';

  @override
  String get copiedWithTafsir => 'Тәпсірмен көшірілді';

  @override
  String get shareAsImage => 'Сурет ретінде бөлісу';

  @override
  String get shareWithTafsir => 'Тәпсірмен бөлісу';

  @override
  String get notFound => 'Табылмады';

  @override
  String get noteContentCannotBeEmpty => 'Ескертпе мазмұны бос болмауы керек.';

  @override
  String get noteSavedSuccessfully => 'Ескертпе сәтті сақталды!';

  @override
  String get selectCollections => 'Жинақтарды таңдау';

  @override
  String get addNote => 'Ескертпе қосу';

  @override
  String get writeCollectionName => 'Жинақ атын жазыңыз...';

  @override
  String get noCollectionsYetAddANewOne => 'Әлі жинақтар жоқ. Жаңасын қосыңыз!';

  @override
  String get pleaseWriteYourNoteFirst => 'Алдымен ескертпеңізді жазыңыз.';

  @override
  String get noCollectionSelected => 'Жинақ таңдалмаған';

  @override
  String get saveNote => 'Ескертпені сақтау';

  @override
  String get nextSelectCollections => 'Келесі: Жинақтарды таңдау';

  @override
  String get addToPinned => 'Бекітілгенге қосу';

  @override
  String get pinnedSavedSuccessfully => 'Бекітілген сәтті сақталды!';

  @override
  String get savePinned => 'Бекітілгенді сақтау';

  @override
  String get closeAudioController => 'Аудио контроллерін жабу';

  @override
  String get previous => 'Алдыңғы';

  @override
  String get rewind => 'Артқа айналдыру';

  @override
  String get fastForward => 'Алға айналдыру';

  @override
  String get playNextAyah => 'Келесі аятты ойнату';

  @override
  String get repeat => 'Қайталау';

  @override
  String get playAsPlaylist => 'Плейлист ретінде ойнату';

  @override
  String style(String style) {
    return 'Стиль: $style';
  }

  @override
  String get stopAndClose => 'Тоқтату және жабу';

  @override
  String get play => 'Ойнату';

  @override
  String get pause => 'Кідірту';

  @override
  String get selectReciter => 'Оқушыны таңдау';

  @override
  String source(String source) {
    return 'Дереккөз: $source';
  }

  @override
  String get newText => 'Жаңа';

  @override
  String get more => 'Қосымша: ';

  @override
  String get cacheNotFound => 'Кэш табылмады';

  @override
  String get cacheSize => 'Кэш өлшемі';

  @override
  String error(String error) {
    return 'Қате: $error';
  }

  @override
  String get clean => 'Тазалау';

  @override
  String get lastModified => 'Соңғы өзгертілген';

  @override
  String get oneYearAgo => '1 жыл бұрын';

  @override
  String monthsAgo(String number) {
    return '$number ай бұрын';
  }

  @override
  String weeksAgo(String number) {
    return '$number апта бұрын';
  }

  @override
  String daysAgo(String number) {
    return '$number күн бұрын';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour сағат бұрын';
  }

  @override
  String get aboutAlQuran => 'Әл Құран туралы';

  @override
  String get appFullName => 'Әл Құран (Тәпсір, Намаз, Қыбла, Аудио)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux және Windows үшін толық исламдық қолданба, Құран оқуын тәпсір және бірнеше аудармалармен (сөзбе-сөзді қоса), әлемдік намаз уақыттары, Қыбла компасы және сөзбе-сөз аудио оқуымен ұсынады.';

  @override
  String get dataSourcesNote =>
      'Ескерту: Құран мәтіндері, тәпсір, аудармалар және аудио ресурстары Quran.com, Everyayah.com және басқа расталған ашық дереккөздерден алынған.';

  @override
  String get adFreePromise =>
      'Бұл қолданба Алланың разылығын алу үшін жасалған. Сондықтан ол толықтай жарнамадан бос және әрқашан солай болады.';

  @override
  String get coreFeatures => 'Негізгі мүмкіндіктер';

  @override
  String get coreFeaturesDescription =>
      'Әл Құран v3-ті күнделікті исламдық амалдар үшін таптырмас құрал ететін негізгі функцияларды зерттеңіз:';

  @override
  String get prayerTimesTitle => 'Намаз уақыттары және ескертулер';

  @override
  String get prayerTimesDescription =>
      'Әртүрлі есептеу әдістерін пайдалана отырып, әлемнің кез келген орналасуы үшін дәл намаз уақыттары. Азан хабарландыруларымен еске салуды орнатыңыз.';

  @override
  String get qiblaDirectionTitle => 'Қыбла бағыты';

  @override
  String get qiblaDirectionDescription =>
      'Анық және дәл компас көрінісімен Қыбланы оңай табыңыз.';

  @override
  String get translationTafsirTitle => 'Құран аудармасы және тәпсірі';

  @override
  String get translationTafsirDescription =>
      '69 тілде 120+ аударма кітабын (сөзбе-сөзді қоса) және 30+ тәпсір кітабын қолданыңыз.';

  @override
  String get wordByWordAudioTitle => 'Сөзбе-сөз аудио және ерекшелеу';

  @override
  String get wordByWordAudioDescription =>
      'Иммерсивті оқу тәжірибесі үшін сөзбе-сөз аудио оқуы және ерекшелеумен бірге жүріңіз.';

  @override
  String get ayahAudioRecitationTitle => 'Аят аудио оқуы';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ танымал оқушылардан толық аят оқуларын тыңдаңыз.';

  @override
  String get notesCloudBackupTitle => 'Ескертпелер бұлттық сақтық көшірмемен';

  @override
  String get notesCloudBackupDescription =>
      'Жеке ескертпелер мен ойларды сақтаңыз, бұлтқа қауіпсіз сақтық көшірме (мүмкіндік әзірлеу үстінде/жақында).';

  @override
  String get crossPlatformSupportTitle => 'Кросс-платформалық қолдау';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux және Windows-та қолдау көрсетіледі.';

  @override
  String get backgroundAudioPlaybackTitle => 'Фондық аудио ойнату';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Қолданба фонда болса да Құран оқуын тыңдауды жалғастырыңыз.';

  @override
  String get audioDataCachingTitle => 'Аудио және деректер кэштеу';

  @override
  String get audioDataCachingDescription =>
      'Мықты аудио және Құран деректерін кэштеумен ойнату және оффлайн мүмкіндіктерін жақсарту.';

  @override
  String get minimalisticInterfaceTitle => 'Минималистік және таза интерфейс';

  @override
  String get minimalisticInterfaceDescription =>
      'Пайдаланушы тәжірибесі және оқуға назар аударатын оңай шарлау интерфейсі.';

  @override
  String get optimizedPerformanceTitle =>
      'Оңтайландырылған өнімділік және өлшем';

  @override
  String get optimizedPerformanceDescription =>
      'Мүмкіндіктері мол қолданба жеңіл және өнімді болу үшін жасалған.';

  @override
  String get languageSupport => 'Тіл қолдауы';

  @override
  String get languageSupportDescription =>
      'Бұл қолданба жаһандық аудиторияға қолжетімді болу үшін келесі тілдерді қолдайды (және қосымшалары үздіксіз қосылуда):';

  @override
  String get technologyAndResources => 'Технология және ресурстар';

  @override
  String get technologyAndResourcesDescription =>
      'Бұл қолданба заманауи технологиялар және сенімді ресурстармен жасалған:';

  @override
  String get flutterFrameworkTitle => 'Flutter фреймворк';

  @override
  String get flutterFrameworkDescription =>
      'Бір код базасынан әдемі, жергілікті компиляцияланған, көпплатформалық тәжірибе үшін Flutter-мен жасалған.';

  @override
  String get advancedAudioEngineTitle => 'Кеңейтілген аудио қозғалтқышы';

  @override
  String get advancedAudioEngineDescription =>
      'Мықты аудио ойнату және басқару үшін `just_audio` және `just_audio_background` Flutter пакеттерімен жұмыс істейді.';

  @override
  String get reliableQuranDataTitle => 'Сенімді Құран деректері';

  @override
  String get reliableQuranDataDescription =>
      'Әл Құран мәтіндері, аудармалар, тәпсірлер және аудио расталған ашық API және дерекқорлардан алынған, мысалы Quran.com және Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Намаз уақыты қозғалтқышы';

  @override
  String get prayerTimeEngineDescription =>
      'Дәл намаз уақыттары үшін белгіленген есептеу әдістерін пайдаланады. Хабарландырулар `flutter_local_notifications` және фондық тапсырмалармен өңделеді.';

  @override
  String get crossPlatformSupport => 'Кросс-платформалық қолдау';

  @override
  String get crossPlatformSupportDescription2 =>
      'Әртүрлі платформаларда үздіксіз қолжетімділікті пайдаланыңыз:';

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
  String get ourLifetimePromise => 'Біздің өмірлік уәдеміз';

  @override
  String get lifetimePromiseDescription =>
      'Мен жеке өмірім бойы бұл қолданбаны үздіксіз қолдау және күтім көрсетуге уәде беремін, Ин ша Аллаһ. Менің мақсатым - бұл қолданба жылдар бойы үммет үшін пайдалы ресурс болып қалуын қамтамасыз ету.';

  @override
  String get fajr => 'Таң';

  @override
  String get sunrise => 'Күн шығуы';

  @override
  String get dhuhr => 'Түс';

  @override
  String get asr => 'Екінді';

  @override
  String get maghrib => 'Ақшам';

  @override
  String get isha => 'Құптан';

  @override
  String get midnight => 'Түн ортасы';

  @override
  String get alarm => 'Дабыл';

  @override
  String get notification => 'Хабарландыру';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Тәжвид';

  @override
  String get quranScriptUthmani => 'Усмани';

  @override
  String get quranScriptIndopak => 'Индопак';

  @override
  String get sajdaAyah => 'Сәжде аяты';

  @override
  String get required => 'Қажетті';

  @override
  String get optional => 'Міндетті емес';

  @override
  String get notificationScheduleWarning =>
      'Ескерту: Жоспарланған хабарландыру немесе еске салу телефонның ОС фонындағы процесс шектеулеріне байланысты жіберілуі мүмкін. Мысалы: Vivo\'s Origin OS, Samsung\'s One UI, Oppo\'s ColorOS т.б. кейде жоспарланған хабарландыру немесе еске салуды өлтіреді. Қолданбаның фондық процесстен шектелмеуі үшін ОС параметрлерін тексеріңіз.';

  @override
  String get scrollWithRecitation => 'Оқумен бірге айналдыру';

  @override
  String get quickAccess => 'Жылдам қолжетімділік';

  @override
  String get initiallyScrollAyah => 'Бастапқыда аятқа айналдыру';

  @override
  String get tajweedGuide => 'Тәжвид нұсқауы';

  @override
  String get scrollWithRecitationDesc =>
      'Қосылса, Құран аяты аудио оқуымен синхронды түрде автоматты айналады.';

  @override
  String get configuration => 'Конфигурация';

  @override
  String get restoreFromBackup => 'Сақтық көшірмеден қалпына келтіру';

  @override
  String get history => 'Тарих';

  @override
  String get search => 'Іздеу';

  @override
  String get useAudioStream => 'Аудио ағынын пайдалану';

  @override
  String get useAudioStreamDesc =>
      'Аудионы тікелей интернеттен ағынмен жүктеу орнына жүктеу.';

  @override
  String get notUseAudioStreamDesc =>
      'Оффлайн пайдалану үшін аудионы жүктеу және деректер шығынын азайту.';

  @override
  String get audioSettings => 'Аудио параметрлері';

  @override
  String get playbackSpeed => 'Ойнату жылдамдығы';

  @override
  String get playbackSpeedDesc => 'Құран оқуының жылдамдығын реттеу.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Ағымдағы жүктеудің аяқталуын күтіңіз.';

  @override
  String get areYouSure => 'Сіз сенімдісіз бе?';

  @override
  String get checkYourInternetConnection =>
      'Интернет қосылымыңызды тексеріңіз.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount аяттың $requiredDownload жүктеу қажет.';
  }

  @override
  String get download => 'Жүктеу';

  @override
  String get audioDownload => 'Аудио жүктеу';

  @override
  String get am => 'ТАҢ';

  @override
  String get pm => 'ТҮС';

  @override
  String get optimizingQuranScript => 'Құран жазуын оңтайландыру';

  @override
  String get supportOnGithub => 'GitHub-та қолдау';
}
