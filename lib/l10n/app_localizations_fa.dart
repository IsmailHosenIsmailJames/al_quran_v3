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
    return '$nameSimple ( $nameArabic ) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'تفسیر برای $ayahKey موجود نیست';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'تفسیر در $anotherAyahLinkKey یافت می‌شود';
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
  String get pleaseSelectOne => 'لطفا یکی را انتخاب کنید';

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
  String get justAMoment => 'کمی صبر کنید...';

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
      'دانلود منابع ممکن نیست...\nمشکلی پیش آمد';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'در حال دانلود قرائت قطعه‌بندی شده قرآن';

  @override
  String get processingSegmentedQuranRecitation =>
      'در حال پردازش قرائت قطعه‌بندی شده قرآن';

  @override
  String get footnote => 'پاورقی';

  @override
  String get tafsir => 'تفسیر';

  @override
  String get wordByWord => 'کلمه به کلمه';

  @override
  String get pleaseSelectRequiredOption =>
      'لطفاً گزینه مورد نظر را انتخاب کنید';

  @override
  String get rememberHomeTab => 'به خاطر سپردن تب خانه';

  @override
  String get rememberHomeTabSubtitle =>
      'برنامه آخرین تب باز شده در صفحه اصلی را به خاطر می‌سپارد.';

  @override
  String get wakeLock => 'روشن نگه داشتن صفحه';

  @override
  String get wakeLockSubtitle => 'جلوگیری از خاموش شدن خودکار صفحه.';

  @override
  String get settings => 'تنظیمات';

  @override
  String get appTheme => 'پوسته برنامه';

  @override
  String get quranStyle => 'سبک قرآن';

  @override
  String get changeTheme => 'تغییر پوسته';

  @override
  String get verseCount => 'تعداد آیات: ';

  @override
  String get translation => 'ترجمه';

  @override
  String get tafsirNotFound => 'یافت نشد';

  @override
  String get moreInfo => 'اطلاعات بیشتر';

  @override
  String get playAudio => 'پخش صوت';

  @override
  String get preview => 'پیش‌نمایش';

  @override
  String get loading => 'در حال بارگذاری...';

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
  String get shareSelectAyahs => 'اشتراک‌گذاری آیات انتخاب شده';

  @override
  String get selectionEmpty => 'انتخابی صورت نگرفته است';

  @override
  String get generatingImagePleaseWait => 'در حال ساخت تصویر... لطفاً صبر کنید';

  @override
  String get asImage => 'به صورت تصویر';

  @override
  String get asText => 'به صورت متن';

  @override
  String get playFromSelectedAyah => 'پخش از آیه انتخاب شده';

  @override
  String get toTafsir => 'به تفسیر';

  @override
  String get selectAyah => 'انتخاب آیه';

  @override
  String get toAyah => 'به آیه';

  @override
  String get searchForASurah => 'جستجوی سوره';

  @override
  String get bugReportTitle => 'گزارش خطا';

  @override
  String get audioCached => 'صوت ذخیره شد';

  @override
  String get others => 'سایر موارد';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'قرآن|ترجمه|آیه، حداقل یکی باید فعال باشد';

  @override
  String get quranFontSize => 'اندازه فونت قرآن';

  @override
  String get quranLineHeight => 'فاصله خطوط قرآن';

  @override
  String get translationAndTafsirFontSize => 'اندازه فونت ترجمه و تفسیر';

  @override
  String get quranAyah => 'آیه قرآن';

  @override
  String get topToolbar => 'نوار ابزار بالا';

  @override
  String get keepOpenWordByWord => 'کلمه به کلمه باز بماند';

  @override
  String get wordByWordHighlight => 'برجسته کردن کلمه به کلمه';

  @override
  String get quranScriptSettings => 'تنظیمات خط قرآن';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'صفحه: ';

  @override
  String get quranResources => 'منابع قرآن';

  @override
  String alreadySelected(String name) {
    return 'زبان \'$name\' قبلاً انتخاب شده است.';
  }

  @override
  String get unableToGetCompassData => 'دریافت اطلاعات قطب‌نما ممکن نیست';

  @override
  String get deviceDoesNotHaveSensors => 'دستگاه سنسور ندارد!';

  @override
  String get north => 'ش';

  @override
  String get east => 'خ';

  @override
  String get south => 'ج';

  @override
  String get west => 'ب';

  @override
  String get address => 'آدرس: ';

  @override
  String get change => 'تغییر';

  @override
  String get calculationMethod => 'روش محاسبه: ';

  @override
  String get downloadPrayerTime => 'دانلود اوقات شرعی';

  @override
  String get calculationMethodsListEmpty => 'لیست روش‌های محاسبه خالی است.';

  @override
  String get noCalculationMethodWithLocationData =>
      'هیچ روش محاسبه‌ای با اطلاعات مکان یافت نشد.';

  @override
  String get prayerSettings => 'تنظیمات نماز';

  @override
  String get reminderSettings => 'تنظیمات یادآور';

  @override
  String get adjustReminderTime => 'تنظیم زمان یادآور';

  @override
  String get enforceAlarmSound => 'اجرای صدای زنگ هشدار';

  @override
  String get enforceAlarmSoundDescription =>
      'در صورت فعال بودن، این ویژگی زنگ هشدار را با صدای تنظیم شده در اینجا پخش می‌کند، حتی اگر صدای تلفن شما کم باشد. این کار تضمین می‌کند که به دلیل کم بودن صدای تلفن، زنگ هشدار را از دست ندهید.';

  @override
  String get volume => 'صدا';

  @override
  String get atPrayerTime => 'در وقت نماز';

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
    return 'وقت $prayerName ساعت $prayerTime است';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'وقت $prayerName فرا رسیده است';
  }

  @override
  String get stopTheAdhan => 'توقف اذان';

  @override
  String dateFoundEmpty(String date) {
    return 'اطلاعاتی برای $date یافت نشد';
  }

  @override
  String get today => 'امروز';

  @override
  String get left => 'باقیمانده';

  @override
  String reminderAdded(String prayerName) {
    return 'یادآور برای $prayerName اضافه شد';
  }

  @override
  String get allowNotificationPermission =>
      'لطفاً برای استفاده از این ویژگی، اجازه اعلان را بدهید';

  @override
  String reminderRemoved(String prayerName) {
    return 'یادآور برای $prayerName حذف شد';
  }

  @override
  String get getPrayerTimesAndQibla => 'دریافت اوقات شرعی و قبله';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'محاسبه اوقات شرعی و قبله برای هر مکان.';

  @override
  String get getFromGPS => 'دریافت از GPS';

  @override
  String get or => 'یا';

  @override
  String get selectYourCity => 'شهر خود را انتخاب کنید';

  @override
  String get noteAboutGPS =>
      'نکته: اگر نمی‌خواهید از GPS استفاده کنید یا احساس امنیت نمی‌کنید، می‌توانید شهر خود را انتخاب کنید.';

  @override
  String get downloadingLocationResources =>
      'در حال دانلود منابع موقعیت مکانی...';

  @override
  String get somethingWentWrong => 'مشکلی پیش آمد';

  @override
  String get selectYourCountry => 'کشور خود را انتخاب کنید';

  @override
  String get searchForACountry => 'جستجوی کشور';

  @override
  String get selectYourAdministrator => 'سازمان خود را انتخاب کنید';

  @override
  String get searchForAnAdministrator => 'جستجوی سازمان';

  @override
  String get searchForACity => 'جستجوی شهر';

  @override
  String get pleaseEnableLocationService =>
      'لطفاً سرویس موقعیت مکانی را فعال کنید';

  @override
  String get donateUs => 'حمایت مالی';

  @override
  String get underDevelopment => 'در حال توسعه';

  @override
  String get versionLoading => 'در حال بارگذاری...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'منوی اصلی';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get pinned => 'سنجاق شده';

  @override
  String get jumpToAyah => 'پرش به آیه';

  @override
  String get shareMultipleAyah => 'اشتراک‌گذاری چند آیه';

  @override
  String get shareThisApp => 'اشتراک‌گذاری این برنامه';

  @override
  String get giveRating => 'امتیاز دادن';

  @override
  String get bugReport => 'گزارش خطا';

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
      'آیا مطمئن هستید که می‌خواهید برنامه را بازنشانی کنید؟ تمام داده‌های شما از بین خواهد رفت و باید برنامه را از ابتدا تنظیم کنید.';

  @override
  String get cancel => 'لغو';

  @override
  String get reset => 'بازنشانی';

  @override
  String get shareAppSubject => 'این برنامه القرآن را بررسی کنید!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام علیکم! این برنامه القرآن را برای قرائت و تأمل روزانه بررسی کنید. این برنامه به ارتباط با کلام خدا کمک می‌کند. از اینجا دانلود کنید: $appLink';
  }

  @override
  String get openDrawerTooltip => 'باز کردن منو';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'نماز';

  @override
  String get qibla => 'قبله';

  @override
  String get audio => 'صوت';

  @override
  String get surah => 'سوره';

  @override
  String get pages => 'صفحات';

  @override
  String get note => 'نکته:';

  @override
  String get linkedAyahs => 'آیات مرتبط:';

  @override
  String get emptyNoteCollection =>
      'این مجموعه یادداشت خالی است.\nبرای مشاهده یادداشت‌ها در اینجا، چند یادداشت اضافه کنید.';

  @override
  String get emptyPinnedCollection =>
      'هنوز هیچ آیه‌ای به این مجموعه سنجاق نشده است.\nآیه‌ها را برای مشاهده در اینجا سنجاق کنید.';

  @override
  String get noContentAvailable => 'محتوایی موجود نیست.';

  @override
  String failedToLoadCollections(String error) {
    return 'بارگذاری مجموعه‌ها ناموفق بود: $error';
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
    return '$count مورد سنجاق شده';
  }

  @override
  String notesCount(int count) {
    return '$count یادداشت';
  }

  @override
  String get emptyNameNotAllowed => 'نام خالی مجاز نیست';

  @override
  String updatedTo(String collectionName) {
    return 'به $collectionName به‌روز شد';
  }

  @override
  String get changeName => 'تغییر نام';

  @override
  String get changeColor => 'تغییر رنگ';

  @override
  String get colorUpdated => 'رنگ به‌روز شد';

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
  String get byNameAtoZ => 'نام الف-ی';

  @override
  String get byNameZtoA => 'نام ی-الف';

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
  String get translationNotFound => 'ترجمه یافت نشد';

  @override
  String get translationTitle => 'ترجمه:';

  @override
  String get footNoteTitle => 'پاورقی:';

  @override
  String get wordByWordTranslation => 'ترجمه کلمه به کلمه:';

  @override
  String get tafsirButton => 'تفسیر';

  @override
  String get shareButton => 'اشتراک‌گذاری';

  @override
  String get addNoteButton => 'افزودن یادداشت';

  @override
  String get pinToCollectionButton => 'سنجاق به مجموعه';

  @override
  String get shareAsText => 'اشتراک‌گذاری به صورت متن';

  @override
  String get copiedWithTafsir => 'همراه با تفسیر کپی شد';

  @override
  String get shareAsImage => 'اشتراک‌گذاری به صورت تصویر';

  @override
  String get shareWithTafsir => 'اشتراک‌گذاری همراه با تفسیر';

  @override
  String get notFound => 'یافت نشد';

  @override
  String get noteContentCannotBeEmpty => 'محتوای یادداشت نمی‌تواند خالی باشد.';

  @override
  String get noteSavedSuccessfully => 'یادداشت با موفقیت ذخیره شد!';

  @override
  String get selectCollections => 'انتخاب مجموعه‌ها';

  @override
  String get addNote => 'افزودن یادداشت';

  @override
  String get writeCollectionName => 'نام مجموعه را بنویسید...';

  @override
  String get noCollectionsYetAddANewOne =>
      'هنوز مجموعه‌ای وجود ندارد. یک مجموعه جدید اضافه کنید!';

  @override
  String get pleaseWriteYourNoteFirst => 'لطفاً ابتدا یادداشت خود را بنویسید.';

  @override
  String get noCollectionSelected => 'هیچ مجموعه‌ای انتخاب نشده است';

  @override
  String get saveNote => 'ذخیره یادداشت';

  @override
  String get nextSelectCollections => 'بعدی: انتخاب مجموعه‌ها';

  @override
  String get addToPinned => 'افزودن به سنجاق شده‌ها';

  @override
  String get pinnedSavedSuccessfully => 'با موفقیت سنجاق شد!';

  @override
  String get savePinned => 'ذخیره سنجاق شده';

  @override
  String get closeAudioController => 'بستن کنترلر صوت';

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
  String get playAsPlaylist => 'پخش به صورت لیست';

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
  String get cacheNotFound => 'کش یافت نشد';

  @override
  String get cacheSize => 'حجم کش';

  @override
  String error(String error) {
    return 'خطا: $error';
  }

  @override
  String get clean => 'پاکسازی';

  @override
  String get lastModified => 'آخرین تغییر';

  @override
  String get oneYearAgo => '۱ سال پیش';

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
  String get appFullName => 'القرآن (تفسیر، نماز، قبله، صوت)';

  @override
  String get appDescription =>
      'یک برنامه جامع اسلامی برای اندروید، iOS، MacOS، وب، لینوکس و ویندوز، که قرائت قرآن با تفسیر و ترجمه‌های متعدد (شامل کلمه به کلمه)، اوقات شرعی جهانی با اعلان، قطب‌نمای قبله، و قرائت صوتی هماهنگ کلمه به کلمه را ارائه می‌دهد.';

  @override
  String get dataSourcesNote =>
      'نکته: متون قرآن، تفسیر، ترجمه‌ها و منابع صوتی از Quran.com، Everyayah.com و سایر منابع باز تأیید شده گرفته شده‌اند.';

  @override
  String get adFreePromise =>
      'این برنامه برای کسب رضایت خداوند ساخته شده است. بنابراین، کاملاً بدون تبلیغات است و همیشه خواهد بود.';

  @override
  String get coreFeatures => 'ویژگی‌های اصلی';

  @override
  String get coreFeaturesDescription =>
      'قابلیت‌های کلیدی را که القرآن نسخه ۳ را به ابزاری ضروری برای اعمال اسلامی روزانه شما تبدیل می‌کند، کاوش کنید:';

  @override
  String get prayerTimesTitle => 'اوقات شرعی و هشدارها';

  @override
  String get prayerTimesDescription =>
      'اوقات شرعی دقیق برای هر مکان در سراسر جهان با استفاده از روش‌های مختلف محاسبه. تنظیم یادآور با اعلان اذان.';

  @override
  String get qiblaDirectionTitle => 'جهت قبله';

  @override
  String get qiblaDirectionDescription =>
      'به راحتی جهت قبله را با نمای قطب‌نمای واضح و دقیق پیدا کنید.';

  @override
  String get translationTafsirTitle => 'ترجمه و تفسیر قرآن';

  @override
  String get translationTafsirDescription =>
      'دسترسی به بیش از ۱۲۰ کتاب ترجمه (شامل کلمه به کلمه) به ۶۹ زبان، و بیش از ۳۰ کتاب تفسیر.';

  @override
  String get wordByWordAudioTitle => 'صوت و برجسته‌سازی کلمه به کلمه';

  @override
  String get wordByWordAudioDescription =>
      'برای یک تجربه یادگیری فراگیر، قرائت صوتی هماهنگ کلمه به کلمه و برجسته‌سازی را دنبال کنید.';

  @override
  String get ayahAudioRecitationTitle => 'قرائت صوتی آیه';

  @override
  String get ayahAudioRecitationDescription =>
      'به قرائت کامل آیات از بیش از ۴۰ قاری مشهور گوش دهید.';

  @override
  String get notesCloudBackupTitle => 'یادداشت‌ها با پشتیبان‌گیری ابری';

  @override
  String get notesCloudBackupDescription =>
      'یادداشت‌ها و تأملات شخصی را ذخیره کنید، با پشتیبان‌گیری امن در فضای ابری (ویژگی در حال توسعه/به زودی).';

  @override
  String get crossPlatformSupportTitle => 'پشتیبانی چند پلتفرمی';

  @override
  String get crossPlatformSupportDescription =>
      'پشتیبانی در اندروید، وب، لینوکس و ویندوز.';

  @override
  String get backgroundAudioPlaybackTitle => 'پخش صوت در پس‌زمینه';

  @override
  String get backgroundAudioPlaybackDescription =>
      'حتی زمانی که برنامه در پس‌زمینه است، به گوش دادن به قرائت قرآن ادامه دهید.';

  @override
  String get audioDataCachingTitle => 'ذخیره‌سازی موقت (کش) صوت و داده';

  @override
  String get audioDataCachingDescription =>
      'پخش بهبود یافته و قابلیت‌های آفلاین با ذخیره‌سازی موقت قوی صوت و داده‌های قرآن.';

  @override
  String get minimalisticInterfaceTitle => 'رابط کاربری مینیمال و تمیز';

  @override
  String get minimalisticInterfaceDescription =>
      'رابط کاربری با ناوبری آسان و تمرکز بر تجربه کاربری و خوانایی.';

  @override
  String get optimizedPerformanceTitle => 'عملکرد و حجم بهینه';

  @override
  String get optimizedPerformanceDescription =>
      'یک برنامه غنی از ویژگی‌ها که برای سبک بودن و عملکرد بالا طراحی شده است.';

  @override
  String get languageSupport => 'پشتیبانی از زبان‌ها';

  @override
  String get languageSupportDescription =>
      'این برنامه برای دسترسی مخاطبان جهانی با پشتیبانی از زبان‌های زیر طراحی شده است (و زبان‌های بیشتری به طور مداوم اضافه می‌شوند):';

  @override
  String get technologyAndResources => 'فناوری و منابع';

  @override
  String get technologyAndResourcesDescription =>
      'این برنامه با استفاده از فناوری‌های پیشرفته و منابع معتبر ساخته شده است:';

  @override
  String get flutterFrameworkTitle => 'فریمورک فلاتر';

  @override
  String get flutterFrameworkDescription =>
      'ساخته شده با فلاتر برای تجربه‌ای زیبا، کامپایل شده بومی و چند پلتفرمی از یک پایگاه کد واحد.';

  @override
  String get advancedAudioEngineTitle => 'موتور صوتی پیشرفته';

  @override
  String get advancedAudioEngineDescription =>
      'قدرت گرفته از بسته‌های فلاتر `just_audio` و `just_audio_background` برای پخش و کنترل صوتی قوی.';

  @override
  String get reliableQuranDataTitle => 'داده‌های معتبر قرآن';

  @override
  String get reliableQuranDataDescription =>
      'متون، ترجمه‌ها، تفاسیر و صوت‌های القرآن از APIهای باز تأیید شده و پایگاه‌های داده مانند Quran.com و Everyayah.com تهیه شده‌اند.';

  @override
  String get prayerTimeEngineTitle => 'موتور اوقات شرعی';

  @override
  String get prayerTimeEngineDescription =>
      'از روش‌های محاسبه معتبر برای اوقات شرعی دقیق استفاده می‌کند. اعلان‌ها توسط `flutter_local_notifications` و وظایف پس‌زمینه مدیریت می‌شوند.';

  @override
  String get crossPlatformSupport => 'پشتیبانی چند پلتفرمی';

  @override
  String get crossPlatformSupportDescription2 =>
      'از دسترسی یکپارچه در پلتفرم‌های مختلف لذت ببرید:';

  @override
  String get android => 'اندروید';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'وب';

  @override
  String get linux => 'لینوکس';

  @override
  String get windows => 'ویندوز';

  @override
  String get ourLifetimePromise => 'قول همیشگی ما';

  @override
  String get lifetimePromiseDescription =>
      'من شخصاً قول می‌دهم که در طول عمرم، ان‌شاءالله، پشتیبانی و نگهداری مداوم برای این برنامه ارائه دهم. هدف من این است که اطمینان حاصل کنم این برنامه برای سال‌های آینده یک منبع مفید برای امت باقی بماند.';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'طلوع';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get midnight => 'نیمه‌شب';

  @override
  String get alarm => 'هشدار';

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
  String get quranScriptUthmani => 'عثمان طه';

  @override
  String get quranScriptIndopak => 'ایندپاک';

  @override
  String get sajdaAyah => 'آیه سجده';

  @override
  String get required => 'واجب';

  @override
  String get optional => 'مستحب';

  @override
  String get notificationScheduleWarning =>
      'توجه: اعلان یا یادآوری برنامه ریزی شده ممکن است به دلیل محدودیت های فرآیندهای پس زمینه سیستم عامل تلفن شما از دست برود. به عنوان مثال: سیستم عامل Origin ویوو، One UI سامسونگ، ColorOS اوپو و غیره گاهی اوقات اعلان یا یادآوری برنامه ریزی شده را از بین می برند. لطفاً تنظیمات سیستم عامل خود را بررسی کنید تا برنامه از فرآیندهای پس زمینه محدود نشود.';
}
