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
  String get languageSettings => 'Language Settings';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
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
  String get changeTheme => 'Change Theme';

  @override
  String get verseCount => 'Verse Count: ';

  @override
  String get translation => 'Translation';

  @override
  String get tafsirNotFound => 'Not Found';

  @override
  String get moreInfo => 'more info';

  @override
  String get playAudio => 'Play Audio';

  @override
  String get preview => 'Preview';

  @override
  String get loading => 'Loading...';

  @override
  String get errorFetchingAddress => 'Error fetching address';

  @override
  String get addressNotAvailable => 'Address not available';

  @override
  String get latitude => 'Latitude: ';

  @override
  String get longitude => 'Longitude: ';

  @override
  String get name => 'Name: ';

  @override
  String get location => 'Location: ';

  @override
  String get parameters => 'Parameters: ';

  @override
  String get selectCalculationMethod => 'Select Calculation Method';

  @override
  String get shareSelectAyahs => 'Share Select Ayahs';

  @override
  String get selectionEmpty => 'Selection Empty';

  @override
  String get generatingImagePleaseWait => 'Generating Image... Please Wait';

  @override
  String get asImage => 'As Image';

  @override
  String get asText => 'As Text';

  @override
  String get playFromSelectedAyah => 'Play From Selected Ayah';

  @override
  String get toTafsir => 'To Tafsir';

  @override
  String get selectAyah => 'Select Ayah';

  @override
  String get toAyah => 'To Ayah';

  @override
  String get searchForASurah => 'Search for a surah';

  @override
  String get bugReportTitle => 'Bug Report';

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

  @override
  String get address => 'Address: ';

  @override
  String get change => 'Change';

  @override
  String get calculationMethod => 'Calculation Method: ';

  @override
  String get downloadPrayerTime => 'Download Prayer Time';

  @override
  String get calculationMethodsListEmpty =>
      'The list of calculation methods is empty.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Could not find any calculation method with location data.';

  @override
  String get prayerSettings => 'Prayer Settings';

  @override
  String get reminderSettings => 'Reminder Settings';

  @override
  String get adjustReminderTime => 'Adjust Reminder Time';

  @override
  String get enforceAlarmSound => 'Enforce Alarm\'s Sound';

  @override
  String get enforceAlarmSoundDescription =>
      'If enabled, This feature will play the alarm at the volume set here, even if your phone\'s sound is low. This ensures you don\'t miss the alarm due to low phone volume.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'At prayer time';

  @override
  String minBefore(int minutes) {
    return '$minutes min before';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min after';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName is at $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'It\'s time of $prayerName';
  }

  @override
  String get stopTheAdhan => 'Stop the Adhan';

  @override
  String dateFoundEmpty(String date) {
    return '$date Found Empty';
  }

  @override
  String get today => 'Today';

  @override
  String get left => 'Left';

  @override
  String reminderAdded(String prayerName) {
    return 'Reminder for $prayerName added';
  }

  @override
  String get allowNotificationPermission =>
      'Please allow notification permission to use this feature';

  @override
  String reminderRemoved(String prayerName) {
    return 'Reminder for $prayerName removed';
  }

  @override
  String get getPrayerTimesAndQibla => 'Get Prayer Times and Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calculate Prayer Times and Qibla for Any Given Location.';

  @override
  String get getFromGPS => 'Get form GPS';

  @override
  String get or => 'Or';

  @override
  String get selectYourCity => 'Select you City';

  @override
  String get noteAboutGPS =>
      'Note: If you don\'t want to use GPS or not feel secure, you can select your city.';

  @override
  String get downloadingLocationResources =>
      'Downloading location resources...';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get selectYourCountry => 'Select Your Country';

  @override
  String get searchForACountry => 'Search for a country';

  @override
  String get selectYourAdministrator => 'Select Your Administrator';

  @override
  String get searchForAnAdministrator => 'Search for a administrator';

  @override
  String get searchForACity => 'Search for a city';

  @override
  String get pleaseEnableLocationService => 'Please enable location service';

  @override
  String get donateUs => 'Donate Us';

  @override
  String get underDevelopment => 'Under development';

  @override
  String get versionLoading => 'Loading...';

  @override
  String get alQuran => 'Al Quran';

  @override
  String get mainMenu => 'Main Menu';

  @override
  String get notes => 'Notes';

  @override
  String get pinned => 'Pinned';

  @override
  String get jumpToAyah => 'Jump to Ayah';

  @override
  String get shareMultipleAyah => 'Share Multiple Ayah';

  @override
  String get shareThisApp => 'Share this App';

  @override
  String get giveRating => 'Give Rating';

  @override
  String get bugReport => 'Bug Report';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get aboutTheApp => 'About the App';

  @override
  String get resetTheApp => 'Reset the App';

  @override
  String get resetAppWarningTitle => 'Reset App Data';

  @override
  String get resetAppWarningMessage =>
      'Are you sure you want to reset the app? All your data will be lost, and you will need to set up the app from the beginning.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get shareAppSubject => 'Check out this Al Quran App!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah\'s words. Download here: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Open Drawer';

  @override
  String get quran => 'Quran';

  @override
  String get prayer => 'Prayer';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Surah';

  @override
  String get pages => 'Pages';

  @override
  String get note => 'Note:';

  @override
  String get linkedAyahs => 'Linked Ayahs:';

  @override
  String get emptyNoteCollection =>
      'This note collection is empty.\nAdd some notes to see them here.';

  @override
  String get emptyPinnedCollection =>
      'No Ayahs pinned to this collection yet.\nPin Ayahs to see them here.';

  @override
  String get noContentAvailable => 'No content available.';

  @override
  String failedToLoadCollections(String error) {
    return 'Failed to load collections: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Search By $collectionType Name...';
  }

  @override
  String get sortBy => 'Sort by';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'No $collectionType added yet';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count pinned items';
  }

  @override
  String notesCount(int count) {
    return '$count notes';
  }

  @override
  String get emptyNameNotAllowed => 'Empty name not allowed';

  @override
  String updatedTo(String collectionName) {
    return 'Updated to $collectionName';
  }

  @override
  String get changeName => 'Change Name';

  @override
  String get changeColor => 'Change Color';

  @override
  String get colorUpdated => 'Color updated';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Deleted';
  }

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get collectionNameCannotBeEmpty => 'Collection name cannot be empty.';

  @override
  String get addedNewCollection => 'Added New Collection';

  @override
  String ayahCount(int count) {
    return '$count Ayah';
  }

  @override
  String get byNameAtoZ => 'Name A-Z';

  @override
  String get byNameZtoA => 'Name Z-A';

  @override
  String get byElementNumberAscending => 'Element Number Ascending';

  @override
  String get byElementNumberDescending => 'Element Number Descending';

  @override
  String get byUpdateDateAscending => 'Update Date Ascending';

  @override
  String get byUpdateDateDescending => 'Update Date Descending';

  @override
  String get byCreateDateAscending => 'Create Date Ascending';

  @override
  String get byCreateDateDescending => 'Create Date Descending';

  @override
  String get translationNotFound => 'Translation Not Found';

  @override
  String get translationTitle => 'Translation:';

  @override
  String get footNoteTitle => 'Foot Note:';

  @override
  String get wordByWordTranslation => 'Word by Word Translation:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Share';

  @override
  String get addNoteButton => 'Add Note';

  @override
  String get pinToCollectionButton => 'Pin to Collection';

  @override
  String get shareAsText => 'Share as Text';

  @override
  String get copiedWithTafsir => 'Copied with Tafsir';

  @override
  String get shareAsImage => 'Share as Image';

  @override
  String get shareWithTafsir => 'Share with Tafsir';

  @override
  String get notFound => 'Not found';

  @override
  String get noteContentCannotBeEmpty => 'Note content cannot be empty.';

  @override
  String get noteSavedSuccessfully => 'Note saved successfully!';

  @override
  String get selectCollections => 'Select Collections';

  @override
  String get addNote => 'Add Note';

  @override
  String get writeCollectionName => 'Write collection name...';

  @override
  String get noCollectionsYetAddANewOne => 'No collections yet. Add a new one!';

  @override
  String get pleaseWriteYourNoteFirst => 'Please write your note first.';

  @override
  String get noCollectionSelected => 'No Collection selected';

  @override
  String get saveNote => 'Save Note';

  @override
  String get nextSelectCollections => 'Next: Select Collections';

  @override
  String get addToPinned => 'Add To Pinned';

  @override
  String get pinnedSavedSuccessfully => 'Pinned saved successfully!';

  @override
  String get savePinned => 'Save Pinned';

  @override
  String get closeAudioController => 'Close Audio Controller';

  @override
  String get previous => 'Previous';

  @override
  String get rewind => 'Rewind';

  @override
  String get fastForward => 'Fast Forward';

  @override
  String get playNextAyah => 'Play Next Ayah';

  @override
  String get repeat => 'Repeat';

  @override
  String get playAsPlaylist => 'Play As Playlist';

  @override
  String style(String style) {
    return 'Style: $style';
  }

  @override
  String get stopAndClose => 'Stop & Close';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get selectReciter => 'Select Reciter';

  @override
  String source(String source) {
    return 'Source: $source';
  }

  @override
  String get newText => 'New';

  @override
  String get more => 'More: ';

  @override
  String get cacheNotFound => 'Cache Not Found';

  @override
  String get cacheSize => 'Cache Size';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get clean => 'Clean';

  @override
  String get lastModified => 'Last Modified';

  @override
  String get oneYearAgo => '1 Year ago';

  @override
  String monthsAgo(String number) {
    return '$number Months ago';
  }

  @override
  String weeksAgo(String number) {
    return '$number Weeks ago';
  }

  @override
  String daysAgo(String number) {
    return '$number Days ago';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Hours ago';
  }

  @override
  String get aboutAlQuran => 'About Al Quran';

  @override
  String get appFullName => 'Al Quran (Tafsir, Prayer, Qibla, Audio)';

  @override
  String get appDescription =>
      'A comprehensive Islamic application for Android, iOS, MacOS, Web, Linux and Windows, offering Quran reading with Tafsir & multiple translations (including word-by-word), worldwide prayer times with notifications, Qibla compass, and synchronized word-by-word audio recitation.';

  @override
  String get dataSourcesNote =>
      'Note: Quran texts, Tafsir, translations, and audio resources are sourced from Quran.com, Everyayah.com, and other verified open sources.';

  @override
  String get adFreePromise =>
      'This app has been built to seek the pleasure of Allah. Therefore, it is and always will be completely Ad-Free.';

  @override
  String get coreFeatures => 'Core Features';

  @override
  String get coreFeaturesDescription =>
      'Explore the key functionalities that make Al Quran v3 an indispensable tool for your daily Islamic practices:';

  @override
  String get prayerTimesTitle => 'Prayer Times & Alerts';

  @override
  String get prayerTimesDescription =>
      'Accurate prayer timings for any location worldwide using various calculation methods. Set reminders with Adhan notifications.';

  @override
  String get qiblaDirectionTitle => 'Qibla Direction';

  @override
  String get qiblaDirectionDescription =>
      'Easily find the Qibla direction with a clear and accurate compass view.';

  @override
  String get translationTafsirTitle => 'Quran Translation & Tafsir';

  @override
  String get translationTafsirDescription =>
      'Access 120+ translation books (including word-by-word) in 69 languages, and 30+ Tafsir books.';

  @override
  String get wordByWordAudioTitle => 'Word by Word Audio & Highlighting';

  @override
  String get wordByWordAudioDescription =>
      'Follow along with synchronized word-by-word audio recitation and highlighting for an immersive learning experience.';

  @override
  String get ayahAudioRecitationTitle => 'Ayah Audio Recitation';

  @override
  String get ayahAudioRecitationDescription =>
      'Listen to full Ayah recitations from over 40+ renowned reciters.';

  @override
  String get notesCloudBackupTitle => 'Notes with Cloud Backup';

  @override
  String get notesCloudBackupDescription =>
      'Save personal notes and reflections, securely backed up to the cloud (feature in development/coming soon).';

  @override
  String get crossPlatformSupportTitle => 'Cross-Platform Support';

  @override
  String get crossPlatformSupportDescription =>
      'Supported on Android, Web, Linux, and Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Background Audio Playback';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continue listening to Quran recitation even when the app is in the background.';

  @override
  String get audioDataCachingTitle => 'Audio & Data Caching';

  @override
  String get audioDataCachingDescription =>
      'Improved playback and offline capabilities with robust audio and Quran data caching.';

  @override
  String get minimalisticInterfaceTitle => 'Minimalistic & Clean Interface';

  @override
  String get minimalisticInterfaceDescription =>
      'Easy to navigate interface with focus on user experience and readability.';

  @override
  String get optimizedPerformanceTitle => 'Optimized Performance & Size';

  @override
  String get optimizedPerformanceDescription =>
      'A feature-rich application designed to be lightweight and performant.';

  @override
  String get languageSupport => 'Language Support';

  @override
  String get languageSupportDescription =>
      'This application is designed to be accessible to a global audience with support for the following languages (and more are continuously being added):';

  @override
  String get technologyAndResources => 'Technology & Resources';

  @override
  String get technologyAndResourcesDescription =>
      'This app is built using cutting-edge technologies and reliable resources:';

  @override
  String get flutterFrameworkTitle => 'Flutter Framework';

  @override
  String get flutterFrameworkDescription =>
      'Built with Flutter for a beautiful, natively compiled, multi-platform experience from a single codebase.';

  @override
  String get advancedAudioEngineTitle => 'Advanced Audio Engine';

  @override
  String get advancedAudioEngineDescription =>
      'Powered by the `just_audio` and `just_audio_background` Flutter packages for robust audio playback and control.';

  @override
  String get reliableQuranDataTitle => 'Reliable Quran Data';

  @override
  String get reliableQuranDataDescription =>
      'Al Quran texts, translations, tafsirs, and audio are sourced from verified open APIs and databases like Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Prayer Time Engine';

  @override
  String get prayerTimeEngineDescription =>
      'Utilizes established calculation methods for accurate prayer times. Notifications handled by `flutter_local_notifications` and background tasks.';

  @override
  String get crossPlatformSupport => 'Cross Platform Support';

  @override
  String get crossPlatformSupportDescription2 =>
      'Enjoy seamless access across various platforms:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'Web';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'Our Lifetime Promise';

  @override
  String get lifetimePromiseDescription =>
      'I personally promise to provide continuous support and maintenance for this application throughout my life, In Sha Allah. My goal is to ensure this app remains a beneficial resource for the Ummah for years to come.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Midnight';

  @override
  String get alarm => 'Alarm';

  @override
  String get notification => 'Notification';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajweed';

  @override
  String get quranScriptUthmani => 'Uthmani';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Sajda Ayah';

  @override
  String get required => 'Required';

  @override
  String get optional => 'Optional';

  @override
  String get notificationScheduleWarning =>
      'Note: Scheduled Notification or Reminder can be missed due to your phone\'s OS background process restrictions. For example: Vivo\'s Origin OS, Samsung\'s One UI, Oppo\'s ColorOS etc. are sometimes kills scheduled Notification or Reminder . Please check your OS settings for make app not restricted from background process.';

  @override
  String get scrollWithRecitation => 'Scroll with Recitation';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get initiallyScrollAyah => 'Initially scroll to ayah';

  @override
  String get tajweedGuide => 'Tajweed Guide';

  @override
  String get scrollWithRecitationDesc =>
      'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.';

  @override
  String get configuration => 'Configuration';

  @override
  String get restoreFromBackup => 'Restore From Backup';

  @override
  String get history => 'History';

  @override
  String get search => 'Search';

  @override
  String get useAudioStream => 'Use Audio Stream';

  @override
  String get useAudioStreamDesc =>
      'Stream audio directly from the internet instead of downloading.';

  @override
  String get notUseAudioStreamDesc =>
      'Download audio for offline use and reduce data consumption.';

  @override
  String get audioSettings => 'Audio Settings';

  @override
  String get playbackSpeed => 'Playback Speed';

  @override
  String get playbackSpeedDesc => 'Adjust the speed of the Quran Recitation.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Please wait for the current download to finish.';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get checkYourInternetConnection => 'Check your internet connection.';
}
