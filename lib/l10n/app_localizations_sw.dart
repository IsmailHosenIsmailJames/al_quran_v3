// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

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
    return 'Tafsiri haipatikani kwa $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsiri itapatikana kwa: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Ruka kwa $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Ukurasa';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Mipangilio ya Lugha';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Aya';
  }

  @override
  String get saveAndDownload => 'Hifadhi na Pakua';

  @override
  String get appLanguage => 'Lugha ya App';

  @override
  String get selectAppLanguage => 'Chagua lugha ya app...';

  @override
  String get pleaseSelectOne => 'Tafadhali chagua moja';

  @override
  String get quranTranslationLanguage => 'Lugha ya Tafsiri ya Kurani';

  @override
  String get selectTranslationLanguage => 'Chagua lugha ya tafsiri...';

  @override
  String get quranTranslationBook => 'Kitabu cha Tafsiri ya Kurani';

  @override
  String get selectTranslationBook => 'Chagua kitabu cha tafsiri...';

  @override
  String get quranTafsirLanguage => 'Lugha ya Tafsiri ya Kurani';

  @override
  String get selectTafsirLanguage => 'Chagua lugha ya tafsiri...';

  @override
  String get quranTafsirBook => 'Kitabu cha Tafsiri ya Kurani';

  @override
  String get selectTafsirBook => 'Chagua kitabu cha tafsiri...';

  @override
  String get quranScriptAndStyle => 'Nakala na Mtindo wa Kurani';

  @override
  String get justAMoment => 'Kidogo tu...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Mafanikio';

  @override
  String get retry => 'Jaribu tena';

  @override
  String get unableToDownloadResources =>
      'Imeshindwa kupakua rasilimali...\nKitu kimeharibika';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Inapakua Usomaji wa Kurani Iliyogawanywa';

  @override
  String get processingSegmentedQuranRecitation =>
      'Inachakata Usomaji wa Kurani Iliyogawanywa';

  @override
  String get footnote => 'Maelezo ya Chini';

  @override
  String get tafsir => 'Tafsiri';

  @override
  String get wordByWord => 'Neno kwa Neno';

  @override
  String get pleaseSelectRequiredOption =>
      'Tafadhali chagua chaguo linalohitajika';

  @override
  String get rememberHomeTab => 'Kumbuka Tab ya Nyumbani';

  @override
  String get rememberHomeTabSubtitle =>
      'App itakumbuka tab iliyofunguliwa mwisho katika skrini ya nyumbani.';

  @override
  String get wakeLock => 'Kufunga Skrini';

  @override
  String get wakeLockSubtitle => 'Zuia skrini kuzima moja kwa moja.';

  @override
  String get settings => 'Mipangilio';

  @override
  String get appTheme => 'Mandhari ya App';

  @override
  String get quranStyle => 'Mtindo wa Kurani';

  @override
  String get changeTheme => 'Badilisha Mandhari';

  @override
  String get verseCount => 'Idadi ya Aya: ';

  @override
  String get translation => 'Tafsiri';

  @override
  String get tafsirNotFound => 'Haikupatikana';

  @override
  String get moreInfo => 'maelezo zaidi';

  @override
  String get playAudio => 'Cheza Sauti';

  @override
  String get preview => 'Onyesho la Awali';

  @override
  String get loading => 'Inapakia...';

  @override
  String get errorFetchingAddress => 'Hitilafu katika kupata anwani';

  @override
  String get addressNotAvailable => 'Anwani haipatikani';

  @override
  String get latitude => 'Latitudo: ';

  @override
  String get longitude => 'Longitudo: ';

  @override
  String get name => 'Jina: ';

  @override
  String get location => 'Mahali: ';

  @override
  String get parameters => 'Vigezo: ';

  @override
  String get selectCalculationMethod => 'Chagua Njia ya Kuhesabu';

  @override
  String get shareSelectAyahs => 'Shiriki Aya Zilizochaguliwa';

  @override
  String get selectionEmpty => 'Uchaguzi Tupu';

  @override
  String get generatingImagePleaseWait =>
      'Inazalisha Picha... Tafadhali Subiri';

  @override
  String get asImage => 'Kama Picha';

  @override
  String get asText => 'Kama Nakala';

  @override
  String get playFromSelectedAyah => 'Cheza Kutoka Aya Iliyochaguliwa';

  @override
  String get toTafsir => 'Kwa Tafsiri';

  @override
  String get selectAyah => 'Chagua Aya';

  @override
  String get toAyah => 'Kwa Aya';

  @override
  String get searchForASurah => 'Tafuta sura';

  @override
  String get bugReportTitle => 'Ripoti ya Hitilafu';

  @override
  String get audioCached => 'Sauti Iliyohifadhiwa';

  @override
  String get others => 'Nyingine';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Kurani|Tafsiri|Aya, Moja Lazima Iwashwe';

  @override
  String get quranFontSize => 'Ukubwa wa Fonti ya Kurani';

  @override
  String get quranLineHeight => 'Urefu wa Mstari wa Kurani';

  @override
  String get translationAndTafsirFontSize =>
      'Ukubwa wa Fonti ya Tafsiri na Tafsiri';

  @override
  String get quranAyah => 'Aya ya Kurani';

  @override
  String get topToolbar => 'Upau wa Juu';

  @override
  String get keepOpenWordByWord => 'Weka Wazi Neno kwa Neno';

  @override
  String get wordByWordHighlight => 'Angazia Neno kwa Neno';

  @override
  String get quranScriptSettings => 'Mipangilio ya Nakala ya Kurani';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Nambari ya Ukurasa: ';

  @override
  String get quranResources => 'Rasilimali za Kurani';

  @override
  String alreadySelected(String name) {
    return 'Lugha \'$name\' imechaguliwa tayari.';
  }

  @override
  String get unableToGetCompassData => 'Imeshindwa kupata data ya dira';

  @override
  String get deviceDoesNotHaveSensors => 'Kifaa hakina vihisi !';

  @override
  String get north => 'K';

  @override
  String get east => 'M';

  @override
  String get south => 'Kus';

  @override
  String get west => 'Mag';

  @override
  String get address => 'Anwani: ';

  @override
  String get change => 'Badilisha';

  @override
  String get calculationMethod => 'Njia ya Kuhesabu: ';

  @override
  String get downloadPrayerTime => 'Pakua Muda wa Swala';

  @override
  String get calculationMethodsListEmpty =>
      'Orodha ya njia za kuhesabu ni tupu.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Haikuweza kupata njia yoyote ya kuhesabu na data ya mahali.';

  @override
  String get prayerSettings => 'Mipangilio ya Swala';

  @override
  String get reminderSettings => 'Mipangilio ya Ukumbusho';

  @override
  String get adjustReminderTime => 'Rekebisha Muda wa Ukumbusho';

  @override
  String get enforceAlarmSound => 'Lazimisha Sauti ya Kengele';

  @override
  String get enforceAlarmSoundDescription =>
      'Ikiwashwa, Kipengele hiki kitacheza kengele kwa sauti iliyowekwa hapa, hata kama sauti ya simu yako iko chini. Hii inahakikisha hutakosa kengele kwa sababu ya sauti ya simu kuwa chini.';

  @override
  String get volume => 'Sauti';

  @override
  String get atPrayerTime => 'Wakati wa swala';

  @override
  String minBefore(int minutes) {
    return '$minutes dakika kabla';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes dakika baada';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName ni saa $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Ni wakati wa $prayerName';
  }

  @override
  String get stopTheAdhan => 'Simamisha Adhana';

  @override
  String dateFoundEmpty(String date) {
    return '$date Imepatikana Tupu';
  }

  @override
  String get today => 'Leo';

  @override
  String get left => 'Kushoto';

  @override
  String reminderAdded(String prayerName) {
    return 'Ukumbusho wa $prayerName umeongezwa';
  }

  @override
  String get allowNotificationPermission =>
      'Tafadhali ruhusu idhini ya arifa ili kutumia kipengele hiki';

  @override
  String reminderRemoved(String prayerName) {
    return 'Ukumbusho wa $prayerName umeondolewa';
  }

  @override
  String get getPrayerTimesAndQibla => 'Pata Muda wa Swala na Kibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Hesabu Muda wa Swala na Kibla kwa Mahali Yoyote Iliyotolewa.';

  @override
  String get getFromGPS => 'Pata kutoka GPS';

  @override
  String get or => 'Au';

  @override
  String get selectYourCity => 'Chagua Mji Wako';

  @override
  String get noteAboutGPS =>
      'Kumbuka: Ikiwa hutaki kutumia GPS au hujisikia salama, unaweza kuchagua mji wako.';

  @override
  String get downloadingLocationResources => 'Inapakua rasilimali za mahali...';

  @override
  String get somethingWentWrong => 'Kitu kimeharibika';

  @override
  String get selectYourCountry => 'Chagua Nchi Yako';

  @override
  String get searchForACountry => 'Tafuta nchi';

  @override
  String get selectYourAdministrator => 'Chagua Msimamizi Wako';

  @override
  String get searchForAnAdministrator => 'Tafuta msimamizi';

  @override
  String get searchForACity => 'Tafuta mji';

  @override
  String get pleaseEnableLocationService => 'Tafadhali washa huduma ya mahali';

  @override
  String get donateUs => 'Tuchangie';

  @override
  String get underDevelopment => 'Inaendelea kujengwa';

  @override
  String get versionLoading => 'Inapakia...';

  @override
  String get alQuran => 'Al Kurani';

  @override
  String get mainMenu => 'Menyu Kuu';

  @override
  String get notes => 'Maelezo';

  @override
  String get pinned => 'Iliyobandikwa';

  @override
  String get jumpToAyah => 'Ruka kwa Aya';

  @override
  String get shareMultipleAyah => 'Shiriki Aya Nyingi';

  @override
  String get shareThisApp => 'Shiriki App Hii';

  @override
  String get giveRating => 'Toa Ukadiriaji';

  @override
  String get bugReport => 'Ripoti ya Hitilafu';

  @override
  String get privacyPolicy => 'Sera ya Faragha';

  @override
  String get aboutTheApp => 'Kuhusu App';

  @override
  String get resetTheApp => 'Weka Upya App';

  @override
  String get resetAppWarningTitle => 'Weka Upya Data ya App';

  @override
  String get resetAppWarningMessage =>
      'Una uhakika unataka kuweka upya app? Data yako yote itapotea, na utahitaji kuanzisha app tangu mwanzo.';

  @override
  String get cancel => 'Ghairi';

  @override
  String get reset => 'Weka Upya';

  @override
  String get shareAppSubject => 'Angalia App Hii ya Al Kurani!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Angalia app hii ya Al Kurani kwa kusoma na kutafakari kila siku. Inasaidia kuungana na maneno ya Allah. Pakua hapa: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Fungua Droo';

  @override
  String get quran => 'Kurani';

  @override
  String get prayer => 'Swala';

  @override
  String get qibla => 'Kibla';

  @override
  String get audio => 'Sauti';

  @override
  String get surah => 'Sura';

  @override
  String get pages => 'Kurasa';

  @override
  String get note => 'Maelezo:';

  @override
  String get linkedAyahs => 'Aya Zilizounganishwa:';

  @override
  String get emptyNoteCollection =>
      'Mkusanyiko huu wa maelezo ni tupu.\nOngeza maelezo ili kuyaona hapa.';

  @override
  String get emptyPinnedCollection =>
      'Hakuna Aya zilizobandikwa kwa mkusanyiko huu bado.\nBandika Aya ili kuyaona hapa.';

  @override
  String get noContentAvailable => 'Hakuna maudhui yanayopatikana.';

  @override
  String failedToLoadCollections(String error) {
    return 'Imeshindwa kupakia mikusanyiko: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Tafuta Kwa Jina la $collectionType...';
  }

  @override
  String get sortBy => 'Panga kwa';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Hakuna $collectionType iliyoongezwa bado';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count vitu vilivyobandikwa';
  }

  @override
  String notesCount(int count) {
    return '$count maelezo';
  }

  @override
  String get emptyNameNotAllowed => 'Jina tupu hairuhusiwi';

  @override
  String updatedTo(String collectionName) {
    return 'Imesasishwa kwa $collectionName';
  }

  @override
  String get changeName => 'Badilisha Jina';

  @override
  String get changeColor => 'Badilisha Rangi';

  @override
  String get colorUpdated => 'Rangi imesasishwa';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Imefutwa';
  }

  @override
  String get delete => 'Futa';

  @override
  String get save => 'Hifadhi';

  @override
  String get collectionNameCannotBeEmpty =>
      'Jina la mkusanyiko haliwezi kuwa tupu.';

  @override
  String get addedNewCollection => 'Imeongezwa Mkusanyiko Mpya';

  @override
  String ayahCount(int count) {
    return '$count Aya';
  }

  @override
  String get byNameAtoZ => 'Jina A-Z';

  @override
  String get byNameZtoA => 'Jina Z-A';

  @override
  String get byElementNumberAscending => 'Nambari ya Kipengele Inayopanda';

  @override
  String get byElementNumberDescending => 'Nambari ya Kipengele Inayoshuka';

  @override
  String get byUpdateDateAscending => 'Tarehe ya Kusasisha Inayopanda';

  @override
  String get byUpdateDateDescending => 'Tarehe ya Kusasisha Inayoshuka';

  @override
  String get byCreateDateAscending => 'Tarehe ya Kuunda Inayopanda';

  @override
  String get byCreateDateDescending => 'Tarehe ya Kuunda Inayoshuka';

  @override
  String get translationNotFound => 'Tafsiri Haikupatikana';

  @override
  String get translationTitle => 'Tafsiri:';

  @override
  String get footNoteTitle => 'Maelezo ya Chini:';

  @override
  String get wordByWordTranslation => 'Tafsiri Neno kwa Neno:';

  @override
  String get tafsirButton => 'Tafsiri';

  @override
  String get shareButton => 'Shiriki';

  @override
  String get addNoteButton => 'Ongeza Maelezo';

  @override
  String get pinToCollectionButton => 'Bandika kwa Mkusanyiko';

  @override
  String get shareAsText => 'Shiriki kama Nakala';

  @override
  String get copiedWithTafsir => 'Imenakiliwa na Tafsiri';

  @override
  String get shareAsImage => 'Shiriki kama Picha';

  @override
  String get shareWithTafsir => 'Shiriki na Tafsiri';

  @override
  String get notFound => 'Haikupatikana';

  @override
  String get noteContentCannotBeEmpty =>
      'Maudhui ya maelezo haliwezi kuwa tupu.';

  @override
  String get noteSavedSuccessfully => 'Maelezo yamehifadhiwa kwa mafanikio!';

  @override
  String get selectCollections => 'Chagua Mikusanyiko';

  @override
  String get addNote => 'Ongeza Maelezo';

  @override
  String get writeCollectionName => 'Andika jina la mkusanyiko...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Hakuna mikusanyiko bado. Ongeza mpya!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Tafadhali andika maelezo yako kwanza.';

  @override
  String get noCollectionSelected => 'Hakuna Mkusanyiko uliochaguliwa';

  @override
  String get saveNote => 'Hifadhi Maelezo';

  @override
  String get nextSelectCollections => 'Ifuatayo: Chagua Mikusanyiko';

  @override
  String get addToPinned => 'Ongeza kwa Iliyobandikwa';

  @override
  String get pinnedSavedSuccessfully =>
      'Iliyobandikwa imehifadhiwa kwa mafanikio!';

  @override
  String get savePinned => 'Hifadhi Iliyobandikwa';

  @override
  String get closeAudioController => 'Funga Kidhibiti cha Sauti';

  @override
  String get previous => 'Iliyotangulia';

  @override
  String get rewind => 'Rudisha Nyuma';

  @override
  String get fastForward => 'Songa Mbele';

  @override
  String get playNextAyah => 'Cheza Aya Ifuatayo';

  @override
  String get repeat => 'Rudia';

  @override
  String get playAsPlaylist => 'Cheza Kama Orodha ya Kucheza';

  @override
  String style(String style) {
    return 'Mtindo: $style';
  }

  @override
  String get stopAndClose => 'Simamisha & Funga';

  @override
  String get play => 'Cheza';

  @override
  String get pause => 'Sitisha';

  @override
  String get selectReciter => 'Chagua Msomaji';

  @override
  String source(String source) {
    return 'Chanzo: $source';
  }

  @override
  String get newText => 'Mpya';

  @override
  String get more => 'Zaidi: ';

  @override
  String get cacheNotFound => 'Hifadhi Haikupatikana';

  @override
  String get cacheSize => 'Ukubwa wa Hifadhi';

  @override
  String error(String error) {
    return 'Hitilafu: $error';
  }

  @override
  String get clean => 'Safisha';

  @override
  String get lastModified => 'Ilirekebishwa Mwisho';

  @override
  String get oneYearAgo => 'Mwaka 1 uliopita';

  @override
  String monthsAgo(String number) {
    return '$number Miezi iliyopita';
  }

  @override
  String weeksAgo(String number) {
    return '$number Wiki zilizopita';
  }

  @override
  String daysAgo(String number) {
    return '$number Siku zilizopita';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Saa zilizopita';
  }

  @override
  String get aboutAlQuran => 'Kuhusu Al Kurani';

  @override
  String get appFullName => 'Al Kurani (Tafsiri, Swala, Kibla, Sauti)';

  @override
  String get appDescription =>
      'Programu kamili ya Kiislamu kwa Android, iOS, MacOS, Wavuti, Linux na Windows, inayotoa kusoma Kurani na Tafsiri & tafsiri nyingi (ikiwemo neno kwa neno), muda wa swala duniani kote na arifa, dira ya Kibla, na usomaji wa sauti wa neno kwa neno uliosawazishwa.';

  @override
  String get dataSourcesNote =>
      'Kumbuka: Nakala za Kurani, Tafsiri, tafsiri, na rasilimali za sauti zinatoka Quran.com, Everyayah.com, na vyanzo vingine vilivyothibitishwa vya wazi.';

  @override
  String get adFreePromise =>
      'App hii imejengwa ili kutafuta radhi ya Allah. Kwa hivyo, ni na itakuwa bila Matangazo milele.';

  @override
  String get coreFeatures => 'Vipengele Muhimu';

  @override
  String get coreFeaturesDescription =>
      'Chunguza vipengele muhimu vinavyofanya Al Kurani v3 kuwa chombo muhimu kwa mazoezi yako ya kila siku ya Kiislamu:';

  @override
  String get prayerTimesTitle => 'Muda wa Swala & Arifa';

  @override
  String get prayerTimesDescription =>
      'Muda sahihi wa swala kwa mahali yoyote duniani kwa kutumia njia mbalimbali za kuhesabu. Weka ukumbusho na arifa za Adhana.';

  @override
  String get qiblaDirectionTitle => 'Mwelekeo wa Kibla';

  @override
  String get qiblaDirectionDescription =>
      'Pata mwelekeo wa Kibla kwa urahisi na mwonekano wa dira iliyo wazi na sahihi.';

  @override
  String get translationTafsirTitle => 'Tafsiri & Tafsiri ya Kurani';

  @override
  String get translationTafsirDescription =>
      'Pata vitabu 120+ vya tafsiri (ikiwemo neno kwa neno) katika lugha 69, na vitabu 30+ vya Tafsiri.';

  @override
  String get wordByWordAudioTitle => 'Sauti & Angazia Neno kwa Neno';

  @override
  String get wordByWordAudioDescription =>
      'Fuata pamoja na usomaji wa sauti wa neno kwa neno uliosawazishwa na angazia kwa uzoefu wa kujifunza unaovuta.';

  @override
  String get ayahAudioRecitationTitle => 'Usomaji wa Sauti wa Aya';

  @override
  String get ayahAudioRecitationDescription =>
      'Sikiliza usomaji kamili wa Aya kutoka kwa wasomaji 40+ mashuhuri.';

  @override
  String get notesCloudBackupTitle => 'Maelezo na Hifadhi ya Wingu';

  @override
  String get notesCloudBackupDescription =>
      'Hifadhi maelezo na tafakari za kibinafsi, zilizohifadhiwa salama kwenye wingu (kipengele kinaendelea kujengwa/kinakuja hivi karibuni).';

  @override
  String get crossPlatformSupportTitle => 'Usaidizi wa Vifaa Vingi';

  @override
  String get crossPlatformSupportDescription =>
      'Inaauniwa kwenye Android, Wavuti, Linux, na Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Uchezaji wa Sauti Nyuma';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Endelea kusikiliza usomaji wa Kurani hata wakati app iko nyuma.';

  @override
  String get audioDataCachingTitle => 'Hifadhi ya Sauti & Data';

  @override
  String get audioDataCachingDescription =>
      'Uchezaji ulioboreshwa na uwezo wa nje ya mtandao na hifadhi thabiti ya sauti na data ya Kurani.';

  @override
  String get minimalisticInterfaceTitle => 'Muundo Mdogo & Safi';

  @override
  String get minimalisticInterfaceDescription =>
      'Muundo rahisi wa kushughulikia na umakini kwa uzoefu wa mtumiaji na usomaji.';

  @override
  String get optimizedPerformanceTitle => 'Utendaji Ulioboreshwa & Ukubwa';

  @override
  String get optimizedPerformanceDescription =>
      'Programu yenye vipengele vingi iliyoundwa kuwa nyepesi na yenye utendaji mzuri.';

  @override
  String get languageSupport => 'Usaidizi wa Lugha';

  @override
  String get languageSupportDescription =>
      'Programu hii imeundwa ili iweze kufikiwa na hadhira ya kimataifa na usaidizi wa lugha zifuatazo (na zaidi zinaongezwa mara kwa mara):';

  @override
  String get technologyAndResources => 'Teknolojia & Rasilimali';

  @override
  String get technologyAndResourcesDescription =>
      'App hii imejengwa kwa kutumia teknolojia za kisasa na rasilimali za kuaminika:';

  @override
  String get flutterFrameworkTitle => 'Mfumo wa Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Imejengwa na Flutter kwa uzoefu mzuri, uliokusanywa asili, wa vifaa vingi kutoka kwa msingi mmoja wa kodi.';

  @override
  String get advancedAudioEngineTitle => 'Injini ya Sauti ya Kina';

  @override
  String get advancedAudioEngineDescription =>
      'Inaendeshwa na vifurushi vya Flutter `just_audio` na `just_audio_background` kwa uchezaji wa sauti thabiti na udhibiti.';

  @override
  String get reliableQuranDataTitle => 'Data ya Kurani Iliyoaminika';

  @override
  String get reliableQuranDataDescription =>
      'Nakala za Al Kurani, tafsiri, tafsiri, na sauti zinatoka kwa API na hifadhidata za wazi zilithibitishwa kama Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Injini ya Muda wa Swala';

  @override
  String get prayerTimeEngineDescription =>
      'Inatumia njia zilizoanzishwa za kuhesabu kwa muda sahihi wa swala. Arifa zinashughulikiwa na `flutter_local_notifications` na kazi za nyuma.';

  @override
  String get crossPlatformSupport => 'Usaidizi wa Vifaa Vingi';

  @override
  String get crossPlatformSupportDescription2 =>
      'Furahia upatikanaji bila shida kwenye vifaa mbalimbali:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'Wavuti';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'Ahadi Yetu ya Maisha';

  @override
  String get lifetimePromiseDescription =>
      'Mimi binafsi naahidi kutoa usaidizi na matengenezo endelevu kwa programu hii katika maisha yangu yote, In Sha Allah. Lengo langu ni kuhakikisha app hii inabaki kuwa rasilimali yenye faida kwa Ummah kwa miaka ijayo.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Kuchomoza kwa Jua';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Usiku wa Manane';

  @override
  String get alarm => 'Kengele';

  @override
  String get notification => 'Arifa';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajweed';

  @override
  String get quranScriptUthmani => 'Uthmani';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Aya ya Sajda';

  @override
  String get required => 'Inahitajika';

  @override
  String get optional => 'Hiari';

  @override
  String get notificationScheduleWarning =>
      'Kumbuka: Arifa au Ukumbusho uliopangwa unaweza kukosa kutokana na vizuizi vya mchakato wa nyuma wa OS ya simu yako. Kwa mfano: Origin OS ya Vivo, One UI ya Samsung, ColorOS ya Oppo wakati mwingine huua Arifa au Ukumbusho uliopangwa. Tafadhali angalia mipangilio ya OS yako ili kufanya app isizuiwe kutoka mchakato wa nyuma.';

  @override
  String get scrollWithRecitation => 'Tembeza na Usomaji';

  @override
  String get quickAccess => 'Upatikanaji Haraka';

  @override
  String get initiallyScrollAyah => 'Awali tembeza kwa aya';

  @override
  String get tajweedGuide => 'Mwongozo wa Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Ikiwashwa, aya ya Kurani itatembeza moja kwa moja sawia na usomaji wa sauti.';

  @override
  String get configuration => 'Usanidi';

  @override
  String get restoreFromBackup => 'Rejesha Kutoka Hifadhi';

  @override
  String get history => 'Historia';

  @override
  String get search => 'Tafuta';

  @override
  String get useAudioStream => 'Tumia Mtiririko wa Sauti';

  @override
  String get useAudioStreamDesc =>
      'Mtiririko wa sauti moja kwa moja kutoka intaneti badala ya kupakua.';

  @override
  String get notUseAudioStreamDesc =>
      'Pakua sauti kwa matumizi ya nje ya mtandao na kupunguza matumizi ya data.';

  @override
  String get audioSettings => 'Mipangilio ya Sauti';

  @override
  String get playbackSpeed => 'Kasi ya Uchezaji';

  @override
  String get playbackSpeedDesc => 'Rekebisha kasi ya Usomaji wa Kurani.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Tafadhali subiri upakuaji wa sasa umalize.';

  @override
  String get areYouSure => 'Una uhakika?';

  @override
  String get checkYourInternetConnection =>
      'Angalia muunganisho wako wa intaneti.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Inahitaji kupakua $requiredDownload kati ya $totalVersesCount aya.';
  }

  @override
  String get download => 'Pakua';

  @override
  String get audioDownload => 'Upakuaji wa Sauti';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Kuboresha Nakala ya Kurani';

  @override
  String get supportOnGithub => 'Saidia kwenye GitHub';
}
