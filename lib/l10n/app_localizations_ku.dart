// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kurdish (`ku`).
class AppLocalizationsKu extends AppLocalizations {
  AppLocalizationsKu([String locale = 'ku']) : super(locale);

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
    return 'Tefsîr ji bo $ayahKey tune ye';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tefsîr li vir tê dîtin: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Biçe ser $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Cuz';

  @override
  String get page => 'Rûpel';

  @override
  String get ruku => 'Ruku\'';

  @override
  String get languageSettings => 'Mîhengên Ziman';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayet';
  }

  @override
  String get saveAndDownload => 'Tomar bike û Daxîne';

  @override
  String get appLanguage => 'Zimanê Sepanê';

  @override
  String get selectAppLanguage => 'Zimanê sepanê hilbijêre...';

  @override
  String get pleaseSelectOne => 'Ji kerema xwe yekê hilbijêre';

  @override
  String get quranTranslationLanguage => 'Zimanê Wergera Quranê';

  @override
  String get selectTranslationLanguage => 'Zimanê wergerê hilbijêre...';

  @override
  String get quranTranslationBook => 'Pirtûka Wergera Quranê';

  @override
  String get selectTranslationBook => 'Pirtûka wergerê hilbijêre...';

  @override
  String get quranTafsirLanguage => 'Zimanê Tefsîra Quranê';

  @override
  String get selectTafsirLanguage => 'Zimanê tefsîrê hilbijêre...';

  @override
  String get quranTafsirBook => 'Pirtûka Tefsîra Quranê';

  @override
  String get selectTafsirBook => 'Pirtûka tefsîrê hilbijêre...';

  @override
  String get quranScriptAndStyle => 'Nivîs û Şêwaza Quranê';

  @override
  String get justAMoment => 'Bîskekê...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Serkeftin';

  @override
  String get retry => 'Dîsa Biceribîne';

  @override
  String get unableToDownloadResources =>
      'Çavkanî nehatin daxistin...\nTiştek xelet çû';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Xwendina Quranê ya Beşkirî tê daxistin';

  @override
  String get processingSegmentedQuranRecitation =>
      'Xwendina Quranê ya Beşkirî tê amadekirin';

  @override
  String get footnote => 'Jêrenot';

  @override
  String get tafsir => 'Tefsîr';

  @override
  String get wordByWord => 'Peyv bi Peyv';

  @override
  String get pleaseSelectRequiredOption =>
      'Ji kerema xwe vebijarka pêwîst hilbijêre';

  @override
  String get rememberHomeTab => 'Tabê Malê bi bîr bîne';

  @override
  String get rememberHomeTabSubtitle =>
      'Sepan dê tabela dawî ya ku di ekrana malê de hatî vekirin bi bîr bîne.';

  @override
  String get wakeLock => 'Dîmenderê Vekirî Bihêle';

  @override
  String get wakeLockSubtitle => 'Pêşî li girtina otomatîkî ya ekranê digire.';

  @override
  String get settings => 'Mîheng';

  @override
  String get appTheme => 'Mijara Sepanê';

  @override
  String get quranStyle => 'Şêwaza Quranê';

  @override
  String get changeTheme => 'Mijarê Biguherîne';

  @override
  String get verseCount => 'Hejmara Ayetan: ';

  @override
  String get translation => 'Werger';

  @override
  String get tafsirNotFound => 'Nehat Dîtin';

  @override
  String get moreInfo => 'zêdetir agahî';

  @override
  String get playAudio => 'Deng Lêde';

  @override
  String get preview => 'Pêşdîtin';

  @override
  String get loading => 'Bardibe...';

  @override
  String get errorFetchingAddress => 'Di wergirtina navnîşanê de çewtî';

  @override
  String get addressNotAvailable => 'Navnîşan peyda nabe';

  @override
  String get latitude => 'Hêlîpan: ';

  @override
  String get longitude => 'Hêlîlar: ';

  @override
  String get name => 'Nav: ';

  @override
  String get location => 'Cih: ';

  @override
  String get parameters => 'Parametre: ';

  @override
  String get selectCalculationMethod => 'Rêbaza Hesabkirinê Hilbijêre';

  @override
  String get shareSelectAyahs => 'Ayetên Hilbijartî Parve Bike';

  @override
  String get selectionEmpty => 'Hilbijartin Vala ye';

  @override
  String get generatingImagePleaseWait =>
      'Wêne tê çêkirin... Ji kerema xwe bisekinin';

  @override
  String get asImage => 'Wek Wêne';

  @override
  String get asText => 'Wek Nivîs';

  @override
  String get playFromSelectedAyah => 'Ji Ayeta Hilbijartî Lêde';

  @override
  String get toTafsir => 'Bo Tefsîrê';

  @override
  String get selectAyah => 'Ayetê Hilbijêre';

  @override
  String get toAyah => 'Bo Ayetê';

  @override
  String get searchForASurah => 'Li sûreyekê bigere';

  @override
  String get bugReportTitle => 'Rapora Çewtiyê';

  @override
  String get audioCached => 'Deng Hat Cachekirin';

  @override
  String get others => 'Yên Din';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Quran|Werger|Ayet, Divê Yek Bê Çalakirin';

  @override
  String get quranFontSize => 'Mezinahiya Tîpên Quranê';

  @override
  String get quranLineHeight => 'Bilindahiya Rêza Quranê';

  @override
  String get translationAndTafsirFontSize =>
      'Mezinahiya Tîpên Werger & Tefsîrê';

  @override
  String get quranAyah => 'Ayeta Quranê';

  @override
  String get topToolbar => 'Darika Amûran ya Jor';

  @override
  String get keepOpenWordByWord => 'Peyv bi Peyv Vekirî Bihêle';

  @override
  String get wordByWordHighlight => 'Nîşankirina Peyv bi Peyv';

  @override
  String get quranScriptSettings => 'Mîhengên Nivîsa Quranê';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Rûpel: ';

  @override
  String get quranResources => 'Çavkaniyên Quranê';

  @override
  String alreadySelected(String name) {
    return 'Zimanê \'$name\' jixwe hatiye hilbijartin.';
  }

  @override
  String get unableToGetCompassData => 'Daneyên pusulayê nehatin wergirtin';

  @override
  String get deviceDoesNotHaveSensors => 'Di cîhazê de sensor tune ne!';

  @override
  String get north => 'B';

  @override
  String get east => 'R';

  @override
  String get south => 'J';

  @override
  String get west => 'X';

  @override
  String get address => 'Navnîşan: ';

  @override
  String get change => 'Biguherîne';

  @override
  String get calculationMethod => 'Rêbaza Hesabkirinê: ';

  @override
  String get downloadPrayerTime => 'Demên Nivêjê Daxîne';

  @override
  String get calculationMethodsListEmpty =>
      'Lîsteya rêbazên hesabkirinê vala ye.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Bi daneyên cîh re tu rêbazek hesabkirinê nehat dîtin.';

  @override
  String get prayerSettings => 'Mîhengên Nivêjê';

  @override
  String get reminderSettings => 'Mîhengên Bîranînê';

  @override
  String get adjustReminderTime => 'Dema Bîranînê Eyarl bike';

  @override
  String get enforceAlarmSound => 'Zorê li Dengê Alarmê Bike';

  @override
  String get enforceAlarmSoundDescription =>
      'Heke were çalakirin, ev taybetmendî dê alarmê di asta dengê ku li vir hatî danîn de lêde, heta ku dengê têlefona we kêm be jî. Ev piştrast dike ku hûn ji ber dengê kêm a têlefonê alarmê ji dest nedin.';

  @override
  String get volume => 'Asta Deng';

  @override
  String get atPrayerTime => 'Di dema nimêjê de';

  @override
  String minBefore(int minutes) {
    return '$minutes deqe berî';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes deqe piştî';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Dema $prayerName di $prayerTime de ye';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Wextê $prayerName ye';
  }

  @override
  String get stopTheAdhan => 'Bangê Rawestîne';

  @override
  String dateFoundEmpty(String date) {
    return '$date Vala Hat Dîtin';
  }

  @override
  String get today => 'Îro';

  @override
  String get left => 'Ma';

  @override
  String reminderAdded(String prayerName) {
    return 'Bîranîn ji bo $prayerName hate zêdekirin';
  }

  @override
  String get allowNotificationPermission =>
      'Ji kerema xwe destûrê bide agahdarkirinê da ku vê taybetmendiyê bikar bîne';

  @override
  String reminderRemoved(String prayerName) {
    return 'Bîranîn ji bo $prayerName hate rakirin';
  }

  @override
  String get getPrayerTimesAndQibla => 'Demên Nivêjê û Qibleyê Bistîne';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Demên Nivêjê û Qibleyê ji bo her cîhekî hesab bike.';

  @override
  String get getFromGPS => 'Ji GPSê bistîne';

  @override
  String get or => 'An';

  @override
  String get selectYourCity => 'Bajarê xwe hilbijêre';

  @override
  String get noteAboutGPS =>
      'Nîşe: Heke hûn naxwazin GPSê bikar bînin an hest bi ewlehiyê nakin, hûn dikarin bajarê xwe hilbijêrin.';

  @override
  String get downloadingLocationResources => 'Çavkaniyên cîhê têne daxistin...';

  @override
  String get somethingWentWrong => 'Tiştek xelet çû';

  @override
  String get selectYourCountry => 'Welatê Xwe Hilbijêre';

  @override
  String get searchForACountry => 'Li welatekî bigere';

  @override
  String get selectYourAdministrator => 'Rêveberê Xwe Hilbijêre';

  @override
  String get searchForAnAdministrator => 'Li rêveberekî bigere';

  @override
  String get searchForACity => 'Li bajarekî bigere';

  @override
  String get pleaseEnableLocationService =>
      'Ji kerema xwe servîsa cîhê çalak bike';

  @override
  String get donateUs => 'Beşdariyê Bike';

  @override
  String get underDevelopment => 'Di bin pêşxistinê de ye';

  @override
  String get versionLoading => 'Bardibe...';

  @override
  String get alQuran => 'Al Quran';

  @override
  String get mainMenu => 'Menuya Sereke';

  @override
  String get notes => 'Nîşe';

  @override
  String get pinned => 'Nîşankirî';

  @override
  String get jumpToAyah => 'Biçe ser Ayetê';

  @override
  String get shareMultipleAyah => 'Gelek Ayetan Parve Bike';

  @override
  String get shareThisApp => 'Vê Sepanê Parve Bike';

  @override
  String get giveRating => 'Binirxîne';

  @override
  String get bugReport => 'Rapora Çewtiyê';

  @override
  String get privacyPolicy => 'Polîtîkaya Nepenîtiyê';

  @override
  String get aboutTheApp => 'Derbarê Sepanê de';

  @override
  String get resetTheApp => 'Sepanê Vesaz Bike';

  @override
  String get resetAppWarningTitle => 'Daneyên Sepanê Vesaz Bike';

  @override
  String get resetAppWarningMessage =>
      'Ma tu bawer î ku dixwazî sepanê vesaz bikî? Hemî daneyên te dê winda bibin, û divê tu sepanê ji nû ve saz bikî.';

  @override
  String get cancel => 'Betal bike';

  @override
  String get reset => 'Vesaz bike';

  @override
  String get shareAppSubject => 'Vê Sepana Al Quran binirxîne!';

  @override
  String shareAppBody(String appLink) {
    return 'Esselamu aleykum! Vê sepana Al Quran ji bo xwendin û ramana rojane biceribîne. Ew dibe alîkar ku meriv bi gotinên Allah re têkildar be. Li vir dakêşin: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Pêşekê Veke';

  @override
  String get quran => 'Quran';

  @override
  String get prayer => 'Nivêj';

  @override
  String get qibla => 'Qible';

  @override
  String get audio => 'Deng';

  @override
  String get surah => 'Sûre';

  @override
  String get pages => 'Rûpel';

  @override
  String get note => 'Nîşe:';

  @override
  String get linkedAyahs => 'Ayetên Girêdayî:';

  @override
  String get emptyNoteCollection =>
      'Ev berhevoka nîşeyan vala ye.\nJi bo dîtina wan li vir çend nîşeyan lê zêde bike.';

  @override
  String get emptyPinnedCollection =>
      'Hêj ti ayet li vê berhevokê nehatine nîşankirin.\nJi bo dîtina wan li vir ayetan nîşan bike.';

  @override
  String get noContentAvailable => 'Naverok tune.';

  @override
  String failedToLoadCollections(String error) {
    return 'Barkirina berhevokan bi ser neket: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Li gorî Navê $collectionType Bigere...';
  }

  @override
  String get sortBy => 'Li gorî rêz bike';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Hêj ti $collectionType nehatiye zêdekirin';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count hêmanên nîşankirî';
  }

  @override
  String notesCount(int count) {
    return '$count nîşe';
  }

  @override
  String get emptyNameNotAllowed => 'Navê vala nayê qebûlkirin';

  @override
  String updatedTo(String collectionName) {
    return 'Ji bo $collectionName hate nûvekirin';
  }

  @override
  String get changeName => 'Navê Biguherîne';

  @override
  String get changeColor => 'Rengê Biguherîne';

  @override
  String get colorUpdated => 'Reng hate nûvekirin';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Hate Jêbirin';
  }

  @override
  String get delete => 'Jê bibe';

  @override
  String get save => 'Tomar bike';

  @override
  String get collectionNameCannotBeEmpty => 'Navê berhevokê nikare vala be.';

  @override
  String get addedNewCollection => 'Berhevoka Nû Hate Zêdekirin';

  @override
  String ayahCount(int count) {
    return '$count Ayet';
  }

  @override
  String get byNameAtoZ => 'Nav A-Z';

  @override
  String get byNameZtoA => 'Nav Z-A';

  @override
  String get byElementNumberAscending => 'Hejmara Hêmanan Berbijor';

  @override
  String get byElementNumberDescending => 'Hejmara Hêmanan Berbijêr';

  @override
  String get byUpdateDateAscending => 'Dîroka Nûvekirinê Berbijor';

  @override
  String get byUpdateDateDescending => 'Dîroka Nûvekirinê Berbijêr';

  @override
  String get byCreateDateAscending => 'Dîroka Çêkirinê Berbijor';

  @override
  String get byCreateDateDescending => 'Dîroka Çêkirinê Berbijêr';

  @override
  String get translationNotFound => 'Werger Nehat Dîtin';

  @override
  String get translationTitle => 'Werger:';

  @override
  String get footNoteTitle => 'Jêrenot:';

  @override
  String get wordByWordTranslation => 'Wergera Peyv bi Peyv:';

  @override
  String get tafsirButton => 'Tefsîr';

  @override
  String get shareButton => 'Parve bike';

  @override
  String get addNoteButton => 'Nîşeyê Zêde Bike';

  @override
  String get pinToCollectionButton => 'Li Berhevokê Nîşan Bike';

  @override
  String get shareAsText => 'Wek Nivîs Parve Bike';

  @override
  String get copiedWithTafsir => 'Bi Tefsîrê re hate kopî kirin';

  @override
  String get shareAsImage => 'Wek Wêne Parve Bike';

  @override
  String get shareWithTafsir => 'Bi Tefsîrê re Parve Bike';

  @override
  String get notFound => 'Nehat dîtin';

  @override
  String get noteContentCannotBeEmpty => 'Naveroka nîşeyê nikare vala be.';

  @override
  String get noteSavedSuccessfully => 'Nîşe bi serkeftî hate tomarkirin!';

  @override
  String get selectCollections => 'Berhevokan Hilbijêre';

  @override
  String get addNote => 'Nîşeyê Zêde Bike';

  @override
  String get writeCollectionName => 'Navê berhevokê binivîse...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Hêj berhevok tune ne. Yek nû lê zêde bike!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Ji kerema xwe pêşî nîşeya xwe binivîse.';

  @override
  String get noCollectionSelected => 'Tu berhevok nehat hilbijartin';

  @override
  String get saveNote => 'Nîşeyê Tomar Bike';

  @override
  String get nextSelectCollections => 'Pêşve: Berhevokan Hilbijêre';

  @override
  String get addToPinned => 'Li Nîşankiriyan Zêde Bike';

  @override
  String get pinnedSavedSuccessfully =>
      'Nîşankirî bi serkeftî hate tomarkirin!';

  @override
  String get savePinned => 'Nîşankirî Tomar Bike';

  @override
  String get closeAudioController => 'Kontrolkera Deng Bigire';

  @override
  String get previous => 'Pêşî';

  @override
  String get rewind => 'Paşve Bizivirîne';

  @override
  String get fastForward => 'Pêşve Bibe';

  @override
  String get playNextAyah => 'Ayeta Pêşîn Lêde';

  @override
  String get repeat => 'Dubare bike';

  @override
  String get playAsPlaylist => 'Wek Lîsteya Lêdanê Lêde';

  @override
  String style(String style) {
    return 'Şêwaz: $style';
  }

  @override
  String get stopAndClose => 'Rawestîne & Bigire';

  @override
  String get play => 'Lêde';

  @override
  String get pause => 'Raweste';

  @override
  String get selectReciter => 'Qari\' Hilbijêre';

  @override
  String source(String source) {
    return 'Çavkanî: $source';
  }

  @override
  String get newText => 'Nû';

  @override
  String get more => 'Zêdetir: ';

  @override
  String get cacheNotFound => 'Cache Nehat Dîtin';

  @override
  String get cacheSize => 'Mezinahiya Cacheyê';

  @override
  String error(String error) {
    return 'Çewtî: $error';
  }

  @override
  String get clean => 'Paqij bike';

  @override
  String get lastModified => 'Guhertina Dawî';

  @override
  String get oneYearAgo => '1 Sal berê';

  @override
  String monthsAgo(String number) {
    return '$number Meh berê';
  }

  @override
  String weeksAgo(String number) {
    return '$number Hefte berê';
  }

  @override
  String daysAgo(String number) {
    return '$number Roj berê';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Saet berê';
  }

  @override
  String get aboutAlQuran => 'Derbarê Al Quran de';

  @override
  String get appFullName => 'Al Quran (Tefsîr, Nivêj, Qible, Deng)';

  @override
  String get appDescription =>
      'Serîlêdanek Îslamî ya berfireh ji bo Android, iOS, MacOS, Web, Linux û Windows, ku xwendina Quranê bi Tefsîr û gelek wergeran (tevî peyv bi peyv), demên nimêjê yên cîhanî bi agahdariyan, pusulaya Qibleyê, û xwendina dengî ya peyv bi peyv a senkronîzekirî pêşkêş dike.';

  @override
  String get dataSourcesNote =>
      'Nîşe: Nivîsên Quranê, Tefsîr, werger, û çavkaniyên dengî ji Quran.com, Everyayah.com, û çavkaniyên din ên vekirî yên pejirandî têne girtin.';

  @override
  String get adFreePromise =>
      'Ev sepan ji bo razîbûna Allah hatiye çêkirin. Ji ber vê yekê, ew bi tevahî Bê Reklam e û dê her dem wisa be.';

  @override
  String get coreFeatures => 'Taybetmendiyên Sereke';

  @override
  String get coreFeaturesDescription =>
      'Taybetmendiyên sereke yên ku Al Quran v3 dikin amûrek bingehîn ji bo pratîkên we yên rojane yên Îslamî, kifş bikin:';

  @override
  String get prayerTimesTitle => 'Demên Nivêjê & Agahdarî';

  @override
  String get prayerTimesDescription =>
      'Demên nimêjê yên rast ji bo her cîhekî li seranserê cîhanê bi karanîna rêbazên hesabkirinê yên cihêreng. Bîranînan bi agahdariyên Bangê saz bikin.';

  @override
  String get qiblaDirectionTitle => 'Arasteya Qibleyê';

  @override
  String get qiblaDirectionDescription =>
      'Bi dîmenek pusulayê ya zelal û rast, arasteya Qibleyê bi hêsanî bibînin.';

  @override
  String get translationTafsirTitle => 'Werger & Tefsîra Quranê';

  @override
  String get translationTafsirDescription =>
      'Gihîştina zêdetirî 120 pirtûkên wergerê (tevî peyv bi peyv) di 69 zimanan de, û zêdetirî 30 pirtûkên Tefsîrê.';

  @override
  String get wordByWordAudioTitle => 'Deng û Nîşankirina Peyv bi Peyv';

  @override
  String get wordByWordAudioDescription =>
      'Ji bo ezmûnek fêrbûnê ya berbiçav, bi xwendina dengî ya peyv bi peyv a senkronîzekirî û nîşankirinê re bişopînin.';

  @override
  String get ayahAudioRecitationTitle => 'Xwendina Dengî ya Ayetan';

  @override
  String get ayahAudioRecitationDescription =>
      'Guhdarî xwendinên ayetên tevahî ji zêdetirî 40 qari\'yên navdar bikin.';

  @override
  String get notesCloudBackupTitle => 'Nîşe bi Piştgiriya Ewr';

  @override
  String get notesCloudBackupDescription =>
      'Nîşe û ramanên kesane tomar bikin, ku bi ewlehî li ewrê têne piştgirî kirin (taybetmendî di bin pêşkeftinê de ye/di demek nêzîk de tê).';

  @override
  String get crossPlatformSupportTitle => 'Piştgiriya Pir-Platformî';

  @override
  String get crossPlatformSupportDescription =>
      'Li ser Android, Web, Linux, û Windowsê tê piştgirî kirin.';

  @override
  String get backgroundAudioPlaybackTitle => 'Lêdana Dengî ya Paşîn';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Guhdarkirina xwendina Quranê bidomînin heta ku sepan di paşîn de be jî.';

  @override
  String get audioDataCachingTitle => 'Cachekirina Deng û Daneyan';

  @override
  String get audioDataCachingDescription =>
      'Lêdan û kapasîteyên negirêdayî yên baştir bi cachekirina daneyên deng û Quranê yên xurt.';

  @override
  String get minimalisticInterfaceTitle => 'Navrûya Minimalîst û Paqij';

  @override
  String get minimalisticInterfaceDescription =>
      'Navrûya hêsan a navîgasyonê ku balê dikişîne ser ezmûna bikarhêner û xwendinê.';

  @override
  String get optimizedPerformanceTitle =>
      'Performans û Mezinahiya Optîmîzekirî';

  @override
  String get optimizedPerformanceDescription =>
      'Serîlêdanek bi taybetmendiyên dewlemend ku ji bo sivik û performans be hatî sêwirandin.';

  @override
  String get languageSupport => 'Piştgiriya Ziman';

  @override
  String get languageSupportDescription =>
      'Ev serîlêdan ji bo temaşevanên gerdûnî bi piştgiriya zimanên jêrîn hatiye sêwirandin (û yên din bi berdewamî têne zêdekirin):';

  @override
  String get technologyAndResources => 'Teknolojî & Çavkanî';

  @override
  String get technologyAndResourcesDescription =>
      'Ev sepan bi karanîna teknolojiyên pêşkeftî û çavkaniyên pêbawer hatî çêkirin:';

  @override
  String get flutterFrameworkTitle => 'Çarçoveya Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Bi Flutter re ji bo ezmûnek pir-platformî ya bedew, bi xwecihî berhevkirî, ji yek bingehek kodê hatî çêkirin.';

  @override
  String get advancedAudioEngineTitle => 'Motora Dengî ya Pêşkeftî';

  @override
  String get advancedAudioEngineDescription =>
      'Ji hêla pakêtên Flutter `just_audio` û `just_audio_background` ve ji bo lêdan û kontrolkirina dengî ya xurt tê hêz kirin.';

  @override
  String get reliableQuranDataTitle => 'Daneyên Quranê yên Pêbawer';

  @override
  String get reliableQuranDataDescription =>
      'Nivîsên Quranê, werger, tefsîr, û deng ji API-yên vekirî yên pejirandî û databasan wekî Quran.com & Everyayah.com têne girtin.';

  @override
  String get prayerTimeEngineTitle => 'Motora Dema Nivêjê';

  @override
  String get prayerTimeEngineDescription =>
      'Ji bo demên nimêjê yên rast rêbazên hesabkirinê yên sazkirî bikar tîne. Agahdarî ji hêla `flutter_local_notifications` û karên paşîn ve têne birêvebirin.';

  @override
  String get crossPlatformSupport => 'Piştgiriya Pir-Platformî';

  @override
  String get crossPlatformSupportDescription2 =>
      'Gihîştina bêkêmasî li ser platformên cihêreng xweş bikin:';

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
  String get ourLifetimePromise => 'Soza me ya Heya-Heyî';

  @override
  String get lifetimePromiseDescription =>
      'Ez bi xwe soz didim ku ez ê di tevahiya jiyana xwe de, Înşallah, piştgirî û lênihêrîna domdar ji bo vê sepanê peyda bikim. Armanca min ew e ku ev sepan ji bo salên pêş de ji bo Ummetê wekî çavkaniyek sûdmend bimîne.';

  @override
  String get fajr => 'Fecr';

  @override
  String get sunrise => 'Rojhilatin';

  @override
  String get dhuhr => 'Nîvro';

  @override
  String get asr => 'Esr';

  @override
  String get maghrib => 'Mexrib';

  @override
  String get isha => 'Eşa';

  @override
  String get midnight => 'Nîvê Şevê';

  @override
  String get alarm => 'Alarm';

  @override
  String get notification => 'Agahdarî';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tecwîd';

  @override
  String get quranScriptUthmani => 'Usmanî';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Ayeta Secdê';

  @override
  String get required => 'Pêwîst';

  @override
  String get optional => 'Bijarî';

  @override
  String get notificationScheduleWarning =>
      'Têbînî: Dibe ku Agahdariya Plankirî an Bîranîn ji ber sînorkirinên pêvajoya paşîn a OS-ya têlefona we winda bibe. Mînak: Origin OS-a Vivo, One UI-ya Samsung, ColorOS-a Oppo û hwd carinan Agahdariya Plankîrî an Bîranînê dikujin. Ji kerema xwe mîhengên OS-ya xwe kontrol bikin da ku sepan ji pêvajoya paşîn neyê sînorkirin.';

  @override
  String get scrollWithRecitation => 'Bi xwendinê bigerin';

  @override
  String get quickAccess => 'Gihîştina Lezgîn';

  @override
  String get initiallyScrollAyah => 'Di destpêkê de biçin ayetê';

  @override
  String get tajweedGuide => 'Rêberê Tecwîdê';

  @override
  String get configuration => 'Configuration';

  @override
  String get restoreFromBackup => 'Restore From Backup';
}
