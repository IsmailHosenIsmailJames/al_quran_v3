// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Somali (`so`).
class AppLocalizationsSo extends AppLocalizations {
  AppLocalizationsSo([String locale = 'so']) : super(locale);

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
    return 'Tafsiir looma hayo $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsiirka waxaad ka heli kartaa: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'U bood $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Xisbi';

  @override
  String get juz => 'Jus';

  @override
  String get page => 'Bog';

  @override
  String get ruku => 'Rukuuc';

  @override
  String get languageSettings => 'Dejinta Luqadda';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Aayadood';
  }

  @override
  String get saveAndDownload => 'Keydi oo Soo Dejiso';

  @override
  String get appLanguage => 'Luqadda Appka';

  @override
  String get selectAppLanguage => 'Dooro luqadda appka...';

  @override
  String get pleaseSelectOne => 'Fadlan dooro mid';

  @override
  String get quranTranslationLanguage => 'Luqadda Tarjumaada Qur\'aanka';

  @override
  String get selectTranslationLanguage => 'Dooro luqadda tarjumaada...';

  @override
  String get quranTranslationBook => 'Buugga Tarjumaada Qur\'aanka';

  @override
  String get selectTranslationBook => 'Dooro buugga tarjumaada...';

  @override
  String get quranTafsirLanguage => 'Luqadda Tafsiirka Qur\'aanka';

  @override
  String get selectTafsirLanguage => 'Dooro luqadda tafsiirka...';

  @override
  String get quranTafsirBook => 'Buugga Tafsiirka Qur\'aanka';

  @override
  String get selectTafsirBook => 'Dooro buugga tafsiirka...';

  @override
  String get quranScriptAndStyle => 'Farta & Qaabka Qur\'aanka';

  @override
  String get justAMoment => 'Sug wax yar...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Guul';

  @override
  String get retry => 'Isku day mar kale';

  @override
  String get unableToDownloadResources =>
      'Lama soo dejin karo agabka...\nKhalad baa dhacay';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Soo dejinta Akhrinta Qur\'aanka oo Qaybsan';

  @override
  String get processingSegmentedQuranRecitation =>
      'Habaynta Akhrinta Qur\'aanka oo Qaybsan';

  @override
  String get footnote => 'Xigasho hoose';

  @override
  String get tafsir => 'Tafsiir';

  @override
  String get wordByWord => 'Eray Eray';

  @override
  String get pleaseSelectRequiredOption =>
      'Fadlan dooro ikhtiyaarka loo baahan yahay';

  @override
  String get rememberHomeTab => 'Xusuuso Bogga Hore';

  @override
  String get rememberHomeTabSubtitle =>
      'Appku wuxuu xusuusan doonaa bogii ugu dambeeyay ee la furay shaashadda hore.';

  @override
  String get wakeLock => 'Shaashad Fur';

  @override
  String get wakeLockSubtitle =>
      'Ka ilaali shaashadda inay si toos ah u damto.';

  @override
  String get settings => 'Dejinta';

  @override
  String get appTheme => 'Dulucda Appka';

  @override
  String get quranStyle => 'Qaabka Qur\'aanka';

  @override
  String get changeTheme => 'Beddel Dulucda';

  @override
  String get verseCount => 'Tirada Aayadaha: ';

  @override
  String get translation => 'Tarjumaad';

  @override
  String get tafsirNotFound => 'Lama Helin';

  @override
  String get moreInfo => 'faahfaahin dheeraad ah';

  @override
  String get playAudio => 'Daar Codka';

  @override
  String get preview => 'Horudhac';

  @override
  String get loading => 'Wuu soo rarmayaa...';

  @override
  String get errorFetchingAddress => 'Cillad xagga ciwaanka ah';

  @override
  String get addressNotAvailable => 'Ciwaan lama hayo';

  @override
  String get latitude => 'Loolka: ';

  @override
  String get longitude => 'Dhanka: ';

  @override
  String get name => 'Magaca: ';

  @override
  String get location => 'Goobta: ';

  @override
  String get parameters => 'Halbeegyada: ';

  @override
  String get selectCalculationMethod => 'Dooro Habka Xisaabinta';

  @override
  String get shareSelectAyahs => 'La wadaag Aayadaha la xushay';

  @override
  String get selectionEmpty => 'Xulasho Madhan';

  @override
  String get generatingImagePleaseWait => 'Abuurista Sawirka... Fadlan Sug';

  @override
  String get asImage => 'Sawir Ahaan';

  @override
  String get asText => 'Qoraal Ahaan';

  @override
  String get playFromSelectedAyah => 'Ka bilow Aayada la xushay';

  @override
  String get toTafsir => 'Aad Tafsiirka';

  @override
  String get selectAyah => 'Dooro Aayad';

  @override
  String get toAyah => 'Aad Aayada';

  @override
  String get searchForASurah => 'Raadi Suurad';

  @override
  String get bugReportTitle => 'Warbixinta Ciladaha';

  @override
  String get audioCached => 'Codka waa la keydiyay';

  @override
  String get others => 'Kuwo Kale';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Qur\'aan|Tarjumaad|Aayad, Waa in mid la shidaa';

  @override
  String get quranFontSize => 'Cabbirka Farta Qur\'aanka';

  @override
  String get quranLineHeight => 'Joogga Khadka Qur\'aanka';

  @override
  String get translationAndTafsirFontSize =>
      'Cabbirka Farta Tarjumaada & Tafsiirka';

  @override
  String get quranAyah => 'Aayadda Qur\'aanka';

  @override
  String get topToolbar => 'Bar-qalabka Sare';

  @override
  String get keepOpenWordByWord => 'Ka dhig mid furan Eray Eray';

  @override
  String get wordByWordHighlight => 'Calaamadeynta Eray Eray';

  @override
  String get quranScriptSettings => 'Dejinta Farta Qur\'aanka';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Bogga: ';

  @override
  String get quranResources => 'Kheyraadka Qur\'aanka';

  @override
  String alreadySelected(String name) {
    return 'Luqadda \'$name\' horey ayaa loo doortay.';
  }

  @override
  String get unableToGetCompassData => 'Lama heli karo xogta jiheeyaha';

  @override
  String get deviceDoesNotHaveSensors => 'Qalabku ma laha dareemayaal!';

  @override
  String get north => 'W';

  @override
  String get east => 'B';

  @override
  String get south => 'K';

  @override
  String get west => 'G';

  @override
  String get address => 'Ciwaanka: ';

  @override
  String get change => 'Beddel';

  @override
  String get calculationMethod => 'Habka Xisaabinta: ';

  @override
  String get downloadPrayerTime => 'Soo Dejiso Waqtiyada Salaadda';

  @override
  String get calculationMethodsListEmpty =>
      'Liiska hababka xisaabintu waa madhan yahay.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Lama helin hab xisaabineed oo leh xogta goobta.';

  @override
  String get prayerSettings => 'Dejinta Salaadda';

  @override
  String get reminderSettings => 'Dejinta Xusuusinta';

  @override
  String get adjustReminderTime => 'Hagaaji Waqtiga Xusuusinta';

  @override
  String get enforceAlarmSound => 'Ku qasab codka digniinta';

  @override
  String get enforceAlarmSoundDescription =>
      'Haddii la furo, muuqaalkani wuxuu ku ciyaari doonaa digniinta codka halkan lagu dejiyay, xitaa haddii codka taleefankaagu uu hooseeyo. Tani waxay hubineysaa inaadan seegin digniinta sababtoo ah codka taleefanka oo hooseeya.';

  @override
  String get volume => 'Codka';

  @override
  String get atPrayerTime => 'Waqtiga salaadda';

  @override
  String minBefore(int minutes) {
    return '$minutes daqiiqo ka hor';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes daqiiqo ka dib';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName waa $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Waa waqtigii $prayerName';
  }

  @override
  String get stopTheAdhan => 'Jooji Aadaanka';

  @override
  String dateFoundEmpty(String date) {
    return '$date oo madhan la helay';
  }

  @override
  String get today => 'Maanta';

  @override
  String get left => 'Hadhay';

  @override
  String reminderAdded(String prayerName) {
    return 'Xusuusin $prayerName waa lagu daray';
  }

  @override
  String get allowNotificationPermission =>
      'Fadlan oggolow oggolaanshaha ogeysiiska si aad u isticmaasho muuqaalkan';

  @override
  String reminderRemoved(String prayerName) {
    return 'Xusuusintii $prayerName waa la saaray';
  }

  @override
  String get getPrayerTimesAndQibla => 'Hel Waqtiyada Salaadda iyo Qiblada';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Xisaabi Waqtiyada Salaadda iyo Qiblada Goob kasta.';

  @override
  String get getFromGPS => 'Ka hel GPS';

  @override
  String get or => 'Ama';

  @override
  String get selectYourCity => 'Dooro Magaaladaada';

  @override
  String get noteAboutGPS =>
      'Ogeysiis: Haddii aadan rabin inaad isticmaasho GPS ama aadan dareemayn ammaan, waxaad dooran kartaa magaaladaada.';

  @override
  String get downloadingLocationResources => 'Soo dejinta agabka goobta...';

  @override
  String get somethingWentWrong => 'Khalad baa dhacay';

  @override
  String get selectYourCountry => 'Dooro Dalkaaga';

  @override
  String get searchForACountry => 'Raadi dal';

  @override
  String get selectYourAdministrator => 'Dooro Maamulkaaga';

  @override
  String get searchForAnAdministrator => 'Raadi maamul';

  @override
  String get searchForACity => 'Raadi magaalo';

  @override
  String get pleaseEnableLocationService => 'Fadlan daar adeegga goobta';

  @override
  String get donateUs => 'Nagu Deeq';

  @override
  String get underDevelopment => 'Waa la horumarinayaa';

  @override
  String get versionLoading => 'Wuu soo rarmayaa...';

  @override
  String get alQuran => 'Al-Qur\'aan';

  @override
  String get mainMenu => 'Liiska Guud';

  @override
  String get notes => 'Qoraalo';

  @override
  String get pinned => 'Ku dhegan';

  @override
  String get jumpToAyah => 'U bood Aayad';

  @override
  String get shareMultipleAyah => 'La wadaag Aayado badan';

  @override
  String get shareThisApp => 'La wadaag Appkan';

  @override
  String get giveRating => 'Qiimee';

  @override
  String get bugReport => 'Warbixinta Ciladaha';

  @override
  String get privacyPolicy => 'Sharciga Asturnaanta';

  @override
  String get aboutTheApp => 'Ku saabsan Appka';

  @override
  String get resetTheApp => 'Dib u Deji Appka';

  @override
  String get resetAppWarningTitle => 'Dib u Deji Xogta Appka';

  @override
  String get resetAppWarningMessage =>
      'Ma hubtaa inaad rabto inaad dib u dejiso appka? Dhammaan xogtaada way lumi doontaa, waxaadna u baahan doontaa inaad appka ka soo bilowdo bilowga.';

  @override
  String get cancel => 'Ka noqo';

  @override
  String get reset => 'Dib u Deji';

  @override
  String get shareAppSubject => 'Fiiri Appkan Al-Qur\'aanka!';

  @override
  String shareAppBody(String appLink) {
    return 'Asalaamu Caleykum! Fiiri appkan Al-Qur\'aanka ee akhriska iyo fikirka maalinlaha ah. Wuxuu kaa caawinayaa inaad ku xirnaato ereyada Alle. Ka soo degso halkan: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Fur Liiska';

  @override
  String get quran => 'Qur\'aan';

  @override
  String get prayer => 'Salaad';

  @override
  String get qibla => 'Qiblo';

  @override
  String get audio => 'Cod';

  @override
  String get surah => 'Suurad';

  @override
  String get pages => 'Boggag';

  @override
  String get note => 'Ogeysiis:';

  @override
  String get linkedAyahs => 'Aayado la xidhiidha:';

  @override
  String get emptyNoteCollection =>
      'Ururinta qoraalkani waa madhan tahay.\nKu dar qoraalo si aad halkan ugu aragto.';

  @override
  String get emptyPinnedCollection =>
      'Ma jiraan Aayado lagu dhejiyay ururintan.\nKu dheji Aayado si aad halkan ugu aragto.';

  @override
  String get noContentAvailable => 'Wax nuxur ah lama hayo.';

  @override
  String failedToLoadCollections(String error) {
    return 'Lama soo rari karin ururinta: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Ku raadi Magaca $collectionType...';
  }

  @override
  String get sortBy => 'Ku kala sooc';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Wali lama darin $collectionType';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count waxyaabood oo ku dhegan';
  }

  @override
  String notesCount(int count) {
    return '$count qoraal';
  }

  @override
  String get emptyNameNotAllowed => 'Magac madhan lama oggola';

  @override
  String updatedTo(String collectionName) {
    return 'Loo cusbooneysiiyey $collectionName';
  }

  @override
  String get changeName => 'Beddel Magaca';

  @override
  String get changeColor => 'Beddel Midabka';

  @override
  String get colorUpdated => 'Midabkii waa la cusbooneysiiyay';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName waa la tirtiray';
  }

  @override
  String get delete => 'Tirtir';

  @override
  String get save => 'Keydi';

  @override
  String get collectionNameCannotBeEmpty =>
      'Magaca ururintu ma noqon karo mid madhan.';

  @override
  String get addedNewCollection => 'Ururin Cusub ayaa lagu daray';

  @override
  String ayahCount(int count) {
    return '$count Aayad';
  }

  @override
  String get byNameAtoZ => 'Magac A-Z';

  @override
  String get byNameZtoA => 'Magac Z-A';

  @override
  String get byElementNumberAscending => 'Tirada Qaybta oo Koraysa';

  @override
  String get byElementNumberDescending => 'Tirada Qaybta oo Hoosaysa';

  @override
  String get byUpdateDateAscending => 'Taariikhda Cusboonaysiinta oo Koraysa';

  @override
  String get byUpdateDateDescending => 'Taariikhda Cusboonaysiinta oo Hoosaysa';

  @override
  String get byCreateDateAscending => 'Taariikhda Abuurista oo Koraysa';

  @override
  String get byCreateDateDescending => 'Taariikhda Abuurista oo Hoosaysa';

  @override
  String get translationNotFound => 'Tarjumaad lama helin';

  @override
  String get translationTitle => 'Tarjumaad:';

  @override
  String get footNoteTitle => 'Xigasho hoose:';

  @override
  String get wordByWordTranslation => 'Tarjumaad Eray Eray ah:';

  @override
  String get tafsirButton => 'Tafsiir';

  @override
  String get shareButton => 'La wadaag';

  @override
  String get addNoteButton => 'Ku dar Qoraal';

  @override
  String get pinToCollectionButton => 'Ku dheji Ururinta';

  @override
  String get shareAsText => 'Ula wadaag Qoraal ahaan';

  @override
  String get copiedWithTafsir => 'Waa la koobiyeeyay Tafsiirka';

  @override
  String get shareAsImage => 'Ula wadaag Sawir ahaan';

  @override
  String get shareWithTafsir => 'La wadaag Tafsiirka';

  @override
  String get notFound => 'Lama helin';

  @override
  String get noteContentCannotBeEmpty =>
      'Qoraalka nuxurkiisu ma noqon karo mid madhan.';

  @override
  String get noteSavedSuccessfully => 'Qoraalka si guul leh ayaa loo keydiyay!';

  @override
  String get selectCollections => 'Dooro Ururino';

  @override
  String get addNote => 'Ku dar Qoraal';

  @override
  String get writeCollectionName => 'Qor magaca ururinta...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Wali ma jiraan ururino. Ku dar mid cusub!';

  @override
  String get pleaseWriteYourNoteFirst => 'Fadlan marka hore qor qoraalkaaga.';

  @override
  String get noCollectionSelected => 'Ururin lama dooran';

  @override
  String get saveNote => 'Keydi Qoraalka';

  @override
  String get nextSelectCollections => 'Xiga: Dooro Ururino';

  @override
  String get addToPinned => 'Ku dar kuwa ku dhegan';

  @override
  String get pinnedSavedSuccessfully => 'Si guul leh ayaa loo keydiyay!';

  @override
  String get savePinned => 'Keydi kuwa ku dhegan';

  @override
  String get closeAudioController => 'Xidh kontoroolka codka';

  @override
  String get previous => 'Hore';

  @override
  String get rewind => 'Dib u celi';

  @override
  String get fastForward => 'Hore u soco';

  @override
  String get playNextAyah => 'Daar Aayada Xigta';

  @override
  String get repeat => 'Ku celi';

  @override
  String get playAsPlaylist => 'U daar sidii liis';

  @override
  String style(String style) {
    return 'Qaab: $style';
  }

  @override
  String get stopAndClose => 'Jooji & Xidh';

  @override
  String get play => 'Daar';

  @override
  String get pause => 'Hakad';

  @override
  String get selectReciter => 'Dooro Qaari\'';

  @override
  String source(String source) {
    return 'Isha: $source';
  }

  @override
  String get newText => 'Cusub';

  @override
  String get more => 'Dheeraad: ';

  @override
  String get cacheNotFound => 'Cache lama helin';

  @override
  String get cacheSize => 'Cabbirka Cache';

  @override
  String error(String error) {
    return 'Cillad: $error';
  }

  @override
  String get clean => 'Nadiifi';

  @override
  String get lastModified => 'Goortii ugu dambaysay ee la bedelay';

  @override
  String get oneYearAgo => '1 Sano ka hor';

  @override
  String monthsAgo(String number) {
    return '$number Bilood ka hor';
  }

  @override
  String weeksAgo(String number) {
    return '$number Todobaad ka hor';
  }

  @override
  String daysAgo(String number) {
    return '$number Maalmood ka hor';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Saacadood ka hor';
  }

  @override
  String get aboutAlQuran => 'Ku saabsan Al-Qur\'aan';

  @override
  String get appFullName => 'Al-Qur\'aan (Tafsiir, Salaad, Qiblo, Cod)';

  @override
  String get appDescription =>
      'App Islaami ah oo dhameystiran oo loogu talagalay Android, iOS, MacOS, Web, Linux iyo Windows, oo bixiya akhrinta Qur\'aanka oo leh Tafsiir & tarjumaado badan (oo ay ku jiraan eray-eray), waqtiyada salaadaha adduunka oo dhan oo leh ogeysiisyo, jiheeyaha Qiblada, iyo akhrinta codka ee eray-eray ah oo isku dubaridan.';

  @override
  String get dataSourcesNote =>
      'Ogeysiis: Qoraallada Qur\'aanka, Tafsiirka, tarjumaadaha, iyo kheyraadka codka waxaa laga soo xigtay Quran.com, Everyayah.com, iyo ilo kale oo furan oo la xaqiijiyay.';

  @override
  String get adFreePromise =>
      'Appkan waxaa loo dhisay in lagu raadiyo raalli ahaanshaha Alle. Sidaa darteed, waa oo waligiis wuxuu ahaan doonaa mid gebi ahaanba bilaa Xayeysiis ah.';

  @override
  String get coreFeatures => 'Astaamaha Muhiimka ah';

  @override
  String get coreFeaturesDescription =>
      'Baro shaqooyinka muhiimka ah ee ka dhigaya Al-Qur\'aan v3 qalab lama huraan u ah cibaadadaada maalinlaha ah ee Islaamka:';

  @override
  String get prayerTimesTitle => 'Waqtiyada Salaadda & Digniinaha';

  @override
  String get prayerTimesDescription =>
      'Waqtiyada salaadda oo sax ah meel kasta oo adduunka ah iyadoo la isticmaalayo habab kala duwan oo xisaabineed. Deji xusuusino leh ogeysiisyada Aadaanka.';

  @override
  String get qiblaDirectionTitle => 'Jiheynta Qiblada';

  @override
  String get qiblaDirectionDescription =>
      'Si fudud u hel jiheynta Qiblada adoo isticmaalaya jiheeye cad oo sax ah.';

  @override
  String get translationTafsirTitle => 'Tarjumaadda & Tafsiirka Qur\'aanka';

  @override
  String get translationTafsirDescription =>
      'Hel 120+ buugaag tarjumaad ah (oo ay ku jiraan eray-eray) oo ku qoran 69 luqadood, iyo 30+ buugaag Tafsiir ah.';

  @override
  String get wordByWordAudioTitle => 'Codka & Calaamadeynta Eray Eray';

  @override
  String get wordByWordAudioDescription =>
      'Lasoco akhrinta codka ee eray-eray ah ee isku dubaridan iyo calaamadeynta si aad u hesho khibrad waxbarasho oo qoto dheer.';

  @override
  String get ayahAudioRecitationTitle => 'Akhrinta Codka Aayadda';

  @override
  String get ayahAudioRecitationDescription =>
      'Dhageyso akhrinta Aayadaha oo dhameystiran oo ka socota in ka badan 40+ Qaari\' oo caan ah.';

  @override
  String get notesCloudBackupTitle => 'Qoraalo leh Keydka Daruuraha';

  @override
  String get notesCloudBackupDescription =>
      'Keydi qoraalada shaqsiga ah iyo fikirka, si ammaan ah loogu keydiyay daruuraha (muuqaal la horumarinayo/goor dhow soo socda).';

  @override
  String get crossPlatformSupportTitle => 'Taageerada Aaladaha Badan';

  @override
  String get crossPlatformSupportDescription =>
      'Waxaa lagu taageeray Android, Web, Linux, iyo Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Daarista Codka ee Gadaal';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Sii wad dhageysiga akhrinta Qur\'aanka xitaa marka appku uu gadaal ka shaqeynayo.';

  @override
  String get audioDataCachingTitle => 'Kaydinta Codka & Xogta';

  @override
  String get audioDataCachingDescription =>
      'Daaris la hagaajiyay iyo awoodaha offline-ka ah oo leh kaydinta codka iyo xogta Qur\'aanka oo adag.';

  @override
  String get minimalisticInterfaceTitle => 'Waji Fudud & Nadiif ah';

  @override
  String get minimalisticInterfaceDescription =>
      'Waji fudud oo la dhex maro oo diiradda saaraya khibradda isticmaalaha iyo akhriska.';

  @override
  String get optimizedPerformanceTitle => 'Waxqabad & Cabbir la Hagaajiyay';

  @override
  String get optimizedPerformanceDescription =>
      'App leh astaamo badan oo loogu talagalay inuu noqdo mid fudud oo waxqabad leh.';

  @override
  String get languageSupport => 'Taageerada Luqadda';

  @override
  String get languageSupportDescription =>
      'Appkan waxaa loogu talagalay inuu u adeego dhagaystayaal caalami ah iyadoo lagu taageerayo luqadaha soo socda (kuwo kalena si joogto ah ayaa loogu darayaa):';

  @override
  String get technologyAndResources => 'Tiknoolajiyadda & Kheyraadka';

  @override
  String get technologyAndResourcesDescription =>
      'Appkan waxaa lagu dhisay iyadoo la isticmaalayo tiknoolajiyad casri ah iyo kheyraad la isku halleyn karo:';

  @override
  String get flutterFrameworkTitle => 'Qaab-dhismeedka Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Lagu dhisay Flutter si loo helo khibrad qurux badan, oo asal ahaan la isku dubariday, oo aalado badan ah oo ka timid hal koodh.';

  @override
  String get advancedAudioEngineTitle => 'Matoorka Codka ee Horumarsan';

  @override
  String get advancedAudioEngineDescription =>
      'Waxaa ku shaqeeya baakidhyada Flutter `just_audio` iyo `just_audio_background` si loo helo daaris iyo kontorool cod oo adag.';

  @override
  String get reliableQuranDataTitle =>
      'Xogta Qur\'aanka oo lagu kalsoonaan karo';

  @override
  String get reliableQuranDataDescription =>
      'Qoraallada Al-Qur\'aanka, tarjumaadaha, tafsiirada, iyo codadka waxaa laga soo xigtay API-yo furan oo la xaqiijiyay iyo keydad xogeed sida Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Matoorka Waqtiga Salaadda';

  @override
  String get prayerTimeEngineDescription =>
      'Wuxuu adeegsadaa hababka xisaabinta ee la aasaasay si loo helo waqtiyo salaadeed oo sax ah. Ogeysiisyada waxaa maamula `flutter_local_notifications` iyo hawlaha gadaal ka shaqeeya.';

  @override
  String get crossPlatformSupport => 'Taageerada Aaladaha Badan';

  @override
  String get crossPlatformSupportDescription2 =>
      'Ku raaxayso gelitaan aan kala go\' lahayn oo ku baahsan aalado kala duwan:';

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
  String get ourLifetimePromise => 'Balanqaadkeena Nolosha';

  @override
  String get lifetimePromiseDescription =>
      'Anigoo shakhsi ah waxaan ballan qaadayaa inaan si joogto ah u bixin doono taageero iyo dayactir appkan inta aan noolahay, In Sha Allah. Hadafkaygu waa inaan hubiyo in appkani uu ahaanayo mid faa\'iido u leh ummadda sanadaha soo socda.';

  @override
  String get fajr => 'Fajar';

  @override
  String get sunrise => 'Qorrax soo bax';

  @override
  String get dhuhr => 'Duhur';

  @override
  String get asr => 'Casar';

  @override
  String get maghrib => 'Maqrib';

  @override
  String get isha => 'Cishe';

  @override
  String get midnight => 'Saqda dhexe';

  @override
  String get alarm => 'Digniin';

  @override
  String get notification => 'Ogeysiis';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajwiid';

  @override
  String get quranScriptUthmani => 'Cusmaani';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Aayadda Sajdada';

  @override
  String get required => 'Waajib';

  @override
  String get optional => 'Ikhtiyaari';

  @override
  String get notificationScheduleWarning =>
      'Ogeysiis: Ogeysiiska Jadwalka ah ama Xusuusinta waa la tabi karaa sababtoo ah xaddidaadaha habka asalka ee OS-ka taleefankaaga. Tusaale ahaan: Vivo\'s Origin OS, Samsung\'s One UI, Oppo\'s ColorOS iwm mararka qaarkood waxay dilaan Ogeysiiska Jadwalka ah ama Xusuusinta. Fadlan hubi dejinta OS-kaaga si aad app-ka uga dhigto mid aan laga xaddidin habka asalka.';

  @override
  String get scrollWithRecitation => 'Ku rogrogasho akhris';

  @override
  String get quickAccess => 'Helitaan Degdeg ah';

  @override
  String get initiallyScrollAyah => 'Marka hore u gudub aayadda';

  @override
  String get tajweedGuide => 'Hagaha Tajweedka';
}
