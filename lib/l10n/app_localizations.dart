import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('en'),
    Locale('es'),
    Locale('hi'),
    Locale('ur'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Al Quran Audio'**
  String get appTitle;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsQuranFontSize.
  ///
  /// In en, this message translates to:
  /// **'Quran Font Size'**
  String get settingsQuranFontSize;

  /// No description provided for @settingsAppTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get settingsAppTheme;

  /// No description provided for @settingsAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get settingsAppLanguage;

  /// No description provided for @settingsAudioCached.
  ///
  /// In en, this message translates to:
  /// **'Audio Cached'**
  String get settingsAudioCached;

  /// No description provided for @audioPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Al Quran Audio'**
  String get audioPageTitle;

  /// No description provided for @audioPlayerTooltipPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get audioPlayerTooltipPlay;

  /// No description provided for @audioPlayerTooltipPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get audioPlayerTooltipPause;

  /// Display for Surah name and Ayah number
  ///
  /// In en, this message translates to:
  /// **'{surahName} - {ayahKey}'**
  String audioPageSurahAyahDisplay(String surahName, String ayahKey);

  /// No description provided for @changeReciterTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get changeReciterTitle;

  /// No description provided for @reciterStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Style: {style}'**
  String reciterStyleLabel(String style);

  /// No description provided for @reciterSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String reciterSourceLabel(String source);

  /// No description provided for @reciterMoreInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'More: '**
  String get reciterMoreInfoLabel;

  /// No description provided for @saveButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButtonLabel;

  /// No description provided for @audioSettingsCacheNotFound.
  ///
  /// In en, this message translates to:
  /// **'Cache Not Found'**
  String get audioSettingsCacheNotFound;

  /// No description provided for @audioSettingsCacheSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get audioSettingsCacheSizeLabel;

  /// No description provided for @audioSettingsErrorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String audioSettingsErrorLabel(String error);

  /// No description provided for @audioSettingsCleanButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get audioSettingsCleanButtonLabel;

  /// No description provided for @audioSettingsLastModifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Modified'**
  String get audioSettingsLastModifiedLabel;

  /// No description provided for @timeAgo1Year.
  ///
  /// In en, this message translates to:
  /// **'1 Year ago'**
  String get timeAgo1Year;

  /// No description provided for @timeAgo6Months.
  ///
  /// In en, this message translates to:
  /// **'6 Months ago'**
  String get timeAgo6Months;

  /// No description provided for @timeAgo3Months.
  ///
  /// In en, this message translates to:
  /// **'3 Months ago'**
  String get timeAgo3Months;

  /// No description provided for @timeAgo2Months.
  ///
  /// In en, this message translates to:
  /// **'2 Months ago'**
  String get timeAgo2Months;

  /// No description provided for @timeAgo1Month.
  ///
  /// In en, this message translates to:
  /// **'1 Month ago'**
  String get timeAgo1Month;

  /// No description provided for @timeAgo3Weeks.
  ///
  /// In en, this message translates to:
  /// **'3 Weeks ago'**
  String get timeAgo3Weeks;

  /// No description provided for @timeAgo2Weeks.
  ///
  /// In en, this message translates to:
  /// **'2 Weeks ago'**
  String get timeAgo2Weeks;

  /// No description provided for @timeAgo1Week.
  ///
  /// In en, this message translates to:
  /// **'1 Week ago'**
  String get timeAgo1Week;

  /// No description provided for @timeAgo6Days.
  ///
  /// In en, this message translates to:
  /// **'6 Days ago'**
  String get timeAgo6Days;

  /// No description provided for @timeAgo5Days.
  ///
  /// In en, this message translates to:
  /// **'5 Days ago'**
  String get timeAgo5Days;

  /// No description provided for @timeAgo4Days.
  ///
  /// In en, this message translates to:
  /// **'4 Days ago'**
  String get timeAgo4Days;

  /// No description provided for @timeAgo3Days.
  ///
  /// In en, this message translates to:
  /// **'3 Days ago'**
  String get timeAgo3Days;

  /// No description provided for @timeAgo2Days.
  ///
  /// In en, this message translates to:
  /// **'2 Days ago'**
  String get timeAgo2Days;

  /// No description provided for @timeAgo1Day.
  ///
  /// In en, this message translates to:
  /// **'1 Day ago'**
  String get timeAgo1Day;

  /// No description provided for @timeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get timeToday;

  /// No description provided for @drawerVersionLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get drawerVersionLoading;

  /// No description provided for @drawerAppNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Al Quran'**
  String get drawerAppNameSubtitle;

  /// No description provided for @drawerSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettingsTitle;

  /// No description provided for @drawerShareAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Share this App'**
  String get drawerShareAppTitle;

  /// No description provided for @drawerShareAppSubject.
  ///
  /// In en, this message translates to:
  /// **'Check out this Al Quran App!'**
  String get drawerShareAppSubject;

  /// The message body for sharing the app
  ///
  /// In en, this message translates to:
  /// **'Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah\'s words. Download here: {appLink}'**
  String drawerShareAppBody(String appLink);

  /// No description provided for @drawerGiveRatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Give Rating'**
  String get drawerGiveRatingTitle;

  /// No description provided for @drawerBugReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get drawerBugReportTitle;

  /// No description provided for @drawerPrivacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get drawerPrivacyPolicyTitle;

  /// No description provided for @bugReportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReportDialogTitle;

  /// No description provided for @bugReportEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Bug Report - Al Quran Audio'**
  String get bugReportEmailSubject;

  /// No description provided for @bugReportEmailBodyDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Information:'**
  String get bugReportEmailBodyDeviceInfo;

  /// No description provided for @bugReportEmailBodyAppInfo.
  ///
  /// In en, this message translates to:
  /// **'App Information:'**
  String get bugReportEmailBodyAppInfo;

  /// No description provided for @bugReportEmailBodyDescribeBug.
  ///
  /// In en, this message translates to:
  /// **'Describe the bug:'**
  String get bugReportEmailBodyDescribeBug;

  /// No description provided for @bugReportEmailBodyToReproduce.
  ///
  /// In en, this message translates to:
  /// **'To Reproduce:'**
  String get bugReportEmailBodyToReproduce;

  /// No description provided for @bugReportEmailBodyExpectedBehavior.
  ///
  /// In en, this message translates to:
  /// **'Expected behavior:'**
  String get bugReportEmailBodyExpectedBehavior;

  /// No description provided for @bugReportEmailBodyScreenshots.
  ///
  /// In en, this message translates to:
  /// **'Screenshots (optional):'**
  String get bugReportEmailBodyScreenshots;

  /// No description provided for @bugReportOptionEmail.
  ///
  /// In en, this message translates to:
  /// **'Through Email'**
  String get bugReportOptionEmail;

  /// No description provided for @bugReportOptionDiscord.
  ///
  /// In en, this message translates to:
  /// **'On Discord'**
  String get bugReportOptionDiscord;

  /// No description provided for @deviceInfoPlatformWeb.
  ///
  /// In en, this message translates to:
  /// **'Platform: Web'**
  String get deviceInfoPlatformWeb;

  /// No description provided for @deviceInfoBrowser.
  ///
  /// In en, this message translates to:
  /// **'Browser: {browserName}'**
  String deviceInfoBrowser(String browserName);

  /// No description provided for @deviceInfoUserAgent.
  ///
  /// In en, this message translates to:
  /// **'User Agent: {userAgent}'**
  String deviceInfoUserAgent(String userAgent);

  /// No description provided for @deviceInfoPlatformAndroid.
  ///
  /// In en, this message translates to:
  /// **'Platform: Android'**
  String get deviceInfoPlatformAndroid;

  /// No description provided for @deviceInfoDevice.
  ///
  /// In en, this message translates to:
  /// **'Device: {deviceName}'**
  String deviceInfoDevice(String deviceName);

  /// No description provided for @deviceInfoManufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer: {manufacturerName}'**
  String deviceInfoManufacturer(String manufacturerName);

  /// No description provided for @deviceInfoOsVersion.
  ///
  /// In en, this message translates to:
  /// **'OS Version: {osVersion}'**
  String deviceInfoOsVersion(String osVersion);

  /// No description provided for @deviceInfoSdkVersion.
  ///
  /// In en, this message translates to:
  /// **'SDK Version: {sdkVersion}'**
  String deviceInfoSdkVersion(String sdkVersion);

  /// No description provided for @deviceInfoPlatformIOS.
  ///
  /// In en, this message translates to:
  /// **'Platform: iOS'**
  String get deviceInfoPlatformIOS;

  /// No description provided for @deviceInfoModel.
  ///
  /// In en, this message translates to:
  /// **'Model: {modelName}'**
  String deviceInfoModel(String modelName);

  /// No description provided for @deviceInfoPlatformLinux.
  ///
  /// In en, this message translates to:
  /// **'Platform: Linux'**
  String get deviceInfoPlatformLinux;

  /// No description provided for @deviceInfoName.
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String deviceInfoName(String name);

  /// No description provided for @deviceInfoVersion.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String deviceInfoVersion(String version);

  /// No description provided for @deviceInfoPlatformMacOS.
  ///
  /// In en, this message translates to:
  /// **'Platform: macOS'**
  String get deviceInfoPlatformMacOS;

  /// No description provided for @deviceInfoPlatformWindows.
  ///
  /// In en, this message translates to:
  /// **'Platform: Windows'**
  String get deviceInfoPlatformWindows;

  /// No description provided for @deviceInfoComputerName.
  ///
  /// In en, this message translates to:
  /// **'Computer Name: {computerName}'**
  String deviceInfoComputerName(String computerName);

  /// No description provided for @deviceInfoError.
  ///
  /// In en, this message translates to:
  /// **'Error getting device info: {error}'**
  String deviceInfoError(String error);

  /// No description provided for @deviceInfoUnknownPlatform.
  ///
  /// In en, this message translates to:
  /// **'Unknown platform'**
  String get deviceInfoUnknownPlatform;

  /// No description provided for @appInfoAppName.
  ///
  /// In en, this message translates to:
  /// **'App Name: {appName}'**
  String appInfoAppName(String appName);

  /// No description provided for @appInfoPackageName.
  ///
  /// In en, this message translates to:
  /// **'Package Name: {packageName}'**
  String appInfoPackageName(String packageName);

  /// No description provided for @appInfoBuildNumber.
  ///
  /// In en, this message translates to:
  /// **'Build Number: {buildNumber}'**
  String appInfoBuildNumber(String buildNumber);

  /// No description provided for @jumpToAyahDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Jump To Ayah'**
  String get jumpToAyahDialogTitle;

  /// No description provided for @jumpToAyahSearchSurahHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a surah'**
  String get jumpToAyahSearchSurahHint;

  /// No description provided for @jumpToAyahPlayButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Play From Selected Ayah'**
  String get jumpToAyahPlayButtonLabel;

  /// No description provided for @themeIconButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get themeIconButtonTooltip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'en',
    'es',
    'hi',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
