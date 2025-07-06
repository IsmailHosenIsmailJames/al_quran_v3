// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return 'تفسیر $nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey کے لیے تفسیر دستیاب نہیں ہے';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر یہاں ملے گی: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey پر جائیں';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جزء';

  @override
  String get page => 'صفحہ';

  @override
  String get ruku => 'رکوع';

  @override
  String get languageSettings => 'زبان کی ترتیبات';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count آیات';
  }

  @override
  String get saveAndDownload => 'محفوظ کریں اور ڈاؤن لوڈ کریں';

  @override
  String get appLanguage => 'ایپ کی زبان';

  @override
  String get selectAppLanguage => 'ایپ کی زبان منتخب کریں...';

  @override
  String get pleaseSelectOne => 'براہ کرم ایک منتخب کریں';

  @override
  String get quranTranslationLanguage => 'قرآن ترجمہ کی زبان';

  @override
  String get selectTranslationLanguage => 'ترجمہ کی زبان منتخب کریں...';

  @override
  String get quranTranslationBook => 'قرآن ترجمہ کی کتاب';

  @override
  String get selectTranslationBook => 'ترجمہ کی کتاب منتخب کریں...';

  @override
  String get quranTafsirLanguage => 'قرآن تفسیر کی زبان';

  @override
  String get selectTafsirLanguage => 'تفسیر کی زبان منتخب کریں...';

  @override
  String get quranTafsirBook => 'قرآن تفسیر کی کتاب';

  @override
  String get selectTafsirBook => 'تفسیر کی کتاب منتخب کریں...';

  @override
  String get quranScriptAndStyle => 'قرآنی رسم الخط اور انداز';

  @override
  String get justAMoment => 'بس ایک لمحہ...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'کامیاب';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get unableToDownloadResources =>
      'وسائل ڈاؤن لوڈ نہیں ہو سکے... \nکچھ خرابی پیش آ گئی';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'قرآن کی جزوی تلاوت ڈاؤن لوڈ ہو رہی ہے';

  @override
  String get processingSegmentedQuranRecitation =>
      'قرآن کی جزوی تلاوت پر کارروائی ہو رہی ہے';

  @override
  String get footnote => 'حاشیہ';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'لفظ بہ لفظ';

  @override
  String get pleaseSelectRequiredOption => 'براہ کرم مطلوبہ آپشن منتخب کریں';

  @override
  String get rememberHomeTab => 'ہوم ٹیب یاد رکھیں';

  @override
  String get rememberHomeTabSubtitle =>
      'ایپ ہوم اسکرین پر آخری کھولی گئی ٹیب کو یاد رکھے گی۔';

  @override
  String get wakeLock => 'اسکرین کو آن رکھیں';

  @override
  String get wakeLockSubtitle => 'اسکرین کو خود بخود بند ہونے سے روکیں۔';

  @override
  String get settings => 'ترتیبات';

  @override
  String get appTheme => 'ایپ کا تھیم';

  @override
  String get quranStyle => 'قرآن کا انداز';

  @override
  String get changeTheme => 'تھیم تبدیل کریں';

  @override
  String get verseCount => 'آیات کی تعداد: ';

  @override
  String get translation => 'ترجمہ';

  @override
  String get tafsirNotFound => 'نہیں ملا';

  @override
  String get moreInfo => 'مزید معلومات';

  @override
  String get playAudio => 'آڈیو چلائیں';

  @override
  String get preview => 'پیش منظر';

  @override
  String get loading => 'لوڈ ہو رہا ہے...';

  @override
  String get errorFetchingAddress => 'پتہ حاصل کرنے میں خرابی';

  @override
  String get addressNotAvailable => 'پتہ دستیاب نہیں';

  @override
  String get latitude => 'عرض بلد: ';

  @override
  String get longitude => 'طول بلد: ';

  @override
  String get name => 'نام: ';

  @override
  String get location => 'مقام: ';

  @override
  String get parameters => 'پیرامیٹرز: ';

  @override
  String get selectCalculationMethod => 'حساب کا طریقہ منتخب کریں';

  @override
  String get shareSelectAyahs => 'منتخب آیات شیئر کریں';

  @override
  String get selectionEmpty => 'انتخاب خالی ہے';

  @override
  String get generatingImagePleaseWait =>
      'تصویر بن رہی ہے... براہ کرم انتظار کریں';

  @override
  String get asImage => 'بطور تصویر';

  @override
  String get asText => 'بطور متن';

  @override
  String get playFromSelectedAyah => 'منتخب آیت سے چلائیں';

  @override
  String get toTafsir => 'تفسیر پر جائیں';

  @override
  String get selectAyah => 'آیت منتخب کریں';

  @override
  String get toAyah => 'آیت پر جائیں';

  @override
  String get searchForASurah => 'سورة تلاش کریں';

  @override
  String get bugReportTitle => 'خرابی کی اطلاع دیں';

  @override
  String get audioCached => 'آڈیو کیش شدہ';

  @override
  String get others => 'دیگر';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن | ترجمہ | آیت، ایک کا فعال ہونا ضروری ہے';

  @override
  String get quranFontSize => 'قرآن کا فونٹ سائز';

  @override
  String get quranLineHeight => 'قرآن کی لائن کی اونچائی';

  @override
  String get translationAndTafsirFontSize => 'ترجمہ اور تفسیر کا فونٹ سائز';

  @override
  String get quranAyah => 'قرآنی آیت';

  @override
  String get topToolbar => 'اوپر والا ٹول بار';

  @override
  String get keepOpenWordByWord => 'لفظ بہ لفظ کو کھلا رکھیں';

  @override
  String get wordByWordHighlight => 'لفظ بہ لفظ نمایاں کریں';

  @override
  String get quranScriptSettings => 'قرآنی رسم الخط کی ترتیبات';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'صفحہ: ';

  @override
  String get quranResources => 'قرآنی وسائل';

  @override
  String alreadySelected(String name) {
    return 'زبان \'$name\' پہلے سے منتخب ہے۔';
  }

  @override
  String get unableToGetCompassData => 'قطب نما کا ڈیٹا حاصل نہیں ہو سکا';

  @override
  String get deviceDoesNotHaveSensors => 'ڈیوائس میں سینسر نہیں ہیں!';

  @override
  String get north => 'شمال';

  @override
  String get east => 'مشرق';

  @override
  String get south => 'جنوب';

  @override
  String get west => 'مغرب';

  @override
  String get address => 'پتہ: ';

  @override
  String get change => 'تبدیل کریں';

  @override
  String get calculationMethod => 'حساب کا طریقہ: ';

  @override
  String get downloadPrayerTime => 'نماز کے اوقات ڈاؤن لوڈ کریں';

  @override
  String get calculationMethodsListEmpty => 'حساب کے طریقوں کی فہرست خالی ہے۔';

  @override
  String get noCalculationMethodWithLocationData =>
      'مقام کے ڈیٹا کے ساتھ کوئی حساب کا طریقہ نہیں ملا۔';

  @override
  String get prayerSettings => 'نماز کی ترتیبات';

  @override
  String get reminderSettings => 'یاد دہانی کی ترتیبات';

  @override
  String get adjustReminderTime => 'یاد دہانی کا وقت ایڈجسٹ کریں';

  @override
  String get enforceAlarmSound => 'الارم کی آواز کو لازمی کریں';

  @override
  String get enforceAlarmSoundDescription =>
      'اگر فعال ہو تو، یہ فیچر الارم کو یہاں سیٹ کردہ والیوم پر بجائے گا، چاہے آپ کے فون کی آواز کم ہی کیوں نہ ہو۔ یہ یقینی بناتا ہے کہ آپ فون کی کم آواز کی وجہ سے الارم سے محروم نہ ہوں۔';

  @override
  String get volume => 'والیوم';

  @override
  String get atPrayerTime => 'نماز کے وقت';

  @override
  String minBefore(int minutes) {
    return '$minutes منٹ پہلے';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes منٹ بعد';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName کا وقت $prayerTime ہے';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'یہ $prayerName کا وقت ہے';
  }

  @override
  String get stopTheAdhan => 'اذان روکیں';

  @override
  String dateFoundEmpty(String date) {
    return '$date خالی ملا';
  }

  @override
  String get today => 'آج';

  @override
  String get left => 'باقی';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName کے لیے یاد دہانی شامل کر دی گئی';
  }

  @override
  String get allowNotificationPermission =>
      'اس فیچر کو استعمال کرنے کے لیے براہ کرم نوٹیفکیشن کی اجازت دیں';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName کے لیے یاد دہانی ہٹا دی گئی';
  }

  @override
  String get getPrayerTimesAndQibla => 'نماز کے اوقات اور قبلہ حاصل کریں';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'کسی بھی مقام کے لیے نماز کے اوقات اور قبلہ کا حساب لگائیں۔';

  @override
  String get getFromGPS => 'GPS سے حاصل کریں';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'اپنا شہر منتخب کریں';

  @override
  String get noteAboutGPS =>
      'نوٹ: اگر آپ GPS استعمال نہیں کرنا چاہتے یا محفوظ محسوس نہیں کرتے، تو آپ اپنا شہر منتخب کر سکتے ہیں۔';

  @override
  String get downloadingLocationResources =>
      'مقام کے وسائل ڈاؤن لوڈ ہو رہے ہیں...';

  @override
  String get somethingWentWrong => 'کچھ خرابی پیش آ گئی';

  @override
  String get selectYourCountry => 'اپنا ملک منتخب کریں';

  @override
  String get searchForACountry => 'ملک تلاش کریں';

  @override
  String get selectYourAdministrator => 'اپنا انتظامی علاقہ منتخب کریں';

  @override
  String get searchForAnAdministrator => 'انتظامی علاقہ تلاش کریں';

  @override
  String get searchForACity => 'شہر تلاش کریں';

  @override
  String get pleaseEnableLocationService => 'براہ کرم لوکیشن سروس فعال کریں';

  @override
  String get donateUs => 'ہمیں عطیہ دیں';

  @override
  String get underDevelopment => 'زیر تعمیر';

  @override
  String get versionLoading => 'لوڈ ہو رہا ہے...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'مرکزی مینو';

  @override
  String get notes => 'نوٹس';

  @override
  String get pinned => 'مخصوص کردہ';

  @override
  String get jumpToAyah => 'آیت پر جائیں';

  @override
  String get shareMultipleAyah => 'متعدد آیات شیئر کریں';

  @override
  String get shareThisApp => 'اس ایپ کو شیئر کریں';

  @override
  String get giveRating => 'درجہ بندی کریں';

  @override
  String get bugReport => 'خرابی کی اطلاع دیں';

  @override
  String get privacyPolicy => 'رازداری کی پالیسی';

  @override
  String get aboutTheApp => 'ایپ کے بارے میں';

  @override
  String get resetTheApp => 'ایپ کو ری سیٹ کریں';

  @override
  String get resetAppWarningTitle => 'ایپ کا ڈیٹا ری سیٹ کریں';

  @override
  String get resetAppWarningMessage =>
      'کیا آپ واقعی ایپ کو ری سیٹ کرنا چاہتے ہیں؟ آپ کا تمام ڈیٹا ضائع ہو جائے گا، اور آپ کو ایپ کو شروع سے ترتیب دینا پڑے گا۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get reset => 'ری سیٹ';

  @override
  String get shareAppSubject => 'یہ القرآن ایپ دیکھیں!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام علیکم! روزانہ تلاوت اور غور و فکر کے لیے یہ القرآن ایپ دیکھیں۔ یہ اللہ کے کلام سے جڑنے میں مدد دیتی ہے۔ یہاں سے ڈاؤن لوڈ کریں: $appLink';
  }

  @override
  String get openDrawerTooltip => 'مینو کھولیں';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'نماز';

  @override
  String get qibla => 'قبلہ';

  @override
  String get audio => 'آڈیو';

  @override
  String get surah => 'سورتیں';

  @override
  String get pages => 'صفحات';

  @override
  String get note => 'نوٹ:';

  @override
  String get linkedAyahs => 'منسلک آیات:';

  @override
  String get emptyNoteCollection =>
      'یہ نوٹس کا مجموعہ خالی ہے۔\nیہاں دیکھنے کے لیے کچھ نوٹس شامل کریں۔';

  @override
  String get emptyPinnedCollection =>
      'اس مجموعے میں ابھی تک کوئی آیت پن نہیں کی گئی۔\nیہاں دیکھنے کے لیے آیات کو پن کریں۔';

  @override
  String get noContentAvailable => 'کوئی مواد دستیاب نہیں۔';

  @override
  String failedToLoadCollections(String error) {
    return 'مجموعے لوڈ کرنے میں ناکام: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType کے نام سے تلاش کریں...';
  }

  @override
  String get sortBy => 'ترتیب دیں بلحاظ';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'ابھی تک کوئی $collectionType شامل نہیں کیا گیا';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count مخصوص کردہ آئٹمز';
  }

  @override
  String notesCount(int count) {
    return '$count نوٹس';
  }

  @override
  String get emptyNameNotAllowed => 'خالی نام کی اجازت نہیں ہے';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName میں اپ ڈیٹ کیا گیا';
  }

  @override
  String get changeName => 'نام تبدیل کریں';

  @override
  String get changeColor => 'رنگ تبدیل کریں';

  @override
  String get colorUpdated => 'رنگ اپ ڈیٹ ہو گیا';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName حذف کر دیا گیا';
  }

  @override
  String get delete => 'حذف کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get collectionNameCannotBeEmpty => 'مجموعے کا نام خالی نہیں ہو سکتا۔';

  @override
  String get addedNewCollection => 'نیا مجموعہ شامل کیا گیا';

  @override
  String ayahCount(int count) {
    return '$count آیت';
  }

  @override
  String get byNameAtoZ => 'نام الف سے ے';

  @override
  String get byNameZtoA => 'نام ے سے الف';

  @override
  String get byElementNumberAscending => 'عنصر نمبر صعودی';

  @override
  String get byElementNumberDescending => 'عنصر نمبر نزولی';

  @override
  String get byUpdateDateAscending => 'تاریخ اپ ڈیٹ صعودی';

  @override
  String get byUpdateDateDescending => 'تاریخ اپ ڈیٹ نزولی';

  @override
  String get byCreateDateAscending => 'تاریخ تخلیق صعودی';

  @override
  String get byCreateDateDescending => 'تاریخ تخلیق نزولی';

  @override
  String get translationNotFound => 'ترجمہ نہیں ملا';

  @override
  String get translationTitle => 'ترجمہ:';

  @override
  String get footNoteTitle => 'حاشیہ:';

  @override
  String get wordByWordTranslation => 'لفظ بہ لفظ ترجمہ:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'شیئر کریں';

  @override
  String get addNoteButton => 'نوٹ شامل کریں';

  @override
  String get pinToCollectionButton => 'مجموعے میں پن کریں';

  @override
  String get shareAsText => 'بطور متن شیئر کریں';

  @override
  String get copiedWithTafsir => 'تفسیر کے ساتھ کاپی کیا گیا';

  @override
  String get shareAsImage => 'بطور تصویر شیئر کریں';

  @override
  String get shareWithTafsir => 'تفسیر کے ساتھ شیئر کریں';

  @override
  String get notFound => 'نہیں ملا';

  @override
  String get noteContentCannotBeEmpty => 'نوٹ کا مواد خالی نہیں ہو سکتا۔';

  @override
  String get noteSavedSuccessfully => 'نوٹ کامیابی سے محفوظ ہو گیا!';

  @override
  String get selectCollections => 'مجموعے منتخب کریں';

  @override
  String get addNote => 'نوٹ شامل کریں';

  @override
  String get writeCollectionName => 'مجموعے کا نام لکھیں...';

  @override
  String get noCollectionsYetAddANewOne =>
      'ابھی تک کوئی مجموعہ نہیں ہے۔ ایک نیا شامل کریں!';

  @override
  String get pleaseWriteYourNoteFirst => 'براہ کرم پہلے اپنا نوٹ لکھیں۔';

  @override
  String get noCollectionSelected => 'کوئی مجموعہ منتخب نہیں کیا گیا';

  @override
  String get saveNote => 'نوٹ محفوظ کریں';

  @override
  String get nextSelectCollections => 'اگلا: مجموعے منتخب کریں';

  @override
  String get addToPinned => 'مخصوص کردہ میں شامل کریں';

  @override
  String get pinnedSavedSuccessfully => 'مخصوص کردہ کامیابی سے محفوظ ہو گیا!';

  @override
  String get savePinned => 'مخصوص کردہ کو محفوظ کریں';

  @override
  String get closeAudioController => 'آڈیو کنٹرولر بند کریں';

  @override
  String get previous => 'پچھلا';

  @override
  String get rewind => 'پیچھے کریں';

  @override
  String get fastForward => 'آگے کریں';

  @override
  String get playNextAyah => 'اگلی آیت چلائیں';

  @override
  String get repeat => 'دہرائیں';

  @override
  String get playAsPlaylist => 'پلے لسٹ کے طور پر چلائیں';

  @override
  String style(String style) {
    return 'انداز: $style';
  }

  @override
  String get stopAndClose => 'روکیں اور بند کریں';

  @override
  String get play => 'چلائیں';

  @override
  String get pause => 'وقفہ';

  @override
  String get selectReciter => 'قاری منتخب کریں';

  @override
  String source(String source) {
    return 'ماخذ: $source';
  }

  @override
  String get newText => 'نیا';

  @override
  String get more => 'مزید: ';

  @override
  String get cacheNotFound => 'کیشے نہیں ملا';

  @override
  String get cacheSize => 'کیشے کا سائز';

  @override
  String error(String error) {
    return 'خرابی: $error';
  }

  @override
  String get clean => 'صاف کریں';

  @override
  String get lastModified => 'آخری ترمیم';

  @override
  String get oneYearAgo => '1 سال پہلے';

  @override
  String monthsAgo(String number) {
    return '$number ماہ پہلے';
  }

  @override
  String weeksAgo(String number) {
    return '$number ہفتے پہلے';
  }

  @override
  String daysAgo(String number) {
    return '$number دن پہلے';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour گھنٹے پہلے';
  }

  @override
  String get aboutAlQuran => 'القرآن کے بارے میں';

  @override
  String get appFullName => 'القرآن (تفسیر، نماز، قبلہ، آڈیو)';

  @override
  String get appDescription =>
      'اینڈرائیڈ، آئی او ایس، میک او ایس، ویب، لینکس اور ونڈوز کے لیے ایک جامع اسلامی ایپلیکیشن، جو تفسیر اور متعدد تراجم (بشمول لفظ بہ لفظ) کے ساتھ قرآن پڑھنے کی سہولت، اطلاعات کے ساتھ دنیا بھر میں نماز کے اوقات، قبلہ کمپاس، اور ہم آہنگ لفظ بہ لفظ آڈیو تلاوت پیش کرتی ہے۔';

  @override
  String get dataSourcesNote =>
      'نوٹ: قرآن کے متون، تفسیر، تراجم، اور آڈیو وسائل Quran.com، Everyayah.com، اور دیگر تصدیق شدہ کھلے ذرائع سے حاصل کیے گئے ہیں۔';

  @override
  String get adFreePromise =>
      'یہ ایپ اللہ کی رضا حاصل کرنے کے لیے بنائی گئی ہے۔ لہذا، یہ ہمیشہ اشتہارات سے مکمل طور پر پاک ہے اور رہے گی۔';

  @override
  String get coreFeatures => 'بنیادی خصوصیات';

  @override
  String get coreFeaturesDescription =>
      'ان کلیدی خصوصیات کو دریافت کریں جو القرآن v3 کو آپ کے روزمرہ کے اسلامی معمولات کے لیے ایک ناگزیر ٹول بناتی ہیں:';

  @override
  String get prayerTimesTitle => 'نماز کے اوقات اور انتباہات';

  @override
  String get prayerTimesDescription =>
      'مختلف حساب کے طریقوں کا استعمال کرتے ہوئے دنیا بھر میں کسی بھی مقام کے لیے نماز کے درست اوقات۔ اذان کی اطلاعات کے ساتھ یاد دہانیاں سیٹ کریں۔';

  @override
  String get qiblaDirectionTitle => 'قبلہ کی سمت';

  @override
  String get qiblaDirectionDescription =>
      'ایک واضح اور درست کمپاس منظر کے ساتھ قبلہ کی سمت آسانی سے تلاش کریں۔';

  @override
  String get translationTafsirTitle => 'قرآن کا ترجمہ اور تفسیر';

  @override
  String get translationTafsirDescription =>
      '69 زبانوں میں 120+ ترجمہ کی کتابوں (بشمول لفظ بہ لفظ) اور 30+ تفسیر کی کتابوں تک رسائی حاصل کریں۔';

  @override
  String get wordByWordAudioTitle => 'لفظ بہ لفظ آڈیو اور ہائی لائٹنگ';

  @override
  String get wordByWordAudioDescription =>
      'ایک عمیق سیکھنے کے تجربے کے لیے ہم آہنگ لفظ بہ لفظ آڈیو تلاوت اور ہائی لائٹنگ کے ساتھ عمل کریں۔';

  @override
  String get ayahAudioRecitationTitle => 'آیت کی آڈیو تلاوت';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ سے زیادہ مشہور قاریوں سے مکمل آیت کی تلاوت سنیں۔';

  @override
  String get notesCloudBackupTitle => 'کلاؤڈ بیک اپ کے ساتھ نوٹس';

  @override
  String get notesCloudBackupDescription =>
      'ذاتی نوٹس اور تاثرات محفوظ کریں، جو کلاؤڈ پر محفوظ طریقے سے بیک اپ کیے گئے ہوں (خصوصیت زیر تعمیر/ جلد آرہی ہے)۔';

  @override
  String get crossPlatformSupportTitle => 'کراس پلیٹ فارم سپورٹ';

  @override
  String get crossPlatformSupportDescription =>
      'اینڈرائیڈ، ویب، لینکس، اور ونڈوز پر معاونت یافتہ۔';

  @override
  String get backgroundAudioPlaybackTitle => 'پس منظر میں آڈیو پلے بیک';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ایپ پس منظر میں ہونے پر بھی قرآن کی تلاوت سننا جاری رکھیں۔';

  @override
  String get audioDataCachingTitle => 'آڈیو اور ڈیٹا کیشنگ';

  @override
  String get audioDataCachingDescription =>
      'مضبوط آڈیو اور قرآنی ڈیٹا کیشنگ کے ساتھ بہتر پلے بیک اور آف لائن صلاحیتیں۔';

  @override
  String get minimalisticInterfaceTitle => 'کم سے کم اور صاف انٹرفیس';

  @override
  String get minimalisticInterfaceDescription =>
      'صارف کے تجربے اور پڑھنے کی اہلیت پر توجہ کے ساتھ نیویگیٹ کرنے میں آسان انٹرفیس۔';

  @override
  String get optimizedPerformanceTitle => 'بہتر کارکردگی اور سائز';

  @override
  String get optimizedPerformanceDescription =>
      'ایک خصوصیت سے بھرپور ایپلیکیشن جو ہلکا پھلکا اور کارکردگی میں بہترین ہونے کے لیے ڈیزائن کی گئی ہے۔';

  @override
  String get languageSupport => 'زبان کی معاونت';

  @override
  String get languageSupportDescription =>
      'یہ ایپلیکیشن مندرجہ ذیل زبانوں کے لیے عالمی سامعین تک رسائی کے لیے ڈیزائن کی گئی ہے (اور مزید مسلسل شامل کی جا رہی ہیں):';

  @override
  String get technologyAndResources => 'ٹیکنالوجی اور وسائل';

  @override
  String get technologyAndResourcesDescription =>
      'یہ ایپ جدید ٹیکنالوجیز اور قابل اعتماد وسائل کا استعمال کرتے ہوئے بنائی گئی ہے:';

  @override
  String get flutterFrameworkTitle => 'فلٹر فریم ورک';

  @override
  String get flutterFrameworkDescription =>
      'ایک ہی کوڈ بیس سے ایک خوبصورت، مقامی طور پر مرتب شدہ، کثیر پلیٹ فارم کے تجربے کے لیے فلٹر کے ساتھ بنایا گیا ہے۔';

  @override
  String get advancedAudioEngineTitle => 'جدید آڈیو انجن';

  @override
  String get advancedAudioEngineDescription =>
      'مضبوط آڈیو پلے بیک اور کنٹرول کے لیے \'just_audio\' اور \'just_audio_background\' فلٹر پیکجز کے ذریعے تقویت یافتہ۔';

  @override
  String get reliableQuranDataTitle => 'قابل اعتماد قرآنی ڈیٹا';

  @override
  String get reliableQuranDataDescription =>
      'القرآن کے متون، تراجم، تفاسیر، اور آڈیو Quran.com اور Everyayah.com جیسی تصدیق شدہ کھلی APIs اور ڈیٹا بیس سے حاصل کیے گئے ہیں۔';

  @override
  String get prayerTimeEngineTitle => 'نماز کے اوقات کا انجن';

  @override
  String get prayerTimeEngineDescription =>
      'نماز کے درست اوقات کے لیے قائم شدہ حساب کے طریقوں کا استعمال کرتا ہے۔ اطلاعات \'flutter_local_notifications\' اور پس منظر کے کاموں کے ذریعے سنبھالی جاتی ہیں۔';

  @override
  String get crossPlatformSupport => 'کراس پلیٹ فارم سپورٹ';

  @override
  String get crossPlatformSupportDescription2 =>
      'مختلف پلیٹ فارمز پر ہموار رسائی سے لطف اٹھائیں:';

  @override
  String get android => 'اینڈرائیڈ';

  @override
  String get ios => 'آئی او ایس';

  @override
  String get macos => 'میک او ایس';

  @override
  String get web => 'ویب';

  @override
  String get linux => 'لینکس';

  @override
  String get windows => 'ونڈوز';

  @override
  String get ourLifetimePromise => 'ہمارا تاحیات وعدہ';

  @override
  String get lifetimePromiseDescription =>
      'میں ذاتی طور پر اس ایپلیکیشن کے لیے اپنی زندگی بھر مسلسل مدد اور دیکھ بھال فراہم کرنے کا وعدہ کرتا ہوں، انشاء اللہ۔ میرا مقصد یہ یقینی بنانا ہے کہ یہ ایپ آنے والے سالوں تک امت کے لیے ایک فائدہ مند وسیلہ بنی رہے۔';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'طلوع آفتاب';

  @override
  String get dhuhr => 'ظہر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get midnight => 'آدھی رات';

  @override
  String get alarm => 'الارم';

  @override
  String get notification => 'اطلاع';

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
  String get quranScriptUthmani => 'عثمانی';

  @override
  String get quranScriptIndopak => 'انڈوپاک';

  @override
  String get sajdaAyah => 'سجدہ آیت';

  @override
  String get required => 'واجب';

  @override
  String get optional => 'اختیاری';
}
