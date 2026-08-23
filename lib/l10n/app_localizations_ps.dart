// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Pushto Pashto (`ps`).
class AppLocalizationsPs extends AppLocalizations {
  AppLocalizationsPs([String locale = 'ps']) : super(locale);

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
    return 'تفسیر د $ayahKey لپاره شتون نلري';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر به په : $anotherAyahLinkKey کې موندل شي';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'په $anotherAyahLinkKey ته ورشئ';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جز';

  @override
  String get page => 'پاڼه';

  @override
  String get ruku => 'رکوع';

  @override
  String get languageSettings => 'د ژبې ترتیبات';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count آیاتونه';
  }

  @override
  String get saveAndDownload => 'خوندي او ډاونلوډ کړئ';

  @override
  String get appLanguage => 'د اپلیکیشن ژبه';

  @override
  String get selectAppLanguage => 'د اپلیکیشن ژبه انتخاب کړئ...';

  @override
  String get pleaseSelectOne => 'مهرباني وکړئ یو انتخاب کړئ';

  @override
  String get quranTranslationLanguage => 'د قرآن ژباړې ژبه';

  @override
  String get selectTranslationLanguage => 'د ژباړې ژبه انتخاب کړئ...';

  @override
  String get quranTranslationBook => 'د قرآن ژباړې کتاب';

  @override
  String get selectTranslationBook => 'د ژباړې کتاب انتخاب کړئ...';

  @override
  String get quranTafsirLanguage => 'د قرآن تفسیر ژبه';

  @override
  String get selectTafsirLanguage => 'د تفسیر ژبه انتخاب کړئ...';

  @override
  String get quranTafsirBook => 'د قرآن تفسیر کتاب';

  @override
  String get selectTafsirBook => 'د تفسیر کتاب انتخاب کړئ...';

  @override
  String get quranScriptAndStyle => 'د قرآن لیک او سټایل';

  @override
  String get justAMoment => 'یو شیبه...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'کامیابي';

  @override
  String get retry => 'بیا هڅه کړئ';

  @override
  String get unableToDownloadResources =>
      'وسایل ډاونلوډ نشي...\nیو څه غلطي شوې ده';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'د قرآن تقسیم شوي تلاوت ډاونلوډ کول';

  @override
  String get processingSegmentedQuranRecitation =>
      'د قرآن تقسیم شوي تلاوت پروسس کول';

  @override
  String get footnote => 'فوټ نوټ';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'کلمه په کلمه';

  @override
  String get pleaseSelectRequiredOption =>
      'مهرباني وکړئ اړین انتخاب انتخاب کړئ';

  @override
  String get rememberHomeTab => 'د کور ټیب په یاد وساتئ';

  @override
  String get rememberHomeTabSubtitle =>
      'اپلیکیشن به د کور سکرین کې وروستي خلاص شوي ټیب په یاد وساتي.';

  @override
  String get wakeLock => 'ویک لاک';

  @override
  String get wakeLockSubtitle => 'د سکرین اتومات بندیدو مخنیوی وکړئ.';

  @override
  String get settings => 'ترتیبات';

  @override
  String get appTheme => 'د اپلیکیشن تم';

  @override
  String get quranStyle => 'د قرآن سټایل';

  @override
  String get changeTheme => 'تم بدل کړئ';

  @override
  String get verseCount => 'د آیتونو شمیر: ';

  @override
  String get translation => 'ژباړه';

  @override
  String get tafsirNotFound => 'نشتون';

  @override
  String get moreInfo => 'نور معلومات';

  @override
  String get playAudio => 'آډیو پلی کړئ';

  @override
  String get preview => 'پریویو';

  @override
  String get loading => 'لوډینګ...';

  @override
  String get errorFetchingAddress => 'پته ترلاسه کولو کې غلطي';

  @override
  String get addressNotAvailable => 'پته شتون نلري';

  @override
  String get latitude => 'عرض البلد: ';

  @override
  String get longitude => 'طول البلد: ';

  @override
  String get name => 'نوم: ';

  @override
  String get location => 'ځای: ';

  @override
  String get parameters => 'پارامیټرونه: ';

  @override
  String get selectCalculationMethod => 'د محاسبې میتود انتخاب کړئ';

  @override
  String get shareSelectAyahs => 'انتخاب شوي آیاتونه شریک کړئ';

  @override
  String get selectionEmpty => 'انتخاب خالي دی';

  @override
  String get generatingImagePleaseWait =>
      'انځور جوړول... مهرباني وکړئ انتظار وکړئ';

  @override
  String get asImage => 'د انځور په توګه';

  @override
  String get asText => 'د متن په توګه';

  @override
  String get playFromSelectedAyah => 'د انتخاب شوي آیت څخه پلی کړئ';

  @override
  String get toTafsir => 'تفسیر ته';

  @override
  String get selectAyah => 'آیت انتخاب کړئ';

  @override
  String get toAyah => 'آیت ته';

  @override
  String get searchForASurah => 'یو سوره لټون کړئ';

  @override
  String get bugReportTitle => 'د بګ راپور';

  @override
  String get audioCached => 'آډیو کیچ شوی';

  @override
  String get others => 'نور';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن|ژباړه|آیت، یو باید فعال شي';

  @override
  String get quranFontSize => 'د قرآن فونټ اندازه';

  @override
  String get quranLineHeight => 'د قرآن لاین لوړوالی';

  @override
  String get translationAndTafsirFontSize => 'ژباړه او تفسیر فونټ اندازه';

  @override
  String get quranAyah => 'د قرآن آیت';

  @override
  String get topToolbar => 'پورته ټولبار';

  @override
  String get keepOpenWordByWord => 'کلمه په کلمه خلاص وساتئ';

  @override
  String get wordByWordHighlight => 'کلمه په کلمه روښانه کول';

  @override
  String get quranScriptSettings => 'د قرآن لیک ترتیبات';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'پاڼه: ';

  @override
  String get quranResources => 'د قرآن وسایل';

  @override
  String alreadySelected(String name) {
    return 'ژبه \'$name\' لا دمخه انتخاب شوې ده.';
  }

  @override
  String get unableToGetCompassData => 'کمپس ډاټا ترلاسه کولو کې ناکامي';

  @override
  String get deviceDoesNotHaveSensors => 'وسیله سینسرونه نلري !';

  @override
  String get north => 'شمال';

  @override
  String get east => 'ختیځ';

  @override
  String get south => 'جنوب';

  @override
  String get west => 'لویدیځ';

  @override
  String get address => 'پته: ';

  @override
  String get change => 'بدلون';

  @override
  String get calculationMethod => 'د محاسبې میتود: ';

  @override
  String get downloadPrayerTime => 'د لمانځه وخت ډاونلوډ کړئ';

  @override
  String get calculationMethodsListEmpty => 'د محاسبې میتودونو لیست خالي دی.';

  @override
  String get noCalculationMethodWithLocationData =>
      'د ځای ډاټا سره هیڅ محاسبه میتود ونه موندل شو.';

  @override
  String get prayerSettings => 'د لمانځه ترتیبات';

  @override
  String get reminderSettings => 'د یادونې ترتیبات';

  @override
  String get adjustReminderTime => 'د یادونې وخت تنظیم کړئ';

  @override
  String get enforceAlarmSound => 'د الارم غږ پلي کړئ';

  @override
  String get enforceAlarmSoundDescription =>
      'که فعال شي، دا فیچر به الارم په دلته سیټ شوي حجم کې پلی کړي، حتی که ستاسو د تلیفون غږ کم وي. دا ډاډ ورکوي چې تاسو د کم تلیفون حجم له امله الارم له لاسه ورنکړئ.';

  @override
  String get volume => 'حجم';

  @override
  String get atPrayerTime => 'د لمانځه په وخت کې';

  @override
  String minBefore(int minutes) {
    return '$minutes دقیقې مخکې';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes دقیقې وروسته';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName په $prayerTime کې دی';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'دا د $prayerName وخت دی';
  }

  @override
  String get stopTheAdhan => 'اذان بند کړئ';

  @override
  String dateFoundEmpty(String date) {
    return '$date خالي موندل شوی';
  }

  @override
  String get today => 'نن';

  @override
  String get left => 'پاتې';

  @override
  String reminderAdded(String prayerName) {
    return 'د $prayerName لپاره یادونه اضافه شوه';
  }

  @override
  String get allowNotificationPermission =>
      'مهرباني وکړئ د دې فیچر کارولو لپاره نوټیفیکیشن اجازه ورکړئ';

  @override
  String reminderRemoved(String prayerName) {
    return 'د $prayerName لپاره یادونه لرې شوه';
  }

  @override
  String get getPrayerTimesAndQibla => 'د لمانځه وختونه او قبلې ترلاسه کړئ';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'د هر ځای لپاره د لمانځه وختونه او قبله محاسبه کړئ.';

  @override
  String get getFromGPS => 'د GPS څخه ترلاسه کړئ';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'خپل ښار انتخاب کړئ';

  @override
  String get noteAboutGPS =>
      'یادونه: که تاسو GPS کارول نه غواړئ یا خوندي احساس نه کوئ، تاسو کولی شئ خپل ښار انتخاب کړئ.';

  @override
  String get downloadingLocationResources => 'د ځای وسایل ډاونلوډ کول...';

  @override
  String get somethingWentWrong => 'یو څه غلطي شوې ده';

  @override
  String get selectYourCountry => 'خپل هیواد انتخاب کړئ';

  @override
  String get searchForACountry => 'یو هیواد لټون کړئ';

  @override
  String get selectYourAdministrator => 'خپل اداري انتخاب کړئ';

  @override
  String get searchForAnAdministrator => 'یو اداري لټون کړئ';

  @override
  String get searchForACity => 'یو ښار لټون کړئ';

  @override
  String get pleaseEnableLocationService => 'مهرباني وکړئ د ځای خدمت فعال کړئ';

  @override
  String get donateUs => 'موږ ته مرسته وکړئ';

  @override
  String get underDevelopment => 'په پراختیا کې';

  @override
  String get versionLoading => 'لوډینګ...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'اصلي مینو';

  @override
  String get notes => 'یادونې';

  @override
  String get pinned => 'پن شوی';

  @override
  String get jumpToAyah => 'آیت ته ورشئ';

  @override
  String get shareMultipleAyah => 'څو آیاتونه شریک کړئ';

  @override
  String get shareThisApp => 'دا اپلیکیشن شریک کړئ';

  @override
  String get giveRating => 'ریټینګ ورکړئ';

  @override
  String get bugReport => 'د بګ راپور';

  @override
  String get privacyPolicy => 'د محرمیت پالیسي';

  @override
  String get aboutTheApp => 'د اپلیکیشن په اړه';

  @override
  String get resetTheApp => 'اپلیکیشن ریسیټ کړئ';

  @override
  String get resetAppWarningTitle => 'د اپلیکیشن ډاټا ریسیټ کړئ';

  @override
  String get resetAppWarningMessage =>
      'ایا تاسو ډاډه یاست چې اپلیکیشن ریسیټ کړئ؟ ستاسو ټول ډاټا به له لاسه ورکړل شي، او تاسو به د اپلیکیشن له پیل څخه تنظیم کړئ.';

  @override
  String get cancel => 'لغوه کړئ';

  @override
  String get reset => 'ریسیټ';

  @override
  String get shareAppSubject => 'دا القرآن اپلیکیشن وګورئ!';

  @override
  String shareAppBody(String appLink) {
    return 'اسلام علیکم! دا القرآن اپلیکیشن د ورځني لوستلو او تفکر لپاره وګورئ. دا د الله له کلماتو سره د نښلولو مرسته کوي. دلته ډاونلوډ کړئ: $appLink';
  }

  @override
  String get openDrawerTooltip => 'دراور خلاص کړئ';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'لمانځه';

  @override
  String get qibla => 'قبله';

  @override
  String get audio => 'آډیو';

  @override
  String get surah => 'سوره';

  @override
  String get pages => 'پاڼې';

  @override
  String get note => 'یادونه:';

  @override
  String get linkedAyahs => 'نښلول شوي آیاتونه:';

  @override
  String get emptyNoteCollection =>
      'دا یادونې مجموعه خالي ده.\nځینې یادونې اضافه کړئ چې دلته یې وګورئ.';

  @override
  String get emptyPinnedCollection =>
      'هیڅ آیاتونه دا مجموعه ته پن شوي ندي.\nآیاتونه پن کړئ چې دلته یې وګورئ.';

  @override
  String get noContentAvailable => 'هیڅ منځپانګه شتون نلري.';

  @override
  String failedToLoadCollections(String error) {
    return 'مجموعې لوډ کولو کې ناکامي: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'د $collectionType نوم په واسطه لټون کړئ...';
  }

  @override
  String get sortBy => 'په واسطه ترتیب کړئ';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'هیڅ $collectionType لا اضافه شوې نده';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count پن شوي توکي';
  }

  @override
  String notesCount(int count) {
    return '$count یادونې';
  }

  @override
  String get emptyNameNotAllowed => 'خالي نوم اجازه نلري';

  @override
  String updatedTo(String collectionName) {
    return 'ته تازه شو: $collectionName';
  }

  @override
  String get changeName => 'نوم بدل کړئ';

  @override
  String get changeColor => 'رنګ بدل کړئ';

  @override
  String get colorUpdated => 'رنګ تازه شو';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ړنګ شو';
  }

  @override
  String get delete => 'ړنګ کړئ';

  @override
  String get save => 'ذخیره کړئ';

  @override
  String get collectionNameCannotBeEmpty => 'د مجموعې نوم خالي نشي کیدی.';

  @override
  String get addedNewCollection => 'نوې مجموعه اضافه شوه';

  @override
  String ayahCount(int count) {
    return '$count آیت';
  }

  @override
  String get byNameAtoZ => 'نوم A-Z';

  @override
  String get byNameZtoA => 'نوم Z-A';

  @override
  String get byElementNumberAscending => 'د عنصر شمیر زیاتیدونکی';

  @override
  String get byElementNumberDescending => 'د عنصر شمیر کمیدونکی';

  @override
  String get byUpdateDateAscending => 'د تازه کیدو نیټه زیاتیدونکې';

  @override
  String get byUpdateDateDescending => 'د تازه کیدو نیټه کمیدونکې';

  @override
  String get byCreateDateAscending => 'د جوړیدو نیټه زیاتیدونکې';

  @override
  String get byCreateDateDescending => 'د جوړیدو نیټه کمیدونکې';

  @override
  String get translationNotFound => 'ژباړه ونه موندل شوه';

  @override
  String get translationTitle => 'ژباړه:';

  @override
  String get footNoteTitle => 'فوټ نوټ:';

  @override
  String get wordByWordTranslation => 'کلمه په کلمه ژباړه:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'شریک کړئ';

  @override
  String get addNoteButton => 'یادونه اضافه کړئ';

  @override
  String get pinToCollectionButton => 'مجموعې ته پن کړئ';

  @override
  String get shareAsText => 'د متن په توګه شریک کړئ';

  @override
  String get copiedWithTafsir => 'د تفسیر سره کاپي شو';

  @override
  String get shareAsImage => 'د انځور په توګه شریک کړئ';

  @override
  String get shareWithTafsir => 'د تفسیر سره شریک کړئ';

  @override
  String get notFound => 'ونه موندل شو';

  @override
  String get noteContentCannotBeEmpty => 'د یادونې منځپانګه خالي نشي کیدی.';

  @override
  String get noteSavedSuccessfully => 'یادونه په بریالیتوب سره ذخیره شوه!';

  @override
  String get selectCollections => 'مجموعې انتخاب کړئ';

  @override
  String get addNote => 'یادونه اضافه کړئ';

  @override
  String get writeCollectionName => 'د مجموعې نوم ولیکئ...';

  @override
  String get noCollectionsYetAddANewOne => 'لا مجموعې نشته. نوې اضافه کړئ!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'مهرباني وکړئ لومړی خپله یادونه ولیکئ.';

  @override
  String get noCollectionSelected => 'هیڅ مجموعه انتخاب شوې نده';

  @override
  String get saveNote => 'یادونه ذخیره کړئ';

  @override
  String get nextSelectCollections => 'بل: مجموعې انتخاب کړئ';

  @override
  String get addToPinned => 'پن شوي ته اضافه کړئ';

  @override
  String get pinnedSavedSuccessfully => 'پن په بریالیتوب سره ذخیره شو!';

  @override
  String get savePinned => 'پن ذخیره کړئ';

  @override
  String get closeAudioController => 'آډیو کنټرولر بند کړئ';

  @override
  String get previous => 'مخکینی';

  @override
  String get rewind => 'شاته کړئ';

  @override
  String get fastForward => 'مخکې کړئ';

  @override
  String get playNextAyah => 'بل آیت پلی کړئ';

  @override
  String get repeat => 'تکرار';

  @override
  String get playAsPlaylist => 'د پلې لیست په توګه پلی کړئ';

  @override
  String style(String style) {
    return 'سټایل: $style';
  }

  @override
  String get stopAndClose => 'بند کړئ او بند کړئ';

  @override
  String get play => 'پلی';

  @override
  String get pause => 'پاز';

  @override
  String get selectReciter => 'قاري انتخاب کړئ';

  @override
  String source(String source) {
    return 'سرچینه: $source';
  }

  @override
  String get newText => 'نوی';

  @override
  String get more => 'نور: ';

  @override
  String get cacheNotFound => 'کیچ ونه موندل شو';

  @override
  String get cacheSize => 'کیچ اندازه';

  @override
  String error(String error) {
    return 'غلطي: $error';
  }

  @override
  String get clean => 'پاک کړئ';

  @override
  String get lastModified => 'وروستي بدلون';

  @override
  String get oneYearAgo => '1 کال مخکې';

  @override
  String monthsAgo(String number) {
    return '$number میاشتې مخکې';
  }

  @override
  String weeksAgo(String number) {
    return '$number اونۍ مخکې';
  }

  @override
  String daysAgo(String number) {
    return '$number ورځې مخکې';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour ساعتونه مخکې';
  }

  @override
  String get aboutAlQuran => 'د القرآن په اړه';

  @override
  String get appFullName => 'القرآن (تفسیر، لمانځه، قبله، آډیو)';

  @override
  String get appDescription =>
      'یو بشپړ اسلامي اپلیکیشن د Android، iOS، MacOS، ویب، Linux او Windows لپاره، چې د تفسیر او څو ژباړو سره قرآن لوستل وړاندې کوي (په شمول کلمه په کلمه)، په ټوله نړۍ کې د لمانځه وختونه د نوټیفیکیشنونو سره، د قبلې کمپاس، او همغږي کلمه په کلمه آډیو تلاوت.';

  @override
  String get dataSourcesNote =>
      'یادونه: د قرآن متنونه، تفسیر، ژباړې، او آډیو وسایل له Quran.com، Everyayah.com، او نورو تصدیق شوي خلاصو سرچینو څخه اخیستل شوي.';

  @override
  String get adFreePromise =>
      'دا اپلیکیشن د الله د رضایت لپاره جوړ شوی دی. له همدې امله، دا به تل بشپړ Ad-Free وي.';

  @override
  String get coreFeatures => 'اصلي فیچرونه';

  @override
  String get coreFeaturesDescription =>
      'د اصلي فعالیتونو لټون وکړئ چې Al Quran v3 ستاسو د ورځني اسلامي اعمالو لپاره یو اړین وسیله جوړوي:';

  @override
  String get prayerTimesTitle => 'د لمانځه وختونه او الرټونه';

  @override
  String get prayerTimesDescription =>
      'د هر ځای لپاره دقیق لمانځه وختونه د مختلفو محاسبې میتودونو په کارولو سره. د اذان نوټیفیکیشنونو سره یادونې سیټ کړئ.';

  @override
  String get qiblaDirectionTitle => 'د قبلې لار';

  @override
  String get qiblaDirectionDescription =>
      'د روښانه او دقیق کمپاس لید سره قبله په اسانۍ ومومئ.';

  @override
  String get translationTafsirTitle => 'د قرآن ژباړه او تفسیر';

  @override
  String get translationTafsirDescription =>
      'د 120+ ژباړې کتابونو (په شمول کلمه په کلمه) ته لاسرسی په 69 ژبو کې، او 30+ تفسیر کتابونه.';

  @override
  String get wordByWordAudioTitle => 'کلمه په کلمه آډیو او روښانه کول';

  @override
  String get wordByWordAudioDescription =>
      'د همغږي کلمه په کلمه آډیو تلاوت او روښانه کولو سره تعقیب کړئ د یو غوطه ور تجربه لپاره.';

  @override
  String get ayahAudioRecitationTitle => 'د آیت آډیو تلاوت';

  @override
  String get ayahAudioRecitationDescription =>
      'د 40+ مشهور قاریانو څخه بشپړ آیت تلاوتونه واورئ.';

  @override
  String get notesCloudBackupTitle => 'یادونې د کلاوډ بیک اپ سره';

  @override
  String get notesCloudBackupDescription =>
      'شخصي یادونې او تفکرات ذخیره کړئ، په خوندي ډول کلاوډ ته بیک اپ (فیچر په پراختیا کې/ژر راځي).';

  @override
  String get crossPlatformSupportTitle => 'کراس پلیټفارم ملاتړ';

  @override
  String get crossPlatformSupportDescription =>
      'په Android، ویب، Linux، او Windows کې ملاتړ شوی.';

  @override
  String get backgroundAudioPlaybackTitle => 'شاته آډیو پلی بیک';

  @override
  String get backgroundAudioPlaybackDescription =>
      'حتی کله چې اپلیکیشن په شاته کې وي، د قرآن تلاوت اوریدو ته دوام ورکړئ.';

  @override
  String get audioDataCachingTitle => 'آډیو او ډاټا کیچینګ';

  @override
  String get audioDataCachingDescription =>
      'د ښه پلی بیک او آفلاین قابلیتونو سره قوي آډیو او قرآن ډاټا کیچینګ.';

  @override
  String get minimalisticInterfaceTitle => 'مینیمالیستیک او پاک انټرفیس';

  @override
  String get minimalisticInterfaceDescription =>
      'د اسان نیویګیشن انټرفیس د کاروونکي تجربه او لوستلو تمرکز سره.';

  @override
  String get optimizedPerformanceTitle => 'بهینه شوې کارکردګي او اندازه';

  @override
  String get optimizedPerformanceDescription =>
      'یو فیچر بډایه اپلیکیشن چې لږ وزن او کارکردګي لپاره ډیزاین شوی.';

  @override
  String get languageSupport => 'د ژبې ملاتړ';

  @override
  String get languageSupportDescription =>
      'دا اپلیکیشن د نړیوال لیدونکو لپاره د لاسرسي لپاره ډیزاین شوی دی د لاندې ژبو ملاتړ سره (او نور په دوامداره توګه اضافه کیږي):';

  @override
  String get technologyAndResources => 'ټیکنالوژي او وسایل';

  @override
  String get technologyAndResourcesDescription =>
      'دا اپلیکیشن د پرمختللي ټیکنالوژیو او معتبر وسایلو په کارولو جوړ شوی دی:';

  @override
  String get flutterFrameworkTitle => 'فلوټر فریم ورک';

  @override
  String get flutterFrameworkDescription =>
      'د فلوټر سره جوړ شوی د یو ښکلي، په اصلي توګه کمپایل شوي، څو پلیټفارم تجربه لپاره د یوې واحد کوډ بیس څخه.';

  @override
  String get advancedAudioEngineTitle => 'پرمختللی آډیو انجن';

  @override
  String get advancedAudioEngineDescription =>
      'د `just_audio` او `just_audio_background` فلوټر پیکیجونو په واسطه ځواکمن شوی د قوي آډیو پلی بیک او کنټرول لپاره.';

  @override
  String get reliableQuranDataTitle => 'معتبر قرآن ډاټا';

  @override
  String get reliableQuranDataDescription =>
      'د القرآن متنونه، ژباړې، تفسیرونه، او آډیو له تصدیق شوي خلاصو APIs او ډاټابیسونو لکه Quran.com او Everyayah.com څخه اخیستل شوي.';

  @override
  String get prayerTimeEngineTitle => 'د لمانځه وخت انجن';

  @override
  String get prayerTimeEngineDescription =>
      'د دقیق لمانځه وختونو لپاره تاسیس شوي محاسبې میتودونه کاروي. نوټیفیکیشنونه د `flutter_local_notifications` او شاته کارونو په واسطه اداره کیږي.';

  @override
  String get crossPlatformSupport => 'کراس پلیټفارم ملاتړ';

  @override
  String get crossPlatformSupportDescription2 =>
      'په مختلفو پلیټفارمونو کې بې سیمه لاسرسی خوند واخلئ:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'ویب';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'زموږ د ژوند وعدې';

  @override
  String get lifetimePromiseDescription =>
      'زه شخصاً وعده کوم چې د دې اپلیکیشن لپاره دوامداره ملاتړ او ساتنه ورکړم په ټول ژوند کې، ان شاء الله. زما هدف دا دی چې دا اپلیکیشن د امت لپاره د کلونو لپاره یو ګټور وسیله پاتې شي.';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'لمر ختو';

  @override
  String get noon => 'ماسپښین';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get sunset => 'لمر لوېدل';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشا';

  @override
  String get midnight => 'نیمه شپه';

  @override
  String get alarm => 'الارم';

  @override
  String get notification => 'نوټیفیکیشن';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea، $administrativeArea، $country';
  }

  @override
  String get quranScriptTajweed => 'تجوید';

  @override
  String get quranScriptUthmani => 'عثماني';

  @override
  String get quranScriptIndopak => 'انډوپاک';

  @override
  String get sajdaAyah => 'سجده آیت';

  @override
  String get required => 'اړین';

  @override
  String get optional => 'اختیاري';

  @override
  String get notificationScheduleWarning =>
      'یادونه: زمانه شوې نوټیفیکیشن یا یادونه کولی شي د ستاسو د تلیفون OS شاته پروسې محدودیتونو له امله له لاسه ورکړل شي. د مثال په توګه: Vivo\'s Origin OS، Samsung\'s One UI، Oppo\'s ColorOS وغیره ځینې وختونه زمانه شوې نوټیفیکیشن یا یادونه وژني. مهرباني وکړئ خپل OS ترتیبات وګورئ چې اپلیکیشن د شاته پروسې څخه محدود نشي.';

  @override
  String get scrollWithRecitation => 'د تلاوت سره سکرول';

  @override
  String get quickAccess => 'ژر لاسرسی';

  @override
  String get initiallyScrollAyah => 'لومړی آیت ته سکرول';

  @override
  String get tajweedGuide => 'تجوید لارښود';

  @override
  String get scrollWithRecitationDesc =>
      'کله چې فعال شي، د قرآن آیت به اتومات په آډیو تلاوت سره همغږي سکرول شي.';

  @override
  String get configuration => 'تنظیم';

  @override
  String get restoreFromBackup => 'د بیک اپ څخه بحال کړئ';

  @override
  String get history => 'تاریخ';

  @override
  String get search => 'لټون';

  @override
  String get useAudioStream => 'آډیو سټریم کارول';

  @override
  String get useAudioStreamDesc =>
      'آډیو مستقیم له انټرنیټ څخه سټریم کړئ پر ځای چې ډاونلوډ کړئ.';

  @override
  String get notUseAudioStreamDesc =>
      'آډیو د آفلاین کارولو لپاره ډاونلوډ کړئ او د ډاټا مصرف کم کړئ.';

  @override
  String get audioSettings => 'آډیو ترتیبات';

  @override
  String get playbackSpeed => 'پلی بیک سرعت';

  @override
  String get playbackSpeedDesc => 'د قرآن تلاوت سرعت تنظیم کړئ.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'مهرباني وکړئ د اوسني ډاونلوډ پای ته انتظار وکړئ.';

  @override
  String get areYouSure => 'ایا تاسو ډاډه یاست؟';

  @override
  String get checkYourInternetConnection => 'خپل انټرنیټ اتصال وګورئ.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'اړتیا ده چې $requiredDownload د $totalVersesCount آیاتونو ډاونلوډ کړئ.';
  }

  @override
  String get download => 'ډاونلوډ';

  @override
  String get audioDownload => 'آډیو ډاونلوډ';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'د قرآن لیک بهینه کول';

  @override
  String get supportOnGithub => 'په GitHub ملاتړ وکړئ';

  @override
  String get forbiddenSalatTimes => 'د لمونځ منع شوي وختونه';

  @override
  String get prayerTimes => 'د لمونځ وختونه';

  @override
  String get hanafi => 'حنفي';

  @override
  String get shafie => 'شافعي';

  @override
  String get suhurEnd => 'د سحری پای';

  @override
  String get iftarStart => 'د افطار پیل';

  @override
  String get tahajjudStart => 'د تهجد پیل';

  @override
  String get tahajjud => 'تهجد';

  @override
  String get dhuha => 'ضحى';

  @override
  String get indopakFont => 'هندپاک فونټ';

  @override
  String get uthmaniFont => 'عثماني فونټ';

  @override
  String get close => 'بندول';

  @override
  String get goToSettings => 'تنظیماتو ته لاړ شئ';

  @override
  String get scriptSettingsUpdated => 'د ليکني تنظیمات تازه شول';

  @override
  String get scriptSettingsUpdatedDescription =>
      'موږ د ليکني انتخابونه ساده کړي او نور فونټونه مو اضافه کړي دي.';

  @override
  String get enterPageNumber => 'د ۱ او ۶۰۴ ترمنځ د پاڼې شمېره داخله کړئ';

  @override
  String get deleteMushafData => 'د مصحف ډیټا حذف کړئ';

  @override
  String get deleteMushafDataDescription =>
      'ایا تاسو ډاډه یاست چې غواړئ د مصحف ټول معلومات حذف کړئ؟';

  @override
  String get invalidPage => 'نامعتبره پاڼه (۱-۶۰۴)';

  @override
  String get goToPage => 'پاڼې ته لاړ شئ';

  @override
  String get resources => 'سرچینې';

  @override
  String get mushaf => 'مصحف';

  @override
  String get circleJojomInQuranScript =>
      'په قرآني رسم الخط کې د جزم/سکون دائره';

  @override
  String get copy => 'کاپي';

  @override
  String get share => 'شریکول';

  @override
  String get warningMessageOnIndopakTajweedEnable =>
      'موږ په ځینو فونټونو کې د انډوپاک تجوید رنګ کې د ښودلو ځینې ستونزې موندلې دي. نو، تاسو ممکن د سکریپټ رنګ ښودلو کې ناانډولي وګورئ. ایا تاسو ډاډه یاست چې تاسو غواړئ په انډوپاک کې تجوید پلي کړئ؟';

  @override
  String get apply => 'تطبیق کړئ';

  @override
  String get warning => 'خبرداری';

  @override
  String get hijri => 'هجري';

  @override
  String get gregorian => 'ګریګورین';

  @override
  String get prayerTimesCalender => 'د لمانځه وختونو کیلنڈر';

  @override
  String get allowLocation => 'موقعیت ته اجازه ورکړئ';

  @override
  String get allowLocationDescription =>
      'د لمانځه وختونه په اوتومات ډول تازه کوي.';

  @override
  String get manualLocation => 'لاسي موقعیت';

  @override
  String get manualLocationDescription =>
      'په لاسي ډول هیواد او ښار وټاکئ. که تاسو ښار بدل کړئ نو تاسو اړتیا لرئ موقعیت تازه کړئ.';

  @override
  String get selectLocation => 'موقعیت وټاکئ';

  @override
  String get selectCountry => 'هیواد وټاکئ';

  @override
  String get selectCity => 'ښار وټاکئ';

  @override
  String get sunRising => 'لمر ختل';

  @override
  String get sunSetting => 'لمر لوېدل';

  @override
  String get sunTopOfTheHead => 'لمر د سر په سر';

  @override
  String get salatTime => 'د لمانځه وخت';

  @override
  String get forbiddenSalatTime => 'د لمانځه منع شوی وخت';

  @override
  String get translationDatabase => 'د ژباړې ډیټابیس';

  @override
  String get translationDatabaseSubtitle => 'د ټاکل شوې ژباړې متن ډاونلوډ کیږي';

  @override
  String get tafsirCommentary => 'د قرآن تفسير';

  @override
  String get tafsirCommentarySubtitle => 'د تفسیر سرچینې چمتو کیږي';

  @override
  String get wordByWordAnalysis => 'کلمه په کلمه تحلیل';

  @override
  String get wordByWordAnalysisSubtitle => 'د لغتونو جلا کول تنظیمول';

  @override
  String get audioRecitationSegments => 'د غږیز تلاوت برخې';

  @override
  String get audioRecitationSegmentsSubtitle => 'د ایتونو د وخت برخې تنظیمول';

  @override
  String get locationQiblaMetadata => 'د موقعیت او قبلې میټاډاټا';

  @override
  String get locationQiblaMetadataSubtitle =>
      'د نړۍ د ښارونو د موقعیت ډیټا ډاونلوډ کیږي';

  @override
  String get preparingResources => 'سرچینې چمتو کیږي...';

  @override
  String get setupCompletedOpeningQuran => 'ترتیب بشپړ شو! القرآن خلاصیږي...';

  @override
  String get unexpectedErrorSetup =>
      'د ترتیب په جریان کې ناڅاپي تېروتنه رامنځته شوه.';

  @override
  String get heading => 'لارښود';

  @override
  String get alignedWithKaaba => 'له کعبې سره برابر شوی';

  @override
  String turnRight(Object degrees) {
    return '$degrees° ښي لور ته وګرځئ';
  }

  @override
  String turnLeft(Object degrees) {
    return '$degrees° چپې لور ته وګرځئ';
  }

  @override
  String get streamingAndNetwork => 'سټریمینګ او شبکه';

  @override
  String get next => 'راتلونکی';

  @override
  String get now => 'اوس';

  @override
  String get current => 'اوسنی';

  @override
  String get active => 'فعال';

  @override
  String get activeNow => 'اوس فعال';

  @override
  String get hours => 'ساعتونه';

  @override
  String get minutes => 'دقیقې';

  @override
  String get seconds => 'ثانیې';

  @override
  String get fastingAndVoluntaryTimes => 'د روژې او نفلو وختونه';

  @override
  String get imsak => 'امساک';

  @override
  String get ishraqAndDuha => 'اشراق او چاشت';

  @override
  String get lastThirdOfNight => 'د شپې وروستۍ دریمه برخه';

  @override
  String get awqatAlNahy => 'د لمانځه د منعې وختونه';

  @override
  String get forbiddenSunriseDescription =>
      'د لمر ختو څخه تر هغه چې د یوې نېزې په اندازه پورته شي (~۱۵ دقیقې)';

  @override
  String get forbiddenNoonDescription =>
      'کله چې لمر په سر کې وي تر څو چې زوال وکړي (~۸ دقیقې)';

  @override
  String get forbiddenSunsetDescription =>
      'د لمر له ژړېدو څخه تر بشپړ ډوبېدو پورې (~۱۵ دقیقې)';

  @override
  String get forbiddenTimesHadith =>
      'According to authentic Hadith in Sahih Muslim (832), \'Uqbah ibn \'Amir al-Juhani said:\n\n\"There are three times at which the Messenger of Allah (peace and blessings be upon him) forbade us to pray or to bury our dead:\n1. When the sun begins to rise until it is fully risen (~15 mins after sunrise).\n2. When the sun is at its height at midday until it has passed the meridian (~8-10 mins before Dhuhr).\n3. When the sun begins to set until it has completely set (~15 mins before Maghrib).\"';

  @override
  String get readMoreOnIslamQA => 'په IslamQA کې بشپړه فتوی ولولئ';

  @override
  String get asrJurisprudence => 'د عصر فقهي مسلک (مذهب)';

  @override
  String get shafieDescription => 'معیاري (شافعي، مالکي، حنبلي)';

  @override
  String get hanafiDescription => 'حنفي مذهب';

  @override
  String get shafieShadow => 'معیاري (سیوری ۱ چنده)';

  @override
  String get hanafiShadow => 'حنفي (سیوری ۲ چنده)';

  @override
  String get calculationAndJurisprudence => 'حساب او فقه';

  @override
  String get notificationsAndAudio => 'خبرتیاوې او غږ';

  @override
  String get enablePrayerReminders => 'د لمانځه یادونه فعاله کړئ';

  @override
  String get enablePrayerRemindersDescription =>
      'د ټولو راتلونکو لمونځونو د وخت لپاره خبرتیا ترلاسه کړئ.';

  @override
  String get adjustReminderTimingDescription =>
      'د لمانځه له اصلي وخت څخه د یادونې وخت تنظیم کړئ (+/- دقیقې).';

  @override
  String get exactTime => 'پوره وخت';

  @override
  String actualTime(String time) {
    return 'اصلي وخت: $time';
  }

  @override
  String get jumpToToday => 'نن ورځې ته لاړ شئ';

  @override
  String get dateAndHijri => 'نېټه / هجري';

  @override
  String get selectedLocation => 'ټاکل شوی ځای';

  @override
  String nextPrayerLabel(String prayerName) {
    return 'راتلونکی: $prayerName';
  }

  @override
  String currentPrayerLabel(String prayerName) {
    return 'اوس: $prayerName';
  }

  @override
  String startsAt(String prayerName, String time) {
    return '$prayerName په $time پیل کیږي';
  }

  @override
  String get continueReading => 'لوستلو ته دوام ورکړئ';

  @override
  String get lastRead => 'وروستی لوستل شوی';

  @override
  String get resume => 'بیا پیل کړئ';

  @override
  String get startReading => 'لوستل پیل کړئ';

  @override
  String get verses => 'آیاتونه';

  @override
  String get ayah => 'آیت';

  @override
  String get edit => 'سمون';

  @override
  String get searchAll => 'ټول';

  @override
  String get searchArabic => 'عربي';

  @override
  String get searchQuranHint => 'Search Quran, Surah, 2:255, Translation...';

  @override
  String get searchFiltersAndOptions => 'Search Filters & Options';

  @override
  String get exactPhrase => 'کټ مټ عبارت';

  @override
  String surahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سورتونه وموندل شول',
      one: '1 سورت وموندل شو',
    );
    return '$_temp0';
  }

  @override
  String ayahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آیاتونه وموندل شول',
      one: '1 آیت وموندل شو',
    );
    return '$_temp0';
  }

  @override
  String noMatchingSurahs(String query) {
    return 'No Surahs matching \"$query\"';
  }

  @override
  String get noResultsFound => 'No results found';

  @override
  String get trySearchingFor =>
      'Try searching for a Surah name, verse number (e.g. 2:255), or topics';

  @override
  String allSurahsCount(int count) {
    return 'All Surahs ($count)';
  }

  @override
  String activeShortcutsCount(int count) {
    return 'Active Shortcuts ($count)';
  }

  @override
  String get noActiveShortcuts => 'No active shortcuts found';

  @override
  String get customize => 'دودیز کړئ';

  @override
  String get bismillahPreview => 'د بسم الله مخکتنه';

  @override
  String get tajweedRules => 'د تجوید قواعد';

  @override
  String get makki => 'مکي';

  @override
  String get madani => 'مدني';

  @override
  String get exactPhraseMatch => 'د کټ مټ عبارت مطابقت';

  @override
  String get matchExactWordsDesc => 'په پرله پسې ترتیب کې دقیق ټکي مطابقت کړئ';

  @override
  String get filterBySurah => 'د سورت له مخې فلټر کړئ';

  @override
  String get all114SurahsEntireQuran => 'ټول ۱۱۴ سورتونه (بشپړ قرآن)';

  @override
  String get revelationType => 'د نزول ډول';

  @override
  String get searchInTranslations => 'په ژباړو کې لټون وکړئ';

  @override
  String get searchInTafsirs => 'په تفاسیرو کې لټون وکړئ';

  @override
  String activeCount(int selected, int total) {
    return '$selected/$total فعال';
  }

  @override
  String get recentSearches => 'وروستي لټونونه';

  @override
  String get clearAll => 'ټول پاک کړئ';

  @override
  String get searchGuideTitle => 'په سپېڅلي قرآن کې لټون وکړئ';

  @override
  String get searchGuideDescription =>
      'د سورت نوم، د آیت شمېره (لکه 2:255)، یا په ژباړو او تفاسیرو کې د کلمو له مخې لټون وکړئ.';

  @override
  String get madani15Line => '۱۵ کرښې مدني';

  @override
  String get totalPagesCount => '۶۰۴ مخونه';

  @override
  String get wordAudio => 'د ټکو غږ';

  @override
  String get offlineReady => 'آفلاین چمتو';

  @override
  String get vectorFonts => 'ویکتور فونټونه';

  @override
  String get madaniMushafLayout => 'د مدني مصحف بڼه';

  @override
  String get kfgqpcDescription => 'د پاچا فهد د قرآن چاپونې کمپلیکس (V4)';

  @override
  String get downloadingMushafPackage => 'د مصحف کڅوړه ډاونلوډ کیږي...';

  @override
  String get extractingAndInstallingData => 'ډاټا استخراج او انسټال کیږي...';

  @override
  String get settingUpOfflinePages => 'آفلاین مخونه تنظیم کیږي...';

  @override
  String get fetchingLayoutArchive => 'د بڼې آرشیف ترلاسه کیږي...';

  @override
  String get keepAppOpenDuringDownload =>
      'مهرباني وکړئ د ډاونلوډ بشپړیدو پورې اپلیکیشن خلاص وساتئ.';

  @override
  String get downloadFailed => 'ډاونلوډ ناکام شو';

  @override
  String get retryDownload => 'بیا ډاونلوډ هڅه وکړئ';

  @override
  String get packageSize => 'د کڅوړې اندازه';

  @override
  String get loadingMushafPage => 'د مصحف مخ بار کیږي...';

  @override
  String get quickPageJump => 'ژر مخ ته تلل';

  @override
  String get searchSurahHint => 'د نوم یا شمېرې له مخې سورت ولټوئ...';

  @override
  String get fullscreen => 'بشپړ سکرین';

  @override
  String get back => 'شاته';

  @override
  String get script => 'لیک';

  @override
  String get muted => 'بې غږه';

  @override
  String get alerts => 'خبرتیاوې';

  @override
  String get off => 'بند';

  @override
  String get on => 'روښانه';

  @override
  String get homeAndLockWidgets => 'د کور او لاک سکرین ویجټونه';

  @override
  String get glanceableWidgets => 'په یوه نظر کې ویجټونه';

  @override
  String get glanceableWidgetsDesc =>
      'د خپل کور او لاک سکرین پر مخ ورځني آیتونه او د لمانځه وختونه وښایاست.';

  @override
  String get ayahWidgetDisplayMode => 'د آیت ویجټ ښودلو حالت';

  @override
  String get dailyInspiringAyah => 'ورځنی الهام بخښونکی آیت (غوره شوی)';

  @override
  String get dailyInspiringAyahDesc =>
      'هره ورځ په نیمه شپه کې له ۳۶۵ څخه زیاتو غوره شویو آیتونو سره بدلیږي.';

  @override
  String get lastReadAyah => 'وروستی لوستل شوی آیت';

  @override
  String get lastReadAyahDesc =>
      'په یو ټک سره لوستلو ته دوام ورکولو لپاره ستاسو د وروستي لوستلو موقعیت سره همغږي کیږي.';

  @override
  String get pinnedCustomVerse => 'ټاکل شوی ځانګړی آیت';

  @override
  String get randomDailyAyah => 'تصادفي ورځنی آیت';

  @override
  String get randomDailyAyahDesc =>
      'د نوي فکر او تدبر لپاره هره ورځ یو تصادفي آیت غوره کوي.';

  @override
  String get updateAllWidgetsNow => 'همدا اوس ټول ویجټونه تازه کړئ';

  @override
  String get widgetsUpdatedSuccessfully => 'ویجټونه په بریالیتوب سره تازه شول!';

  @override
  String get ayahPinnedToWidgets =>
      'آیت د کور او لاک سکرین ویجټونو ته وټاکل شو!';

  @override
  String get pinToWidgets => 'ویجټونو ته وټاکئ';

  @override
  String get selectPinnedAyah => 'د ټاکلو لپاره آیت وټاکئ';

  @override
  String get saveAndApplyToWidget => 'خوندي کړئ او ویجټ ته یې پلي کړئ';

  @override
  String get howToAddWidgets => 'ویجټونه څنګه اضافه کړئ';

  @override
  String get customizeWidgetAyahAndPrayers =>
      'د ویجټ آیت او لمونځونه تنظیم کړئ';

  @override
  String get customizeWidgetAyahAndPrayersDesc =>
      'د ورځني غوره شوي، وروستي لوستل شوي، یا ټاکل شوي ځانګړي آیتونو ترمنځ وټاکئ';

  @override
  String get accountAndSync => 'حساب او کلاوډ همغږي';

  @override
  String get signIn => 'ننوتل';

  @override
  String get signUp => 'حساب جوړ کړئ';

  @override
  String get signOut => 'وتل';

  @override
  String get deleteAccount => 'حساب او معلومات ړنګ کړئ';

  @override
  String get deleteAccountTitle => 'ایا حساب ړنګ کړئ؟';

  @override
  String get deleteAccountWarning =>
      'دا به ستاسو حساب او ستاسو ټول همغږي شوي نوټونه، بک مارکونه، او د لوستلو تاریخ د تل لپاره له کلاوډ څخه ړنګ کړي. دا عمل نشي بیرته کیدی.';

  @override
  String get deleteAccountConfirm => 'هو، ټول ړنګ کړئ';

  @override
  String get syncNow => 'همدا اوس همغږي کړئ';

  @override
  String get syncing => 'د همغږۍ په حال کې...';

  @override
  String get syncSuccess => 'معلومات په بریالیتوب سره همغږي شول!';

  @override
  String get syncFailed =>
      'همغږي ناکامه شوه. مهرباني وکړئ خپل د انټرنیټ اړیکه وګورئ.';

  @override
  String get googleSignIn => 'د ګوګل سره دوام ورکړئ';

  @override
  String get email => 'بریښنالیک پته';

  @override
  String get password => 'پټ نوم';

  @override
  String get fullName => 'بشپړ نوم';

  @override
  String get forgotPassword => 'پټ نوم مو هېر شوی؟';

  @override
  String get sendResetLink => 'د بیا تنظیم لینک واستوئ';

  @override
  String get resetPasswordEmailSent =>
      'د پټ نوم د بیا تنظیم لینک ستاسو بریښنالیک ته واستول شو!';

  @override
  String get continueAsGuest => 'د میلمه په توګه دوام ورکړئ';

  @override
  String get alreadyHaveAccount => 'ایا له وړاندې حساب لرئ؟ ننوځئ';

  @override
  String get dontHaveAccount => 'حساب نه لرئ؟ نوم لیکنه وکړئ';

  @override
  String get privacyPolicyNotice =>
      'د دوام ورکولو سره، تاسو زموږ د خدماتو شرایطو او د محرمیت پالیسۍ سره موافق یاست.';

  @override
  String get guestUser => 'میلمه کاروونکی';

  @override
  String get syncedCloudBackup => 'کلاوډ همغږي';

  @override
  String get syncedCloudBackupDesc =>
      'خپل نوټونه، پنونه او د لوستلو تاریخ په خپلو ټولو وسیلو کې همغږي وساتئ.';

  @override
  String get alHadith => 'الحدیث';

  @override
  String get hadithCompanion => 'ملګری';

  @override
  String get hadithCompanionDesc =>
      'صحیح البخاري، مسلم او د مستندو احادیثو ټولګې.';

  @override
  String get open => 'خلاصول';

  @override
  String get install => 'نصب کول';

  @override
  String get companionApps => 'ملګري اپلیکیشنونه';

  @override
  String get hadithCollectionsBrief => 'بخاري، مسلم او نور';

  @override
  String get explore => 'پلټنه';

  @override
  String get ourIslamicCompanionApps => 'زموږ اسلامي ملګري اپلیکیشنونه';

  @override
  String get ourIslamicCompanionAppsDesc =>
      'د مسلمان امت لپاره یوازې د الله تعالی د رضا (صدقه جاریه) لپاره په ۱۰۰٪ وړیا او له اعلاناتو پرته تجربه جوړ شوی.';
}
