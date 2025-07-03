// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'अल क़ुरान ऑडियो';

  @override
  String get settingsPageTitle => 'सेटिंग्स';

  @override
  String get settingsQuranFontSize => 'क़ुरान फ़ॉन्ट आकार';

  @override
  String get settingsAppTheme => 'ऐप थीम';

  @override
  String get settingsAppLanguage => 'ऐप की भाषा';

  @override
  String get settingsAudioCached => 'कैश किया गया ऑडियो';

  @override
  String get audioPageTitle => 'अल क़ुरान ऑडियो';

  @override
  String get audioPlayerTooltipPlay => 'चलाएं';

  @override
  String get audioPlayerTooltipPause => 'रोकें';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'कारी चुनें';

  @override
  String reciterStyleLabel(String style) {
    return 'शैली: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'स्रोत: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'और जानकारी: ';

  @override
  String get saveButtonLabel => 'सहेजें';

  @override
  String get audioSettingsCacheNotFound => 'कैश नहीं मिला';

  @override
  String get audioSettingsCacheSizeLabel => 'कैश का आकार';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'साफ़ करें';

  @override
  String get audioSettingsLastModifiedLabel => 'अंतिम संशोधन';

  @override
  String get timeAgo1Year => '1 साल पहले';

  @override
  String get timeAgo6Months => '6 महीने पहले';

  @override
  String get timeAgo3Months => '3 महीने पहले';

  @override
  String get timeAgo2Months => '2 महीने पहले';

  @override
  String get timeAgo1Month => '1 महीना पहले';

  @override
  String get timeAgo3Weeks => '3 सप्ताह पहले';

  @override
  String get timeAgo2Weeks => '2 सप्ताह पहले';

  @override
  String get timeAgo1Week => '1 सप्ताह पहले';

  @override
  String get timeAgo6Days => '6 दिन पहले';

  @override
  String get timeAgo5Days => '5 दिन पहले';

  @override
  String get timeAgo4Days => '4 दिन पहले';

  @override
  String get timeAgo3Days => '3 दिन पहले';

  @override
  String get timeAgo2Days => '2 दिन पहले';

  @override
  String get timeAgo1Day => '1 दिन पहले';

  @override
  String get timeToday => 'आज';

  @override
  String get drawerVersionLoading => 'लोड हो रहा है...';

  @override
  String get drawerAppNameSubtitle => 'अल क़ुरान';

  @override
  String get drawerSettingsTitle => 'सेटिंग्स';

  @override
  String get drawerShareAppTitle => 'इस ऐप को साझा करें';

  @override
  String get drawerShareAppSubject => 'यह अल क़ुरान ऐप देखें!';

  @override
  String drawerShareAppBody(String appLink) {
    return 'अस्सलामु अलैकुम! दैनिक पढ़ने और चिंतन के लिए यह अल क़ुरान ऐप देखें। यह अल्लाह के शब्दों से जुड़ने में मदद करता है। यहाँ से डाउनलोड करें: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'रेटिंग दें';

  @override
  String get drawerBugReportTitle => 'बग रिपोर्ट करें';

  @override
  String get drawerPrivacyPolicyTitle => 'गोपनीयता नीति';

  @override
  String get bugReportDialogTitle => 'बग रिपोर्ट करें';

  @override
  String get bugReportEmailSubject => 'बग रिपोर्ट - अल क़ुरान ऑडियो';

  @override
  String get bugReportEmailBodyDeviceInfo => 'डिवाइस की जानकारी:';

  @override
  String get bugReportEmailBodyAppInfo => 'ऐप की जानकारी:';

  @override
  String get bugReportEmailBodyDescribeBug => 'बग का वर्णन करें:';

  @override
  String get bugReportEmailBodyToReproduce => 'पुनः उत्पन्न करने के लिए:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'अपेक्षित व्यवहार:';

  @override
  String get bugReportEmailBodyScreenshots => 'स्क्रीनशॉट (वैकल्पिक):';

  @override
  String get bugReportOptionEmail => 'ईमेल के माध्यम से';

  @override
  String get bugReportOptionDiscord => 'डिस्कॉर्ड पर';

  @override
  String get deviceInfoPlatformWeb => 'प्लेटफ़ॉर्म: वेब';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'ब्राउज़र: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'यूज़र एजेंट: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'प्लेटफ़ॉर्म: एंड्रॉइड';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'डिवाइस: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'निर्माता: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'ओएस संस्करण: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'एसडीके संस्करण: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'प्लेटफ़ॉर्म: iOS';

  @override
  String deviceInfoModel(String modelName) {
    return 'मॉडल: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'प्लेटफ़ॉर्म: लिनक्स';

  @override
  String deviceInfoName(String name) {
    return 'नाम: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'संस्करण: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'प्लेटफ़ॉर्म: macOS';

  @override
  String get deviceInfoPlatformWindows => 'प्लेटफ़ॉर्म: विंडोज';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'कंप्यूटर का नाम: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'डिवाइस की जानकारी प्राप्त करने में त्रुटि: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'अज्ञात प्लेटफ़ॉर्म';

  @override
  String appInfoAppName(String appName) {
    return 'ऐप का नाम: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'पैकेज का नाम: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'बिल्ड नंबर: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'आयत पर जाएं';

  @override
  String get jumpToAyahSearchSurahHint => 'एक सूरह खोजें';

  @override
  String get jumpToAyahPlayButtonLabel => 'चुनी हुई आयत से चलाएं';

  @override
  String get themeIconButtonTooltip => 'थीम बदलें';
}
