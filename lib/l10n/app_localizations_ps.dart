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
    return 'د $ayahKey لپاره تفسیر شتون نلري';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر به په دې ځای کې وموندل شي: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey ته ورشئ';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جزء';

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
    return '$count آیتونه';
  }

  @override
  String get saveAndDownload => 'خوندي او ډاونلوډ کړئ';

  @override
  String get appLanguage => 'د اپلیکیشن ژبه';

  @override
  String get selectAppLanguage => 'د اپلیکیشن ژبه وټاکئ...';

  @override
  String get pleaseSelectOne => 'مهرباني وکړئ یو وټاکئ';

  @override
  String get quranTranslationLanguage => 'د قرآن د ژباړې ژبه';

  @override
  String get selectTranslationLanguage => 'د ژباړې ژبه وټاکئ...';

  @override
  String get quranTranslationBook => 'د قرآن د ژباړې کتاب';

  @override
  String get selectTranslationBook => 'د ژباړې کتاب وټاکئ...';

  @override
  String get quranTafsirLanguage => 'د قرآن د تفسیر ژبه';

  @override
  String get selectTafsirLanguage => 'د تفسیر ژبه وټاکئ...';

  @override
  String get quranTafsirBook => 'د قرآن د تفسیر کتاب';

  @override
  String get selectTafsirBook => 'د تفسیر کتاب وټاکئ...';

  @override
  String get quranScriptAndStyle => 'د قرآن خط او سټایل';

  @override
  String get justAMoment => 'یوه شیبه صبر...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'بریالی';

  @override
  String get retry => 'بیا هڅه وکړئ';

  @override
  String get unableToDownloadResources =>
      'د سرچینو په ډاونلوډ کولو کې پاتې راغی...\nیو څه ستونزه وشوه';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'د قرآن کریم ټوټه ټوټه تلاوت ډاونلوډ کیږي';

  @override
  String get processingSegmentedQuranRecitation =>
      'د قرآن کریم ټوټه ټوټه تلاوت پروسس کیږي';

  @override
  String get footnote => 'پای‌لیکنه';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'کلمه په کلمه';

  @override
  String get pleaseSelectRequiredOption => 'مهرباني وکړئ اړین انتخاب وکړئ';

  @override
  String get rememberHomeTab => 'اصلي ټب په یاد وساتئ';

  @override
  String get rememberHomeTabSubtitle =>
      'اپلیکیشن به په کور سکرین کې وروستی خلاص شوی ټب په یاد وساتي.';

  @override
  String get wakeLock => 'سکرین روښانه وساتئ';

  @override
  String get wakeLockSubtitle => 'د سکرین د اتوماتیک بندیدو مخه ونیسئ.';

  @override
  String get settings => 'ترتیبات';

  @override
  String get appTheme => 'د اپلیکیشن تھیم';

  @override
  String get quranStyle => 'د قرآن سټایل';

  @override
  String get changeTheme => 'تھیم بدل کړئ';

  @override
  String get verseCount => 'د آیتونو شمیر: ';

  @override
  String get translation => 'ژباړه';

  @override
  String get tafsirNotFound => 'پیدا نه شو';

  @override
  String get moreInfo => 'نور معلومات';

  @override
  String get playAudio => 'غږ پلی کړئ';

  @override
  String get preview => 'مخلیدنه';

  @override
  String get loading => 'بارول...';

  @override
  String get errorFetchingAddress => 'د پته په ترلاسه کولو کې تېروتنه';

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
  String get parameters => 'پیرامیټرونه: ';

  @override
  String get selectCalculationMethod => 'د محاسبې طریقه وټاکئ';

  @override
  String get shareSelectAyahs => 'ټاکل شوي آیتونه شریک کړئ';

  @override
  String get selectionEmpty => 'انتخاب خالي دی';

  @override
  String get generatingImagePleaseWait =>
      'انځور جوړیږي... مهرباني وکړئ انتظار وکړئ';

  @override
  String get asImage => 'د انځور په توګه';

  @override
  String get asText => 'د متن په توګه';

  @override
  String get playFromSelectedAyah => 'د ټاکل شوي آیت څخه پلی کړئ';

  @override
  String get toTafsir => 'تفسیر ته';

  @override
  String get selectAyah => 'آیت وټاکئ';

  @override
  String get toAyah => 'آیت ته';

  @override
  String get searchForASurah => 'د سورت لټون وکړئ';

  @override
  String get bugReportTitle => 'د بګ راپور';

  @override
  String get audioCached => 'غږ کیش شو';

  @override
  String get others => 'نور';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن|ژباړه|آیت، یو باید فعال وي';

  @override
  String get quranFontSize => 'د قرآن د فونټ اندازه';

  @override
  String get quranLineHeight => 'د قرآن د کرښې لوړوالی';

  @override
  String get translationAndTafsirFontSize => 'د ژباړې او تفسیر د فونټ اندازه';

  @override
  String get quranAyah => 'د قرآن آیت';

  @override
  String get topToolbar => 'پورتنی اوزارپټی';

  @override
  String get keepOpenWordByWord => 'کلمه په کلمه خلاص وساتئ';

  @override
  String get wordByWordHighlight => 'کلمه په کلمه روښانه کول';

  @override
  String get quranScriptSettings => 'د قرآن د خط ترتیبات';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'پاڼه: ';

  @override
  String get quranResources => 'د قرآن سرچینې';

  @override
  String alreadySelected(String name) {
    return 'د \'$name\' ژبه لا دمخه ټاکل شوې ده.';
  }

  @override
  String get unableToGetCompassData => 'د قطب نما ډیټا ترلاسه کولو توان نلري';

  @override
  String get deviceDoesNotHaveSensors => 'وسیله سینسرونه نلري!';

  @override
  String get north => 'ش';

  @override
  String get east => 'خ';

  @override
  String get south => 'ج';

  @override
  String get west => 'ل';

  @override
  String get address => 'پته: ';

  @override
  String get change => 'بدلون';

  @override
  String get calculationMethod => 'د محاسبې طریقه: ';

  @override
  String get downloadPrayerTime => 'د لمانځه وختونه ډاونلوډ کړئ';

  @override
  String get calculationMethodsListEmpty => 'د محاسبې میتودونو لیست خالي دی.';

  @override
  String get noCalculationMethodWithLocationData =>
      'د ځای ډیټا سره د محاسبې هیڅ طریقه ونه موندل شوه.';

  @override
  String get prayerSettings => 'د لمانځه ترتیبات';

  @override
  String get reminderSettings => 'د یادونې ترتیبات';

  @override
  String get adjustReminderTime => 'د یادونې وخت تنظیم کړئ';

  @override
  String get enforceAlarmSound => 'د الارم غږ مجبور کړئ';

  @override
  String get enforceAlarmSoundDescription =>
      'که فعال وي، دا فیچر به الارم په هغه حجم کې پلی کړي چې دلته ټاکل شوی، حتی که ستاسو د تلیفون غږ ټیټ وي. دا ډاډ ورکوي چې تاسو د ټیټ تلیفون حجم له امله الارم له لاسه ورنکړئ.';

  @override
  String get volume => 'غږ';

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
    return 'د $prayerName وخت $prayerTime دی';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'د $prayerName وخت دی';
  }

  @override
  String get stopTheAdhan => 'اذان ودروئ';

  @override
  String dateFoundEmpty(String date) {
    return '$date خالي وموندل شو';
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
      'مهرباني وکړئ د دې فیچر کارولو لپاره د خبرتیا اجازه ورکړئ';

  @override
  String reminderRemoved(String prayerName) {
    return 'د $prayerName لپاره یادونه لرې شوه';
  }

  @override
  String get getPrayerTimesAndQibla => 'د لمانځه وختونه او قبله ترلاسه کړئ';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'د هر ورکړل شوي ځای لپاره د لمانځه وختونه او قبله محاسبه کړئ.';

  @override
  String get getFromGPS => 'له GPS څخه ترلاسه کړئ';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'خپل ښار وټاکئ';

  @override
  String get noteAboutGPS =>
      'یادونه: که تاسو نه غواړئ GPS وکاروئ یا خوندي احساس نه کوئ، تاسو کولی شئ خپل ښار وټاکئ.';

  @override
  String get downloadingLocationResources => 'د ځای سرچینې ډاونلوډ کیږي...';

  @override
  String get somethingWentWrong => 'یو څه ستونزه وشوه';

  @override
  String get selectYourCountry => 'خپل هیواد وټاکئ';

  @override
  String get searchForACountry => 'د هیواد لټون وکړئ';

  @override
  String get selectYourAdministrator => 'خپل مدیر وټاکئ';

  @override
  String get searchForAnAdministrator => 'د مدیر لټون وکړئ';

  @override
  String get searchForACity => 'د ښار لټون وکړئ';

  @override
  String get pleaseEnableLocationService => 'مهرباني وکړئ د ځای خدمت فعال کړئ';

  @override
  String get donateUs => 'مرسته وکړئ';

  @override
  String get underDevelopment => 'د جوړیدو په حال کې';

  @override
  String get versionLoading => 'بارول...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'اصلي مینو';

  @override
  String get notes => 'یادښتونه';

  @override
  String get pinned => 'پین شوی';

  @override
  String get jumpToAyah => 'آیت ته ورشئ';

  @override
  String get shareMultipleAyah => 'څو آیتونه شریک کړئ';

  @override
  String get shareThisApp => 'دا اپلیکیشن شریک کړئ';

  @override
  String get giveRating => 'درجه ورکړئ';

  @override
  String get bugReport => 'د بګ راپور ورکړئ';

  @override
  String get privacyPolicy => 'د محرمیت تګلاره';

  @override
  String get aboutTheApp => 'د اپلیکیشن په اړه';

  @override
  String get resetTheApp => 'اپلیکیشن بیا تنظیم کړئ';

  @override
  String get resetAppWarningTitle => 'د اپلیکیشن ډیټا بیا تنظیم کړئ';

  @override
  String get resetAppWarningMessage =>
      'ایا تاسو ډاډه یاست چې اپلیکیشن بیا تنظیمول غواړئ؟ ستاسو ټول معلومات به له منځه لاړ شي، او تاسو به اړتیا ولرئ چې اپلیکیشن له پیل څخه تنظیم کړئ.';

  @override
  String get cancel => 'لغوه کول';

  @override
  String get reset => 'بیا تنظیمول';

  @override
  String get shareAppSubject => 'دا القرآن اپلیکیشن وګورئ!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام علیکم! د ورځني لوستلو او فکر کولو لپاره دا القرآن اپلیکیشن وګورئ. دا د الله تعالی له کلام سره په نښلولو کې مرسته کوي. دلته یې ډاونلوډ کړئ: $appLink';
  }

  @override
  String get openDrawerTooltip => 'مینو خلاص کړئ';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'لمونځ';

  @override
  String get qibla => 'قبله';

  @override
  String get audio => 'غږ';

  @override
  String get surah => 'سورت';

  @override
  String get pages => 'پاڼې';

  @override
  String get note => 'یادونه:';

  @override
  String get linkedAyahs => 'تړلي آیتونه:';

  @override
  String get emptyNoteCollection =>
      'د یادښتونو دا ټولګه خالي ده.\nدلته د لیدو لپاره ځینې یادښتونه اضافه کړئ.';

  @override
  String get emptyPinnedCollection =>
      'تر اوسه پدې ټولګه کې هیڅ آیت پین شوی نه دی.\nدلته د لیدو لپاره آیتونه پین کړئ.';

  @override
  String get noContentAvailable => 'هیڅ محتوا شتون نلري.';

  @override
  String failedToLoadCollections(String error) {
    return 'د ټولګو په بارولو کې پاتې راغی: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'د $collectionType نوم له مخې لټون وکړئ...';
  }

  @override
  String get sortBy => 'له مخې ترتیب کړئ';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'تر اوسه هیڅ $collectionType نه دی اضافه شوی';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count پین شوي توکي';
  }

  @override
  String notesCount(int count) {
    return '$count یادښتونه';
  }

  @override
  String get emptyNameNotAllowed => 'خالي نوم اجازه نلري';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName ته تازه شو';
  }

  @override
  String get changeName => 'نوم بدل کړئ';

  @override
  String get changeColor => 'رنګ بدل کړئ';

  @override
  String get colorUpdated => 'رنګ تازه شو';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName حذف شو';
  }

  @override
  String get delete => 'حذف کړئ';

  @override
  String get save => 'خوندي کړئ';

  @override
  String get collectionNameCannotBeEmpty => 'د ټولګې نوم خالي نشي کیدی.';

  @override
  String get addedNewCollection => 'نوې ټولګه اضافه شوه';

  @override
  String ayahCount(int count) {
    return '$count آیت';
  }

  @override
  String get byNameAtoZ => 'نوم له الف څخه تر ے پورې';

  @override
  String get byNameZtoA => 'نوم له ے څخه تر الف پورې';

  @override
  String get byElementNumberAscending => 'د عنصر شمیره صعودي';

  @override
  String get byElementNumberDescending => 'د عنصر شمیره نزولي';

  @override
  String get byUpdateDateAscending => 'د تازه کولو نیټه صعودي';

  @override
  String get byUpdateDateDescending => 'د تازه کولو نیټه نزولي';

  @override
  String get byCreateDateAscending => 'د جوړولو نیټه صعودي';

  @override
  String get byCreateDateDescending => 'د جوړولو نیټه نزولي';

  @override
  String get translationNotFound => 'ژباړه ونه موندل شوه';

  @override
  String get translationTitle => 'ژباړه:';

  @override
  String get footNoteTitle => 'پای‌لیکنه:';

  @override
  String get wordByWordTranslation => 'کلمه په کلمه ژباړه:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'شریک کړئ';

  @override
  String get addNoteButton => 'یادښت اضافه کړئ';

  @override
  String get pinToCollectionButton => 'ټولګې ته پین کړئ';

  @override
  String get shareAsText => 'د متن په توګه شریک کړئ';

  @override
  String get copiedWithTafsir => 'د تفسیر سره کاپي شو';

  @override
  String get shareAsImage => 'د انځور په توګه شریک کړئ';

  @override
  String get shareWithTafsir => 'د تفسیر سره شریک کړئ';

  @override
  String get notFound => 'پیدا نه شو';

  @override
  String get noteContentCannotBeEmpty => 'د یادښت محتوا خالي نشي کیدی.';

  @override
  String get noteSavedSuccessfully => 'یادښت په بریالیتوب سره خوندي شو!';

  @override
  String get selectCollections => 'ټولګې وټاکئ';

  @override
  String get addNote => 'یادښت اضافه کړئ';

  @override
  String get writeCollectionName => 'د ټولګې نوم ولیکئ...';

  @override
  String get noCollectionsYetAddANewOne =>
      'تر اوسه هیڅ ټولګه نشته. یوه نوې اضافه کړئ!';

  @override
  String get pleaseWriteYourNoteFirst => 'مهرباني وکړئ لومړی خپل یادښت ولیکئ.';

  @override
  String get noCollectionSelected => 'هیڅ ټولګه نه ده ټاکل شوې';

  @override
  String get saveNote => 'یادښت خوندي کړئ';

  @override
  String get nextSelectCollections => 'بل: ټولګې وټاکئ';

  @override
  String get addToPinned => 'پین شویو ته اضافه کړئ';

  @override
  String get pinnedSavedSuccessfully => 'پین شوی په بریالیتوب سره خوندي شو!';

  @override
  String get savePinned => 'پین شوی خوندي کړئ';

  @override
  String get closeAudioController => 'د غږ کنټرولر بند کړئ';

  @override
  String get previous => 'مخکینی';

  @override
  String get rewind => 'شاته';

  @override
  String get fastForward => 'مخکې';

  @override
  String get playNextAyah => 'بل آیت پلی کړئ';

  @override
  String get repeat => 'تکرار';

  @override
  String get playAsPlaylist => 'د پلی لیست په توګه پلی کړئ';

  @override
  String style(String style) {
    return 'سټایل: $style';
  }

  @override
  String get stopAndClose => 'ودروئ او بند کړئ';

  @override
  String get play => 'پلی کړئ';

  @override
  String get pause => 'وقفه';

  @override
  String get selectReciter => 'قاري وټاکئ';

  @override
  String source(String source) {
    return 'سرچینه: $source';
  }

  @override
  String get newText => 'نوی';

  @override
  String get more => 'نور: ';

  @override
  String get cacheNotFound => 'کیش ونه موندل شو';

  @override
  String get cacheSize => 'د کیش اندازه';

  @override
  String error(String error) {
    return 'تېروتنه: $error';
  }

  @override
  String get clean => 'پاک کړئ';

  @override
  String get lastModified => 'وروستی تعدیل';

  @override
  String get oneYearAgo => '۱ کال مخکې';

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
  String get appFullName => 'القرآن (تفسیر، لمونځ، قبله، غږ)';

  @override
  String get appDescription =>
      'د انډرایډ، iOS، MacOS، ویب، لینکس او وینډوز لپاره یو جامع اسلامي اپلیکیشن، چې د تفسیر او څو ژباړو (د کلمې په کلمه په شمول) سره د قرآن لوستل، د خبرتیاو سره د نړۍ په کچه د لمانځه وختونه، د قبلې قطب نما، او د همغږي شوي کلمې په کلمه غږیز تلاوت وړاندې کوي.';

  @override
  String get dataSourcesNote =>
      'یادونه: د قرآن متنونه، تفسیر، ژباړې، او غږیزې سرچینې د Quran.com، Everyayah.com، او نورو تایید شویو خلاصو سرچینو څخه اخیستل شوي دي.';

  @override
  String get adFreePromise =>
      'دا اپلیکیشن د الله تعالی د رضا لپاره جوړ شوی دی. له همدې امله، دا په بشپړه توګه له اعلاناتو پاک دی او تل به وي.';

  @override
  String get coreFeatures => 'اصلي ځانګړتیاوې';

  @override
  String get coreFeaturesDescription =>
      'هغه کلیدي فعالیتونه وپلټئ چې القرآن v3 ستاسو د ورځنیو اسلامي عملونو لپاره یو لازمي وسیله جوړوي:';

  @override
  String get prayerTimesTitle => 'د لمانځه وختونه او خبرتیاوې';

  @override
  String get prayerTimesDescription =>
      'د مختلفو محاسبې میتودونو په کارولو سره د نړۍ په هر ځای کې د لمانځه دقیق وختونه. د اذان خبرتیاو سره یادونې تنظیم کړئ.';

  @override
  String get qiblaDirectionTitle => 'د قبلې لور';

  @override
  String get qiblaDirectionDescription =>
      'د روښانه او دقیق قطب نما لید سره په اسانۍ سره د قبلې لور ومومئ.';

  @override
  String get translationTafsirTitle => 'د قرآن ژباړه او تفسیر';

  @override
  String get translationTafsirDescription =>
      ' په ۶۹ ژبو کې ۱۲۰+ د ژباړې کتابونو (د کلمې په کلمه په شمول)، او ۳۰+ د تفسیر کتابونو ته لاسرسی ومومئ.';

  @override
  String get wordByWordAudioTitle => 'کلمه په کلمه غږ او روښانه کول';

  @override
  String get wordByWordAudioDescription =>
      'د یوې ژورې زده کړې تجربې لپاره د همغږي شوي کلمې په کلمه غږیز تلاوت او روښانه کولو سره یوځای شئ.';

  @override
  String get ayahAudioRecitationTitle => 'د آیت غږیز تلاوت';

  @override
  String get ayahAudioRecitationDescription =>
      'د ۴۰+ څخه ډیرو مشهورو قاریانو څخه د آیت بشپړ تلاوت واورئ.';

  @override
  String get notesCloudBackupTitle => 'د کلاوډ بیک اپ سره یادښتونه';

  @override
  String get notesCloudBackupDescription =>
      'شخصي یادښتونه او فکرونه خوندي کړئ، په خوندي توګه کلاوډ ته بیک اپ شوي (فیچر د جوړیدو په حال کې/ژر راځي).';

  @override
  String get crossPlatformSupportTitle => 'د کراس پلیټفارم ملاتړ';

  @override
  String get crossPlatformSupportDescription =>
      'په انډرایډ، ویب، لینکس، او وینډوز کې ملاتړ کیږي.';

  @override
  String get backgroundAudioPlaybackTitle => 'په پس منظر کې غږ پلی کول';

  @override
  String get backgroundAudioPlaybackDescription =>
      'حتی کله چې اپلیکیشن په پس منظر کې وي د قرآن تلاوت اوریدلو ته دوام ورکړئ.';

  @override
  String get audioDataCachingTitle => 'د غږ او ډیټا کیش کول';

  @override
  String get audioDataCachingDescription =>
      'د قوي غږ او قرآن ډیټا کیش کولو سره پرمختللي پلی بیک او آفلاین وړتیاوې.';

  @override
  String get minimalisticInterfaceTitle => 'ساده او پاک انټرفیس';

  @override
  String get minimalisticInterfaceDescription =>
      'د کارونکي تجربې او لوستلو وړتیا باندې تمرکز سره د نیویګیټ کولو لپاره اسانه انټرفیس.';

  @override
  String get optimizedPerformanceTitle => 'غوره شوي فعالیت او اندازه';

  @override
  String get optimizedPerformanceDescription =>
      'یو بډایه فیچر اپلیکیشن چې د سپک او فعال کیدو لپاره ډیزاین شوی.';

  @override
  String get languageSupport => 'د ژبې ملاتړ';

  @override
  String get languageSupportDescription =>
      'دا اپلیکیشن د نړیوالو لیدونکو لپاره د لاسرسي وړ کیدو لپاره ډیزاین شوی چې د لاندې ژبو ملاتړ کوي (او نور په دوامداره توګه اضافه کیږي):';

  @override
  String get technologyAndResources => 'ټیکنالوژي او سرچینې';

  @override
  String get technologyAndResourcesDescription =>
      'دا اپلیکیشن د پرمختللي ټیکنالوژیو او باوري سرچینو په کارولو سره جوړ شوی دی:';

  @override
  String get flutterFrameworkTitle => 'د فلوټر چوکاټ';

  @override
  String get flutterFrameworkDescription =>
      'د یو واحد کوډبیس څخه د ښکلي، اصلي تالیف شوي، څو پلیټ فارم تجربې لپاره د فلوټر سره جوړ شوی.';

  @override
  String get advancedAudioEngineTitle => 'پرمختللی غږیز انجن';

  @override
  String get advancedAudioEngineDescription =>
      'د قوي غږ پلی بیک او کنټرول لپاره د `just_audio` او `just_audio_background` فلوټر کڅوړو لخوا پرمخ وړل کیږي.';

  @override
  String get reliableQuranDataTitle => 'د قرآن باوري ډیټا';

  @override
  String get reliableQuranDataDescription =>
      'د القرآن متنونه، ژباړې، تفسیرونه، او غږونه د تایید شویو خلاصو APIs او ډیټابیسونو لکه Quran.com او Everyayah.com څخه اخیستل شوي دي.';

  @override
  String get prayerTimeEngineTitle => 'د لمانځه وخت انجن';

  @override
  String get prayerTimeEngineDescription =>
      'د دقیق لمانځه وختونو لپاره تاسیس شوي محاسبې میتودونه کاروي. خبرتیاوې د `flutter_local_notifications` او پس منظر کارونو لخوا اداره کیږي.';

  @override
  String get crossPlatformSupport => 'د کراس پلیټفارم ملاتړ';

  @override
  String get crossPlatformSupportDescription2 =>
      'په مختلف پلیټ فارمونو کې له بې سیمې لاسرسي څخه خوند واخلئ:';

  @override
  String get android => 'انډرایډ';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'ویب';

  @override
  String get linux => 'لینکس';

  @override
  String get windows => 'وینډوز';

  @override
  String get ourLifetimePromise => 'زموږ د تل لپاره ژمنه';

  @override
  String get lifetimePromiseDescription =>
      'زه په شخصي توګه ژمنه کوم چې زما د ژوند په اوږدو کې به د دې اپلیکیشن لپاره دوامداره ملاتړ او ساتنه چمتو کړم، ان شاءالله. زما هدف دا دی چې ډاډ ترلاسه کړم چې دا اپلیکیشن د راتلونکو کلونو لپاره د امت لپاره یوه ګټوره سرچینه پاتې شي.';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'لمرختل';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get midnight => 'نيمه شپه';

  @override
  String get alarm => 'الارم';

  @override
  String get notification => 'خبرتیا';

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
  String get sajdaAyah => 'د سجدې آیت';

  @override
  String get required => 'واجب';

  @override
  String get optional => 'اختیاري';

  @override
  String get notificationScheduleWarning =>
      'یادونه: ستاسو د تلیفون د عامل سیسټم د شالید پروسې محدودیتونو له امله مهالویش شوی خبرتیا یا یادونه له لاسه ورکیدلی شي. د مثال په توګه: د ویوو اوریجن عامل سیسټم، د سامسنګ ون یو آی، د اوپو کلر عامل سیسټم او داسې نور کله ناکله مهالویش شوی خبرتیا یا یادونه وژني. مهرباني وکړئ د خپل عامل سیسټم تنظیمات وګورئ ترڅو اپلیکیشن د شالید پروسې څخه محدود نه شي.';

  @override
  String get scrollWithRecitation => 'د تلاوت سره سکرول کړئ';

  @override
  String get scrollWithRecitationDesc =>
      'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.';

  @override
  String get quickAccess => 'چټک لاسرسی';

  @override
  String get initiallyScrollAyah => 'په پیل کې آیت ته سکرول کړئ';

  @override
  String get tajweedGuide => 'د تجوید لارښود';

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
}
