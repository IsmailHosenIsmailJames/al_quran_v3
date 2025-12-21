import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_az.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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
    Locale('az'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('ko'),
    Locale('ms'),
    Locale('pa'),
    Locale('ps'),
    Locale('pt'),
    Locale('ru'),
    Locale('sw'),
    Locale('ta'),
    Locale('tr'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @tafsirAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'{nameSimple} ( {nameArabic} ) - {ayahKey}'**
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  );

  /// No description provided for @tafsirNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Tafsir is not available for {ayahKey}'**
  String tafsirNotAvailable(String ayahKey);

  /// No description provided for @tafsirFoundAt.
  ///
  /// In en, this message translates to:
  /// **'Tafsir will found at : {anotherAyahLinkKey}'**
  String tafsirFoundAt(String anotherAyahLinkKey);

  /// No description provided for @tafsirJumpTo.
  ///
  /// In en, this message translates to:
  /// **'Jump to {anotherAyahLinkKey}'**
  String tafsirJumpTo(String anotherAyahLinkKey);

  /// No description provided for @hizb.
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get hizb;

  /// No description provided for @juz.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get juz;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @ruku.
  ///
  /// In en, this message translates to:
  /// **'Ruku'**
  String get ruku;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @surahAyah.
  ///
  /// In en, this message translates to:
  /// **'{surahName} {ayahKey}'**
  String surahAyah(String surahName, String ayahKey);

  /// No description provided for @ayahsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Ayahs'**
  String ayahsCount(String count);

  /// No description provided for @saveAndDownload.
  ///
  /// In en, this message translates to:
  /// **'Save and Download'**
  String get saveAndDownload;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @selectAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select app language...'**
  String get selectAppLanguage;

  /// No description provided for @pleaseSelectOne.
  ///
  /// In en, this message translates to:
  /// **'Please select one'**
  String get pleaseSelectOne;

  /// No description provided for @quranTranslationLanguage.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation Language'**
  String get quranTranslationLanguage;

  /// No description provided for @selectTranslationLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select translation language...'**
  String get selectTranslationLanguage;

  /// No description provided for @quranTranslationBook.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation Book'**
  String get quranTranslationBook;

  /// No description provided for @selectTranslationBook.
  ///
  /// In en, this message translates to:
  /// **'Select translation book...'**
  String get selectTranslationBook;

  /// No description provided for @quranTafsirLanguage.
  ///
  /// In en, this message translates to:
  /// **'Quran Tafsir Language'**
  String get quranTafsirLanguage;

  /// No description provided for @selectTafsirLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select tafsir language...'**
  String get selectTafsirLanguage;

  /// No description provided for @quranTafsirBook.
  ///
  /// In en, this message translates to:
  /// **'Quran Tafsir Book'**
  String get quranTafsirBook;

  /// No description provided for @selectTafsirBook.
  ///
  /// In en, this message translates to:
  /// **'Select tafsir book...'**
  String get selectTafsirBook;

  /// No description provided for @quranScriptAndStyle.
  ///
  /// In en, this message translates to:
  /// **'Quran Script & Style'**
  String get quranScriptAndStyle;

  /// No description provided for @justAMoment.
  ///
  /// In en, this message translates to:
  /// **'Just a moment...'**
  String get justAMoment;

  /// No description provided for @processProgress.
  ///
  /// In en, this message translates to:
  /// **'{processName} {percentage}'**
  String processProgress(String processName, String percentage);

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @unableToDownloadResources.
  ///
  /// In en, this message translates to:
  /// **'Unable to download resources...\nSomething went wrong'**
  String get unableToDownloadResources;

  /// No description provided for @downloadingSegmentedQuranRecitation.
  ///
  /// In en, this message translates to:
  /// **'Downloading Segmented Quran Recitation'**
  String get downloadingSegmentedQuranRecitation;

  /// No description provided for @processingSegmentedQuranRecitation.
  ///
  /// In en, this message translates to:
  /// **'Processing Segmented Quran Recitation'**
  String get processingSegmentedQuranRecitation;

  /// No description provided for @footnote.
  ///
  /// In en, this message translates to:
  /// **'Footnote'**
  String get footnote;

  /// No description provided for @tafsir.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsir;

  /// No description provided for @wordByWord.
  ///
  /// In en, this message translates to:
  /// **'Word by Word'**
  String get wordByWord;

  /// No description provided for @pleaseSelectRequiredOption.
  ///
  /// In en, this message translates to:
  /// **'Please select required option'**
  String get pleaseSelectRequiredOption;

  /// No description provided for @rememberHomeTab.
  ///
  /// In en, this message translates to:
  /// **'Remember Home Tab'**
  String get rememberHomeTab;

  /// No description provided for @rememberHomeTabSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App will remember the last opened tab in the home screen.'**
  String get rememberHomeTabSubtitle;

  /// No description provided for @wakeLock.
  ///
  /// In en, this message translates to:
  /// **'Wake Lock'**
  String get wakeLock;

  /// No description provided for @wakeLockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevent the screen from turning off automatically.'**
  String get wakeLockSubtitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @quranStyle.
  ///
  /// In en, this message translates to:
  /// **'Quran Style'**
  String get quranStyle;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @verseCount.
  ///
  /// In en, this message translates to:
  /// **'Verse Count: '**
  String get verseCount;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @tafsirNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get tafsirNotFound;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'more info'**
  String get moreInfo;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play Audio'**
  String get playAudio;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorFetchingAddress.
  ///
  /// In en, this message translates to:
  /// **'Error fetching address'**
  String get errorFetchingAddress;

  /// No description provided for @addressNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Address not available'**
  String get addressNotAvailable;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude: '**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude: '**
  String get longitude;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get name;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location: '**
  String get location;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters: '**
  String get parameters;

  /// No description provided for @selectCalculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Calculation Method'**
  String get selectCalculationMethod;

  /// No description provided for @shareSelectAyahs.
  ///
  /// In en, this message translates to:
  /// **'Share Select Ayahs'**
  String get shareSelectAyahs;

  /// No description provided for @selectionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Selection Empty'**
  String get selectionEmpty;

  /// No description provided for @generatingImagePleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Generating Image... Please Wait'**
  String get generatingImagePleaseWait;

  /// No description provided for @asImage.
  ///
  /// In en, this message translates to:
  /// **'As Image'**
  String get asImage;

  /// No description provided for @asText.
  ///
  /// In en, this message translates to:
  /// **'As Text'**
  String get asText;

  /// No description provided for @playFromSelectedAyah.
  ///
  /// In en, this message translates to:
  /// **'Play From Selected Ayah'**
  String get playFromSelectedAyah;

  /// No description provided for @toTafsir.
  ///
  /// In en, this message translates to:
  /// **'To Tafsir'**
  String get toTafsir;

  /// No description provided for @selectAyah.
  ///
  /// In en, this message translates to:
  /// **'Select Ayah'**
  String get selectAyah;

  /// No description provided for @toAyah.
  ///
  /// In en, this message translates to:
  /// **'To Ayah'**
  String get toAyah;

  /// No description provided for @searchForASurah.
  ///
  /// In en, this message translates to:
  /// **'Search for a surah'**
  String get searchForASurah;

  /// No description provided for @bugReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReportTitle;

  /// No description provided for @audioCached.
  ///
  /// In en, this message translates to:
  /// **'Audio Cached'**
  String get audioCached;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @quranTranslationAyahOneMustEnabled.
  ///
  /// In en, this message translates to:
  /// **'Quran|Translation|Ayah, One Must Enabled'**
  String get quranTranslationAyahOneMustEnabled;

  /// No description provided for @quranFontSize.
  ///
  /// In en, this message translates to:
  /// **'Quran Font Size'**
  String get quranFontSize;

  /// No description provided for @quranLineHeight.
  ///
  /// In en, this message translates to:
  /// **'Quran Line Height'**
  String get quranLineHeight;

  /// No description provided for @translationAndTafsirFontSize.
  ///
  /// In en, this message translates to:
  /// **'Translation & Tafsir Font Size'**
  String get translationAndTafsirFontSize;

  /// No description provided for @quranAyah.
  ///
  /// In en, this message translates to:
  /// **'Quran Ayah'**
  String get quranAyah;

  /// No description provided for @topToolbar.
  ///
  /// In en, this message translates to:
  /// **'Top Toolbar'**
  String get topToolbar;

  /// No description provided for @keepOpenWordByWord.
  ///
  /// In en, this message translates to:
  /// **'Keep Open Word By Word'**
  String get keepOpenWordByWord;

  /// No description provided for @wordByWordHighlight.
  ///
  /// In en, this message translates to:
  /// **'Word By Word Highlight'**
  String get wordByWordHighlight;

  /// No description provided for @quranScriptSettings.
  ///
  /// In en, this message translates to:
  /// **'Quran Script Settings'**
  String get quranScriptSettings;

  /// No description provided for @surahName.
  ///
  /// In en, this message translates to:
  /// **'{nameSimple}'**
  String surahName(String nameSimple);

  /// No description provided for @pageNumber.
  ///
  /// In en, this message translates to:
  /// **'Page: '**
  String get pageNumber;

  /// No description provided for @quranResources.
  ///
  /// In en, this message translates to:
  /// **'Quran Resources'**
  String get quranResources;

  /// No description provided for @alreadySelected.
  ///
  /// In en, this message translates to:
  /// **'Language \'{name}\' is already selected.'**
  String alreadySelected(String name);

  /// No description provided for @unableToGetCompassData.
  ///
  /// In en, this message translates to:
  /// **'Unable to get compass data'**
  String get unableToGetCompassData;

  /// No description provided for @deviceDoesNotHaveSensors.
  ///
  /// In en, this message translates to:
  /// **'Device does not have sensors !'**
  String get deviceDoesNotHaveSensors;

  /// No description provided for @north.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get north;

  /// No description provided for @east.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get east;

  /// No description provided for @south.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get south;

  /// No description provided for @west.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get west;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address: '**
  String get address;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @calculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation Method: '**
  String get calculationMethod;

  /// No description provided for @downloadPrayerTime.
  ///
  /// In en, this message translates to:
  /// **'Download Prayer Time'**
  String get downloadPrayerTime;

  /// No description provided for @calculationMethodsListEmpty.
  ///
  /// In en, this message translates to:
  /// **'The list of calculation methods is empty.'**
  String get calculationMethodsListEmpty;

  /// No description provided for @noCalculationMethodWithLocationData.
  ///
  /// In en, this message translates to:
  /// **'Could not find any calculation method with location data.'**
  String get noCalculationMethodWithLocationData;

  /// No description provided for @prayerSettings.
  ///
  /// In en, this message translates to:
  /// **'Prayer Settings'**
  String get prayerSettings;

  /// No description provided for @reminderSettings.
  ///
  /// In en, this message translates to:
  /// **'Reminder Settings'**
  String get reminderSettings;

  /// No description provided for @adjustReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Adjust Reminder Time'**
  String get adjustReminderTime;

  /// No description provided for @enforceAlarmSound.
  ///
  /// In en, this message translates to:
  /// **'Enforce Alarm\'s Sound'**
  String get enforceAlarmSound;

  /// No description provided for @enforceAlarmSoundDescription.
  ///
  /// In en, this message translates to:
  /// **'If enabled, This feature will play the alarm at the volume set here, even if your phone\'s sound is low. This ensures you don\'t miss the alarm due to low phone volume.'**
  String get enforceAlarmSoundDescription;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @atPrayerTime.
  ///
  /// In en, this message translates to:
  /// **'At prayer time'**
  String get atPrayerTime;

  /// No description provided for @minBefore.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min before'**
  String minBefore(int minutes);

  /// No description provided for @minAfter.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min after'**
  String minAfter(int minutes);

  /// No description provided for @prayerTimeIsAt.
  ///
  /// In en, this message translates to:
  /// **'{prayerName} is at {prayerTime}'**
  String prayerTimeIsAt(String prayerName, String prayerTime);

  /// No description provided for @itsTimeOf.
  ///
  /// In en, this message translates to:
  /// **'It\'s time of {prayerName}'**
  String itsTimeOf(String prayerName);

  /// No description provided for @stopTheAdhan.
  ///
  /// In en, this message translates to:
  /// **'Stop the Adhan'**
  String get stopTheAdhan;

  /// No description provided for @dateFoundEmpty.
  ///
  /// In en, this message translates to:
  /// **'{date} Found Empty'**
  String dateFoundEmpty(String date);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @reminderAdded.
  ///
  /// In en, this message translates to:
  /// **'Reminder for {prayerName} added'**
  String reminderAdded(String prayerName);

  /// No description provided for @allowNotificationPermission.
  ///
  /// In en, this message translates to:
  /// **'Please allow notification permission to use this feature'**
  String get allowNotificationPermission;

  /// No description provided for @reminderRemoved.
  ///
  /// In en, this message translates to:
  /// **'Reminder for {prayerName} removed'**
  String reminderRemoved(String prayerName);

  /// No description provided for @getPrayerTimesAndQibla.
  ///
  /// In en, this message translates to:
  /// **'Get Prayer Times and Qibla'**
  String get getPrayerTimesAndQibla;

  /// No description provided for @getPrayerTimesAndQiblaDescription.
  ///
  /// In en, this message translates to:
  /// **'Calculate Prayer Times and Qibla for Any Given Location.'**
  String get getPrayerTimesAndQiblaDescription;

  /// No description provided for @getFromGPS.
  ///
  /// In en, this message translates to:
  /// **'Get form GPS'**
  String get getFromGPS;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @selectYourCity.
  ///
  /// In en, this message translates to:
  /// **'Select you City'**
  String get selectYourCity;

  /// No description provided for @noteAboutGPS.
  ///
  /// In en, this message translates to:
  /// **'Note: If you don\'t want to use GPS or not feel secure, you can select your city.'**
  String get noteAboutGPS;

  /// No description provided for @downloadingLocationResources.
  ///
  /// In en, this message translates to:
  /// **'Downloading location resources...'**
  String get downloadingLocationResources;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @selectYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Your Country'**
  String get selectYourCountry;

  /// No description provided for @searchForACountry.
  ///
  /// In en, this message translates to:
  /// **'Search for a country'**
  String get searchForACountry;

  /// No description provided for @selectYourAdministrator.
  ///
  /// In en, this message translates to:
  /// **'Select Your Administrator'**
  String get selectYourAdministrator;

  /// No description provided for @searchForAnAdministrator.
  ///
  /// In en, this message translates to:
  /// **'Search for a administrator'**
  String get searchForAnAdministrator;

  /// No description provided for @searchForACity.
  ///
  /// In en, this message translates to:
  /// **'Search for a city'**
  String get searchForACity;

  /// No description provided for @pleaseEnableLocationService.
  ///
  /// In en, this message translates to:
  /// **'Please enable location service'**
  String get pleaseEnableLocationService;

  /// No description provided for @donateUs.
  ///
  /// In en, this message translates to:
  /// **'Donate Us'**
  String get donateUs;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Under development'**
  String get underDevelopment;

  /// No description provided for @versionLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get versionLoading;

  /// No description provided for @alQuran.
  ///
  /// In en, this message translates to:
  /// **'Al Quran'**
  String get alQuran;

  /// No description provided for @mainMenu.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get mainMenu;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @pinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get pinned;

  /// No description provided for @jumpToAyah.
  ///
  /// In en, this message translates to:
  /// **'Jump to Ayah'**
  String get jumpToAyah;

  /// No description provided for @shareMultipleAyah.
  ///
  /// In en, this message translates to:
  /// **'Share Multiple Ayah'**
  String get shareMultipleAyah;

  /// No description provided for @shareThisApp.
  ///
  /// In en, this message translates to:
  /// **'Share this App'**
  String get shareThisApp;

  /// No description provided for @giveRating.
  ///
  /// In en, this message translates to:
  /// **'Give Rating'**
  String get giveRating;

  /// No description provided for @bugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReport;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @aboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutTheApp;

  /// No description provided for @resetTheApp.
  ///
  /// In en, this message translates to:
  /// **'Reset the App'**
  String get resetTheApp;

  /// No description provided for @resetAppWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset App Data'**
  String get resetAppWarningTitle;

  /// No description provided for @resetAppWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the app? All your data will be lost, and you will need to set up the app from the beginning.'**
  String get resetAppWarningMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @shareAppSubject.
  ///
  /// In en, this message translates to:
  /// **'Check out this Al Quran App!'**
  String get shareAppSubject;

  /// No description provided for @shareAppBody.
  ///
  /// In en, this message translates to:
  /// **'Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah\'s words. Download here: {appLink}'**
  String shareAppBody(String appLink);

  /// No description provided for @openDrawerTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open Drawer'**
  String get openDrawerTooltip;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @prayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get prayer;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// No description provided for @surah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get surah;

  /// No description provided for @pages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get note;

  /// No description provided for @linkedAyahs.
  ///
  /// In en, this message translates to:
  /// **'Linked Ayahs:'**
  String get linkedAyahs;

  /// No description provided for @emptyNoteCollection.
  ///
  /// In en, this message translates to:
  /// **'This note collection is empty.\nAdd some notes to see them here.'**
  String get emptyNoteCollection;

  /// No description provided for @emptyPinnedCollection.
  ///
  /// In en, this message translates to:
  /// **'No Ayahs pinned to this collection yet.\nPin Ayahs to see them here.'**
  String get emptyPinnedCollection;

  /// No description provided for @noContentAvailable.
  ///
  /// In en, this message translates to:
  /// **'No content available.'**
  String get noContentAvailable;

  /// No description provided for @failedToLoadCollections.
  ///
  /// In en, this message translates to:
  /// **'Failed to load collections: {error}'**
  String failedToLoadCollections(String error);

  /// No description provided for @searchByCollectionName.
  ///
  /// In en, this message translates to:
  /// **'Search By {collectionType} Name...'**
  String searchByCollectionName(String collectionType);

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @noCollectionAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No {collectionType} added yet'**
  String noCollectionAddedYet(String collectionType);

  /// No description provided for @pinnedItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} pinned items'**
  String pinnedItemsCount(int count);

  /// No description provided for @notesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} notes'**
  String notesCount(int count);

  /// No description provided for @emptyNameNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Empty name not allowed'**
  String get emptyNameNotAllowed;

  /// No description provided for @updatedTo.
  ///
  /// In en, this message translates to:
  /// **'Updated to {collectionName}'**
  String updatedTo(String collectionName);

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// No description provided for @changeColor.
  ///
  /// In en, this message translates to:
  /// **'Change Color'**
  String get changeColor;

  /// No description provided for @colorUpdated.
  ///
  /// In en, this message translates to:
  /// **'Color updated'**
  String get colorUpdated;

  /// No description provided for @collectionDeleted.
  ///
  /// In en, this message translates to:
  /// **'{collectionName} Deleted'**
  String collectionDeleted(String collectionName);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @collectionNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Collection name cannot be empty.'**
  String get collectionNameCannotBeEmpty;

  /// No description provided for @addedNewCollection.
  ///
  /// In en, this message translates to:
  /// **'Added New Collection'**
  String get addedNewCollection;

  /// No description provided for @ayahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Ayah'**
  String ayahCount(int count);

  /// No description provided for @byNameAtoZ.
  ///
  /// In en, this message translates to:
  /// **'Name A-Z'**
  String get byNameAtoZ;

  /// No description provided for @byNameZtoA.
  ///
  /// In en, this message translates to:
  /// **'Name Z-A'**
  String get byNameZtoA;

  /// No description provided for @byElementNumberAscending.
  ///
  /// In en, this message translates to:
  /// **'Element Number Ascending'**
  String get byElementNumberAscending;

  /// No description provided for @byElementNumberDescending.
  ///
  /// In en, this message translates to:
  /// **'Element Number Descending'**
  String get byElementNumberDescending;

  /// No description provided for @byUpdateDateAscending.
  ///
  /// In en, this message translates to:
  /// **'Update Date Ascending'**
  String get byUpdateDateAscending;

  /// No description provided for @byUpdateDateDescending.
  ///
  /// In en, this message translates to:
  /// **'Update Date Descending'**
  String get byUpdateDateDescending;

  /// No description provided for @byCreateDateAscending.
  ///
  /// In en, this message translates to:
  /// **'Create Date Ascending'**
  String get byCreateDateAscending;

  /// No description provided for @byCreateDateDescending.
  ///
  /// In en, this message translates to:
  /// **'Create Date Descending'**
  String get byCreateDateDescending;

  /// No description provided for @translationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Translation Not Found'**
  String get translationNotFound;

  /// No description provided for @translationTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation:'**
  String get translationTitle;

  /// No description provided for @footNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Foot Note:'**
  String get footNoteTitle;

  /// No description provided for @wordByWordTranslation.
  ///
  /// In en, this message translates to:
  /// **'Word by Word Translation:'**
  String get wordByWordTranslation;

  /// No description provided for @tafsirButton.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirButton;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @addNoteButton.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNoteButton;

  /// No description provided for @pinToCollectionButton.
  ///
  /// In en, this message translates to:
  /// **'Pin to Collection'**
  String get pinToCollectionButton;

  /// No description provided for @shareAsText.
  ///
  /// In en, this message translates to:
  /// **'Share as Text'**
  String get shareAsText;

  /// No description provided for @copiedWithTafsir.
  ///
  /// In en, this message translates to:
  /// **'Copied with Tafsir'**
  String get copiedWithTafsir;

  /// No description provided for @shareAsImage.
  ///
  /// In en, this message translates to:
  /// **'Share as Image'**
  String get shareAsImage;

  /// No description provided for @shareWithTafsir.
  ///
  /// In en, this message translates to:
  /// **'Share with Tafsir'**
  String get shareWithTafsir;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @noteContentCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Note content cannot be empty.'**
  String get noteContentCannotBeEmpty;

  /// No description provided for @noteSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Note saved successfully!'**
  String get noteSavedSuccessfully;

  /// No description provided for @selectCollections.
  ///
  /// In en, this message translates to:
  /// **'Select Collections'**
  String get selectCollections;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @writeCollectionName.
  ///
  /// In en, this message translates to:
  /// **'Write collection name...'**
  String get writeCollectionName;

  /// No description provided for @noCollectionsYetAddANewOne.
  ///
  /// In en, this message translates to:
  /// **'No collections yet. Add a new one!'**
  String get noCollectionsYetAddANewOne;

  /// No description provided for @pleaseWriteYourNoteFirst.
  ///
  /// In en, this message translates to:
  /// **'Please write your note first.'**
  String get pleaseWriteYourNoteFirst;

  /// No description provided for @noCollectionSelected.
  ///
  /// In en, this message translates to:
  /// **'No Collection selected'**
  String get noCollectionSelected;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get saveNote;

  /// No description provided for @nextSelectCollections.
  ///
  /// In en, this message translates to:
  /// **'Next: Select Collections'**
  String get nextSelectCollections;

  /// No description provided for @addToPinned.
  ///
  /// In en, this message translates to:
  /// **'Add To Pinned'**
  String get addToPinned;

  /// No description provided for @pinnedSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Pinned saved successfully!'**
  String get pinnedSavedSuccessfully;

  /// No description provided for @savePinned.
  ///
  /// In en, this message translates to:
  /// **'Save Pinned'**
  String get savePinned;

  /// No description provided for @closeAudioController.
  ///
  /// In en, this message translates to:
  /// **'Close Audio Controller'**
  String get closeAudioController;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @rewind.
  ///
  /// In en, this message translates to:
  /// **'Rewind'**
  String get rewind;

  /// No description provided for @fastForward.
  ///
  /// In en, this message translates to:
  /// **'Fast Forward'**
  String get fastForward;

  /// No description provided for @playNextAyah.
  ///
  /// In en, this message translates to:
  /// **'Play Next Ayah'**
  String get playNextAyah;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// No description provided for @playAsPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Play As Playlist'**
  String get playAsPlaylist;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style: {style}'**
  String style(String style);

  /// No description provided for @stopAndClose.
  ///
  /// In en, this message translates to:
  /// **'Stop & Close'**
  String get stopAndClose;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @selectReciter.
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get selectReciter;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String source(String source);

  /// No description provided for @newText.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newText;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More: '**
  String get more;

  /// No description provided for @cacheNotFound.
  ///
  /// In en, this message translates to:
  /// **'Cache Not Found'**
  String get cacheNotFound;

  /// No description provided for @cacheSize.
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get cacheSize;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(String error);

  /// No description provided for @clean.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get clean;

  /// No description provided for @lastModified.
  ///
  /// In en, this message translates to:
  /// **'Last Modified'**
  String get lastModified;

  /// No description provided for @oneYearAgo.
  ///
  /// In en, this message translates to:
  /// **'1 Year ago'**
  String get oneYearAgo;

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{number} Months ago'**
  String monthsAgo(String number);

  /// No description provided for @weeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{number} Weeks ago'**
  String weeksAgo(String number);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{number} Days ago'**
  String daysAgo(String number);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hour} Hours ago'**
  String hoursAgo(int hour);

  /// No description provided for @aboutAlQuran.
  ///
  /// In en, this message translates to:
  /// **'About Al Quran'**
  String get aboutAlQuran;

  /// No description provided for @appFullName.
  ///
  /// In en, this message translates to:
  /// **'Al Quran (Tafsir, Prayer, Qibla, Audio)'**
  String get appFullName;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive Islamic application for Android, iOS, MacOS, Web, Linux and Windows, offering Quran reading with Tafsir & multiple translations (including word-by-word), worldwide prayer times with notifications, Qibla compass, and synchronized word-by-word audio recitation.'**
  String get appDescription;

  /// No description provided for @dataSourcesNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Quran texts, Tafsir, translations, and audio resources are sourced from Quran.com, Everyayah.com, and other verified open sources.'**
  String get dataSourcesNote;

  /// No description provided for @adFreePromise.
  ///
  /// In en, this message translates to:
  /// **'This app has been built to seek the pleasure of Allah. Therefore, it is and always will be completely Ad-Free.'**
  String get adFreePromise;

  /// No description provided for @coreFeatures.
  ///
  /// In en, this message translates to:
  /// **'Core Features'**
  String get coreFeatures;

  /// No description provided for @coreFeaturesDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore the key functionalities that make Al Quran v3 an indispensable tool for your daily Islamic practices:'**
  String get coreFeaturesDescription;

  /// No description provided for @prayerTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times & Alerts'**
  String get prayerTimesTitle;

  /// No description provided for @prayerTimesDescription.
  ///
  /// In en, this message translates to:
  /// **'Accurate prayer timings for any location worldwide using various calculation methods. Set reminders with Adhan notifications.'**
  String get prayerTimesDescription;

  /// No description provided for @qiblaDirectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla Direction'**
  String get qiblaDirectionTitle;

  /// No description provided for @qiblaDirectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Easily find the Qibla direction with a clear and accurate compass view.'**
  String get qiblaDirectionDescription;

  /// No description provided for @translationTafsirTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation & Tafsir'**
  String get translationTafsirTitle;

  /// No description provided for @translationTafsirDescription.
  ///
  /// In en, this message translates to:
  /// **'Access 120+ translation books (including word-by-word) in 69 languages, and 30+ Tafsir books.'**
  String get translationTafsirDescription;

  /// No description provided for @wordByWordAudioTitle.
  ///
  /// In en, this message translates to:
  /// **'Word by Word Audio & Highlighting'**
  String get wordByWordAudioTitle;

  /// No description provided for @wordByWordAudioDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow along with synchronized word-by-word audio recitation and highlighting for an immersive learning experience.'**
  String get wordByWordAudioDescription;

  /// No description provided for @ayahAudioRecitationTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayah Audio Recitation'**
  String get ayahAudioRecitationTitle;

  /// No description provided for @ayahAudioRecitationDescription.
  ///
  /// In en, this message translates to:
  /// **'Listen to full Ayah recitations from over 40+ renowned reciters.'**
  String get ayahAudioRecitationDescription;

  /// No description provided for @notesCloudBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Notes with Cloud Backup'**
  String get notesCloudBackupTitle;

  /// No description provided for @notesCloudBackupDescription.
  ///
  /// In en, this message translates to:
  /// **'Save personal notes and reflections, securely backed up to the cloud (feature in development/coming soon).'**
  String get notesCloudBackupDescription;

  /// No description provided for @crossPlatformSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Cross-Platform Support'**
  String get crossPlatformSupportTitle;

  /// No description provided for @crossPlatformSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Supported on Android, Web, Linux, and Windows.'**
  String get crossPlatformSupportDescription;

  /// No description provided for @backgroundAudioPlaybackTitle.
  ///
  /// In en, this message translates to:
  /// **'Background Audio Playback'**
  String get backgroundAudioPlaybackTitle;

  /// No description provided for @backgroundAudioPlaybackDescription.
  ///
  /// In en, this message translates to:
  /// **'Continue listening to Quran recitation even when the app is in the background.'**
  String get backgroundAudioPlaybackDescription;

  /// No description provided for @audioDataCachingTitle.
  ///
  /// In en, this message translates to:
  /// **'Audio & Data Caching'**
  String get audioDataCachingTitle;

  /// No description provided for @audioDataCachingDescription.
  ///
  /// In en, this message translates to:
  /// **'Improved playback and offline capabilities with robust audio and Quran data caching.'**
  String get audioDataCachingDescription;

  /// No description provided for @minimalisticInterfaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Minimalistic & Clean Interface'**
  String get minimalisticInterfaceTitle;

  /// No description provided for @minimalisticInterfaceDescription.
  ///
  /// In en, this message translates to:
  /// **'Easy to navigate interface with focus on user experience and readability.'**
  String get minimalisticInterfaceDescription;

  /// No description provided for @optimizedPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimized Performance & Size'**
  String get optimizedPerformanceTitle;

  /// No description provided for @optimizedPerformanceDescription.
  ///
  /// In en, this message translates to:
  /// **'A feature-rich application designed to be lightweight and performant.'**
  String get optimizedPerformanceDescription;

  /// No description provided for @languageSupport.
  ///
  /// In en, this message translates to:
  /// **'Language Support'**
  String get languageSupport;

  /// No description provided for @languageSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'This application is designed to be accessible to a global audience with support for the following languages (and more are continuously being added):'**
  String get languageSupportDescription;

  /// No description provided for @technologyAndResources.
  ///
  /// In en, this message translates to:
  /// **'Technology & Resources'**
  String get technologyAndResources;

  /// No description provided for @technologyAndResourcesDescription.
  ///
  /// In en, this message translates to:
  /// **'This app is built using cutting-edge technologies and reliable resources:'**
  String get technologyAndResourcesDescription;

  /// No description provided for @flutterFrameworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter Framework'**
  String get flutterFrameworkTitle;

  /// No description provided for @flutterFrameworkDescription.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter for a beautiful, natively compiled, multi-platform experience from a single codebase.'**
  String get flutterFrameworkDescription;

  /// No description provided for @advancedAudioEngineTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Audio Engine'**
  String get advancedAudioEngineTitle;

  /// No description provided for @advancedAudioEngineDescription.
  ///
  /// In en, this message translates to:
  /// **'Powered by the `just_audio` and `just_audio_background` Flutter packages for robust audio playback and control.'**
  String get advancedAudioEngineDescription;

  /// No description provided for @reliableQuranDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Reliable Quran Data'**
  String get reliableQuranDataTitle;

  /// No description provided for @reliableQuranDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Al Quran texts, translations, tafsirs, and audio are sourced from verified open APIs and databases like Quran.com & Everyayah.com.'**
  String get reliableQuranDataDescription;

  /// No description provided for @prayerTimeEngineTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Time Engine'**
  String get prayerTimeEngineTitle;

  /// No description provided for @prayerTimeEngineDescription.
  ///
  /// In en, this message translates to:
  /// **'Utilizes established calculation methods for accurate prayer times. Notifications handled by `flutter_local_notifications` and background tasks.'**
  String get prayerTimeEngineDescription;

  /// No description provided for @crossPlatformSupport.
  ///
  /// In en, this message translates to:
  /// **'Cross Platform Support'**
  String get crossPlatformSupport;

  /// No description provided for @crossPlatformSupportDescription2.
  ///
  /// In en, this message translates to:
  /// **'Enjoy seamless access across various platforms:'**
  String get crossPlatformSupportDescription2;

  /// No description provided for @android.
  ///
  /// In en, this message translates to:
  /// **'Android'**
  String get android;

  /// No description provided for @ios.
  ///
  /// In en, this message translates to:
  /// **'iOS'**
  String get ios;

  /// No description provided for @macos.
  ///
  /// In en, this message translates to:
  /// **'macOS'**
  String get macos;

  /// No description provided for @web.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get web;

  /// No description provided for @linux.
  ///
  /// In en, this message translates to:
  /// **'Linux'**
  String get linux;

  /// No description provided for @windows.
  ///
  /// In en, this message translates to:
  /// **'Windows'**
  String get windows;

  /// No description provided for @ourLifetimePromise.
  ///
  /// In en, this message translates to:
  /// **'Our Lifetime Promise'**
  String get ourLifetimePromise;

  /// No description provided for @lifetimePromiseDescription.
  ///
  /// In en, this message translates to:
  /// **'I personally promise to provide continuous support and maintenance for this application throughout my life, In Sha Allah. My goal is to ensure this app remains a beneficial resource for the Ummah for years to come.'**
  String get lifetimePromiseDescription;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @noon.
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get noon;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @midnight.
  ///
  /// In en, this message translates to:
  /// **'Midnight'**
  String get midnight;

  /// No description provided for @alarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get alarm;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @formattedAddress.
  ///
  /// In en, this message translates to:
  /// **'{subAdministrativeArea}, {administrativeArea}, {country}'**
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  );

  /// No description provided for @quranScriptTajweed.
  ///
  /// In en, this message translates to:
  /// **'Tajweed'**
  String get quranScriptTajweed;

  /// No description provided for @quranScriptUthmani.
  ///
  /// In en, this message translates to:
  /// **'Uthmani'**
  String get quranScriptUthmani;

  /// No description provided for @quranScriptIndopak.
  ///
  /// In en, this message translates to:
  /// **'Indopak'**
  String get quranScriptIndopak;

  /// No description provided for @sajdaAyah.
  ///
  /// In en, this message translates to:
  /// **'Sajda Ayah'**
  String get sajdaAyah;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @notificationScheduleWarning.
  ///
  /// In en, this message translates to:
  /// **'Note: Scheduled Notification or Reminder can be missed due to your phone\'s OS background process restrictions. For example: Vivo\'s Origin OS, Samsung\'s One UI, Oppo\'s ColorOS etc. are sometimes kills scheduled Notification or Reminder . Please check your OS settings for make app not restricted from background process.'**
  String get notificationScheduleWarning;

  /// No description provided for @scrollWithRecitation.
  ///
  /// In en, this message translates to:
  /// **'Scroll with Recitation'**
  String get scrollWithRecitation;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @initiallyScrollAyah.
  ///
  /// In en, this message translates to:
  /// **'Initially scroll to ayah'**
  String get initiallyScrollAyah;

  /// No description provided for @tajweedGuide.
  ///
  /// In en, this message translates to:
  /// **'Tajweed Guide'**
  String get tajweedGuide;

  /// No description provided for @scrollWithRecitationDesc.
  ///
  /// In en, this message translates to:
  /// **'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.'**
  String get scrollWithRecitationDesc;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @restoreFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore From Backup'**
  String get restoreFromBackup;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @useAudioStream.
  ///
  /// In en, this message translates to:
  /// **'Use Audio Stream'**
  String get useAudioStream;

  /// No description provided for @useAudioStreamDesc.
  ///
  /// In en, this message translates to:
  /// **'Stream audio directly from the internet instead of downloading.'**
  String get useAudioStreamDesc;

  /// No description provided for @notUseAudioStreamDesc.
  ///
  /// In en, this message translates to:
  /// **'Download audio for offline use and reduce data consumption.'**
  String get notUseAudioStreamDesc;

  /// No description provided for @audioSettings.
  ///
  /// In en, this message translates to:
  /// **'Audio Settings'**
  String get audioSettings;

  /// No description provided for @playbackSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback Speed'**
  String get playbackSpeed;

  /// No description provided for @playbackSpeedDesc.
  ///
  /// In en, this message translates to:
  /// **'Adjust the speed of the Quran Recitation.'**
  String get playbackSpeedDesc;

  /// No description provided for @waitForCurrentDownloadToFinish.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the current download to finish.'**
  String get waitForCurrentDownloadToFinish;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @checkYourInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection.'**
  String get checkYourInternetConnection;

  /// No description provided for @audioDownloadAlert.
  ///
  /// In en, this message translates to:
  /// **'Need to download {requiredDownload} of {totalVersesCount} ayahs.'**
  String audioDownloadAlert(int requiredDownload, int totalVersesCount);

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @audioDownload.
  ///
  /// In en, this message translates to:
  /// **'Audio Download'**
  String get audioDownload;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @optimizingQuranScript.
  ///
  /// In en, this message translates to:
  /// **'Optimizing Quran Script'**
  String get optimizingQuranScript;

  /// No description provided for @supportOnGithub.
  ///
  /// In en, this message translates to:
  /// **'Support on GitHub'**
  String get supportOnGithub;
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
    'az',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'kk',
    'ko',
    'ms',
    'pa',
    'ps',
    'pt',
    'ru',
    'sw',
    'ta',
    'tr',
    'ur',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'az':
      return AppLocalizationsAz();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'kk':
      return AppLocalizationsKk();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'pa':
      return AppLocalizationsPa();
    case 'ps':
      return AppLocalizationsPs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'ta':
      return AppLocalizationsTa();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
