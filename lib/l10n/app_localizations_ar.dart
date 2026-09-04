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
    return '$nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'التفسير غير متوفر لـ $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'التفسير موجود في: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'انتقل إلى $anotherAyahLinkKey';
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
  String get pleaseSelectOne => 'يرجى اختيار واحد';

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
  String get quranScriptAndStyle => 'نص القرآن وأسلوبه';

  @override
  String get justAMoment => 'لحظة فقط...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'نجاح';

  @override
  String get retry => 'أعد المحاولة';

  @override
  String get unableToDownloadResources =>
      'غير قادر على تنزيل الموارد...\nحدث خطأ ما';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'جاري تنزيل تلاوة القرآن المقسمة';

  @override
  String get processingSegmentedQuranRecitation =>
      'جاري معالجة تلاوة القرآن المقسمة';

  @override
  String get footnote => 'هامش';

  @override
  String get tafsir => 'تفسير';

  @override
  String get wordByWord => 'كلمة بكلمة';

  @override
  String get pleaseSelectRequiredOption => 'يرجى اختيار الخيار المطلوب';

  @override
  String get rememberHomeTab => 'تذكر علامة التبويب الرئيسية';

  @override
  String get rememberHomeTabSubtitle =>
      'سيحتفظ التطبيق بآخر علامة تبويب مفتوحة في الشاشة الرئيسية.';

  @override
  String get wakeLock => 'قفل الاستيقاظ';

  @override
  String get wakeLockSubtitle => 'منع الشاشة من الإغلاق تلقائيًا.';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appTheme => 'سمة التطبيق';

  @override
  String get quranStyle => 'أسلوب القرآن';

  @override
  String get changeTheme => 'تغيير السمة';

  @override
  String get verseCount => 'عدد الآيات: ';

  @override
  String get translation => 'ترجمة';

  @override
  String get tafsirNotFound => 'غير موجود';

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
  String get shareSelectAyahs => 'مشاركة الآيات المختارة';

  @override
  String get selectionEmpty => 'الاختيار فارغ';

  @override
  String get generatingImagePleaseWait => 'جاري إنشاء الصورة... يرجى الانتظار';

  @override
  String get asImage => 'كصورة';

  @override
  String get asText => 'كنص';

  @override
  String get playFromSelectedAyah => 'تشغيل من الآية المختارة';

  @override
  String get toTafsir => 'إلى التفسير';

  @override
  String get selectAyah => 'اختر آية';

  @override
  String get toAyah => 'إلى آية';

  @override
  String get searchForASurah => 'ابحث عن سورة';

  @override
  String get bugReportTitle => 'تقرير خطأ';

  @override
  String get audioCached => 'الصوت المخزن مؤقتًا';

  @override
  String get others => 'آخرون';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'القرآن|الترجمة|الآية، يجب تمكين واحد';

  @override
  String get quranFontSize => 'حجم خط القرآن';

  @override
  String get quranLineHeight => 'ارتفاع سطر القرآن';

  @override
  String get translationAndTafsirFontSize => 'حجم خط الترجمة والتفسير';

  @override
  String get quranAyah => 'آية القرآن';

  @override
  String get topToolbar => 'شريط الأدوات العلوي';

  @override
  String get keepOpenWordByWord => 'ابق مفتوحًا كلمة بكلمة';

  @override
  String get wordByWordHighlight => 'تسليط الضوء كلمة بكلمة';

  @override
  String get quranScriptSettings => 'إعدادات نص القرآن';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'رقم الصفحة: ';

  @override
  String get quranResources => 'موارد القرآن';

  @override
  String alreadySelected(String name) {
    return 'اللغة \'$name\' مختارة بالفعل.';
  }

  @override
  String get unableToGetCompassData => 'غير قادر على الحصول على بيانات البوصلة';

  @override
  String get deviceDoesNotHaveSensors => 'الجهاز لا يحتوي على مستشعرات!';

  @override
  String get north => 'شمال';

  @override
  String get east => 'شرق';

  @override
  String get south => 'جنوب';

  @override
  String get west => 'غرب';

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
      'لم يتم العثور على أي طريقة حساب مع بيانات الموقع.';

  @override
  String get prayerSettings => 'إعدادات الصلاة';

  @override
  String get reminderSettings => 'إعدادات التذكير';

  @override
  String get adjustReminderTime => 'ضبط وقت التذكير';

  @override
  String get enforceAlarmSound => 'فرض صوت الإنذار';

  @override
  String get enforceAlarmSoundDescription =>
      'إذا تم تمكينه، سيقوم هذا الميزة بتشغيل الإنذار بحجم الصوت المحدد هنا، حتى لو كان صوت هاتفك منخفضًا. هذا يضمن عدم تفويت الإنذار بسبب انخفاض حجم الهاتف.';

  @override
  String get volume => 'الصوت';

  @override
  String get atPrayerTime => 'في وقت الصلاة';

  @override
  String minBefore(int minutes) {
    return '$minutes دقيقة قبل';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes دقيقة بعد';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName في $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'حان وقت $prayerName';
  }

  @override
  String get stopTheAdhan => 'أوقف الأذان';

  @override
  String dateFoundEmpty(String date) {
    return '$date وجد فارغًا';
  }

  @override
  String get today => 'اليوم';

  @override
  String get left => 'باقي';

  @override
  String reminderAdded(String prayerName) {
    return 'تم إضافة تذكير لـ $prayerName';
  }

  @override
  String get allowNotificationPermission =>
      'يرجى السماح بإذن الإشعارات لاستخدام هذه الميزة';

  @override
  String reminderRemoved(String prayerName) {
    return 'تم إزالة تذكير $prayerName';
  }

  @override
  String get getPrayerTimesAndQibla => 'احصل على أوقات الصلاة والقبلة';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'احسب أوقات الصلاة والقبلة لأي موقع معين.';

  @override
  String get getFromGPS => 'احصل من GPS';

  @override
  String get or => 'أو';

  @override
  String get selectYourCity => 'اختر مدينتك';

  @override
  String get noteAboutGPS =>
      'ملاحظة: إذا كنت لا تريد استخدام GPS أو لا تشعر بالأمان، يمكنك اختيار مدينتك.';

  @override
  String get downloadingLocationResources => 'جاري تنزيل موارد الموقع...';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get selectYourCountry => 'اختر بلدك';

  @override
  String get searchForACountry => 'ابحث عن بلد';

  @override
  String get selectYourAdministrator => 'اختر الإدارة الخاصة بك';

  @override
  String get searchForAnAdministrator => 'ابحث عن إدارة';

  @override
  String get searchForACity => 'ابحث عن مدينة';

  @override
  String get pleaseEnableLocationService => 'يرجى تمكين خدمة الموقع';

  @override
  String get donateUs => 'تبرع لنا';

  @override
  String get underDevelopment => 'قيد التطوير';

  @override
  String get versionLoading => 'جاري التحميل...';

  @override
  String get alQuran => 'القرآن';

  @override
  String get mainMenu => 'القائمة الرئيسية';

  @override
  String get notes => 'ملاحظات';

  @override
  String get pinned => 'مثبت';

  @override
  String get jumpToAyah => 'انتقل إلى آية';

  @override
  String get shareMultipleAyah => 'مشاركة آيات متعددة';

  @override
  String get shareThisApp => 'مشاركة هذا التطبيق';

  @override
  String get giveRating => 'أعطِ تقييمًا';

  @override
  String get bugReport => 'تقرير خطأ';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get aboutTheApp => 'عن التطبيق';

  @override
  String get resetTheApp => 'إعادة تعيين التطبيق';

  @override
  String get resetAppWarningTitle => 'إعادة تعيين بيانات التطبيق';

  @override
  String get resetAppWarningMessage =>
      'هل أنت متأكد من إعادة تعيين التطبيق؟ سيتم فقدان جميع بياناتك، وسيتعين عليك إعداد التطبيق من البداية.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get shareAppSubject => 'تحقق من تطبيق القرآن هذا!';

  @override
  String shareAppBody(String appLink) {
    return 'السلام عليكم! تحقق من تطبيق القرآن هذا للقراءة اليومية والتأمل. يساعد في الاتصال بكلمات الله. نزل من هنا: $appLink';
  }

  @override
  String get openDrawerTooltip => 'افتح الدرج';

  @override
  String get quran => 'قرآن';

  @override
  String get prayer => 'صلاة';

  @override
  String get qibla => 'قبلة';

  @override
  String get audio => 'صوت';

  @override
  String get surah => 'سورة';

  @override
  String get pages => 'صفحات';

  @override
  String get note => 'ملاحظة:';

  @override
  String get linkedAyahs => 'آيات مرتبطة:';

  @override
  String get emptyNoteCollection =>
      'هذه المجموعة من الملاحظات فارغة.\nأضف بعض الملاحظات لرؤيتها هنا.';

  @override
  String get emptyPinnedCollection =>
      'لم يتم تثبيت أي آيات في هذه المجموعة بعد.\nثبت الآيات لرؤيتها هنا.';

  @override
  String get noContentAvailable => 'لا يوجد محتوى متوفر.';

  @override
  String failedToLoadCollections(String error) {
    return 'فشل في تحميل المجموعات: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'ابحث حسب اسم $collectionType...';
  }

  @override
  String get sortBy => 'ترتيب حسب';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'لم يتم إضافة $collectionType بعد';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count عناصر مثبتة';
  }

  @override
  String notesCount(int count) {
    return '$count ملاحظات';
  }

  @override
  String get emptyNameNotAllowed => 'الاسم الفارغ غير مسموح';

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
    return '$collectionName محذوف';
  }

  @override
  String get delete => 'حذف';

  @override
  String get save => 'حفظ';

  @override
  String get collectionNameCannotBeEmpty =>
      'اسم المجموعة لا يمكن أن يكون فارغًا.';

  @override
  String get addedNewCollection => 'تم إضافة مجموعة جديدة';

  @override
  String ayahCount(int count) {
    return '$count آية';
  }

  @override
  String get byNameAtoZ => 'الاسم أ-ي';

  @override
  String get byNameZtoA => 'الاسم ي-أ';

  @override
  String get byElementNumberAscending => 'رقم العنصر تصاعدي';

  @override
  String get byElementNumberDescending => 'رقم العنصر تنازلي';

  @override
  String get byUpdateDateAscending => 'تاريخ التحديث تصاعدي';

  @override
  String get byUpdateDateDescending => 'تاريخ التحديث تنازلي';

  @override
  String get byCreateDateAscending => 'تاريخ الإنشاء تصاعدي';

  @override
  String get byCreateDateDescending => 'تاريخ الإنشاء تنازلي';

  @override
  String get translationNotFound => 'الترجمة غير موجودة';

  @override
  String get translationTitle => 'ترجمة:';

  @override
  String get footNoteTitle => 'هامش:';

  @override
  String get wordByWordTranslation => 'ترجمة كلمة بكلمة:';

  @override
  String get tafsirButton => 'تفسير';

  @override
  String get shareButton => 'مشاركة';

  @override
  String get addNoteButton => 'إضافة ملاحظة';

  @override
  String get pinToCollectionButton => 'تثبيت في المجموعة';

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
      'محتوى الملاحظة لا يمكن أن يكون فارغًا.';

  @override
  String get noteSavedSuccessfully => 'تم حفظ الملاحظة بنجاح!';

  @override
  String get selectCollections => 'اختر المجموعات';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get writeCollectionName => 'اكتب اسم المجموعة...';

  @override
  String get noCollectionsYetAddANewOne => 'لا مجموعات بعد. أضف واحدة جديدة!';

  @override
  String get pleaseWriteYourNoteFirst => 'يرجى كتابة ملاحظتك أولاً.';

  @override
  String get noCollectionSelected => 'لم يتم اختيار مجموعة';

  @override
  String get saveNote => 'حفظ الملاحظة';

  @override
  String get nextSelectCollections => 'التالي: اختر المجموعات';

  @override
  String get addToPinned => 'إضافة إلى المثبت';

  @override
  String get pinnedSavedSuccessfully => 'تم حفظ المثبت بنجاح!';

  @override
  String get savePinned => 'حفظ المثبت';

  @override
  String get closeAudioController => 'أغلق متحكم الصوت';

  @override
  String get previous => 'السابق';

  @override
  String get rewind => 'إعادة';

  @override
  String get fastForward => 'تقديم سريع';

  @override
  String get playNextAyah => 'تشغيل الآية التالية';

  @override
  String get repeat => 'تكرار';

  @override
  String get playAsPlaylist => 'تشغيل كقائمة تشغيل';

  @override
  String style(String style) {
    return 'أسلوب: $style';
  }

  @override
  String get stopAndClose => 'أوقف وأغلق';

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
  String get cacheNotFound => 'المخزن المؤقت غير موجود';

  @override
  String get cacheSize => 'حجم المخزن المؤقت';

  @override
  String error(String error) {
    return 'خطأ: $error';
  }

  @override
  String get clean => 'تنظيف';

  @override
  String get lastModified => 'آخر تعديل';

  @override
  String get oneYearAgo => 'منذ عام واحد';

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
  String get aboutAlQuran => 'عن القرآن';

  @override
  String get appFullName => 'القرآن (تفسير، صلاة، قبلة، صوت)';

  @override
  String get appDescription =>
      'تطبيق إسلامي شامل لأندرويد، iOS، macOS، الويب، لينكس وويندوز، يقدم قراءة القرآن مع تفسير وترجمات متعددة (بما في ذلك كلمة بكلمة)، أوقات الصلاة في جميع أنحاء العالم مع إشعارات، بوصلة القبلة، وتلاوة صوتية متزامنة كلمة بكلمة.';

  @override
  String get dataSourcesNote =>
      'ملاحظة: نصوص القرآن، التفسير، الترجمات، والموارد الصوتية مستمدة من Quran.com، Everyayah.com، ومصادر مفتوحة موثوقة أخرى.';

  @override
  String get adFreePromise =>
      'تم بناء هذا التطبيق للحصول على رضا الله. لذلك، هو ودائمًا سيكون خاليًا تمامًا من الإعلانات.';

  @override
  String get coreFeatures => 'الميزات الأساسية';

  @override
  String get coreFeaturesDescription =>
      'استكشف الوظائف الرئيسية التي تجعل القرآن v3 أداة لا غنى عنها لممارساتك الإسلامية اليومية:';

  @override
  String get prayerTimesTitle => 'أوقات الصلاة والتنبيهات';

  @override
  String get prayerTimesDescription =>
      'أوقات صلاة دقيقة لأي موقع في العالم باستخدام طرق حساب متنوعة. قم بتعيين تذكيرات مع إشعارات الأذان.';

  @override
  String get qiblaDirectionTitle => 'اتجاه القبلة';

  @override
  String get qiblaDirectionDescription =>
      'ابحث عن اتجاه القبلة بسهولة مع عرض بوصلة واضح ودقيق.';

  @override
  String get translationTafsirTitle => 'ترجمة القرآن وتفسيره';

  @override
  String get translationTafsirDescription =>
      'الوصول إلى أكثر من 120 كتاب ترجمة (بما في ذلك كلمة بكلمة) في 69 لغة، وأكثر من 30 كتاب تفسير.';

  @override
  String get wordByWordAudioTitle => 'صوت كلمة بكلمة وتسليط الضوء';

  @override
  String get wordByWordAudioDescription =>
      'تابع مع تلاوة صوتية متزامنة كلمة بكلمة وتسليط الضوء لتجربة تعلم غامرة.';

  @override
  String get ayahAudioRecitationTitle => 'تلاوة صوتية للآية';

  @override
  String get ayahAudioRecitationDescription =>
      'استمع إلى تلاوات آيات كاملة من أكثر من 40 قارئ مشهور.';

  @override
  String get notesCloudBackupTitle => 'ملاحظات مع نسخ احتياطي سحابي';

  @override
  String get notesCloudBackupDescription =>
      'احفظ ملاحظاتك الشخصية وتأملاتك، مدعومة بشكل آمن في السحابة (ميزة قيد التطوير/قادمة قريبًا).';

  @override
  String get crossPlatformSupportTitle => 'دعم عبر المنصات';

  @override
  String get crossPlatformSupportDescription =>
      'مدعوم على أندرويد، الويب، لينكس، وويندوز.';

  @override
  String get backgroundAudioPlaybackTitle => 'تشغيل الصوت في الخلفية';

  @override
  String get backgroundAudioPlaybackDescription =>
      'استمر في الاستماع إلى تلاوة القرآن حتى عندما يكون التطبيق في الخلفية.';

  @override
  String get audioDataCachingTitle => 'تخزين الصوت والبيانات مؤقتًا';

  @override
  String get audioDataCachingDescription =>
      'تحسين التشغيل والقدرات دون اتصال مع تخزين قوي للصوت وبيانات القرآن.';

  @override
  String get minimalisticInterfaceTitle => 'واجهة بسيطة ونظيفة';

  @override
  String get minimalisticInterfaceDescription =>
      'واجهة سهلة التنقل مع التركيز على تجربة المستخدم والقراءة.';

  @override
  String get optimizedPerformanceTitle => 'أداء محسن وحجم';

  @override
  String get optimizedPerformanceDescription =>
      'تطبيق غني بالميزات مصمم ليكون خفيف الوزن وفعال.';

  @override
  String get languageSupport => 'دعم اللغات';

  @override
  String get languageSupportDescription =>
      'تم تصميم هذا التطبيق ليكون متاحًا لجمهور عالمي مع دعم اللغات التالية (ومزيد منها يتم إضافته باستمرار):';

  @override
  String get technologyAndResources => 'التكنولوجيا والموارد';

  @override
  String get technologyAndResourcesDescription =>
      'تم بناء هذا التطبيق باستخدام تقنيات حديثة وموارد موثوقة:';

  @override
  String get flutterFrameworkTitle => 'إطار عمل فلاتر';

  @override
  String get flutterFrameworkDescription =>
      'مبني باستخدام فلاتر لتجربة جميلة، مترجمة أصلاً، متعددة المنصات من قاعدة كود واحدة.';

  @override
  String get advancedAudioEngineTitle => 'محرك صوت متقدم';

  @override
  String get advancedAudioEngineDescription =>
      'مدعوم بحزم فلاتر `just_audio` و`just_audio_background` لتشغيل وتحكم صوتي قوي.';

  @override
  String get reliableQuranDataTitle => 'بيانات قرآن موثوقة';

  @override
  String get reliableQuranDataDescription =>
      'نصوص القرآن، الترجمات، التفاسير، والصوت مستمدة من واجهات برمجة تطبيقات مفتوحة موثوقة و قواعد بيانات مثل Quran.com وEveryayah.com.';

  @override
  String get prayerTimeEngineTitle => 'محرك أوقات الصلاة';

  @override
  String get prayerTimeEngineDescription =>
      'يستخدم طرق حساب مثبتة لأوقات صلاة دقيقة. الإشعارات تدار بواسطة `flutter_local_notifications` والمهام الخلفية.';

  @override
  String get crossPlatformSupport => 'دعم عبر المنصات';

  @override
  String get crossPlatformSupportDescription2 =>
      'استمتع بالوصول السلس عبر منصات مختلفة:';

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
      'أعد شخصيًا بدعم وصيانة مستمرة لهذا التطبيق طوال حياتي، إن شاء الله. هدفي هو التأكد من أن هذا التطبيق يظل مصدرًا مفيدًا للأمة لسنوات قادمة.';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'شروق';

  @override
  String get noon => 'الظهر';

  @override
  String get dhuhr => 'ظهر';

  @override
  String get asr => 'عصر';

  @override
  String get sunset => 'الغروب';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get midnight => 'منتصف الليل';

  @override
  String get alarm => 'إنذار';

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
  String get quranScriptIndopak => 'إندوباك';

  @override
  String get sajdaAyah => 'آية سجدة';

  @override
  String get required => 'مطلوب';

  @override
  String get optional => 'اختياري';

  @override
  String get notificationScheduleWarning =>
      'ملاحظة: قد يتم تفويت إشعار أو تذكير مجدول بسبب قيود عملية الخلفية في نظام تشغيل هاتفك. على سبيل المثال: Origin OS من Vivo، One UI من Samsung، ColorOS من Oppo إلخ. أحيانًا تقتل الإشعارات أو التذكيرات المجدولة. يرجى التحقق من إعدادات نظام التشغيل الخاص بك لجعل التطبيق غير مقيد من عمليات الخلفية.';

  @override
  String get scrollWithRecitation => 'التمرير مع التلاوة';

  @override
  String get quickAccess => 'وصول سريع';

  @override
  String get initiallyScrollAyah => 'التمرير الأولي إلى الآية';

  @override
  String get tajweedGuide => 'دليل التجويد';

  @override
  String get scrollWithRecitationDesc =>
      'عند تمكينه، سيتحرك الآية القرآنية تلقائيًا متزامنًا مع التلاوة الصوتية.';

  @override
  String get configuration => 'التكوين';

  @override
  String get restoreFromBackup => 'استعادة من النسخ الاحتياطي';

  @override
  String get history => 'التاريخ';

  @override
  String get search => 'بحث';

  @override
  String get useAudioStream => 'استخدام تدفق الصوت';

  @override
  String get useAudioStreamDesc =>
      'تدفق الصوت مباشرة من الإنترنت بدلاً من التنزيل.';

  @override
  String get notUseAudioStreamDesc =>
      'تنزيل الصوت للاستخدام دون اتصال وتقليل استهلاك البيانات.';

  @override
  String get audioSettings => 'إعدادات الصوت';

  @override
  String get playbackSpeed => 'سرعة التشغيل';

  @override
  String get playbackSpeedDesc => 'ضبط سرعة تلاوة القرآن.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'يرجى الانتظار حتى ينتهي التنزيل الحالي.';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get checkYourInternetConnection => 'تحقق من اتصالك بالإنترنت.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'يحتاج إلى تنزيل $requiredDownload من $totalVersesCount آيات.';
  }

  @override
  String get download => 'تنزيل';

  @override
  String get audioDownload => 'تنزيل الصوت';

  @override
  String get am => 'ص';

  @override
  String get pm => 'م';

  @override
  String get optimizingQuranScript => 'تحسين نص القرآن';

  @override
  String get supportOnGithub => 'ادعمونا على جيت هب';

  @override
  String get forbiddenSalatTimes => 'أوقات الصلاة المنهي عنها';

  @override
  String get prayerTimes => 'أوقات الصلاة';

  @override
  String get hanafi => 'حنفى';

  @override
  String get shafie => 'شافعى';

  @override
  String get suhurEnd => 'نهاية السحور';

  @override
  String get iftarStart => 'بداية الإفطار';

  @override
  String get tahajjudStart => 'بداية التهجد';

  @override
  String get tahajjud => 'التهجد';

  @override
  String get dhuha => 'الضحى';

  @override
  String get indopakFont => 'الخط الهندوسي الباكستاني';

  @override
  String get uthmaniFont => 'الخط العثماني';

  @override
  String get close => 'إغلاق';

  @override
  String get goToSettings => 'اذهب إلى الإعدادات';

  @override
  String get scriptSettingsUpdated => 'تم تحديث إعدادات الخط';

  @override
  String get scriptSettingsUpdatedDescription =>
      'لقد قمنا بتبسيط خيارات الخط وأضفنا المزيد من الخطوط.';

  @override
  String get enterPageNumber => 'أدخل رقم الصفحة بين 1 و 604';

  @override
  String get deleteMushafData => 'حذف بيانات المصحف';

  @override
  String get deleteMushafDataDescription =>
      'هل أنت متأكد أنك تريد حذف جميع بيانات المصحف؟';

  @override
  String get invalidPage => 'صفحة غير صالحة (1-604)';

  @override
  String get goToPage => 'ذهاب إلى الصفحة';

  @override
  String get resources => 'الموارد';

  @override
  String get mushaf => 'مصحف';

  @override
  String get circleJojomInQuranScript => 'دائرة جزم/سكون في خط القرآن';

  @override
  String get copy => 'نسخ';

  @override
  String get share => 'مشاركة';

  @override
  String get warningMessageOnIndopakTajweedEnable =>
      'لقد وجدنا بعض مشاكل العرض في لون التجويد الهندي الباكستاني في بعض الخطوط. لذلك، قد ترى عدم تناسق في عرض ألوان النص. هل أنت متأكد من أنك تريد تطبيق التجويد على الهندي الباكستاني؟';

  @override
  String get apply => 'تطبيق';

  @override
  String get warning => 'تحذير';

  @override
  String get hijri => 'هجري';

  @override
  String get gregorian => 'ميلادي';

  @override
  String get prayerTimesCalender => 'تقويم أوقات الصلاة';

  @override
  String get allowLocation => 'السماح بالموقع';

  @override
  String get allowLocationDescription => 'تحديث أوقات الصلاة تلقائيًا.';

  @override
  String get manualLocation => 'موقع يدوي';

  @override
  String get manualLocationDescription =>
      'اختر البلد والمدينة يدويًا. ستحتاج إلى تحديث الموقع إذا قمت بتغيير المدينة.';

  @override
  String get selectLocation => 'اختر الموقع';

  @override
  String get selectCountry => 'اختر البلد';

  @override
  String get selectCity => 'اختر المدينة';

  @override
  String get sunRising => 'شروق الشمس';

  @override
  String get sunSetting => 'غروب الشمس';

  @override
  String get sunTopOfTheHead => 'وقت الزوال (الشمس في كبد السماء)';

  @override
  String get salatTime => 'وقت الصلاة';

  @override
  String get forbiddenSalatTime => 'وقت كراهة الصلاة';

  @override
  String get translationDatabase => 'قاعدة بيانات الترجمة';

  @override
  String get translationDatabaseSubtitle => 'تنزيل نص الترجمة المحدد';

  @override
  String get tafsirCommentary => 'تفسير القرآن';

  @override
  String get tafsirCommentarySubtitle => 'إعداد مصادر التفسير';

  @override
  String get wordByWordAnalysis => 'التحليل كلمة بكلمة';

  @override
  String get wordByWordAnalysisSubtitle => 'إعداد تفكيك المفردات';

  @override
  String get audioRecitationSegments => 'أجزاء التلاوة الصوتية';

  @override
  String get audioRecitationSegmentsSubtitle => 'تكوين التوقيت الصوتي للآيات';

  @override
  String get locationQiblaMetadata => 'بيانات الموقع والقبلة';

  @override
  String get locationQiblaMetadataSubtitle =>
      'تنزيل بيانات مواقع المدن العالمية';

  @override
  String get preparingResources => 'جاري إعداد المصادر...';

  @override
  String get setupCompletedOpeningQuran => 'اكتمل الإعداد! جاري فتح القرآن...';

  @override
  String get unexpectedErrorSetup => 'حدث خطأ غير متوقع أثناء الإعداد.';

  @override
  String get heading => 'الاتجاه';

  @override
  String get alignedWithKaaba => 'محاذٍ للكعبة';

  @override
  String turnRight(Object degrees) {
    return 'أدر $degrees° إلى اليمين';
  }

  @override
  String turnLeft(Object degrees) {
    return 'أدر $degrees° إلى اليسار';
  }

  @override
  String get streamingAndNetwork => 'البث والشبكة';

  @override
  String get next => 'التالي';

  @override
  String get now => 'الآن';

  @override
  String get current => 'الحالي';

  @override
  String get active => 'نشط';

  @override
  String get activeNow => 'نشط الآن';

  @override
  String get hours => 'ساعات';

  @override
  String get minutes => 'دقائق';

  @override
  String get seconds => 'ثوانٍ';

  @override
  String get fastingAndVoluntaryTimes => 'أوقات الصيام والتطوع';

  @override
  String get imsak => 'الإمساك';

  @override
  String get ishraqAndDuha => 'الإشراق والضحى';

  @override
  String get lastThirdOfNight => 'الثلث الأخير من الليل';

  @override
  String get awqatAlNahy => 'أوقات النهي عن الصلاة';

  @override
  String get forbiddenSunriseDescription =>
      'من طلوع الشمس حتى ترتفع قيد رمح (نحو 15 دقيقة)';

  @override
  String get forbiddenNoonDescription =>
      'عند استواء الشمس في كبد السماء حتى تزول (~8 دقائق)';

  @override
  String get forbiddenSunsetDescription =>
      'عند اصفرار الشمس حتى تغرب تماماً (~15 دقيقة)';

  @override
  String get forbiddenTimesHadith =>
      'جاء في صحيح مسلم (832) عن عقبة بن عامر الجهني رضي الله عنه قال:\n\n«ثلاث ساعات كان رسول الله صلى الله عليه وسلم ينهانا أن نصلي فيهن أو أن نقبر فيهن موتانا:\n1. حين تطلع الشمس بازغة حتى ترتفع.\n2. وحين يقوم قائم الظهيرة حتى تميل الشمس.\n3. وحين تضيّف الشمس للغروب حتى تغرب.»';

  @override
  String get readMoreOnIslamQA => 'اقرأ الفتوى كاملة على IslamQA';

  @override
  String get asrJurisprudence => 'مذهب حساب صلاة العصر';

  @override
  String get shafieDescription => 'الجمهور (الشافعي، المالكي، الحنبلي)';

  @override
  String get hanafiDescription => 'المذهب الحنفي';

  @override
  String get shafieShadow => 'الجمهور (الظل 1x)';

  @override
  String get hanafiShadow => 'الحنفي (الظل 2x)';

  @override
  String get calculationAndJurisprudence => 'طرق الحساب والمذهب';

  @override
  String get notificationsAndAudio => 'الإشعارات والصوت';

  @override
  String get enablePrayerReminders => 'تفعيل تنبيهات الصلاة';

  @override
  String get enablePrayerRemindersDescription =>
      'تلقي إشعارات تنبيهية لجميع أوقات الصلاة القادمة.';

  @override
  String get adjustReminderTimingDescription =>
      'ضبط وقت تنبيه الصلاة (+/- دقائق عن بداية الوقت الفعلي).';

  @override
  String get exactTime => 'الوقت بالضبط';

  @override
  String actualTime(String time) {
    return 'الوقت الفعلي: $time';
  }

  @override
  String get jumpToToday => 'الانتقال إلى اليوم';

  @override
  String get dateAndHijri => 'التاريخ / الهجري';

  @override
  String get selectedLocation => 'الموقع المحدد';

  @override
  String nextPrayerLabel(String prayerName) {
    return 'التالي: $prayerName';
  }

  @override
  String currentPrayerLabel(String prayerName) {
    return 'الآن: $prayerName';
  }

  @override
  String startsAt(String prayerName, String time) {
    return 'يبدأ $prayerName في $time';
  }

  @override
  String get continueReading => 'متابعة القراءة';

  @override
  String get lastRead => 'آخر قراءة';

  @override
  String get resume => 'استئناف';

  @override
  String get startReading => 'ابدأ القراءة';

  @override
  String get verses => 'آيات';

  @override
  String get ayah => 'آية';

  @override
  String get edit => 'تعديل';

  @override
  String get searchAll => 'الكل';

  @override
  String get searchArabic => 'العربية';

  @override
  String get searchQuranHint => 'ابحث في القرآن، السورة، ٢:٢٥٥، الترجمة...';

  @override
  String get searchFiltersAndOptions => 'خيارات وفلاتر البحث';

  @override
  String get exactPhrase => 'العبارة بالضبط';

  @override
  String surahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم العثور على $count سورة',
      many: 'تم العثور على $count سورة',
      few: 'تم العثور على $count سور',
      two: 'تم العثور على سورتين',
      one: 'تم العثور على سورة واحدة',
    );
    return '$_temp0';
  }

  @override
  String ayahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تم العثور على $count آية',
      many: 'تم العثور على $count آية',
      few: 'تم العثور على $count آيات',
      two: 'تم العثور على آيتين',
      one: 'تم العثور على آية واحدة',
    );
    return '$_temp0';
  }

  @override
  String noMatchingSurahs(String query) {
    return 'لا توجد سور مطابقة لـ \"$query\"';
  }

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get trySearchingFor =>
      'جرب البحث عن اسم سورة أو رقم آية (مثل ٢:٢٥٥) أو مواضيع';

  @override
  String allSurahsCount(int count) {
    return 'جميع السور ($count)';
  }

  @override
  String activeShortcutsCount(int count) {
    return 'الاختصارات النشطة ($count)';
  }

  @override
  String get noActiveShortcuts => 'لا توجد اختصارات نشطة';

  @override
  String get customize => 'تخصيص';

  @override
  String get bismillahPreview => 'معاينة البسملة';

  @override
  String get tajweedRules => 'أحكام التجويد';

  @override
  String get makki => 'مكية';

  @override
  String get madani => 'مدنية';

  @override
  String get exactPhraseMatch => 'مطابقة العبارة بدقة';

  @override
  String get matchExactWordsDesc => 'مطابقة الكلمات بدقة في تسلسل متصل';

  @override
  String get filterBySurah => 'تصفية حسب السورة';

  @override
  String get all114SurahsEntireQuran => 'جميع السور الـ ١١٤ (القرآن كاملاً)';

  @override
  String get revelationType => 'نوع النزول';

  @override
  String get searchInTranslations => 'البحث في الترجمات';

  @override
  String get searchInTafsirs => 'البحث في التفاسير';

  @override
  String activeCount(int selected, int total) {
    return '$selected/$total نشط';
  }

  @override
  String get recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get searchGuideTitle => 'ابحث في القرآن الكريم';

  @override
  String get searchGuideDescription =>
      'ابحث باسم السورة أو رقم الآية (مثل 2:255) أو بالكلمات في الترجمات والتفاسير.';

  @override
  String get madani15Line => 'مصحف المدينة ١٥ سطر';

  @override
  String get totalPagesCount => '٦٠٤ صفحة';

  @override
  String get wordAudio => 'صوت الكلمات';

  @override
  String get offlineReady => 'جاهز بدون إنترنت';

  @override
  String get vectorFonts => 'خطوط متجهة';

  @override
  String get madaniMushafLayout => 'تصميم مصحف المدينة';

  @override
  String get kfgqpcDescription => 'مجمع الملك فهد لطباعة المصحف الشريف (V4)';

  @override
  String get downloadingMushafPackage => 'جاري تنزيل حزمة المصحف...';

  @override
  String get extractingAndInstallingData => 'جاري استخراج وتثبيت البيانات...';

  @override
  String get settingUpOfflinePages => 'جاري تجهيز الصفحات بدون اتصال...';

  @override
  String get fetchingLayoutArchive => 'جاري جلب أرشيف التصميم...';

  @override
  String get keepAppOpenDuringDownload =>
      'يرجى إبقاء التطبيق مفتوحاً حتى يكتمل التنزيل.';

  @override
  String get downloadFailed => 'فشل التنزيل';

  @override
  String get retryDownload => 'إعادة المحاولة';

  @override
  String get packageSize => 'حجم الحزمة';

  @override
  String get loadingMushafPage => 'جاري تحميل صفحة المصحف...';

  @override
  String get quickPageJump => 'انتقال سريع للصفحة';

  @override
  String get searchSurahHint => 'ابحث عن السورة بالاسم أو الرقم...';

  @override
  String get fullscreen => 'ملء الشاشة';

  @override
  String get back => 'رجوع';

  @override
  String get script => 'رسم الخط';

  @override
  String get muted => 'مكتوم';

  @override
  String get alerts => 'تنبيهات';

  @override
  String get off => 'إيقاف';

  @override
  String get on => 'تشغيل';

  @override
  String get homeAndLockWidgets => 'ويدجت الشاشة الرئيسية والقفل';

  @override
  String get glanceableWidgets => 'أدوات سهلة وسريعة';

  @override
  String get glanceableWidgetsDesc =>
      'عرض الآيات اليومية وأوقات الصلاة على شاشتك الرئيسية وشاشة القفل.';

  @override
  String get ayahWidgetDisplayMode => 'وضع عرض ويدجت الآية';

  @override
  String get dailyInspiringAyah => 'آية يومية ملهمة (مختارة)';

  @override
  String get dailyInspiringAyahDesc =>
      'يتغير كل يوم عند منتصف الليل مع أكثر من 365 آية مختارة بعناية.';

  @override
  String get lastReadAyah => 'آخر آية مقروءة';

  @override
  String get lastReadAyahDesc =>
      'يتزامن مع آخر موضع قراءة للمتابعة الفورية بنقرة واحدة.';

  @override
  String get pinnedCustomVerse => 'آية مخصصة مثبتة';

  @override
  String get randomDailyAyah => 'آية يومية عشوائية';

  @override
  String get randomDailyAyahDesc =>
      'يختار آية عشوائية كل يوم للتأمل والتفكر المتجدد.';

  @override
  String get updateAllWidgetsNow => 'تحديث جميع الأدوات الآن';

  @override
  String get widgetsUpdatedSuccessfully => 'تم تحديث الأدوات بنجاح!';

  @override
  String get ayahPinnedToWidgets =>
      'تم تثبيت الآية في ويدجت الشاشة الرئيسية والقفل!';

  @override
  String get pinToWidgets => 'تثبيت في ويدجت الشاشة';

  @override
  String get selectPinnedAyah => 'اختر الآية للتثبيت';

  @override
  String get saveAndApplyToWidget => 'حفظ وتطبيق على الويدجت';

  @override
  String get howToAddWidgets => 'كيفية إضافة الأدوات';

  @override
  String get customizeWidgetAyahAndPrayers => 'تخصيص آيات وصلوات الويدجت';

  @override
  String get customizeWidgetAyahAndPrayersDesc =>
      'اختر بين الآيات اليومية المختارة، أو آخر قراءة، أو آية مثبتة مخصصة';

  @override
  String get accountAndSync => 'الحساب والمزامنة السحابية';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get deleteAccount => 'حذف الحساب والبيانات';

  @override
  String get deleteAccountTitle => 'هل تريد حذف الحساب؟';

  @override
  String get deleteAccountWarning =>
      'سيؤدي هذا إلى حذف حسابك وجميع ملاحظاتك وإشاراتك المرجعية وسجل القراءة المتزامن سحابيًا نهائيًا. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteAccountConfirm => 'نعم، احذف كل شيء';

  @override
  String get syncNow => 'المزامنة الآن';

  @override
  String get syncing => 'جارٍ المزامنة...';

  @override
  String get syncSuccess => 'تمت مزامنة البيانات بنجاح!';

  @override
  String get syncFailed => 'فشلت المزامنة. يرجى التحقق من اتصال الإنترنت.';

  @override
  String get googleSignIn => 'المتابعة باستخدام Google';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get resetPasswordEmailSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني!';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get privacyPolicyNotice =>
      'بالمتابعة، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.';

  @override
  String get guestUser => 'مستخدم ضيف';

  @override
  String get syncedCloudBackup => 'المزامنة السحابية';

  @override
  String get syncedCloudBackupDesc =>
      'حافظ على مزامنة ملاحظاتك وإشاراتك وسجل القراءة عبر جميع أجهزتك.';

  @override
  String get alHadith => 'الحديث الشريف';

  @override
  String get hadithCompanion => 'مرافق';

  @override
  String get hadithCompanionDesc =>
      'صحيح البخاري ومسلم ومجموعات الحديث النبوي الشريف.';

  @override
  String get open => 'فتح';

  @override
  String get install => 'تثبيت';

  @override
  String get companionApps => 'التطبيقات المرافقة';

  @override
  String get hadithCollectionsBrief => 'البخاري ومسلم والمزيد';

  @override
  String get explore => 'استكشاف';

  @override
  String get ourIslamicCompanionApps => 'تطبيقاتنا الإسلامية المرافقة';

  @override
  String get ourIslamicCompanionAppsDesc =>
      'تم تطويرها خالصًا لوجه الله (صدقة جارية) ومجانية وخالية من الإعلانات بنسبة 100% للأمة الإسلامية.';

  @override
  String get reminderRingtone => 'صوت التذكير';

  @override
  String get chooseRingtone => 'اختيار النغمة';

  @override
  String get chooseRingtoneDescription =>
      'اختر من أصوات النظام أو ملفات الصوت بالجهاز';

  @override
  String get defaultSound => 'افتراضي التطبيق (notification_sound.wav)';

  @override
  String get systemNotification => 'إشعار النظام الافتراضي';

  @override
  String get systemAlarm => 'منبه النظام الافتراضي';

  @override
  String get systemRingtone => 'نغمة الهاتف الافتراضية';

  @override
  String get previewSound => 'معاينة الصوت';

  @override
  String get stopPreview => 'إيقاف المعاينة';

  @override
  String get testNotification => 'إرسال إشعار تجريبي';

  @override
  String get testNotificationSent =>
      'تم إرسال الإشعار التجريبي! تحقق من إشعاراتك.';

  @override
  String get quickPresets => 'خيارات سريعة';
}
