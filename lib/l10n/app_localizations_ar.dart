// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return 'تفسير $nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'التفسير غير متوفر للآية $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'يمكنك إيجاد التفسير في: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'الانتقال إلى $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'حزب';

  @override
  String get juz => 'جزء';

  @override
  String get page => 'صفحة';

  @override
  String get ruku => 'ركوع';

  @override
  String get languageSettings => 'إعدادات اللغة';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count آيات';
  }

  @override
  String get saveAndDownload => 'حفظ وتنزيل';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get selectAppLanguage => 'اختر لغة التطبيق...';

  @override
  String get pleaseSelectOne => 'الرجاء اختيار واحد';

  @override
  String get quranTranslationLanguage => 'لغة ترجمة القرآن';

  @override
  String get selectTranslationLanguage => 'اختر لغة الترجمة...';

  @override
  String get quranTranslationBook => 'كتاب ترجمة القرآن';

  @override
  String get selectTranslationBook => 'اختر كتاب الترجمة...';

  @override
  String get quranTafsirLanguage => 'لغة تفسير القرآن';

  @override
  String get selectTafsirLanguage => 'اختر لغة التفسير...';

  @override
  String get quranTafsirBook => 'كتاب تفسير القرآن';

  @override
  String get selectTafsirBook => 'اختر كتاب التفسير...';

  @override
  String get quranScriptAndStyle => 'خط القرآن ونمطه';

  @override
  String get justAMoment => 'لحظة من فضلك...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'تم بنجاح';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get unableToDownloadResources => 'تعذر تنزيل الموارد...\nحدث خطأ ما';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'جاري تنزيل تلاوة القرآن المقسمة';

  @override
  String get processingSegmentedQuranRecitation =>
      'جاري معالجة تلاوة القرآن المقسمة';

  @override
  String get footnote => 'حاشية';

  @override
  String get tafsir => 'تفسير';

  @override
  String get wordByWord => 'كلمة بكلمة';

  @override
  String get pleaseSelectRequiredOption => 'الرجاء تحديد الخيار المطلوب';

  @override
  String get rememberHomeTab => 'تذكر علامة التبويب الرئيسية';

  @override
  String get rememberHomeTabSubtitle =>
      'سيقوم التطبيق بتذكر آخر علامة تبويب تم فتحها في الشاشة الرئيسية.';

  @override
  String get wakeLock => 'إبقاء الشاشة قيد التشغيل';

  @override
  String get wakeLockSubtitle => 'منع الشاشة من الإطفاء تلقائياً.';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appTheme => 'مظهر التطبيق';

  @override
  String get quranStyle => 'نمط القرآن';

  @override
  String get changeTheme => 'تغيير المظهر';

  @override
  String get verseCount => 'عدد الآيات: ';

  @override
  String get translation => 'ترجمة';

  @override
  String get tafsirNotFound => 'لم يتم العثور عليه';

  @override
  String get moreInfo => 'مزيد من المعلومات';

  @override
  String get playAudio => 'تشغيل الصوت';

  @override
  String get preview => 'معاينة';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get errorFetchingAddress => 'خطأ في جلب العنوان';

  @override
  String get addressNotAvailable => 'العنوان غير متوفر';

  @override
  String get latitude => 'خط العرض: ';

  @override
  String get longitude => 'خط الطول: ';

  @override
  String get name => 'الاسم: ';

  @override
  String get location => 'الموقع: ';

  @override
  String get parameters => 'المعلمات: ';

  @override
  String get selectCalculationMethod => 'اختر طريقة الحساب';

  @override
  String get shareSelectAyahs => 'مشاركة الآيات المحددة';

  @override
  String get selectionEmpty => 'التحديد فارغ';

  @override
  String get generatingImagePleaseWait =>
      'جاري إنشاء الصورة... الرجاء الانتظار';

  @override
  String get asImage => 'كصورة';

  @override
  String get asText => 'كنص';

  @override
  String get playFromSelectedAyah => 'تشغيل من الآية المحددة';

  @override
  String get toTafsir => 'إلى التفسير';

  @override
  String get selectAyah => 'تحديد آية';

  @override
  String get toAyah => 'إلى الآية';

  @override
  String get searchForASurah => 'ابحث عن سورة';

  @override
  String get bugReportTitle => 'الإبلاغ عن خطأ';

  @override
  String get audioCached => 'الصوتيات المخزنة مؤقتاً';

  @override
  String get others => 'أخرى';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'القرآن|الترجمة|الآية، يجب تفعيل واحد على الأقل';

  @override
  String get quranFontSize => 'حجم خط القرآن';

  @override
  String get quranLineHeight => 'ارتفاع سطر القرآن';

  @override
  String get translationAndTafsirFontSize => 'حجم خط الترجمة والتفسير';

  @override
  String get quranAyah => 'آية قرآنية';

  @override
  String get topToolbar => 'الشريط العلوي';

  @override
  String get keepOpenWordByWord => 'إبقاء (كلمة بكلمة) مفتوحاً';

  @override
  String get wordByWordHighlight => 'تمييز كلمة بكلمة';

  @override
  String get quranScriptSettings => 'إعدادات خط القرآن';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'صفحة: ';

  @override
  String get quranResources => 'موارد القرآن';

  @override
  String alreadySelected(String name) {
    return 'اللغة \'$name\' محددة بالفعل.';
  }

  @override
  String get unableToGetCompassData => 'تعذر الحصول على بيانات البوصلة';

  @override
  String get deviceDoesNotHaveSensors => 'الجهاز لا يحتوي على مستشعرات!';

  @override
  String get north => 'ش';

  @override
  String get east => 'ق';

  @override
  String get south => 'ج';

  @override
  String get west => 'غ';

  @override
  String get address => 'العنوان: ';

  @override
  String get change => 'تغيير';

  @override
  String get calculationMethod => 'طريقة الحساب: ';

  @override
  String get downloadPrayerTime => 'تنزيل أوقات الصلاة';

  @override
  String get calculationMethodsListEmpty => 'قائمة طرق الحساب فارغة.';

  @override
  String get noCalculationMethodWithLocationData =>
      'تعذر العثور على أي طريقة حساب ببيانات الموقع.';

  @override
  String get prayerSettings => 'إعدادات الصلاة';

  @override
  String get reminderSettings => 'إعدادات التذكير';

  @override
  String get adjustReminderTime => 'ضبط وقت التذكير';

  @override
  String get enforceAlarmSound => 'فرض صوت المنبه';

  @override
  String get enforceAlarmSoundDescription =>
      'عند التفعيل، ستقوم هذه الميزة بتشغيل المنبه بمستوى الصوت المحدد هنا، حتى لو كان صوت هاتفك منخفضًا. هذا يضمن عدم تفويت المنبه بسبب انخفاض صوت الهاتف.';

  @override
  String get volume => 'مستوى الصوت';

  @override
  String get atPrayerTime => 'في وقت الصلاة';

  @override
  String minBefore(int minutes) {
    return 'قبل بـ $minutes دقيقة';
  }

  @override
  String minAfter(int minutes) {
    return 'بعد بـ $minutes دقيقة';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'موعد $prayerName في $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'حان وقت $prayerName';
  }

  @override
  String get stopTheAdhan => 'إيقاف الأذان';

  @override
  String dateFoundEmpty(String date) {
    return '$date فارغ';
  }

  @override
  String get today => 'اليوم';

  @override
  String get left => 'المتبقي';

  @override
  String reminderAdded(String prayerName) {
    return 'تمت إضافة تذكير لصلاة $prayerName';
  }

  @override
  String get allowNotificationPermission =>
      'الرجاء السماح بإذن الإشعارات لاستخدام هذه الميزة';

  @override
  String reminderRemoved(String prayerName) {
    return 'تمت إزالة تذكير صلاة $prayerName';
  }

  @override
  String get getPrayerTimesAndQibla => 'الحصول على أوقات الصلاة والقبلة';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'حساب أوقات الصلاة والقبلة لأي موقع محدد.';

  @override
  String get getFromGPS => 'الحصول من GPS';

  @override
  String get or => 'أو';

  @override
  String get selectYourCity => 'اختر مدينتك';

  @override
  String get noteAboutGPS =>
      'ملاحظة: إذا كنت لا ترغب في استخدام GPS أو لا تشعر بالأمان، يمكنك اختيار مدينتك.';

  @override
  String get downloadingLocationResources => 'جاري تنزيل موارد الموقع...';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get selectYourCountry => 'اختر بلدك';

  @override
  String get searchForACountry => 'ابحث عن بلد';

  @override
  String get selectYourAdministrator => 'اختر منطقتك الإدارية';

  @override
  String get searchForAnAdministrator => 'ابحث عن منطقة إدارية';

  @override
  String get searchForACity => 'ابحث عن مدينة';

  @override
  String get pleaseEnableLocationService => 'الرجاء تفعيل خدمة الموقع';

  @override
  String get donateUs => 'تبرع لنا';

  @override
  String get underDevelopment => 'قيد التطوير';

  @override
  String get versionLoading => 'جاري التحميل...';

  @override
  String get alQuran => 'القرآن الكريم';

  @override
  String get mainMenu => 'القائمة الرئيسية';

  @override
  String get notes => 'ملاحظات';

  @override
  String get pinned => 'المثبتة';

  @override
  String get jumpToAyah => 'الانتقال إلى آية';

  @override
  String get shareMultipleAyah => 'مشاركة عدة آيات';

  @override
  String get shareThisApp => 'شارك هذا التطبيق';

  @override
  String get giveRating => 'تقييم التطبيق';

  @override
  String get bugReport => 'الإبلاغ عن خطأ';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get aboutTheApp => 'عن التطبيق';

  @override
  String get resetTheApp => 'إعادة ضبط التطبيق';

  @override
  String get resetAppWarningTitle => 'إعادة ضبط بيانات التطبيق';

  @override
  String get resetAppWarningMessage =>
      'هل أنت متأكد أنك تريد إعادة ضبط التطبيق؟ ستفقد جميع بياناتك، وستحتاج إلى إعداد التطبيق من البداية.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get shareAppSubject => 'اطلع على تطبيق القرآن الكريم هذا!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام عليكم! اطلع على تطبيق القرآن الكريم هذا للقراءة والتأمل اليومي. يساعد على التواصل مع كلمات الله. قم بالتحميل من هنا: $appLink';
  }

  @override
  String get openDrawerTooltip => 'فتح القائمة';

  @override
  String get quran => 'القرآن';

  @override
  String get prayer => 'الصلاة';

  @override
  String get qibla => 'القبلة';

  @override
  String get audio => 'الصوتيات';

  @override
  String get surah => 'السور';

  @override
  String get pages => 'الصفحات';

  @override
  String get note => 'ملاحظة:';

  @override
  String get linkedAyahs => 'الآيات المرتبطة:';

  @override
  String get emptyNoteCollection =>
      'مجموعة الملاحظات هذه فارغة.\nأضف بعض الملاحظات لرؤيتها هنا.';

  @override
  String get emptyPinnedCollection =>
      'لم يتم تثبيت أي آيات في هذه المجموعة بعد.\nثبّت آيات لرؤيتها هنا.';

  @override
  String get noContentAvailable => 'لا يوجد محتوى متاح.';

  @override
  String failedToLoadCollections(String error) {
    return 'فشل تحميل المجموعات: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'ابحث باسم $collectionType...';
  }

  @override
  String get sortBy => 'فرز حسب';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'لم يتم إضافة $collectionType بعد';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count عنصر مثبت';
  }

  @override
  String notesCount(int count) {
    return '$count ملاحظة';
  }

  @override
  String get emptyNameNotAllowed => 'الاسم الفارغ غير مسموح به';

  @override
  String updatedTo(String collectionName) {
    return 'تم التحديث إلى $collectionName';
  }

  @override
  String get changeName => 'تغيير الاسم';

  @override
  String get changeColor => 'تغيير اللون';

  @override
  String get colorUpdated => 'تم تحديث اللون';

  @override
  String collectionDeleted(String collectionName) {
    return 'تم حذف $collectionName';
  }

  @override
  String get delete => 'حذف';

  @override
  String get save => 'حفظ';

  @override
  String get collectionNameCannotBeEmpty =>
      'اسم المجموعة لا يمكن أن يكون فارغاً.';

  @override
  String get addedNewCollection => 'تمت إضافة مجموعة جديدة';

  @override
  String ayahCount(int count) {
    return '$count آية';
  }

  @override
  String get byNameAtoZ => 'الاسم من أ-ي';

  @override
  String get byNameZtoA => 'الاسم من ي-أ';

  @override
  String get byElementNumberAscending => 'رقم العنصر تصاعدياً';

  @override
  String get byElementNumberDescending => 'رقم العنصر تنازلياً';

  @override
  String get byUpdateDateAscending => 'تاريخ التحديث تصاعدياً';

  @override
  String get byUpdateDateDescending => 'تاريخ التحديث تنازلياً';

  @override
  String get byCreateDateAscending => 'تاريخ الإنشاء تصاعدياً';

  @override
  String get byCreateDateDescending => 'تاريخ الإنشاء تنازلياً';

  @override
  String get translationNotFound => 'الترجمة غير موجودة';

  @override
  String get translationTitle => 'الترجمة:';

  @override
  String get footNoteTitle => 'الحاشية:';

  @override
  String get wordByWordTranslation => 'ترجمة كلمة بكلمة:';

  @override
  String get tafsirButton => 'تفسير';

  @override
  String get shareButton => 'مشاركة';

  @override
  String get addNoteButton => 'إضافة ملاحظة';

  @override
  String get pinToCollectionButton => 'تثبيت في مجموعة';

  @override
  String get shareAsText => 'مشاركة كنص';

  @override
  String get copiedWithTafsir => 'تم النسخ مع التفسير';

  @override
  String get shareAsImage => 'مشاركة كصورة';

  @override
  String get shareWithTafsir => 'مشاركة مع التفسير';

  @override
  String get notFound => 'غير موجود';

  @override
  String get noteContentCannotBeEmpty =>
      'محتوى الملاحظة لا يمكن أن يكون فارغاً.';

  @override
  String get noteSavedSuccessfully => 'تم حفظ الملاحظة بنجاح!';

  @override
  String get selectCollections => 'اختر المجموعات';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get writeCollectionName => 'اكتب اسم المجموعة...';

  @override
  String get noCollectionsYetAddANewOne =>
      'لا توجد مجموعات بعد. أضف واحدة جديدة!';

  @override
  String get pleaseWriteYourNoteFirst => 'الرجاء كتابة ملاحظتك أولاً.';

  @override
  String get noCollectionSelected => 'لم يتم اختيار مجموعة';

  @override
  String get saveNote => 'حفظ الملاحظة';

  @override
  String get nextSelectCollections => 'التالي: اختر المجموعات';

  @override
  String get addToPinned => 'إضافة إلى المثبتة';

  @override
  String get pinnedSavedSuccessfully => 'تم حفظ التثبيت بنجاح!';

  @override
  String get savePinned => 'حفظ المثبتة';

  @override
  String get closeAudioController => 'إغلاق وحدة التحكم بالصوت';

  @override
  String get previous => 'السابق';

  @override
  String get rewind => 'إرجاع';

  @override
  String get fastForward => 'تقديم';

  @override
  String get playNextAyah => 'تشغيل الآية التالية';

  @override
  String get repeat => 'تكرار';

  @override
  String get playAsPlaylist => 'تشغيل كقائمة تشغيل';

  @override
  String style(String style) {
    return 'النمط: $style';
  }

  @override
  String get stopAndClose => 'إيقاف وإغلاق';

  @override
  String get play => 'تشغيل';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get selectReciter => 'اختر القارئ';

  @override
  String source(String source) {
    return 'المصدر: $source';
  }

  @override
  String get newText => 'جديد';

  @override
  String get more => 'المزيد: ';

  @override
  String get cacheNotFound => 'لم يتم العثور على ذاكرة التخزين المؤقت';

  @override
  String get cacheSize => 'حجم ذاكرة التخزين المؤقت';

  @override
  String error(String error) {
    return 'خطأ: $error';
  }

  @override
  String get clean => 'تنظيف';

  @override
  String get lastModified => 'آخر تعديل';

  @override
  String get oneYearAgo => 'منذ سنة';

  @override
  String monthsAgo(String number) {
    return 'منذ $number أشهر';
  }

  @override
  String weeksAgo(String number) {
    return 'منذ $number أسابيع';
  }

  @override
  String daysAgo(String number) {
    return 'منذ $number أيام';
  }

  @override
  String hoursAgo(int hour) {
    return 'منذ $hour ساعات';
  }

  @override
  String get aboutAlQuran => 'عن تطبيق القرآن';

  @override
  String get appFullName => 'القرآن الكريم (تفسير، صلاة، قبلة، صوتيات)';

  @override
  String get appDescription =>
      'تطبيق إسلامي شامل لأنظمة أندرويد، iOS، ماك، الويب، لينكس، وويندوز، يوفر قراءة القرآن مع التفسير وترجمات متعددة (بما في ذلك كلمة بكلمة)، وأوقات صلاة عالمية مع إشعارات، وبوصلة القبلة، وتلاوة صوتية متزامنة كلمة بكلمة.';

  @override
  String get dataSourcesNote =>
      'ملاحظة: نصوص القرآن، التفسير، الترجمات، والموارد الصوتية مأخوذة من Quran.com، و Everyayah.com، ومصادر أخرى مفتوحة وموثوقة.';

  @override
  String get adFreePromise =>
      'تم بناء هذا التطبيق ابتغاءً لمرضاة الله. لذلك، هو وسيظل دائماً خالياً تماماً من الإعلانات.';

  @override
  String get coreFeatures => 'الميزات الأساسية';

  @override
  String get coreFeaturesDescription =>
      'استكشف الوظائف الرئيسية التي تجعل تطبيق القرآن v3 أداة لا غنى عنها لممارساتك الإسلامية اليومية:';

  @override
  String get prayerTimesTitle => 'أوقات الصلاة والتنبيهات';

  @override
  String get prayerTimesDescription =>
      'أوقات صلاة دقيقة لأي مكان في العالم باستخدام طرق حساب متنوعة. قم بتعيين تذكيرات مع إشعارات الأذان.';

  @override
  String get qiblaDirectionTitle => 'اتجاه القبلة';

  @override
  String get qiblaDirectionDescription =>
      'اعثر بسهولة على اتجاه القبلة مع عرض بوصلة واضح ودقيق.';

  @override
  String get translationTafsirTitle => 'ترجمة القرآن والتفسير';

  @override
  String get translationTafsirDescription =>
      'الوصول إلى أكثر من 120 كتاب ترجمة (بما في ذلك كلمة بكلمة) بـ 69 لغة، وأكثر من 30 كتاب تفسير.';

  @override
  String get wordByWordAudioTitle => 'صوتيات كلمة بكلمة وتمييز';

  @override
  String get wordByWordAudioDescription =>
      'تابع التلاوة الصوتية المتزامنة كلمة بكلمة مع التمييز لتجربة تعليمية غامرة.';

  @override
  String get ayahAudioRecitationTitle => 'تلاوة صوتية للآيات';

  @override
  String get ayahAudioRecitationDescription =>
      'استمع إلى تلاوات كاملة للآيات من أكثر من 40 قارئاً مشهوراً.';

  @override
  String get notesCloudBackupTitle => 'ملاحظات مع نسخ احتياطي سحابي';

  @override
  String get notesCloudBackupDescription =>
      'احفظ الملاحظات والتأملات الشخصية، مع نسخ احتياطي آمن على السحابة (الميزة قيد التطوير/قادمة قريباً).';

  @override
  String get crossPlatformSupportTitle => 'دعم متعدد المنصات';

  @override
  String get crossPlatformSupportDescription =>
      'مدعوم على أندرويد، الويب، لينكس، وويندوز.';

  @override
  String get backgroundAudioPlaybackTitle => 'تشغيل الصوت في الخلفية';

  @override
  String get backgroundAudioPlaybackDescription =>
      'استمر في الاستماع إلى تلاوة القرآن حتى عندما يكون التطبيق في الخلفية.';

  @override
  String get audioDataCachingTitle => 'تخزين مؤقت للصوت والبيانات';

  @override
  String get audioDataCachingDescription =>
      'تشغيل محسّن وإمكانيات غير متصلة بالإنترنت مع تخزين مؤقت قوي لبيانات الصوت والقرآن.';

  @override
  String get minimalisticInterfaceTitle => 'واجهة بسيطة ونظيفة';

  @override
  String get minimalisticInterfaceDescription =>
      'واجهة سهلة التنقل مع التركيز على تجربة المستخدم وسهولة القراءة.';

  @override
  String get optimizedPerformanceTitle => 'أداء وحجم محسن';

  @override
  String get optimizedPerformanceDescription =>
      'تطبيق غني بالميزات مصمم ليكون خفيف الوزن وعالي الأداء.';

  @override
  String get languageSupport => 'دعم اللغات';

  @override
  String get languageSupportDescription =>
      'تم تصميم هذا التطبيق ليكون متاحاً لجمهور عالمي مع دعم اللغات التالية (ويتم إضافة المزيد باستمرار):';

  @override
  String get technologyAndResources => 'التقنيات والمصادر';

  @override
  String get technologyAndResourcesDescription =>
      'تم بناء هذا التطبيق باستخدام أحدث التقنيات والمصادر الموثوقة:';

  @override
  String get flutterFrameworkTitle => 'إطار عمل فلاتر (Flutter)';

  @override
  String get flutterFrameworkDescription =>
      'مبني باستخدام فلاتر لتجربة جميلة، مجمّعة أصليًا، ومتعددة المنصات من قاعدة كود واحدة.';

  @override
  String get advancedAudioEngineTitle => 'محرك صوتي متقدم';

  @override
  String get advancedAudioEngineDescription =>
      'مدعوم بحزم فلاتر `just_audio` و `just_audio_background` لتشغيل وتحكم صوتي قوي.';

  @override
  String get reliableQuranDataTitle => 'بيانات قرآنية موثوقة';

  @override
  String get reliableQuranDataDescription =>
      'نصوص القرآن الكريم، الترجمات، التفاسير، والصوتيات مأخوذة من واجهات برمجة تطبيقات وقواعد بيانات مفتوحة وموثوقة مثل Quran.com و Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'محرك أوقات الصلاة';

  @override
  String get prayerTimeEngineDescription =>
      'يستخدم طرق حساب معتمدة لأوقات صلاة دقيقة. يتم التعامل مع الإشعارات بواسطة `flutter_local_notifications` والمهام الخلفية.';

  @override
  String get crossPlatformSupport => 'دعم متعدد المنصات';

  @override
  String get crossPlatformSupportDescription2 =>
      'استمتع بوصول سلس عبر مختلف المنصات:';

  @override
  String get android => 'أندرويد';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'الويب';

  @override
  String get linux => 'لينكس';

  @override
  String get windows => 'ويندوز';

  @override
  String get ourLifetimePromise => 'وعدنا مدى الحياة';

  @override
  String get lifetimePromiseDescription =>
      'أتعهد شخصياً بتقديم الدعم والصيانة المستمرة لهذا التطبيق طوال حياتي، إن شاء الله. هدفي هو ضمان أن يظل هذا التطبيق مورداً نافعاً للأمة لسنوات قادمة.';

  @override
  String get fajr => 'الفجر';

  @override
  String get sunrise => 'الشروق';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get midnight => 'منتصف الليل';

  @override
  String get alarm => 'منبه';

  @override
  String get notification => 'إشعار';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea، $administrativeArea، $country';
  }

  @override
  String get quranScriptTajweed => 'تجويد';

  @override
  String get quranScriptUthmani => 'عثماني';

  @override
  String get quranScriptIndopak => 'هندي-باكستاني';

  @override
  String get sajdaAyah => 'آية سجدة';

  @override
  String get required => 'واجبة';

  @override
  String get optional => 'مستحبة';

  @override
  String get notificationScheduleWarning =>
      'ملاحظة: قد يتم تفويت الإشعار المجدول أو التذكير بسبب قيود عمليات الخلفية في نظام تشغيل هاتفك. على سبيل المثال: نظام Origin OS من Vivo، و One UI من Samsung، و ColorOS من Oppo وما إلى ذلك، تقتل أحيانًا الإشعار المجدول أو التذكير. يرجى التحقق من إعدادات نظام التشغيل لديك لجعل التطبيق غير مقيد من عمليات الخلفية.';

  @override
  String get scrollWithRecitation => 'التمرير مع التلاوة';

  @override
  String get quickAccess => 'الوصول السريع';

  @override
  String get initiallyScrollAyah => 'التمرير في البداية إلى الآية';
}
