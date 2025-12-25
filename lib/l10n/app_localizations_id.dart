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
    return 'Tafsir bisa ditemukan di: $anotherAyahLinkKey';
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
  String get pleaseSelectOne => 'Silakan pilih satu';

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
  String get quranScriptAndStyle => 'Naskah & Gaya Al-Quran';

  @override
  String get justAMoment => 'Sebentar ya...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Sukses';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get unableToDownloadResources =>
      'Gagal mengunduh sumber daya...\nAda yang salah';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Mengunduh Bacaan Al-Quran Tersegmentasi';

  @override
  String get processingSegmentedQuranRecitation =>
      'Memproses Bacaan Al-Quran Tersegmentasi';

  @override
  String get footnote => 'Catatan Kaki';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Kata demi Kata';

  @override
  String get pleaseSelectRequiredOption => 'Silakan pilih opsi yang diperlukan';

  @override
  String get rememberHomeTab => 'Ingat Tab Beranda';

  @override
  String get rememberHomeTabSubtitle =>
      'Aplikasi akan ingat tab terakhir yang dibuka di layar beranda.';

  @override
  String get wakeLock => 'Kunci Bangun';

  @override
  String get wakeLockSubtitle => 'Cegah layar mati secara otomatis.';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appTheme => 'Tema Aplikasi';

  @override
  String get quranStyle => 'Gaya Al-Quran';

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
  String get shareSelectAyahs => 'Bagikan Ayat yang Dipilih';

  @override
  String get selectionEmpty => 'Pilihan Kosong';

  @override
  String get generatingImagePleaseWait => 'Membuat Gambar... Tunggu Sebentar';

  @override
  String get asImage => 'Sebagai Gambar';

  @override
  String get asText => 'Sebagai Teks';

  @override
  String get playFromSelectedAyah => 'Putar dari Ayat yang Dipilih';

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
  String get audioCached => 'Audio Disimpan';

  @override
  String get others => 'Lainnya';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Al-Quran|Terjemahan|Ayat, Satu Harus Diaktifkan';

  @override
  String get quranFontSize => 'Ukuran Font Al-Quran';

  @override
  String get quranLineHeight => 'Tinggi Baris Al-Quran';

  @override
  String get translationAndTafsirFontSize => 'Ukuran Font Terjemahan & Tafsir';

  @override
  String get quranAyah => 'Ayat Al-Quran';

  @override
  String get topToolbar => 'Bilah Alat Atas';

  @override
  String get keepOpenWordByWord => 'Tetap Buka Kata demi Kata';

  @override
  String get wordByWordHighlight => 'Sorot Kata demi Kata';

  @override
  String get quranScriptSettings => 'Pengaturan Naskah Al-Quran';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Halaman: ';

  @override
  String get quranResources => 'Sumber Daya Al-Quran';

  @override
  String alreadySelected(String name) {
    return 'Bahasa \'$name\' sudah dipilih.';
  }

  @override
  String get unableToGetCompassData => 'Gagal mendapatkan data kompas';

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
  String get downloadPrayerTime => 'Unduh Waktu Sholat';

  @override
  String get calculationMethodsListEmpty => 'Daftar metode perhitungan kosong.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Tidak menemukan metode perhitungan dengan data lokasi.';

  @override
  String get prayerSettings => 'Pengaturan Sholat';

  @override
  String get reminderSettings => 'Pengaturan Pengingat';

  @override
  String get adjustReminderTime => 'Sesuaikan Waktu Pengingat';

  @override
  String get enforceAlarmSound => 'Paksa Suara Alarm';

  @override
  String get enforceAlarmSoundDescription =>
      'Jika diaktifkan, fitur ini akan memutar alarm dengan volume yang ditetapkan di sini, meskipun suara ponselmu rendah. Ini memastikan kamu tidak ketinggalan alarm karena volume ponsel rendah.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'Pada waktu sholat';

  @override
  String minBefore(int minutes) {
    return '$minutes menit sebelum';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes menit setelah';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName pada $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Waktunya $prayerName';
  }

  @override
  String get stopTheAdhan => 'Hentikan Adzan';

  @override
  String dateFoundEmpty(String date) {
    return '$date Ditemukan Kosong';
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
      'Izinkan izin notifikasi untuk menggunakan fitur ini';

  @override
  String reminderRemoved(String prayerName) {
    return 'Pengingat untuk $prayerName dihapus';
  }

  @override
  String get getPrayerTimesAndQibla => 'Dapatkan Waktu Sholat dan Kiblat';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Hitung Waktu Sholat dan Kiblat untuk Lokasi Mana Saja.';

  @override
  String get getFromGPS => 'Dapatkan dari GPS';

  @override
  String get or => 'Atau';

  @override
  String get selectYourCity => 'Pilih Kota Anda';

  @override
  String get noteAboutGPS =>
      'Catatan: Jika tidak ingin menggunakan GPS atau merasa tidak aman, Anda bisa pilih kota Anda.';

  @override
  String get downloadingLocationResources => 'Mengunduh sumber daya lokasi...';

  @override
  String get somethingWentWrong => 'Ada yang salah';

  @override
  String get selectYourCountry => 'Pilih Negara Anda';

  @override
  String get searchForACountry => 'Cari negara';

  @override
  String get selectYourAdministrator => 'Pilih Administrator Anda';

  @override
  String get searchForAnAdministrator => 'Cari administrator';

  @override
  String get searchForACity => 'Cari kota';

  @override
  String get pleaseEnableLocationService => 'Aktifkan layanan lokasi';

  @override
  String get donateUs => 'Donasi untuk Kami';

  @override
  String get underDevelopment => 'Sedang dikembangkan';

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
  String get giveRating => 'Beri Rating';

  @override
  String get bugReport => 'Laporan Bug';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get aboutTheApp => 'Tentang Aplikasi';

  @override
  String get resetTheApp => 'Reset Aplikasi';

  @override
  String get resetAppWarningTitle => 'Reset Data Aplikasi';

  @override
  String get resetAppWarningMessage =>
      'Yakin ingin reset aplikasi? Semua data Anda akan hilang, dan Anda harus atur ulang dari awal.';

  @override
  String get cancel => 'Batal';

  @override
  String get reset => 'Reset';

  @override
  String get shareAppSubject => 'Coba Aplikasi Al Quran Ini!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Coba aplikasi Al Quran ini untuk bacaan dan renungan harian. Membantu terhubung dengan firman Allah. Unduh di sini: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Buka Laci';

  @override
  String get quran => 'Al-Quran';

  @override
  String get prayer => 'Sholat';

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
      'Koleksi catatan ini kosong.\nTambahkan catatan untuk melihatnya di sini.';

  @override
  String get emptyPinnedCollection =>
      'Belum ada ayat yang disematkan ke koleksi ini.\nSematkan ayat untuk melihatnya di sini.';

  @override
  String get noContentAvailable => 'Tidak ada konten tersedia.';

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
  String get emptyNameNotAllowed => 'Nama kosong tidak diizinkan';

  @override
  String updatedTo(String collectionName) {
    return 'Diperbarui ke $collectionName';
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
  String get addedNewCollection => 'Koleksi Baru Ditambahkan';

  @override
  String ayahCount(int count) {
    return '$count Ayat';
  }

  @override
  String get byNameAtoZ => 'Nama A-Z';

  @override
  String get byNameZtoA => 'Nama Z-A';

  @override
  String get byElementNumberAscending => 'Nomor Elemen Naik';

  @override
  String get byElementNumberDescending => 'Nomor Elemen Turun';

  @override
  String get byUpdateDateAscending => 'Tanggal Update Naik';

  @override
  String get byUpdateDateDescending => 'Tanggal Update Turun';

  @override
  String get byCreateDateAscending => 'Tanggal Buat Naik';

  @override
  String get byCreateDateDescending => 'Tanggal Buat Turun';

  @override
  String get translationNotFound => 'Terjemahan Tidak Ditemukan';

  @override
  String get translationTitle => 'Terjemahan:';

  @override
  String get footNoteTitle => 'Catatan Kaki:';

  @override
  String get wordByWordTranslation => 'Terjemahan Kata demi Kata:';

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
  String get pleaseWriteYourNoteFirst => 'Tulis catatan Anda dulu.';

  @override
  String get noCollectionSelected => 'Tidak ada koleksi yang dipilih';

  @override
  String get saveNote => 'Simpan Catatan';

  @override
  String get nextSelectCollections => 'Selanjutnya: Pilih Koleksi';

  @override
  String get addToPinned => 'Tambah ke Sematan';

  @override
  String get pinnedSavedSuccessfully => 'Sematan berhasil disimpan!';

  @override
  String get savePinned => 'Simpan Sematan';

  @override
  String get closeAudioController => 'Tutup Pengontrol Audio';

  @override
  String get previous => 'Sebelumnya';

  @override
  String get rewind => 'Mundur';

  @override
  String get fastForward => 'Maju Cepat';

  @override
  String get playNextAyah => 'Putar Ayat Selanjutnya';

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
  String get more => 'Lebih Banyak: ';

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
  String get aboutAlQuran => 'Tentang Al Quran';

  @override
  String get appFullName => 'Al Quran (Tafsir, Sholat, Kiblat, Audio)';

  @override
  String get appDescription =>
      'Aplikasi Islam lengkap untuk Android, iOS, MacOS, Web, Linux, dan Windows, menawarkan bacaan Al-Quran dengan Tafsir & berbagai terjemahan (termasuk kata demi kata), waktu sholat di seluruh dunia dengan notifikasi, kompas Kiblat, dan rekaman audio kata demi kata yang disinkronkan.';

  @override
  String get dataSourcesNote =>
      'Catatan: Teks Al-Quran, Tafsir, terjemahan, dan sumber audio diambil dari Quran.com, Everyayah.com, dan sumber terbuka terverifikasi lainnya.';

  @override
  String get adFreePromise =>
      'Aplikasi ini dibuat untuk mencari ridha Allah. Oleh karena itu, aplikasi ini dan akan selalu bebas iklan sepenuhnya.';

  @override
  String get coreFeatures => 'Fitur Utama';

  @override
  String get coreFeaturesDescription =>
      'Jelajahi fungsi utama yang membuat Al Quran v3 menjadi alat penting untuk praktik Islam harian Anda:';

  @override
  String get prayerTimesTitle => 'Waktu Sholat & Peringatan';

  @override
  String get prayerTimesDescription =>
      'Waktu sholat akurat untuk lokasi mana saja di dunia menggunakan berbagai metode perhitungan. Atur pengingat dengan notifikasi Adzan.';

  @override
  String get qiblaDirectionTitle => 'Arah Kiblat';

  @override
  String get qiblaDirectionDescription =>
      'Temukan arah Kiblat dengan mudah menggunakan tampilan kompas yang jelas dan akurat.';

  @override
  String get translationTafsirTitle => 'Terjemahan & Tafsir Al-Quran';

  @override
  String get translationTafsirDescription =>
      'Akses 120+ buku terjemahan (termasuk kata demi kata) dalam 69 bahasa, dan 30+ buku Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio & Sorotan Kata demi Kata';

  @override
  String get wordByWordAudioDescription =>
      'Ikuti rekaman audio kata demi kata yang disinkronkan dan sorotan untuk pengalaman belajar yang mendalam.';

  @override
  String get ayahAudioRecitationTitle => 'Rekaman Audio Ayat';

  @override
  String get ayahAudioRecitationDescription =>
      'Dengarkan rekaman ayat penuh dari lebih dari 40+ qari terkenal.';

  @override
  String get notesCloudBackupTitle => 'Catatan dengan Cadangan Cloud';

  @override
  String get notesCloudBackupDescription =>
      'Simpan catatan dan refleksi pribadi, dicadangkan dengan aman ke cloud (fitur sedang dikembangkan/segera hadir).';

  @override
  String get crossPlatformSupportTitle => 'Dukungan Lintas Platform';

  @override
  String get crossPlatformSupportDescription =>
      'Didukung di Android, Web, Linux, dan Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Pemutaran Audio Latar Belakang';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Lanjutkan mendengarkan bacaan Al-Quran meskipun aplikasi di latar belakang.';

  @override
  String get audioDataCachingTitle => 'Cache Audio & Data';

  @override
  String get audioDataCachingDescription =>
      'Pemutaran lebih baik dan kemampuan offline dengan cache audio dan data Al-Quran yang kuat.';

  @override
  String get minimalisticInterfaceTitle => 'Antarmuka Minimalis & Bersih';

  @override
  String get minimalisticInterfaceDescription =>
      'Antarmuka mudah dinavigasi dengan fokus pada pengalaman pengguna dan keterbacaan.';

  @override
  String get optimizedPerformanceTitle => 'Performa & Ukuran yang Dioptimalkan';

  @override
  String get optimizedPerformanceDescription =>
      'Aplikasi kaya fitur yang dirancang ringan dan berkinerja tinggi.';

  @override
  String get languageSupport => 'Dukungan Bahasa';

  @override
  String get languageSupportDescription =>
      'Aplikasi ini dirancang untuk dapat diakses oleh audiens global dengan dukungan bahasa berikut (dan lebih banyak lagi terus ditambahkan):';

  @override
  String get technologyAndResources => 'Teknologi & Sumber Daya';

  @override
  String get technologyAndResourcesDescription =>
      'Aplikasi ini dibangun menggunakan teknologi mutakhir dan sumber daya terpercaya:';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Dibangun dengan Flutter untuk pengalaman indah, dikompilasi secara native, multi-platform dari satu basis kode.';

  @override
  String get advancedAudioEngineTitle => 'Mesin Audio Canggih';

  @override
  String get advancedAudioEngineDescription =>
      'Didukung oleh paket Flutter `just_audio` dan `just_audio_background` untuk pemutaran dan kontrol audio yang kuat.';

  @override
  String get reliableQuranDataTitle => 'Data Al-Quran Terpercaya';

  @override
  String get reliableQuranDataDescription =>
      'Teks Al-Quran, terjemahan, tafsir, dan audio diambil dari API terbuka terverifikasi seperti Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Mesin Waktu Sholat';

  @override
  String get prayerTimeEngineDescription =>
      'Menggunakan metode perhitungan mapan untuk waktu sholat akurat. Notifikasi ditangani oleh `flutter_local_notifications` dan tugas latar belakang.';

  @override
  String get crossPlatformSupport => 'Dukungan Lintas Platform';

  @override
  String get crossPlatformSupportDescription2 =>
      'Nikmati akses mulus di berbagai platform:';

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
      'Saya secara pribadi berjanji untuk memberikan dukungan dan pemeliharaan berkelanjutan untuk aplikasi ini sepanjang hidup saya, In Sha Allah. Tujuan saya adalah memastikan aplikasi ini tetap menjadi sumber daya bermanfaat bagi Ummah selama bertahun-tahun.';

  @override
  String get fajr => 'Subuh';

  @override
  String get sunrise => 'Terbit Matahari';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Zuhur';

  @override
  String get asr => 'Ashar';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'Maghrib';

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
  String get required => 'Diperlukan';

  @override
  String get optional => 'Opsional';

  @override
  String get notificationScheduleWarning =>
      'Catatan: Notifikasi atau Pengingat Terjadwal bisa terlewat karena pembatasan proses latar belakang OS ponsel Anda. Misalnya: Origin OS Vivo, One UI Samsung, ColorOS Oppo kadang menghentikan notifikasi atau pengingat terjadwal. Periksa pengaturan OS Anda agar aplikasi tidak dibatasi dari proses latar belakang.';

  @override
  String get scrollWithRecitation => 'Gulir dengan Bacaan';

  @override
  String get quickAccess => 'Akses Cepat';

  @override
  String get initiallyScrollAyah => 'Gulir awal ke ayat';

  @override
  String get tajweedGuide => 'Panduan Tajwid';

  @override
  String get scrollWithRecitationDesc =>
      'Saat diaktifkan, ayat Al-Quran akan otomatis bergulir sesuai dengan audio bacaan.';

  @override
  String get configuration => 'Konfigurasi';

  @override
  String get restoreFromBackup => 'Pulihkan dari Cadangan';

  @override
  String get history => 'Riwayat';

  @override
  String get search => 'Cari';

  @override
  String get useAudioStream => 'Gunakan Streaming Audio';

  @override
  String get useAudioStreamDesc =>
      'Streaming audio langsung dari internet daripada mengunduh.';

  @override
  String get notUseAudioStreamDesc =>
      'Unduh audio untuk penggunaan offline dan kurangi konsumsi data.';

  @override
  String get audioSettings => 'Pengaturan Audio';

  @override
  String get playbackSpeed => 'Kecepatan Pemutaran';

  @override
  String get playbackSpeedDesc => 'Sesuaikan kecepatan bacaan Al-Quran.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Tunggu unduhan saat ini selesai.';

  @override
  String get areYouSure => 'Yakin?';

  @override
  String get checkYourInternetConnection => 'Periksa koneksi internet Anda.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Perlu unduh $requiredDownload dari $totalVersesCount ayat.';
  }

  @override
  String get download => 'Unduh';

  @override
  String get audioDownload => 'Unduh Audio';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Mengoptimalkan Naskah Al-Quran';

  @override
  String get supportOnGithub => 'Dukung di GitHub';

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
