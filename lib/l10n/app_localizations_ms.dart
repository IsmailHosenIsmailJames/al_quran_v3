// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

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
    return 'Tafsir tidak tersedia untuk $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsir boleh didapati di: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Lompat ke $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz\'';

  @override
  String get page => 'Muka Surat';

  @override
  String get ruku => 'Ruku\'';

  @override
  String get languageSettings => 'Tetapan Bahasa';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayat';
  }

  @override
  String get saveAndDownload => 'Simpan dan Muat Turun';

  @override
  String get appLanguage => 'Bahasa Aplikasi';

  @override
  String get selectAppLanguage => 'Pilih bahasa aplikasi...';

  @override
  String get pleaseSelectOne => 'Sila pilih satu';

  @override
  String get quranTranslationLanguage => 'Bahasa Terjemahan Quran';

  @override
  String get selectTranslationLanguage => 'Pilih bahasa terjemahan...';

  @override
  String get quranTranslationBook => 'Buku Terjemahan Quran';

  @override
  String get selectTranslationBook => 'Pilih buku terjemahan...';

  @override
  String get quranTafsirLanguage => 'Bahasa Tafsir Quran';

  @override
  String get selectTafsirLanguage => 'Pilih bahasa tafsir...';

  @override
  String get quranTafsirBook => 'Buku Tafsir Quran';

  @override
  String get selectTafsirBook => 'Pilih buku tafsir...';

  @override
  String get quranScriptAndStyle => 'Skrip & Gaya Quran';

  @override
  String get justAMoment => 'Sekejap...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Berjaya';

  @override
  String get retry => 'Cuba Semula';

  @override
  String get unableToDownloadResources =>
      'Tidak dapat memuat turun sumber...\nSesuatu telah berlaku';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Memuat turun Bacaan Quran Bersegmen';

  @override
  String get processingSegmentedQuranRecitation =>
      'Memproses Bacaan Quran Bersegmen';

  @override
  String get footnote => 'Nota kaki';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Perkataan demi Perkataan';

  @override
  String get pleaseSelectRequiredOption => 'Sila pilih pilihan yang diperlukan';

  @override
  String get rememberHomeTab => 'Ingat Tab Utama';

  @override
  String get rememberHomeTabSubtitle =>
      'Aplikasi akan mengingati tab terakhir yang dibuka di skrin utama.';

  @override
  String get wakeLock => 'Skrin Sentiasa Hidup';

  @override
  String get wakeLockSubtitle =>
      'Elakkan skrin daripada terpadam secara automatik.';

  @override
  String get settings => 'Tetapan';

  @override
  String get appTheme => 'Tema Aplikasi';

  @override
  String get quranStyle => 'Gaya Quran';

  @override
  String get changeTheme => 'Tukar Tema';

  @override
  String get verseCount => 'Bilangan Ayat: ';

  @override
  String get translation => 'Terjemahan';

  @override
  String get tafsirNotFound => 'Tidak Ditemui';

  @override
  String get moreInfo => 'maklumat lanjut';

  @override
  String get playAudio => 'Mainkan Audio';

  @override
  String get preview => 'Pratonton';

  @override
  String get loading => 'Memuatkan...';

  @override
  String get errorFetchingAddress => 'Ralat mendapatkan alamat';

  @override
  String get addressNotAvailable => 'Alamat tidak tersedia';

  @override
  String get latitude => 'Latitud: ';

  @override
  String get longitude => 'Longitud: ';

  @override
  String get name => 'Nama: ';

  @override
  String get location => 'Lokasi: ';

  @override
  String get parameters => 'Parameter: ';

  @override
  String get selectCalculationMethod => 'Pilih Kaedah Kiraan';

  @override
  String get shareSelectAyahs => 'Kongsi Ayat Terpilih';

  @override
  String get selectionEmpty => 'Pilihan Kosong';

  @override
  String get generatingImagePleaseWait => 'Menjana Imej... Sila Tunggu';

  @override
  String get asImage => 'Sebagai Imej';

  @override
  String get asText => 'Sebagai Teks';

  @override
  String get playFromSelectedAyah => 'Main dari Ayat Terpilih';

  @override
  String get toTafsir => 'Ke Tafsir';

  @override
  String get selectAyah => 'Pilih Ayat';

  @override
  String get toAyah => 'Ke Ayat';

  @override
  String get searchForASurah => 'Cari surah';

  @override
  String get bugReportTitle => 'Laporan Pepijat';

  @override
  String get audioCached => 'Audio Dicache';

  @override
  String get others => 'Lain-lain';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Quran|Terjemahan|Ayat, Satu Mesti Diaktifkan';

  @override
  String get quranFontSize => 'Saiz Fon Quran';

  @override
  String get quranLineHeight => 'Ketinggian Baris Quran';

  @override
  String get translationAndTafsirFontSize => 'Saiz Fon Terjemahan & Tafsir';

  @override
  String get quranAyah => 'Ayat Quran';

  @override
  String get topToolbar => 'Bar Alat Atas';

  @override
  String get keepOpenWordByWord => 'Kekalkan Paparan Perkataan demi Perkataan';

  @override
  String get wordByWordHighlight => 'Serlahan Perkataan demi Perkataan';

  @override
  String get quranScriptSettings => 'Tetapan Skrip Quran';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Muka Surat: ';

  @override
  String get quranResources => 'Sumber Quran';

  @override
  String alreadySelected(String name) {
    return 'Bahasa \'$name\' telah pun dipilih.';
  }

  @override
  String get unableToGetCompassData => 'Tidak dapat memperoleh data kompas';

  @override
  String get deviceDoesNotHaveSensors => 'Peranti tidak mempunyai penderia!';

  @override
  String get north => 'U';

  @override
  String get east => 'T';

  @override
  String get south => 'S';

  @override
  String get west => 'B';

  @override
  String get address => 'Alamat: ';

  @override
  String get change => 'Tukar';

  @override
  String get calculationMethod => 'Kaedah Kiraan: ';

  @override
  String get downloadPrayerTime => 'Muat Turun Waktu Solat';

  @override
  String get calculationMethodsListEmpty =>
      'Senarai kaedah kiraan adalah kosong.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Tidak dapat mencari sebarang kaedah kiraan dengan data lokasi.';

  @override
  String get prayerSettings => 'Tetapan Solat';

  @override
  String get reminderSettings => 'Tetapan Peringatan';

  @override
  String get adjustReminderTime => 'Laraskan Masa Peringatan';

  @override
  String get enforceAlarmSound => 'Kuatkuasakan Bunyi Penggera';

  @override
  String get enforceAlarmSoundDescription =>
      'Jika diaktifkan, ciri ini akan memainkan penggera pada kelantangan yang ditetapkan di sini, walaupun bunyi telefon anda rendah. Ini memastikan anda tidak terlepas penggera disebabkan kelantangan telefon yang rendah.';

  @override
  String get volume => 'Kelantangan';

  @override
  String get atPrayerTime => 'Pada waktu solat';

  @override
  String minBefore(int minutes) {
    return '$minutes min sebelum';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min selepas';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName pada $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Sudah masuk waktu $prayerName';
  }

  @override
  String get stopTheAdhan => 'Hentikan Azan';

  @override
  String dateFoundEmpty(String date) {
    return '$date Ditemui Kosong';
  }

  @override
  String get today => 'Hari Ini';

  @override
  String get left => 'Berbaki';

  @override
  String reminderAdded(String prayerName) {
    return 'Peringatan untuk $prayerName ditambah';
  }

  @override
  String get allowNotificationPermission =>
      'Sila benarkan kebenaran pemberitahuan untuk menggunakan ciri ini';

  @override
  String reminderRemoved(String prayerName) {
    return 'Peringatan untuk $prayerName dibuang';
  }

  @override
  String get getPrayerTimesAndQibla => 'Dapatkan Waktu Solat dan Kiblat';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Kira Waktu Solat dan Kiblat untuk Sebarang Lokasi yang Diberikan.';

  @override
  String get getFromGPS => 'Dapatkan dari GPS';

  @override
  String get or => 'Atau';

  @override
  String get selectYourCity => 'Pilih Bandar anda';

  @override
  String get noteAboutGPS =>
      'Nota: Jika anda tidak mahu menggunakan GPS atau tidak berasa selamat, anda boleh memilih bandar anda.';

  @override
  String get downloadingLocationResources => 'Memuat turun sumber lokasi...';

  @override
  String get somethingWentWrong => 'Sesuatu telah berlaku';

  @override
  String get selectYourCountry => 'Pilih Negara Anda';

  @override
  String get searchForACountry => 'Cari negara';

  @override
  String get selectYourAdministrator => 'Pilih Pentadbir Anda';

  @override
  String get searchForAnAdministrator => 'Cari pentadbir';

  @override
  String get searchForACity => 'Cari bandar';

  @override
  String get pleaseEnableLocationService => 'Sila aktifkan perkhidmatan lokasi';

  @override
  String get donateUs => 'Sumbangan';

  @override
  String get underDevelopment => 'Dalam pembangunan';

  @override
  String get versionLoading => 'Memuatkan...';

  @override
  String get alQuran => 'Al-Quran';

  @override
  String get mainMenu => 'Menu Utama';

  @override
  String get notes => 'Nota';

  @override
  String get pinned => 'Disemat';

  @override
  String get jumpToAyah => 'Lompat ke Ayat';

  @override
  String get shareMultipleAyah => 'Kongsi Berbilang Ayat';

  @override
  String get shareThisApp => 'Kongsi Aplikasi Ini';

  @override
  String get giveRating => 'Beri Penilaian';

  @override
  String get bugReport => 'Laporan Pepijat';

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get aboutTheApp => 'Mengenai Aplikasi';

  @override
  String get resetTheApp => 'Set Semula Aplikasi';

  @override
  String get resetAppWarningTitle => 'Set Semula Data Aplikasi';

  @override
  String get resetAppWarningMessage =>
      'Adakah anda pasti mahu menetapkan semula aplikasi? Semua data anda akan hilang, dan anda perlu menyediakan aplikasi dari awal.';

  @override
  String get cancel => 'Batal';

  @override
  String get reset => 'Set Semula';

  @override
  String get shareAppSubject => 'Jom cuba Aplikasi Al-Quran ini!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Jom cuba aplikasi Al-Quran ini untuk bacaan dan renungan harian. Ia membantu mendekatkan diri dengan kalam Allah. Muat turun di sini: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Buka Laci';

  @override
  String get quran => 'Quran';

  @override
  String get prayer => 'Solat';

  @override
  String get qibla => 'Kiblat';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Surah';

  @override
  String get pages => 'Halaman';

  @override
  String get note => 'Nota:';

  @override
  String get linkedAyahs => 'Ayat Berkaitan:';

  @override
  String get emptyNoteCollection =>
      'Koleksi nota ini kosong.\nTambah beberapa nota untuk melihatnya di sini.';

  @override
  String get emptyPinnedCollection =>
      'Tiada Ayat yang disemat pada koleksi ini lagi.\nSematkan Ayat untuk melihatnya di sini.';

  @override
  String get noContentAvailable => 'Tiada kandungan tersedia.';

  @override
  String failedToLoadCollections(String error) {
    return 'Gagal memuatkan koleksi: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Cari Mengikut Nama $collectionType...';
  }

  @override
  String get sortBy => 'Isih ikut';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Belum ada $collectionType ditambah';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count item disemat';
  }

  @override
  String notesCount(int count) {
    return '$count nota';
  }

  @override
  String get emptyNameNotAllowed => 'Nama kosong tidak dibenarkan';

  @override
  String updatedTo(String collectionName) {
    return 'Dikemas kini kepada $collectionName';
  }

  @override
  String get changeName => 'Tukar Nama';

  @override
  String get changeColor => 'Tukar Warna';

  @override
  String get colorUpdated => 'Warna dikemas kini';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Dipadam';
  }

  @override
  String get delete => 'Padam';

  @override
  String get save => 'Simpan';

  @override
  String get collectionNameCannotBeEmpty => 'Nama koleksi tidak boleh kosong.';

  @override
  String get addedNewCollection => 'Koleksi Baharu Ditambah';

  @override
  String ayahCount(int count) {
    return '$count Ayat';
  }

  @override
  String get byNameAtoZ => 'Nama A-Z';

  @override
  String get byNameZtoA => 'Nama Z-A';

  @override
  String get byElementNumberAscending => 'Nombor Elemen Menaik';

  @override
  String get byElementNumberDescending => 'Nombor Elemen Menurun';

  @override
  String get byUpdateDateAscending => 'Tarikh Kemas Kini Menaik';

  @override
  String get byUpdateDateDescending => 'Tarikh Kemas Kini Menurun';

  @override
  String get byCreateDateAscending => 'Tarikh Dicipta Menaik';

  @override
  String get byCreateDateDescending => 'Tarikh Dicipta Menurun';

  @override
  String get translationNotFound => 'Terjemahan Tidak Ditemui';

  @override
  String get translationTitle => 'Terjemahan:';

  @override
  String get footNoteTitle => 'Nota Kaki:';

  @override
  String get wordByWordTranslation => 'Terjemahan Perkataan demi Perkataan:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Kongsi';

  @override
  String get addNoteButton => 'Tambah Nota';

  @override
  String get pinToCollectionButton => 'Pin ke Koleksi';

  @override
  String get shareAsText => 'Kongsi sebagai Teks';

  @override
  String get copiedWithTafsir => 'Disalin dengan Tafsir';

  @override
  String get shareAsImage => 'Kongsi sebagai Imej';

  @override
  String get shareWithTafsir => 'Kongsi dengan Tafsir';

  @override
  String get notFound => 'Tidak ditemui';

  @override
  String get noteContentCannotBeEmpty => 'Kandungan nota tidak boleh kosong.';

  @override
  String get noteSavedSuccessfully => 'Nota berjaya disimpan!';

  @override
  String get selectCollections => 'Pilih Koleksi';

  @override
  String get addNote => 'Tambah Nota';

  @override
  String get writeCollectionName => 'Tulis nama koleksi...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Belum ada koleksi. Tambah yang baharu!';

  @override
  String get pleaseWriteYourNoteFirst => 'Sila tulis nota anda dahulu.';

  @override
  String get noCollectionSelected => 'Tiada Koleksi dipilih';

  @override
  String get saveNote => 'Simpan Nota';

  @override
  String get nextSelectCollections => 'Seterusnya: Pilih Koleksi';

  @override
  String get addToPinned => 'Tambah ke Disemat';

  @override
  String get pinnedSavedSuccessfully => 'Semat berjaya disimpan!';

  @override
  String get savePinned => 'Simpan Sematan';

  @override
  String get closeAudioController => 'Tutup Pengawal Audio';

  @override
  String get previous => 'Sebelumnya';

  @override
  String get rewind => 'Undur';

  @override
  String get fastForward => 'Maju Cepat';

  @override
  String get playNextAyah => 'Main Ayat Seterusnya';

  @override
  String get repeat => 'Ulang';

  @override
  String get playAsPlaylist => 'Main sebagai Senarai Main';

  @override
  String style(String style) {
    return 'Gaya: $style';
  }

  @override
  String get stopAndClose => 'Henti & Tutup';

  @override
  String get play => 'Main';

  @override
  String get pause => 'Jeda';

  @override
  String get selectReciter => 'Pilih Qari';

  @override
  String source(String source) {
    return 'Sumber: $source';
  }

  @override
  String get newText => 'Baharu';

  @override
  String get more => 'Lagi: ';

  @override
  String get cacheNotFound => 'Cache Tidak Ditemui';

  @override
  String get cacheSize => 'Saiz Cache';

  @override
  String error(String error) {
    return 'Ralat: $error';
  }

  @override
  String get clean => 'Bersihkan';

  @override
  String get lastModified => 'Terakhir Diubah suai';

  @override
  String get oneYearAgo => '1 Tahun lalu';

  @override
  String monthsAgo(String number) {
    return '$number Bulan lalu';
  }

  @override
  String weeksAgo(String number) {
    return '$number Minggu lalu';
  }

  @override
  String daysAgo(String number) {
    return '$number Hari lalu';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Jam lalu';
  }

  @override
  String get aboutAlQuran => 'Mengenai Al-Quran';

  @override
  String get appFullName => 'Al-Quran (Tafsir, Solat, Kiblat, Audio)';

  @override
  String get appDescription =>
      'Aplikasi Islamik yang komprehensif untuk Android, iOS, MacOS, Web, Linux dan Windows, menawarkan bacaan Al-Quran dengan Tafsir & pelbagai terjemahan (termasuk perkataan demi perkataan), waktu solat seluruh dunia dengan pemberitahuan, kompas Kiblat, dan bacaan audio perkataan demi perkataan yang disegerakkan.';

  @override
  String get dataSourcesNote =>
      'Nota: Teks Al-Quran, Tafsir, terjemahan, dan sumber audio diperoleh daripada Quran.com, Everyayah.com, dan sumber terbuka lain yang disahkan.';

  @override
  String get adFreePromise =>
      'Aplikasi ini dibina untuk mencari keredhaan Allah. Oleh itu, ia adalah dan akan sentiasa bebas Iklan sepenuhnya.';

  @override
  String get coreFeatures => 'Ciri-ciri Teras';

  @override
  String get coreFeaturesDescription =>
      'Terokai fungsi-fungsi utama yang menjadikan Al-Quran v3 sebagai alat yang amat diperlukan untuk amalan Islam harian anda:';

  @override
  String get prayerTimesTitle => 'Waktu Solat & Peringatan';

  @override
  String get prayerTimesDescription =>
      'Waktu solat yang tepat untuk sebarang lokasi di seluruh dunia menggunakan pelbagai kaedah pengiraan. Tetapkan peringatan dengan pemberitahuan Azan.';

  @override
  String get qiblaDirectionTitle => 'Arah Kiblat';

  @override
  String get qiblaDirectionDescription =>
      'Cari arah Kiblat dengan mudah melalui paparan kompas yang jelas dan tepat.';

  @override
  String get translationTafsirTitle => 'Terjemahan & Tafsir Al-Quran';

  @override
  String get translationTafsirDescription =>
      'Akses 120+ buku terjemahan (termasuk perkataan demi perkataan) dalam 69 bahasa, dan 30+ buku Tafsir.';

  @override
  String get wordByWordAudioTitle =>
      'Audio & Serlahan Perkataan demi Perkataan';

  @override
  String get wordByWordAudioDescription =>
      'Ikuti bacaan audio perkataan demi perkataan yang disegerakkan dan diserlahkan untuk pengalaman pembelajaran yang mendalam.';

  @override
  String get ayahAudioRecitationTitle => 'Bacaan Audio Ayat';

  @override
  String get ayahAudioRecitationDescription =>
      'Dengarkan bacaan ayat penuh daripada lebih 40+ qari terkenal.';

  @override
  String get notesCloudBackupTitle => 'Nota dengan Sandaran Awan';

  @override
  String get notesCloudBackupDescription =>
      'Simpan nota peribadi dan renungan, disandarkan dengan selamat ke awan (ciri dalam pembangunan/akan datang).';

  @override
  String get crossPlatformSupportTitle => 'Sokongan Pelbagai Platform';

  @override
  String get crossPlatformSupportDescription =>
      'Disokong pada Android, Web, Linux, dan Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Main Audio Latar Belakang';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Teruskan mendengar bacaan Al-Quran walaupun aplikasi berada di latar belakang.';

  @override
  String get audioDataCachingTitle => 'Caching Audio & Data';

  @override
  String get audioDataCachingDescription =>
      'Keupayaan main balik dan luar talian yang lebih baik dengan caching data audio dan Al-Quran yang mantap.';

  @override
  String get minimalisticInterfaceTitle => 'Antara Muka Minimalis & Bersih';

  @override
  String get minimalisticInterfaceDescription =>
      'Antara muka yang mudah dinavigasi dengan tumpuan kepada pengalaman pengguna dan kebolehbacaan.';

  @override
  String get optimizedPerformanceTitle => 'Prestasi & Saiz yang Dioptimumkan';

  @override
  String get optimizedPerformanceDescription =>
      'Aplikasi yang kaya dengan ciri-ciri direka untuk menjadi ringan dan berprestasi tinggi.';

  @override
  String get languageSupport => 'Sokongan Bahasa';

  @override
  String get languageSupportDescription =>
      'Aplikasi ini direka bentuk untuk boleh diakses oleh audiens global dengan sokongan untuk bahasa-bahasa berikut (dan lebih banyak lagi akan ditambah secara berterusan):';

  @override
  String get technologyAndResources => 'Teknologi & Sumber';

  @override
  String get technologyAndResourcesDescription =>
      'Aplikasi ini dibina menggunakan teknologi terkini dan sumber yang boleh dipercayai:';

  @override
  String get flutterFrameworkTitle => 'Rangka Kerja Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Dibina dengan Flutter untuk pengalaman berbilang platform yang cantik dan dikompil secara asli dari satu pangkalan kod.';

  @override
  String get advancedAudioEngineTitle => 'Enjin Audio Termaju';

  @override
  String get advancedAudioEngineDescription =>
      'Dikuasakan oleh pakej Flutter `just_audio` dan `just_audio_background` untuk main balik dan kawalan audio yang mantap.';

  @override
  String get reliableQuranDataTitle => 'Data Al-Quran yang Boleh Dipercayai';

  @override
  String get reliableQuranDataDescription =>
      'Teks, terjemahan, tafsir, dan audio Al-Quran diperoleh daripada API terbuka dan pangkalan data yang disahkan seperti Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Enjin Waktu Solat';

  @override
  String get prayerTimeEngineDescription =>
      'Menggunakan kaedah pengiraan yang mantap untuk waktu solat yang tepat. Pemberitahuan dikendalikan oleh `flutter_local_notifications` dan tugas latar belakang.';

  @override
  String get crossPlatformSupport => 'Sokongan Pelbagai Platform';

  @override
  String get crossPlatformSupportDescription2 =>
      'Nikmati akses lancar merentasi pelbagai platform:';

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
  String get ourLifetimePromise => 'Janji Seumur Hidup Kami';

  @override
  String get lifetimePromiseDescription =>
      'Saya secara peribadi berjanji untuk memberikan sokongan dan penyelenggaraan berterusan untuk aplikasi ini sepanjang hayat saya, Insya-Allah. Matlamat saya adalah untuk memastikan aplikasi ini kekal sebagai sumber yang bermanfaat untuk Ummah untuk tahun-tahun mendatang.';

  @override
  String get fajr => 'Subuh';

  @override
  String get sunrise => 'Syuruk';

  @override
  String get dhuhr => 'Zohor';

  @override
  String get asr => 'Asar';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isyak';

  @override
  String get midnight => 'Tengah Malam';

  @override
  String get alarm => 'Penggera';

  @override
  String get notification => 'Pemberitahuan';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tajwid';

  @override
  String get quranScriptUthmani => 'Uthmani';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Ayat Sajdah';

  @override
  String get required => 'Wajib';

  @override
  String get optional => 'Sunat';

  @override
  String get notificationScheduleWarning =>
      'Nota: Pemberitahuan atau Peringatan yang dijadualkan mungkin terlepas kerana sekatan proses latar belakang OS telefon anda. Contohnya: Origin OS Vivo, One UI Samsung, ColorOS Oppo dll kadangkala mematikan Pemberitahuan atau Peringatan yang dijadualkan. Sila semak tetapan OS anda untuk memastikan apl tidak disekat daripada proses latar belakang.';

  @override
  String get scrollWithRecitation => 'Tatal dengan Bacaan';

  @override
  String get quickAccess => 'Akses Pantas';

  @override
  String get initiallyScrollAyah => 'Tatal pada mulanya ke ayah';

  @override
  String get tajweedGuide => 'Panduan Tajwid';
}
