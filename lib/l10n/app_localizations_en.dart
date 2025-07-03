// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Al Quran Audio';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsQuranFontSize => 'Quran Font Size';

  @override
  String get settingsAppTheme => 'App Theme';

  @override
  String get settingsAppLanguage => 'App Language';

  @override
  String get settingsAudioCached => 'Audio Cached';

  @override
  String get audioPageTitle => 'Al Quran Audio';

  @override
  String get audioPlayerTooltipPlay => 'Play';

  @override
  String get audioPlayerTooltipPause => 'Pause';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'Select Reciter';

  @override
  String reciterStyleLabel(String style) {
    return 'Style: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'Source: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'More: ';

  @override
  String get saveButtonLabel => 'Save';

  @override
  String get audioSettingsCacheNotFound => 'Cache Not Found';

  @override
  String get audioSettingsCacheSizeLabel => 'Cache Size';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'Error: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'Clean';

  @override
  String get audioSettingsLastModifiedLabel => 'Last Modified';

  @override
  String get timeAgo1Year => '1 Year ago';

  @override
  String get timeAgo6Months => '6 Months ago';

  @override
  String get timeAgo3Months => '3 Months ago';

  @override
  String get timeAgo2Months => '2 Months ago';

  @override
  String get timeAgo1Month => '1 Month ago';

  @override
  String get timeAgo3Weeks => '3 Weeks ago';

  @override
  String get timeAgo2Weeks => '2 Weeks ago';

  @override
  String get timeAgo1Week => '1 Week ago';

  @override
  String get timeAgo6Days => '6 Days ago';

  @override
  String get timeAgo5Days => '5 Days ago';

  @override
  String get timeAgo4Days => '4 Days ago';

  @override
  String get timeAgo3Days => '3 Days ago';

  @override
  String get timeAgo2Days => '2 Days ago';

  @override
  String get timeAgo1Day => '1 Day ago';

  @override
  String get timeToday => 'Today';

  @override
  String get drawerVersionLoading => 'Loading...';

  @override
  String get drawerAppNameSubtitle => 'Al Quran';

  @override
  String get drawerSettingsTitle => 'Settings';

  @override
  String get drawerShareAppTitle => 'Share this App';

  @override
  String get drawerShareAppSubject => 'Check out this Al Quran App!';

  @override
  String drawerShareAppBody(String appLink) {
    return 'Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah\'s words. Download here: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'Give Rating';

  @override
  String get drawerBugReportTitle => 'Bug Report';

  @override
  String get drawerPrivacyPolicyTitle => 'Privacy Policy';

  @override
  String get bugReportDialogTitle => 'Bug Report';

  @override
  String get bugReportEmailSubject => 'Bug Report - Al Quran Audio';

  @override
  String get bugReportEmailBodyDeviceInfo => 'Device Information:';

  @override
  String get bugReportEmailBodyAppInfo => 'App Information:';

  @override
  String get bugReportEmailBodyDescribeBug => 'Describe the bug:';

  @override
  String get bugReportEmailBodyToReproduce => 'To Reproduce:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'Expected behavior:';

  @override
  String get bugReportEmailBodyScreenshots => 'Screenshots (optional):';

  @override
  String get bugReportOptionEmail => 'Through Email';

  @override
  String get bugReportOptionDiscord => 'On Discord';

  @override
  String get deviceInfoPlatformWeb => 'Platform: Web';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'Browser: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'User Agent: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'Platform: Android';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'Device: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'Manufacturer: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'OS Version: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'SDK Version: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'Platform: iOS';

  @override
  String deviceInfoModel(String modelName) {
    return 'Model: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'Platform: Linux';

  @override
  String deviceInfoName(String name) {
    return 'Name: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'Version: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'Platform: macOS';

  @override
  String get deviceInfoPlatformWindows => 'Platform: Windows';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'Computer Name: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'Error getting device info: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'Unknown platform';

  @override
  String appInfoAppName(String appName) {
    return 'App Name: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'Package Name: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'Build Number: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'Jump To Ayah';

  @override
  String get jumpToAyahSearchSurahHint => 'Search for a surah';

  @override
  String get jumpToAyahPlayButtonLabel => 'Play From Selected Ayah';

  @override
  String get themeIconButtonTooltip => 'Change Theme';
}
