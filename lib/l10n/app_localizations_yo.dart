// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

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
    return 'Tafsir kò sí fún $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsir wà ní: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Lọ sí $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz\'';

  @override
  String get page => 'Oju-iwé';

  @override
  String get ruku => 'Ruku\'';

  @override
  String get languageSettings => 'Ètò Èdè';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayat';
  }

  @override
  String get saveAndDownload => 'Fipamọ́ àti Gba Sílẹ̀';

  @override
  String get appLanguage => 'Èdè Áàpù';

  @override
  String get selectAppLanguage => 'Yan èdè áàpù...';

  @override
  String get pleaseSelectOne => 'Jọ̀wọ́ yan ọ̀kan';

  @override
  String get quranTranslationLanguage => 'Èdè Ìtúmọ̀ Al-Qur\'an';

  @override
  String get selectTranslationLanguage => 'Yan èdè ìtúmọ̀...';

  @override
  String get quranTranslationBook => 'Ìwé Ìtúmọ̀ Al-Qur\'an';

  @override
  String get selectTranslationBook => 'Yan ìwé ìtúmọ̀...';

  @override
  String get quranTafsirLanguage => 'Èdè Tafsir Al-Qur\'an';

  @override
  String get selectTafsirLanguage => 'Yan èdè tafsir...';

  @override
  String get quranTafsirBook => 'Ìwé Tafsir Al-Qur\'an';

  @override
  String get selectTafsirBook => 'Yan ìwé tafsir...';

  @override
  String get quranScriptAndStyle => 'Àkọsílẹ̀ & Àṣà Al-Qur\'an';

  @override
  String get justAMoment => 'Fún ìṣẹ́jú kan...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Àṣeyọrí';

  @override
  String get retry => 'Gbìyànjú Lẹ́ẹ̀kansí';

  @override
  String get unableToDownloadResources =>
      'Kò ṣeéṣe láti gba àwọn orísun sílẹ̀...\nNǹkan kan kò lọ déédéé';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Gbigba Kewu Al-Qur\'an tó pín sí abala sílẹ̀';

  @override
  String get processingSegmentedQuranRecitation =>
      'Ṣíṣe Àgbékalẹ̀ Kewu Al-Qur\'an tó pín sí abala';

  @override
  String get footnote => 'Àlàyé ìsàlẹ̀-ìwé';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Ọ̀rọ̀ nìkọ̀ọ̀kan';

  @override
  String get pleaseSelectRequiredOption => 'Jọ̀wọ́ yan àṣàyàn tó pọn dandan';

  @override
  String get rememberHomeTab => 'Rántí Tààbù Àkọ́kọ́';

  @override
  String get rememberHomeTabSubtitle =>
      'Áàpù yóò rántí tààbù ìgbẹ̀yìn tí a ṣí ní ojú-ewé àkọ́kọ́.';

  @override
  String get wakeLock => 'Mú Ojú Fóònù Dúró';

  @override
  String get wakeLockSubtitle => 'Dènà ojú fóònù láti má pa fúnra rẹ̀.';

  @override
  String get settings => 'Ètò';

  @override
  String get appTheme => 'Tíìmù Áàpù';

  @override
  String get quranStyle => 'Àṣà Al-Qur\'an';

  @override
  String get changeTheme => 'Yí Tíìmù padà';

  @override
  String get verseCount => 'Iye Ayat: ';

  @override
  String get translation => 'Ìtúmọ̀';

  @override
  String get tafsirNotFound => 'A kò rí i';

  @override
  String get moreInfo => 'àlàyé síwájú sí i';

  @override
  String get playAudio => 'Tan Ohùn';

  @override
  String get preview => 'Àkọ́kọ́-wò';

  @override
  String get loading => 'Ó ń gbé jáde...';

  @override
  String get errorFetchingAddress => 'Àṣìṣe nígbà tí a ń gba àdírẹ́sì';

  @override
  String get addressNotAvailable => 'Àdírẹ́sì kò sí';

  @override
  String get latitude => 'Látítúùdù: ';

  @override
  String get longitude => 'Lọ́ńgítúùdù: ';

  @override
  String get name => 'Orúkọ: ';

  @override
  String get location => 'Ibi tí ó wà: ';

  @override
  String get parameters => 'Àwọn Pàrámítà: ';

  @override
  String get selectCalculationMethod => 'Yan Ọ̀nà Ìṣírò';

  @override
  String get shareSelectAyahs => 'Pín Àwọn Ayat Tí A Yàn';

  @override
  String get selectionEmpty => 'Àṣàyàn Òfo';

  @override
  String get generatingImagePleaseWait => 'Ó ń ṣẹ̀dá àwòrán... Jọ̀wọ́ dúró';

  @override
  String get asImage => 'Gẹ́gẹ́ bí Àwòrán';

  @override
  String get asText => 'Gẹ́gẹ́ bí Ọ̀rọ̀';

  @override
  String get playFromSelectedAyah => 'Bẹ̀rẹ̀ síí tan láti Ayat tí a yàn';

  @override
  String get toTafsir => 'Sí Tafsir';

  @override
  String get selectAyah => 'Yan Ayat';

  @override
  String get toAyah => 'Sí Ayat';

  @override
  String get searchForASurah => 'Wá Surah kan';

  @override
  String get bugReportTitle => 'Ìròyìn Àléébù';

  @override
  String get audioCached => 'Ohùn ti wà nínú Cache';

  @override
  String get others => 'Àwọn Mìíràn';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Al-Qur\'an|Ìtúmọ̀|Ayat, A gbọ́dọ̀ tan ọ̀kan';

  @override
  String get quranFontSize => 'Ìwọ̀n Lẹ́tà Al-Qur\'an';

  @override
  String get quranLineHeight => 'Gíga Láinì Al-Qur\'an';

  @override
  String get translationAndTafsirFontSize => 'Ìwọ̀n Lẹ́tà Ìtúmọ̀ & Tafsir';

  @override
  String get quranAyah => 'Ayat Al-Qur\'an';

  @override
  String get topToolbar => 'Pẹpẹ irinṣẹ́ òkè';

  @override
  String get keepOpenWordByWord => 'Jẹ́ kí Ọ̀rọ̀ nìkọ̀ọ̀kan wà ní ṣíṣí';

  @override
  String get wordByWordHighlight => 'Àmì sí Ọ̀rọ̀ nìkọ̀ọ̀kan';

  @override
  String get quranScriptSettings => 'Ètò Àkọsílẹ̀ Al-Qur\'an';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Oju-iwé: ';

  @override
  String get quranResources => 'Àwọn Orísun Al-Qur\'an';

  @override
  String alreadySelected(String name) {
    return 'A ti yan èdè \'$name\' tẹ́lẹ̀.';
  }

  @override
  String get unableToGetCompassData => 'Kò ṣeéṣe láti gba dátà kọ́mpáàsì';

  @override
  String get deviceDoesNotHaveSensors => 'Ẹ̀rọ yìí kò ní àwọn pálí !';

  @override
  String get north => 'À';

  @override
  String get east => 'I';

  @override
  String get south => 'G';

  @override
  String get west => 'W';

  @override
  String get address => 'Àdírẹ́sì: ';

  @override
  String get change => 'Yí padà';

  @override
  String get calculationMethod => 'Ọ̀nà Ìṣírò: ';

  @override
  String get downloadPrayerTime => 'Gba Àkókò Kirun sílẹ̀';

  @override
  String get calculationMethodsListEmpty => 'Àkójọ àwọn ọ̀nà ìṣírò jẹ́ òfo.';

  @override
  String get noCalculationMethodWithLocationData =>
      'A kò rí ọ̀nà ìṣírò kankan pẹ̀lú dátà ibi tí ó wà.';

  @override
  String get prayerSettings => 'Ètò Kirun';

  @override
  String get reminderSettings => 'Ètò Ìránnilétí';

  @override
  String get adjustReminderTime => 'Ṣe àtúnṣe Àkókò Ìránnilétí';

  @override
  String get enforceAlarmSound => 'Fipá mú Ohùn Itaniji';

  @override
  String get enforceAlarmSoundDescription =>
      'Tí a bá tan-án, àṣàyàn yìí yóò tan ìtaniji ní ìwọ̀n ohùn tí a ṣètò síbí, kódà bí ohùn fóònù rẹ bá lọlẹ̀. Èyí yóò jẹ́ kí o má pàdánù ìtaniji nítorí ohùn fóònù tó lọlẹ̀.';

  @override
  String get volume => 'Ìwọ̀n Ohùn';

  @override
  String get atPrayerTime => 'Ní àkókò kirun';

  @override
  String minBefore(int minutes) {
    return 'Ìṣẹ́jú $minutes ṣáájú';
  }

  @override
  String minAfter(int minutes) {
    return 'Ìṣẹ́jú $minutes lẹ́yìn';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Àkókò $prayerName jẹ́ ní $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Àkókò $prayerName ti tó';
  }

  @override
  String get stopTheAdhan => 'Dá Adhan dúró';

  @override
  String dateFoundEmpty(String date) {
    return '$date Jẹ́ Òfo';
  }

  @override
  String get today => 'Òní';

  @override
  String get left => 'Ó ku';

  @override
  String reminderAdded(String prayerName) {
    return 'A ti fi ìránnilétí kún $prayerName';
  }

  @override
  String get allowNotificationPermission =>
      'Jọ̀wọ́ gba àṣẹ ìwifúnni láti lo àṣàyàn yìí';

  @override
  String reminderRemoved(String prayerName) {
    return 'A ti yọ ìránnilétí kúrò fún $prayerName';
  }

  @override
  String get getPrayerTimesAndQibla => 'Gba Àwọn Àkókò Kirun àti Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Ṣírò Àwọn Àkókò Kirun àti Qibla fún Ibi Tí Ó Wù Kó Jẹ́.';

  @override
  String get getFromGPS => 'Gba láti GPS';

  @override
  String get or => 'Tàbí';

  @override
  String get selectYourCity => 'Yan Ìlú rẹ';

  @override
  String get noteAboutGPS =>
      'Àkíyèsí: Bí o kò bá fẹ́ lo GPS tàbí o kò ní ìgbẹ́kẹ̀lé, o lè yan ìlú rẹ.';

  @override
  String get downloadingLocationResources =>
      'Gbigba àwọn orísun ibi tí ó wà sílẹ̀...';

  @override
  String get somethingWentWrong => 'Nǹkan kan kò lọ déédéé';

  @override
  String get selectYourCountry => 'Yan Orílẹ̀-èdè Rẹ';

  @override
  String get searchForACountry => 'Wá orílẹ̀-èdè kan';

  @override
  String get selectYourAdministrator => 'Yan Alábòójútó Rẹ';

  @override
  String get searchForAnAdministrator => 'Wá alábòójútó kan';

  @override
  String get searchForACity => 'Wá ìlú kan';

  @override
  String get pleaseEnableLocationService => 'Jọ̀wọ́ tan iṣẹ́-ìṣe ipò síṣe';

  @override
  String get donateUs => 'Ṣe Ìtọrẹ fún Wa';

  @override
  String get underDevelopment => 'Ó ń bọ̀ lọ́nà';

  @override
  String get versionLoading => 'Ó ń gbé jáde...';

  @override
  String get alQuran => 'Al-Qur\'an';

  @override
  String get mainMenu => 'Mẹ́ńù Àkọ́kọ́';

  @override
  String get notes => 'Àkọsílẹ̀';

  @override
  String get pinned => 'Tí a Lẹ̀ Mọ́';

  @override
  String get jumpToAyah => 'Lọ sí Ayat';

  @override
  String get shareMultipleAyah => 'Pín Ayat Púpọ̀';

  @override
  String get shareThisApp => 'Pín Áàpù Yìí';

  @override
  String get giveRating => 'Fún ní Ìṣedára';

  @override
  String get bugReport => 'Ìròyìn Àléébù';

  @override
  String get privacyPolicy => 'Òfin Ìpamọ́';

  @override
  String get aboutTheApp => 'Nípa Áàpù';

  @override
  String get resetTheApp => 'Tún Áàpù Bẹ̀rẹ̀';

  @override
  String get resetAppWarningTitle => 'Tún Dátà Áàpù Bẹ̀rẹ̀';

  @override
  String get resetAppWarningMessage =>
      'Ṣé o dá ọ lójú pé o fẹ́ tún áàpù bẹ̀rẹ̀? Gbogbo dátà rẹ yóò sọnù, o sì ní láti tún áàpù ṣètò láti ìbẹ̀rẹ̀.';

  @override
  String get cancel => 'Fagilé';

  @override
  String get reset => 'Tún Bẹ̀rẹ̀';

  @override
  String get shareAppSubject => 'Wá wo Áàpù Al-Qur\'an yìí!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Wá wo áàpù Al-Qur\'an yìí fún kíkà àti àṣàrò ojoojúmọ́. Ó ń ràn wá lọ́wọ́ láti sopọ̀ mọ́ àwọn ọ̀rọ̀ Allah. Gba sílẹ̀ níbí: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Ṣí Drọ́wà';

  @override
  String get quran => 'Qur\'an';

  @override
  String get prayer => 'Kirun';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Ohùn';

  @override
  String get surah => 'Surah';

  @override
  String get pages => 'Àwọn Oju-iwé';

  @override
  String get note => 'Àkíyèsí:';

  @override
  String get linkedAyahs => 'Àwọn Ayat Tí A Sopọ̀:';

  @override
  String get emptyNoteCollection =>
      'Àkójọ àkọsílẹ̀ yìí jẹ́ òfo.\nFi àwọn àkọsílẹ̀ díẹ̀ kún un láti rí wọn níbí.';

  @override
  String get emptyPinnedCollection =>
      'Kò sí Ayat kankan tí a lẹ̀ mọ́ àkójọ yìí.\nLẹ̀ àwọn Ayat mọ́ ọn láti rí wọn níbí.';

  @override
  String get noContentAvailable => 'Kò sí àkóónú kankan.';

  @override
  String failedToLoadCollections(String error) {
    return 'Kò ṣeéṣe láti gbé àwọn àkójọ jáde: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Wá Pẹ̀lú Orúkọ $collectionType...';
  }

  @override
  String get sortBy => 'Tò Nípasẹ̀';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'A kò tíì fi $collectionType kankan kún un';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count ohun tí a lẹ̀ mọ́';
  }

  @override
  String notesCount(int count) {
    return '$count àkọsílẹ̀';
  }

  @override
  String get emptyNameNotAllowed => 'A kò gba orúkọ òfo';

  @override
  String updatedTo(String collectionName) {
    return 'A ti ṣe àtúnṣe sí $collectionName';
  }

  @override
  String get changeName => 'Yí Orúkọ padà';

  @override
  String get changeColor => 'Yí Àwọ̀ padà';

  @override
  String get colorUpdated => 'A ti ṣe àtúnṣe àwọ̀';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ti parẹ́';
  }

  @override
  String get delete => 'Pa rẹ́';

  @override
  String get save => 'Fipamọ́';

  @override
  String get collectionNameCannotBeEmpty => 'Orúkọ àkójọ kò gbọ́dọ̀ jẹ́ òfo.';

  @override
  String get addedNewCollection => 'A ti fi Àkójọ Tuntun kún un';

  @override
  String ayahCount(int count) {
    return '$count Ayat';
  }

  @override
  String get byNameAtoZ => 'Orúkọ A-Z';

  @override
  String get byNameZtoA => 'Orúkọ Z-A';

  @override
  String get byElementNumberAscending => 'Nọ́mbà Èlímẹ́ńtì tó ń lọ sókè';

  @override
  String get byElementNumberDescending => 'Nọ́mbà Èlímẹ́ńtì tó ń sọ̀kalẹ̀';

  @override
  String get byUpdateDateAscending => 'Ọjọ́ Àtúnṣe tó ń lọ sókè';

  @override
  String get byUpdateDateDescending => 'Ọjọ́ Àtúnṣe tó ń sọ̀kalẹ̀';

  @override
  String get byCreateDateAscending => 'Ọjọ́ Ìṣẹ̀dá tó ń lọ sókè';

  @override
  String get byCreateDateDescending => 'Ọjọ́ Ìṣẹ̀dá tó ń sọ̀kalẹ̀';

  @override
  String get translationNotFound => 'A kò rí Ìtúmọ̀';

  @override
  String get translationTitle => 'Ìtúmọ̀:';

  @override
  String get footNoteTitle => 'Àlàyé ìsàlẹ̀-ìwé:';

  @override
  String get wordByWordTranslation => 'Ìtúmọ̀ Ọ̀rọ̀ nìkọ̀ọ̀kan:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Pín';

  @override
  String get addNoteButton => 'Fi Àkọsílẹ̀ Kún un';

  @override
  String get pinToCollectionButton => 'Lẹ̀ mọ́ Àkójọ';

  @override
  String get shareAsText => 'Pín gẹ́gẹ́ bí Ọ̀rọ̀';

  @override
  String get copiedWithTafsir => 'A ti ṣàdàkọ pẹ̀lú Tafsir';

  @override
  String get shareAsImage => 'Pín gẹ́gẹ́ bí Àwòrán';

  @override
  String get shareWithTafsir => 'Pín pẹ̀lú Tafsir';

  @override
  String get notFound => 'A kò rí i';

  @override
  String get noteContentCannotBeEmpty => 'Àkóónú àkọsílẹ̀ kò gbọ́dọ̀ jẹ́ òfo.';

  @override
  String get noteSavedSuccessfully => 'A ti fi àkọsílẹ̀ pamọ́ ní àṣeyọrí!';

  @override
  String get selectCollections => 'Yan Àwọn Àkójọ';

  @override
  String get addNote => 'Fi Àkọsílẹ̀ Kún un';

  @override
  String get writeCollectionName => 'Kọ orúkọ àkójọ...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Kò sí àkójọ kankan. Fi ọ̀kan tuntun kún un!';

  @override
  String get pleaseWriteYourNoteFirst => 'Jọ̀wọ́ kọ àkọsílẹ̀ rẹ lákọ̀ọ́kọ́.';

  @override
  String get noCollectionSelected => 'A kò yan Àkójọ kankan';

  @override
  String get saveNote => 'Fi Àkọsílẹ̀ Pamọ́';

  @override
  String get nextSelectCollections => 'Tí ó tẹ̀lé: Yan Àwọn Àkójọ';

  @override
  String get addToPinned => 'Fi Kún Àwọn Tí A Lẹ̀ Mọ́';

  @override
  String get pinnedSavedSuccessfully =>
      'A ti fi àwọn tí a lẹ̀ mọ́ pamọ́ ní àṣeyọrí!';

  @override
  String get savePinned => 'Fi Àwọn Tí A Lẹ̀ Mọ́ Pamọ́';

  @override
  String get closeAudioController => 'Pa Alábòójútó Ohùn';

  @override
  String get previous => 'Tẹ́lẹ̀';

  @override
  String get rewind => 'Mú padà sẹ́yìn';

  @override
  String get fastForward => 'Mú lọ síwájú';

  @override
  String get playNextAyah => 'Tan Ayat Tí ó tẹ̀lé';

  @override
  String get repeat => 'Tún un ṣe';

  @override
  String get playAsPlaylist => 'Tan gẹ́gẹ́ bí Àkójọ Orin';

  @override
  String style(String style) {
    return 'Àṣà: $style';
  }

  @override
  String get stopAndClose => 'Dúró & Pa';

  @override
  String get play => 'Tan';

  @override
  String get pause => 'Dúró';

  @override
  String get selectReciter => 'Yan Oníkewu';

  @override
  String source(String source) {
    return 'Orísun: $source';
  }

  @override
  String get newText => 'Tuntun';

  @override
  String get more => 'Síwájú sí i: ';

  @override
  String get cacheNotFound => 'A kò rí Cache';

  @override
  String get cacheSize => 'Ìwọ̀n Cache';

  @override
  String error(String error) {
    return 'Àṣìṣe: $error';
  }

  @override
  String get clean => 'Nù mọ́';

  @override
  String get lastModified => 'Àtúnṣe Ìgbẹ̀yìn';

  @override
  String get oneYearAgo => 'Ọdún 1 sẹ́yìn';

  @override
  String monthsAgo(String number) {
    return 'Oṣù $number sẹ́yìn';
  }

  @override
  String weeksAgo(String number) {
    return 'Ọ̀sẹ̀ $number sẹ́yìn';
  }

  @override
  String daysAgo(String number) {
    return 'Ọjọ́ $number sẹ́yìn';
  }

  @override
  String hoursAgo(Object hour) {
    return 'Wákàtí $hour sẹ́yìn';
  }

  @override
  String get aboutAlQuran => 'Nípa Al-Qur\'an';

  @override
  String get appFullName => 'Al-Qur\'an (Tafsir, Kirun, Qibla, Ohùn)';

  @override
  String get appDescription =>
      'Áàpù Islam kan tí ó pé pérépéré fún Android, iOS, MacOS, Web, Linux àti Windows, tí ó ń pèsè kíkà Al-Qur\'an pẹ̀lú Tafsir & àwọn ìtúmọ̀ púpọ̀ (pẹ̀lú ọ̀rọ̀ nìkọ̀ọ̀kan), àwọn àkókò kirun káríayé pẹ̀lú ìwifúnni, kọ́mpáàsì Qibla, àti kewu ọ̀rọ̀ nìkọ̀ọ̀kan tí a ṣíṣẹpọ̀.';

  @override
  String get dataSourcesNote =>
      'Àkíyèsí: Àwọn ọ̀rọ̀ Al-Qur\'an, Tafsir, ìtúmọ̀, àti àwọn orísun ohùn wá láti Quran.com, Everyayah.com, àti àwọn orísun ṣíṣí sílẹ̀ mìíràn tí a ti fìdí rẹ̀ múlẹ̀.';

  @override
  String get adFreePromise =>
      'A ṣe áàpù yìí láti wá ìyọ́nú Allah. Nítorí náà, kò ní ìpolówó kankan, kò sì ní ní láéláé.';

  @override
  String get coreFeatures => 'Àwọn Àṣàyàn Pàtàkì';

  @override
  String get coreFeaturesDescription =>
      'Ṣàwárí àwọn iṣẹ́-ṣíṣe pàtàkì tí ó sọ Al-Qur\'an v3 di irinṣẹ́ tí kò ṣeé fọwọ́ rọ́ sẹ́yìn fún àwọn ìṣe Islam ojoojúmọ́ rẹ:';

  @override
  String get prayerTimesTitle => 'Àwọn Àkókò Kirun & Ìtaniji';

  @override
  String get prayerTimesDescription =>
      'Àwọn àkókò kirun tí ó péye fún ibikíbi káríayé nípa lílo àwọn ọ̀nà ìṣírò ọ̀tọ̀ọ̀tọ̀. Ṣètò àwọn ìránnilétí pẹ̀lú ìwifúnni Adhan.';

  @override
  String get qiblaDirectionTitle => 'Ìtọ́sọ́nà Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Wá ìtọ́sọ́nà Qibla ní ìrọ̀rùn pẹ̀lú ìran kọ́mpáàsì tí ó ṣe kedere àti péye.';

  @override
  String get translationTafsirTitle => 'Ìtúmọ̀ & Tafsir Al-Qur\'an';

  @override
  String get translationTafsirDescription =>
      'Wọlé sí àwọn ìwé ìtúmọ̀ tó lé ní 120 (pẹ̀lú ọ̀rọ̀ nìkọ̀ọ̀kan) ní èdè 69, àti àwọn ìwé Tafsir tó lé ní 30.';

  @override
  String get wordByWordAudioTitle => 'Ohùn Ọ̀rọ̀ nìkọ̀ọ̀kan & Àmì sí';

  @override
  String get wordByWordAudioDescription =>
      'Tẹ̀lé pẹ̀lú kewu ọ̀rọ̀ nìkọ̀ọ̀kan tí a ṣíṣẹpọ̀ àti àmì sí fún ìrírí ìkẹ́kọ̀ọ́ tí ó jinlẹ̀.';

  @override
  String get ayahAudioRecitationTitle => 'Kewu Ohùn Ayat';

  @override
  String get ayahAudioRecitationDescription =>
      'Gbọ́ kewu Ayat lẹ́kùn-únrẹ́rẹ́ láti ọ̀dọ̀ àwọn oníkewu olókìkí tó lé ní 40.';

  @override
  String get notesCloudBackupTitle => 'Àkọsílẹ̀ pẹ̀lú Ìpamọ́ Sínú Cloud';

  @override
  String get notesCloudBackupDescription =>
      'Fipamọ́ àwọn àkọsílẹ̀ àti àṣàrò ara ẹni, tí a fi pamọ́ sínú cloud ní ààbò (àṣàyàn yìí ń bọ̀ lọ́nà/kò tíì jáde).';

  @override
  String get crossPlatformSupportTitle => 'Ìtìlẹ́yìn lórí Oríṣiríṣi Platform';

  @override
  String get crossPlatformSupportDescription =>
      'A ti ṣe ìtìlẹ́yìn fún un lórí Android, Web, Linux, àti Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Títan Ohùn ní Ìsàlẹ̀';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Tẹ̀síwájú láti máa gbọ́ kewu Al-Qur\'an kódà nígbà tí áàpù bá wà ní ìsàlẹ̀.';

  @override
  String get audioDataCachingTitle => 'Ìpamọ́ Ohùn & Dátà sínú Cache';

  @override
  String get audioDataCachingDescription =>
      'Títan tó dára sí i àti agbára láti lò ó láìsí ìsopọ̀ pẹ̀lú caching dáadáa fún ohùn àti dátà Al-Qur\'an.';

  @override
  String get minimalisticInterfaceTitle => 'Ojú-iṣẹ́ tó rọrùn & Mímọ́';

  @override
  String get minimalisticInterfaceDescription =>
      'Ojú-iṣẹ́ tó rọrùn láti lò pẹ̀lú àfiyèsí sí ìrírí olùlò àti ìrọ̀rùn kíkà.';

  @override
  String get optimizedPerformanceTitle => 'Iṣẹ́-ṣíṣe & Ìwọ̀n tó dára jù';

  @override
  String get optimizedPerformanceDescription =>
      'Áàpù kan tí ó kún fún àwọn àṣàyàn tí a ṣe láti jẹ́ fúyẹ́ àti láti ṣiṣẹ́ dáadáa.';

  @override
  String get languageSupport => 'Ìtìlẹ́yìn Èdè';

  @override
  String get languageSupportDescription =>
      'A ṣe áàpù yìí láti wà fún gbogbo ènìyàn káríayé pẹ̀lú ìtìlẹ́yìn fún àwọn èdè wọ̀nyí (a sì ń fi kún un nígbà gbogbo):';

  @override
  String get technologyAndResources => 'Ìmọ̀-ẹ̀rọ & Àwọn Orísun';

  @override
  String get technologyAndResourcesDescription =>
      'A ṣe áàpù yìí pẹ̀lú àwọn ìmọ̀-ẹ̀rọ ìgbàlódé àti àwọn orísun tí ó ṣeé gbẹ́kẹ̀lé:';

  @override
  String get flutterFrameworkTitle => 'Ránpẹ́ Flutter';

  @override
  String get flutterFrameworkDescription =>
      'A fi Flutter ṣe é fún ìrírí lórí oríṣiríṣi platform tó rẹwà, tí a ṣàkójọpọ̀ ní ìbílẹ̀, láti inú koodu kan ṣoṣo.';

  @override
  String get advancedAudioEngineTitle => 'Ẹnjìn Ohùn Onítẹ̀síwájú';

  @override
  String get advancedAudioEngineDescription =>
      'Agbára rẹ̀ wá láti ọ̀dọ̀ àwọn pákéjì Flutter `just_audio` àti `just_audio_background` fún títan àti ìdarí ohùn tó lágbára.';

  @override
  String get reliableQuranDataTitle => 'Dátà Al-Qur\'an tó ṣeé gbẹ́kẹ̀lé';

  @override
  String get reliableQuranDataDescription =>
      'Àwọn ọ̀rọ̀, ìtúmọ̀, tafsir, àti ohùn Al-Qur\'an wá láti ọ̀dọ̀ àwọn API ṣíṣí sílẹ̀ àti àwọn ibi ìpamọ́ dátà tí a ti fìdí rẹ̀ múlẹ̀ bí Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Ẹnjìn Àkókò Kirun';

  @override
  String get prayerTimeEngineDescription =>
      'Ó ń lo àwọn ọ̀nà ìṣírò tí a ti mọ̀ fún àwọn àkókò kirun tó péye. Àwọn ìwifúnni jẹ́ àbójútó `flutter_local_notifications` àti àwọn iṣẹ́ ìsàlẹ̀.';

  @override
  String get crossPlatformSupport => 'Ìtìlẹ́yìn lórí Oríṣiríṣi Platform';

  @override
  String get crossPlatformSupportDescription2 =>
      'Gbádùn ìwọlé ní ìrọ̀rùn lórí àwọn platform ọ̀tọ̀ọ̀tọ̀:';

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
  String get ourLifetimePromise => 'Ìlérí Wa Títí Láé';

  @override
  String get lifetimePromiseDescription =>
      'Mo ṣe ìlérí fúnra mi láti pèsè ìtìlẹ́yìn àti ìtọ́jú lemọ́lemọ́ fún áàpù yìí jálẹ̀ ìgbésí ayé mi, In Sha Allah. Èròǹgbà mi ni láti rí i dájú pé áàpù yìí wà gẹ́gẹ́ bí orísun àǹfààní fún Ummah fún ọ̀pọ̀lọpọ̀ ọdún tí ń bọ̀.';

  @override
  String get fajr => 'Subhi';

  @override
  String get sunrise => 'Yíyọ Oòrùn';

  @override
  String get dhuhr => 'Mọ̀húrì';

  @override
  String get asr => 'Lásárì';

  @override
  String get maghrib => 'Mógúréèbè';

  @override
  String get isha => 'Íṣáì';

  @override
  String get midnight => 'Àárín Òru';

  @override
  String get alarm => 'Itaniji';

  @override
  String get notification => 'Ìwifúnni';

  @override
  String formattedAddress(
    Object administrativeArea,
    Object country,
    Object subAdministrativeArea,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajwid';

  @override
  String get quranScriptUthmani => 'Uthmani';

  @override
  String get quranScriptIndopak => 'Indopak';
}
