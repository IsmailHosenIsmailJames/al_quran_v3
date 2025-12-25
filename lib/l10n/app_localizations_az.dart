// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

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
    return '$ayahKey üçün təfsir mövcud deyil';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Təfsir burada tapılacaq: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey-ə keç';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Cüz';

  @override
  String get page => 'Səhifə';

  @override
  String get ruku => 'Rüku';

  @override
  String get languageSettings => 'Dil Parametrləri';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayə';
  }

  @override
  String get saveAndDownload => 'Yadda saxla və Yüklə';

  @override
  String get appLanguage => 'Tətbiq Dili';

  @override
  String get selectAppLanguage => 'Tətbiq dilini seçin...';

  @override
  String get pleaseSelectOne => 'Zəhmət olmasa birini seçin';

  @override
  String get quranTranslationLanguage => 'Quran Tərcümə Dili';

  @override
  String get selectTranslationLanguage => 'Tərcümə dilini seçin...';

  @override
  String get quranTranslationBook => 'Quran Tərcümə Kitabı';

  @override
  String get selectTranslationBook => 'Tərcümə kitabını seçin...';

  @override
  String get quranTafsirLanguage => 'Quran Təfsir Dili';

  @override
  String get selectTafsirLanguage => 'Təfsir dilini seçin...';

  @override
  String get quranTafsirBook => 'Quran Təfsir Kitabı';

  @override
  String get selectTafsirBook => 'Təfsir kitabını seçin...';

  @override
  String get quranScriptAndStyle => 'Quran Xətti və Üslubu';

  @override
  String get justAMoment => 'Bir az gözləyin...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Uğurlu';

  @override
  String get retry => 'Yenidən cəhd et';

  @override
  String get unableToDownloadResources =>
      'Resursları yükləmək mümkün olmadı...\nXəta baş verdi';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Hissəli Quran Tilavəti Yüklənir';

  @override
  String get processingSegmentedQuranRecitation =>
      'Hissəli Quran Tilavəti Emal Edilir';

  @override
  String get footnote => 'Qeyd';

  @override
  String get tafsir => 'Təfsir';

  @override
  String get wordByWord => 'Sözbəsöz';

  @override
  String get pleaseSelectRequiredOption =>
      'Zəhmət olmasa, tələb olunan seçimi edin';

  @override
  String get rememberHomeTab => 'Əsas Səhifəni Yadda Saxla';

  @override
  String get rememberHomeTabSubtitle =>
      'Tətbiq əsas ekranda son açılan səhifəni yadda saxlayacaq.';

  @override
  String get wakeLock => 'Ekranı Açıq Saxla';

  @override
  String get wakeLockSubtitle => 'Ekranın avtomatik sönməsinin qarşısını alır.';

  @override
  String get settings => 'Parametrlər';

  @override
  String get appTheme => 'Tətbiq Mövzusu';

  @override
  String get quranStyle => 'Quran Üslubu';

  @override
  String get changeTheme => 'Mövzunu Dəyiş';

  @override
  String get verseCount => 'Ayə Sayı: ';

  @override
  String get translation => 'Tərcümə';

  @override
  String get tafsirNotFound => 'Tapılmadı';

  @override
  String get moreInfo => 'daha çox məlumat';

  @override
  String get playAudio => 'Səsi Oxut';

  @override
  String get preview => 'Önizləmə';

  @override
  String get loading => 'Yüklənir...';

  @override
  String get errorFetchingAddress => 'Ünvanı alarkən xəta baş verdi';

  @override
  String get addressNotAvailable => 'Ünvan mövcud deyil';

  @override
  String get latitude => 'Enlik: ';

  @override
  String get longitude => 'Uzunluq: ';

  @override
  String get name => 'Ad: ';

  @override
  String get location => 'Məkan: ';

  @override
  String get parameters => 'Parametrlər: ';

  @override
  String get selectCalculationMethod => 'Hesablama Metodunu Seçin';

  @override
  String get shareSelectAyahs => 'Seçilmiş Ayələri Paylaş';

  @override
  String get selectionEmpty => 'Seçim Boşdur';

  @override
  String get generatingImagePleaseWait =>
      'Şəkil Yaradılır... Zəhmət olmasa Gözləyin';

  @override
  String get asImage => 'Şəkil Kimi';

  @override
  String get asText => 'Mətn Kimi';

  @override
  String get playFromSelectedAyah => 'Seçilmiş Ayədən Oxut';

  @override
  String get toTafsir => 'Təfsirə Keç';

  @override
  String get selectAyah => 'Ayə Seç';

  @override
  String get toAyah => 'Ayəyə Keç';

  @override
  String get searchForASurah => 'Surə axtarın';

  @override
  String get bugReportTitle => 'Xəta Hesabatı';

  @override
  String get audioCached => 'Səs Keşləndi';

  @override
  String get others => 'Digərləri';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Quran|Tərcümə|Ayə, Biri Aktiv Olmalıdır';

  @override
  String get quranFontSize => 'Quran Şrift Ölçüsü';

  @override
  String get quranLineHeight => 'Quran Sətir Hündürlüyü';

  @override
  String get translationAndTafsirFontSize => 'Tərcümə və Təfsir Şrift Ölçüsü';

  @override
  String get quranAyah => 'Quran Ayəsi';

  @override
  String get topToolbar => 'Yuxarı Alətlər Paneli';

  @override
  String get keepOpenWordByWord => 'Sözbəsöz Tərcüməni Açıq Saxla';

  @override
  String get wordByWordHighlight => 'Sözbəsöz İşarələmə';

  @override
  String get quranScriptSettings => 'Quran Xətti Parametrləri';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Səhifə: ';

  @override
  String get quranResources => 'Quran Resursları';

  @override
  String alreadySelected(String name) {
    return '\'$name\' dili artıq seçilib.';
  }

  @override
  String get unableToGetCompassData =>
      'Kompas məlumatlarını almaq mümkün olmadı';

  @override
  String get deviceDoesNotHaveSensors => 'Cihazda sensorlar yoxdur!';

  @override
  String get north => 'Şm';

  @override
  String get east => 'Ş';

  @override
  String get south => 'C';

  @override
  String get west => 'Q';

  @override
  String get address => 'Ünvan: ';

  @override
  String get change => 'Dəyişdir';

  @override
  String get calculationMethod => 'Hesablama Metodu: ';

  @override
  String get downloadPrayerTime => 'Namaz Vaxtlarını Yüklə';

  @override
  String get calculationMethodsListEmpty =>
      'Hesablama metodları siyahısı boşdur.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Məkan məlumatları ilə heç bir hesablama metodu tapılmadı.';

  @override
  String get prayerSettings => 'Namaz Parametrləri';

  @override
  String get reminderSettings => 'Xatırlatma Parametrləri';

  @override
  String get adjustReminderTime => 'Xatırlatma Vaxtını Tənzimlə';

  @override
  String get enforceAlarmSound => 'Siqnal Səsini Məcburi Et';

  @override
  String get enforceAlarmSoundDescription =>
      'Əgər aktivdirsə, bu funksiya telefonunuzun səsi az olsa belə, siqnalı burada təyin edilmiş səs səviyyəsində səsləndirəcək. Bu, telefonun səs səviyyəsinin aşağı olması səbəbindən siqnalı qaçırmamağınızı təmin edir.';

  @override
  String get volume => 'Səs Səviyyəsi';

  @override
  String get atPrayerTime => 'Namaz vaxtında';

  @override
  String minBefore(int minutes) {
    return '$minutes dəqiqə əvvəl';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes dəqiqə sonra';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName vaxtı $prayerTime-dır';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'İndi $prayerName vaxtıdır';
  }

  @override
  String get stopTheAdhan => 'Azanı Dayandır';

  @override
  String dateFoundEmpty(String date) {
    return '$date üçün məlumat tapılmadı';
  }

  @override
  String get today => 'Bu gün';

  @override
  String get left => 'Qalıb';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName üçün xatırlatma əlavə edildi';
  }

  @override
  String get allowNotificationPermission =>
      'Bu funksiyanı istifadə etmək üçün zəhmət olmasa bildiriş icazəsi verin';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName üçün xatırlatma silindi';
  }

  @override
  String get getPrayerTimesAndQibla => 'Namaz Vaxtlarını və Qibləni Al';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'İstənilən Məkan üçün Namaz Vaxtlarını və Qibləni Hesablayın.';

  @override
  String get getFromGPS => 'GPS-dən al';

  @override
  String get or => 'Və ya';

  @override
  String get selectYourCity => 'Şəhərinizi Seçin';

  @override
  String get noteAboutGPS =>
      'Qeyd: Əgər GPS istifadə etmək istəmirsinizsə və ya özünüzü təhlükəsiz hiss etmirsinizsə, şəhərinizi seçə bilərsiniz.';

  @override
  String get downloadingLocationResources => 'Məkan resursları yüklənir...';

  @override
  String get somethingWentWrong => 'Xəta baş verdi';

  @override
  String get selectYourCountry => 'Ölkənizi Seçin';

  @override
  String get searchForACountry => 'Ölkə axtarın';

  @override
  String get selectYourAdministrator => 'İnzibati Ərazinizi Seçin';

  @override
  String get searchForAnAdministrator => 'İnzibati ərazi axtarın';

  @override
  String get searchForACity => 'Şəhər axtarın';

  @override
  String get pleaseEnableLocationService =>
      'Zəhmət olmasa, məkan xidmətini aktivləşdirin';

  @override
  String get donateUs => 'Bizə İanə Edin';

  @override
  String get underDevelopment => 'Hazırlanma mərhələsindədir';

  @override
  String get versionLoading => 'Yüklənir...';

  @override
  String get alQuran => 'əl-Quran';

  @override
  String get mainMenu => 'Əsas Menyu';

  @override
  String get notes => 'Qeydlər';

  @override
  String get pinned => 'Bərkidilmişlər';

  @override
  String get jumpToAyah => 'Ayəyə Keç';

  @override
  String get shareMultipleAyah => 'Birdən Çox Ayə Paylaş';

  @override
  String get shareThisApp => 'Bu Tətbiqi Paylaş';

  @override
  String get giveRating => 'Qiymət Ver';

  @override
  String get bugReport => 'Xəta Bildir';

  @override
  String get privacyPolicy => 'Məxfilik Siyasəti';

  @override
  String get aboutTheApp => 'Tətbiq Haqqında';

  @override
  String get resetTheApp => 'Tətbiqi Sıfırla';

  @override
  String get resetAppWarningTitle => 'Tətbiq Məlumatlarını Sıfırla';

  @override
  String get resetAppWarningMessage =>
      'Tətbiqi sıfırlamaq istədiyinizə əminsinizmi? Bütün məlumatlarınız silinəcək və tətbiqi yenidən qurmalı olacaqsınız.';

  @override
  String get cancel => 'Ləğv et';

  @override
  String get reset => 'Sıfırla';

  @override
  String get shareAppSubject => 'Bu əl-Quran tətbiqinə bax!';

  @override
  String shareAppBody(String appLink) {
    return 'Əssəlamu Aleykum! Gündəlik oxu və təfəkkür üçün bu əl-Quran tətbiqinə baxın. Allahın kəlamı ilə bağ qurmağa kömək edir. Buradan yükləyin: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Menyunu Aç';

  @override
  String get quran => 'Quran';

  @override
  String get prayer => 'Namaz';

  @override
  String get qibla => 'Qiblə';

  @override
  String get audio => 'Səs';

  @override
  String get surah => 'Surə';

  @override
  String get pages => 'Səhifələr';

  @override
  String get note => 'Qeyd:';

  @override
  String get linkedAyahs => 'Əlaqəli Ayələr:';

  @override
  String get emptyNoteCollection =>
      'Bu qeyd kolleksiyası boşdur.\nOnları burada görmək üçün bir neçə qeyd əlavə edin.';

  @override
  String get emptyPinnedCollection =>
      'Hələlik bu kolleksiyaya bərkidilmiş Ayə yoxdur.\nOnları burada görmək üçün Ayələri bərkidin.';

  @override
  String get noContentAvailable => 'Məzmun mövcud deyil.';

  @override
  String failedToLoadCollections(String error) {
    return 'Kolleksiyaları yükləmək alınmadı: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType Adına görə axtar...';
  }

  @override
  String get sortBy => 'Sırala';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Hələ heç bir $collectionType əlavə edilməyib';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count bərkidilmiş element';
  }

  @override
  String notesCount(int count) {
    return '$count qeyd';
  }

  @override
  String get emptyNameNotAllowed => 'Boş ad icazə verilmir';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName olaraq yeniləndi';
  }

  @override
  String get changeName => 'Adı Dəyiş';

  @override
  String get changeColor => 'Rəngi Dəyiş';

  @override
  String get colorUpdated => 'Rəng yeniləndi';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Silindi';
  }

  @override
  String get delete => 'Sil';

  @override
  String get save => 'Yadda saxla';

  @override
  String get collectionNameCannotBeEmpty => 'Kolleksiya adı boş ola bilməz.';

  @override
  String get addedNewCollection => 'Yeni Kolleksiya Əlavə Edildi';

  @override
  String ayahCount(int count) {
    return '$count Ayə';
  }

  @override
  String get byNameAtoZ => 'Ad A-Z';

  @override
  String get byNameZtoA => 'Ad Z-A';

  @override
  String get byElementNumberAscending => 'Element Sayına görə Artan';

  @override
  String get byElementNumberDescending => 'Element Sayına görə Azalan';

  @override
  String get byUpdateDateAscending => 'Yeniləmə Tarixinə görə Artan';

  @override
  String get byUpdateDateDescending => 'Yeniləmə Tarixinə görə Azalan';

  @override
  String get byCreateDateAscending => 'Yaradılma Tarixinə görə Artan';

  @override
  String get byCreateDateDescending => 'Yaradılma Tarixinə görə Azalan';

  @override
  String get translationNotFound => 'Tərcümə Tapılmadı';

  @override
  String get translationTitle => 'Tərcümə:';

  @override
  String get footNoteTitle => 'Qeyd:';

  @override
  String get wordByWordTranslation => 'Sözbəsöz Tərcümə:';

  @override
  String get tafsirButton => 'Təfsir';

  @override
  String get shareButton => 'Paylaş';

  @override
  String get addNoteButton => 'Qeyd Əlavə et';

  @override
  String get pinToCollectionButton => 'Kolleksiyaya Bərkit';

  @override
  String get shareAsText => 'Mətn kimi paylaş';

  @override
  String get copiedWithTafsir => 'Təfsirlə birlikdə kopyalandı';

  @override
  String get shareAsImage => 'Şəkil kimi paylaş';

  @override
  String get shareWithTafsir => 'Təfsirlə birlikdə paylaş';

  @override
  String get notFound => 'Tapılmadı';

  @override
  String get noteContentCannotBeEmpty => 'Qeyd məzmunu boş ola bilməz.';

  @override
  String get noteSavedSuccessfully => 'Qeyd uğurla yadda saxlanıldı!';

  @override
  String get selectCollections => 'Kolleksiyaları Seç';

  @override
  String get addNote => 'Qeyd Əlavə et';

  @override
  String get writeCollectionName => 'Kolleksiya adını yazın...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Hələ kolleksiya yoxdur. Yeni birini əlavə edin!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Zəhmət olmasa, əvvəlcə qeydinizi yazın.';

  @override
  String get noCollectionSelected => 'Heç bir Kolleksiya seçilməyib';

  @override
  String get saveNote => 'Qeydi Yadda Saxla';

  @override
  String get nextSelectCollections => 'Növbəti: Kolleksiyaları Seç';

  @override
  String get addToPinned => 'Bərkidilmişlərə Əlavə et';

  @override
  String get pinnedSavedSuccessfully => 'Uğurla bərkidildi!';

  @override
  String get savePinned => 'Bərkidilmişi Yadda Saxla';

  @override
  String get closeAudioController => 'Səs Nəzarətçisini Bağla';

  @override
  String get previous => 'Əvvəlki';

  @override
  String get rewind => 'Geri çək';

  @override
  String get fastForward => 'İrəli çək';

  @override
  String get playNextAyah => 'Növbəti Ayəni Oxut';

  @override
  String get repeat => 'Təkrarla';

  @override
  String get playAsPlaylist => 'Pleylist Kimi Oxut';

  @override
  String style(String style) {
    return 'Üslub: $style';
  }

  @override
  String get stopAndClose => 'Dayandır və Bağla';

  @override
  String get play => 'Oxut';

  @override
  String get pause => 'Fasilə';

  @override
  String get selectReciter => 'Qari Seç';

  @override
  String source(String source) {
    return 'Mənbə: $source';
  }

  @override
  String get newText => 'Yeni';

  @override
  String get more => 'Daha çox: ';

  @override
  String get cacheNotFound => 'Keş Tapılmadı';

  @override
  String get cacheSize => 'Keş Ölçüsü';

  @override
  String error(String error) {
    return 'Xəta: $error';
  }

  @override
  String get clean => 'Təmizlə';

  @override
  String get lastModified => 'Son Dəyişiklik';

  @override
  String get oneYearAgo => '1 il əvvəl';

  @override
  String monthsAgo(String number) {
    return '$number ay əvvəl';
  }

  @override
  String weeksAgo(String number) {
    return '$number həftə əvvəl';
  }

  @override
  String daysAgo(String number) {
    return '$number gün əvvəl';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour saat əvvəl';
  }

  @override
  String get aboutAlQuran => 'əl-Quran Haqqında';

  @override
  String get appFullName => 'əl-Quran (Təfsir, Namaz, Qiblə, Səs)';

  @override
  String get appDescription =>
      'Android, iOS, MacOS, Web, Linux və Windows üçün hərtərəfli İslami tətbiq. Təfsir və çoxsaylı tərcümələr (sözbəsöz daxil olmaqla) ilə Quran oxuma, bildirişlərlə dünya üzrə namaz vaxtları, Qiblə kompasları və sinxronlaşdırılmış sözbəsöz səsli tilavət təklif edir.';

  @override
  String get dataSourcesNote =>
      'Qeyd: Quran mətnləri, Təfsir, tərcümələr və səs resursları Quran.com, Everyayah.com və digər təsdiqlənmiş açıq mənbələrdən əldə edilir.';

  @override
  String get adFreePromise =>
      'Bu tətbiq Allahın razılığını qazanmaq üçün yaradılmışdır. Buna görə də, tamamilə Reklamsızdır və həmişə də belə olacaq.';

  @override
  String get coreFeatures => 'Əsas Xüsusiyyətlər';

  @override
  String get coreFeaturesDescription =>
      'əl-Quran v3-ü gündəlik İslami əməlləriniz üçün əvəzolunmaz bir vasitəyə çevirən əsas funksionallıqları kəşf edin:';

  @override
  String get prayerTimesTitle => 'Namaz Vaxtları və Bildirişlər';

  @override
  String get prayerTimesDescription =>
      'Müxtəlif hesablama metodlarından istifadə edərək dünya üzrə istənilən məkan üçün dəqiq namaz vaxtları. Azan bildirişləri ilə xatırlatmalar qurun.';

  @override
  String get qiblaDirectionTitle => 'Qiblə İstiqaməti';

  @override
  String get qiblaDirectionDescription =>
      'Aydın və dəqiq kompas görünüşü ilə Qiblə istiqamətini asanlıqla tapın.';

  @override
  String get translationTafsirTitle => 'Quran Tərcüməsi və Təfsiri';

  @override
  String get translationTafsirDescription =>
      '69 dildə 120-dən çox tərcümə kitabına (sözbəsöz daxil olmaqla) və 30-dan çox Təfsir kitabına giriş əldə edin.';

  @override
  String get wordByWordAudioTitle => 'Sözbəsöz Səs və İşarələmə';

  @override
  String get wordByWordAudioDescription =>
      'Daha dərin öyrənmə təcrübəsi üçün sinxronlaşdırılmış sözbəsöz səsli tilavət və işarələmə ilə izləyin.';

  @override
  String get ayahAudioRecitationTitle => 'Ayə Səsli Tilavəti';

  @override
  String get ayahAudioRecitationDescription =>
      '40-dan çox məşhur qarinin tam Ayə tilavətlərini dinləyin.';

  @override
  String get notesCloudBackupTitle => 'Bulud Ehtiyat Nüsxəsi ilə Qeydlər';

  @override
  String get notesCloudBackupDescription =>
      'Şəxsi qeydləri və düşüncələri yadda saxlayın, təhlükəsiz şəkildə buludda ehtiyat nüsxəsi yaradılır (funksiya hazırlanma mərhələsindədir/tezliklə əlavə olunacaq).';

  @override
  String get crossPlatformSupportTitle => 'Çoxplatformalı Dəstək';

  @override
  String get crossPlatformSupportDescription =>
      'Android, Web, Linux və Windows-da dəstəklənir.';

  @override
  String get backgroundAudioPlaybackTitle => 'Arxa Planda Səs Oxutma';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Tətbiq arxa planda olduqda belə Quran tilavətini dinləməyə davam edin.';

  @override
  String get audioDataCachingTitle => 'Səs və Məlumatların Keşlənməsi';

  @override
  String get audioDataCachingDescription =>
      'Güclü səs və Quran məlumatlarının keşlənməsi ilə təkmilləşdirilmiş oxutma və oflayn imkanlar.';

  @override
  String get minimalisticInterfaceTitle => 'Minimalist və Təmiz İnterfeys';

  @override
  String get minimalisticInterfaceDescription =>
      'İstifadəçi təcrübəsinə və oxunaqlılığa fokuslanmış, asan naviqasiyalı interfeys.';

  @override
  String get optimizedPerformanceTitle =>
      'Optimallaşdırılmış Performans və Ölçü';

  @override
  String get optimizedPerformanceDescription =>
      'Yüngül və yüksək performanslı olması üçün nəzərdə tutulmuş zəngin funksiyalı bir tətbiq.';

  @override
  String get languageSupport => 'Dil Dəstəyi';

  @override
  String get languageSupportDescription =>
      'Bu tətbiq qlobal auditoriya üçün əlçatan olması məqsədi ilə aşağıdakı dilləri dəstəkləyir (və davamlı olaraq daha çoxu əlavə edilir):';

  @override
  String get technologyAndResources => 'Texnologiya və Resurslar';

  @override
  String get technologyAndResourcesDescription =>
      'Bu tətbiq ən son texnologiyalar və etibarlı resurslardan istifadə edilərək yaradılmışdır:';

  @override
  String get flutterFrameworkTitle => 'Flutter Freymvorku';

  @override
  String get flutterFrameworkDescription =>
      'Vahid kod bazasından gözəl, nativ kompilyasiya edilmiş, çoxplatformalı təcrübə üçün Flutter ilə yaradılmışdır.';

  @override
  String get advancedAudioEngineTitle => 'Qabaqcıl Səs Mühərriki';

  @override
  String get advancedAudioEngineDescription =>
      'Güclü səs oxutma və nəzarət üçün `just_audio` və `just_audio_background` Flutter paketləri ilə təchiz edilmişdir.';

  @override
  String get reliableQuranDataTitle => 'Etibarlı Quran Məlumatları';

  @override
  String get reliableQuranDataDescription =>
      'əl-Quran mətnləri, tərcümələri, təfsirləri və səsləri Quran.com və Everyayah.com kimi təsdiqlənmiş açıq API-lərdən və məlumat bazalarından əldə edilir.';

  @override
  String get prayerTimeEngineTitle => 'Namaz Vaxtı Mühərriki';

  @override
  String get prayerTimeEngineDescription =>
      'Dəqiq namaz vaxtları üçün qurulmuş hesablama metodlarından istifadə edir. Bildirişlər `flutter_local_notifications` və arxa plan tapşırıqları ilə idarə olunur.';

  @override
  String get crossPlatformSupport => 'Çoxplatformalı Dəstək';

  @override
  String get crossPlatformSupportDescription2 =>
      'Müxtəlif platformalarda problemsiz girişdən həzz alın:';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => 'Veb';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => 'Ömürlük Sözümüz';

  @override
  String get lifetimePromiseDescription =>
      'Şəxsən söz verirəm ki, İn Şa Allah, ömrüm boyu bu tətbiq üçün davamlı dəstək və təmir təmin edəcəyəm. Məqsədim bu tətbiqin gələcək illər ərzində Ümmət üçün faydalı bir mənbə olaraq qalmasını təmin etməkdir.';

  @override
  String get fajr => 'Sübh';

  @override
  String get sunrise => 'Günəş';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Zöhr';

  @override
  String get asr => 'Əsr';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'Məğrib';

  @override
  String get isha => 'İşa';

  @override
  String get midnight => 'Gecəyarısı';

  @override
  String get alarm => 'Siqnal';

  @override
  String get notification => 'Bildiriş';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Təcvid';

  @override
  String get quranScriptUthmani => 'Osman';

  @override
  String get quranScriptIndopak => 'İndopak';

  @override
  String get sajdaAyah => 'Səcdə Ayəsi';

  @override
  String get required => 'Vacib';

  @override
  String get optional => 'İstəyə bağlı';

  @override
  String get notificationScheduleWarning =>
      'Qeyd: Planlaşdırılmış Bildiriş və ya Xatırlatma telefonunuzun ƏS arxa fon proses məhdudiyyətləri səbəbindən əldən verilə bilər. Məsələn: Vivo-nun Origin ƏS, Samsung-un One UI, Oppo-nun ColorOS və s. bəzən planlaşdırılmış Bildiriş və ya Xatırlatmanı dayandırır. Tətbiqin arxa fon prosesindən məhdudlaşdırılmaması üçün lütfən ƏS parametrlərinizi yoxlayın.';

  @override
  String get scrollWithRecitation => 'Tilavətlə Sürüşdürün';

  @override
  String get quickAccess => 'Sürətli Giriş';

  @override
  String get initiallyScrollAyah => 'Başlanğıcda ayəyə sürüşdürün';

  @override
  String get tajweedGuide => 'Təcvid Bələdçisi';

  @override
  String get scrollWithRecitationDesc =>
      'Aktiv olduqda, Quran ayəsi səsli tilavət ilə sinxron olaraq avtomatik sürüşdürüləcək.';

  @override
  String get configuration => 'Konfiqurasiya';

  @override
  String get restoreFromBackup => 'Yedəkdən Geri Yüklə';

  @override
  String get history => 'Tarix';

  @override
  String get search => 'Axtarış';

  @override
  String get useAudioStream => 'Audio Axınından istifadə edin';

  @override
  String get useAudioStreamDesc =>
      'Yükləmək əvəzinə internetdən birbaşa səs axını.';

  @override
  String get notUseAudioStreamDesc =>
      'Oflayn istifadə üçün audio yükləyin və məlumat istehlakını azaldın.';

  @override
  String get audioSettings => 'Səs Parametrləri';

  @override
  String get playbackSpeed => 'Oynatma Sürəti';

  @override
  String get playbackSpeedDesc => 'Quran tilavətinin sürətini tənzimləyin.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Zəhmət olmasa, cari endirmənin bitməsini gözləyin.';

  @override
  String get areYouSure => 'Əminsiniz?';

  @override
  String get checkYourInternetConnection => 'İnternet bağlantınızı yoxlayın.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCount ayədən $requiredDownload yükləmək lazımdır.';
  }

  @override
  String get download => 'Yüklə';

  @override
  String get audioDownload => 'Səs Yükləmə';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Quran Mətninin Optimallaşdırılması';

  @override
  String get supportOnGithub => 'GitHub-da dəstək';

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
}
