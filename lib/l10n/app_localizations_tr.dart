// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

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
    return '$ayahKey için tefsir mevcut değil';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tefsir şu ayette bulunur: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey\'ye git';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Cüz';

  @override
  String get page => 'Sayfa';

  @override
  String get ruku => 'Rükû';

  @override
  String get languageSettings => 'Dil Ayarları';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayet';
  }

  @override
  String get saveAndDownload => 'Kaydet ve İndir';

  @override
  String get appLanguage => 'Uygulama Dili';

  @override
  String get selectAppLanguage => 'Uygulama dilini seçin...';

  @override
  String get pleaseSelectOne => 'Lütfen birini seçin';

  @override
  String get quranTranslationLanguage => 'Kur\'an Tercüme Dili';

  @override
  String get selectTranslationLanguage => 'Tercüme dilini seçin...';

  @override
  String get quranTranslationBook => 'Kur\'an Tercüme Kitabı';

  @override
  String get selectTranslationBook => 'Tercüme kitabını seçin...';

  @override
  String get quranTafsirLanguage => 'Kur\'an Tefsir Dili';

  @override
  String get selectTafsirLanguage => 'Tefsir dilini seçin...';

  @override
  String get quranTafsirBook => 'Kur\'an Tefsir Kitabı';

  @override
  String get selectTafsirBook => 'Tefsir kitabını seçin...';

  @override
  String get quranScriptAndStyle => 'Kur\'an Yazısı & Stili';

  @override
  String get justAMoment => 'Bir saniye...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Başarılı';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get unableToDownloadResources =>
      'Kaynaklar indirilemedi...\nBir şeyler ters gitti';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Bölümlü Kur\'an Okuması İndiriliyor';

  @override
  String get processingSegmentedQuranRecitation =>
      'Bölümlü Kur\'an Okuması İşleniyor';

  @override
  String get footnote => 'Dipnot';

  @override
  String get tafsir => 'Tefsir';

  @override
  String get wordByWord => 'Kelime Kelime';

  @override
  String get pleaseSelectRequiredOption => 'Lütfen gerekli seçeneği seçin';

  @override
  String get rememberHomeTab => 'Ana Sekmeyi Hatırla';

  @override
  String get rememberHomeTabSubtitle =>
      'Uygulama, ana ekranda en son açılan sekmeyi hatırlar.';

  @override
  String get wakeLock => 'Ekran Kilidi';

  @override
  String get wakeLockSubtitle => 'Ekranın otomatik kapanmasını önle.';

  @override
  String get settings => 'Ayarlar';

  @override
  String get appTheme => 'Uygulama Teması';

  @override
  String get quranStyle => 'Kur\'an Stili';

  @override
  String get changeTheme => 'Temayı Değiştir';

  @override
  String get verseCount => 'Ayet Sayısı: ';

  @override
  String get translation => 'Tercüme';

  @override
  String get tafsirNotFound => 'Bulunamadı';

  @override
  String get moreInfo => 'daha fazla bilgi';

  @override
  String get playAudio => 'Ses Çal';

  @override
  String get preview => 'Önizleme';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get errorFetchingAddress => 'Adres getirilirken hata';

  @override
  String get addressNotAvailable => 'Adres mevcut değil';

  @override
  String get latitude => 'Enlem: ';

  @override
  String get longitude => 'Boylam: ';

  @override
  String get name => 'İsim: ';

  @override
  String get location => 'Konum: ';

  @override
  String get parameters => 'Parametreler: ';

  @override
  String get selectCalculationMethod => 'Hesaplama Yöntemini Seçin';

  @override
  String get shareSelectAyahs => 'Seçili Ayetleri Paylaş';

  @override
  String get selectionEmpty => 'Seçim Boş';

  @override
  String get generatingImagePleaseWait =>
      'Görüntü Oluşturuluyor... Lütfen Bekleyin';

  @override
  String get asImage => 'Görüntü Olarak';

  @override
  String get asText => 'Metin Olarak';

  @override
  String get playFromSelectedAyah => 'Seçili Ayetten Çal';

  @override
  String get toTafsir => 'Tefsire Git';

  @override
  String get selectAyah => 'Ayet Seç';

  @override
  String get toAyah => 'Ayet\'e';

  @override
  String get searchForASurah => 'Bir sure ara';

  @override
  String get bugReportTitle => 'Hata Raporu';

  @override
  String get audioCached => 'Ses Önbelleğe Alındı';

  @override
  String get others => 'Diğerleri';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Kur\'an|Tercüme|Ayet, Biri Etkin Olmalı';

  @override
  String get quranFontSize => 'Kur\'an Yazı Boyutu';

  @override
  String get quranLineHeight => 'Kur\'an Satır Yüksekliği';

  @override
  String get translationAndTafsirFontSize => 'Tercüme & Tefsir Yazı Boyutu';

  @override
  String get quranAyah => 'Kur\'an Ayeti';

  @override
  String get topToolbar => 'Üst Araç Çubuğu';

  @override
  String get keepOpenWordByWord => 'Kelime Kelime Açık Tut';

  @override
  String get wordByWordHighlight => 'Kelime Kelime Vurgu';

  @override
  String get quranScriptSettings => 'Kur\'an Yazı Ayarları';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Sayfa: ';

  @override
  String get quranResources => 'Kur\'an Kaynakları';

  @override
  String alreadySelected(String name) {
    return '\'$name\' dili zaten seçili.';
  }

  @override
  String get unableToGetCompassData => 'Pusula verisi alınamadı';

  @override
  String get deviceDoesNotHaveSensors => 'Cihazda sensör yok!';

  @override
  String get north => 'K';

  @override
  String get east => 'D';

  @override
  String get south => 'G';

  @override
  String get west => 'B';

  @override
  String get address => 'Adres: ';

  @override
  String get change => 'Değiştir';

  @override
  String get calculationMethod => 'Hesaplama Yöntemi: ';

  @override
  String get downloadPrayerTime => 'Namaz Vakitlerini İndir';

  @override
  String get calculationMethodsListEmpty => 'Hesaplama yöntemleri listesi boş.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Konum verisiyle hiçbir hesaplama yöntemi bulunamadı.';

  @override
  String get prayerSettings => 'Namaz Ayarları';

  @override
  String get reminderSettings => 'Hatırlatma Ayarları';

  @override
  String get adjustReminderTime => 'Hatırlatma Zamanını Ayarla';

  @override
  String get enforceAlarmSound => 'Alarm Sesini Zorla';

  @override
  String get enforceAlarmSoundDescription =>
      'Etkinleştirilirse, bu özellik alarmı burada ayarlanan ses seviyesinde çalar, telefonunuzun sesi düşük olsa bile. Bu, düşük telefon sesi nedeniyle alarmı kaçırmamanızı sağlar.';

  @override
  String get volume => 'Ses Seviyesi';

  @override
  String get atPrayerTime => 'Namaz vaktinde';

  @override
  String minBefore(int minutes) {
    return '$minutes dakika önce';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes dakika sonra';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName vakti $prayerTime\'de';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName vakti geldi';
  }

  @override
  String get stopTheAdhan => 'Ezanı Durdur';

  @override
  String dateFoundEmpty(String date) {
    return '$date Boş Bulundu';
  }

  @override
  String get today => 'Bugün';

  @override
  String get left => 'Kalan';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName için hatırlatma eklendi';
  }

  @override
  String get allowNotificationPermission =>
      'Bu özelliği kullanmak için bildirim iznine izin verin';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName için hatırlatma kaldırıldı';
  }

  @override
  String get getPrayerTimesAndQibla => 'Namaz Vakitleri ve Kıble Al';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Herhangi Bir Konum İçin Namaz Vakitlerini ve Kıbleyi Hesapla.';

  @override
  String get getFromGPS => 'GPS\'ten Al';

  @override
  String get or => 'Veya';

  @override
  String get selectYourCity => 'Şehrinizi Seçin';

  @override
  String get noteAboutGPS =>
      'Not: GPS kullanmak istemiyorsanız veya güvensiz hissediyorsanız, şehrinizi seçebilirsiniz.';

  @override
  String get downloadingLocationResources => 'Konum kaynakları indiriliyor...';

  @override
  String get somethingWentWrong => 'Bir şeyler ters gitti';

  @override
  String get selectYourCountry => 'Ülkenizi Seçin';

  @override
  String get searchForACountry => 'Bir ülke ara';

  @override
  String get selectYourAdministrator => 'Yönetici Alanınızı Seçin';

  @override
  String get searchForAnAdministrator => 'Bir yönetici ara';

  @override
  String get searchForACity => 'Bir şehir ara';

  @override
  String get pleaseEnableLocationService =>
      'Lütfen konum servisini etkinleştirin';

  @override
  String get donateUs => 'Bize Bağış Yapın';

  @override
  String get underDevelopment => 'Geliştirme aşamasında';

  @override
  String get versionLoading => 'Yükleniyor...';

  @override
  String get alQuran => 'Kur\'an';

  @override
  String get mainMenu => 'Ana Menü';

  @override
  String get notes => 'Notlar';

  @override
  String get pinned => 'Sabitlenmiş';

  @override
  String get jumpToAyah => 'Ayete Git';

  @override
  String get shareMultipleAyah => 'Birden Fazla Ayeti Paylaş';

  @override
  String get shareThisApp => 'Bu Uygulamayı Paylaş';

  @override
  String get giveRating => 'Puan Ver';

  @override
  String get bugReport => 'Hata Raporu';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get aboutTheApp => 'Uygulama Hakkında';

  @override
  String get resetTheApp => 'Uygulamayı Sıfırla';

  @override
  String get resetAppWarningTitle => 'Uygulama Verilerini Sıfırla';

  @override
  String get resetAppWarningMessage =>
      'Uygulamayı sıfırlamak istediğinize emin misiniz? Tüm verileriniz silinecek ve uygulamayı baştan kurmanız gerekecek.';

  @override
  String get cancel => 'İptal';

  @override
  String get reset => 'Sıfırla';

  @override
  String get shareAppSubject => 'Bu Kur\'an Uygulamasını İnceleyin!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Günlük okuma ve tefekkür için bu Kur\'an uygulamasını inceleyin. Allah\'ın kelamıyla bağlantı kurmanıza yardımcı olur. Buradan indirin: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Çekmeceyi Aç';

  @override
  String get quran => 'Kur\'an';

  @override
  String get prayer => 'Namaz';

  @override
  String get qibla => 'Kıble';

  @override
  String get audio => 'Ses';

  @override
  String get surah => 'Sure';

  @override
  String get pages => 'Sayfalar';

  @override
  String get note => 'Not:';

  @override
  String get linkedAyahs => 'Bağlı Ayetler:';

  @override
  String get emptyNoteCollection =>
      'Bu not koleksiyonu boş.\nBurada görmek için bazı notlar ekleyin.';

  @override
  String get emptyPinnedCollection =>
      'Bu koleksiyona henüz ayet sabitlenmemiş.\nGörmek için ayetleri sabitleyin.';

  @override
  String get noContentAvailable => 'İçerik mevcut değil.';

  @override
  String failedToLoadCollections(String error) {
    return 'Koleksiyonlar yüklenemedi: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType Adına Göre Ara...';
  }

  @override
  String get sortBy => 'Sırala';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Henüz $collectionType eklenmemiş';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count sabitlenmiş öğe';
  }

  @override
  String notesCount(int count) {
    return '$count not';
  }

  @override
  String get emptyNameNotAllowed => 'Boş isim izin verilmez';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName\'e güncellendi';
  }

  @override
  String get changeName => 'İsmi Değiştir';

  @override
  String get changeColor => 'Rengi Değiştir';

  @override
  String get colorUpdated => 'Renk güncellendi';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Silindi';
  }

  @override
  String get delete => 'Sil';

  @override
  String get save => 'Kaydet';

  @override
  String get collectionNameCannotBeEmpty => 'Koleksiyon adı boş olamaz.';

  @override
  String get addedNewCollection => 'Yeni Koleksiyon Eklendi';

  @override
  String ayahCount(int count) {
    return '$count Ayet';
  }

  @override
  String get byNameAtoZ => 'İsime Göre A-Z';

  @override
  String get byNameZtoA => 'İsime Göre Z-A';

  @override
  String get byElementNumberAscending => 'Öğe Numarasına Göre Artan';

  @override
  String get byElementNumberDescending => 'Öğe Numarasına Göre Azalan';

  @override
  String get byUpdateDateAscending => 'Güncelleme Tarihine Göre Artan';

  @override
  String get byUpdateDateDescending => 'Güncelleme Tarihine Göre Azalan';

  @override
  String get byCreateDateAscending => 'Oluşturma Tarihine Göre Artan';

  @override
  String get byCreateDateDescending => 'Oluşturma Tarihine Göre Azalan';

  @override
  String get translationNotFound => 'Tercüme Bulunamadı';

  @override
  String get translationTitle => 'Tercüme:';

  @override
  String get footNoteTitle => 'Dipnot:';

  @override
  String get wordByWordTranslation => 'Kelime Kelime Tercüme:';

  @override
  String get tafsirButton => 'Tefsir';

  @override
  String get shareButton => 'Paylaş';

  @override
  String get addNoteButton => 'Not Ekle';

  @override
  String get pinToCollectionButton => 'Koleksiyona Sabitle';

  @override
  String get shareAsText => 'Metin Olarak Paylaş';

  @override
  String get copiedWithTafsir => 'Tefsirle Kopyalandı';

  @override
  String get shareAsImage => 'Görüntü Olarak Paylaş';

  @override
  String get shareWithTafsir => 'Tefsirle Paylaş';

  @override
  String get notFound => 'Bulunamadı';

  @override
  String get noteContentCannotBeEmpty => 'Not içeriği boş olamaz.';

  @override
  String get noteSavedSuccessfully => 'Not başarıyla kaydedildi!';

  @override
  String get selectCollections => 'Koleksiyonları Seç';

  @override
  String get addNote => 'Not Ekle';

  @override
  String get writeCollectionName => 'Koleksiyon adını yazın...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Henüz koleksiyon yok. Yeni bir tane ekleyin!';

  @override
  String get pleaseWriteYourNoteFirst => 'Lütfen önce notunuzu yazın.';

  @override
  String get noCollectionSelected => 'Koleksiyon seçilmedi';

  @override
  String get saveNote => 'Notu Kaydet';

  @override
  String get nextSelectCollections => 'Sonraki: Koleksiyonları Seç';

  @override
  String get addToPinned => 'Sabitlenmişlere Ekle';

  @override
  String get pinnedSavedSuccessfully => 'Sabitleme başarıyla kaydedildi!';

  @override
  String get savePinned => 'Sabitlemeyi Kaydet';

  @override
  String get closeAudioController => 'Ses Denetleyicisini Kapat';

  @override
  String get previous => 'Önceki';

  @override
  String get rewind => 'Geri Sar';

  @override
  String get fastForward => 'İleri Sar';

  @override
  String get playNextAyah => 'Sonraki Ayeti Çal';

  @override
  String get repeat => 'Tekrarla';

  @override
  String get playAsPlaylist => 'Çalma Listesi Olarak Çal';

  @override
  String style(String style) {
    return 'Stil: $style';
  }

  @override
  String get stopAndClose => 'Durdur & Kapat';

  @override
  String get play => 'Çal';

  @override
  String get pause => 'Duraklat';

  @override
  String get selectReciter => 'Okuyucu Seç';

  @override
  String source(String source) {
    return 'Kaynak: $source';
  }

  @override
  String get newText => 'Yeni';

  @override
  String get more => 'Daha Fazla: ';

  @override
  String get cacheNotFound => 'Önbellek Bulunamadı';

  @override
  String get cacheSize => 'Önbellek Boyutu';

  @override
  String error(String error) {
    return 'Hata: $error';
  }

  @override
  String get clean => 'Temizle';

  @override
  String get lastModified => 'Son Değiştirme';

  @override
  String get oneYearAgo => '1 Yıl önce';

  @override
  String monthsAgo(String number) {
    return '$number Ay önce';
  }

  @override
  String weeksAgo(String number) {
    return '$number Hafta önce';
  }

  @override
  String daysAgo(String number) {
    return '$number Gün önce';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour Saat önce';
  }

  @override
  String get aboutAlQuran => 'Kur\'an Hakkında';

  @override
  String get appFullName => 'Kur\'an (Tefsir, Namaz, Kıble, Ses)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux ve Windows için kapsamlı bir İslami uygulama. Kur\'an okuma, tefsir ve birden fazla tercüme (kelime kelime dahil), dünya çapında namaz vakitleri, kıble pusulası ve senkronize kelime kelime sesli okuma sunar.';

  @override
  String get dataSourcesNote =>
      'Not: Kur\'an metinleri, tefsir, tercümeler ve ses kaynakları Quran.com, Everyayah.com ve diğer doğrulanmış açık kaynaklardan alınmıştır.';

  @override
  String get adFreePromise =>
      'Bu uygulama Allah\'ın rızasını kazanmak için yapılmıştır. Bu yüzden tamamen Reklamsızdır ve her zaman öyle kalacaktır.';

  @override
  String get coreFeatures => 'Temel Özellikler';

  @override
  String get coreFeaturesDescription =>
      'Al Quran v3\'ü günlük İslami uygulamalarınız için vazgeçilmez bir araç yapan ana işlevleri keşfedin:';

  @override
  String get prayerTimesTitle => 'Namaz Vakitleri & Uyarılar';

  @override
  String get prayerTimesDescription =>
      'Dünya çapında herhangi bir konum için doğru namaz vakitleri, çeşitli hesaplama yöntemleri kullanarak. Ezan bildirimleriyle hatırlatmalar ayarlayın.';

  @override
  String get qiblaDirectionTitle => 'Kıble Yönü';

  @override
  String get qiblaDirectionDescription =>
      'Net ve doğru bir pusula görünümüyle kıble yönünü kolayca bulun.';

  @override
  String get translationTafsirTitle => 'Kur\'an Tercüme & Tefsir';

  @override
  String get translationTafsirDescription =>
      '69 dilde 120+ tercüme kitabı (kelime kelime dahil) ve 30+ tefsir kitabı erişimi.';

  @override
  String get wordByWordAudioTitle => 'Kelime Kelime Ses & Vurgulama';

  @override
  String get wordByWordAudioDescription =>
      'Senkronize kelime kelime sesli okuma ve vurgulamayla sürükleyici bir öğrenme deneyimi için takip edin.';

  @override
  String get ayahAudioRecitationTitle => 'Ayet Sesli Okuma';

  @override
  String get ayahAudioRecitationDescription =>
      '40+ ünlü okuyucudan tam ayet okumalarını dinleyin.';

  @override
  String get notesCloudBackupTitle => 'Notlar ve Bulut Yedekleme';

  @override
  String get notesCloudBackupDescription =>
      'Kişisel notlar ve yansımalar kaydedin, buluta güvenli bir şekilde yedeklenir (geliştirme aşamasında/yakında).';

  @override
  String get crossPlatformSupportTitle => 'Çoklu Platform Desteği';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux ve Windows\'ta desteklenir.';

  @override
  String get backgroundAudioPlaybackTitle => 'Arka Plan Ses Çalma';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Uygulama arka planda olsa bile Kur\'an okumasına devam edin.';

  @override
  String get audioDataCachingTitle => 'Ses & Veri Önbellekleme';

  @override
  String get audioDataCachingDescription =>
      'Sağlam ses ve Kur\'an veri önbelleklemesiyle geliştirilmiş oynatma ve çevrimdışı yetenekler.';

  @override
  String get minimalisticInterfaceTitle => 'Minimalist & Temiz Arayüz';

  @override
  String get minimalisticInterfaceDescription =>
      'Kullanıcı deneyimine ve okunabilirliğe odaklanan kolay gezinme arayüzü.';

  @override
  String get optimizedPerformanceTitle => 'Optimize Edilmiş Performans & Boyut';

  @override
  String get optimizedPerformanceDescription =>
      'Özellik dolu bir uygulama, hafif ve performant olacak şekilde tasarlandı.';

  @override
  String get languageSupport => 'Dil Desteği';

  @override
  String get languageSupportDescription =>
      'Bu uygulama küresel bir kitleye erişilebilir olacak şekilde tasarlandı ve şu dilleri destekliyor (ve daha fazlası sürekli ekleniyor):';

  @override
  String get technologyAndResources => 'Teknoloji & Kaynaklar';

  @override
  String get technologyAndResourcesDescription =>
      'Bu uygulama son teknoloji ve güvenilir kaynaklar kullanılarak yapıldı:';

  @override
  String get flutterFrameworkTitle => 'Flutter Çerçevesi';

  @override
  String get flutterFrameworkDescription =>
      'Tek bir kod tabanından güzel, yerel derlenmiş, çoklu platform deneyimi için Flutter ile yapıldı.';

  @override
  String get advancedAudioEngineTitle => 'Gelişmiş Ses Motoru';

  @override
  String get advancedAudioEngineDescription =>
      'Sağlam ses çalma ve kontrol için `just_audio` ve `just_audio_background` Flutter paketleri tarafından desteklenir.';

  @override
  String get reliableQuranDataTitle => 'Güvenilir Kur\'an Verileri';

  @override
  String get reliableQuranDataDescription =>
      'Kur\'an metinleri, tercümeler, tefsirler ve sesler, Quran.com & Everyayah.com gibi doğrulanmış açık API\'ler ve veritabanlarından alınır.';

  @override
  String get prayerTimeEngineTitle => 'Namaz Vakti Motoru';

  @override
  String get prayerTimeEngineDescription =>
      'Doğru namaz vakitleri için yerleşik hesaplama yöntemleri kullanır. Bildirimler `flutter_local_notifications` ve arka plan görevleri tarafından yönetilir.';

  @override
  String get crossPlatformSupport => 'Çoklu Platform Desteği';

  @override
  String get crossPlatformSupportDescription2 =>
      'Çeşitli platformlarda kesintisiz erişimin keyfini çıkarın:';

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
  String get ourLifetimePromise => 'Ömür Boyu Sözümüz';

  @override
  String get lifetimePromiseDescription =>
      'Bu uygulamaya ömrüm boyunca sürekli destek ve bakım sağlayacağımı şahsen söz veriyorum, İnşallah. Amacım, bu uygulamanın Ümmet için yıllarca faydalı bir kaynak olarak kalmasını sağlamak.';

  @override
  String get fajr => 'Sabah';

  @override
  String get sunrise => 'Gündoğumu';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Öğle';

  @override
  String get asr => 'İkindi';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'Akşam';

  @override
  String get isha => 'Yatsı';

  @override
  String get midnight => 'Gece Yarısı';

  @override
  String get alarm => 'Alarm';

  @override
  String get notification => 'Bildirim';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tecvid';

  @override
  String get quranScriptUthmani => 'Osmanlı';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Secde Ayeti';

  @override
  String get required => 'Gerekli';

  @override
  String get optional => 'İsteğe Bağlı';

  @override
  String get notificationScheduleWarning =>
      'Not: Zamanlanmış Bildirim veya Hatırlatma, telefonunuzun OS arka plan işlem kısıtlamaları nedeniyle kaçırılabilir. Örneğin: Vivo\'nun Origin OS, Samsung\'un One UI, Oppo\'nun ColorOS vb. bazen zamanlanmış Bildirim veya Hatırlatmayı öldürür. Lütfen OS ayarlarınızı kontrol edin ve uygulamayı arka plan işleminden kısıtlamayın.';

  @override
  String get scrollWithRecitation => 'Okumayla Kaydır';

  @override
  String get quickAccess => 'Hızlı Erişim';

  @override
  String get initiallyScrollAyah => 'Başlangıçta ayete kaydır';

  @override
  String get tajweedGuide => 'Tecvid Rehberi';

  @override
  String get scrollWithRecitationDesc =>
      'Etkinleştirildiğinde, Kur\'an ayeti sesli okumayla senkronize olarak otomatik kayar.';

  @override
  String get configuration => 'Yapılandırma';

  @override
  String get restoreFromBackup => 'Yedekten Geri Yükle';

  @override
  String get history => 'Geçmiş';

  @override
  String get search => 'Ara';

  @override
  String get useAudioStream => 'Ses Akışı Kullan';

  @override
  String get useAudioStreamDesc =>
      'Sesleri indirmek yerine doğrudan internetten akıt.';

  @override
  String get notUseAudioStreamDesc =>
      'Çevrimdışı kullanım için ses indir ve veri tüketimini azalt.';

  @override
  String get audioSettings => 'Ses Ayarları';

  @override
  String get playbackSpeed => 'Çalma Hızı';

  @override
  String get playbackSpeedDesc => 'Kur\'an Okuma hızını ayarla.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Lütfen mevcut indirmenin bitmesini bekleyin.';

  @override
  String get areYouSure => 'Emin misiniz?';

  @override
  String get checkYourInternetConnection =>
      'İnternet bağlantınızı kontrol edin.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount ayetten $requiredDownload indirilmesi gerekiyor.';
  }

  @override
  String get download => 'İndir';

  @override
  String get audioDownload => 'Ses İndirme';

  @override
  String get am => 'ÖÖ';

  @override
  String get pm => 'ÖS';

  @override
  String get optimizingQuranScript => 'Kur\'an Yazısını Optimize Ediliyor';

  @override
  String get supportOnGithub => 'GitHub\'da Destekleyin';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafieMalikiHanbali => 'Shafie, Maliki, Hanbali';
}
