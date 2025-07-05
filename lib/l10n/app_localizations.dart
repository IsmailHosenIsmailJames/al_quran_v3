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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

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

  /// No description provided for @surahAyah.
  ///
  /// In en, this message translates to:
  /// **'{surahName} {ayahKey}'**
  String surahAyah(String surahName, String ayahKey);

  /// No description provided for @ayahsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Ayahs'**
  String ayahsCount(int count);

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

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

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
