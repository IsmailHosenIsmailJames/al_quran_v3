// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple ( $nameArabic ) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'Tafsir is not available for $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsir will found at : $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Jump to $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Page';

  @override
  String get ruku => 'Ruku';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(int count) {
    return '$count Ayahs';
  }

  @override
  String get saveAndDownload => 'Save and Download';

  @override
  String get appLanguage => 'App Language';

  @override
  String get selectAppLanguage => 'Select app language...';

  @override
  String get pleaseSelectOne => 'Please select one';

  @override
  String get quranTranslationLanguage => 'Quran Translation Language';

  @override
  String get selectTranslationLanguage => 'Select translation language...';

  @override
  String get quranTranslationBook => 'Quran Translation Book';

  @override
  String get selectTranslationBook => 'Select translation book...';

  @override
  String get quranTafsirLanguage => 'Quran Tafsir Language';

  @override
  String get selectTafsirLanguage => 'Select tafsir language...';

  @override
  String get quranTafsirBook => 'Quran Tafsir Book';

  @override
  String get selectTafsirBook => 'Select tafsir book...';

  @override
  String get quranScriptAndStyle => 'Quran Script & Style';

  @override
  String get justAMoment => 'Just a moment...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Success';

  @override
  String get retry => 'Retry';

  @override
  String get unableToDownloadResources =>
      'Unable to download resources...\nSomething went wrong';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Downloading Segmented Quran Recitation';

  @override
  String get processingSegmentedQuranRecitation =>
      'Processing Segmented Quran Recitation';

  @override
  String get footnote => 'Footnote';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Word by Word';

  @override
  String get pleaseSelectRequiredOption => 'Please select required option';

  @override
  String get rememberHomeTab => 'Remember Home Tab';

  @override
  String get rememberHomeTabSubtitle =>
      'App will remember the last opened tab in the home screen.';

  @override
  String get wakeLock => 'Wake Lock';

  @override
  String get wakeLockSubtitle =>
      'Prevent the screen from turning off automatically.';

  @override
  String get settings => 'Settings';

  @override
  String get appTheme => 'App Theme';

  @override
  String get quranStyle => 'Quran Style';

  @override
  String get audioCached => 'Audio Cached';

  @override
  String get others => 'Others';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Quran|Translation|Ayah, One Must Enabled';

  @override
  String get quranFontSize => 'Quran Font Size';

  @override
  String get quranLineHeight => 'Quran Line Height';

  @override
  String get translationAndTafsirFontSize => 'Translation & Tafsir Font Size';

  @override
  String get quranAyah => 'Quran Ayah';

  @override
  String get translation => 'Translation';

  @override
  String get topToolbar => 'Top Toolbar';

  @override
  String get keepOpenWordByWord => 'Keep Open Word By Word';

  @override
  String get wordByWordHighlight => 'Word By Word Highlight';

  @override
  String get quranScriptSettings => 'Quran Script Settings';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Page: ';

  @override
  String get quranResources => 'Quran Resources';

  @override
  String alreadySelected(String name) {
    return 'Language \'$name\' is already selected.';
  }

  @override
  String get unableToGetCompassData => 'Unable to get compass data';

  @override
  String get deviceDoesNotHaveSensors => 'Device does not have sensors !';

  @override
  String get north => 'N';

  @override
  String get east => 'E';

  @override
  String get south => 'S';

  @override
  String get west => 'W';
}
