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
    return 'Тәпісір $ayahKey үшін қолжетімсіз';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Тәпісірді мына жерден табасыз: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey аятына өту';
  }

  @override
  String get hizb => 'Хизб';

  @override
  String get juz => 'Пара';

  @override
  String get page => 'Бет';

  @override
  String get ruku => 'Рукуғ';

  @override
  String get languageSettings => 'Тіл параметрлері';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName, $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count аят';
  }

  @override
  String get saveAndDownload => 'Сақтау және жүктеп алу';

  @override
  String get appLanguage => 'Қолданба тілі';

  @override
  String get selectAppLanguage => 'Қолданба тілін таңдаңыз...';

  @override
  String get pleaseSelectOne => 'Біреуін таңдаңыз';

  @override
  String get quranTranslationLanguage => 'Құран аудармасының тілі';

  @override
  String get selectTranslationLanguage => 'Аударма тілін таңдаңыз...';

  @override
  String get quranTranslationBook => 'Құран аудармасының кітабы';

  @override
  String get selectTranslationBook => 'Аударма кітабын таңдаңыз...';

  @override
  String get quranTafsirLanguage => 'Құран тәпісірінің тілі';

  @override
  String get selectTafsirLanguage => 'Тәпісір тілін таңдаңыз...';

  @override
  String get quranTafsirBook => 'Құран тәпісірінің кітабы';

  @override
  String get selectTafsirBook => 'Тәпісір кітабын таңдаңыз...';

  @override
  String get quranScriptAndStyle => 'Құран жазуы мен стилі';

  @override
  String get justAMoment => 'Бір сәт күте тұрыңыз...';

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
      'Ресурстарды жүктеп алу мүмкін болмады...\nБір қателік орын алды';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Бөлінген Құран оқуын жүктеп алу';

  @override
  String get processingSegmentedQuranRecitation => 'Бөлінген Құран оқуын өңдеу';

  @override
  String get footnote => 'Түсініктеме';

  @override
  String get tafsir => 'Тәпісір';

  @override
  String get wordByWord => 'Сөзбе-сөз';

  @override
  String get pleaseSelectRequiredOption => 'Қажетті опцияны таңдаңыз';

  @override
  String get rememberHomeTab => 'Негізгі бетті есте сақтау';

  @override
  String get rememberHomeTabSubtitle =>
      'Қолданба негізгі экрандағы соңғы ашылған бетті есте сақтайды.';

  @override
  String get wakeLock => 'Экранды ояу ұстау';

  @override
  String get wakeLockSubtitle => 'Экранның автоматты түрде сөнуіне жол бермеу.';

  @override
  String get settings => 'Параметрлер';

  @override
  String get appTheme => 'Қолданба тақырыбы';

  @override
  String get quranStyle => 'Құран стилі';

  @override
  String get changeTheme => 'Тақырыпты өзгерту';

  @override
  String get verseCount => 'Аяттар саны: ';

  @override
  String get translation => 'Аударма';

  @override
  String get tafsirNotFound => 'Табылмады';

  @override
  String get moreInfo => 'толығырақ';

  @override
  String get playAudio => 'Аудионы ойнату';

  @override
  String get preview => 'Алдын ала қарау';

  @override
  String get loading => 'Жүктелуде...';

  @override
  String get errorFetchingAddress => 'Мекенжайды алу қатесі';

  @override
  String get addressNotAvailable => 'Мекенжай қолжетімсіз';

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
  String get selectionEmpty => 'Ештеңе таңдалмаған';

  @override
  String get generatingImagePleaseWait => 'Сурет жасалуда... Күте тұрыңыз';

  @override
  String get asImage => 'Сурет ретінде';

  @override
  String get asText => 'Мәтін ретінде';

  @override
  String get playFromSelectedAyah => 'Таңдалған аяттан бастап ойнату';

  @override
  String get toTafsir => 'Тәпісірге өту';

  @override
  String get selectAyah => 'Аятты таңдау';

  @override
  String get toAyah => 'Аятқа өту';

  @override
  String get searchForASurah => 'Сүре іздеу';

  @override
  String get bugReportTitle => 'Қате туралы хабарлау';

  @override
  String get audioCached => 'Аудио кэштелген';

  @override
  String get others => 'Басқалары';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Құран|Аударма|Аят, кем дегенде біреуі қосулы болуы керек';

  @override
  String get quranFontSize => 'Құран қаріпінің өлшемі';

  @override
  String get quranLineHeight => 'Құран жолының биіктігі';

  @override
  String get translationAndTafsirFontSize =>
      'Аударма мен тәпісір қаріпінің өлшемі';

  @override
  String get quranAyah => 'Құран аяты';

  @override
  String get topToolbar => 'Жоғарғы құралдар тақтасы';

  @override
  String get keepOpenWordByWord => 'Сөзбе-сөз аударманы ашық қалдыру';

  @override
  String get wordByWordHighlight => 'Сөзбе-сөз бөлектеу';

  @override
  String get quranScriptSettings => 'Құран жазуының параметрлері';

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
  String get unableToGetCompassData => 'Компас деректерін алу мүмкін болмады';

  @override
  String get deviceDoesNotHaveSensors => 'Құрылғыда сенсорлар жоқ !';

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
  String get downloadPrayerTime => 'Намаз уақыттарын жүктеп алу';

  @override
  String get calculationMethodsListEmpty => 'Есептеу әдістерінің тізімі бос.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Орналасқан жер деректерімен ешқандай есептеу әдісі табылмады.';

  @override
  String get prayerSettings => 'Намаз параметрлері';

  @override
  String get reminderSettings => 'Еске салғыш параметрлері';

  @override
  String get adjustReminderTime => 'Еске салу уақытын реттеу';

  @override
  String get enforceAlarmSound => 'Дабыл дыбысын мәжбүрлі түрде қосу';

  @override
  String get enforceAlarmSoundDescription =>
      'Егер қосылса, бұл мүмкіндік телефон дыбысы төмен болса да, дабылды осы жерде орнатылған дыбыс деңгейінде ойнатады. Бұл телефонның төмен дыбыс деңгейіне байланысты дабылды өткізіп алмауды қамтамасыз етеді.';

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
    return '$prayerName уақыты $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Қазір $prayerName уақыты';
  }

  @override
  String get stopTheAdhan => 'Азанды тоқтату';

  @override
  String dateFoundEmpty(String date) {
    return '$date күні бос табылды';
  }

  @override
  String get today => 'Бүгін';

  @override
  String get left => 'Қалды';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName үшін еске салғыш қосылды';
  }

  @override
  String get allowNotificationPermission =>
      'Бұл мүмкіндікті пайдалану үшін хабарландыру рұқсатын беріңіз';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName үшін еске салғыш жойылды';
  }

  @override
  String get getPrayerTimesAndQibla => 'Намаз уақыттары мен Құбыланы алу';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Кез келген орын үшін намаз уақыттары мен құбыланы есептеу.';

  @override
  String get getFromGPS => 'GPS арқылы алу';

  @override
  String get or => 'Немесе';

  @override
  String get selectYourCity => 'Қалаңызды таңдаңыз';

  @override
  String get noteAboutGPS =>
      'Ескерту: Егер сіз GPS-ті пайдаланғыңыз келмесе немесе өзіңізді қауіпсіз сезінбесеңіз, қалаңызды таңдай аласыз.';

  @override
  String get downloadingLocationResources =>
      'Орналасқан жер ресурстары жүктелуде...';

  @override
  String get somethingWentWrong => 'Бір қателік орын алды';

  @override
  String get selectYourCountry => 'Еліңізді таңдаңыз';

  @override
  String get searchForACountry => 'Ел іздеу';

  @override
  String get selectYourAdministrator => 'Әкімшілік аймағыңызды таңдаңыз';

  @override
  String get searchForAnAdministrator => 'Әкімшілік аймақ іздеу';

  @override
  String get searchForACity => 'Қала іздеу';

  @override
  String get pleaseEnableLocationService =>
      'Орналасқан жерді анықтау қызметін қосыңыз';

  @override
  String get donateUs => 'Бізге қолдау көрсетіңіз';

  @override
  String get underDevelopment => 'Жасалу үстінде';

  @override
  String get versionLoading => 'Нұсқасы жүктелуде...';

  @override
  String get alQuran => 'Әл-Құран';

  @override
  String get mainMenu => 'Негізгі мәзір';

  @override
  String get notes => 'Жазбалар';

  @override
  String get pinned => 'Бекітілгендер';

  @override
  String get jumpToAyah => 'Аятқа өту';

  @override
  String get shareMultipleAyah => 'Бірнеше аятты бөлісу';

  @override
  String get shareThisApp => 'Осы қолданбамен бөлісу';

  @override
  String get giveRating => 'Бағалау';

  @override
  String get bugReport => 'Қате туралы хабарлау';

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
      'Қолданбаны қалпына келтіргіңіз келетініне сенімдісіз бе? Барлық деректеріңіз жойылады және қолданбаны басынан бастап орнатуыңыз керек болады.';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get reset => 'Қалпына келтіру';

  @override
  String get shareAppSubject => 'Мына Әл-Құран қолданбасын қарап көріңіз!';

  @override
  String shareAppBody(String appLink) {
    return 'Ассалаумағалейкум! Күнделікті оқу және ой жүгірту үшін осы Әл-Құран қолданбасын қарап көріңіз. Ол Алланың сөздерімен байланысуға көмектеседі. Мына жерден жүктеп алыңыз: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Мәзірді ашу';

  @override
  String get quran => 'Құран';

  @override
  String get prayer => 'Намаз';

  @override
  String get qibla => 'Құбыла';

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
      'Бұл жазбалар жинағы бос.\nОларды осы жерден көру үшін жазбалар қосыңыз.';

  @override
  String get emptyPinnedCollection =>
      'Бұл жинаққа әлі аяттар бекітілмеген.\nОларды осы жерден көру үшін аяттарды бекітіңіз.';

  @override
  String get noContentAvailable => 'Мазмұн жоқ.';

  @override
  String failedToLoadCollections(String error) {
    return 'Жинақтарды жүктеу сәтсіз аяқталды: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType атауы бойынша іздеу...';
  }

  @override
  String get sortBy => 'Сұрыптау';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Әлі ешқандай $collectionType қосылмаған';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count бекітілген элемент';
  }

  @override
  String notesCount(int count) {
    return '$count жазба';
  }

  @override
  String get emptyNameNotAllowed => 'Атауын бос қалдыруға болмайды';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName болып жаңартылды';
  }

  @override
  String get changeName => 'Атауын өзгерту';

  @override
  String get changeColor => 'Түсін өзгерту';

  @override
  String get colorUpdated => 'Түсі жаңартылды';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName жойылды';
  }

  @override
  String get delete => 'Жою';

  @override
  String get save => 'Сақтау';

  @override
  String get collectionNameCannotBeEmpty => 'Жинақ атауы бос болмауы керек.';

  @override
  String get addedNewCollection => 'Жаңа жинақ қосылды';

  @override
  String ayahCount(int count) {
    return '$count аят';
  }

  @override
  String get byNameAtoZ => 'Атауы бойынша А-Я';

  @override
  String get byNameZtoA => 'Атауы бойынша Я-А';

  @override
  String get byElementNumberAscending => 'Элемент нөмірі бойынша өсу';

  @override
  String get byElementNumberDescending => 'Элемент нөмірі бойынша кему';

  @override
  String get byUpdateDateAscending => 'Жаңарту күні бойынша өсу';

  @override
  String get byUpdateDateDescending => 'Жаңарту күні бойынша кему';

  @override
  String get byCreateDateAscending => 'Құру күні бойынша өсу';

  @override
  String get byCreateDateDescending => 'Құру күні бойынша кему';

  @override
  String get translationNotFound => 'Аударма табылмады';

  @override
  String get translationTitle => 'Аударма:';

  @override
  String get footNoteTitle => 'Түсініктеме:';

  @override
  String get wordByWordTranslation => 'Сөзбе-сөз аударма:';

  @override
  String get tafsirButton => 'Тәпісір';

  @override
  String get shareButton => 'Бөлісу';

  @override
  String get addNoteButton => 'Жазба қосу';

  @override
  String get pinToCollectionButton => 'Жинаққа бекіту';

  @override
  String get shareAsText => 'Мәтін ретінде бөлісу';

  @override
  String get copiedWithTafsir => 'Тәпісірмен бірге көшірілді';

  @override
  String get shareAsImage => 'Сурет ретінде бөлісу';

  @override
  String get shareWithTafsir => 'Тәпісірмен бірге бөлісу';

  @override
  String get notFound => 'Табылмады';

  @override
  String get noteContentCannotBeEmpty => 'Жазба мазмұны бос болмауы керек.';

  @override
  String get noteSavedSuccessfully => 'Жазба сәтті сақталды!';

  @override
  String get selectCollections => 'Жинақтарды таңдау';

  @override
  String get addNote => 'Жазба қосу';

  @override
  String get writeCollectionName => 'Жинақ атауын жазыңыз...';

  @override
  String get noCollectionsYetAddANewOne => 'Әлі жинақтар жоқ. Жаңасын қосыңыз!';

  @override
  String get pleaseWriteYourNoteFirst => 'Алдымен жазбаңызды жазыңыз.';

  @override
  String get noCollectionSelected => 'Жинақ таңдалмаған';

  @override
  String get saveNote => 'Жазбаны сақтау';

  @override
  String get nextSelectCollections => 'Келесі: Жинақтарды таңдау';

  @override
  String get addToPinned => 'Бекітілгендерге қосу';

  @override
  String get pinnedSavedSuccessfully => 'Бекітілгендер сәтті сақталды!';

  @override
  String get savePinned => 'Бекітілгендерді сақтау';

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
  String get selectReciter => 'Қариды таңдау';

  @override
  String source(String source) {
    return 'Дереккөз: $source';
  }

  @override
  String get newText => 'Жаңа';

  @override
  String get more => 'Толығырақ: ';

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
  String get aboutAlQuran => 'Әл-Құран туралы';

  @override
  String get appFullName => 'Әл-Құран (Тәпісір, Намаз, Құбыла, Аудио)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux және Windows-қа арналған кешенді исламдық қолданба. Тәпісірмен және бірнеше аудармамен (соның ішінде сөзбе-сөз) Құран оқу, хабарландырулары бар дүниежүзілік намаз уақыттары, Құбыла компасы және синхрондалған сөзбе-сөз аудио оқу мүмкіндіктері бар.';

  @override
  String get dataSourcesNote =>
      'Ескерту: Құран мәтіндері, тәпісірлер, аудармалар және аудио ресурстар Quran.com, Everyayah.com және басқа да тексерілген ашық дереккөздерден алынған.';

  @override
  String get adFreePromise =>
      'Бұл қолданба Алланың разылығын іздеу үшін жасалған. Сондықтан, ол толығымен жарнамасыз және әрқашан солай болып қалады.';

  @override
  String get coreFeatures => 'Негізгі мүмкіндіктер';

  @override
  String get coreFeaturesDescription =>
      'Әл-Құран v3-ті күнделікті ислами амалдарыңыз үшін таптырмас құрал ететін негізгі функцияларды зерттеңіз:';

  @override
  String get prayerTimesTitle => 'Намаз уақыттары мен ескертулері';

  @override
  String get prayerTimesDescription =>
      'Түрлі есептеу әдістерін қолдана отырып, дүние жүзіндегі кез келген жер үшін дәл намаз уақыттары. Азан хабарландыруларымен еске салғыштарды орнатыңыз.';

  @override
  String get qiblaDirectionTitle => 'Құбыла бағыты';

  @override
  String get qiblaDirectionDescription =>
      'Анық және дәл компас көрінісімен Құбыла бағытын оңай табыңыз.';

  @override
  String get translationTafsirTitle => 'Құран аудармасы мен тәпісірі';

  @override
  String get translationTafsirDescription =>
      '69 тілдегі 120-дан астам аударма кітабына (сөзбе-сөз аударманы қоса) және 30-дан астам тәпісір кітабына қол жеткізіңіз.';

  @override
  String get wordByWordAudioTitle => 'Сөзбе-сөз аудио және бөлектеу';

  @override
  String get wordByWordAudioDescription =>
      'Тереңдетілген оқу тәжірибесі үшін синхрондалған сөзбе-сөз аудио оқуды және бөлектеуді қадағалаңыз.';

  @override
  String get ayahAudioRecitationTitle => 'Аяттардың аудио оқылуы';

  @override
  String get ayahAudioRecitationDescription =>
      '40-тан астам танымал қарилардың толық аят оқуларын тыңдаңыз.';

  @override
  String get notesCloudBackupTitle => 'Бұлттық сақтық көшірмесі бар жазбалар';

  @override
  String get notesCloudBackupDescription =>
      'Жеке жазбалар мен ой-пікірлерді сақтаңыз, олар бұлтта қауіпсіз сақталады (мүмкіндік әзірленуде/жақында қолжетімді болады).';

  @override
  String get crossPlatformSupportTitle => 'Кросс-платформалық қолдау';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux және Windows жүйелерінде қолдау көрсетіледі.';

  @override
  String get backgroundAudioPlaybackTitle => 'Фондық режимде аудио ойнату';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Қолданба фондық режимде болса да, Құран оқуын тыңдауды жалғастырыңыз.';

  @override
  String get audioDataCachingTitle => 'Аудио мен деректерді кэштеу';

  @override
  String get audioDataCachingDescription =>
      'Сенімді аудио мен Құран деректерін кэштеу арқылы жақсартылған ойнату және офлайн мүмкіндіктері.';

  @override
  String get minimalisticInterfaceTitle => 'Минималистік және таза интерфейс';

  @override
  String get minimalisticInterfaceDescription =>
      'Пайдаланушы тәжірибесі мен оқылуына баса назар аударылған, навигациясы оңай интерфейс.';

  @override
  String get optimizedPerformanceTitle =>
      'Оңтайландырылған өнімділік пен өлшем';

  @override
  String get optimizedPerformanceDescription =>
      'Жеңіл және өнімді болу үшін жасалған, мүмкіндіктері мол қолданба.';

  @override
  String get languageSupport => 'Тілдік қолдау';

  @override
  String get languageSupportDescription =>
      'Бұл қолданба келесі тілдерді қолдау арқылы жаһандық аудиторияға қолжетімді болу үшін жасалған (және үнемі жаңалары қосылып отырады):';

  @override
  String get technologyAndResources => 'Технологиялар мен ресурстар';

  @override
  String get technologyAndResourcesDescription =>
      'Бұл қолданба озық технологиялар мен сенімді ресурстарды пайдалана отырып жасалған:';

  @override
  String get flutterFrameworkTitle => 'Flutter фреймворкы';

  @override
  String get flutterFrameworkDescription =>
      'Бір код базасынан әдемі, жергілікті компиляцияланған, көп платформалы тәжірибе үшін Flutter-мен жасалған.';

  @override
  String get advancedAudioEngineTitle => 'Жетілдірілген аудио қозғалтқышы';

  @override
  String get advancedAudioEngineDescription =>
      'Сенімді аудио ойнату және басқару үшін `just_audio` және `just_audio_background` Flutter пакеттерімен жұмыс істейді.';

  @override
  String get reliableQuranDataTitle => 'Сенімді Құран деректері';

  @override
  String get reliableQuranDataDescription =>
      'Әл-Құран мәтіндері, аудармалары, тәпісірлері және аудиосы Quran.com мен Everyayah.com сияқты тексерілген ашық API-лер мен дерекқорлардан алынған.';

  @override
  String get prayerTimeEngineTitle => 'Намаз уақытын есептеу қозғалтқышы';

  @override
  String get prayerTimeEngineDescription =>
      'Дәл намаз уақыттары үшін белгіленген есептеу әдістерін пайдаланады. Хабарландырулар `flutter_local_notifications` және фондық тапсырмалар арқылы өңделеді.';

  @override
  String get crossPlatformSupport => 'Кросс-платформалық қолдау';

  @override
  String get crossPlatformSupportDescription2 =>
      'Түрлі платформаларда үздіксіз қол жеткізудің рахатын көріңіз:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'Веб';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'Біздің өмірлік уәдеміз';

  @override
  String get lifetimePromiseDescription =>
      'Мен жеке өзім өмір бойы, Ин ша Алла, осы қолданбаға үздіксіз қолдау мен техникалық қызмет көрсетуге уәде беремін. Менің мақсатым - бұл қолданбаның алдағы жылдар бойы үммет үшін пайдалы ресурс болып қалуын қамтамасыз ету.';

  @override
  String get fajr => 'Таң';

  @override
  String get sunrise => 'Күн шығуы';

  @override
  String get dhuhr => 'Бесін';

  @override
  String get asr => 'Екінті';

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
  String get quranScriptTajweed => 'Тәжуид';

  @override
  String get quranScriptUthmani => 'Усмани';

  @override
  String get quranScriptIndopak => 'Индо-Пак';

  @override
  String get sajdaAyah => 'Сәжде аяты';

  @override
  String get required => 'Міндетті';

  @override
  String get optional => 'Ерікті';

  @override
  String get notificationScheduleWarning =>
      'Ескерту: Жоспарланған хабарландыру немесе еске салғыш телефонның ОЖ фондық процесс шектеулеріне байланысты өткізіліп кетуі мүмкін. Мысалы: Vivo-ның Origin ОЖ, Samsung-тың One UI, Oppo-ның ColorOS және т.б. кейде жоспарланған хабарландыруды немесе еске салғышты тоқтатады. Қолданбаның фондық процестен шектелмеуі үшін ОЖ параметрлерін тексеріңіз.';

  @override
  String get scrollWithRecitation => 'Оқумен айналдыру';

  @override
  String get quickAccess => 'Жылдам қатынау';

  @override
  String get initiallyScrollAyah => 'Бастапқыда аятқа жылжыңыз';

  @override
  String get tajweedGuide => 'Тәжуид нұсқаулығы';

  @override
  String get scrollWithRecitationDesc =>
      'Қосылған кезде, Құран аяты аудио оқумен синхронды түрде автоматты түрде жылжиды.';

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
      'Жүктеп алудың орнына интернеттен тікелей аудио ағыны.';

  @override
  String get notUseAudioStreamDesc =>
      'Офлайн пайдалану үшін аудионы жүктеп алыңыз және деректерді тұтынуды азайтыңыз.';

  @override
  String get audioSettings => 'Аудио параметрлері';

  @override
  String get playbackSpeed => 'Ойнату жылдамдығы';

  @override
  String get playbackSpeedDesc => 'Құран оқу жылдамдығын реттеңіз.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Ағымдағы жүктеп алудың аяқталуын күтіңіз.';

  @override
  String get areYouSure => 'Сіз сенімдісіз бе?';

  @override
  String get checkYourInternetConnection =>
      'Интернет қосылымыңызды тексеріңіз.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount аяттың $requiredDownload жүктеп алу қажет.';
  }

  @override
  String get download => 'Жүктеп алу';

  @override
  String get audioDownload => 'Аудио жүктеу';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';
}
