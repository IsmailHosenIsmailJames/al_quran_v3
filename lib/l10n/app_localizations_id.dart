// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

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
    return 'Tafsir akan ditemukan di: $anotherAyahLinkKey';
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
  String get languageSettings => 'Pengaturan Bahasa';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayat';
  }

  @override
  String get saveAndDownload => 'Simpan dan Unduh';

  @override
  String get appLanguage => 'Bahasa Aplikasi';

  @override
  String get selectAppLanguage => 'Pilih bahasa aplikasi...';

  @override
  String get pleaseSelectOne => 'Silakan pilih salah satu';

  @override
  String get quranTranslationLanguage => 'Bahasa Terjemahan Quran';

  @override
  String get selectTranslationLanguage => 'Pilih bahasa terjemahan...';

  @override
  String get quranTranslationBook => 'Kitab Terjemahan Quran';

  @override
  String get selectTranslationBook => 'Pilih kitab terjemahan...';

  @override
  String get quranTafsirLanguage => 'Bahasa Tafsir Quran';

  @override
  String get selectTafsirLanguage => 'Pilih bahasa tafsir...';

  @override
  String get quranTafsirBook => 'Kitab Tafsir Quran';

  @override
  String get selectTafsirBook => 'Pilih kitab tafsir...';

  @override
  String get quranScriptAndStyle => 'Skrip & Gaya Quran';

  @override
  String get justAMoment => 'Tunggu sebentar...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Berhasil';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get unableToDownloadResources =>
      'Tidak dapat mengunduh sumber daya...\nTerjadi kesalahan';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Mengunduh Bacaan Quran per Segmen';

  @override
  String get processingSegmentedQuranRecitation =>
      'Memproses Bacaan Quran per Segmen';

  @override
  String get footnote => 'Catatan Kaki';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Kata per Kata';

  @override
  String get pleaseSelectRequiredOption => 'Silakan pilih opsi yang diperlukan';

  @override
  String get rememberHomeTab => 'Ingat Tab Beranda';

  @override
  String get rememberHomeTabSubtitle =>
      'Aplikasi akan mengingat tab terakhir yang dibuka di layar beranda.';

  @override
  String get wakeLock => 'Jaga Layar Tetap Aktif';

  @override
  String get wakeLockSubtitle => 'Mencegah layar mati secara otomatis.';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appTheme => 'Tema Aplikasi';

  @override
  String get quranStyle => 'Gaya Quran';

  @override
  String get changeTheme => 'Ubah Tema';

  @override
  String get verseCount => 'Jumlah Ayat: ';

  @override
  String get translation => 'Terjemahan';

  @override
  String get tafsirNotFound => 'Tidak Ditemukan';

  @override
  String get moreInfo => 'info lebih lanjut';

  @override
  String get playAudio => 'Putar Audio';

  @override
  String get preview => 'Pratinjau';

  @override
  String get loading => 'Memuat...';

  @override
  String get errorFetchingAddress => 'Gagal mengambil alamat';

  @override
  String get addressNotAvailable => 'Alamat tidak tersedia';

  @override
  String get latitude => 'Lintang: ';

  @override
  String get longitude => 'Bujur: ';

  @override
  String get name => 'Nama: ';

  @override
  String get location => 'Lokasi: ';

  @override
  String get parameters => 'Parameter: ';

  @override
  String get selectCalculationMethod => 'Pilih Metode Perhitungan';

  @override
  String get shareSelectAyahs => 'Bagikan Ayat Terpilih';

  @override
  String get selectionEmpty => 'Pilihan Kosong';

  @override
  String get generatingImagePleaseWait => 'Membuat Gambar... Mohon Tunggu';

  @override
  String get asImage => 'Sebagai Gambar';

  @override
  String get asText => 'Sebagai Teks';

  @override
  String get playFromSelectedAyah => 'Putar dari Ayat Terpilih';

  @override
  String get toTafsir => 'Ke Tafsir';

  @override
  String get selectAyah => 'Pilih Ayat';

  @override
  String get toAyah => 'Ke Ayat';

  @override
  String get searchForASurah => 'Cari surah';

  @override
  String get bugReportTitle => 'Laporan Bug';

  @override
  String get audioCached => 'Audio Tersimpan di Cache';

  @override
  String get others => 'Lainnya';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Quran|Terjemahan|Ayat, Salah Satu Harus Diaktifkan';

  @override
  String get quranFontSize => 'Ukuran Font Quran';

  @override
  String get quranLineHeight => 'Tinggi Baris Quran';

  @override
  String get translationAndTafsirFontSize => 'Ukuran Font Terjemahan & Tafsir';

  @override
  String get quranAyah => 'Ayat Quran';

  @override
  String get topToolbar => 'Bilah Alat Atas';

  @override
  String get keepOpenWordByWord => 'Tetap Buka Kata per Kata';

  @override
  String get wordByWordHighlight => 'Sorotan Kata per Kata';

  @override
  String get quranScriptSettings => 'Pengaturan Skrip Quran';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Halaman: ';

  @override
  String get quranResources => 'Sumber Daya Quran';

  @override
  String alreadySelected(String name) {
    return 'Bahasa \'$name\' sudah dipilih.';
  }

  @override
  String get unableToGetCompassData => 'Tidak dapat mengambil data kompas';

  @override
  String get deviceDoesNotHaveSensors => 'Perangkat tidak memiliki sensor!';

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
  String get change => 'Ubah';

  @override
  String get calculationMethod => 'Metode Perhitungan: ';

  @override
  String get downloadPrayerTime => 'Unduh Waktu Salat';

  @override
  String get calculationMethodsListEmpty => 'Daftar metode perhitungan kosong.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Tidak dapat menemukan metode perhitungan dengan data lokasi.';

  @override
  String get prayerSettings => 'Pengaturan Salat';

  @override
  String get reminderSettings => 'Pengaturan Pengingat';

  @override
  String get adjustReminderTime => 'Sesuaikan Waktu Pengingat';

  @override
  String get enforceAlarmSound => 'Paksa Suara Alarm';

  @override
  String get enforceAlarmSoundDescription =>
      'Jika diaktifkan, fitur ini akan memutar alarm dengan volume yang diatur di sini, meskipun suara ponsel Anda rendah. Ini memastikan Anda tidak melewatkan alarm karena volume ponsel yang rendah.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'Saat waktu salat';

  @override
  String minBefore(int minutes) {
    return '$minutes menit sebelumnya';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes menit setelahnya';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Waktu $prayerName pukul $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Telah tiba waktu $prayerName';
  }

  @override
  String get stopTheAdhan => 'Hentikan Azan';

  @override
  String dateFoundEmpty(String date) {
    return 'Data untuk $date tidak ditemukan';
  }

  @override
  String get today => 'Hari Ini';

  @override
  String get left => 'Tersisa';

  @override
  String reminderAdded(String prayerName) {
    return 'Pengingat untuk $prayerName ditambahkan';
  }

  @override
  String get allowNotificationPermission =>
      'Izinkan notifikasi untuk menggunakan fitur ini';

  @override
  String reminderRemoved(String prayerName) {
    return 'Pengingat untuk $prayerName dihapus';
  }

  @override
  String get getPrayerTimesAndQibla => 'Dapatkan Waktu Salat dan Kiblat';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Hitung Waktu Salat dan Kiblat untuk Lokasi Manapun.';

  @override
  String get getFromGPS => 'Dapatkan dari GPS';

  @override
  String get or => 'Atau';

  @override
  String get selectYourCity => 'Pilih Kota Anda';

  @override
  String get noteAboutGPS =>
      'Catatan: Jika Anda tidak ingin menggunakan GPS atau merasa tidak aman, Anda dapat memilih kota Anda.';

  @override
  String get downloadingLocationResources => 'Mengunduh sumber daya lokasi...';

  @override
  String get somethingWentWrong => 'Terjadi kesalahan';

  @override
  String get selectYourCountry => 'Pilih Negara Anda';

  @override
  String get searchForACountry => 'Cari negara';

  @override
  String get selectYourAdministrator => 'Pilih Lembaga Anda';

  @override
  String get searchForAnAdministrator => 'Cari lembaga';

  @override
  String get searchForACity => 'Cari kota';

  @override
  String get pleaseEnableLocationService => 'Harap aktifkan layanan lokasi';

  @override
  String get donateUs => 'Donasi';

  @override
  String get underDevelopment => 'Dalam pengembangan';

  @override
  String get versionLoading => 'Memuat...';

  @override
  String get alQuran => 'Al Quran';

  @override
  String get mainMenu => 'Menu Utama';

  @override
  String get notes => 'Catatan';

  @override
  String get pinned => 'Disematkan';

  @override
  String get jumpToAyah => 'Lompat ke Ayat';

  @override
  String get shareMultipleAyah => 'Bagikan Beberapa Ayat';

  @override
  String get shareThisApp => 'Bagikan Aplikasi Ini';

  @override
  String get giveRating => 'Beri Peringkat';

  @override
  String get bugReport => 'Laporan Bug';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get aboutTheApp => 'Tentang Aplikasi';

  @override
  String get resetTheApp => 'Atur Ulang Aplikasi';

  @override
  String get resetAppWarningTitle => 'Atur Ulang Data Aplikasi';

  @override
  String get resetAppWarningMessage =>
      'Apakah Anda yakin ingin mengatur ulang aplikasi? Semua data Anda akan hilang, dan Anda harus mengatur ulang aplikasi dari awal.';

  @override
  String get cancel => 'Batal';

  @override
  String get reset => 'Atur Ulang';

  @override
  String get shareAppSubject => 'Coba aplikasi Al Quran ini!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Coba aplikasi Al Quran ini untuk bacaan dan refleksi harian. Aplikasi ini membantu terhubung dengan firman Allah. Unduh di sini: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Buka Menu';

  @override
  String get quran => 'Quran';

  @override
  String get prayer => 'Salat';

  @override
  String get qibla => 'Kiblat';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Surah';

  @override
  String get pages => 'Halaman';

  @override
  String get note => 'Catatan:';

  @override
  String get linkedAyahs => 'Ayat Terkait:';

  @override
  String get emptyNoteCollection =>
      'Koleksi catatan ini kosong.\nTambahkan beberapa catatan untuk melihatnya di sini.';

  @override
  String get emptyPinnedCollection =>
      'Belum ada Ayat yang disematkan ke koleksi ini.\nSematkan Ayat untuk melihatnya di sini.';

  @override
  String get noContentAvailable => 'Tidak ada konten yang tersedia.';

  @override
  String failedToLoadCollections(String error) {
    return 'Gagal memuat koleksi: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Cari Berdasarkan Nama $collectionType...';
  }

  @override
  String get sortBy => 'Urutkan berdasarkan';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Belum ada $collectionType yang ditambahkan';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count item disematkan';
  }

  @override
  String notesCount(int count) {
    return '$count catatan';
  }

  @override
  String get emptyNameNotAllowed => 'Nama tidak boleh kosong';

  @override
  String updatedTo(String collectionName) {
    return 'Diperbarui menjadi $collectionName';
  }

  @override
  String get changeName => 'Ubah Nama';

  @override
  String get changeColor => 'Ubah Warna';

  @override
  String get colorUpdated => 'Warna diperbarui';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Dihapus';
  }

  @override
  String get delete => 'Hapus';

  @override
  String get save => 'Simpan';

  @override
  String get collectionNameCannotBeEmpty => 'Nama koleksi tidak boleh kosong.';

  @override
  String get addedNewCollection => 'Menambahkan Koleksi Baru';

  @override
  String ayahCount(int count) {
    return '$count Ayat';
  }

  @override
  String get byNameAtoZ => 'Nama A-Z';

  @override
  String get byNameZtoA => 'Nama Z-A';

  @override
  String get byElementNumberAscending => 'Nomor Elemen Menaik';

  @override
  String get byElementNumberDescending => 'Nomor Elemen Menurun';

  @override
  String get byUpdateDateAscending => 'Tanggal Diperbarui Menaik';

  @override
  String get byUpdateDateDescending => 'Tanggal Diperbarui Menurun';

  @override
  String get byCreateDateAscending => 'Tanggal Dibuat Menaik';

  @override
  String get byCreateDateDescending => 'Tanggal Dibuat Menurun';

  @override
  String get translationNotFound => 'Terjemahan Tidak Ditemukan';

  @override
  String get translationTitle => 'Terjemahan:';

  @override
  String get footNoteTitle => 'Catatan Kaki:';

  @override
  String get wordByWordTranslation => 'Terjemahan Kata per Kata:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Bagikan';

  @override
  String get addNoteButton => 'Tambah Catatan';

  @override
  String get pinToCollectionButton => 'Sematkan ke Koleksi';

  @override
  String get shareAsText => 'Bagikan sebagai Teks';

  @override
  String get copiedWithTafsir => 'Disalin dengan Tafsir';

  @override
  String get shareAsImage => 'Bagikan sebagai Gambar';

  @override
  String get shareWithTafsir => 'Bagikan dengan Tafsir';

  @override
  String get notFound => 'Tidak ditemukan';

  @override
  String get noteContentCannotBeEmpty => 'Isi catatan tidak boleh kosong.';

  @override
  String get noteSavedSuccessfully => 'Catatan berhasil disimpan!';

  @override
  String get selectCollections => 'Pilih Koleksi';

  @override
  String get addNote => 'Tambah Catatan';

  @override
  String get writeCollectionName => 'Tulis nama koleksi...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Belum ada koleksi. Tambahkan yang baru!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Harap tulis catatan Anda terlebih dahulu.';

  @override
  String get noCollectionSelected => 'Tidak ada Koleksi yang dipilih';

  @override
  String get saveNote => 'Simpan Catatan';

  @override
  String get nextSelectCollections => 'Berikutnya: Pilih Koleksi';

  @override
  String get addToPinned => 'Tambahkan ke Disematkan';

  @override
  String get pinnedSavedSuccessfully => 'Berhasil disimpan ke Disematkan!';

  @override
  String get savePinned => 'Simpan ke Disematkan';

  @override
  String get closeAudioController => 'Tutup Pengontrol Audio';

  @override
  String get previous => 'Sebelumnya';

  @override
  String get rewind => 'Mundur';

  @override
  String get fastForward => 'Maju';

  @override
  String get playNextAyah => 'Putar Ayat Berikutnya';

  @override
  String get repeat => 'Ulangi';

  @override
  String get playAsPlaylist => 'Putar sebagai Daftar Putar';

  @override
  String style(String style) {
    return 'Gaya: $style';
  }

  @override
  String get stopAndClose => 'Hentikan & Tutup';

  @override
  String get play => 'Putar';

  @override
  String get pause => 'Jeda';

  @override
  String get selectReciter => 'Pilih Qari';

  @override
  String source(String source) {
    return 'Sumber: $source';
  }

  @override
  String get newText => 'Baru';

  @override
  String get more => 'Lainnya: ';

  @override
  String get cacheNotFound => 'Cache Tidak Ditemukan';

  @override
  String get cacheSize => 'Ukuran Cache';

  @override
  String error(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get clean => 'Bersihkan';

  @override
  String get lastModified => 'Terakhir Diubah';

  @override
  String get oneYearAgo => '1 Tahun yang lalu';

  @override
  String monthsAgo(String number) {
    return '$number Bulan yang lalu';
  }

  @override
  String weeksAgo(String number) {
    return '$number Minggu yang lalu';
  }

  @override
  String daysAgo(String number) {
    return '$number Hari yang lalu';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Jam yang lalu';
  }

  @override
  String get aboutAlQuran => 'Tentang Al Quran';

  @override
  String get appFullName => 'Al Quran (Tafsir, Salat, Kiblat, Audio)';

  @override
  String get appDescription =>
      'Aplikasi Islami komprehensif untuk Android, iOS, MacOS, Web, Linux, dan Windows, yang menawarkan bacaan Quran dengan Tafsir & berbagai terjemahan (termasuk kata per kata), waktu salat di seluruh dunia dengan notifikasi, kompas Kiblat, dan pembacaan audio kata per kata yang disinkronkan.';

  @override
  String get dataSourcesNote =>
      'Catatan: Teks Quran, Tafsir, terjemahan, dan sumber daya audio bersumber dari Quran.com, Everyayah.com, dan sumber terbuka terverifikasi lainnya.';

  @override
  String get adFreePromise =>
      'Aplikasi ini dibuat untuk mencari rida Allah. Oleh karena itu, aplikasi ini sepenuhnya Bebas Iklan dan akan selalu begitu.';

  @override
  String get coreFeatures => 'Fitur Utama';

  @override
  String get coreFeaturesDescription =>
      'Jelajahi fungsionalitas utama yang menjadikan Al Quran v3 alat yang tak tergantikan untuk amalan Islami harian Anda:';

  @override
  String get prayerTimesTitle => 'Waktu Salat & Peringatan';

  @override
  String get prayerTimesDescription =>
      'Waktu salat yang akurat untuk lokasi manapun di seluruh dunia menggunakan berbagai metode perhitungan. Atur pengingat dengan notifikasi Azan.';

  @override
  String get qiblaDirectionTitle => 'Arah Kiblat';

  @override
  String get qiblaDirectionDescription =>
      'Temukan arah Kiblat dengan mudah melalui tampilan kompas yang jelas dan akurat.';

  @override
  String get translationTafsirTitle => 'Terjemahan & Tafsir Quran';

  @override
  String get translationTafsirDescription =>
      'Akses 120+ kitab terjemahan (termasuk kata per kata) dalam 69 bahasa, dan 30+ kitab Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio & Sorotan Kata per Kata';

  @override
  String get wordByWordAudioDescription =>
      'Ikuti bacaan audio kata per kata yang disinkronkan dengan sorotan untuk pengalaman belajar yang mendalam.';

  @override
  String get ayahAudioRecitationTitle => 'Pembacaan Audio per Ayat';

  @override
  String get ayahAudioRecitationDescription =>
      'Dengarkan bacaan Ayat lengkap dari lebih dari 40+ Qari ternama.';

  @override
  String get notesCloudBackupTitle => 'Catatan dengan Cadangan Awan';

  @override
  String get notesCloudBackupDescription =>
      'Simpan catatan pribadi dan refleksi, dicadangkan dengan aman ke cloud (fitur sedang dikembangkan/segera hadir).';

  @override
  String get crossPlatformSupportTitle => 'Dukungan Lintas Platform';

  @override
  String get crossPlatformSupportDescription =>
      'Didukung di Android, Web, Linux, dan Windows.';

  @override
  String get backgroundAudioPlaybackTitle =>
      'Pemutaran Audio di Latar Belakang';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Terus dengarkan bacaan Quran bahkan saat aplikasi berjalan di latar belakang.';

  @override
  String get audioDataCachingTitle => 'Penyimpanan Cache Audio & Data';

  @override
  String get audioDataCachingDescription =>
      'Peningkatan pemutaran dan kemampuan luring dengan penyimpanan cache audio dan data Quran yang kuat.';

  @override
  String get minimalisticInterfaceTitle => 'Antarmuka Minimalis & Bersih';

  @override
  String get minimalisticInterfaceDescription =>
      'Antarmuka yang mudah dinavigasi dengan fokus pada pengalaman pengguna dan keterbacaan.';

  @override
  String get optimizedPerformanceTitle => 'Performa & Ukuran yang Dioptimalkan';

  @override
  String get optimizedPerformanceDescription =>
      'Aplikasi kaya fitur yang dirancang agar ringan dan berperforma tinggi.';

  @override
  String get languageSupport => 'Dukungan Bahasa';

  @override
  String get languageSupportDescription =>
      'Aplikasi ini dirancang agar dapat diakses oleh audiens global dengan dukungan untuk bahasa-bahasa berikut (dan lebih banyak lagi akan terus ditambahkan):';

  @override
  String get technologyAndResources => 'Teknologi & Sumber Daya';

  @override
  String get technologyAndResourcesDescription =>
      'Aplikasi ini dibuat menggunakan teknologi canggih dan sumber daya yang andal:';

  @override
  String get flutterFrameworkTitle => 'Kerangka Kerja Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Dibuat dengan Flutter untuk pengalaman multi-platform yang indah dan dikompilasi secara native dari satu basis kode.';

  @override
  String get advancedAudioEngineTitle => 'Mesin Audio Canggih';

  @override
  String get advancedAudioEngineDescription =>
      'Didukung oleh paket Flutter `just_audio` dan `just_audio_background` untuk pemutaran dan kontrol audio yang kuat.';

  @override
  String get reliableQuranDataTitle => 'Data Quran yang Andal';

  @override
  String get reliableQuranDataDescription =>
      'Teks Al Quran, terjemahan, tafsir, dan audio bersumber dari API terbuka dan basis data terverifikasi seperti Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Mesin Waktu Salat';

  @override
  String get prayerTimeEngineDescription =>
      'Menggunakan metode perhitungan yang sudah mapan untuk waktu salat yang akurat. Notifikasi ditangani oleh `flutter_local_notifications` dan tugas latar belakang.';

  @override
  String get crossPlatformSupport => 'Dukungan Lintas Platform';

  @override
  String get crossPlatformSupportDescription2 =>
      'Nikmati akses tanpa batas di berbagai platform:';

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
      'Saya pribadi berjanji akan memberikan dukungan dan pemeliharaan berkelanjutan untuk aplikasi ini seumur hidup saya, Insya Allah. Tujuan saya adalah memastikan aplikasi ini tetap menjadi sumber daya yang bermanfaat bagi umat di tahun-tahun mendatang.';

  @override
  String get fajr => 'Subuh';

  @override
  String get sunrise => 'Terbit';

  @override
  String get dhuhr => 'Zuhur';

  @override
  String get asr => 'Asar';

  @override
  String get maghrib => 'Magrib';

  @override
  String get isha => 'Isya';

  @override
  String get midnight => 'Tengah Malam';

  @override
  String get alarm => 'Alarm';

  @override
  String get notification => 'Notifikasi';

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
  String get quranScriptUthmani => 'Utsmani';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Ayat Sajdah';

  @override
  String get required => 'Wajib';

  @override
  String get optional => 'Sunnah';

  @override
  String get notificationScheduleWarning =>
      'Catatan: Notifikasi atau Pengingat terjadwal dapat terlewatkan karena batasan proses latar belakang OS ponsel Anda. Misalnya: Origin OS dari Vivo, One UI dari Samsung, ColorOS dari Oppo, dll. terkadang mematikan Notifikasi atau Pengingat terjadwal. Silakan periksa pengaturan OS Anda agar aplikasi tidak dibatasi dari proses latar belakang.';

  @override
  String get scrollWithRecitation => 'Gulir dengan Bacaan';

  @override
  String get scrollWithRecitationDesc =>
      'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.';

  @override
  String get quickAccess => 'Akses Cepat';

  @override
  String get initiallyScrollAyah => 'Awalnya gulir ke ayat';

  @override
  String get tajweedGuide => 'Panduan Tajwid';

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
