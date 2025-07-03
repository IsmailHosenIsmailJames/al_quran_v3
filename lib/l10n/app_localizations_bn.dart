// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'আল কুরআন অডিও';

  @override
  String get settingsPageTitle => 'সেটিংস';

  @override
  String get settingsQuranFontSize => 'কুরআনের ফন্ট সাইজ';

  @override
  String get settingsAppTheme => 'অ্যাপ থিম';

  @override
  String get settingsAppLanguage => 'অ্যাপের ভাষা';

  @override
  String get settingsAudioCached => 'ক্যাশ করা অডিও';

  @override
  String get audioPageTitle => 'আল কুরআন অডিও';

  @override
  String get audioPlayerTooltipPlay => 'প্লে';

  @override
  String get audioPlayerTooltipPause => 'পজ';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'কারী নির্বাচন করুন';

  @override
  String reciterStyleLabel(String style) {
    return 'ধরন: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'উৎস: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'আরও তথ্য: ';

  @override
  String get saveButtonLabel => 'সংরক্ষণ করুন';

  @override
  String get audioSettingsCacheNotFound => 'ক্যাশ খুঁজে পাওয়া যায়নি';

  @override
  String get audioSettingsCacheSizeLabel => 'ক্যাশের আকার';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'ত্রুটি: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'পরিষ্কার করুন';

  @override
  String get audioSettingsLastModifiedLabel => 'শেষ পরিবর্তন';

  @override
  String get timeAgo1Year => '১ বছর আগে';

  @override
  String get timeAgo6Months => '৬ মাস আগে';

  @override
  String get timeAgo3Months => '৩ মাস আগে';

  @override
  String get timeAgo2Months => '২ মাস আগে';

  @override
  String get timeAgo1Month => '১ মাস আগে';

  @override
  String get timeAgo3Weeks => '৩ সপ্তাহ আগে';

  @override
  String get timeAgo2Weeks => '২ সপ্তাহ আগে';

  @override
  String get timeAgo1Week => '১ সপ্তাহ আগে';

  @override
  String get timeAgo6Days => '৬ দিন আগে';

  @override
  String get timeAgo5Days => '৫ দিন আগে';

  @override
  String get timeAgo4Days => '৪ দিন আগে';

  @override
  String get timeAgo3Days => '৩ দিন আগে';

  @override
  String get timeAgo2Days => '২ দিন আগে';

  @override
  String get timeAgo1Day => '১ দিন আগে';

  @override
  String get timeToday => 'আজ';

  @override
  String get drawerVersionLoading => 'লোড হচ্ছে...';

  @override
  String get drawerAppNameSubtitle => 'আল কুরআন';

  @override
  String get drawerSettingsTitle => 'সেটিংস';

  @override
  String get drawerShareAppTitle => 'অ্যাপটি শেয়ার করুন';

  @override
  String get drawerShareAppSubject => 'এই আল কুরআন অ্যাপটি দেখুন!';

  @override
  String drawerShareAppBody(String appLink) {
    return 'আসসালামু আলাইকুম! প্রতিদিন তিলাওয়াত ও চিন্তাভাবনার জন্য এই আল কুরআন অ্যাপটি দেখুন। এটি আপনাকে আল্লাহর বাণীর সাথে সংযুক্ত হতে সাহায্য করবে। এখানে ডাউনলোড করুন: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'রেটিং দিন';

  @override
  String get drawerBugReportTitle => 'বাগ রিপোর্ট';

  @override
  String get drawerPrivacyPolicyTitle => 'গোপনীয়তা নীতি';

  @override
  String get bugReportDialogTitle => 'বাগ রিপোর্ট করুন';

  @override
  String get bugReportEmailSubject => 'বাগ রিপোর্ট - আল কুরআন অডিও';

  @override
  String get bugReportEmailBodyDeviceInfo => 'ডিভাইসের তথ্য:';

  @override
  String get bugReportEmailBodyAppInfo => 'অ্যাপের তথ্য:';

  @override
  String get bugReportEmailBodyDescribeBug => 'বাগটি বর্ণনা করুন:';

  @override
  String get bugReportEmailBodyToReproduce => 'পুনরাবৃত্তি করতে:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'প্রত্যাশিত আচরণ:';

  @override
  String get bugReportEmailBodyScreenshots => 'স্ক্রিনশট (ঐচ্ছিক):';

  @override
  String get bugReportOptionEmail => 'ইমেইলের মাধ্যমে';

  @override
  String get bugReportOptionDiscord => 'ডিসকর্ডে';

  @override
  String get deviceInfoPlatformWeb => 'প্ল্যাটফর্ম: ওয়েব';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'ব্রাউজার: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'ইউজার এজেন্ট: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'প্ল্যাটফর্ম: অ্যান্ড্রয়েড';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'ডিভাইস: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'প্রস্তুতকারক: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'ওএস সংস্করণ: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'এসডিকে সংস্করণ: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'প্ল্যাটফর্ম: আইওএস';

  @override
  String deviceInfoModel(String modelName) {
    return 'মডেল: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'প্ল্যাটফর্ম: লিনাক্স';

  @override
  String deviceInfoName(String name) {
    return 'নাম: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'সংস্করণ: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'প্ল্যাটফর্ম: ম্যাকওএস';

  @override
  String get deviceInfoPlatformWindows => 'প্ল্যাটফর্ম: উইন্ডোজ';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'কম্পিউটারের নাম: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'ডিভাইসের তথ্য পেতে ত্রুটি: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'অজানা প্ল্যাটফর্ম';

  @override
  String appInfoAppName(String appName) {
    return 'অ্যাপের নাম: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'প্যাকেজের নাম: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'বিল্ড নম্বর: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'আয়াতে যান';

  @override
  String get jumpToAyahSearchSurahHint => 'সূরা খুঁজুন';

  @override
  String get jumpToAyahPlayButtonLabel => 'নির্বাচিত আয়াত থেকে প্লে করুন';

  @override
  String get themeIconButtonTooltip => 'থিম পরিবর্তন করুন';
}
