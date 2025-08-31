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
    return 'Tefsir şurada bulunabilir: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey adresine git';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Cüz';

  @override
  String get page => 'Sayfa';

  @override
  String get ruku => 'Rukû';

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
  String get quranTranslationLanguage => 'Kur\'an Meali Dili';

  @override
  String get selectTranslationLanguage => 'Meal dilini seçin...';

  @override
  String get quranTranslationBook => 'Kur\'an Meali Kitabı';

  @override
  String get selectTranslationBook => 'Meal kitabını seçin...';

  @override
  String get quranTafsirLanguage => 'Kur\'an Tefsiri Dili';

  @override
  String get selectTafsirLanguage => 'Tefsir dilini seçin...';

  @override
  String get quranTafsirBook => 'Kur\'an Tefsiri Kitabı';

  @override
  String get selectTafsirBook => 'Tefsir kitabını seçin...';

  @override
  String get quranScriptAndStyle => 'Kur\'an Yazı Tipi ve Stili';

  @override
  String get justAMoment => 'Biraz bekleyin...';

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
      'Kaynaklar indirilemedi...\nBir hata oluştu';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Bölümlere Ayrılmış Kur\'an Kıraati İndiriliyor';

  @override
  String get processingSegmentedQuranRecitation =>
      'Bölümlere Ayrılmış Kur\'an Kıraati İşleniyor';

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
      'Uygulama, ana ekranda son açılan sekmeyi hatırlayacaktır.';

  @override
  String get wakeLock => 'Ekranı Açık Tut';

  @override
  String get wakeLockSubtitle =>
      'Ekranın otomatik olarak kapanmasını engeller.';

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
  String get translation => 'Meal';

  @override
  String get tafsirNotFound => 'Bulunamadı';

  @override
  String get moreInfo => 'daha fazla bilgi';

  @override
  String get playAudio => 'Sesi Oynat';

  @override
  String get preview => 'Önizleme';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get errorFetchingAddress => 'Adres alınırken hata oluştu';

  @override
  String get addressNotAvailable => 'Adres mevcut değil';

  @override
  String get latitude => 'Enlem: ';

  @override
  String get longitude => 'Boylam: ';

  @override
  String get name => 'Ad: ';

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
  String get asImage => 'Resim Olarak';

  @override
  String get asText => 'Metin Olarak';

  @override
  String get playFromSelectedAyah => 'Seçili Ayetten Oynat';

  @override
  String get toTafsir => 'Tefsire Git';

  @override
  String get selectAyah => 'Ayet Seç';

  @override
  String get toAyah => 'Ayete Git';

  @override
  String get searchForASurah => 'Sure ara';

  @override
  String get bugReportTitle => 'Hata Bildirimi';

  @override
  String get audioCached => 'Ses Önbelleğe Alındı';

  @override
  String get others => 'Diğerleri';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Kur\'an|Meal|Ayet, Bir tanesi etkinleştirilmelidir';

  @override
  String get quranFontSize => 'Kur\'an Yazı Tipi Boyutu';

  @override
  String get quranLineHeight => 'Kur\'an Satır Yüksekliği';

  @override
  String get translationAndTafsirFontSize => 'Meal ve Tefsir Yazı Tipi Boyutu';

  @override
  String get quranAyah => 'Kur\'an Ayeti';

  @override
  String get topToolbar => 'Üst Araç Çubuğu';

  @override
  String get keepOpenWordByWord => 'Kelime Kelimeyi Açık Tut';

  @override
  String get wordByWordHighlight => 'Kelime Kelime Vurgulama';

  @override
  String get quranScriptSettings => 'Kur\'an Yazı Tipi Ayarları';

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
  String get unableToGetCompassData => 'Pusula verileri alınamıyor';

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
      'Konum verileriyle uyumlu bir hesaplama yöntemi bulunamadı.';

  @override
  String get prayerSettings => 'Namaz Ayarları';

  @override
  String get reminderSettings => 'Hatırlatıcı Ayarları';

  @override
  String get adjustReminderTime => 'Hatırlatma Zamanını Ayarla';

  @override
  String get enforceAlarmSound => 'Alarm Sesini Zorla';

  @override
  String get enforceAlarmSoundDescription =>
      'Etkinleştirilirse, bu özellik telefonunuzun sesi kısık olsa bile alarmı burada ayarlanan ses seviyesinde çalar. Bu, düşük telefon sesi nedeniyle alarmı kaçırmamanızı sağlar.';

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
    return '$prayerName vakti: $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName vakti girdi';
  }

  @override
  String get stopTheAdhan => 'Ezanı Durdur';

  @override
  String dateFoundEmpty(String date) {
    return '$date için veri bulunamadı';
  }

  @override
  String get today => 'Bugün';

  @override
  String get left => 'Kaldı';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName için hatırlatıcı eklendi';
  }

  @override
  String get allowNotificationPermission =>
      'Bu özelliği kullanmak için lütfen bildirim iznine izin verin';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName için hatırlatıcı kaldırıldı';
  }

  @override
  String get getPrayerTimesAndQibla => 'Namaz Vakitlerini ve Kıbleyi Bul';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Belirtilen konum için Namaz Vakitlerini ve Kıbleyi hesaplayın.';

  @override
  String get getFromGPS => 'GPS\'ten Al';

  @override
  String get or => 'Veya';

  @override
  String get selectYourCity => 'Şehrinizi Seçin';

  @override
  String get noteAboutGPS =>
      'Not: GPS kullanmak istemiyorsanız veya kendinizi güvende hissetmiyorsanız, şehrinizi seçebilirsiniz.';

  @override
  String get downloadingLocationResources => 'Konum kaynakları indiriliyor...';

  @override
  String get somethingWentWrong => 'Bir şeyler ters gitti';

  @override
  String get selectYourCountry => 'Ülkenizi Seçin';

  @override
  String get searchForACountry => 'Bir ülke arayın';

  @override
  String get selectYourAdministrator => 'Kurumunuzu Seçin';

  @override
  String get searchForAnAdministrator => 'Bir kurum arayın';

  @override
  String get searchForACity => 'Bir şehir arayın';

  @override
  String get pleaseEnableLocationService =>
      'Lütfen konum servisini etkinleştirin';

  @override
  String get donateUs => 'Bağış Yapın';

  @override
  String get underDevelopment => 'Geliştirme aşamasında';

  @override
  String get versionLoading => 'Yükleniyor...';

  @override
  String get alQuran => 'Kur\'an-ı Kerim';

  @override
  String get mainMenu => 'Ana Menü';

  @override
  String get notes => 'Notlar';

  @override
  String get pinned => 'Sabitlenmiş';

  @override
  String get jumpToAyah => 'Ayete Git';

  @override
  String get shareMultipleAyah => 'Birden Fazla Ayet Paylaş';

  @override
  String get shareThisApp => 'Uygulamayı Paylaş';

  @override
  String get giveRating => 'Puan Ver';

  @override
  String get bugReport => 'Hata Bildir';

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
      'Uygulamayı sıfırlamak istediğinizden emin misiniz? Tüm verileriniz kaybolacak ve uygulamayı baştan kurmanız gerekecek.';

  @override
  String get cancel => 'İptal';

  @override
  String get reset => 'Sıfırla';

  @override
  String get shareAppSubject => 'Bu Kur\'an Uygulamasına bir göz at!';

  @override
  String shareAppBody(String appLink) {
    return 'Selamun Aleyküm! Günlük okuma ve tefekkür için bu Kur\'an uygulamasına bir göz atın. Allah\'ın kelamıyla bağ kurmaya yardımcı olur. Buradan indirin: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Menüyü Aç';

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
  String get linkedAyahs => 'İlişkili Ayetler:';

  @override
  String get emptyNoteCollection =>
      'Bu not koleksiyonu boş.\nBurada görmek için birkaç not ekleyin.';

  @override
  String get emptyPinnedCollection =>
      'Bu koleksiyona henüz sabitlenmiş Ayet yok.\nBurada görmek için Ayetleri sabitleyin.';

  @override
  String get noContentAvailable => 'Kullanılabilir içerik yok.';

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
    return 'Henüz $collectionType eklenmedi';
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
  String get emptyNameNotAllowed => 'Boş isme izin verilmez';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName olarak güncellendi';
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
  String get byNameAtoZ => 'İsim A-Z';

  @override
  String get byNameZtoA => 'İsim Z-A';

  @override
  String get byElementNumberAscending => 'Öğe Numarası Artan';

  @override
  String get byElementNumberDescending => 'Öğe Numarası Azalan';

  @override
  String get byUpdateDateAscending => 'Güncelleme Tarihi Artan';

  @override
  String get byUpdateDateDescending => 'Güncelleme Tarihi Azalan';

  @override
  String get byCreateDateAscending => 'Oluşturma Tarihi Artan';

  @override
  String get byCreateDateDescending => 'Oluşturma Tarihi Azalan';

  @override
  String get translationNotFound => 'Meal Bulunamadı';

  @override
  String get translationTitle => 'Meal:';

  @override
  String get footNoteTitle => 'Dipnot:';

  @override
  String get wordByWordTranslation => 'Kelime Kelime Meal:';

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
  String get copiedWithTafsir => 'Tefsir ile Kopyalandı';

  @override
  String get shareAsImage => 'Resim Olarak Paylaş';

  @override
  String get shareWithTafsir => 'Tefsir ile Paylaş';

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
  String get writeCollectionName => 'Koleksiyon adı yazın...';

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
  String get addToPinned => 'Sabitlenenlere Ekle';

  @override
  String get pinnedSavedSuccessfully => 'Sabitlenenlere başarıyla kaydedildi!';

  @override
  String get savePinned => 'Sabitleneni Kaydet';

  @override
  String get closeAudioController => 'Ses Kontrolcüsünü Kapat';

  @override
  String get previous => 'Önceki';

  @override
  String get rewind => 'Geri Sar';

  @override
  String get fastForward => 'İleri Sar';

  @override
  String get playNextAyah => 'Sonraki Ayeti Oynat';

  @override
  String get repeat => 'Tekrarla';

  @override
  String get playAsPlaylist => 'Oynatma Listesi Olarak Oynat';

  @override
  String style(String style) {
    return 'Stil: $style';
  }

  @override
  String get stopAndClose => 'Durdur ve Kapat';

  @override
  String get play => 'Oynat';

  @override
  String get pause => 'Duraklat';

  @override
  String get selectReciter => 'Kâri Seç';

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
  String get aboutAlQuran => 'Kur\'an-ı Kerim Hakkında';

  @override
  String get appFullName => 'Kur\'an-ı Kerim (Tefsir, Namaz, Kıble, Ses)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux ve Windows için Tefsir ve çoklu mealler (kelime kelime dahil) ile Kur\'an okuma, bildirimli dünya çapında namaz vakitleri, Kıble pusulası ve senkronize kelime kelime sesli kıraat sunan kapsamlı bir İslami uygulama.';

  @override
  String get dataSourcesNote =>
      'Not: Kur\'an metinleri, Tefsir, mealler ve ses kaynakları Quran.com, Everyayah.com ve diğer doğrulanmış açık kaynaklardan alınmıştır.';

  @override
  String get adFreePromise =>
      'Bu uygulama Allah\'ın rızasını kazanmak için yapılmıştır. Bu nedenle, tamamen Reklamsızdır ve her zaman öyle kalacaktır.';

  @override
  String get coreFeatures => 'Ana Özellikler';

  @override
  String get coreFeaturesDescription =>
      'Kur\'an-ı Kerim v3\'ü günlük İslami uygulamalarınız için vazgeçilmez bir araç yapan temel işlevleri keşfedin:';

  @override
  String get prayerTimesTitle => 'Namaz Vakitleri ve Uyarılar';

  @override
  String get prayerTimesDescription =>
      'Çeşitli hesaplama yöntemlerini kullanarak dünya çapında herhangi bir konum için doğru namaz vakitleri. Ezan bildirimleriyle hatırlatıcılar ayarlayın.';

  @override
  String get qiblaDirectionTitle => 'Kıble Yönü';

  @override
  String get qiblaDirectionDescription =>
      'Açık ve doğru bir pusula görünümüyle Kıble yönünü kolayca bulun.';

  @override
  String get translationTafsirTitle => 'Kur\'an Meali ve Tefsiri';

  @override
  String get translationTafsirDescription =>
      '69 dilde 120\'den fazla meal kitabına (kelime kelime dahil) ve 30\'dan fazla Tefsir kitabına erişin.';

  @override
  String get wordByWordAudioTitle => 'Kelime Kelime Ses ve Vurgulama';

  @override
  String get wordByWordAudioDescription =>
      'Sürükleyici bir öğrenme deneyimi için senkronize kelime kelime sesli kıraati ve vurgulamayı takip edin.';

  @override
  String get ayahAudioRecitationTitle => 'Ayet Sesli Kıraati';

  @override
  String get ayahAudioRecitationDescription =>
      '40\'tan fazla ünlü kârinin tam Ayet kıraatlerini dinleyin.';

  @override
  String get notesCloudBackupTitle => 'Bulut Yedeklemeli Notlar';

  @override
  String get notesCloudBackupDescription =>
      'Kişisel notları ve tefekkürleri kaydedin, buluta güvenli bir şekilde yedeklenir (özellik geliştirme aşamasında/yakında gelecek).';

  @override
  String get crossPlatformSupportTitle => 'Çapraz Platform Desteği';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux ve Windows\'ta desteklenmektedir.';

  @override
  String get backgroundAudioPlaybackTitle => 'Arka Planda Ses Oynatma';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Uygulama arka planda olsa bile Kur\'an kıraatini dinlemeye devam edin.';

  @override
  String get audioDataCachingTitle => 'Ses ve Veri Önbellekleme';

  @override
  String get audioDataCachingDescription =>
      'Güçlü ses ve Kur\'an verisi önbellekleme ile geliştirilmiş oynatma ve çevrimdışı yetenekler.';

  @override
  String get minimalisticInterfaceTitle => 'Minimalist ve Sade Arayüz';

  @override
  String get minimalisticInterfaceDescription =>
      'Kullanıcı deneyimi ve okunabilirliğe odaklanan, gezinmesi kolay arayüz.';

  @override
  String get optimizedPerformanceTitle =>
      'Optimize Edilmiş Performans ve Boyut';

  @override
  String get optimizedPerformanceDescription =>
      'Hafif ve performanslı olacak şekilde tasarlanmış, zengin özelliklere sahip bir uygulama.';

  @override
  String get languageSupport => 'Dil Desteği';

  @override
  String get languageSupportDescription =>
      'Bu uygulama, aşağıdaki diller için destekle küresel bir kitleye erişilebilir olacak şekilde tasarlanmıştır (ve sürekli olarak yenileri eklenmektedir):';

  @override
  String get technologyAndResources => 'Teknoloji ve Kaynaklar';

  @override
  String get technologyAndResourcesDescription =>
      'Bu uygulama, en son teknolojiler ve güvenilir kaynaklar kullanılarak oluşturulmuştur:';

  @override
  String get flutterFrameworkTitle => 'Flutter Çatısı';

  @override
  String get flutterFrameworkDescription =>
      'Tek bir kod tabanından güzel, yerel olarak derlenmiş, çok platformlu bir deneyim için Flutter ile oluşturulmuştur.';

  @override
  String get advancedAudioEngineTitle => 'Gelişmiş Ses Motoru';

  @override
  String get advancedAudioEngineDescription =>
      'Güçlü ses oynatma ve kontrolü için `just_audio` ve `just_audio_background` Flutter paketleri tarafından desteklenmektedir.';

  @override
  String get reliableQuranDataTitle => 'Güvenilir Kur\'an Verileri';

  @override
  String get reliableQuranDataDescription =>
      'Kur\'an metinleri, mealler, tefsirler ve sesler Quran.com & Everyayah.com gibi doğrulanmış açık API\'lerden ve veritabanlarından alınmıştır.';

  @override
  String get prayerTimeEngineTitle => 'Namaz Vakti Motoru';

  @override
  String get prayerTimeEngineDescription =>
      'Doğru namaz vakitleri için yerleşik hesaplama yöntemlerini kullanır. Bildirimler `flutter_local_notifications` ve arka plan görevleri tarafından yönetilir.';

  @override
  String get crossPlatformSupport => 'Çapraz Platform Desteği';

  @override
  String get crossPlatformSupportDescription2 =>
      'Çeşitli platformlarda sorunsuz erişimin keyfini çıkarın:';

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
      'Şahsen, hayatım boyunca bu uygulama için sürekli destek ve bakım sağlayacağıma söz veriyorum, İnşaAllah. Amacım, bu uygulamanın gelecek yıllarda Ümmet için faydalı bir kaynak olarak kalmasını sağlamaktır.';

  @override
  String get fajr => 'İmsak';

  @override
  String get sunrise => 'Güneş';

  @override
  String get dhuhr => 'Öğle';

  @override
  String get asr => 'İkindi';

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
  String get quranScriptTajweed => 'Tecvidli';

  @override
  String get quranScriptUthmani => 'Osmanlı Hattı';

  @override
  String get quranScriptIndopak => 'Indopak';

  @override
  String get sajdaAyah => 'Secde Ayeti';

  @override
  String get required => 'Vacip';

  @override
  String get optional => 'İsteğe Bağlı';

  @override
  String get notificationScheduleWarning =>
      'Not: Telefonunuzun işletim sisteminin arka plan işlem kısıtlamaları nedeniyle zamanlanmış Bildirim veya Hatırlatma kaçırılabilir. Örneğin: Vivo\'nun Origin OS\'u, Samsung\'un One UI\'ı, Oppo\'nun ColorOS\'u vb. bazen zamanlanmış Bildirim veya Hatırlatmayı sonlandırır. Uygulamanın arka plan işleminden kısıtlanmaması için lütfen işletim sistemi ayarlarınızı kontrol edin.';

  @override
  String get scrollWithRecitation => 'Okunuşla Kaydır';

  @override
  String get scrollWithRecitationDesc =>
      'When enabled, the Quran ayah will automatically scroll in sync with the audio recitation.';

  @override
  String get quickAccess => 'Hızlı Erişim';

  @override
  String get initiallyScrollAyah => 'Başlangıçta ayete gidin';

  @override
  String get tajweedGuide => 'Tecvid Rehberi';

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
