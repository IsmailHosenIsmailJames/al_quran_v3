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
    return '$nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey এর জন্য তাফসির উপলব্ধ নেই';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'তাফসিরটি এখানে পাওয়া যাবে: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey এ যান';
  }

  @override
  String get hizb => 'হিযব';

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
    return '$count টি আয়াত';
  }

  @override
  String get saveAndDownload => 'সংরক্ষণ ও ডাউনলোড করুন';

  @override
  String get appLanguage => 'অ্যাপের ভাষা';

  @override
  String get selectAppLanguage => 'অ্যাপের ভাষা নির্বাচন করুন...';

  @override
  String get pleaseSelectOne => 'অনুগ্রহ করে একটি নির্বাচন করুন';

  @override
  String get quranTranslationLanguage => 'কুরআনের অনুবাদের ভাষা';

  @override
  String get selectTranslationLanguage => 'অনুবাদের ভাষা নির্বাচন করুন...';

  @override
  String get quranTranslationBook => 'কুরআনের অনুবাদের বই';

  @override
  String get selectTranslationBook => 'অনুবাদের বই নির্বাচন করুন...';

  @override
  String get quranTafsirLanguage => 'কুরআনের তাফসিরের ভাষা';

  @override
  String get selectTafsirLanguage => 'তাফসিরের ভাষা নির্বাচন করুন...';

  @override
  String get quranTafsirBook => 'কুরআনের তাফসিরের বই';

  @override
  String get selectTafsirBook => 'তাফসিরের বই নির্বাচন করুন...';

  @override
  String get quranScriptAndStyle => 'কুরআনের লিপি ও শৈলী';

  @override
  String get justAMoment => 'একটু অপেক্ষা করুন...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'সফল';

  @override
  String get retry => 'পুনরায় চেষ্টা করুন';

  @override
  String get unableToDownloadResources =>
      'রিসোর্স ডাউনলোড করা সম্ভব হচ্ছে না...\nকিছু একটা সমস্যা হয়েছে';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'খণ্ডিত কুরআন তিলাওয়াত ডাউনলোড করা হচ্ছে';

  @override
  String get processingSegmentedQuranRecitation =>
      'খণ্ডিত কুরআন তিলাওয়াত প্রসেস করা হচ্ছে';

  @override
  String get footnote => 'পাদটীকা';

  @override
  String get tafsir => 'তাফসির';

  @override
  String get wordByWord => 'শব্দে শব্দে';

  @override
  String get pleaseSelectRequiredOption => 'প্রয়োজনীয় বিকল্পটি নির্বাচন করুন';

  @override
  String get rememberHomeTab => 'হোম ট্যাব মনে রাখুন';

  @override
  String get rememberHomeTabSubtitle =>
      'অ্যাপটি হোম স্ক্রিনের সর্বশেষ খোলা ট্যাবটি মনে রাখবে।';

  @override
  String get wakeLock => 'স্ক্রিন সজাগ রাখুন';

  @override
  String get wakeLockSubtitle =>
      'স্বয়ংক্রিয়ভাবে স্ক্রিন বন্ধ হওয়া থেকে বিরত রাখুন।';

  @override
  String get settings => 'সেটিংস';

  @override
  String get appTheme => 'অ্যাপ থিম';

  @override
  String get quranStyle => 'কুরআনের শৈলী';

  @override
  String get changeTheme => 'থিম পরিবর্তন করুন';

  @override
  String get verseCount => 'আয়াত সংখ্যা: ';

  @override
  String get translation => 'অনুবাদ';

  @override
  String get tafsirNotFound => 'পাওয়া যায়নি';

  @override
  String get moreInfo => 'আরও তথ্য';

  @override
  String get playAudio => 'অডিও চালান';

  @override
  String get preview => 'প্রিভিউ';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get errorFetchingAddress => 'ঠিকানা আনতে ত্রুটি হয়েছে';

  @override
  String get addressNotAvailable => 'ঠিকানা উপলব্ধ নয়';

  @override
  String get latitude => 'অক্ষাংশ: ';

  @override
  String get longitude => 'দ্রাঘিমাংশ: ';

  @override
  String get name => 'নাম: ';

  @override
  String get location => 'অবস্থান: ';

  @override
  String get parameters => 'প্যারামিটার: ';

  @override
  String get selectCalculationMethod => 'গণনা পদ্ধতি নির্বাচন করুন';

  @override
  String get shareSelectAyahs => 'নির্বাচিত আয়াত শেয়ার করুন';

  @override
  String get selectionEmpty => 'কিছুই নির্বাচন করা হয়নি';

  @override
  String get generatingImagePleaseWait =>
      'ছবি তৈরি হচ্ছে... অনুগ্রহ করে অপেক্ষা করুন';

  @override
  String get asImage => 'ছবি হিসেবে';

  @override
  String get asText => 'টেক্সট হিসেবে';

  @override
  String get playFromSelectedAyah => 'নির্বাচিত আয়াত থেকে চালান';

  @override
  String get toTafsir => 'তাফসিরে যান';

  @override
  String get selectAyah => 'আয়াত নির্বাচন করুন';

  @override
  String get toAyah => 'আয়াতে যান';

  @override
  String get searchForASurah => 'একটি সূরা খুঁজুন';

  @override
  String get bugReportTitle => 'বাগ রিপোর্ট';

  @override
  String get audioCached => 'অডিও ক্যাশ করা হয়েছে';

  @override
  String get others => 'অন্যান্য';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'কুরআন|অনুবাদ|আয়াত, এর মধ্যে একটি অবশ্যই চালু রাখতে হবে';

  @override
  String get quranFontSize => 'কুরআনের ফন্ট সাইজ';

  @override
  String get quranLineHeight => 'কুরআনের লাইন হাইট';

  @override
  String get translationAndTafsirFontSize => 'অনুবাদ ও তাফসিরের ফন্ট সাইজ';

  @override
  String get quranAyah => 'কুরআনের আয়াত';

  @override
  String get topToolbar => 'উপরের টুলবার';

  @override
  String get keepOpenWordByWord => 'শব্দে শব্দে অনুবাদ খোলা রাখুন';

  @override
  String get wordByWordHighlight => 'শব্দে শব্দে হাইলাইট';

  @override
  String get quranScriptSettings => 'কুরআনের লিপি সেটিংস';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'পৃষ্ঠা: ';

  @override
  String get quranResources => 'কুরআনের রিসোর্স';

  @override
  String alreadySelected(String name) {
    return 'ভাষা \'$name\' ইতিমধ্যে নির্বাচিত।';
  }

  @override
  String get unableToGetCompassData => 'কম্পাসের ডেটা পাওয়া যাচ্ছে না';

  @override
  String get deviceDoesNotHaveSensors => 'ডিভাইসে সেন্সর নেই !';

  @override
  String get north => 'উঃ';

  @override
  String get east => 'পূঃ';

  @override
  String get south => 'দঃ';

  @override
  String get west => 'পঃ';

  @override
  String get address => 'ঠিকানা: ';

  @override
  String get change => 'পরিবর্তন';

  @override
  String get calculationMethod => 'গণনা পদ্ধতি: ';

  @override
  String get downloadPrayerTime => 'নামাজের সময় ডাউনলোড করুন';

  @override
  String get calculationMethodsListEmpty => 'গণনা পদ্ধতির তালিকা খালি।';

  @override
  String get noCalculationMethodWithLocationData =>
      'অবস্থানের ডেটা সহ কোনো গণনা পদ্ধতি খুঁজে পাওয়া হয়নি।';

  @override
  String get prayerSettings => 'নামাজের সেটিংস';

  @override
  String get reminderSettings => 'রিমাইন্ডার সেটিংস';

  @override
  String get adjustReminderTime => 'রিমাইন্ডারের সময় ঠিক করুন';

  @override
  String get enforceAlarmSound => 'অ্যালার্মের শব্দ প্রয়োগ করুন';

  @override
  String get enforceAlarmSoundDescription =>
      'এটি চালু থাকলে, আপনার ফোনের সাউন্ড কম থাকলেও এখানে সেট করা ভলিউমে অ্যালার্ম বাজবে। এটি নিশ্চিত করে যে ফোনের ভলিউম কম থাকার কারণে আপনি অ্যালার্ম মিস করবেন না।';

  @override
  String get volume => 'ভলিউম';

  @override
  String get atPrayerTime => 'নামাজের সময়';

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
    return '$prayerName-এর সময় $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName-এর সময় হয়েছে';
  }

  @override
  String get stopTheAdhan => 'আযান বন্ধ করুন';

  @override
  String dateFoundEmpty(String date) {
    return '$date খালি পাওয়া গেছে';
  }

  @override
  String get today => 'আজ';

  @override
  String get left => 'বাকি';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName-এর জন্য রিমাইন্ডার যোগ করা হয়েছে';
  }

  @override
  String get allowNotificationPermission =>
      'এই ফিচারটি ব্যবহার করার জন্য অনুগ্রহ করে নোটিফিকেশন অনুমতি দিন';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName-এর জন্য রিমাইন্ডার সরানো হয়েছে';
  }

  @override
  String get getPrayerTimesAndQibla => 'নামাজের সময় ও কিবলা জানুন';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'যেকোনো অবস্থানের জন্য নামাজের সময় ও কিবলা গণনা করুন।';

  @override
  String get getFromGPS => 'জিপিএস থেকে নিন';

  @override
  String get or => 'অথবা';

  @override
  String get selectYourCity => 'আপনার শহর নির্বাচন করুন';

  @override
  String get noteAboutGPS =>
      'দ্রষ্টব্য: আপনি যদি জিপিএস ব্যবহার করতে না চান বা নিরাপদ বোধ না করেন, তবে আপনার শহর নির্বাচন করতে পারেন।';

  @override
  String get downloadingLocationResources =>
      'অবস্থানের রিসোর্স ডাউনলোড হচ্ছে...';

  @override
  String get somethingWentWrong => 'কিছু একটা সমস্যা হয়েছে';

  @override
  String get selectYourCountry => 'আপনার দেশ নির্বাচন করুন';

  @override
  String get searchForACountry => 'একটি সূরা খুঁজুন';

  @override
  String get selectYourAdministrator => 'আপনার প্রশাসনিক অঞ্চল নির্বাচন করুন';

  @override
  String get searchForAnAdministrator => 'একটি প্রশাসনিক অঞ্চল খুঁজুন';

  @override
  String get searchForACity => 'একটি শহর খুঁজুন';

  @override
  String get pleaseEnableLocationService =>
      'অনুগ্রহ করে লোকেশন সার্ভিস চালু করুন';

  @override
  String get donateUs => 'আমাদের দান করুন';

  @override
  String get underDevelopment => 'নির্মাণাধীন';

  @override
  String get versionLoading => 'লোড হচ্ছে...';

  @override
  String get alQuran => 'আল কুরআন';

  @override
  String get mainMenu => 'প্রধান মেনু';

  @override
  String get notes => 'নোট';

  @override
  String get pinned => 'পিন করা';

  @override
  String get jumpToAyah => 'আয়াতে যান';

  @override
  String get shareMultipleAyah => 'একাধিক আয়াত শেয়ার করুন';

  @override
  String get shareThisApp => 'এই অ্যাপটি শেয়ার করুন';

  @override
  String get giveRating => 'রেটিং দিন';

  @override
  String get bugReport => 'বাগ রিপোর্ট';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get aboutTheApp => 'অ্যাপ সম্পর্কে';

  @override
  String get resetTheApp => 'অ্যাপটি রিসেট করুন';

  @override
  String get resetAppWarningTitle => 'অ্যাপ ডেটা রিসেট করুন';

  @override
  String get resetAppWarningMessage =>
      'আপনি কি অ্যাপটি রিসেট করতে নিশ্চিত? আপনার সমস্ত ডেটা মুছে যাবে এবং আপনাকে প্রথম থেকে অ্যাপটি সেট আপ করতে হবে।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get reset => 'রিসেট';

  @override
  String get shareAppSubject => 'এই আল কুরআন অ্যাপটি দেখুন!';

  @override
  String shareAppBody(String appLink) {
    return 'আসসালামু আলাইকুম! প্রতিদিনের পড়া এবং চিন্তাভাবনার জন্য এই আল কুরআন অ্যাপটি দেখুন। এটি আল্লাহর বাণীর সাথে সংযোগ স্থাপন করতে সাহায্য করে। এখানে ডাউনলোড করুন: $appLink';
  }

  @override
  String get openDrawerTooltip => 'ড্রয়ার খুলুন';

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
  String get pages => 'পৃষ্ঠা';

  @override
  String get note => 'নোট:';

  @override
  String get linkedAyahs => 'সংযুক্ত আয়াত:';

  @override
  String get emptyNoteCollection =>
      'এই নোট সংগ্রহটি খালি।\nএখানে দেখার জন্য কিছু নোট যোগ করুন।';

  @override
  String get emptyPinnedCollection =>
      'এখনও কোনো আয়াত এই সংগ্রহে পিন করা হয়নি।\nএখানে দেখার জন্য আয়াত পিন করুন।';

  @override
  String get noContentAvailable => 'কোনো কনটেন্ট উপলব্ধ নেই।';

  @override
  String failedToLoadCollections(String error) {
    return 'সংগ্রহ লোড করতে ব্যর্থ: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType এর নাম দিয়ে খুঁজুন...';
  }

  @override
  String get sortBy => 'সাজান';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'এখনও কোনো $collectionType যোগ করা হয়নি';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count টি পিন করা আইটেম';
  }

  @override
  String notesCount(int count) {
    return '$count টি নোট';
  }

  @override
  String get emptyNameNotAllowed => 'খালি নাম অনুমোদিত নয়';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName এ আপডেট করা হয়েছে';
  }

  @override
  String get changeName => 'নাম পরিবর্তন করুন';

  @override
  String get changeColor => 'রঙ পরিবর্তন করুন';

  @override
  String get colorUpdated => 'রঙ আপডেট করা হয়েছে';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName মুছে ফেলা হয়েছে';
  }

  @override
  String get delete => 'মুছে ফেলুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get collectionNameCannotBeEmpty => 'সংগ্রহের নাম খালি রাখা যাবে না।';

  @override
  String get addedNewCollection => 'নতুন সংগ্রহ যোগ করা হয়েছে';

  @override
  String ayahCount(int count) {
    return '$count টি আয়াত';
  }

  @override
  String get byNameAtoZ => 'নাম A-Z';

  @override
  String get byNameZtoA => 'নাম Z-A';

  @override
  String get byElementNumberAscending => 'উপাদানের সংখ্যা (ছোট থেকে বড়)';

  @override
  String get byElementNumberDescending => 'উপাদানের সংখ্যা (বড় থেকে ছোট)';

  @override
  String get byUpdateDateAscending => 'আপডেটের তারিখ (পুরানো থেকে নতুন)';

  @override
  String get byUpdateDateDescending => 'আপডেটের তারিখ (নতুন থেকে পুরানো)';

  @override
  String get byCreateDateAscending => 'তৈরির তারিখ (পুরানো থেকে নতুন)';

  @override
  String get byCreateDateDescending => 'তৈরির তারিখ (নতুন থেকে পুরানো)';

  @override
  String get translationNotFound => 'অনুবাদ পাওয়া যায়নি';

  @override
  String get translationTitle => 'অনুবাদ:';

  @override
  String get footNoteTitle => 'পাদটীকা:';

  @override
  String get wordByWordTranslation => 'শব্দে শব্দে অনুবাদ:';

  @override
  String get tafsirButton => 'তাফসির';

  @override
  String get shareButton => 'শেয়ার';

  @override
  String get addNoteButton => 'নোট যোগ করুন';

  @override
  String get pinToCollectionButton => 'সংগ্রহে পিন করুন';

  @override
  String get shareAsText => 'টেক্সট হিসেবে শেয়ার করুন';

  @override
  String get copiedWithTafsir => 'তাফসির সহ কপি করা হয়েছে';

  @override
  String get shareAsImage => 'ছবি হিসেবে শেয়ার করুন';

  @override
  String get shareWithTafsir => 'তাফসির সহ শেয়ার করুন';

  @override
  String get notFound => 'পাওয়া যায়নি';

  @override
  String get noteContentCannotBeEmpty => 'নোটের বিষয়বস্তু খালি রাখা যাবে না।';

  @override
  String get noteSavedSuccessfully => 'নোট সফলভাবে সংরক্ষণ করা হয়েছে!';

  @override
  String get selectCollections => 'সংগ্রহ নির্বাচন করুন';

  @override
  String get addNote => 'নোট যোগ করুন';

  @override
  String get writeCollectionName => 'সংগ্রহের নাম লিখুন...';

  @override
  String get noCollectionsYetAddANewOne =>
      'এখনও কোনো সংগ্রহ নেই। একটি নতুন যোগ করুন!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'অনুগ্রহ করে প্রথমে আপনার নোটটি লিখুন।';

  @override
  String get noCollectionSelected => 'কোনো সংগ্রহ নির্বাচন করা হয়নি';

  @override
  String get saveNote => 'নোট সংরক্ষণ করুন';

  @override
  String get nextSelectCollections => 'পরবর্তী: সংগ্রহ নির্বাচন করুন';

  @override
  String get addToPinned => 'পিন করুন';

  @override
  String get pinnedSavedSuccessfully => 'পিন সফলভাবে সংরক্ষণ করা হয়েছে!';

  @override
  String get savePinned => 'পিন সংরক্ষণ করুন';

  @override
  String get closeAudioController => 'অডিও কন্ট্রোলার বন্ধ করুন';

  @override
  String get previous => 'পূর্ববর্তী';

  @override
  String get rewind => 'রিওয়াইন্ড';

  @override
  String get fastForward => 'ফাস্ট ফরোয়ার্ড';

  @override
  String get playNextAyah => 'পরবর্তী আয়াত চালান';

  @override
  String get repeat => 'পুনরাবৃত্তি';

  @override
  String get playAsPlaylist => 'প্লেলিস্ট হিসেবে চালান';

  @override
  String style(String style) {
    return 'শৈলী: $style';
  }

  @override
  String get stopAndClose => 'থামান ও বন্ধ করুন';

  @override
  String get play => 'চালান';

  @override
  String get pause => 'বিরতি';

  @override
  String get selectReciter => 'কারী নির্বাচন করুন';

  @override
  String source(String source) {
    return 'উৎস: $source';
  }

  @override
  String get newText => 'নতুন';

  @override
  String get more => 'আরও: ';

  @override
  String get cacheNotFound => 'ক্যাশ খুঁজে পাওয়া যায়নি';

  @override
  String get cacheSize => 'ক্যাশের আকার';

  @override
  String error(String error) {
    return 'ত্রুটি: $error';
  }

  @override
  String get clean => 'পরিষ্কার করুন';

  @override
  String get lastModified => 'সর্বশেষ পরিবর্তিত';

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
    return '$hour ঘন্টা আগে';
  }

  @override
  String get aboutAlQuran => 'আল কুরআন সম্পর্কে';

  @override
  String get appFullName => 'আল কুরআন (তাফসির, নামাজ, কিবলা, অডিও)';

  @override
  String get appDescription =>
      'অ্যান্ড্রয়েড, আইওএস, ম্যাকওএস, ওয়েব, লিনাক্স এবং উইন্ডোজের জন্য একটি পূর্ণাঙ্গ ইসলামিক অ্যাপ্লিকেশন, যা তাফসির এবং একাধিক অনুবাদসহ (শব্দে-শব্দে সহ) কুরআন পড়ার সুবিধা, নোটিফিকেশনসহ বিশ্বব্যাপী নামাজের সময়, কিবলা কম্পাস এবং শব্দে-শব্দে অডিও তিলাওয়াত শোনার সুযোগ দেয়।';

  @override
  String get dataSourcesNote =>
      'দ্রষ্টব্য: কুরআনের টেক্সট, তাফসির, অনুবাদ এবং অডিও রিসোর্সগুলো Quran.com, Everyayah.com এবং অন্যান্য যাচাইকৃত উন্মুক্ত উৎস থেকে সংগ্রহ করা হয়েছে।';

  @override
  String get adFreePromise =>
      'এই অ্যাপটি আল্লাহর সন্তুষ্টি অর্জনের জন্য তৈরি করা হয়েছে। অতএব, এটি বিজ্ঞাপন-মুক্ত এবং সর্বদা তাই থাকবে।';

  @override
  String get coreFeatures => 'প্রধান বৈশিষ্ট্য';

  @override
  String get coreFeaturesDescription =>
      'আল কুরআন v3-কে আপনার দৈনন্দিন ইসলামিক অনুশীলনের জন্য একটি অপরিহার্য হাতিয়ার করে তুলেছে এমন মূল কার্যকারিতাগুলো অন্বেষণ করুন:';

  @override
  String get prayerTimesTitle => 'নামাজের সময় ও সতর্কতা';

  @override
  String get prayerTimesDescription =>
      'বিভিন্ন গণনা পদ্ধতি ব্যবহার করে বিশ্বব্যাপী যেকোনো অবস্থানের জন্য সঠিক নামাজের সময়। আযানের নোটিফিকেশনসহ রিমাইন্ডার সেট করুন।';

  @override
  String get qiblaDirectionTitle => 'কিবলার দিক';

  @override
  String get qiblaDirectionDescription =>
      'একটি স্পষ্ট এবং সঠিক কম্পাসের মাধ্যমে সহজেই কিবলার দিক নির্ণয় করুন।';

  @override
  String get translationTafsirTitle => 'কুরআনের অনুবাদ ও তাফসির';

  @override
  String get translationTafsirDescription =>
      '৬৯টি ভাষায় ১২০টিরও বেশি অনুবাদের বই (শব্দে-শব্দে সহ) এবং ৩০টিরও বেশি তাফসিরের বই অ্যাক্সেস করুন।';

  @override
  String get wordByWordAudioTitle => 'শব্দে শব্দে অডিও ও হাইলাইটিং';

  @override
  String get wordByWordAudioDescription =>
      'একটি গভীর শেখার অভিজ্ঞতার জন্য সিঙ্ক্রোনাইজড শব্দ-ভিত্তিক অডিও তিলাওয়াত এবং হাইলাইটিং অনুসরণ করুন।';

  @override
  String get ayahAudioRecitationTitle => 'আয়াতের অডিও তিলাওয়াত';

  @override
  String get ayahAudioRecitationDescription =>
      '৪০ জনেরও বেশি প্রখ্যাত কারীর সম্পূর্ণ আয়াত তিলাওয়াত শুনুন।';

  @override
  String get notesCloudBackupTitle => 'ক্লাউড ব্যাকআপ সহ নোট';

  @override
  String get notesCloudBackupDescription =>
      'ব্যক্তিগত নোট এবং চিন্তাভাবনা সংরক্ষণ করুন, যা ক্লাউডে নিরাপদে ব্যাক আপ করা হবে (ফিচারটি নির্মাণাধীন/শীঘ্রই আসছে)।';

  @override
  String get crossPlatformSupportTitle => 'ক্রস-প্ল্যাটফর্ম সাপোর্ট';

  @override
  String get crossPlatformSupportDescription =>
      'অ্যান্ড্রয়েড, ওয়েব, লিনাক্স এবং উইন্ডোজে সমর্থিত।';

  @override
  String get backgroundAudioPlaybackTitle => 'ব্যাকগ্রাউন্ডে অডিও প্লেব্যাক';

  @override
  String get backgroundAudioPlaybackDescription =>
      'অ্যাপটি ব্যাকগ্রাউন্ডে থাকলেও কুরআন তিলাওয়াত শোনা চালিয়ে যান।';

  @override
  String get audioDataCachingTitle => 'অডিও ও ডেটা ক্যাশিং';

  @override
  String get audioDataCachingDescription =>
      'শক্তিশালী অডিও এবং কুরআন ডেটা ক্যাশিংয়ের মাধ্যমে উন্নত প্লেব্যাক এবং অফলাইন ব্যবহারের সুবিধা।';

  @override
  String get minimalisticInterfaceTitle => 'নান্দনিক ও পরিচ্ছন্ন ইন্টারফেস';

  @override
  String get minimalisticInterfaceDescription =>
      'ব্যবহারকারীর অভিজ্ঞতা এবং পঠনযোগ্যতার উপর দৃষ্টি নিবদ্ধ করে সহজে ব্যবহারযোগ্য ইন্টারফেস।';

  @override
  String get optimizedPerformanceTitle => 'অপ্টিমাইজড পারফরম্যান্স ও আকার';

  @override
  String get optimizedPerformanceDescription =>
      'একটি ফিচার-সমৃদ্ধ অ্যাপ্লিকেশন যা হালকা এবং দ্রুতগতিসম্পন্ন হওয়ার জন্য ডিজাইন করা হয়েছে।';

  @override
  String get languageSupport => 'ভাষা সমর্থন';

  @override
  String get languageSupportDescription =>
      'এই অ্যাপ্লিকেশনটি বিশ্বব্যাপী দর্শকদের জন্য তৈরি করা হয়েছে এবং নিম্নলিখিত ভাষাগুলিকে সমর্থন করে (এবং আরও ভাষা ক্রমাগত যোগ করা হচ্ছে):';

  @override
  String get technologyAndResources => 'প্রযুক্তি ও রিসোর্স';

  @override
  String get technologyAndResourcesDescription =>
      'এই অ্যাপটি অত্যাধুনিক প্রযুক্তি এবং নির্ভরযোগ্য রিসোর্স ব্যবহার করে তৈরি করা হয়েছে:';

  @override
  String get flutterFrameworkTitle => 'ফ্লাটার ফ্রেমওয়ার্ক';

  @override
  String get flutterFrameworkDescription =>
      'একটি একক কোডবেস থেকে সুন্দর, নেটিভলি কম্পাইল করা, মাল্টি-প্ল্যাটফর্ম অভিজ্ঞতার জন্য ফ্লাটার দিয়ে তৈরি।';

  @override
  String get advancedAudioEngineTitle => 'উন্নত অডিও ইঞ্জিন';

  @override
  String get advancedAudioEngineDescription =>
      'শক্তিশালী অডিও প্লেব্যাক এবং নিয়ন্ত্রণের জন্য `just_audio` এবং `just_audio_background` ফ্লাটার প্যাকেজ দ্বারা চালিত।';

  @override
  String get reliableQuranDataTitle => 'নির্ভরযোগ্য কুরআন ডেটা';

  @override
  String get reliableQuranDataDescription =>
      'আল কুরআনের টেক্সট, অনুবাদ, তাফসির এবং অডিও Quran.com ও Everyayah.com-এর মতো যাচাইকৃত উন্মুক্ত এপিআই এবং ডেটাবেস থেকে সংগ্রহ করা হয়েছে।';

  @override
  String get prayerTimeEngineTitle => 'নামাজের সময় ইঞ্জিন';

  @override
  String get prayerTimeEngineDescription =>
      'সঠিক নামাজের সময়ের জন্য প্রতিষ্ঠিত গণনা পদ্ধতি ব্যবহার করে। নোটিফিকেশন `flutter_local_notifications` এবং ব্যাকগ্রাউন্ড টাস্ক দ্বারা পরিচালিত হয়।';

  @override
  String get crossPlatformSupport => 'ক্রস প্ল্যাটফর্ম সাপোর্ট';

  @override
  String get crossPlatformSupportDescription2 =>
      'বিভিন্ন প্ল্যাটফর্মে নির্বিঘ্ন অ্যাক্সেস উপভোগ করুন:';

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
  String get ourLifetimePromise => 'আমাদের আজীবনের প্রতিশ্রুতি';

  @override
  String get lifetimePromiseDescription =>
      'আমি ব্যক্তিগতভাবে আমার সারাজীবন এই অ্যাপ্লিকেশনটির জন্য ক্রমাগত সমর্থন এবং রক্ষণাবেক্ষণ প্রদানের প্রতিশ্রুতি দিচ্ছি, ইনশাআল্লাহ। আমার লক্ষ্য হলো এই অ্যাপটি যাতে আগামী বছরগুলিতে উম্মাহর জন্য একটি উপকারী সম্পদ হিসেবে থাকে তা নিশ্চিত করে।';

  @override
  String get fajr => 'ফজর';

  @override
  String get sunrise => 'সূর্যোদয়';

  @override
  String get dhuhr => 'যোহর';

  @override
  String get asr => 'আসর';

  @override
  String get maghrib => 'মাগরিব';

  @override
  String get isha => 'ইশা';

  @override
  String get midnight => 'মধ্যরাত';

  @override
  String get alarm => 'অ্যালার্ম';

  @override
  String get notification => 'বিজ্ঞপ্তি';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'তাজবীদ';

  @override
  String get quranScriptUthmani => 'উসমানী';

  @override
  String get quranScriptIndopak => 'ইন্দোপাক';

  @override
  String get sajdaAyah => 'সিজদা আয়াত';

  @override
  String get required => 'আবশ্যক';

  @override
  String get optional => 'ঐচ্ছিক';

  @override
  String get notificationScheduleWarning =>
      'দ্রষ্টব্য: আপনার ফোনের ওএস ব্যাকগ্রাউন্ড প্রসেস সীমাবদ্ধতার কারণে নির্ধারিত বিজ্ঞপ্তি বা অনুস্মারক মিস হতে পারে। উদাহরণস্বরূপ: Vivo-এর Origin OS, Samsung-এর One UI, Oppo-এর ColorOS ইত্যাদি কখনও কখনও নির্ধারিত বিজ্ঞপ্তি বা অনুস্মারক বন্ধ করে দেয়। অ্যাপটিকে ব্যাকগ্রাউন্ড প্রসেস থেকে সীমাবদ্ধ না করার জন্য অনুগ্রহ করে আপনার ওএস সেটিংস পরীক্ষা করুন।';

  @override
  String get scrollWithRecitation => 'তিলাওয়াতের সাথে স্ক্রোল করুন';

  @override
  String get quickAccess => 'দ্রুত অ্যাক্সেস';

  @override
  String get initiallyScrollAyah => 'প্রাথমিকভাবে আয়াতে স্ক্রোল করুন';

  @override
  String get tajweedGuide => 'তাজবীদ গাইড';

  @override
  String get scrollWithRecitationDesc =>
      'সক্ষম করা হলে, কুরআনের আয়াতটি অডিও تلاوتের সাথে সিঙ্কে স্বয়ংক্রিয়ভাবে স্ক্রোল হবে।';

  @override
  String get configuration => 'কনফিগারেশন';

  @override
  String get restoreFromBackup => 'ব্যাকআপ থেকে পুনরুদ্ধার করুন';

  @override
  String get history => 'ইতিহাস';

  @override
  String get search => 'অনুসন্ধান করুন';

  @override
  String get useAudioStream => 'অডিও স্ট্রিম ব্যবহার করুন';

  @override
  String get useAudioStreamDesc =>
      'ডাউনলোড করার পরিবর্তে সরাসরি ইন্টারনেট থেকে অডিও স্ট্রিম করুন।';

  @override
  String get notUseAudioStreamDesc =>
      'অফলাইন ব্যবহারের জন্য অডিও ডাউনলোড করুন এবং ডেটা খরচ কমান।';

  @override
  String get audioSettings => 'অডিও সেটিংস';

  @override
  String get playbackSpeed => 'প্লেব্যাক গতি';

  @override
  String get playbackSpeedDesc => 'কুরআন তেলাওয়াতের গতি সামঞ্জস্য করুন।';

  @override
  String get waitForCurrentDownloadToFinish =>
      'বর্তমান ডাউনলোড শেষ হওয়ার জন্য অনুগ্রহ করে অপেক্ষা করুন।';

  @override
  String get areYouSure => 'আপনি কি নিশ্চিত?';

  @override
  String get checkYourInternetConnection =>
      'আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount আয়াতের মধ্যে $requiredDownload টি ডাউনলোড করতে হবে।';
  }

  @override
  String get download => 'ডাউনলোড';

  @override
  String get audioDownload => 'অডিও ডাউনলোড';
}
