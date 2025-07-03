// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'القرآن آڈیو';

  @override
  String get settingsPageTitle => 'ترتیبات';

  @override
  String get settingsQuranFontSize => 'قرآن فونٹ سائز';

  @override
  String get settingsAppTheme => 'ایپ تھیم';

  @override
  String get settingsAppLanguage => 'ایپ کی زبان';

  @override
  String get settingsAudioCached => 'کیش شدہ آڈیو';

  @override
  String get audioPageTitle => 'القرآن آڈیو';

  @override
  String get audioPlayerTooltipPlay => 'چلائیں';

  @override
  String get audioPlayerTooltipPause => 'روکیں';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'قاری منتخب کریں';

  @override
  String reciterStyleLabel(String style) {
    return 'انداز: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'ماخذ: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'مزید: ';

  @override
  String get saveButtonLabel => 'محفوظ کریں';

  @override
  String get audioSettingsCacheNotFound => 'کیش نہیں ملا';

  @override
  String get audioSettingsCacheSizeLabel => 'کیش کا سائز';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'خرابی: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'صاف کریں';

  @override
  String get audioSettingsLastModifiedLabel => 'آخری بار ترمیم شدہ';

  @override
  String get timeAgo1Year => '1 سال پہلے';

  @override
  String get timeAgo6Months => '6 مہینے پہلے';

  @override
  String get timeAgo3Months => '3 مہینے پہلے';

  @override
  String get timeAgo2Months => '2 مہینے پہلے';

  @override
  String get timeAgo1Month => '1 مہینہ پہلے';

  @override
  String get timeAgo3Weeks => '3 ہفتے پہلے';

  @override
  String get timeAgo2Weeks => '2 ہفتے پہلے';

  @override
  String get timeAgo1Week => '1 ہفتہ پہلے';

  @override
  String get timeAgo6Days => '6 دن پہلے';

  @override
  String get timeAgo5Days => '5 دن پہلے';

  @override
  String get timeAgo4Days => '4 دن پہلے';

  @override
  String get timeAgo3Days => '3 دن پہلے';

  @override
  String get timeAgo2Days => '2 دن پہلے';

  @override
  String get timeAgo1Day => '1 دن پہلے';

  @override
  String get timeToday => 'آج';

  @override
  String get drawerVersionLoading => 'لوڈ ہو رہا ہے...';

  @override
  String get drawerAppNameSubtitle => 'القرآن';

  @override
  String get drawerSettingsTitle => 'ترتیبات';

  @override
  String get drawerShareAppTitle => 'ایپ شیئر کریں';

  @override
  String get drawerShareAppSubject => 'یہ القرآن ایپ دیکھیں!';

  @override
  String drawerShareAppBody(String appLink) {
    return 'السلام علیکم! روزانہ تلاوت اور غور و فکر کے لیے یہ القرآن ایپ دیکھیں۔ یہ اللہ کے کلام سے جڑنے میں مدد کرتی ہے۔ یہاں سے ڈاؤن لوڈ کریں: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'ریٹنگ دیں';

  @override
  String get drawerBugReportTitle => 'بگ کی اطلاع دیں';

  @override
  String get drawerPrivacyPolicyTitle => 'رازداری کی پالیسی';

  @override
  String get bugReportDialogTitle => 'بگ کی اطلاع دیں';

  @override
  String get bugReportEmailSubject => 'بگ رپورٹ - القرآن آڈیو';

  @override
  String get bugReportEmailBodyDeviceInfo => 'ڈیوائس کی معلومات:';

  @override
  String get bugReportEmailBodyAppInfo => 'ایپ کی معلومات:';

  @override
  String get bugReportEmailBodyDescribeBug => 'بگ کی وضاحت کریں:';

  @override
  String get bugReportEmailBodyToReproduce => 'دوبارہ پیش کرنے کے لیے:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'متوقع رویہ:';

  @override
  String get bugReportEmailBodyScreenshots => 'اسکرین شاٹس (اختیاری):';

  @override
  String get bugReportOptionEmail => 'ای میل کے ذریعے';

  @override
  String get bugReportOptionDiscord => 'ڈسکارڈ پر';

  @override
  String get deviceInfoPlatformWeb => 'پلیٹ فارم: ویب';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'براؤزر: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'یوزر ایجنٹ: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'پلیٹ فارم: اینڈرائیڈ';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'ڈیوائس: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'بنانے والا: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'OS ورژن: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'SDK ورژن: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'پلیٹ فارم: iOS';

  @override
  String deviceInfoModel(String modelName) {
    return 'ماڈل: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'پلیٹ فارم: لینکس';

  @override
  String deviceInfoName(String name) {
    return 'نام: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'ورژن: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'پلیٹ فارم: macOS';

  @override
  String get deviceInfoPlatformWindows => 'پلیٹ فارم: ونڈوز';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'کمپیوٹر کا نام: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'ڈیوائس کی معلومات حاصل کرنے میں خرابی: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'نامعلوم پلیٹ فارم';

  @override
  String appInfoAppName(String appName) {
    return 'ایپ کا نام: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'پیکیج کا نام: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'بلڈ نمبر: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'آیت پر جائیں';

  @override
  String get jumpToAyahSearchSurahHint => 'سورت تلاش کریں';

  @override
  String get jumpToAyahPlayButtonLabel => 'منتخب آیت سے چلائیں';

  @override
  String get themeIconButtonTooltip => 'تھیم تبدیل کریں';
}
