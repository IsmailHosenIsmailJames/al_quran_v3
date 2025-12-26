// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

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
    return '$ayahKey এর জন্য তাফসীর পাওয়া যায়নি';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'তাফসীর পাওয়া যাবে এখানে: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey এ যান';
  }

  @override
  String get hizb => 'হিজব';

  @override
  String get juz => 'জুয';

  @override
  String get page => 'পৃষ্ঠা';

  @override
  String get ruku => 'রুকু';

  @override
  String get languageSettings => 'ভাষা সেটিংস';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count আয়াত';
  }

  @override
  String get saveAndDownload => 'সেভ করুন এবং ডাউনলোড করুন';

  @override
  String get appLanguage => 'অ্যাপের ভাষা';

  @override
  String get selectAppLanguage => 'অ্যাপের ভাষা নির্বাচন করুন...';

  @override
  String get pleaseSelectOne => 'দয়া করে একটা নির্বাচন করুন';

  @override
  String get quranTranslationLanguage => 'কুরআন অনুবাদের ভাষা';

  @override
  String get selectTranslationLanguage => 'অনুবাদের ভাষা নির্বাচন করুন...';

  @override
  String get quranTranslationBook => 'কুরআন অনুবাদের বই';

  @override
  String get selectTranslationBook => 'অনুবাদের বই নির্বাচন করুন...';

  @override
  String get quranTafsirLanguage => 'কুরআন তাফসীরের ভাষা';

  @override
  String get selectTafsirLanguage => 'তাফসীরের ভাষা নির্বাচন করুন...';

  @override
  String get quranTafsirBook => 'কুরআন তাফসীরের বই';

  @override
  String get selectTafsirBook => 'তাফসীরের বই নির্বাচন করুন...';

  @override
  String get quranScriptAndStyle => 'কুরআন স্ক্রিপ্ট এবং স্টাইল';

  @override
  String get justAMoment => 'একটু অপেক্ষা করুন...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'সফল';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get unableToDownloadResources =>
      'রিসোর্স ডাউনলোড করতে পারছি না...\nকিছু একটা সমস্যা হয়েছে';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'সেগমেন্টেড কুরআন তিলাওয়াত ডাউনলোড হচ্ছে';

  @override
  String get processingSegmentedQuranRecitation =>
      'সেগমেন্টেড কুরআন তিলাওয়াত প্রসেস হচ্ছে';

  @override
  String get footnote => 'ফুটনোট';

  @override
  String get tafsir => 'তাফসীর';

  @override
  String get wordByWord => 'শব্দে শব্দে';

  @override
  String get pleaseSelectRequiredOption =>
      'দয়া করে প্রয়োজনীয় অপশন নির্বাচন করুন';

  @override
  String get rememberHomeTab => 'হোম ট্যাব মনে রাখুন';

  @override
  String get rememberHomeTabSubtitle =>
      'অ্যাপ হোম স্ক্রিনের শেষ খোলা ট্যাব মনে রাখবে।';

  @override
  String get wakeLock => 'ওয়েক লক';

  @override
  String get wakeLockSubtitle =>
      'স্ক্রিন অটোম্যাটিক বন্ধ হওয়া থেকে বিরত রাখুন।';

  @override
  String get settings => 'সেটিংস';

  @override
  String get appTheme => 'অ্যাপ থিম';

  @override
  String get quranStyle => 'কুরআন স্টাইল';

  @override
  String get changeTheme => 'থিম চেঞ্জ করুন';

  @override
  String get verseCount => 'আয়াত সংখ্যা: ';

  @override
  String get translation => 'অনুবাদ';

  @override
  String get tafsirNotFound => 'পাওয়া যায়নি';

  @override
  String get moreInfo => 'আরও তথ্য';

  @override
  String get playAudio => 'অডিও চালান';

  @override
  String get preview => 'প্রিভিউ';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get errorFetchingAddress => 'ঠিকানা আনতে সমস্যা';

  @override
  String get addressNotAvailable => 'ঠিকানা পাওয়া যায়নি';

  @override
  String get latitude => 'অক্ষাংশ: ';

  @override
  String get longitude => 'দ্রাঘিমা: ';

  @override
  String get name => 'নাম: ';

  @override
  String get location => 'লোকেশন: ';

  @override
  String get parameters => 'প্যারামিটার: ';

  @override
  String get selectCalculationMethod => 'ক্যালকুলেশন মেথড নির্বাচন করুন';

  @override
  String get shareSelectAyahs => 'নির্বাচিত আয়াত শেয়ার করুন';

  @override
  String get selectionEmpty => 'নির্বাচন খালি';

  @override
  String get generatingImagePleaseWait => 'ইমেজ তৈরি হচ্ছে... অপেক্ষা করুন';

  @override
  String get asImage => 'ইমেজ হিসেবে';

  @override
  String get asText => 'টেক্সট হিসেবে';

  @override
  String get playFromSelectedAyah => 'নির্বাচিত আয়াত থেকে চালান';

  @override
  String get toTafsir => 'তাফসীরে যান';

  @override
  String get selectAyah => 'আয়াত নির্বাচন করুন';

  @override
  String get toAyah => 'আয়াতে যান';

  @override
  String get searchForASurah => 'একটা সূরা খুঁজুন';

  @override
  String get bugReportTitle => 'বাগ রিপোর্ট';

  @override
  String get audioCached => 'অডিও ক্যাশড';

  @override
  String get others => 'অন্যান্য';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'কুরআন|অনুবাদ|আয়াত, একটা অবশ্যই চালু থাকতে হবে';

  @override
  String get quranFontSize => 'কুরআন ফন্ট সাইজ';

  @override
  String get quranLineHeight => 'কুরআন লাইন হাইট';

  @override
  String get translationAndTafsirFontSize => 'অনুবাদ ও তাফসীর ফন্ট সাইজ';

  @override
  String get quranAyah => 'কুরআন আয়াত';

  @override
  String get topToolbar => 'উপরের টুলবার';

  @override
  String get keepOpenWordByWord => 'শব্দে শব্দে খোলা রাখুন';

  @override
  String get wordByWordHighlight => 'শব্দে শব্দে হাইলাইট';

  @override
  String get quranScriptSettings => 'কুরআন স্ক্রিপ্ট সেটিংস';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'পৃষ্ঠা: ';

  @override
  String get quranResources => 'কুরআন রিসোর্স';

  @override
  String alreadySelected(String name) {
    return '\'$name\' ভাষা ইতিমধ্যে নির্বাচিত।';
  }

  @override
  String get unableToGetCompassData => 'কম্পাস ডেটা পাওয়া যাচ্ছে না';

  @override
  String get deviceDoesNotHaveSensors => 'ডিভাইসে সেন্সর নেই!';

  @override
  String get north => 'উ';

  @override
  String get east => 'পূ';

  @override
  String get south => 'দ';

  @override
  String get west => 'প';

  @override
  String get address => 'ঠিকানা: ';

  @override
  String get change => 'চেঞ্জ';

  @override
  String get calculationMethod => 'ক্যালকুলেশন মেথড: ';

  @override
  String get downloadPrayerTime => 'নামাজের সময় ডাউনলোড করুন';

  @override
  String get calculationMethodsListEmpty => 'ক্যালকুলেশন মেথডের লিস্ট খালি।';

  @override
  String get noCalculationMethodWithLocationData =>
      'লোকেশন ডেটা সহ কোনো ক্যালকুলেশন মেথড পাওয়া যায়নি।';

  @override
  String get prayerSettings => 'নামাজ সেটিংস';

  @override
  String get reminderSettings => 'রিমাইন্ডার সেটিংস';

  @override
  String get adjustReminderTime => 'রিমাইন্ডার সময় অ্যাডজাস্ট করুন';

  @override
  String get enforceAlarmSound => 'অ্যালার্মের সাউন্ড জোর করে চালান';

  @override
  String get enforceAlarmSoundDescription =>
      'চালু থাকলে, এই ফিচার অ্যালার্মের ভলিউম এখানে সেট করা ভলিউমে চালাবে, এমনকি ফোনের সাউন্ড কম থাকলেও। এতে অ্যালার্ম মিস হবে না।';

  @override
  String get volume => 'ভলিউম';

  @override
  String get atPrayerTime => 'নামাজের সময়ে';

  @override
  String minBefore(int minutes) {
    return '$minutes মিনিট আগে';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes মিনিট পরে';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName এর সময় $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName এর সময় হয়েছে';
  }

  @override
  String get stopTheAdhan => 'আজান বন্ধ করুন';

  @override
  String dateFoundEmpty(String date) {
    return '$date খালি পাওয়া গেছে';
  }

  @override
  String get today => 'আজ';

  @override
  String get left => 'বাকি';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName এর রিমাইন্ডার যোগ করা হয়েছে';
  }

  @override
  String get allowNotificationPermission =>
      'এই ফিচার ব্যবহার করতে নোটিফিকেশন পারমিশন দিন';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName এর রিমাইন্ডার সরানো হয়েছে';
  }

  @override
  String get getPrayerTimesAndQibla => 'নামাজের সময় এবং কিবলা পান';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'যেকোনো লোকেশনের জন্য নামাজের সময় এবং কিবলা ক্যালকুলেট করুন।';

  @override
  String get getFromGPS => 'জিপিএস থেকে পান';

  @override
  String get or => 'অথবা';

  @override
  String get selectYourCity => 'আপনার শহর নির্বাচন করুন';

  @override
  String get noteAboutGPS =>
      'নোট: জিপিএস ব্যবহার করতে না চাইলে বা নিরাপদ মনে না করলে, আপনার শহর নির্বাচন করুন।';

  @override
  String get downloadingLocationResources => 'লোকেশন রিসোর্স ডাউনলোড হচ্ছে...';

  @override
  String get somethingWentWrong => 'কিছু একটা সমস্যা হয়েছে';

  @override
  String get selectYourCountry => 'আপনার দেশ নির্বাচন করুন';

  @override
  String get searchForACountry => 'একটা দেশ খুঁজুন';

  @override
  String get selectYourAdministrator => 'আপনার অ্যাডমিনিস্ট্রেটর নির্বাচন করুন';

  @override
  String get searchForAnAdministrator => 'একটা অ্যাডমিনিস্ট্রেটর খুঁজুন';

  @override
  String get searchForACity => 'একটা শহর খুঁজুন';

  @override
  String get pleaseEnableLocationService => 'লোকেশন সার্ভিস চালু করুন';

  @override
  String get donateUs => 'আমাদের ডোনেট করুন';

  @override
  String get underDevelopment => 'ডেভেলপমেন্টের মধ্যে';

  @override
  String get versionLoading => 'লোড হচ্ছে...';

  @override
  String get alQuran => 'আল কুরআন';

  @override
  String get mainMenu => 'মেইন মেনু';

  @override
  String get notes => 'নোটস';

  @override
  String get pinned => 'পিনড';

  @override
  String get jumpToAyah => 'আয়াতে যান';

  @override
  String get shareMultipleAyah => 'একাধিক আয়াত শেয়ার করুন';

  @override
  String get shareThisApp => 'এই অ্যাপ শেয়ার করুন';

  @override
  String get giveRating => 'রেটিং দিন';

  @override
  String get bugReport => 'বাগ রিপোর্ট';

  @override
  String get privacyPolicy => 'প্রাইভেসি পলিসি';

  @override
  String get aboutTheApp => 'অ্যাপ সম্পর্কে';

  @override
  String get resetTheApp => 'অ্যাপ রিসেট করুন';

  @override
  String get resetAppWarningTitle => 'অ্যাপ ডেটা রিসেট';

  @override
  String get resetAppWarningMessage =>
      'আপনি কি নিশ্চিত অ্যাপ রিসেট করতে চান? সব ডেটা হারিয়ে যাবে, এবং অ্যাপ শুরু থেকে সেটআপ করতে হবে।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get reset => 'রিসেট';

  @override
  String get shareAppSubject => 'এই আল কুরআন অ্যাপ দেখুন!';

  @override
  String shareAppBody(String appLink) {
    return 'আসসালামু আলাইকুম! এই আল কুরআন অ্যাপ দেখুন দৈনিক পড়া এবং চিন্তার জন্য। এটা আল্লাহর কথার সাথে যুক্ত হতে সাহায্য করে। এখান থেকে ডাউনলোড করুন: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ড্রয়ার খুলুন';

  @override
  String get quran => 'কুরআন';

  @override
  String get prayer => 'নামাজ';

  @override
  String get qibla => 'কিবলা';

  @override
  String get audio => 'অডিও';

  @override
  String get surah => 'সূরা';

  @override
  String get pages => 'পৃষ্ঠাসমূহ';

  @override
  String get note => 'নোট:';

  @override
  String get linkedAyahs => 'লিঙ্কড আয়াত:';

  @override
  String get emptyNoteCollection =>
      'এই নোট কালেকশন খালি।\nকিছু নোট যোগ করে দেখুন।';

  @override
  String get emptyPinnedCollection =>
      'এই কালেকশনে কোনো আয়াত পিন করা হয়নি।\nআয়াত পিন করে দেখুন।';

  @override
  String get noContentAvailable => 'কোনো কনটেন্ট পাওয়া যায়নি।';

  @override
  String failedToLoadCollections(String error) {
    return 'কালেকশন লোড করতে ব্যর্থ: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType নাম দিয়ে খুঁজুন...';
  }

  @override
  String get sortBy => 'সর্ট করুন';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'এখনো কোনো $collectionType যোগ করা হয়নি';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count পিনড আইটেম';
  }

  @override
  String notesCount(int count) {
    return '$count নোট';
  }

  @override
  String get emptyNameNotAllowed => 'খালি নাম অনুমোদিত নয়';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName এ আপডেট করা হয়েছে';
  }

  @override
  String get changeName => 'নাম চেঞ্জ করুন';

  @override
  String get changeColor => 'রঙ চেঞ্জ করুন';

  @override
  String get colorUpdated => 'রঙ আপডেট করা হয়েছে';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName ডিলিট করা হয়েছে';
  }

  @override
  String get delete => 'ডিলিট';

  @override
  String get save => 'সেভ';

  @override
  String get collectionNameCannotBeEmpty => 'কালেকশন নাম খালি হতে পারবে না।';

  @override
  String get addedNewCollection => 'নতুন কালেকশন যোগ করা হয়েছে';

  @override
  String ayahCount(int count) {
    return '$count আয়াত';
  }

  @override
  String get byNameAtoZ => 'নাম A-Z';

  @override
  String get byNameZtoA => 'নাম Z-A';

  @override
  String get byElementNumberAscending => 'এলিমেন্ট নম্বর অ্যাসেন্ডিং';

  @override
  String get byElementNumberDescending => 'এলিমেন্ট নম্বর ডিসেন্ডিং';

  @override
  String get byUpdateDateAscending => 'আপডেট ডেট অ্যাসেন্ডিং';

  @override
  String get byUpdateDateDescending => 'আপডেট ডেট ডিসেন্ডিং';

  @override
  String get byCreateDateAscending => 'ক্রিয়েট ডেট অ্যাসেন্ডিং';

  @override
  String get byCreateDateDescending => 'ক্রিয়েট ডেট ডিসেন্ডিং';

  @override
  String get translationNotFound => 'অনুবাদ পাওয়া যায়নি';

  @override
  String get translationTitle => 'অনুবাদ:';

  @override
  String get footNoteTitle => 'ফুট নোট:';

  @override
  String get wordByWordTranslation => 'শব্দে শব্দে অনুবাদ:';

  @override
  String get tafsirButton => 'তাফসীর';

  @override
  String get shareButton => 'শেয়ার';

  @override
  String get addNoteButton => 'নোট যোগ করুন';

  @override
  String get pinToCollectionButton => 'কালেকশনে পিন করুন';

  @override
  String get shareAsText => 'টেক্সট হিসেবে শেয়ার';

  @override
  String get copiedWithTafsir => 'তাফসীর সহ কপি করা হয়েছে';

  @override
  String get shareAsImage => 'ইমেজ হিসেবে শেয়ার';

  @override
  String get shareWithTafsir => 'তাফসীর সহ শেয়ার';

  @override
  String get notFound => 'পাওয়া যায়নি';

  @override
  String get noteContentCannotBeEmpty => 'নোট কনটেন্ট খালি হতে পারবে না।';

  @override
  String get noteSavedSuccessfully => 'নোট সফলভাবে সেভ করা হয়েছে!';

  @override
  String get selectCollections => 'কালেকশন নির্বাচন করুন';

  @override
  String get addNote => 'নোট যোগ করুন';

  @override
  String get writeCollectionName => 'কালেকশন নাম লিখুন...';

  @override
  String get noCollectionsYetAddANewOne =>
      'এখনো কোনো কালেকশন নেই। নতুন একটা যোগ করুন!';

  @override
  String get pleaseWriteYourNoteFirst => 'প্রথমে আপনার নোট লিখুন।';

  @override
  String get noCollectionSelected => 'কোনো কালেকশন নির্বাচিত নয়';

  @override
  String get saveNote => 'নোট সেভ করুন';

  @override
  String get nextSelectCollections => 'পরবর্তী: কালেকশন নির্বাচন করুন';

  @override
  String get addToPinned => 'পিনডে যোগ করুন';

  @override
  String get pinnedSavedSuccessfully => 'পিনড সফলভাবে সেভ করা হয়েছে!';

  @override
  String get savePinned => 'পিনড সেভ করুন';

  @override
  String get closeAudioController => 'অডিও কন্ট্রোলার বন্ধ করুন';

  @override
  String get previous => 'পূর্ববর্তী';

  @override
  String get rewind => 'রিওয়াইন্ড';

  @override
  String get fastForward => 'ফাস্ট ফরওয়ার্ড';

  @override
  String get playNextAyah => 'পরবর্তী আয়াত চালান';

  @override
  String get repeat => 'রিপিট';

  @override
  String get playAsPlaylist => 'প্লেলিস্ট হিসেবে চালান';

  @override
  String style(String style) {
    return 'স্টাইল: $style';
  }

  @override
  String get stopAndClose => 'বন্ধ করুন এবং ক্লোজ করুন';

  @override
  String get play => 'চালান';

  @override
  String get pause => 'পজ';

  @override
  String get selectReciter => 'তিলাওয়াতকারী নির্বাচন করুন';

  @override
  String source(String source) {
    return 'সোর্স: $source';
  }

  @override
  String get newText => 'নতুন';

  @override
  String get more => 'আরও: ';

  @override
  String get cacheNotFound => 'ক্যাশ পাওয়া যায়নি';

  @override
  String get cacheSize => 'ক্যাশ সাইজ';

  @override
  String error(String error) {
    return 'এরর: $error';
  }

  @override
  String get clean => 'ক্লিন';

  @override
  String get lastModified => 'শেষ মডিফাইড';

  @override
  String get oneYearAgo => '১ বছর আগে';

  @override
  String monthsAgo(String number) {
    return '$number মাস আগে';
  }

  @override
  String weeksAgo(String number) {
    return '$number সপ্তাহ আগে';
  }

  @override
  String daysAgo(String number) {
    return '$number দিন আগে';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour ঘণ্টা আগে';
  }

  @override
  String get aboutAlQuran => 'আল কুরআন সম্পর্কে';

  @override
  String get appFullName => 'আল কুরআন (তাফসীর, নামাজ, কিবলা, অডিও)';

  @override
  String get appDescription =>
      'একটা সম্পূর্ণ ইসলামিক অ্যাপ অ্যান্ড্রয়েড, আইওএস, ম্যাকওএস, ওয়েব, লিনাক্স এবং উইন্ডোজের জন্য, কুরআন পড়া তাফসীর এবং একাধিক অনুবাদ (শব্দে শব্দে সহ), বিশ্বব্যাপী নামাজের সময় নোটিফিকেশন সহ, কিবলা কম্পাস, এবং শব্দে শব্দে সিঙ্ক্রোনাইজড অডিও তিলাওয়াত।';

  @override
  String get dataSourcesNote =>
      'নোট: কুরআন টেক্সট, তাফসীর, অনুবাদ, এবং অডিও রিসোর্স Quran.com, Everyayah.com, এবং অন্যান্য যাচাইকৃত ওপেন সোর্স থেকে নেয়া।';

  @override
  String get adFreePromise =>
      'এই অ্যাপ আল্লাহর সন্তুষ্টির জন্য তৈরি। তাই এটা সবসময় অ্যাড-ফ্রি থাকবে।';

  @override
  String get coreFeatures => 'মূল ফিচারসমূহ';

  @override
  String get coreFeaturesDescription =>
      'আল কুরআন v3 এর মূল ফাংশনালিটি অন্বেষণ করুন যা আপনার দৈনিক ইসলামিক অনুশীলনের জন্য অপরিহার্য টুল:';

  @override
  String get prayerTimesTitle => 'নামাজের সময় এবং অ্যালার্ট';

  @override
  String get prayerTimesDescription =>
      'বিভিন্ন ক্যালকুলেশন মেথড ব্যবহার করে বিশ্বের যেকোনো লোকেশনের জন্য সঠিক নামাজের সময়। আজান নোটিফিকেশন সহ রিমাইন্ডার সেট করুন।';

  @override
  String get qiblaDirectionTitle => 'কিবলা দিক';

  @override
  String get qiblaDirectionDescription =>
      'সহজে কিবলা দিক খুঁজুন স্পষ্ট এবং সঠিক কম্পাস ভিউ সহ।';

  @override
  String get translationTafsirTitle => 'কুরআন অনুবাদ এবং তাফসীর';

  @override
  String get translationTafsirDescription =>
      '৬৯ ভাষায় ১২০+ অনুবাদ বই (শব্দে শব্দে সহ), এবং ৩০+ তাফসীর বই অ্যাক্সেস করুন।';

  @override
  String get wordByWordAudioTitle => 'শব্দে শব্দে অডিও এবং হাইলাইটিং';

  @override
  String get wordByWordAudioDescription =>
      'ইমার্সিভ লার্নিং অভিজ্ঞতার জন্য সিঙ্ক্রোনাইজড শব্দে শব্দে অডিও তিলাওয়াত এবং হাইলাইটিং সহ অনুসরণ করুন।';

  @override
  String get ayahAudioRecitationTitle => 'আয়াত অডিও তিলাওয়াত';

  @override
  String get ayahAudioRecitationDescription =>
      '৪০+ বিখ্যাত তিলাওয়াতকারীর থেকে পূর্ণ আয়াত তিলাওয়াত শুনুন।';

  @override
  String get notesCloudBackupTitle => 'নোটস ক্লাউড ব্যাকআপ সহ';

  @override
  String get notesCloudBackupDescription =>
      'ব্যক্তিগত নোট এবং চিন্তা সেভ করুন, ক্লাউডে নিরাপদে ব্যাকআপ (ফিচার ডেভেলপমেন্টে/শীঘ্রই আসছে)।';

  @override
  String get crossPlatformSupportTitle => 'ক্রস-প্ল্যাটফর্ম সাপোর্ট';

  @override
  String get crossPlatformSupportDescription =>
      'অ্যান্ড্রয়েড, ওয়েব, লিনাক্স, এবং উইন্ডোজে সাপোর্টেড।';

  @override
  String get backgroundAudioPlaybackTitle => 'ব্যাকগ্রাউন্ড অডিও প্লেব্যাক';

  @override
  String get backgroundAudioPlaybackDescription =>
      'অ্যাপ ব্যাকগ্রাউন্ডে থাকলেও কুরআন তিলাওয়াত শোনা চালিয়ে যান।';

  @override
  String get audioDataCachingTitle => 'অডিও এবং ডেটা ক্যাশিং';

  @override
  String get audioDataCachingDescription =>
      'অফলাইন ক্যাপাবিলিটি এবং উন্নত প্লেব্যাকের জন্য শক্তিশালী অডিও এবং কুরআন ডেটা ক্যাশিং।';

  @override
  String get minimalisticInterfaceTitle => 'মিনিমালিস্টিক এবং ক্লিন ইন্টারফেস';

  @override
  String get minimalisticInterfaceDescription =>
      'সহজ নেভিগেশন ইন্টারফেস ইউজার এক্সপিরিয়েন্স এবং পড়ার উপর ফোকাস সহ।';

  @override
  String get optimizedPerformanceTitle => 'অপটিমাইজড পারফরম্যান্স এবং সাইজ';

  @override
  String get optimizedPerformanceDescription =>
      'ফিচার-রিচ অ্যাপ্লিকেশন যা লাইটওয়েট এবং পারফরম্যান্ট ডিজাইন করা।';

  @override
  String get languageSupport => 'ভাষা সাপোর্ট';

  @override
  String get languageSupportDescription =>
      'এই অ্যাপ্লিকেশন বিশ্বব্যাপী অ্যাক্সেসিবল হওয়ার জন্য ডিজাইন করা, নিম্নলিখিত ভাষাসমূহ সাপোর্ট করে (এবং আরও যোগ হচ্ছে):';

  @override
  String get technologyAndResources => 'টেকনোলজি এবং রিসোর্স';

  @override
  String get technologyAndResourcesDescription =>
      'এই অ্যাপ কাটিং-এজ টেকনোলজি এবং নির্ভরযোগ্য রিসোর্স ব্যবহার করে তৈরি:';

  @override
  String get flutterFrameworkTitle => 'ফ্লাটার ফ্রেমওয়ার্ক';

  @override
  String get flutterFrameworkDescription =>
      'ফ্লাটার দিয়ে তৈরি সুন্দর, নেটিভলি কম্পাইল্ড, মাল্টি-প্ল্যাটফর্ম এক্সপিরিয়েন্স একটা সিঙ্গেল কোডবেস থেকে।';

  @override
  String get advancedAudioEngineTitle => 'অ্যাডভান্সড অডিও ইঞ্জিন';

  @override
  String get advancedAudioEngineDescription =>
      '`just_audio` এবং `just_audio_background` ফ্লাটার প্যাকেজ দিয়ে চালিত শক্তিশালী অডিও প্লেব্যাক এবং কন্ট্রোলের জন্য।';

  @override
  String get reliableQuranDataTitle => 'নির্ভরযোগ্য কুরআন ডেটা';

  @override
  String get reliableQuranDataDescription =>
      'আল কুরআন টেক্সট, অনুবাদ, তাফসীর, এবং অডিও যাচাইকৃত ওপেন এপিআই এবং ডেটাবেস যেমন Quran.com এবং Everyayah.com থেকে নেয়া।';

  @override
  String get prayerTimeEngineTitle => 'নামাজের সময় ইঞ্জিন';

  @override
  String get prayerTimeEngineDescription =>
      'সঠিক নামাজের সময়ের জন্য প্রতিষ্ঠিত ক্যালকুলেশন মেথড ব্যবহার করে। নোটিফিকেশন `flutter_local_notifications` এবং ব্যাকগ্রাউন্ড টাস্ক দিয়ে হ্যান্ডেল করা।';

  @override
  String get crossPlatformSupport => 'ক্রস প্ল্যাটফর্ম সাপোর্ট';

  @override
  String get crossPlatformSupportDescription2 =>
      'বিভিন্ন প্ল্যাটফর্মে সিমলেস অ্যাক্সেস উপভোগ করুন:';

  @override
  String get android => 'অ্যান্ড্রয়েড';

  @override
  String get ios => 'আইওএস';

  @override
  String get macos => 'ম্যাকওএস';

  @override
  String get web => 'ওয়েব';

  @override
  String get linux => 'লিনাক্স';

  @override
  String get windows => 'উইন্ডোজ';

  @override
  String get ourLifetimePromise => 'আমাদের লাইফটাইম প্রমিস';

  @override
  String get lifetimePromiseDescription =>
      'আমি ব্যক্তিগতভাবে প্রমিস করছি এই অ্যাপ্লিকেশনের জন্য আমার জীবনভর সাপোর্ট এবং মেইনটেন্যান্স প্রদান করব, ইনশাআল্লাহ। আমার লক্ষ্য এই অ্যাপ উম্মাহর জন্য বছরের পর বছর উপকারী রিসোর্স হিসেবে থাকবে।';

  @override
  String get fajr => 'ফজর';

  @override
  String get sunrise => 'সূর্যোদয়';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'জোহর';

  @override
  String get asr => 'আসর';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'মাগরিব';

  @override
  String get isha => 'ইশা';

  @override
  String get midnight => 'মধ্যরাত';

  @override
  String get alarm => 'অ্যালার্ম';

  @override
  String get notification => 'নোটিফিকেশন';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'তাজউইদ';

  @override
  String get quranScriptUthmani => 'উসমানি';

  @override
  String get quranScriptIndopak => 'ইন্দোপাক';

  @override
  String get sajdaAyah => 'সাজদা আয়াত';

  @override
  String get required => 'প্রয়োজনীয়';

  @override
  String get optional => 'অপশনাল';

  @override
  String get notificationScheduleWarning =>
      'নোট: স্কেডিউল্ড নোটিফিকেশন বা রিমাইন্ডার আপনার ফোনের ওএস ব্যাকগ্রাউন্ড প্রসেস রেস্ট্রিকশনের কারণে মিস হতে পারে। উদাহরণস্বরূপ: ভিভোর অরিজিন ওএস, স্যামসাংয়ের ওয়ান ইউআই, অপ্পোর কালারওএস ইত্যাদি কখনো কখনো স্কেডিউল্ড নোটিফিকেশন বা রিমাইন্ডার কিল করে। দয়া করে আপনার ওএস সেটিংস চেক করুন যাতে অ্যাপ ব্যাকগ্রাউন্ড প্রসেস থেকে রেস্ট্রিক্ট না হয়।';

  @override
  String get scrollWithRecitation => 'তিলাওয়াতের সাথে স্ক্রল করুন';

  @override
  String get quickAccess => 'কুইক অ্যাক্সেস';

  @override
  String get initiallyScrollAyah => 'প্রথমে আয়াতে স্ক্রল করুন';

  @override
  String get tajweedGuide => 'তাজউইদ গাইড';

  @override
  String get scrollWithRecitationDesc =>
      'চালু থাকলে, কুরআন আয়াত অডিও তিলাওয়াতের সাথে অটোম্যাটিক স্ক্রল করবে।';

  @override
  String get configuration => 'কনফিগারেশন';

  @override
  String get restoreFromBackup => 'ব্যাকআপ থেকে রিস্টোর করুন';

  @override
  String get history => 'হিস্ট্রি';

  @override
  String get search => 'খুঁজুন';

  @override
  String get useAudioStream => 'অডিও স্ট্রিম ব্যবহার করুন';

  @override
  String get useAudioStreamDesc =>
      'ইন্টারনেট থেকে সরাসরি অডিও স্ট্রিম করুন ডাউনলোড না করে।';

  @override
  String get notUseAudioStreamDesc =>
      'অফলাইন ব্যবহারের জন্য অডিও ডাউনলোড করুন এবং ডেটা খরচ কমান।';

  @override
  String get audioSettings => 'অডিও সেটিংস';

  @override
  String get playbackSpeed => 'প্লেব্যাক স্পিড';

  @override
  String get playbackSpeedDesc => 'কুরআন তিলাওয়াতের স্পিড অ্যাডজাস্ট করুন।';

  @override
  String get waitForCurrentDownloadToFinish =>
      'বর্তমান ডাউনলোড শেষ হওয়ার জন্য অপেক্ষা করুন।';

  @override
  String get areYouSure => 'আপনি কি নিশ্চিত?';

  @override
  String get checkYourInternetConnection => 'আপনার ইন্টারনেট কানেকশন চেক করুন।';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount আয়াতের মধ্যে $requiredDownload ডাউনলোড করতে হবে।';
  }

  @override
  String get download => 'ডাউনলোড';

  @override
  String get audioDownload => 'অডিও ডাউনলোড';

  @override
  String get am => 'এএম';

  @override
  String get pm => 'পিএম';

  @override
  String get optimizingQuranScript => 'কুরআন স্ক্রিপ্ট অপটিমাইজ করা হচ্ছে';

  @override
  String get supportOnGithub => 'GitHub-এ সমর্থন করুন';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafie';

  @override
  String get suhurEndTime => 'Suhur End Time';

  @override
  String get iftarStartTime => 'Iftar Start Time';

  @override
  String get tahajjudStartTime => 'Tahajjud Start Time';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';
}
