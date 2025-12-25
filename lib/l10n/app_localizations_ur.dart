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
    return '$nameSimple ( $nameArabic ) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey کے لیے تفسیر دستیاب نہیں ہے';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر یہاں دستیاب ہے: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey پر جائیں';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جز';

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
  String get pleaseSelectOne => 'براہ مہربانی ایک منتخب کریں';

  @override
  String get quranTranslationLanguage => 'قرآن کا ترجمہ زبان';

  @override
  String get selectTranslationLanguage => 'ترجمہ کی زبان منتخب کریں...';

  @override
  String get quranTranslationBook => 'قرآن کا ترجمہ کتاب';

  @override
  String get selectTranslationBook => 'ترجمہ کی کتاب منتخب کریں...';

  @override
  String get quranTafsirLanguage => 'قرآن کی تفسیر زبان';

  @override
  String get selectTafsirLanguage => 'تفسیر کی زبان منتخب کریں...';

  @override
  String get quranTafsirBook => 'قرآن کی تفسیر کتاب';

  @override
  String get selectTafsirBook => 'تفسیر کی کتاب منتخب کریں...';

  @override
  String get quranScriptAndStyle => 'قرآن کا رسم الخط اور انداز';

  @override
  String get justAMoment => 'ایک لمحہ...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'کامیابی';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get unableToDownloadResources =>
      'وسائل ڈاؤن لوڈ کرنے میں ناکام...\nکچھ غلط ہو گیا';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'قرآن کی تقسیم شدہ تلاوت ڈاؤن لوڈ ہو رہی ہے';

  @override
  String get processingSegmentedQuranRecitation =>
      'قرآن کی تقسیم شدہ تلاوت پر عمل ہو رہا ہے';

  @override
  String get footnote => 'فٹ نوٹ';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'لفظ بہ لفظ';

  @override
  String get pleaseSelectRequiredOption =>
      'براہ مہربانی مطلوبہ آپشن منتخب کریں';

  @override
  String get rememberHomeTab => 'ہوم ٹیب یاد رکھیں';

  @override
  String get rememberHomeTabSubtitle =>
      'ایپ ہوم اسکرین میں آخری کھولی گئی ٹیب کو یاد رکھے گی۔';

  @override
  String get wakeLock => 'ویک لاک';

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
  String get preview => 'پیش نظارہ';

  @override
  String get loading => 'لوڈ ہو رہا ہے...';

  @override
  String get errorFetchingAddress => 'پتہ حاصل کرنے میں خرابی';

  @override
  String get addressNotAvailable => 'پتہ دستیاب نہیں ہے';

  @override
  String get latitude => 'عرض البلد: ';

  @override
  String get longitude => 'طول البلد: ';

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
      'تصویر تیار ہو رہی ہے... براہ مہربانی انتظار کریں';

  @override
  String get asImage => 'تصویر کی صورت میں';

  @override
  String get asText => 'متن کی صورت میں';

  @override
  String get playFromSelectedAyah => 'منتخب آیت سے چلائیں';

  @override
  String get toTafsir => 'تفسیر کی طرف';

  @override
  String get selectAyah => 'آیت منتخب کریں';

  @override
  String get toAyah => 'آیت کی طرف';

  @override
  String get searchForASurah => 'سورہ تلاش کریں';

  @override
  String get bugReportTitle => 'بگ رپورٹ';

  @override
  String get audioCached => 'آڈیو کیچڈ';

  @override
  String get others => 'دیگر';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن|ترجمہ|آیت، ایک کو فعال کرنا ضروری ہے';

  @override
  String get quranFontSize => 'قرآن کا فونٹ سائز';

  @override
  String get quranLineHeight => 'قرآن کی لائن ہائیٹ';

  @override
  String get translationAndTafsirFontSize => 'ترجمہ اور تفسیر کا فونٹ سائز';

  @override
  String get quranAyah => 'قرآن کی آیت';

  @override
  String get topToolbar => 'اوپر کا ٹول بار';

  @override
  String get keepOpenWordByWord => 'لفظ بہ لفظ کھلا رکھیں';

  @override
  String get wordByWordHighlight => 'لفظ بہ لفظ ہائی لائٹ';

  @override
  String get quranScriptSettings => 'قرآن کے رسم الخط کی ترتیبات';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'صفحہ: ';

  @override
  String get quranResources => 'قرآن کے وسائل';

  @override
  String alreadySelected(String name) {
    return 'زبان \'$name\' پہلے سے منتخب ہے۔';
  }

  @override
  String get unableToGetCompassData => 'کمپس کا ڈیٹا حاصل کرنے میں ناکام';

  @override
  String get deviceDoesNotHaveSensors => 'ڈیوائس میں سینسرز نہیں ہیں!';

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
  String get enforceAlarmSound => 'الارم کی آواز کو نافذ کریں';

  @override
  String get enforceAlarmSoundDescription =>
      'اگر فعال ہو تو، یہ فیچر الارم کو یہاں سیٹ کی گئی والیوم پر چلائے گا، چاہے آپ کے فون کی آواز کم ہو۔ یہ یقینی بناتا ہے کہ آپ کم فون والیوم کی وجہ سے الارم مس نہ کریں۔';

  @override
  String get volume => 'والیوم';

  @override
  String get atPrayerTime => 'نماز کے وقت پر';

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
    return '$prayerName کا وقت ہے';
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
    return '$prayerName کے لیے یاد دہانی شامل کی گئی';
  }

  @override
  String get allowNotificationPermission =>
      'اس فیچر کو استعمال کرنے کے لیے نوٹیفیکیشن کی اجازت دیں';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName کے لیے یاد دہانی ہٹا دی گئی';
  }

  @override
  String get getPrayerTimesAndQibla => 'نماز کے اوقات اور قبلہ حاصل کریں';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'کسی بھی دیے گئے مقام کے لیے نماز کے اوقات اور قبلہ کا حساب لگائیں۔';

  @override
  String get getFromGPS => 'جی پی ایس سے حاصل کریں';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'اپنا شہر منتخب کریں';

  @override
  String get noteAboutGPS =>
      'نوٹ: اگر آپ جی پی ایس استعمال نہیں کرنا چاہتے یا محفوظ محسوس نہیں کرتے، تو آپ اپنا شہر منتخب کر سکتے ہیں۔';

  @override
  String get downloadingLocationResources =>
      'مقام کے وسائل ڈاؤن لوڈ ہو رہے ہیں...';

  @override
  String get somethingWentWrong => 'کچھ غلط ہو گیا';

  @override
  String get selectYourCountry => 'اپنا ملک منتخب کریں';

  @override
  String get searchForACountry => 'ملک تلاش کریں';

  @override
  String get selectYourAdministrator => 'اپنا ایڈمنسٹریٹر منتخب کریں';

  @override
  String get searchForAnAdministrator => 'ایڈمنسٹریٹر تلاش کریں';

  @override
  String get searchForACity => 'شہر تلاش کریں';

  @override
  String get pleaseEnableLocationService =>
      'براہ مہربانی مقام کی سروس فعال کریں';

  @override
  String get donateUs => 'ہمیں عطیہ دیں';

  @override
  String get underDevelopment => 'ترقی کے مراحل میں';

  @override
  String get versionLoading => 'لوڈ ہو رہا ہے...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'مین مینو';

  @override
  String get notes => 'نوٹس';

  @override
  String get pinned => 'پن کیے گئے';

  @override
  String get jumpToAyah => 'آیت پر جائیں';

  @override
  String get shareMultipleAyah => 'کئی آیات شیئر کریں';

  @override
  String get shareThisApp => 'یہ ایپ شیئر کریں';

  @override
  String get giveRating => 'ریٹنگ دیں';

  @override
  String get bugReport => 'بگ رپورٹ';

  @override
  String get privacyPolicy => 'پرائیویسی پالیسی';

  @override
  String get aboutTheApp => 'ایپ کے بارے میں';

  @override
  String get resetTheApp => 'ایپ ری سیٹ کریں';

  @override
  String get resetAppWarningTitle => 'ایپ ڈیٹا ری سیٹ کریں';

  @override
  String get resetAppWarningMessage =>
      'کیا آپ واقعی ایپ ری سیٹ کرنا چاہتے ہیں؟ آپ کا تمام ڈیٹا ضائع ہو جائے گا، اور آپ کو ایپ کو شروع سے سیٹ اپ کرنا پڑے گا۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get reset => 'ری سیٹ';

  @override
  String get shareAppSubject => 'یہ القرآن ایپ چیک کریں!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام علیکم! یہ القرآن ایپ روزانہ پڑھنے اور غور و فکر کے لیے چیک کریں۔ یہ اللہ کے کلام سے جڑنے میں مدد کرتی ہے۔ یہاں سے ڈاؤن لوڈ کریں: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ڈراور کھولیں';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'نماز';

  @override
  String get qibla => 'قبلہ';

  @override
  String get audio => 'آڈیو';

  @override
  String get surah => 'سورہ';

  @override
  String get pages => 'صفحات';

  @override
  String get note => 'نوٹ:';

  @override
  String get linkedAyahs => 'منسلک آیات:';

  @override
  String get emptyNoteCollection =>
      'یہ نوٹ کلیکشن خالی ہے۔\nیہاں دیکھنے کے لیے کچھ نوٹس شامل کریں۔';

  @override
  String get emptyPinnedCollection =>
      'ابھی تک اس کلیکشن میں کوئی آیات پن نہیں کی گئیں۔\nیہاں دیکھنے کے لیے آیات پن کریں۔';

  @override
  String get noContentAvailable => 'کوئی مواد دستیاب نہیں ہے۔';

  @override
  String failedToLoadCollections(String error) {
    return 'کلیکشنز لوڈ کرنے میں ناکام: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType نام سے تلاش کریں...';
  }

  @override
  String get sortBy => 'ترتیب سے';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'ابھی تک کوئی $collectionType شامل نہیں کیا گیا';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count پن کیے گئے آئٹمز';
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
  String get collectionNameCannotBeEmpty => 'کلیکشن کا نام خالی نہیں ہو سکتا۔';

  @override
  String get addedNewCollection => 'نئی کلیکشن شامل کی گئی';

  @override
  String ayahCount(int count) {
    return '$count آیت';
  }

  @override
  String get byNameAtoZ => 'نام A-Z';

  @override
  String get byNameZtoA => 'نام Z-A';

  @override
  String get byElementNumberAscending => 'عنصر نمبر بڑھتا ہوا';

  @override
  String get byElementNumberDescending => 'عنصر نمبر گھٹتا ہوا';

  @override
  String get byUpdateDateAscending => 'اپ ڈیٹ کی تاریخ بڑھتی ہوئی';

  @override
  String get byUpdateDateDescending => 'اپ ڈیٹ کی تاریخ گھٹتی ہوئی';

  @override
  String get byCreateDateAscending => 'تخلیق کی تاریخ بڑھتی ہوئی';

  @override
  String get byCreateDateDescending => 'تخلیق کی تاریخ گھٹتی ہوئی';

  @override
  String get translationNotFound => 'ترجمہ نہیں ملا';

  @override
  String get translationTitle => 'ترجمہ:';

  @override
  String get footNoteTitle => 'فٹ نوٹ:';

  @override
  String get wordByWordTranslation => 'لفظ بہ لفظ ترجمہ:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'شیئر';

  @override
  String get addNoteButton => 'نوٹ شامل کریں';

  @override
  String get pinToCollectionButton => 'کلیکشن میں پن کریں';

  @override
  String get shareAsText => 'متن کی صورت میں شیئر کریں';

  @override
  String get copiedWithTafsir => 'تفسیر کے ساتھ کاپی کیا گیا';

  @override
  String get shareAsImage => 'تصویر کی صورت میں شیئر کریں';

  @override
  String get shareWithTafsir => 'تفسیر کے ساتھ شیئر کریں';

  @override
  String get notFound => 'نہیں ملا';

  @override
  String get noteContentCannotBeEmpty => 'نوٹ کا مواد خالی نہیں ہو سکتا۔';

  @override
  String get noteSavedSuccessfully => 'نوٹ کامیابی سے محفوظ ہو گیا!';

  @override
  String get selectCollections => 'کلیکشنز منتخب کریں';

  @override
  String get addNote => 'نوٹ شامل کریں';

  @override
  String get writeCollectionName => 'کلیکشن کا نام لکھیں...';

  @override
  String get noCollectionsYetAddANewOne =>
      'ابھی تک کوئی کلیکشن نہیں۔ ایک نئی شامل کریں!';

  @override
  String get pleaseWriteYourNoteFirst => 'براہ مہربانی پہلے اپنا نوٹ لکھیں۔';

  @override
  String get noCollectionSelected => 'کوئی کلیکشن منتخب نہیں کی گئی';

  @override
  String get saveNote => 'نوٹ محفوظ کریں';

  @override
  String get nextSelectCollections => 'اگلا: کلیکشنز منتخب کریں';

  @override
  String get addToPinned => 'پن کیے گئے میں شامل کریں';

  @override
  String get pinnedSavedSuccessfully => 'پن کامیابی سے محفوظ ہو گیا!';

  @override
  String get savePinned => 'پن محفوظ کریں';

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
  String get playAsPlaylist => 'پلے لسٹ کی طرح چلائیں';

  @override
  String style(String style) {
    return 'انداز: $style';
  }

  @override
  String get stopAndClose => 'روکیں اور بند کریں';

  @override
  String get play => 'چلائیں';

  @override
  String get pause => 'روکیں';

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
  String get cacheNotFound => 'کیچ نہیں ملا';

  @override
  String get cacheSize => 'کیچ کا سائز';

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
    return '$number مہینے پہلے';
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
      'ایک جامع اسلامی ایپلیکیشن اینڈرائیڈ، آئی او ایس، میک او ایس، ویب، لینکس اور ونڈوز کے لیے، جو قرآن کی تفسیر اور متعدد تراجم (بشمول لفظ بہ لفظ) کے ساتھ پڑھنے، دنیا بھر کے نماز کے اوقات نوٹیفیکیشنز کے ساتھ، قبلہ کمپاس، اور سنکرونائزڈ لفظ بہ لفظ آڈیو تلاوت پیش کرتی ہے۔';

  @override
  String get dataSourcesNote =>
      'نوٹ: قرآن کے متن، تفسیر، تراجم، اور آڈیو وسائل Quran.com، Everyayah.com، اور دیگر تصدیق شدہ اوپن سورس سے لیے گئے ہیں۔';

  @override
  String get adFreePromise =>
      'یہ ایپ اللہ کی خوشنودی حاصل کرنے کے لیے بنائی گئی ہے۔ اس لیے یہ مکمل طور پر اور ہمیشہ ایڈ فری رہے گی۔';

  @override
  String get coreFeatures => 'بنیادی فیچرز';

  @override
  String get coreFeaturesDescription =>
      'القرآن v3 کے کلیدی فنکشنز کو دریافت کریں جو آپ کی روزانہ اسلامی عبادات کے لیے ایک ناگزیر ٹول بناتے ہیں:';

  @override
  String get prayerTimesTitle => 'نماز کے اوقات اور الرٹس';

  @override
  String get prayerTimesDescription =>
      'دنیا بھر کے کسی بھی مقام کے لیے درست نماز کے اوقات مختلف حساب کے طریقوں کا استعمال کرتے ہوئے۔ اذان نوٹیفیکیشنز کے ساتھ یاد دہانیاں سیٹ کریں۔';

  @override
  String get qiblaDirectionTitle => 'قبلہ کی سمت';

  @override
  String get qiblaDirectionDescription =>
      'واضح اور درست کمپاس ویو کے ساتھ قبلہ کی سمت آسانی سے تلاش کریں۔';

  @override
  String get translationTafsirTitle => 'قرآن کا ترجمہ اور تفسیر';

  @override
  String get translationTafsirDescription =>
      '69 زبانوں میں 120+ ترجمہ کی کتابیں (بشمول لفظ بہ لفظ) اور 30+ تفسیر کی کتابیں حاصل کریں۔';

  @override
  String get wordByWordAudioTitle => 'لفظ بہ لفظ آڈیو اور ہائی لائٹنگ';

  @override
  String get wordByWordAudioDescription =>
      'ایک immersive لرننگ تجربے کے لیے سنکرونائزڈ لفظ بہ لفظ آڈیو تلاوت اور ہائی لائٹنگ کے ساتھ ساتھ چلیں۔';

  @override
  String get ayahAudioRecitationTitle => 'آیت کی آڈیو تلاوت';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ مشہور قاریوں سے مکمل آیت کی تلاوت سنیں۔';

  @override
  String get notesCloudBackupTitle => 'نوٹس کلاؤڈ بیک اپ کے ساتھ';

  @override
  String get notesCloudBackupDescription =>
      'ذاتی نوٹس اور غور و فکر محفوظ کریں، کلاؤڈ پر محفوظ بیک اپ (فیچر ترقی کے مراحل میں/جلد آ رہا ہے)۔';

  @override
  String get crossPlatformSupportTitle => 'کراس پلیٹ فارم سپورٹ';

  @override
  String get crossPlatformSupportDescription =>
      'اینڈرائیڈ، ویب، لینکس، اور ونڈوز پر سپورٹڈ۔';

  @override
  String get backgroundAudioPlaybackTitle => 'بیک گراؤنڈ آڈیو پلے بیک';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ایپ بیک گراؤنڈ میں ہونے پر بھی قرآن کی تلاوت سنتے رہیں۔';

  @override
  String get audioDataCachingTitle => 'آڈیو اور ڈیٹا کیچنگ';

  @override
  String get audioDataCachingDescription =>
      'آف لائن صلاحیتوں اور بہتر پلے بیک کے لیے مضبوط آڈیو اور قرآن ڈیٹا کیچنگ۔';

  @override
  String get minimalisticInterfaceTitle => 'منیملسٹک اور کلین انٹرفیس';

  @override
  String get minimalisticInterfaceDescription =>
      'یوزر تجربے اور پڑھنے کی آسانی پر توجہ کے ساتھ نیویگیٹ کرنے میں آسان انٹرفیس۔';

  @override
  String get optimizedPerformanceTitle => 'آپٹمائزڈ پرفارمنس اور سائز';

  @override
  String get optimizedPerformanceDescription =>
      'ایک فیچر سے بھرپور ایپلیکیشن جو ہلکی اور پرفارمنٹ ہونے کے لیے ڈیزائن کی گئی ہے۔';

  @override
  String get languageSupport => 'زبان کی سپورٹ';

  @override
  String get languageSupportDescription =>
      'یہ ایپلیکیشن عالمی سامعین کے لیے قابل رسائی ہونے کے لیے ڈیزائن کی گئی ہے جس میں درج ذیل زبانوں کی سپورٹ ہے (اور مزید مسلسل شامل کی جا رہی ہیں):';

  @override
  String get technologyAndResources => 'ٹیکنالوجی اور وسائل';

  @override
  String get technologyAndResourcesDescription =>
      'یہ ایپ جدید ٹیکنالوجیز اور قابل اعتماد وسائل کا استعمال کرتے ہوئے بنائی گئی ہے:';

  @override
  String get flutterFrameworkTitle => 'فلٹر فریم ورک';

  @override
  String get flutterFrameworkDescription =>
      'فلٹر کے ساتھ بنائی گئی ایک خوبصورت، نیٹولی کمپائلڈ، ملٹی پلیٹ فارم تجربے کے لیے ایک سنگل کوڈ بیس سے۔';

  @override
  String get advancedAudioEngineTitle => 'ایڈوانسڈ آڈیو انجن';

  @override
  String get advancedAudioEngineDescription =>
      'just_audio اور just_audio_background فلٹر پیکیجز سے چلنے والا مضبوط آڈیو پلے بیک اور کنٹرول۔';

  @override
  String get reliableQuranDataTitle => 'قابل اعتماد قرآن ڈیٹا';

  @override
  String get reliableQuranDataDescription =>
      'القرآن کے متن، تراجم، تفاسیر، اور آڈیو تصدیق شدہ اوپن APIs اور ڈیٹا بیسز جیسے Quran.com اور Everyayah.com سے لیے گئے ہیں۔';

  @override
  String get prayerTimeEngineTitle => 'نماز کے وقت کا انجن';

  @override
  String get prayerTimeEngineDescription =>
      'درست نماز کے اوقات کے لیے قائم شدہ حساب کے طریقے استعمال کرتا ہے۔ نوٹیفیکیشنز flutter_local_notifications اور بیک گراؤنڈ ٹاسکس سے ہینڈل کیے جاتے ہیں۔';

  @override
  String get crossPlatformSupport => 'کراس پلیٹ فارم سپورٹ';

  @override
  String get crossPlatformSupportDescription2 =>
      'مختلف پلیٹ فارمز پر بغیر کسی رکاوٹ کے رسائی حاصل کریں:';

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
  String get ourLifetimePromise => 'ہمارا لائف ٹائم وعدہ';

  @override
  String get lifetimePromiseDescription =>
      'میں ذاتی طور پر اس ایپلیکیشن کی لائف ٹائم سپورٹ اور مینٹیننس فراہم کرنے کا وعدہ کرتا ہوں، ان شاء اللہ۔ میرا مقصد یہ یقینی بنانا ہے کہ یہ ایپ امت کے لیے آنے والے سالوں میں ایک مفید وسیلہ رہے۔';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'طلوع آفتاب';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'ظہر';

  @override
  String get asr => 'عصر';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get midnight => 'نصف شب';

  @override
  String get alarm => 'الارم';

  @override
  String get notification => 'نوٹیفیکیشن';

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
  String get quranScriptIndopak => 'انڈو پاک';

  @override
  String get sajdaAyah => 'سجدہ کی آیت';

  @override
  String get required => 'ضروری';

  @override
  String get optional => 'اختیاری';

  @override
  String get notificationScheduleWarning =>
      'نوٹ: شیڈولڈ نوٹیفیکیشن یا یاد دہانی آپ کے فون کی OS بیک گراؤنڈ پروسیس پابندیوں کی وجہ سے مس ہو سکتی ہے۔ مثال کے طور پر: Vivo کی Origin OS، Samsung کی One UI، Oppo کی ColorOS وغیرہ کبھی کبھی شیڈولڈ نوٹیفیکیشن یا یاد دہانی کو ختم کر دیتے ہیں۔ براہ مہربانی اپنے OS کی ترتیبات چیک کریں تاکہ ایپ کو بیک گراؤنڈ پروسیس سے محدود نہ کیا جائے۔';

  @override
  String get scrollWithRecitation => 'تلاوت کے ساتھ اسکرول کریں';

  @override
  String get quickAccess => 'فوری رسائی';

  @override
  String get initiallyScrollAyah => 'شروع میں آیت پر اسکرول کریں';

  @override
  String get tajweedGuide => 'تجوید گائیڈ';

  @override
  String get scrollWithRecitationDesc =>
      'فعال ہونے پر، قرآن کی آیت آڈیو تلاوت کے ساتھ خود بخود اسکرول ہو گی۔';

  @override
  String get configuration => 'کنفیگریشن';

  @override
  String get restoreFromBackup => 'بیک اپ سے بحال کریں';

  @override
  String get history => 'تاریخ';

  @override
  String get search => 'تلاش';

  @override
  String get useAudioStream => 'آڈیو اسٹریم استعمال کریں';

  @override
  String get useAudioStreamDesc =>
      'انٹرنیٹ سے براہ راست آڈیو اسٹریم کریں بجائے ڈاؤن لوڈ کرنے کے۔';

  @override
  String get notUseAudioStreamDesc =>
      'آف لائن استعمال کے لیے آڈیو ڈاؤن لوڈ کریں اور ڈیٹا کی کھپت کم کریں۔';

  @override
  String get audioSettings => 'آڈیو ترتیبات';

  @override
  String get playbackSpeed => 'پلے بیک کی رفتار';

  @override
  String get playbackSpeedDesc => 'قرآن کی تلاوت کی رفتار ایڈجسٹ کریں۔';

  @override
  String get waitForCurrentDownloadToFinish =>
      'براہ مہربانی موجودہ ڈاؤن لوڈ ختم ہونے کا انتظار کریں۔';

  @override
  String get areYouSure => 'کیا آپ یقینی ہیں؟';

  @override
  String get checkYourInternetConnection => 'اپنا انٹرنیٹ کنکشن چیک کریں۔';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount آیات میں سے $requiredDownload ڈاؤن لوڈ کرنے کی ضرورت ہے۔';
  }

  @override
  String get download => 'ڈاؤن لوڈ';

  @override
  String get audioDownload => 'آڈیو ڈاؤن لوڈ';

  @override
  String get am => 'صبح';

  @override
  String get pm => 'شام';

  @override
  String get optimizingQuranScript => 'قرآن کے رسم الخط کو آپٹمائز کر رہے ہیں';

  @override
  String get supportOnGithub => 'گٹ ہب پر حمایت';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafieMalikiHanbali => 'Shafie, Maliki, Hanbali';

  @override
  String get suhurEndTime => 'Suhur End Time';

  @override
  String get iftarStartTime => 'Iftar Start Time';

  @override
  String get tahajjudStartTime => 'Tahajjud Start Time';
}
