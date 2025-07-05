import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Al Quran App'**
  String get appTitle;

  /// No description provided for @aboutAlQuranTitle.
  ///
  /// In en, this message translates to:
  /// **'About Al Quran'**
  String get aboutAlQuranTitle;

  /// No description provided for @aboutAppFullName.
  ///
  /// In en, this message translates to:
  /// **'Al Quran (Tafsir, Prayer, Qibla, Audio)'**
  String get aboutAppFullName;

  /// No description provided for @aboutAppDescription.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive Islamic application for Android, iOS, MacOS, Web, Linux and Windows, offering Quran reading with Tafsir & multiple translations (including word-by-word), worldwide prayer times with notifications, Qibla compass, and synchronized word-by-word audio recitation.'**
  String get aboutAppDescription;

  /// No description provided for @aboutSourceNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Quran texts, Tafsir, translations, and audio resources are sourced from Quran.com, Everyayah.com, and other verified open sources.'**
  String get aboutSourceNote;

  /// No description provided for @aboutAdFreePromise.
  ///
  /// In en, this message translates to:
  /// **'This app has been built to seek the pleasure of Allah. Therefore, it is and always will be completely Ad-Free.'**
  String get aboutAdFreePromise;

  /// No description provided for @coreFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Core Features'**
  String get coreFeaturesTitle;

  /// No description provided for @coreFeaturesDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore the key functionalities that make Al Quran v3 an indispensable tool for your daily Islamic practices:'**
  String get coreFeaturesDescription;

  /// No description provided for @prayerTimesAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times & Alerts'**
  String get prayerTimesAlertsTitle;

  /// No description provided for @prayerTimesAlertsDescription.
  ///
  /// In en, this message translates to:
  /// **'Accurate prayer timings for any location worldwide using various calculation methods. Set reminders with Adhan notifications.'**
  String get prayerTimesAlertsDescription;

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

  /// No description provided for @quranTranslationTafsirTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation & Tafsir'**
  String get quranTranslationTafsirTitle;

  /// No description provided for @quranTranslationTafsirDescription.
  ///
  /// In en, this message translates to:
  /// **'Access 120+ translation books (including word-by-word) in 69 languages, and 30+ Tafsir books.'**
  String get quranTranslationTafsirDescription;

  /// No description provided for @wordByWordAudioHighlightingTitle.
  ///
  /// In en, this message translates to:
  /// **'Word by Word Audio & Highlighting'**
  String get wordByWordAudioHighlightingTitle;

  /// No description provided for @wordByWordAudioHighlightingDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow along with synchronized word-by-word audio recitation and highlighting for an immersive learning experience.'**
  String get wordByWordAudioHighlightingDescription;

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

  /// No description provided for @minimalisticCleanInterfaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Minimalistic & Clean Interface'**
  String get minimalisticCleanInterfaceTitle;

  /// No description provided for @minimalisticCleanInterfaceDescription.
  ///
  /// In en, this message translates to:
  /// **'Easy to navigate interface with focus on user experience and readability.'**
  String get minimalisticCleanInterfaceDescription;

  /// No description provided for @optimizedPerformanceSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimized Performance & Size'**
  String get optimizedPerformanceSizeTitle;

  /// No description provided for @optimizedPerformanceSizeDescription.
  ///
  /// In en, this message translates to:
  /// **'A feature-rich application designed to be lightweight and performant.'**
  String get optimizedPerformanceSizeDescription;

  /// No description provided for @languageSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Support'**
  String get languageSupportTitle;

  /// No description provided for @languageSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'This application is designed to be accessible to a global audience with support for the following languages (and more are continuously being added):'**
  String get languageSupportDescription;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @languageUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get languageUrdu;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get languageIndonesian;

  /// No description provided for @languageMalay.
  ///
  /// In en, this message translates to:
  /// **'Malay'**
  String get languageMalay;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTurkish;

  /// No description provided for @languageBengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get languageBengali;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @technologyResourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Technology & Resources'**
  String get technologyResourcesTitle;

  /// No description provided for @technologyResourcesDescription.
  ///
  /// In en, this message translates to:
  /// **'This app is built using cutting-edge technologies and reliable resources:'**
  String get technologyResourcesDescription;

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

  /// No description provided for @crossPlatformSupportPlatformsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cross Platform Support'**
  String get crossPlatformSupportPlatformsTitle;

  /// No description provided for @crossPlatformSupportPlatformsDescription.
  ///
  /// In en, this message translates to:
  /// **'Enjoy seamless access across various platforms:'**
  String get crossPlatformSupportPlatformsDescription;

  /// No description provided for @platformAndroid.
  ///
  /// In en, this message translates to:
  /// **'Platform: Android'**
  String get platformAndroid;

  /// No description provided for @platformIOS.
  ///
  /// In en, this message translates to:
  /// **'Platform: iOS'**
  String get platformIOS;

  /// No description provided for @platformMacOS.
  ///
  /// In en, this message translates to:
  /// **'Platform: macOS'**
  String get platformMacOS;

  /// No description provided for @platformWeb.
  ///
  /// In en, this message translates to:
  /// **'Platform: Web'**
  String get platformWeb;

  /// No description provided for @platformLinux.
  ///
  /// In en, this message translates to:
  /// **'Platform: Linux'**
  String get platformLinux;

  /// No description provided for @platformWindows.
  ///
  /// In en, this message translates to:
  /// **'Platform: Windows'**
  String get platformWindows;

  /// No description provided for @ourLifetimePromiseTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Lifetime Promise'**
  String get ourLifetimePromiseTitle;

  /// No description provided for @ourLifetimePromiseDescription.
  ///
  /// In en, this message translates to:
  /// **'I personally promise to provide continuous support and maintenance for this application throughout my life, In Sha Allah. My goal is to ensure this app remains a beneficial resource for the Ummah for years to come.'**
  String get ourLifetimePromiseDescription;

  /// No description provided for @translationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Translation Not Found'**
  String get translationNotFound;

  /// No description provided for @playTooltip.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get playTooltip;

  /// No description provided for @pauseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseTooltip;

  /// No description provided for @selectReciterTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get selectReciterTitle;

  /// No description provided for @reciterStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Style: {styleName}'**
  String reciterStyleLabel(Object styleName);

  /// No description provided for @reciterSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source: {sourceName}'**
  String reciterSourceLabel(Object sourceName);

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

  /// No description provided for @cacheNotFound.
  ///
  /// In en, this message translates to:
  /// **'Cache Not Found'**
  String get cacheNotFound;

  /// No description provided for @cacheSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get cacheSizeLabel;

  /// No description provided for @errorLabel.
  ///
  /// In en, this message translates to:
  /// **'Error: {errorMessage}'**
  String errorLabel(Object errorMessage);

  /// No description provided for @cleanButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get cleanButtonLabel;

  /// No description provided for @lastModifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Modified'**
  String get lastModifiedLabel;

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

  /// No description provided for @searchByCollectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Search By {collectionTypeName} Name...'**
  String searchByCollectionNameHint(Object collectionTypeName);

  /// No description provided for @sortByTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortByTitle;

  /// No description provided for @noCollectionAddedYet.
  ///
  /// In en, this message translates to:
  /// **'No {collectionTypeName} added yet'**
  String noCollectionAddedYet(Object collectionTypeName);

  /// No description provided for @pinnedItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} pinned items'**
  String pinnedItemsCount(Object count);

  /// No description provided for @notesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} notes'**
  String notesCount(Object count);

  /// No description provided for @emptyNameNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Empty name not allowed'**
  String get emptyNameNotAllowed;

  /// No description provided for @updatedToCollectionName.
  ///
  /// In en, this message translates to:
  /// **'Updated to {collectionName}'**
  String updatedToCollectionName(Object collectionName);

  /// No description provided for @changeNameMenu.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeNameMenu;

  /// No description provided for @colorUpdated.
  ///
  /// In en, this message translates to:
  /// **'Color updated'**
  String get colorUpdated;

  /// No description provided for @changeColorMenu.
  ///
  /// In en, this message translates to:
  /// **'Change Color'**
  String get changeColorMenu;

  /// No description provided for @collectionNameDeleted.
  ///
  /// In en, this message translates to:
  /// **'{collectionName} Deleted'**
  String collectionNameDeleted(Object collectionName);

  /// No description provided for @deleteMenu.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteMenu;

  /// No description provided for @sortingByNameAsc.
  ///
  /// In en, this message translates to:
  /// **'By Name (A-Z)'**
  String get sortingByNameAsc;

  /// No description provided for @sortingByNameDesc.
  ///
  /// In en, this message translates to:
  /// **'By Name (Z-A)'**
  String get sortingByNameDesc;

  /// No description provided for @sortingByDateNewest.
  ///
  /// In en, this message translates to:
  /// **'By Date (Newest First)'**
  String get sortingByDateNewest;

  /// No description provided for @sortingByDateOldest.
  ///
  /// In en, this message translates to:
  /// **'By Date (Oldest First)'**
  String get sortingByDateOldest;

  /// No description provided for @sortingByColor.
  ///
  /// In en, this message translates to:
  /// **'By Color'**
  String get sortingByColor;

  /// No description provided for @sortingByItemCountAsc.
  ///
  /// In en, this message translates to:
  /// **'By Item Count (Ascending)'**
  String get sortingByItemCountAsc;

  /// No description provided for @sortingByItemCountDesc.
  ///
  /// In en, this message translates to:
  /// **'By Item Count (Descending)'**
  String get sortingByItemCountDesc;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get noteLabel;

  /// No description provided for @linkedAyahsLabel.
  ///
  /// In en, this message translates to:
  /// **'Linked Ayahs:'**
  String get linkedAyahsLabel;

  /// No description provided for @emptyNoteCollectionMessage.
  ///
  /// In en, this message translates to:
  /// **'This note collection is empty.\nAdd some notes to see them here.'**
  String get emptyNoteCollectionMessage;

  /// No description provided for @emptyPinnedCollectionMessage.
  ///
  /// In en, this message translates to:
  /// **'No Ayahs pinned to this collection yet.\nPin Ayahs to see them here.'**
  String get emptyPinnedCollectionMessage;

  /// No description provided for @noContentAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'No content available.'**
  String get noContentAvailableMessage;

  /// No description provided for @openDrawerTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open Drawer'**
  String get openDrawerTooltip;

  /// No description provided for @homeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Al Quran'**
  String get homeAppBarTitle;

  /// No description provided for @bottomNavQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get bottomNavQuran;

  /// No description provided for @bottomNavPrayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get bottomNavPrayer;

  /// No description provided for @bottomNavQibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get bottomNavQibla;

  /// No description provided for @bottomNavAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get bottomNavAudio;

  /// No description provided for @versionLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get versionLoading;

  /// No description provided for @drawerAlQuranTitle.
  ///
  /// In en, this message translates to:
  /// **'Al Quran'**
  String get drawerAlQuranTitle;

  /// No description provided for @drawerMainMenu.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get drawerMainMenu;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @drawerNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get drawerNotes;

  /// No description provided for @drawerPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get drawerPinned;

  /// No description provided for @drawerJumpToAyah.
  ///
  /// In en, this message translates to:
  /// **'Jump to Ayah'**
  String get drawerJumpToAyah;

  /// No description provided for @drawerQuranResources.
  ///
  /// In en, this message translates to:
  /// **'Quran Resources'**
  String get drawerQuranResources;

  /// No description provided for @drawerShareMultipleAyah.
  ///
  /// In en, this message translates to:
  /// **'Share Multiple Ayah'**
  String get drawerShareMultipleAyah;

  /// No description provided for @drawerDonateUs.
  ///
  /// In en, this message translates to:
  /// **'Donate Us'**
  String get drawerDonateUs;

  /// No description provided for @drawerOthersMenu.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get drawerOthersMenu;

  /// No description provided for @drawerShareThisApp.
  ///
  /// In en, this message translates to:
  /// **'Share this App'**
  String get drawerShareThisApp;

  /// No description provided for @drawerShareMessage.
  ///
  /// In en, this message translates to:
  /// **'Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah\'s words. Download here: {appLink}'**
  String drawerShareMessage(Object appLink);

  /// No description provided for @drawerShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Check out this Al Quran App!'**
  String get drawerShareSubject;

  /// No description provided for @drawerGiveRating.
  ///
  /// In en, this message translates to:
  /// **'Give Rating'**
  String get drawerGiveRating;

  /// No description provided for @drawerBugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get drawerBugReport;

  /// No description provided for @drawerPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get drawerPrivacyPolicy;

  /// No description provided for @drawerAboutTheApp.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get drawerAboutTheApp;

  /// No description provided for @drawerResetAppDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset App Data'**
  String get drawerResetAppDataTitle;

  /// No description provided for @drawerResetAppDataContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the app? All your data will be lost, and you will need to set up the app from the beginning.'**
  String get drawerResetAppDataContent;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @resetButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButtonLabel;

  /// No description provided for @drawerResetTheApp.
  ///
  /// In en, this message translates to:
  /// **'Reset the App'**
  String get drawerResetTheApp;

  /// No description provided for @getPrayerTimesQiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Get Prayer Times and Qibla'**
  String get getPrayerTimesQiblaTitle;

  /// No description provided for @calculatePrayerTimesQiblaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate Prayer Times and Qibla for Any Given Location.'**
  String get calculatePrayerTimesQiblaSubtitle;

  /// No description provided for @enableLocationServiceToast.
  ///
  /// In en, this message translates to:
  /// **'Please enable location service'**
  String get enableLocationServiceToast;

  /// No description provided for @getFromGPSButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Get from GPS'**
  String get getFromGPSButtonLabel;

  /// No description provided for @orLabel.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orLabel;

  /// No description provided for @selectYourCityButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Select your City'**
  String get selectYourCityButtonLabel;

  /// No description provided for @locationNote.
  ///
  /// In en, this message translates to:
  /// **'Note: If you don\'t want to use GPS or not feel secure, you can select your city.'**
  String get locationNote;

  /// No description provided for @downloadingLocationResources.
  ///
  /// In en, this message translates to:
  /// **'Downloading location resources...'**
  String get downloadingLocationResources;

  /// No description provided for @selectYourCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Country'**
  String get selectYourCountryTitle;

  /// No description provided for @searchForCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a country'**
  String get searchForCountryHint;

  /// No description provided for @somethingWentWrongError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrongError;

  /// No description provided for @selectYourAdministratorTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Administrator'**
  String get selectYourAdministratorTitle;

  /// No description provided for @searchForAdministratorHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a administrator'**
  String get searchForAdministratorHint;

  /// No description provided for @selectYourCityTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your City'**
  String get selectYourCityTitle;

  /// No description provided for @searchForCityHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a city'**
  String get searchForCityHint;

  /// No description provided for @prayerSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Settings'**
  String get prayerSettingsTitle;

  /// No description provided for @calculationMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Calculation Method: '**
  String get calculationMethodLabel;

  /// No description provided for @changeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeButtonLabel;

  /// No description provided for @reminderSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder Settings'**
  String get reminderSettingsTitle;

  /// No description provided for @adjustReminderTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust Reminder Time'**
  String get adjustReminderTimeTitle;

  /// No description provided for @enforceAlarmSoundLabel.
  ///
  /// In en, this message translates to:
  /// **'Enforce Alarm\'s Sound'**
  String get enforceAlarmSoundLabel;

  /// No description provided for @enforceAlarmSoundDescription.
  ///
  /// In en, this message translates to:
  /// **'If enabled, This feature will play the alarm at the volume set here, even if your phone\'s sound is low. This ensures you don\'t miss the alarm due to low phone volume.'**
  String get enforceAlarmSoundDescription;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volumeLabel;

  /// No description provided for @reminderTypeNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get reminderTypeNotification;

  /// No description provided for @reminderTypeAlarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get reminderTypeAlarm;

  /// No description provided for @atPrayerTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'At prayer time'**
  String get atPrayerTimeLabel;

  /// No description provided for @minutesBeforePrayerLabel.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min before'**
  String minutesBeforePrayerLabel(Object minutes);

  /// No description provided for @minutesAfterPrayerLabel.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min after'**
  String minutesAfterPrayerLabel(Object minutes);

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address: '**
  String get addressLabel;

  /// No description provided for @downloadPrayerTimeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Download Prayer Time'**
  String get downloadPrayerTimeButtonLabel;

  /// No description provided for @prayerDataNotFoundForDate.
  ///
  /// In en, this message translates to:
  /// **'Prayer data not found for {date}'**
  String prayerDataNotFoundForDate(Object date);

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @reminderAddedToast.
  ///
  /// In en, this message translates to:
  /// **'Reminder for {prayerName} added'**
  String reminderAddedToast(Object prayerName);

  /// No description provided for @allowNotificationPermissionToast.
  ///
  /// In en, this message translates to:
  /// **'Please allow notification permission to use this feature'**
  String get allowNotificationPermissionToast;

  /// No description provided for @reminderRemovedToast.
  ///
  /// In en, this message translates to:
  /// **'Reminder for {prayerName} removed'**
  String reminderRemovedToast(Object prayerName);

  /// No description provided for @timeLeftLabel.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get timeLeftLabel;

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

  /// No description provided for @compassNorth.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get compassNorth;

  /// No description provided for @compassEast.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get compassEast;

  /// No description provided for @compassSouth.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get compassSouth;

  /// No description provided for @compassWest.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get compassWest;

  /// No description provided for @quranResourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Resources'**
  String get quranResourcesTitle;

  /// No description provided for @translationTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translationTabLabel;

  /// No description provided for @tafsirTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirTabLabel;

  /// No description provided for @wordByWordTabLabel.
  ///
  /// In en, this message translates to:
  /// **'Word By Word'**
  String get wordByWordTabLabel;

  /// No description provided for @pageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page: '**
  String get pageLabel;

  /// No description provided for @quranScriptSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Script Settings'**
  String get quranScriptSettingsTitle;

  /// No description provided for @quranStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Style'**
  String get quranStyleLabel;

  /// No description provided for @quranFontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Font Size'**
  String get quranFontSizeLabel;

  /// No description provided for @quranLineHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Line Height'**
  String get quranLineHeightLabel;

  /// No description provided for @translationTafsirFontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation & Tafsir Font Size'**
  String get translationTafsirFontSizeLabel;

  /// No description provided for @quranAyahLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Ayah'**
  String get quranAyahLabel;

  /// No description provided for @translationLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translationLabel;

  /// No description provided for @wordByWordLabel.
  ///
  /// In en, this message translates to:
  /// **'Word By Word'**
  String get wordByWordLabel;

  /// No description provided for @footNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Foot Note'**
  String get footNoteLabel;

  /// No description provided for @topToolbarLabel.
  ///
  /// In en, this message translates to:
  /// **'Top Toolbar'**
  String get topToolbarLabel;

  /// No description provided for @keepOpenWordByWordLabel.
  ///
  /// In en, this message translates to:
  /// **'Keep Open Word By Word'**
  String get keepOpenWordByWordLabel;

  /// No description provided for @wordByWordHighlightLabel.
  ///
  /// In en, this message translates to:
  /// **'Word By Word Highlight'**
  String get wordByWordHighlightLabel;

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

  /// No description provided for @quranScriptQpch.
  ///
  /// In en, this message translates to:
  /// **'QPC Hafs'**
  String get quranScriptQpch;

  /// No description provided for @saveAndDownloadTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save and Download'**
  String get saveAndDownloadTooltip;

  /// No description provided for @appLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguageLabel;

  /// No description provided for @selectAppLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select app language...'**
  String get selectAppLanguageHint;

  /// No description provided for @pleaseSelectOneValidator.
  ///
  /// In en, this message translates to:
  /// **'Please select one'**
  String get pleaseSelectOneValidator;

  /// No description provided for @quranTranslationLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation Language'**
  String get quranTranslationLanguageLabel;

  /// No description provided for @selectTranslationLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select translation language...'**
  String get selectTranslationLanguageHint;

  /// No description provided for @quranTranslationBookLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Translation Book'**
  String get quranTranslationBookLabel;

  /// No description provided for @selectTranslationBookHint.
  ///
  /// In en, this message translates to:
  /// **'Select translation book...'**
  String get selectTranslationBookHint;

  /// No description provided for @quranTafsirLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Tafsir Language'**
  String get quranTafsirLanguageLabel;

  /// No description provided for @selectTafsirLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Select tafsir language...'**
  String get selectTafsirLanguageHint;

  /// No description provided for @quranTafsirBookLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Tafsir Book'**
  String get quranTafsirBookLabel;

  /// No description provided for @selectTafsirBookHint.
  ///
  /// In en, this message translates to:
  /// **'Select tafsir book...'**
  String get selectTafsirBookHint;

  /// No description provided for @quranScriptStyleLabel.
  ///
  /// In en, this message translates to:
  /// **'Quran Script & Style'**
  String get quranScriptStyleLabel;

  /// No description provided for @justAMomentDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Just a moment...'**
  String get justAMomentDialogTitle;

  /// No description provided for @downloadingSegmentedQuranRecitationProgress.
  ///
  /// In en, this message translates to:
  /// **'Downloading Segmented Quran Recitation'**
  String get downloadingSegmentedQuranRecitationProgress;

  /// No description provided for @processingSegmentedQuranRecitationProgress.
  ///
  /// In en, this message translates to:
  /// **'Processing Segmented Quran Recitation'**
  String get processingSegmentedQuranRecitationProgress;

  /// No description provided for @successDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successDialogMessage;

  /// No description provided for @retryButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButtonLabel;

  /// No description provided for @unableToDownloadResourcesError.
  ///
  /// In en, this message translates to:
  /// **'Unable to download resources...\nSomething went wrong'**
  String get unableToDownloadResourcesError;

  /// No description provided for @footnoteTag.
  ///
  /// In en, this message translates to:
  /// **'Footnote'**
  String get footnoteTag;

  /// No description provided for @tafsirTag.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get tafsirTag;

  /// No description provided for @wordByWordTag.
  ///
  /// In en, this message translates to:
  /// **'Word by Word'**
  String get wordByWordTag;

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

  /// No description provided for @selectCollectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Collections'**
  String get selectCollectionsTitle;

  /// No description provided for @addNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNoteTitle;

  /// No description provided for @newButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newButtonLabel;

  /// No description provided for @writeCollectionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Write collection name...'**
  String get writeCollectionNameHint;

  /// No description provided for @noCollectionsYet.
  ///
  /// In en, this message translates to:
  /// **'No collections yet. Add a new one!'**
  String get noCollectionsYet;

  /// No description provided for @pleaseWriteYourNoteFirst.
  ///
  /// In en, this message translates to:
  /// **'Please write your note first.'**
  String get pleaseWriteYourNoteFirst;

  /// No description provided for @noCollectionSelectedToast.
  ///
  /// In en, this message translates to:
  /// **'No Collection selected'**
  String get noCollectionSelectedToast;

  /// No description provided for @saveNoteButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Note'**
  String get saveNoteButtonLabel;

  /// No description provided for @nextSelectCollectionsButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Next: Select Collections'**
  String get nextSelectCollectionsButtonLabel;

  /// No description provided for @pinnedSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Pinned saved successfully!'**
  String get pinnedSavedSuccessfully;

  /// No description provided for @addToPinnedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add To Pinned'**
  String get addToPinnedTitle;

  /// No description provided for @savePinnedButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Pinned'**
  String get savePinnedButtonLabel;

  /// No description provided for @demoCollectionReflections.
  ///
  /// In en, this message translates to:
  /// **'Reflections'**
  String get demoCollectionReflections;

  /// No description provided for @demoCollectionFavourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get demoCollectionFavourites;

  /// No description provided for @closeAudioControllerTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close Audio Controller'**
  String get closeAudioControllerTooltip;

  /// No description provided for @stopAndCloseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Stop & Close'**
  String get stopAndCloseTooltip;

  /// No description provided for @previousTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousTooltip;

  /// No description provided for @rewindTooltip.
  ///
  /// In en, this message translates to:
  /// **'Rewind'**
  String get rewindTooltip;

  /// No description provided for @fastForwardTooltip.
  ///
  /// In en, this message translates to:
  /// **'Fast Forward'**
  String get fastForwardTooltip;

  /// No description provided for @playNextAyahTooltip.
  ///
  /// In en, this message translates to:
  /// **'Play Next Ayah'**
  String get playNextAyahTooltip;

  /// No description provided for @repeatTooltip.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatTooltip;

  /// No description provided for @playAsPlaylistTooltip.
  ///
  /// In en, this message translates to:
  /// **'Play As Playlist'**
  String get playAsPlaylistTooltip;

  /// No description provided for @translationLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Translation:'**
  String get translationLabelColon;

  /// No description provided for @footNoteLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Foot Note:'**
  String get footNoteLabelColon;

  /// No description provided for @wordByWordTranslationLabel.
  ///
  /// In en, this message translates to:
  /// **'Word by Word Translation:'**
  String get wordByWordTranslationLabel;

  /// No description provided for @viewTafsirButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Tafsir'**
  String get viewTafsirButtonLabel;

  /// No description provided for @shareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTooltip;

  /// No description provided for @pinToCollectionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pin to Collection'**
  String get pinToCollectionTooltip;

  /// No description provided for @shareDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareDialogTitle;

  /// No description provided for @shareAsTextButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Share as Text'**
  String get shareAsTextButtonLabel;

  /// No description provided for @copiedWithTafsirToast.
  ///
  /// In en, this message translates to:
  /// **'Copied with Tafsir'**
  String get copiedWithTafsirToast;

  /// No description provided for @shareAsImageButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Share as Image'**
  String get shareAsImageButtonLabel;

  /// No description provided for @shareWithTafsirButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Share with Tafsir'**
  String get shareWithTafsirButtonLabel;

  /// No description provided for @tafsirNotFound.
  ///
  /// In en, this message translates to:
  /// **'Tafsir not found'**
  String get tafsirNotFound;

  /// No description provided for @bugReportOnGithub.
  ///
  /// In en, this message translates to:
  /// **'On Github'**
  String get bugReportOnGithub;

  /// No description provided for @bugReportRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get bugReportRecommended;

  /// No description provided for @bugReportThroughEmail.
  ///
  /// In en, this message translates to:
  /// **'Through Email'**
  String get bugReportThroughEmail;

  /// No description provided for @bugReportEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Bug Report - Al Quran v3'**
  String get bugReportEmailSubject;

  /// No description provided for @bugReportDeviceInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'Device Information:'**
  String get bugReportDeviceInfoLabel;

  /// No description provided for @bugReportAppInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'App Information:'**
  String get bugReportAppInfoLabel;

  /// No description provided for @bugReportDescribeBugLabel.
  ///
  /// In en, this message translates to:
  /// **'Describe the bug:'**
  String get bugReportDescribeBugLabel;

  /// No description provided for @bugReportToReproduceLabel.
  ///
  /// In en, this message translates to:
  /// **'To Reproduce:'**
  String get bugReportToReproduceLabel;

  /// No description provided for @bugReportExpectedBehaviorLabel.
  ///
  /// In en, this message translates to:
  /// **'Expected behavior:'**
  String get bugReportExpectedBehaviorLabel;

  /// No description provided for @bugReportScreenshotsOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Screenshots (optional):'**
  String get bugReportScreenshotsOptionalLabel;

  /// No description provided for @bugReportOnDiscord.
  ///
  /// In en, this message translates to:
  /// **'On Discord'**
  String get bugReportOnDiscord;

  /// No description provided for @browserLabel.
  ///
  /// In en, this message translates to:
  /// **'Browser: '**
  String get browserLabel;

  /// No description provided for @userAgentLabel.
  ///
  /// In en, this message translates to:
  /// **'User Agent: '**
  String get userAgentLabel;

  /// No description provided for @deviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device: '**
  String get deviceLabel;

  /// No description provided for @manufacturerLabel.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer: '**
  String get manufacturerLabel;

  /// No description provided for @osVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'OS Version: '**
  String get osVersionLabel;

  /// No description provided for @sdkVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'SDK Version: '**
  String get sdkVersionLabel;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model: '**
  String get modelLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get nameLabel;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version: '**
  String get versionLabel;

  /// No description provided for @computerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Computer Name: '**
  String get computerNameLabel;

  /// No description provided for @errorGettingDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Error getting device info: {error}'**
  String errorGettingDeviceInfo(Object error);

  /// No description provided for @unknownPlatform.
  ///
  /// In en, this message translates to:
  /// **'Unknown platform'**
  String get unknownPlatform;

  /// No description provided for @appNameLabel.
  ///
  /// In en, this message translates to:
  /// **'App Name: '**
  String get appNameLabel;

  /// No description provided for @packageNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Package Name: '**
  String get packageNameLabel;

  /// No description provided for @buildNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Build Number: '**
  String get buildNumberLabel;

  /// No description provided for @shareSelectedAyahsTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Selected Ayahs'**
  String get shareSelectedAyahsTitle;

  /// No description provided for @selectedCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected: {count}'**
  String selectedCountLabel(Object count);

  /// No description provided for @selectionEmptyLabel.
  ///
  /// In en, this message translates to:
  /// **'Selection Empty'**
  String get selectionEmptyLabel;

  /// No description provided for @searchForSurahHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a surah'**
  String get searchForSurahHint;

  /// No description provided for @generatingImagePleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Generating Image... Please Wait'**
  String get generatingImagePleaseWait;

  /// No description provided for @asImageButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'As Image'**
  String get asImageButtonLabel;

  /// No description provided for @asTextButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'As Text'**
  String get asTextButtonLabel;

  /// No description provided for @playFromSelectedAyahButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Play From Selected Ayah'**
  String get playFromSelectedAyahButtonLabel;

  /// No description provided for @toTafsirButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'To Tafsir'**
  String get toTafsirButtonLabel;

  /// No description provided for @selectAyahButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Ayah'**
  String get selectAyahButtonLabel;

  /// No description provided for @toAyahButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'To Ayah'**
  String get toAyahButtonLabel;

  /// No description provided for @addressLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading address...'**
  String get addressLoading;

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

  /// No description provided for @latitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Latitude: '**
  String get latitudeLabel;

  /// No description provided for @longitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longitude: '**
  String get longitudeLabel;

  /// No description provided for @nameLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get nameLabelColon;

  /// No description provided for @locationLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Location: '**
  String get locationLabelColon;

  /// No description provided for @parametersLabelColon.
  ///
  /// In en, this message translates to:
  /// **'Parameters: '**
  String get parametersLabelColon;

  /// No description provided for @fajrAngleParam.
  ///
  /// In en, this message translates to:
  /// **'FajrAngle'**
  String get fajrAngleParam;

  /// No description provided for @ishaAngleParam.
  ///
  /// In en, this message translates to:
  /// **'IshaAngle'**
  String get ishaAngleParam;

  /// No description provided for @ishaIntervalParam.
  ///
  /// In en, this message translates to:
  /// **'IshaInterval'**
  String get ishaIntervalParam;

  /// No description provided for @maghribAngleParam.
  ///
  /// In en, this message translates to:
  /// **'MaghribAngle'**
  String get maghribAngleParam;

  /// No description provided for @selectCalculationMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Calculation Method'**
  String get selectCalculationMethodTitle;

  /// No description provided for @previewLabel.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewLabel;

  /// No description provided for @playAudioLabel.
  ///
  /// In en, this message translates to:
  /// **'Play Audio'**
  String get playAudioLabel;

  /// No description provided for @verseCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Verse Count: '**
  String get verseCountLabel;

  /// No description provided for @moreInfoLabel.
  ///
  /// In en, this message translates to:
  /// **'more info'**
  String get moreInfoLabel;

  /// No description provided for @changeThemeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeThemeTooltip;

  /// No description provided for @quranSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Search'**
  String get quranSearchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// No description provided for @searchInLabel.
  ///
  /// In en, this message translates to:
  /// **'Search In'**
  String get searchInLabel;

  /// No description provided for @searchByLabel.
  ///
  /// In en, this message translates to:
  /// **'Search By'**
  String get searchByLabel;

  /// No description provided for @searchNowButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Now'**
  String get searchNowButtonLabel;

  /// No description provided for @searchResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Result'**
  String get searchResultTitle;

  /// No description provided for @underDevelopmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Under Development'**
  String get underDevelopmentLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
