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
  String get saveAndDownload => 'ذخیره کړئ او ډاونلوډ کړئ';

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
  String get change => 'بدل کړئ';

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
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

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
}
