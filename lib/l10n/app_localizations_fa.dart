// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'تفسیر برای $ayahKey موجود نیست';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر در: $anotherAyahLinkKey یافت می‌شود';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'پرش به $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جزء';

  @override
  String get page => 'صفحه';

  @override
  String get ruku => 'رکوع';

  @override
  String get languageSettings => 'تنظیمات زبان';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count آیه';
  }

  @override
  String get saveAndDownload => 'ذخیره و دانلود';

  @override
  String get appLanguage => 'زبان برنامه';

  @override
  String get selectAppLanguage => 'انتخاب زبان برنامه...';

  @override
  String get pleaseSelectOne => 'لطفاً یکی را انتخاب کنید';

  @override
  String get quranTranslationLanguage => 'زبان ترجمه قرآن';

  @override
  String get selectTranslationLanguage => 'انتخاب زبان ترجمه...';

  @override
  String get quranTranslationBook => 'کتاب ترجمه قرآن';

  @override
  String get selectTranslationBook => 'انتخاب کتاب ترجمه...';

  @override
  String get quranTafsirLanguage => 'زبان تفسیر قرآن';

  @override
  String get selectTafsirLanguage => 'انتخاب زبان تفسیر...';

  @override
  String get quranTafsirBook => 'کتاب تفسیر قرآن';

  @override
  String get selectTafsirBook => 'انتخاب کتاب تفسیر...';

  @override
  String get quranScriptAndStyle => 'خط و سبک قرآن';

  @override
  String get justAMoment => 'یک لحظه صبر کنید...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'موفقیت';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get unableToDownloadResources =>
      'ناتوان در دانلود منابع...\nچیزی اشتباه رخ داد';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'دانلود قرائت بخش‌بندی‌شده قرآن';

  @override
  String get processingSegmentedQuranRecitation =>
      'پردازش قرائت بخش‌بندی‌شده قرآن';

  @override
  String get footnote => 'پانویس';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'کلمه به کلمه';

  @override
  String get pleaseSelectRequiredOption =>
      'لطفاً گزینه مورد نیاز را انتخاب کنید';

  @override
  String get rememberHomeTab => 'به خاطر سپردن تب اصلی';

  @override
  String get rememberHomeTabSubtitle =>
      'برنامه آخرین تب باز شده در صفحه اصلی را به خاطر می‌سپارد.';

  @override
  String get wakeLock => 'قفل بیداری';

  @override
  String get wakeLockSubtitle => 'جلوگیری از خاموش شدن خودکار صفحه.';

  @override
  String get settings => 'تنظیمات';

  @override
  String get appTheme => 'تم برنامه';

  @override
  String get quranStyle => 'سبک قرآن';

  @override
  String get changeTheme => 'تغییر تم';

  @override
  String get verseCount => 'تعداد آیه: ';

  @override
  String get translation => 'ترجمه';

  @override
  String get tafsirNotFound => 'پیدا نشد';

  @override
  String get moreInfo => 'اطلاعات بیشتر';

  @override
  String get playAudio => 'پخش صدا';

  @override
  String get preview => 'پیش‌نمایش';

  @override
  String get loading => 'در حال بارگیری...';

  @override
  String get errorFetchingAddress => 'خطا در دریافت آدرس';

  @override
  String get addressNotAvailable => 'آدرس موجود نیست';

  @override
  String get latitude => 'عرض جغرافیایی: ';

  @override
  String get longitude => 'طول جغرافیایی: ';

  @override
  String get name => 'نام: ';

  @override
  String get location => 'مکان: ';

  @override
  String get parameters => 'پارامترها: ';

  @override
  String get selectCalculationMethod => 'انتخاب روش محاسبه';

  @override
  String get shareSelectAyahs => 'اشتراک‌گذاری آیه‌های انتخاب‌شده';

  @override
  String get selectionEmpty => 'انتخاب خالی است';

  @override
  String get generatingImagePleaseWait =>
      'در حال تولید تصویر... لطفاً صبر کنید';

  @override
  String get asImage => 'به عنوان تصویر';

  @override
  String get asText => 'به عنوان متن';

  @override
  String get playFromSelectedAyah => 'پخش از آیه انتخاب‌شده';

  @override
  String get toTafsir => 'به تفسیر';

  @override
  String get selectAyah => 'انتخاب آیه';

  @override
  String get toAyah => 'به آیه';

  @override
  String get searchForASurah => 'جستجو برای یک سوره';

  @override
  String get bugReportTitle => 'گزارش باگ';

  @override
  String get audioCached => 'صدا کش شده';

  @override
  String get others => 'دیگران';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن|ترجمه|آیه، یکی باید فعال باشد';

  @override
  String get quranFontSize => 'اندازه فونت قرآن';

  @override
  String get quranLineHeight => 'ارتفاع خط قرآن';

  @override
  String get translationAndTafsirFontSize => 'اندازه فونت ترجمه و تفسیر';

  @override
  String get quranAyah => 'آیه قرآن';

  @override
  String get topToolbar => 'نوار ابزار بالا';

  @override
  String get keepOpenWordByWord => 'باز نگه داشتن کلمه به کلمه';

  @override
  String get wordByWordHighlight => 'برجسته کردن کلمه به کلمه';

  @override
  String get quranScriptSettings => 'تنظیمات خط قرآن';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'شماره صفحه: ';

  @override
  String get quranResources => 'منابع قرآن';

  @override
  String alreadySelected(String name) {
    return 'زبان \'$name\' قبلاً انتخاب شده است.';
  }

  @override
  String get unableToGetCompassData => 'ناتوان در دریافت داده‌های قطب‌نما';

  @override
  String get deviceDoesNotHaveSensors => 'دستگاه سنسور ندارد!';

  @override
  String get north => 'شمال';

  @override
  String get east => 'شرق';

  @override
  String get south => 'جنوب';

  @override
  String get west => 'غرب';

  @override
  String get address => 'آدرس: ';

  @override
  String get change => 'تغییر';

  @override
  String get calculationMethod => 'روش محاسبه: ';

  @override
  String get downloadPrayerTime => 'دانلود زمان نماز';

  @override
  String get calculationMethodsListEmpty => 'لیست روش‌های محاسبه خالی است.';

  @override
  String get noCalculationMethodWithLocationData =>
      'هیچ روش محاسبه‌ای با داده‌های مکان پیدا نشد.';

  @override
  String get prayerSettings => 'تنظیمات نماز';

  @override
  String get reminderSettings => 'تنظیمات یادآوری';

  @override
  String get adjustReminderTime => 'تنظیم زمان یادآوری';

  @override
  String get enforceAlarmSound => 'اجبار صدای زنگ';

  @override
  String get enforceAlarmSoundDescription =>
      'اگر فعال باشد، این ویژگی زنگ را با صدای تنظیم‌شده اینجا پخش می‌کند، حتی اگر صدای گوشی کم باشد. این اطمینان می‌دهد که زنگ را به دلیل صدای کم گوشی از دست ندهید.';

  @override
  String get volume => 'صدا';

  @override
  String get atPrayerTime => 'در زمان نماز';

  @override
  String minBefore(int minutes) {
    return '$minutes دقیقه قبل';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes دقیقه بعد';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName در $prayerTime است';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'زمان $prayerName است';
  }

  @override
  String get stopTheAdhan => 'توقف اذان';

  @override
  String dateFoundEmpty(String date) {
    return '$date خالی یافت شد';
  }

  @override
  String get today => 'امروز';

  @override
  String get left => 'باقیمانده';

  @override
  String reminderAdded(String prayerName) {
    return 'یادآوری برای $prayerName اضافه شد';
  }

  @override
  String get allowNotificationPermission =>
      'لطفاً مجوز اعلان را اجازه دهید تا از این ویژگی استفاده کنید';

  @override
  String reminderRemoved(String prayerName) {
    return 'یادآوری برای $prayerName حذف شد';
  }

  @override
  String get getPrayerTimesAndQibla => 'دریافت زمان‌های نماز و قبله';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'محاسبه زمان‌های نماز و قبله برای هر مکان داده‌شده.';

  @override
  String get getFromGPS => 'دریافت از GPS';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'انتخاب شهر شما';

  @override
  String get noteAboutGPS =>
      'توجه: اگر نمی‌خواهید از GPS استفاده کنید یا احساس امنیت نمی‌کنید، می‌توانید شهر خود را انتخاب کنید.';

  @override
  String get downloadingLocationResources => 'دانلود منابع مکان...';

  @override
  String get somethingWentWrong => 'چیزی اشتباه رخ داد';

  @override
  String get selectYourCountry => 'انتخاب کشور شما';

  @override
  String get searchForACountry => 'جستجو برای یک کشور';

  @override
  String get selectYourAdministrator => 'انتخاب مدیر شما';

  @override
  String get searchForAnAdministrator => 'جستجو برای یک مدیر';

  @override
  String get searchForACity => 'جستجو برای یک شهر';

  @override
  String get pleaseEnableLocationService => 'لطفاً سرویس مکان را فعال کنید';

  @override
  String get donateUs => 'کمک مالی به ما';

  @override
  String get underDevelopment => 'در حال توسعه';

  @override
  String get versionLoading => 'در حال بارگیری...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'منوی اصلی';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get pinned => 'سنجاق‌شده';

  @override
  String get jumpToAyah => 'پرش به آیه';

  @override
  String get shareMultipleAyah => 'اشتراک‌گذاری چندین آیه';

  @override
  String get shareThisApp => 'اشتراک‌گذاری این برنامه';

  @override
  String get giveRating => 'دادن امتیاز';

  @override
  String get bugReport => 'گزارش باگ';

  @override
  String get privacyPolicy => 'سیاست حفظ حریم خصوصی';

  @override
  String get aboutTheApp => 'درباره برنامه';

  @override
  String get resetTheApp => 'بازنشانی برنامه';

  @override
  String get resetAppWarningTitle => 'بازنشانی داده‌های برنامه';

  @override
  String get resetAppWarningMessage =>
      'آیا مطمئن هستید که می‌خواهید برنامه را بازنشانی کنید؟ تمام داده‌های شما از دست خواهد رفت و باید برنامه را از ابتدا تنظیم کنید.';

  @override
  String get cancel => 'لغو';

  @override
  String get reset => 'بازنشانی';

  @override
  String get shareAppSubject => 'این برنامه القرآن را بررسی کنید!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام علیکم! این برنامه القرآن را برای خواندن و تأمل روزانه بررسی کنید. کمک می‌کند با کلمات الله ارتباط برقرار کنید. اینجا دانلود کنید: $appLink';
  }

  @override
  String get openDrawerTooltip => 'باز کردن کشو';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'نماز';

  @override
  String get qibla => 'قبله';

  @override
  String get audio => 'صدا';

  @override
  String get surah => 'سوره';

  @override
  String get pages => 'صفحات';

  @override
  String get note => 'یادداشت:';

  @override
  String get linkedAyahs => 'آیه‌های مرتبط:';

  @override
  String get emptyNoteCollection =>
      'این مجموعه یادداشت خالی است.\nچند یادداشت اضافه کنید تا اینجا ببینید.';

  @override
  String get emptyPinnedCollection =>
      'هنوز هیچ آیه‌ای به این مجموعه سنجاق نشده است.\nآیه‌ها را سنجاق کنید تا اینجا ببینید.';

  @override
  String get noContentAvailable => 'محتوایی موجود نیست.';

  @override
  String failedToLoadCollections(String error) {
    return 'بارگیری مجموعه‌ها شکست خورد: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'جستجو بر اساس نام $collectionType...';
  }

  @override
  String get sortBy => 'مرتب‌سازی بر اساس';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'هنوز هیچ $collectionType اضافه نشده است';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count مورد سنجاق‌شده';
  }

  @override
  String notesCount(int count) {
    return '$count یادداشت';
  }

  @override
  String get emptyNameNotAllowed => 'نام خالی مجاز نیست';

  @override
  String updatedTo(String collectionName) {
    return 'به‌روزرسانی به $collectionName';
  }

  @override
  String get changeName => 'تغییر نام';

  @override
  String get changeColor => 'تغییر رنگ';

  @override
  String get colorUpdated => 'رنگ به‌روزرسانی شد';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName حذف شد';
  }

  @override
  String get delete => 'حذف';

  @override
  String get save => 'ذخیره';

  @override
  String get collectionNameCannotBeEmpty => 'نام مجموعه نمی‌تواند خالی باشد.';

  @override
  String get addedNewCollection => 'مجموعه جدید اضافه شد';

  @override
  String ayahCount(int count) {
    return '$count آیه';
  }

  @override
  String get byNameAtoZ => 'نام الف تا ی';

  @override
  String get byNameZtoA => 'نام ی تا الف';

  @override
  String get byElementNumberAscending => 'شماره عنصر صعودی';

  @override
  String get byElementNumberDescending => 'شماره عنصر نزولی';

  @override
  String get byUpdateDateAscending => 'تاریخ به‌روزرسانی صعودی';

  @override
  String get byUpdateDateDescending => 'تاریخ به‌روزرسانی نزولی';

  @override
  String get byCreateDateAscending => 'تاریخ ایجاد صعودی';

  @override
  String get byCreateDateDescending => 'تاریخ ایجاد نزولی';

  @override
  String get translationNotFound => 'ترجمه پیدا نشد';

  @override
  String get translationTitle => 'ترجمه:';

  @override
  String get footNoteTitle => 'پانویس:';

  @override
  String get wordByWordTranslation => 'ترجمه کلمه به کلمه:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'اشتراک‌گذاری';

  @override
  String get addNoteButton => 'اضافه کردن یادداشت';

  @override
  String get pinToCollectionButton => 'سنجاق به مجموعه';

  @override
  String get shareAsText => 'اشتراک‌گذاری به عنوان متن';

  @override
  String get copiedWithTafsir => 'کپی شده با تفسیر';

  @override
  String get shareAsImage => 'اشتراک‌گذاری به عنوان تصویر';

  @override
  String get shareWithTafsir => 'اشتراک‌گذاری با تفسیر';

  @override
  String get notFound => 'پیدا نشد';

  @override
  String get noteContentCannotBeEmpty => 'محتوای یادداشت نمی‌تواند خالی باشد.';

  @override
  String get noteSavedSuccessfully => 'یادداشت با موفقیت ذخیره شد!';

  @override
  String get selectCollections => 'انتخاب مجموعه‌ها';

  @override
  String get addNote => 'اضافه کردن یادداشت';

  @override
  String get writeCollectionName => 'نوشتن نام مجموعه...';

  @override
  String get noCollectionsYetAddANewOne =>
      'هنوز هیچ مجموعه‌ای نیست. یکی جدید اضافه کنید!';

  @override
  String get pleaseWriteYourNoteFirst => 'لطفاً اول یادداشت خود را بنویسید.';

  @override
  String get noCollectionSelected => 'هیچ مجموعه‌ای انتخاب نشده';

  @override
  String get saveNote => 'ذخیره یادداشت';

  @override
  String get nextSelectCollections => 'بعدی: انتخاب مجموعه‌ها';

  @override
  String get addToPinned => 'اضافه به سنجاق‌شده';

  @override
  String get pinnedSavedSuccessfully => 'سنجاق با موفقیت ذخیره شد!';

  @override
  String get savePinned => 'ذخیره سنجاق';

  @override
  String get closeAudioController => 'بستن کنترلر صدا';

  @override
  String get previous => 'قبلی';

  @override
  String get rewind => 'عقب بردن';

  @override
  String get fastForward => 'جلو بردن';

  @override
  String get playNextAyah => 'پخش آیه بعدی';

  @override
  String get repeat => 'تکرار';

  @override
  String get playAsPlaylist => 'پخش به عنوان لیست پخش';

  @override
  String style(String style) {
    return 'سبک: $style';
  }

  @override
  String get stopAndClose => 'توقف و بستن';

  @override
  String get play => 'پخش';

  @override
  String get pause => 'مکث';

  @override
  String get selectReciter => 'انتخاب قاری';

  @override
  String source(String source) {
    return 'منبع: $source';
  }

  @override
  String get newText => 'جدید';

  @override
  String get more => 'بیشتر: ';

  @override
  String get cacheNotFound => 'کش پیدا نشد';

  @override
  String get cacheSize => 'اندازه کش';

  @override
  String error(String error) {
    return 'خطا: $error';
  }

  @override
  String get clean => 'پاک کردن';

  @override
  String get lastModified => 'آخرین تغییر';

  @override
  String get oneYearAgo => '1 سال پیش';

  @override
  String monthsAgo(String number) {
    return '$number ماه پیش';
  }

  @override
  String weeksAgo(String number) {
    return '$number هفته پیش';
  }

  @override
  String daysAgo(String number) {
    return '$number روز پیش';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour ساعت پیش';
  }

  @override
  String get aboutAlQuran => 'درباره القرآن';

  @override
  String get appFullName => 'القرآن (تفسیر، نماز، قبله، صدا)';

  @override
  String get appDescription =>
      'یک برنامه اسلامی جامع برای اندروید، iOS، مک‌اواس، وب، لینوکس و ویندوز، که خواندن قرآن با تفسیر و ترجمه‌های متعدد (شامل کلمه به کلمه)، زمان‌های نماز جهانی با اعلان‌ها، قطب‌نمای قبله، و قرائت صوتی کلمه به کلمه همگام‌سازی‌شده را ارائه می‌دهد.';

  @override
  String get dataSourcesNote =>
      'توجه: متن‌های قرآن، تفسیر، ترجمه‌ها و منابع صوتی از Quran.com، Everyayah.com و دیگر منابع باز معتبر گرفته شده‌اند.';

  @override
  String get adFreePromise =>
      'این برنامه برای کسب رضایت الله ساخته شده است. بنابراین، کاملاً بدون تبلیغات است و همیشه خواهد بود.';

  @override
  String get coreFeatures => 'ویژگی‌های اصلی';

  @override
  String get coreFeaturesDescription =>
      'ویژگی‌های کلیدی را کاوش کنید که Al Quran v3 را به ابزاری ضروری برای اعمال اسلامی روزانه شما تبدیل می‌کند:';

  @override
  String get prayerTimesTitle => 'زمان‌های نماز و هشدارها';

  @override
  String get prayerTimesDescription =>
      'زمان‌بندی دقیق نماز برای هر مکان جهانی با استفاده از روش‌های محاسبه مختلف. تنظیم یادآوری با اعلان‌های اذان.';

  @override
  String get qiblaDirectionTitle => 'جهت قبله';

  @override
  String get qiblaDirectionDescription =>
      'به راحتی جهت قبله را با نمای قطب‌نمای واضح و دقیق پیدا کنید.';

  @override
  String get translationTafsirTitle => 'ترجمه و تفسیر قرآن';

  @override
  String get translationTafsirDescription =>
      'دسترسی به بیش از 120 کتاب ترجمه (شامل کلمه به کلمه) در 69 زبان، و بیش از 30 کتاب تفسیر.';

  @override
  String get wordByWordAudioTitle => 'صدا و برجسته کردن کلمه به کلمه';

  @override
  String get wordByWordAudioDescription =>
      'با قرائت صوتی کلمه به کلمه همگام‌سازی‌شده و برجسته کردن برای تجربه یادگیری غوطه‌ور دنبال کنید.';

  @override
  String get ayahAudioRecitationTitle => 'قرائت صوتی آیه';

  @override
  String get ayahAudioRecitationDescription =>
      'گوش دادن به قرائت‌های کامل آیه از بیش از 40 قاری مشهور.';

  @override
  String get notesCloudBackupTitle => 'یادداشت‌ها با پشتیبان‌گیری ابری';

  @override
  String get notesCloudBackupDescription =>
      'ذخیره یادداشت‌ها و تأملات شخصی، با پشتیبان‌گیری امن به ابر (ویژگی در حال توسعه/به زودی).';

  @override
  String get crossPlatformSupportTitle => 'پشتیبانی چندپلتفرمی';

  @override
  String get crossPlatformSupportDescription =>
      'پشتیبانی‌شده در اندروید، وب، لینوکس و ویندوز.';

  @override
  String get backgroundAudioPlaybackTitle => 'پخش صدا در پس‌زمینه';

  @override
  String get backgroundAudioPlaybackDescription =>
      'ادامه گوش دادن به قرائت قرآن حتی وقتی برنامه در پس‌زمینه است.';

  @override
  String get audioDataCachingTitle => 'کش صدا و داده';

  @override
  String get audioDataCachingDescription =>
      'پخش بهبودیافته و قابلیت آفلاین با کش قوی صدا و داده‌های قرآن.';

  @override
  String get minimalisticInterfaceTitle => 'رابط مینیمالیستی و تمیز';

  @override
  String get minimalisticInterfaceDescription =>
      'رابط آسان برای ناوبری با تمرکز بر تجربه کاربر و خوانایی.';

  @override
  String get optimizedPerformanceTitle => 'عملکرد و اندازه بهینه‌شده';

  @override
  String get optimizedPerformanceDescription =>
      'یک برنامه غنی از ویژگی که سبک و کارآمد طراحی شده است.';

  @override
  String get languageSupport => 'پشتیبانی زبان';

  @override
  String get languageSupportDescription =>
      'این برنامه برای مخاطبان جهانی با پشتیبانی از زبان‌های زیر طراحی شده است (و بیشتر به طور مداوم اضافه می‌شود):';

  @override
  String get technologyAndResources => 'فناوری و منابع';

  @override
  String get technologyAndResourcesDescription =>
      'این برنامه با استفاده از فناوری‌های پیشرفته و منابع معتبر ساخته شده است:';

  @override
  String get flutterFrameworkTitle => 'چارچوب فلاتر';

  @override
  String get flutterFrameworkDescription =>
      'ساخته‌شده با فلاتر برای تجربه زیبا، کامپایل‌شده محلی، چندپلتفرمی از یک کدبیس واحد.';

  @override
  String get advancedAudioEngineTitle => 'موتور صوتی پیشرفته';

  @override
  String get advancedAudioEngineDescription =>
      'توسط بسته‌های فلاتر just_audio و just_audio_background برای پخش و کنترل صوتی قوی پشتیبانی می‌شود.';

  @override
  String get reliableQuranDataTitle => 'داده‌های قرآن معتبر';

  @override
  String get reliableQuranDataDescription =>
      'متن‌های القرآن، ترجمه‌ها، تفسیرها و صدا از APIهای باز معتبر مانند Quran.com و Everyayah.com گرفته شده‌اند.';

  @override
  String get prayerTimeEngineTitle => 'موتور زمان نماز';

  @override
  String get prayerTimeEngineDescription =>
      'از روش‌های محاسبه established برای زمان‌های دقیق نماز استفاده می‌کند. اعلان‌ها توسط flutter_local_notifications و وظایف پس‌زمینه مدیریت می‌شوند.';

  @override
  String get crossPlatformSupport => 'پشتیبانی چندپلتفرمی';

  @override
  String get crossPlatformSupportDescription2 =>
      'دسترسی یکپارچه در پلتفرم‌های مختلف لذت ببرید:';

  @override
  String get android => 'اندروید';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'مک‌اواس';

  @override
  String get web => 'وب';

  @override
  String get linux => 'لینوکس';

  @override
  String get windows => 'ویندوز';

  @override
  String get ourLifetimePromise => 'وعده مادام‌العمر ما';

  @override
  String get lifetimePromiseDescription =>
      'من شخصاً قول می‌دهم که پشتیبانی و نگهداری مداوم برای این برنامه در طول عمرم ارائه دهم، ان شاء الله. هدف من اطمینان از این است که این برنامه منبع مفیدی برای امت برای سال‌های آینده باقی بماند.';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'طلوع آفتاب';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشا';

  @override
  String get midnight => 'نیمه‌شب';

  @override
  String get alarm => 'زنگ';

  @override
  String get notification => 'اعلان';

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
  String get quranScriptIndopak => 'ایندوپاک';

  @override
  String get sajdaAyah => 'آیه سجده';

  @override
  String get required => 'الزامی';

  @override
  String get optional => 'اختیاری';

  @override
  String get notificationScheduleWarning =>
      'توجه: اعلان یا یادآوری برنامه‌ریزی‌شده ممکن است به دلیل محدودیت‌های فرآیند پس‌زمینه سیستم عامل گوشی شما از دست برود. برای مثال: Origin OS ویوو، One UI سامسونگ، ColorOS اوپو گاهی اوقات اعلان یا یادآوری برنامه‌ریزی‌شده را می‌کشد. لطفاً تنظیمات سیستم عامل خود را بررسی کنید تا برنامه از فرآیند پس‌زمینه محدود نشود.';

  @override
  String get scrollWithRecitation => 'پیمایش با قرائت';

  @override
  String get quickAccess => 'دسترسی سریع';

  @override
  String get initiallyScrollAyah => 'ابتدا پیمایش به آیه';

  @override
  String get tajweedGuide => 'راهنمای تجوید';

  @override
  String get scrollWithRecitationDesc =>
      'وقتی فعال باشد، آیه قرآن به طور خودکار با قرائت صوتی همگام پیمایش می‌شود.';

  @override
  String get configuration => 'پیکربندی';

  @override
  String get restoreFromBackup => 'بازگردانی از پشتیبان';

  @override
  String get history => 'تاریخچه';

  @override
  String get search => 'جستجو';

  @override
  String get useAudioStream => 'استفاده از جریان صدا';

  @override
  String get useAudioStreamDesc =>
      'جریان صدا مستقیماً از اینترنت به جای دانلود.';

  @override
  String get notUseAudioStreamDesc =>
      'دانلود صدا برای استفاده آفلاین و کاهش مصرف داده.';

  @override
  String get audioSettings => 'تنظیمات صدا';

  @override
  String get playbackSpeed => 'سرعت پخش';

  @override
  String get playbackSpeedDesc => 'تنظیم سرعت قرائت قرآن.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'لطفاً منتظر پایان دانلود فعلی باشید.';

  @override
  String get areYouSure => 'آیا مطمئن هستید؟';

  @override
  String get checkYourInternetConnection => 'اتصال اینترنت خود را بررسی کنید.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'نیاز به دانلود $requiredDownload از $totalVersesCount آیه.';
  }

  @override
  String get download => 'دانلود';

  @override
  String get audioDownload => 'دانلود صدا';

  @override
  String get am => 'صبح';

  @override
  String get pm => 'عصر';

  @override
  String get optimizingQuranScript => 'بهینه‌سازی خط قرآن';

  @override
  String get supportOnGithub => 'حمایت در گیت‌هاب';

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

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';
}
