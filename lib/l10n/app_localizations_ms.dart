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
  String get juz => 'Juz';

  @override
  String get page => 'Halaman';

  @override
  String get ruku => 'Ruku';

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
  String get quranTranslationLanguage => 'Bahasa Terjemahan Al-Quran';

  @override
  String get selectTranslationLanguage => 'Pilih bahasa terjemahan...';

  @override
  String get quranTranslationBook => 'Buku Terjemahan Al-Quran';

  @override
  String get selectTranslationBook => 'Pilih buku terjemahan...';

  @override
  String get quranTafsirLanguage => 'Bahasa Tafsir Al-Quran';

  @override
  String get selectTafsirLanguage => 'Pilih bahasa tafsir...';

  @override
  String get quranTafsirBook => 'Buku Tafsir Al-Quran';

  @override
  String get selectTafsirBook => 'Pilih buku tafsir...';

  @override
  String get quranScriptAndStyle => 'Skrip & Gaya Al-Quran';

  @override
  String get justAMoment => 'Sebentar sahaja...';

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
      'Tidak dapat muat turun sumber...\nSesuatu tidak kena';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Muat Turun Bacaan Al-Quran Bersegmen';

  @override
  String get processingSegmentedQuranRecitation =>
      'Memproses Bacaan Al-Quran Bersegmen';

  @override
  String get footnote => 'Catatan Kaki';

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
      'Aplikasi akan ingat tab terakhir yang dibuka di skrin utama.';

  @override
  String get wakeLock => 'Kunci Bangun';

  @override
  String get wakeLockSubtitle => 'Cegah skrin mati secara automatik.';

  @override
  String get settings => 'Tetapan';

  @override
  String get appTheme => 'Tema Aplikasi';

  @override
  String get quranStyle => 'Gaya Al-Quran';

  @override
  String get changeTheme => 'Tukar Tema';

  @override
  String get verseCount => 'Bilangan Ayat: ';

  @override
  String get translation => 'Terjemahan';

  @override
  String get tafsirNotFound => 'Tidak Dijumpai';

  @override
  String get moreInfo => 'maklumat lanjut';

  @override
  String get playAudio => 'Main Audio';

  @override
  String get preview => 'Pratonton';

  @override
  String get loading => 'Sedang Memuat...';

  @override
  String get errorFetchingAddress => 'Ralat mengambil alamat';

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
  String get selectCalculationMethod => 'Pilih Kaedah Pengiraan';

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
  String get playFromSelectedAyah => 'Main Dari Ayat Terpilih';

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
  String get audioCached => 'Audio Dikache';

  @override
  String get others => 'Lain-lain';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Al-Quran|Terjemahan|Ayat, Satu Mesti Diaktifkan';

  @override
  String get quranFontSize => 'Saiz Fon Al-Quran';

  @override
  String get quranLineHeight => 'Ketinggian Baris Al-Quran';

  @override
  String get translationAndTafsirFontSize => 'Saiz Fon Terjemahan & Tafsir';

  @override
  String get quranAyah => 'Ayat Al-Quran';

  @override
  String get topToolbar => 'Bar Alat Atas';

  @override
  String get keepOpenWordByWord => 'Biarkan Terbuka Perkataan demi Perkataan';

  @override
  String get wordByWordHighlight => 'Sorotan Perkataan demi Perkataan';

  @override
  String get quranScriptSettings => 'Tetapan Skrip Al-Quran';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Halaman: ';

  @override
  String get quranResources => 'Sumber Al-Quran';

  @override
  String alreadySelected(String name) {
    return 'Bahasa \'$name\' sudah dipilih.';
  }

  @override
  String get unableToGetCompassData => 'Tidak dapat mendapatkan data kompas';

  @override
  String get deviceDoesNotHaveSensors => 'Peranti tidak mempunyai sensor!';

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
  String get calculationMethod => 'Kaedah Pengiraan: ';

  @override
  String get downloadPrayerTime => 'Muat Turun Waktu Solat';

  @override
  String get calculationMethodsListEmpty => 'Senarai kaedah pengiraan kosong.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Tidak dapat mencari kaedah pengiraan dengan data lokasi.';

  @override
  String get prayerSettings => 'Tetapan Solat';

  @override
  String get reminderSettings => 'Tetapan Peringatan';

  @override
  String get adjustReminderTime => 'Laraskan Masa Peringatan';

  @override
  String get enforceAlarmSound => 'Paksa Bunyi Penggera';

  @override
  String get enforceAlarmSoundDescription =>
      'Jika diaktifkan, ciri ini akan mainkan penggera pada kelantangan yang ditetapkan di sini, walaupun bunyi telefon anda rendah. Ini memastikan anda tidak terlepas penggera kerana kelantangan telefon rendah.';

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
    return 'Masa untuk $prayerName';
  }

  @override
  String get stopTheAdhan => 'Hentikan Azan';

  @override
  String dateFoundEmpty(String date) {
    return '$date Dijumpai Kosong';
  }

  @override
  String get today => 'Hari Ini';

  @override
  String get left => 'Baki';

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
      'Kira Waktu Solat dan Kiblat untuk Mana-mana Lokasi.';

  @override
  String get getFromGPS => 'Dapatkan dari GPS';

  @override
  String get or => 'Atau';

  @override
  String get selectYourCity => 'Pilih Bandar Anda';

  @override
  String get noteAboutGPS =>
      'Nota: Jika anda tidak mahu gunakan GPS atau tidak rasa selamat, anda boleh pilih bandar anda.';

  @override
  String get downloadingLocationResources => 'Muat turun sumber lokasi...';

  @override
  String get somethingWentWrong => 'Sesuatu tidak kena';

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
  String get donateUs => 'Dermakan Kepada Kami';

  @override
  String get underDevelopment => 'Sedang Dibangunkan';

  @override
  String get versionLoading => 'Sedang Memuat...';

  @override
  String get alQuran => 'Al-Quran';

  @override
  String get mainMenu => 'Menu Utama';

  @override
  String get notes => 'Nota';

  @override
  String get pinned => 'Dipinkan';

  @override
  String get jumpToAyah => 'Lompat ke Ayat';

  @override
  String get shareMultipleAyah => 'Kongsi Beberapa Ayat';

  @override
  String get shareThisApp => 'Kongsi Aplikasi Ini';

  @override
  String get giveRating => 'Beri Penilaian';

  @override
  String get bugReport => 'Laporan Pepijat';

  @override
  String get privacyPolicy => 'Dasar Privasi';

  @override
  String get aboutTheApp => 'Tentang Aplikasi';

  @override
  String get resetTheApp => 'Tetapkan Semula Aplikasi';

  @override
  String get resetAppWarningTitle => 'Tetapkan Semula Data Aplikasi';

  @override
  String get resetAppWarningMessage =>
      'Adakah anda pasti mahu tetapkan semula aplikasi? Semua data anda akan hilang, dan anda perlu tetapkan aplikasi dari awal.';

  @override
  String get cancel => 'Batal';

  @override
  String get reset => 'Tetapkan Semula';

  @override
  String get shareAppSubject => 'Lihat Aplikasi Al-Quran Ini!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Lihat aplikasi Al-Quran ini untuk bacaan dan renungan harian. Ia membantu hubung dengan kalam Allah. Muat turun di sini: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Buka Laci';

  @override
  String get quran => 'Al-Quran';

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
      'Koleksi nota ini kosong.\nTambah nota untuk lihat di sini.';

  @override
  String get emptyPinnedCollection =>
      'Tiada ayat dipinkan ke koleksi ini lagi.\nPinkan ayat untuk lihat di sini.';

  @override
  String get noContentAvailable => 'Tiada kandungan tersedia.';

  @override
  String failedToLoadCollections(String error) {
    return 'Gagal muat koleksi: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Cari Mengikut Nama $collectionType...';
  }

  @override
  String get sortBy => 'Susun mengikut';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Tiada $collectionType ditambah lagi';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count item dipinkan';
  }

  @override
  String notesCount(int count) {
    return '$count nota';
  }

  @override
  String get emptyNameNotAllowed => 'Nama kosong tidak dibenarkan';

  @override
  String updatedTo(String collectionName) {
    return 'Dikemas kini ke $collectionName';
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
  String get addedNewCollection => 'Tambah Koleksi Baru';

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
  String get byCreateDateAscending => 'Tarikh Cipta Menaik';

  @override
  String get byCreateDateDescending => 'Tarikh Cipta Menurun';

  @override
  String get translationNotFound => 'Terjemahan Tidak Dijumpai';

  @override
  String get translationTitle => 'Terjemahan:';

  @override
  String get footNoteTitle => 'Catatan Kaki:';

  @override
  String get wordByWordTranslation => 'Terjemahan Perkataan demi Perkataan:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Kongsi';

  @override
  String get addNoteButton => 'Tambah Nota';

  @override
  String get pinToCollectionButton => 'Pinkan ke Koleksi';

  @override
  String get shareAsText => 'Kongsi sebagai Teks';

  @override
  String get copiedWithTafsir => 'Disalin dengan Tafsir';

  @override
  String get shareAsImage => 'Kongsi sebagai Imej';

  @override
  String get shareWithTafsir => 'Kongsi dengan Tafsir';

  @override
  String get notFound => 'Tidak dijumpai';

  @override
  String get noteContentCannotBeEmpty => 'Kandungan nota tidak boleh kosong.';

  @override
  String get noteSavedSuccessfully => 'Nota disimpan berjaya!';

  @override
  String get selectCollections => 'Pilih Koleksi';

  @override
  String get addNote => 'Tambah Nota';

  @override
  String get writeCollectionName => 'Tulis nama koleksi...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Tiada koleksi lagi. Tambah yang baru!';

  @override
  String get pleaseWriteYourNoteFirst => 'Sila tulis nota anda dulu.';

  @override
  String get noCollectionSelected => 'Tiada Koleksi dipilih';

  @override
  String get saveNote => 'Simpan Nota';

  @override
  String get nextSelectCollections => 'Seterusnya: Pilih Koleksi';

  @override
  String get addToPinned => 'Tambah Ke Dipinkan';

  @override
  String get pinnedSavedSuccessfully => 'Dipinkan disimpan berjaya!';

  @override
  String get savePinned => 'Simpan Dipinkan';

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
  String get playAsPlaylist => 'Main Sebagai Senarai Main';

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
  String get selectReciter => 'Pilih Pembaca';

  @override
  String source(String source) {
    return 'Sumber: $source';
  }

  @override
  String get newText => 'Baru';

  @override
  String get more => 'Lebih: ';

  @override
  String get cacheNotFound => 'Cache Tidak Dijumpai';

  @override
  String get cacheSize => 'Saiz Cache';

  @override
  String error(String error) {
    return 'Ralat: $error';
  }

  @override
  String get clean => 'Bersih';

  @override
  String get lastModified => 'Terakhir Diubah';

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
  String get aboutAlQuran => 'Tentang Al-Quran';

  @override
  String get appFullName => 'Al-Quran (Tafsir, Solat, Kiblat, Audio)';

  @override
  String get appDescription =>
      'Aplikasi Islam komprehensif untuk Android, iOS, MacOS, Web, Linux dan Windows, menawarkan bacaan Al-Quran dengan Tafsir & pelbagai terjemahan (termasuk perkataan demi perkataan), waktu solat seluruh dunia dengan pemberitahuan, kompas Kiblat, dan bacaan audio perkataan demi perkataan yang diselaraskan.';

  @override
  String get dataSourcesNote =>
      'Nota: Teks Al-Quran, Tafsir, terjemahan, dan sumber audio diambil dari Quran.com, Everyayah.com, dan sumber terbuka yang disahkan lain.';

  @override
  String get adFreePromise =>
      'Aplikasi ini dibina untuk mencari keredhaan Allah. Oleh itu, ia adalah dan sentiasa bebas iklan sepenuhnya.';

  @override
  String get coreFeatures => 'Ciri Utama';

  @override
  String get coreFeaturesDescription =>
      'Terokai fungsi utama yang menjadikan Al-Quran v3 alat penting untuk amalan Islam harian anda:';

  @override
  String get prayerTimesTitle => 'Waktu Solat & Amaran';

  @override
  String get prayerTimesDescription =>
      'Waktu solat tepat untuk mana-mana lokasi di dunia menggunakan pelbagai kaedah pengiraan. Tetapkan peringatan dengan pemberitahuan Azan.';

  @override
  String get qiblaDirectionTitle => 'Arah Kiblat';

  @override
  String get qiblaDirectionDescription =>
      'Cari arah Kiblat dengan mudah dengan paparan kompas yang jelas dan tepat.';

  @override
  String get translationTafsirTitle => 'Terjemahan & Tafsir Al-Quran';

  @override
  String get translationTafsirDescription =>
      'Akses 120+ buku terjemahan (termasuk perkataan demi perkataan) dalam 69 bahasa, dan 30+ buku Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio & Sorotan Perkataan demi Perkataan';

  @override
  String get wordByWordAudioDescription =>
      'Ikuti bacaan audio perkataan demi perkataan yang diselaraskan dan sorotan untuk pengalaman pembelajaran mendalam.';

  @override
  String get ayahAudioRecitationTitle => 'Bacaan Audio Ayat';

  @override
  String get ayahAudioRecitationDescription =>
      'Dengar bacaan ayat penuh dari lebih 40+ pembaca terkenal.';

  @override
  String get notesCloudBackupTitle => 'Nota dengan Sandaran Awan';

  @override
  String get notesCloudBackupDescription =>
      'Simpan nota dan renungan peribadi, disandarkan dengan selamat ke awan (ciri dalam pembangunan/akan datang).';

  @override
  String get crossPlatformSupportTitle => 'Sokongan Pelbagai Platform';

  @override
  String get crossPlatformSupportDescription =>
      'Disokong pada Android, Web, Linux, dan Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Main Audio Latar Belakang';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Teruskan mendengar bacaan Al-Quran walaupun aplikasi di latar belakang.';

  @override
  String get audioDataCachingTitle => 'Cache Audio & Data';

  @override
  String get audioDataCachingDescription =>
      'Main semula yang lebih baik dan keupayaan luar talian dengan cache audio dan data Al-Quran yang kukuh.';

  @override
  String get minimalisticInterfaceTitle => 'Antara Muka Minimalis & Bersih';

  @override
  String get minimalisticInterfaceDescription =>
      'Antara muka mudah dinavigasi dengan fokus pada pengalaman pengguna dan kebolehbacaan.';

  @override
  String get optimizedPerformanceTitle => 'Prestasi & Saiz Dioptimumkan';

  @override
  String get optimizedPerformanceDescription =>
      'Aplikasi kaya ciri direka untuk ringan dan berprestasi.';

  @override
  String get languageSupport => 'Sokongan Bahasa';

  @override
  String get languageSupportDescription =>
      'Aplikasi ini direka untuk boleh diakses oleh khalayak global dengan sokongan untuk bahasa berikut (dan lebih banyak ditambah secara berterusan):';

  @override
  String get technologyAndResources => 'Teknologi & Sumber';

  @override
  String get technologyAndResourcesDescription =>
      'Aplikasi ini dibina menggunakan teknologi canggih dan sumber yang boleh dipercayai:';

  @override
  String get flutterFrameworkTitle => 'Kerangka Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Dibina dengan Flutter untuk pengalaman indah, dikompil asli, pelbagai platform dari kod tunggal.';

  @override
  String get advancedAudioEngineTitle => 'Enjin Audio Canggih';

  @override
  String get advancedAudioEngineDescription =>
      'Dikuasakan oleh pakej Flutter `just_audio` dan `just_audio_background` untuk main audio kukuh dan kawalan.';

  @override
  String get reliableQuranDataTitle => 'Data Al-Quran Boleh Dipercayai';

  @override
  String get reliableQuranDataDescription =>
      'Teks Al-Quran, terjemahan, tafsir, dan audio diambil dari API terbuka yang disahkan dan pangkalan data seperti Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Enjin Waktu Solat';

  @override
  String get prayerTimeEngineDescription =>
      'Menggunakan kaedah pengiraan yang ditetapkan untuk waktu solat tepat. Pemberitahuan dikendalikan oleh `flutter_local_notifications` dan tugas latar belakang.';

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
      'Saya secara peribadi berjanji untuk memberikan sokongan dan penyelenggaraan berterusan untuk aplikasi ini sepanjang hayat saya, In Sha Allah. Matlamat saya adalah memastikan aplikasi ini kekal sebagai sumber bermanfaat untuk Ummah untuk tahun-tahun mendatang.';

  @override
  String get fajr => 'Subuh';

  @override
  String get sunrise => 'Matahari Terbit';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Zohor';

  @override
  String get asr => 'Asar';

  @override
  String get sunset => 'Sunset';

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
  String get required => 'Diperlukan';

  @override
  String get optional => 'Pilihan';

  @override
  String get notificationScheduleWarning =>
      'Nota: Pemberitahuan atau Peringatan Berjadual boleh terlepas kerana sekatan proses latar belakang OS telefon anda. Contohnya: Origin OS Vivo, One UI Samsung, ColorOS Oppo dll. kadang-kadang membunuh Pemberitahuan atau Peringatan berjadual. Sila semak tetapan OS anda untuk buat aplikasi tidak disekat dari proses latar belakang.';

  @override
  String get scrollWithRecitation => 'Skrol dengan Bacaan';

  @override
  String get quickAccess => 'Akses Cepat';

  @override
  String get initiallyScrollAyah => 'Skrol ke ayat pada mulanya';

  @override
  String get tajweedGuide => 'Panduan Tajwid';

  @override
  String get scrollWithRecitationDesc =>
      'Apabila diaktifkan, ayat Al-Quran akan skrol secara automatik selaras dengan bacaan audio.';

  @override
  String get configuration => 'Konfigurasi';

  @override
  String get restoreFromBackup => 'Pulih Dari Sandaran';

  @override
  String get history => 'Sejarah';

  @override
  String get search => 'Cari';

  @override
  String get useAudioStream => 'Gunakan Strim Audio';

  @override
  String get useAudioStreamDesc =>
      'Strim audio terus dari internet bukannya muat turun.';

  @override
  String get notUseAudioStreamDesc =>
      'Muat turun audio untuk penggunaan luar talian dan kurangkan penggunaan data.';

  @override
  String get audioSettings => 'Tetapan Audio';

  @override
  String get playbackSpeed => 'Kelajuan Main Semula';

  @override
  String get playbackSpeedDesc => 'Laraskan kelajuan Bacaan Al-Quran.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Sila tunggu muat turun semasa selesai.';

  @override
  String get areYouSure => 'Adakah anda pasti?';

  @override
  String get checkYourInternetConnection => 'Semak sambungan internet anda.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Perlu muat turun $requiredDownload daripada $totalVersesCount ayat.';
  }

  @override
  String get download => 'Muat Turun';

  @override
  String get audioDownload => 'Muat Turun Audio';

  @override
  String get am => 'PG';

  @override
  String get pm => 'PTG';

  @override
  String get optimizingQuranScript => 'Mengoptimumkan Skrip Al-Quran';

  @override
  String get supportOnGithub => 'Sokongan di GitHub';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafieMalikiHanbali => 'Shafie, Maliki, Hanbali';

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
