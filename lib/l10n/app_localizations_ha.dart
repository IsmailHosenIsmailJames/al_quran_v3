// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

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
    return 'Babu Tafsiri don $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Za a samu Tafsiri a: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Tsallaka zuwa $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizifi';

  @override
  String get juz => 'Izifi';

  @override
  String get page => 'Shafi';

  @override
  String get ruku => 'Ruku\'u';

  @override
  String get languageSettings => 'Saitunan Harshe';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayoyi';
  }

  @override
  String get saveAndDownload => 'Ajiye kuma Sauko da';

  @override
  String get appLanguage => 'Harshen Manhaja';

  @override
  String get selectAppLanguage => 'Zaɓi harshen manhaja...';

  @override
  String get pleaseSelectOne => 'Don Allah a zaɓi ɗaya';

  @override
  String get quranTranslationLanguage => 'Harshen Fassara Al-Qur\'ani';

  @override
  String get selectTranslationLanguage => 'Zaɓi harshen fassara...';

  @override
  String get quranTranslationBook => 'Littafin Fassara Al-Qur\'ani';

  @override
  String get selectTranslationBook => 'Zaɓi littafin fassara...';

  @override
  String get quranTafsirLanguage => 'Harshen Tafsirin Al-Qur\'ani';

  @override
  String get selectTafsirLanguage => 'Zaɓi harshen tafsiri...';

  @override
  String get quranTafsirBook => 'Littafin Tafsirin Al-Qur\'ani';

  @override
  String get selectTafsirBook => 'Zaɓi littafin tafsiri...';

  @override
  String get quranScriptAndStyle => 'Rubutu & Salon Al-Qur\'ani';

  @override
  String get justAMoment => 'Sauran kaɗan...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'An yi nasara';

  @override
  String get retry => 'Sake gwadawa';

  @override
  String get unableToDownloadResources =>
      'Ba a iya sauko da abubuwan da ake buƙata ba...\nWani abu ya faru ba daidai ba';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Ana sauko da karatun Al-Qur\'ani kashi-kashi';

  @override
  String get processingSegmentedQuranRecitation =>
      'Ana sarrafa karatun Al-Qur\'ani kashi-kashi';

  @override
  String get footnote => 'Bayanan ƙafa';

  @override
  String get tafsir => 'Tafsiri';

  @override
  String get wordByWord => 'Kalma da kalma';

  @override
  String get pleaseSelectRequiredOption =>
      'Don Allah a zaɓi abin da ake buƙata';

  @override
  String get rememberHomeTab => 'Tuna da Babban Shafi';

  @override
  String get rememberHomeTabSubtitle =>
      'Manhajar za ta riƙe shafin da aka buɗe na ƙarshe a babban shafi.';

  @override
  String get wakeLock => 'Hana allo kashewa';

  @override
  String get wakeLockSubtitle => 'Hana allo daga kashewa da kansa.';

  @override
  String get settings => 'Saituna';

  @override
  String get appTheme => 'Jigon Manhaja';

  @override
  String get quranStyle => 'Salon Al-Qur\'ani';

  @override
  String get changeTheme => 'Canja Jigo';

  @override
  String get verseCount => 'Adadin Ayoyi: ';

  @override
  String get translation => 'Fassara';

  @override
  String get tafsirNotFound => 'Ba a samu ba';

  @override
  String get moreInfo => 'ƙarin bayani';

  @override
  String get playAudio => 'Kunna Sauti';

  @override
  String get preview => 'Kwatance';

  @override
  String get loading => 'Ana budewa...';

  @override
  String get errorFetchingAddress => 'Kuskure wajen samo adireshi';

  @override
  String get addressNotAvailable => 'Babu adireshi';

  @override
  String get latitude => 'Latitude: ';

  @override
  String get longitude => 'Longitude: ';

  @override
  String get name => 'Suna: ';

  @override
  String get location => 'Wuri: ';

  @override
  String get parameters => 'Ma\'aunai: ';

  @override
  String get selectCalculationMethod => 'Zaɓi Hanyar Lissafi';

  @override
  String get shareSelectAyahs => 'Raba Ayoyin da aka Zaɓa';

  @override
  String get selectionEmpty => 'Babu Abin da Aka Zaɓa';

  @override
  String get generatingImagePleaseWait =>
      'Ana Kirkirar Hoto... Don Allah a jira';

  @override
  String get asImage => 'A Matsayin Hoto';

  @override
  String get asText => 'A Matsayin Rubutu';

  @override
  String get playFromSelectedAyah => 'Kunna daga Ayar da aka Zaɓa';

  @override
  String get toTafsir => 'Zuwa Tafsiri';

  @override
  String get selectAyah => 'Zaɓi Aya';

  @override
  String get toAyah => 'Zuwa Aya';

  @override
  String get searchForASurah => 'Nemo sura';

  @override
  String get bugReportTitle => 'Rahoton Kuskure';

  @override
  String get audioCached => 'An adana sauti a ma\'ajiya';

  @override
  String get others => 'Wasu';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Al-Qur\'ani|Fassara|Aya, Dole ne a kunna ɗaya';

  @override
  String get quranFontSize => 'Gudun Rubutun Al-Qur\'ani';

  @override
  String get quranLineHeight => 'Tsayin Layin Al-Qur\'ani';

  @override
  String get translationAndTafsirFontSize => 'Gudun Rubutun Fassara & Tafsiri';

  @override
  String get quranAyah => 'Ayar Al-Qur\'ani';

  @override
  String get topToolbar => 'Maɓallan Sama';

  @override
  String get keepOpenWordByWord => 'Bar Kalma da Kalma a buɗe';

  @override
  String get wordByWordHighlight => 'Haskaka Kalma da Kalma';

  @override
  String get quranScriptSettings => 'Saitunan Rubutun Al-Qur\'ani';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Shafi: ';

  @override
  String get quranResources => 'Abubuwan Al-Qur\'ani';

  @override
  String alreadySelected(String name) {
    return 'An riga an zaɓi harshen \'$name\'.';
  }

  @override
  String get unableToGetCompassData => 'Ba a iya samun bayanan alkibla ba';

  @override
  String get deviceDoesNotHaveSensors =>
      'Wannan na\'urar ba ta da na\'urori masu auna sigina!';

  @override
  String get north => 'A';

  @override
  String get east => 'G';

  @override
  String get south => 'K';

  @override
  String get west => 'Y';

  @override
  String get address => 'Adireshi: ';

  @override
  String get change => 'Canja';

  @override
  String get calculationMethod => 'Hanyar Lissafi: ';

  @override
  String get downloadPrayerTime => 'Sauko da Lokutan Sallah';

  @override
  String get calculationMethodsListEmpty =>
      'Jerin hanyoyin lissafi ba komai a ciki.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Ba a sami hanyar lissafi da bayanan wuri ba.';

  @override
  String get prayerSettings => 'Saitunan Sallah';

  @override
  String get reminderSettings => 'Saitunan Tunatarwa';

  @override
  String get adjustReminderTime => 'Daidaita Lokacin Tunatarwa';

  @override
  String get enforceAlarmSound => 'Tilasta Sautin Ƙararrawa';

  @override
  String get enforceAlarmSoundDescription =>
      'Idan an kunna, wannan fasalin zai kunna ƙararrawa da ƙarfin da aka saita anan, koda sautin wayarka a ƙasa yake. Wannan yana tabbatar da cewa ba za ka rasa ƙararrawa ba saboda ƙarancin sautin waya.';

  @override
  String get volume => 'Sauti';

  @override
  String get atPrayerTime => 'A lokacin sallah';

  @override
  String minBefore(int minutes) {
    return 'minti $minutes kafin';
  }

  @override
  String minAfter(int minutes) {
    return 'minti $minutes bayan';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Lokacin $prayerName ya yi da karfe $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Lokacin $prayerName ya yi';
  }

  @override
  String get stopTheAdhan => 'Tsayar da Kiran Sallah';

  @override
  String dateFoundEmpty(String date) {
    return 'Babu bayani na $date';
  }

  @override
  String get today => 'Yau';

  @override
  String get left => 'Saura';

  @override
  String reminderAdded(String prayerName) {
    return 'An ƙara tunatarwa don $prayerName';
  }

  @override
  String get allowNotificationPermission =>
      'Don Allah a ba da izinin sanarwa don amfani da wannan fasalin';

  @override
  String reminderRemoved(String prayerName) {
    return 'An cire tunatarwa don $prayerName';
  }

  @override
  String get getPrayerTimesAndQibla => 'Samo Lokutan Sallah da Alkibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Lissafa Lokutan Sallah da Alkibla ga kowane wuri.';

  @override
  String get getFromGPS => 'Samo daga GPS';

  @override
  String get or => 'Ko';

  @override
  String get selectYourCity => 'Zaɓi Garinku';

  @override
  String get noteAboutGPS =>
      'Lura: Idan ba ka son amfani da GPS ko ba ka ji daɗin tsaro ba, za ka iya zaɓar garinku.';

  @override
  String get downloadingLocationResources => 'Ana sauko da bayanan wuri...';

  @override
  String get somethingWentWrong => 'Wani abu ya faru ba daidai ba';

  @override
  String get selectYourCountry => 'Zaɓi Ƙasarku';

  @override
  String get searchForACountry => 'Nemo ƙasa';

  @override
  String get selectYourAdministrator => 'Zaɓi Hukumar ku';

  @override
  String get searchForAnAdministrator => 'Nemo hukuma';

  @override
  String get searchForACity => 'Nemo gari';

  @override
  String get pleaseEnableLocationService => 'Don Allah a kunna sabis ɗin wuri';

  @override
  String get donateUs => 'Ba da Gudummawa';

  @override
  String get underDevelopment => 'Ana kan aiki';

  @override
  String get versionLoading => 'Ana budewa...';

  @override
  String get alQuran => 'Al-Qur\'ani';

  @override
  String get mainMenu => 'Babban Menu';

  @override
  String get notes => 'Rubuce-rubuce';

  @override
  String get pinned => 'Mananne';

  @override
  String get jumpToAyah => 'Tsallaka zuwa Aya';

  @override
  String get shareMultipleAyah => 'Raba Ayoyi da yawa';

  @override
  String get shareThisApp => 'Raba Wannan Manhaja';

  @override
  String get giveRating => 'Bada Maki';

  @override
  String get bugReport => 'Kai Rahoton Kuskure';

  @override
  String get privacyPolicy => 'Dokar Sirri';

  @override
  String get aboutTheApp => 'Game da Manhaja';

  @override
  String get resetTheApp => 'Sake Saitin Manhaja';

  @override
  String get resetAppWarningTitle => 'Sake Saitin Bayanan Manhaja';

  @override
  String get resetAppWarningMessage =>
      'Shin kun tabbata kuna son sake saitin manhajar? Dukkan bayananku za su ɓace, kuma kuna buƙatar sake saita manhajar daga farko.';

  @override
  String get cancel => 'Soke';

  @override
  String get reset => 'Sake saiti';

  @override
  String get shareAppSubject => 'Duba wannan Manhajar Al-Qur\'ani!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamu alaikum! Duba wannan manhajar Al-Qur\'ani don karatu da tunani na yau da kullun. Yana taimakawa wajen haɗa kai da kalmomin Allah. Sauko da ita anan: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Buɗe Menu';

  @override
  String get quran => 'Al-Qur\'ani';

  @override
  String get prayer => 'Sallah';

  @override
  String get qibla => 'Alkibla';

  @override
  String get audio => 'Sauti';

  @override
  String get surah => 'Sura';

  @override
  String get pages => 'Shafuka';

  @override
  String get note => 'Lura:';

  @override
  String get linkedAyahs => 'Ayoyi masu alaƙa:';

  @override
  String get emptyNoteCollection =>
      'Wannan tarin rubuce-rubucen ba komai a ciki.\nƘara wasu rubuce-rubuce don ganin su a nan.';

  @override
  String get emptyPinnedCollection =>
      'Babu wata Aya da aka manna a wannan tarin tukuna.\nManna Ayoyi don ganin su a nan.';

  @override
  String get noContentAvailable => 'Babu wani abun ciki.';

  @override
  String failedToLoadCollections(String error) {
    return 'An kasa buɗe tarin: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Nemo ta sunan $collectionType...';
  }

  @override
  String get sortBy => 'Shirya ta';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Babu wani $collectionType da aka ƙara tukuna';
  }

  @override
  String pinnedItemsCount(int count) {
    return 'abubuwa $count da aka manna';
  }

  @override
  String notesCount(int count) {
    return 'rubuce-rubuce $count';
  }

  @override
  String get emptyNameNotAllowed => 'Ba a yarda da suna fanko ba';

  @override
  String updatedTo(String collectionName) {
    return 'An sabunta zuwa $collectionName';
  }

  @override
  String get changeName => 'Canja Suna';

  @override
  String get changeColor => 'Canja Launi';

  @override
  String get colorUpdated => 'An sabunta launi';

  @override
  String collectionDeleted(String collectionName) {
    return 'An goge $collectionName';
  }

  @override
  String get delete => 'Goge';

  @override
  String get save => 'Ajiye';

  @override
  String get collectionNameCannotBeEmpty =>
      'Sunan tarin ba zai iya zama fanko ba.';

  @override
  String get addedNewCollection => 'An Ƙara Sabon Tari';

  @override
  String ayahCount(int count) {
    return 'Aya $count';
  }

  @override
  String get byNameAtoZ => 'Suna A-Z';

  @override
  String get byNameZtoA => 'Suna Z-A';

  @override
  String get byElementNumberAscending => 'Lambar abu daga ƙasa zuwa sama';

  @override
  String get byElementNumberDescending => 'Lambar abu daga sama zuwa ƙasa';

  @override
  String get byUpdateDateAscending => 'Ranar sabuntawa daga baya zuwa yanzu';

  @override
  String get byUpdateDateDescending => 'Ranar sabuntawa daga yanzu zuwa baya';

  @override
  String get byCreateDateAscending => 'Ranar ƙirƙira daga baya zuwa yanzu';

  @override
  String get byCreateDateDescending => 'Ranar ƙirƙira daga yanzu zuwa baya';

  @override
  String get translationNotFound => 'Ba a samu Fassara ba';

  @override
  String get translationTitle => 'Fassara:';

  @override
  String get footNoteTitle => 'Bayanin ƙafa:';

  @override
  String get wordByWordTranslation => 'Fassarar Kalma da Kalma:';

  @override
  String get tafsirButton => 'Tafsiri';

  @override
  String get shareButton => 'Raba';

  @override
  String get addNoteButton => 'Ƙara Rubutu';

  @override
  String get pinToCollectionButton => 'Manna zuwa Tari';

  @override
  String get shareAsText => 'Raba a matsayin Rubutu';

  @override
  String get copiedWithTafsir => 'An kwafa da Tafsiri';

  @override
  String get shareAsImage => 'Raba a matsayin Hoto';

  @override
  String get shareWithTafsir => 'Raba da Tafsiri';

  @override
  String get notFound => 'Ba a samu ba';

  @override
  String get noteContentCannotBeEmpty =>
      'Cikin rubutu ba zai iya zama fanko ba.';

  @override
  String get noteSavedSuccessfully => 'An ajiye rubutu cikin nasara!';

  @override
  String get selectCollections => 'Zaɓi Tarin';

  @override
  String get addNote => 'Ƙara Rubutu';

  @override
  String get writeCollectionName => 'Rubuta sunan tarin...';

  @override
  String get noCollectionsYetAddANewOne => 'Babu wani tari tukuna. Ƙara sabo!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Don Allah a rubuta bayanin ka da farko.';

  @override
  String get noCollectionSelected => 'Babu tarin da aka zaɓa';

  @override
  String get saveNote => 'Ajiye Rubutu';

  @override
  String get nextSelectCollections => 'Na gaba: Zaɓi Tarin';

  @override
  String get addToPinned => 'Ƙara zuwa Mananne';

  @override
  String get pinnedSavedSuccessfully => 'An ajiye a mananne cikin nasara!';

  @override
  String get savePinned => 'Ajiye Mananne';

  @override
  String get closeAudioController => 'Rufe Mai Sarrafa Sauti';

  @override
  String get previous => 'Baya';

  @override
  String get rewind => 'Juyawa Baya';

  @override
  String get fastForward => 'Gudun Gaba';

  @override
  String get playNextAyah => 'Kunna Aya ta Gaba';

  @override
  String get repeat => 'Maimaita';

  @override
  String get playAsPlaylist => 'Kunna a matsayin Jerin Waƙoƙi';

  @override
  String style(String style) {
    return 'Salo: $style';
  }

  @override
  String get stopAndClose => 'Tsayar & Rufe';

  @override
  String get play => 'Kunna';

  @override
  String get pause => 'Dakata';

  @override
  String get selectReciter => 'Zaɓi Makaranci';

  @override
  String source(String source) {
    return 'Majiya: $source';
  }

  @override
  String get newText => 'Sabo';

  @override
  String get more => 'Ƙari: ';

  @override
  String get cacheNotFound => 'Ba a samu Ma\'ajiya ba';

  @override
  String get cacheSize => 'Gudun Ma\'ajiya';

  @override
  String error(String error) {
    return 'Kuskure: $error';
  }

  @override
  String get clean => 'Tsaftace';

  @override
  String get lastModified => 'Gyaran Ƙarshe';

  @override
  String get oneYearAgo => 'Shekara 1 da ta wuce';

  @override
  String monthsAgo(String number) {
    return 'Watanni $number da suka wuce';
  }

  @override
  String weeksAgo(String number) {
    return 'Makonni $number da suka wuce';
  }

  @override
  String daysAgo(String number) {
    return 'Kwanaki $number da suka wuce';
  }

  @override
  String hoursAgo(int hour) {
    return 'Awoyi $hour da suka wuce';
  }

  @override
  String get aboutAlQuran => 'Game da Al-Qur\'ani';

  @override
  String get appFullName => 'Al-Qur\'ani (Tafsiri, Sallah, Alkibla, Sauti)';

  @override
  String get appDescription =>
      'Wata cikakkiyar manhajar Musulunci don Android, iOS, MacOS, Web, Linux da Windows, wacce ke ba da damar karatun Al-Qur\'ani tare da Tafsiri & fassarori da yawa (ciki har da kalma da kalma), lokutan sallah na duniya tare da sanarwa, alkibla, da karatun sauti na kalma da kalma a tare.';

  @override
  String get dataSourcesNote =>
      'Lura: Rubutun Al-Qur\'ani, Tafsiri, fassarori, da sautuka an samo su ne daga Quran.com, Everyayah.com, da sauran ingantattun majiyoyi masu buɗe.';

  @override
  String get adFreePromise =>
      'An gina wannan manhaja ne don neman yardar Allah. Saboda haka, ba ta da talla kuma ba za ta taɓa samun talla ba har abada.';

  @override
  String get coreFeatures => 'Muhimman Ayyuka';

  @override
  String get coreFeaturesDescription =>
      'Binciko muhimman ayyukan da suka sa Al-Qur\'ani v3 ya zama kayan aiki mai muhimmanci ga ayyukanka na Musulunci na yau da kullun:';

  @override
  String get prayerTimesTitle => 'Lokutan Sallah & Fadakarwa';

  @override
  String get prayerTimesDescription =>
      'Daidaitattun lokutan sallah ga kowane wuri a duniya ta amfani da hanyoyin lissafi daban-daban. Saita tunatarwa da sanarwar Kiran Sallah.';

  @override
  String get qiblaDirectionTitle => 'Al-kibla';

  @override
  String get qiblaDirectionDescription =>
      'A sauƙaƙe nemo alkibla da ingantaccen kompas mai haske.';

  @override
  String get translationTafsirTitle => 'Fassara & Tafsirin Al-Qur\'ani';

  @override
  String get translationTafsirDescription =>
      'Samun damar littattafan fassara sama da 120 (ciki har da kalma da kalma) a cikin harsuna 69, da littattafan Tafsiri sama da 30.';

  @override
  String get wordByWordAudioTitle => 'Sauti & Haskaka Kalma da Kalma';

  @override
  String get wordByWordAudioDescription =>
      'Bi tare da karatun sauti na kalma da kalma da aka haɗa da haskakawa don samun kwarewar ilmantarwa mai zurfi.';

  @override
  String get ayahAudioRecitationTitle => 'Karatun Sauti na Aya';

  @override
  String get ayahAudioRecitationDescription =>
      'Saurari cikakken karatun Ayoyi daga mashahuran makaranta sama da 40.';

  @override
  String get notesCloudBackupTitle => 'Rubuce-rubuce da Ajiya a \'Cloud\'';

  @override
  String get notesCloudBackupDescription =>
      'Ajiye rubuce-rubuce na sirri da tunani, waɗanda aka adana su a cikin \'cloud\' (wannan fasalin yana kan aiki/zai zo nan ba da daɗewa ba).';

  @override
  String get crossPlatformSupportTitle => 'Taimako a Dandamali Daban-daban';

  @override
  String get crossPlatformSupportDescription =>
      'Ana tallafawa a kan Android, Web, Linux, da Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Kunna Sauti a Baya';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Ci gaba da sauraron karatun Al-Qur\'ani koda manhajar tana aiki a baya.';

  @override
  String get audioDataCachingTitle => 'Adana Sauti & Bayanai';

  @override
  String get audioDataCachingDescription =>
      'Ingantaccen kunnawa da damar amfani ba tare da intanet ba tare da ingantacciyar ma\'ajiyar sauti da bayanan Al-Qur\'ani.';

  @override
  String get minimalisticInterfaceTitle => 'Sauƙaƙe & Tsabtataccen Fuska';

  @override
  String get minimalisticInterfaceDescription =>
      'Fuskar da ke da sauƙin amfani tare da mai da hankali kan jin daɗin mai amfani da sauƙin karantawa.';

  @override
  String get optimizedPerformanceTitle => 'Ingantaccen Aiki & Girma';

  @override
  String get optimizedPerformanceDescription =>
      'Manhaja mai cike da fasali wacce aka tsara don zama mai sauƙi da saurin aiki.';

  @override
  String get languageSupport => 'Taimakon Harshe';

  @override
  String get languageSupportDescription =>
      'An tsara wannan manhaja don masu amfani a duniya baki ɗaya tare da tallafi ga harsunan da ke gaba (kuma ana ci gaba da ƙara wasu):';

  @override
  String get technologyAndResources => 'Fasaha & Majiyoyi';

  @override
  String get technologyAndResourcesDescription =>
      'An gina wannan manhaja ta amfani da sabbin fasahohi da ingantattun majiyoyi:';

  @override
  String get flutterFrameworkTitle => 'Tsarin \'Flutter\'';

  @override
  String get flutterFrameworkDescription =>
      'An gina shi da Flutter don kyakkyawar kwarewa a dandamali daban-daban daga tushen lamba ɗaya.';

  @override
  String get advancedAudioEngineTitle => 'Ingantaccen Injin Sauti';

  @override
  String get advancedAudioEngineDescription =>
      'An ƙarfafa shi da fakitin Flutter `just_audio` da `just_audio_background` don ingantaccen kunna sauti da sarrafawa.';

  @override
  String get reliableQuranDataTitle => 'Ingantattun Bayanan Al-Qur\'ani';

  @override
  String get reliableQuranDataDescription =>
      'An samo rubutun Al-Qur\'ani, fassarori, tafsiri, da sautuka daga ingantattun majiyoyin buɗe kamar Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Injin Lokacin Sallah';

  @override
  String get prayerTimeEngineDescription =>
      'Yana amfani da ingantattun hanyoyin lissafi don daidaitattun lokutan sallah. Ana sarrafa sanarwa ta `flutter_local_notifications` da ayyukan baya.';

  @override
  String get crossPlatformSupport => 'Taimako a Dandamali Daban-daban';

  @override
  String get crossPlatformSupportDescription2 =>
      'Yi amfani da sauƙin shiga a dandamali daban-daban:';

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
  String get ourLifetimePromise => 'Alƙawarinmu na Har Abada';

  @override
  String get lifetimePromiseDescription =>
      'Ni da kaina na yi alƙawarin ba da tallafi da gyara na dindindin ga wannan manhaja a tsawon rayuwata, In Sha Allah. Manufata ita ce tabbatar da cewa wannan manhaja ta kasance mai amfani ga Al\'umma har shekaru masu zuwa.';

  @override
  String get fajr => 'Asuba';

  @override
  String get sunrise => 'Fitowar Rana';

  @override
  String get dhuhr => 'Azahar';

  @override
  String get asr => 'La\'asar';

  @override
  String get maghrib => 'Magariba';

  @override
  String get isha => 'Isha\'i';

  @override
  String get midnight => 'Tsakar Dare';

  @override
  String get alarm => 'Ƙararrawa';

  @override
  String get notification => 'Sanarwa';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajwidi';

  @override
  String get quranScriptUthmani => 'Usmaniyya';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Ayar Sajdah';

  @override
  String get required => 'Wajibi';

  @override
  String get optional => 'Zabi';

  @override
  String get notificationScheduleWarning =>
      'Lura: Ana iya rasa Jadawalin Sanarwa ko Tunatarwa saboda ƙuntatawa na aikin baya na OS na wayarka. Misali: Vivo\'s Origin OS, Samsung\'s One UI, Oppo\'s ColorOS da sauransu wani lokacin suna kashe Jadawalin Sanarwa ko Tunatarwa. Da fatan za a duba saitunan OS don sanya app ba a takura shi daga aikin baya ba.';

  @override
  String get scrollWithRecitation => 'Gungura da Karatu';

  @override
  String get quickAccess => 'Samun Sauri';

  @override
  String get initiallyScrollAyah => 'Da farko gungura zuwa ayah';

  @override
  String get tajweedGuide => 'Jagoran Tajwidi';
}
