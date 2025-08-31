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
    return 'Tafsiri itapatikana kwenye: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Rukia $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizbu';

  @override
  String get juz => 'Juzu';

  @override
  String get page => 'Ukurasa';

  @override
  String get ruku => 'Rukuu';

  @override
  String get languageSettings => 'Mipangilio ya Lugha';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return 'Aya $count';
  }

  @override
  String get saveAndDownload => 'Hifadhi na Upakue';

  @override
  String get appLanguage => 'Lugha ya Programu';

  @override
  String get selectAppLanguage => 'Chagua lugha ya programu...';

  @override
  String get pleaseSelectOne => 'Tafadhali chagua moja';

  @override
  String get quranTranslationLanguage => 'Lugha ya Tafsiri ya Qur\'ani';

  @override
  String get selectTranslationLanguage => 'Chagua lugha ya tafsiri...';

  @override
  String get quranTranslationBook => 'Kitabu cha Tafsiri ya Qur\'ani';

  @override
  String get selectTranslationBook => 'Chagua kitabu cha tafsiri...';

  @override
  String get quranTafsirLanguage => 'Lugha ya Tafsiri ya Kina (Tafsiri)';

  @override
  String get selectTafsirLanguage => 'Chagua lugha ya tafsiri ya kina...';

  @override
  String get quranTafsirBook => 'Kitabu cha Tafsiri ya Kina';

  @override
  String get selectTafsirBook => 'Chagua kitabu cha tafsiri ya kina...';

  @override
  String get quranScriptAndStyle => 'Mwandiko na Mtindo wa Qur\'ani';

  @override
  String get justAMoment => 'Subiri kidogo...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Imefanikiwa';

  @override
  String get retry => 'Jaribu Tena';

  @override
  String get unableToDownloadResources =>
      'Imeshindwa kupakua nyenzo...\nKuna tatizo limetokea';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Inapakua usomaji wa Qur\'ani kwa sehemu';

  @override
  String get processingSegmentedQuranRecitation =>
      'Inachakata usomaji wa Qur\'ani kwa sehemu';

  @override
  String get footnote => 'Tanbihi';

  @override
  String get tafsir => 'Tafsiri';

  @override
  String get wordByWord => 'Neno kwa Neno';

  @override
  String get pleaseSelectRequiredOption =>
      'Tafadhali chagua chaguo linalohitajika';

  @override
  String get rememberHomeTab => 'Kumbuka Kichupo cha Mwanzo';

  @override
  String get rememberHomeTabSubtitle =>
      'Programu itakumbuka kichupo cha mwisho kilichofunguliwa kwenye skrini ya mwanzo.';

  @override
  String get wakeLock => 'Zuia Skrini Isizime';

  @override
  String get wakeLockSubtitle => 'Zuia skrini isizime yenyewe.';

  @override
  String get settings => 'Mipangilio';

  @override
  String get appTheme => 'Mandhari ya Programu';

  @override
  String get quranStyle => 'Mtindo wa Qur\'ani';

  @override
  String get changeTheme => 'Badilisha Mandhari';

  @override
  String get verseCount => 'Idadi ya Aya: ';

  @override
  String get translation => 'Tafsiri';

  @override
  String get tafsirNotFound => 'Haikupatikana';

  @override
  String get moreInfo => 'Maelezo zaidi';

  @override
  String get playAudio => 'Cheza Sauti';

  @override
  String get preview => 'Onyesho la awali';

  @override
  String get loading => 'Inapakia...';

  @override
  String get errorFetchingAddress => 'Hitilafu kupata anwani';

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
  String get selectCalculationMethod => 'Chagua Njia ya Kukokotoa';

  @override
  String get shareSelectAyahs => 'Shiriki Aya Zilizochaguliwa';

  @override
  String get selectionEmpty => 'Hakuna Ulichochagua';

  @override
  String get generatingImagePleaseWait =>
      'Inatengeneza Picha... Tafadhali Subiri';

  @override
  String get asImage => 'Kama Picha';

  @override
  String get asText => 'Kama Maandishi';

  @override
  String get playFromSelectedAyah => 'Cheza Kutoka Aya Uliyochagua';

  @override
  String get toTafsir => 'Kwenye Tafsiri';

  @override
  String get selectAyah => 'Chagua Aya';

  @override
  String get toAyah => 'Kwenye Aya';

  @override
  String get searchForASurah => 'Tafuta sura';

  @override
  String get bugReportTitle => 'Ripoti ya Hitilafu';

  @override
  String get audioCached => 'Sauti Imehifadhiwa Kwenye Akiba';

  @override
  String get others => 'Nyinginezo';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Qur\'ani|Tafsiri|Aya, Lazima Moja Iwashwe';

  @override
  String get quranFontSize => 'Ukubwa wa Mwandiko wa Qur\'ani';

  @override
  String get quranLineHeight => 'Nafasi kati ya Mistari ya Qur\'ani';

  @override
  String get translationAndTafsirFontSize => 'Ukubwa wa Mwandiko wa Tafsiri';

  @override
  String get quranAyah => 'Aya ya Qur\'ani';

  @override
  String get topToolbar => 'Upau wa Zana wa Juu';

  @override
  String get keepOpenWordByWord => 'Acha Wazi Neno kwa Neno';

  @override
  String get wordByWordHighlight => 'Kuangaza Neno kwa Neno';

  @override
  String get quranScriptSettings => 'Mipangilio ya Mwandiko wa Qur\'ani';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Ukurasa: ';

  @override
  String get quranResources => 'Nyenzo za Qur\'ani';

  @override
  String alreadySelected(String name) {
    return 'Lugha ya \'$name\' tayari imechaguliwa.';
  }

  @override
  String get unableToGetCompassData => 'Imeshindwa kupata data ya dira';

  @override
  String get deviceDoesNotHaveSensors => 'Kifaa hakina vitambuzi!';

  @override
  String get north => 'N';

  @override
  String get east => 'E';

  @override
  String get south => 'S';

  @override
  String get west => 'W';

  @override
  String get address => 'Anwani: ';

  @override
  String get change => 'Badilisha';

  @override
  String get calculationMethod => 'Njia ya Kukokotoa: ';

  @override
  String get downloadPrayerTime => 'Pakua Nyakati za Swala';

  @override
  String get calculationMethodsListEmpty =>
      'Orodha ya njia za kukokotoa haina kitu.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Haikuweza kupata njia yoyote ya kukokotoa na data ya eneo.';

  @override
  String get prayerSettings => 'Mipangilio ya Swala';

  @override
  String get reminderSettings => 'Mipangilio ya Vikumbusho';

  @override
  String get adjustReminderTime => 'Rekebisha Muda wa Kikumbusho';

  @override
  String get enforceAlarmSound => 'Lazimisha Sauti ya Kengele';

  @override
  String get enforceAlarmSoundDescription =>
      'Ikiwashwa, kipengele hiki kitacheza kengele kwa sauti iliyowekwa hapa, hata kama sauti ya simu yako iko chini. Hii inahakikisha hutakosa kengele kwa sababu ya sauti ndogo ya simu.';

  @override
  String get volume => 'Sauti';

  @override
  String get atPrayerTime => 'Wakati wa swala';

  @override
  String minBefore(int minutes) {
    return 'Dakika $minutes kabla';
  }

  @override
  String minAfter(int minutes) {
    return 'Dakika $minutes baada ya';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Wakati wa $prayerName ni saa $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Ni wakati wa $prayerName';
  }

  @override
  String get stopTheAdhan => 'Sitisha Adhana';

  @override
  String dateFoundEmpty(String date) {
    return '$date Haikupatikana';
  }

  @override
  String get today => 'Leo';

  @override
  String get left => 'Imebaki';

  @override
  String reminderAdded(String prayerName) {
    return 'Kikumbusho cha $prayerName kimeongezwa';
  }

  @override
  String get allowNotificationPermission =>
      'Tafadhali ruhusu idhini ya arifa kutumia kipengele hiki';

  @override
  String reminderRemoved(String prayerName) {
    return 'Kikumbusho cha $prayerName kimeondolewa';
  }

  @override
  String get getPrayerTimesAndQibla => 'Pata Nyakati za Swala na Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Kokotoa Nyakati za Swala na Qibla kwa Eneo Lolote.';

  @override
  String get getFromGPS => 'Pata kutoka GPS';

  @override
  String get or => 'Au';

  @override
  String get selectYourCity => 'Chagua Jiji lako';

  @override
  String get noteAboutGPS =>
      'Kumbuka: Ikiwa hutaki kutumia GPS au hujisikii salama, unaweza kuchagua jiji lako.';

  @override
  String get downloadingLocationResources => 'Inapakua nyenzo za eneo...';

  @override
  String get somethingWentWrong => 'Kuna tatizo limetokea';

  @override
  String get selectYourCountry => 'Chagua Nchi Yako';

  @override
  String get searchForACountry => 'Tafuta nchi';

  @override
  String get selectYourAdministrator => 'Chagua Mkoa Wako';

  @override
  String get searchForAnAdministrator => 'Tafuta mkoa';

  @override
  String get searchForACity => 'Tafuta jiji';

  @override
  String get pleaseEnableLocationService => 'Tafadhali washa huduma ya eneo';

  @override
  String get donateUs => 'Tuchangie';

  @override
  String get underDevelopment => 'Inaendelezwa';

  @override
  String get versionLoading => 'Inapakia...';

  @override
  String get alQuran => 'Al Qur\'an';

  @override
  String get mainMenu => 'Menyu Kuu';

  @override
  String get notes => 'Dondoo';

  @override
  String get pinned => 'Zilizobandikwa';

  @override
  String get jumpToAyah => 'Rukia Aya';

  @override
  String get shareMultipleAyah => 'Shiriki Aya Nyingi';

  @override
  String get shareThisApp => 'Shiriki Programu Hii';

  @override
  String get giveRating => 'Toa Ukadiriaji';

  @override
  String get bugReport => 'Ripoti ya Hitilafu';

  @override
  String get privacyPolicy => 'Sera ya Faragha';

  @override
  String get aboutTheApp => 'Kuhusu Programu';

  @override
  String get resetTheApp => 'Weka Upya Programu';

  @override
  String get resetAppWarningTitle => 'Weka Upya Data ya Programu';

  @override
  String get resetAppWarningMessage =>
      'Una uhakika unataka kuweka upya programu? Data zako zote zitapotea, na utahitaji kuiweka programu upya tangu mwanzo.';

  @override
  String get cancel => 'Ghairi';

  @override
  String get reset => 'Weka Upya';

  @override
  String get shareAppSubject => 'Tazama Programu hii ya Al Qur\'an!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamu alaykum! Tazama programu hii ya Al Qur\'an kwa usomaji na tafakari ya kila siku. Inasaidia kuungana na maneno ya Mwenyezi Mungu. Pakua hapa: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Fungua Droo';

  @override
  String get quran => 'Qur\'ani';

  @override
  String get prayer => 'Swala';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Sauti';

  @override
  String get surah => 'Sura';

  @override
  String get pages => 'Kurasa';

  @override
  String get note => 'Kumbuka:';

  @override
  String get linkedAyahs => 'Aya Zinazohusiana:';

  @override
  String get emptyNoteCollection =>
      'Mkusanyiko huu wa dondoo hauna kitu.\nOngeza dondoo ili zionekane hapa.';

  @override
  String get emptyPinnedCollection =>
      'Hakuna Aya zilizobandikwa kwenye mkusanyiko huu.\nBandika Aya ili zionekane hapa.';

  @override
  String get noContentAvailable => 'Hakuna maudhui yanayopatikana.';

  @override
  String failedToLoadCollections(String error) {
    return 'Imeshindwa kupakia makusanyo: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Tafuta kwa Jina la $collectionType...';
  }

  @override
  String get sortBy => 'Panga kwa';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Hakuna $collectionType iliyoongezwa bado';
  }

  @override
  String pinnedItemsCount(int count) {
    return 'Vipengee $count vilivyobandikwa';
  }

  @override
  String notesCount(int count) {
    return 'Dondoo $count';
  }

  @override
  String get emptyNameNotAllowed => 'Jina tupu haliruhusiwi';

  @override
  String updatedTo(String collectionName) {
    return 'Imesasishwa kuwa $collectionName';
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
  String get addedNewCollection => 'Mkusanyiko Mpya Umeongezwa';

  @override
  String ayahCount(int count) {
    return 'Aya $count';
  }

  @override
  String get byNameAtoZ => 'Jina A-Z';

  @override
  String get byNameZtoA => 'Jina Z-A';

  @override
  String get byElementNumberAscending => 'Nambari ya Kipengee Kupanda';

  @override
  String get byElementNumberDescending => 'Nambari ya Kipengee Kushuka';

  @override
  String get byUpdateDateAscending => 'Tarehe ya Usasishaji Kupanda';

  @override
  String get byUpdateDateDescending => 'Tarehe ya Usasishaji Kushuka';

  @override
  String get byCreateDateAscending => 'Tarehe ya Kuundwa Kupanda';

  @override
  String get byCreateDateDescending => 'Tarehe ya Kuundwa Kushuka';

  @override
  String get translationNotFound => 'Tafsiri Haikupatikana';

  @override
  String get translationTitle => 'Tafsiri:';

  @override
  String get footNoteTitle => 'Tanbihi:';

  @override
  String get wordByWordTranslation => 'Tafsiri Neno kwa Neno:';

  @override
  String get tafsirButton => 'Tafsiri';

  @override
  String get shareButton => 'Shiriki';

  @override
  String get addNoteButton => 'Ongeza Dondoo';

  @override
  String get pinToCollectionButton => 'Bandika kwenye Mkusanyiko';

  @override
  String get shareAsText => 'Shiriki kama Maandishi';

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
      'Maudhui ya dondoo hayawezi kuwa tupu.';

  @override
  String get noteSavedSuccessfully => 'Dondoo limehifadhiwa kikamilifu!';

  @override
  String get selectCollections => 'Chagua Makusanyo';

  @override
  String get addNote => 'Ongeza Dondoo';

  @override
  String get writeCollectionName => 'Andika jina la mkusanyiko...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Hakuna makusanyo bado. Ongeza jipya!';

  @override
  String get pleaseWriteYourNoteFirst => 'Tafadhali andika dondoo lako kwanza.';

  @override
  String get noCollectionSelected => 'Hakuna Mkusanyiko uliochaguliwa';

  @override
  String get saveNote => 'Hifadhi Dondoo';

  @override
  String get nextSelectCollections => 'Inayofuata: Chagua Makusanyo';

  @override
  String get addToPinned => 'Ongeza kwenye Zilizobandikwa';

  @override
  String get pinnedSavedSuccessfully =>
      'Imehifadhiwa kikamilifu kwenye zilizobandikwa!';

  @override
  String get savePinned => 'Hifadhi Zilizobandikwa';

  @override
  String get closeAudioController => 'Funga Kidhibiti cha Sauti';

  @override
  String get previous => 'Iliyopita';

  @override
  String get rewind => 'Rudisha Nyuma';

  @override
  String get fastForward => 'Songesha Mbele';

  @override
  String get playNextAyah => 'Cheza Aya Inayofuata';

  @override
  String get repeat => 'Rudia';

  @override
  String get playAsPlaylist => 'Cheza kama Orodha ya Kucheza';

  @override
  String style(String style) {
    return 'Mtindo: $style';
  }

  @override
  String get stopAndClose => 'Sitisha na Funga';

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
  String get cacheNotFound => 'Akiba Haikupatikana';

  @override
  String get cacheSize => 'Ukubwa wa Akiba';

  @override
  String error(String error) {
    return 'Hitilafu: $error';
  }

  @override
  String get clean => 'Safisha';

  @override
  String get lastModified => 'Ilibadilishwa Mwisho';

  @override
  String get oneYearAgo => 'Mwaka 1 uliopita';

  @override
  String monthsAgo(String number) {
    return 'Miezi $number iliyopita';
  }

  @override
  String weeksAgo(String number) {
    return 'Wiki $number zilizopita';
  }

  @override
  String daysAgo(String number) {
    return 'Siku $number zilizopita';
  }

  @override
  String hoursAgo(int hour) {
    return 'Saa $hour zilizopita';
  }

  @override
  String get aboutAlQuran => 'Kuhusu Al Qur\'an';

  @override
  String get appFullName => 'Al Qur\'an (Tafsiri, Swala, Qibla, Sauti)';

  @override
  String get appDescription =>
      'Programu kamili ya Kiislamu kwa ajili ya Android, iOS, MacOS, Web, Linux na Windows, inayotoa usomaji wa Qur\'ani na Tafsiri ya Kina & tafsiri nyingi (ikiwemo neno kwa neno), nyakati za swala duniani kote na arifa, dira ya Qibla, na usomaji wa sauti wa neno kwa neno uliolandanishwa.';

  @override
  String get dataSourcesNote =>
      'Kumbuka: Maandishi ya Qur\'ani, Tafsiri, tafsiri nyingine, na nyenzo za sauti zinatokana na Quran.com, Everyayah.com, na vyanzo vingine vilivyothibitishwa vya wazi.';

  @override
  String get adFreePromise =>
      'Programu hii imejengwa ili kutafuta radhi za Mwenyezi Mungu. Kwa hivyo, haina na daima haitakuwa na matangazo kabisa.';

  @override
  String get coreFeatures => 'Vipengele Muhimu';

  @override
  String get coreFeaturesDescription =>
      'Gundua utendaji muhimu unaoifanya Al Qur\'an v3 kuwa zana muhimu kwa ajili ya matendo yako ya Kiislamu ya kila siku:';

  @override
  String get prayerTimesTitle => 'Nyakati za Swala na Vikumbusho';

  @override
  String get prayerTimesDescription =>
      'Nyakati sahihi za swala kwa eneo lolote duniani kote kwa kutumia njia mbalimbali za kukokotoa. Weka vikumbusho na arifa za Adhana.';

  @override
  String get qiblaDirectionTitle => 'Mwelekeo wa Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Pata mwelekeo wa Qibla kwa urahisi na mwonekano wa dira ulio wazi na sahihi.';

  @override
  String get translationTafsirTitle => 'Tafsiri ya Qur\'ani na Tafsiri ya Kina';

  @override
  String get translationTafsirDescription =>
      'Fikia vitabu vya tafsiri zaidi ya 120 (ikiwemo neno kwa neno) katika lugha 69, na vitabu vya Tafsiri ya Kina zaidi ya 30.';

  @override
  String get wordByWordAudioTitle => 'Sauti na Kuangaza Neno kwa Neno';

  @override
  String get wordByWordAudioDescription =>
      'Fuatilia pamoja na usomaji wa sauti wa neno kwa neno uliolandanishwa na kuangazwa kwa ajili ya uzoefu wa kujifunza unaovutia.';

  @override
  String get ayahAudioRecitationTitle => 'Usomaji wa Sauti wa Aya';

  @override
  String get ayahAudioRecitationDescription =>
      'Sikiliza usomaji kamili wa Aya kutoka kwa wasomaji maarufu zaidi ya 40.';

  @override
  String get notesCloudBackupTitle => 'Dondoo na Hifadhi ya Wingu';

  @override
  String get notesCloudBackupDescription =>
      'Hifadhi dondoo na tafakari za kibinafsi, zikihifadhiwa kwa usalama kwenye wingu (kipengele kinachoendelezwa/kinakuja hivi karibuni).';

  @override
  String get crossPlatformSupportTitle => 'Usaidizi wa Majukwaa Mbalimbali';

  @override
  String get crossPlatformSupportDescription =>
      'Inatumika kwenye Android, Web, Linux, na Windows.';

  @override
  String get backgroundAudioPlaybackTitle =>
      'Uchezaji wa Sauti Chini kwa Chini';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Endelea kusikiliza usomaji wa Qur\'ani hata wakati programu iko chini kwa chini.';

  @override
  String get audioDataCachingTitle => 'Uhifadhi wa Sauti na Data';

  @override
  String get audioDataCachingDescription =>
      'Uchezaji ulioboreshwa na uwezo wa nje ya mtandao na uhifadhi thabiti wa sauti na data ya Qur\'ani.';

  @override
  String get minimalisticInterfaceTitle => 'Muonekano Rahisi na Safi';

  @override
  String get minimalisticInterfaceDescription =>
      'Muonekano rahisi wa kutumia unaozingatia uzoefu wa mtumiaji na usomaji.';

  @override
  String get optimizedPerformanceTitle => 'Utendaji na Ukubwa Ulioboreshwa';

  @override
  String get optimizedPerformanceDescription =>
      'Programu yenye vipengele vingi iliyoundwa kuwa nyepesi na yenye utendaji mzuri.';

  @override
  String get languageSupport => 'Usaidizi wa Lugha';

  @override
  String get languageSupportDescription =>
      'Programu hii imeundwa kupatikana kwa hadhira ya kimataifa na usaidizi wa lugha zifuatazo (na zaidi zinaongezwa kila mara):';

  @override
  String get technologyAndResources => 'Teknolojia na Nyenzo';

  @override
  String get technologyAndResourcesDescription =>
      'Programu hii imejengwa kwa kutumia teknolojia za kisasa na nyenzo za kuaminika:';

  @override
  String get flutterFrameworkTitle => 'Mfumo wa Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Imejengwa na Flutter kwa ajili ya uzoefu mzuri, uliokusanywa asilia, wa majukwaa mbalimbali kutoka kwa msingi mmoja wa msimbo.';

  @override
  String get advancedAudioEngineTitle => 'Injini ya Sauti ya Hali ya Juu';

  @override
  String get advancedAudioEngineDescription =>
      'Inaendeshwa na vifurushi vya Flutter `just_audio` na `just_audio_background` kwa uchezaji na udhibiti thabiti wa sauti.';

  @override
  String get reliableQuranDataTitle => 'Data ya Kuaminika ya Qur\'ani';

  @override
  String get reliableQuranDataDescription =>
      'Maandishi ya Al Qur\'an, tafsiri, tafsiri za kina, na sauti zinatokana na API za wazi zilizothibitishwa na hifadhidata kama Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Injini ya Nyakati za Swala';

  @override
  String get prayerTimeEngineDescription =>
      'Inatumia njia za kukokotoa zilizothibitishwa kwa nyakati sahihi za swala. Arifa zinashughulikiwa na `flutter_local_notifications` na kazi za chini kwa chini.';

  @override
  String get crossPlatformSupport => 'Usaidizi wa Majukwaa Mbalimbali';

  @override
  String get crossPlatformSupportDescription2 =>
      'Furahia ufikiaji usio na mshono kwenye majukwaa mbalimbali:';

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
      'Binafsi naahidi kutoa usaidizi na matengenezo endelevu kwa programu hii katika maisha yangu yote, In Sha Allah. Lengo langu ni kuhakikisha programu hii inabaki kuwa nyenzo yenye manufaa kwa Umma kwa miaka ijayo.';

  @override
  String get fajr => 'Alfajiri';

  @override
  String get sunrise => 'Macheo';

  @override
  String get dhuhr => 'Adhuhuri';

  @override
  String get asr => 'Alasiri';

  @override
  String get maghrib => 'Magharibi';

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
  String get sajdaAyah => 'Aya ya Sijda';

  @override
  String get required => 'Lazima';

  @override
  String get optional => 'Hiari';

  @override
  String get notificationScheduleWarning =>
      'Kumbuka: Arifa Iliyoratibiwa au Kikumbusho kinaweza kukosekana kwa sababu ya vizuizi vya mchakato wa usuli wa Mfumo wa Uendeshaji wa simu yako. Kwa mfano: Mfumo wa Uendeshaji wa Origin wa Vivo, One UI wa Samsung, ColorOS ya Oppo n.k. wakati mwingine huzima Arifa Iliyoratibiwa au Kikumbusho. Tafadhali angalia mipangilio ya Mfumo wako wa Uendeshaji ili kufanya programu isizuiliwe kutoka kwa mchakato wa usuli.';

  @override
  String get scrollWithRecitation => 'Tembeza na Kisomo';

  @override
  String get scrollWithRecitationDesc =>
      'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.';

  @override
  String get quickAccess => 'Ufikiaji wa Haraka';

  @override
  String get initiallyScrollAyah => 'Awali tembeza hadi kwenye ayah';

  @override
  String get tajweedGuide => 'Mwongozo wa Tajweed';

  @override
  String get configuration => 'Configuration';

  @override
  String get restoreFromBackup => 'Restore From Backup';

  @override
  String get history => 'History';

  @override
  String get search => 'Search';

  @override
  String get useAudioStream => 'Use Audio Stream';

  @override
  String get useAudioStreamDesc =>
      'Stream audio directly from the internet instead of downloading.';

  @override
  String get notUseAudioStreamDesc =>
      'Download audio for offline use and reduce data consumption.';

  @override
  String get audioSettings => 'Audio Settings';

  @override
  String get playbackSpeed => 'Playback Speed';

  @override
  String get playbackSpeedDesc => 'Adjust the speed of the Quran Recitation.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Please wait for the current download to finish.';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get checkYourInternetConnection => 'Check your internet connection.';
}
