// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'القرآن الكريم صوتي';

  @override
  String get settingsPageTitle => 'الإعدادات';

  @override
  String get settingsQuranFontSize => 'حجم خط القرآن';

  @override
  String get settingsAppTheme => 'سمة التطبيق';

  @override
  String get settingsAppLanguage => 'لغة التطبيق';

  @override
  String get settingsAudioCached => 'الصوت المخزن مؤقتًا';

  @override
  String get audioPageTitle => 'القرآن الكريم صوتي';

  @override
  String get audioPlayerTooltipPlay => 'تشغيل';

  @override
  String get audioPlayerTooltipPause => 'إيقاف مؤقت';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'اختر القارئ';

  @override
  String reciterStyleLabel(String style) {
    return 'النمط: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'المصدر: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'المزيد: ';

  @override
  String get saveButtonLabel => 'حفظ';

  @override
  String get audioSettingsCacheNotFound =>
      'لم يتم العثور على ذاكرة التخزين المؤقت';

  @override
  String get audioSettingsCacheSizeLabel => 'حجم ذاكرة التخزين المؤقت';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'خطأ: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'تنظيف';

  @override
  String get audioSettingsLastModifiedLabel => 'آخر تعديل';

  @override
  String get timeAgo1Year => 'قبل عام';

  @override
  String get timeAgo6Months => 'قبل 6 أشهر';

  @override
  String get timeAgo3Months => 'قبل 3 أشهر';

  @override
  String get timeAgo2Months => 'قبل شهرين';

  @override
  String get timeAgo1Month => 'قبل شهر';

  @override
  String get timeAgo3Weeks => 'قبل 3 أسابيع';

  @override
  String get timeAgo2Weeks => 'قبل أسبوعين';

  @override
  String get timeAgo1Week => 'قبل أسبوع';

  @override
  String get timeAgo6Days => 'قبل 6 أيام';

  @override
  String get timeAgo5Days => 'قبل 5 أيام';

  @override
  String get timeAgo4Days => 'قبل 4 أيام';

  @override
  String get timeAgo3Days => 'قبل 3 أيام';

  @override
  String get timeAgo2Days => 'قبل يومين';

  @override
  String get timeAgo1Day => 'أمس';

  @override
  String get timeToday => 'اليوم';

  @override
  String get drawerVersionLoading => 'جارٍ التحميل...';

  @override
  String get drawerAppNameSubtitle => 'القرآن الكريم';

  @override
  String get drawerSettingsTitle => 'الإعدادات';

  @override
  String get drawerShareAppTitle => 'مشاركة التطبيق';

  @override
  String get drawerShareAppSubject => 'جرّب تطبيق القرآن الكريم هذا!';

  @override
  String drawerShareAppBody(String appLink) {
    return 'السلام عليكم! جرّب تطبيق القرآن الكريم هذا للقراءة اليومية والتأمل. يساعد على الاتصال بكلام الله. قم بالتنزيل من هنا: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'تقييم التطبيق';

  @override
  String get drawerBugReportTitle => 'الإبلاغ عن خطأ';

  @override
  String get drawerPrivacyPolicyTitle => 'سياسة الخصوصية';

  @override
  String get bugReportDialogTitle => 'الإبلاغ عن خطأ';

  @override
  String get bugReportEmailSubject => 'بلاغ عن خطأ - القرآن الكريم صوتي';

  @override
  String get bugReportEmailBodyDeviceInfo => 'معلومات الجهاز:';

  @override
  String get bugReportEmailBodyAppInfo => 'معلومات التطبيق:';

  @override
  String get bugReportEmailBodyDescribeBug => 'صف الخطأ:';

  @override
  String get bugReportEmailBodyToReproduce => 'خطوات تكرار الخطأ:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'السلوك المتوقع:';

  @override
  String get bugReportEmailBodyScreenshots => 'لقطات شاشة (اختياري):';

  @override
  String get bugReportOptionEmail => 'عبر البريد الإلكتروني';

  @override
  String get bugReportOptionDiscord => 'على ديسكورد';

  @override
  String get deviceInfoPlatformWeb => 'المنصة: ويب';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'المتصفح: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'وكيل المستخدم: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'المنصة: أندرويد';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'الجهاز: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'الشركة المصنعة: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'إصدار نظام التشغيل: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'إصدار SDK: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'المنصة: iOS';

  @override
  String deviceInfoModel(String modelName) {
    return 'الموديل: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'المنصة: لينكس';

  @override
  String deviceInfoName(String name) {
    return 'الاسم: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'الإصدار: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'المنصة: macOS';

  @override
  String get deviceInfoPlatformWindows => 'المنصة: ويندوز';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'اسم الكمبيوتر: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'خطأ في الحصول على معلومات الجهاز: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'منصة غير معروفة';

  @override
  String appInfoAppName(String appName) {
    return 'اسم التطبيق: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'اسم الحزمة: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'رقم البناء: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'الانتقال إلى آية';

  @override
  String get jumpToAyahSearchSurahHint => 'ابحث عن سورة';

  @override
  String get jumpToAyahPlayButtonLabel => 'تشغيل من الآية المحددة';

  @override
  String get themeIconButtonTooltip => 'تغيير السمة';
}
