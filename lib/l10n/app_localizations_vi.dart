// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

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
    return 'Tafsir không có sẵn cho $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsir có thể được tìm thấy tại: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Chuyển đến $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Trang';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Cài đặt Ngôn ngữ';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName, $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Ayah';
  }

  @override
  String get saveAndDownload => 'Lưu và Tải xuống';

  @override
  String get appLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get selectAppLanguage => 'Chọn ngôn ngữ ứng dụng...';

  @override
  String get pleaseSelectOne => 'Vui lòng chọn một';

  @override
  String get quranTranslationLanguage => 'Ngôn ngữ dịch Kinh Qur\'an';

  @override
  String get selectTranslationLanguage => 'Chọn ngôn ngữ dịch...';

  @override
  String get quranTranslationBook => 'Sách dịch Kinh Qur\'an';

  @override
  String get selectTranslationBook => 'Chọn sách dịch...';

  @override
  String get quranTafsirLanguage => 'Ngôn ngữ Tafsir Kinh Qur\'an';

  @override
  String get selectTafsirLanguage => 'Chọn ngôn ngữ tafsir...';

  @override
  String get quranTafsirBook => 'Sách Tafsir Kinh Qur\'an';

  @override
  String get selectTafsirBook => 'Chọn sách tafsir...';

  @override
  String get quranScriptAndStyle => 'Chữ viết & Kiểu chữ Kinh Qur\'an';

  @override
  String get justAMoment => 'Vui lòng đợi một lát...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Thành công';

  @override
  String get retry => 'Thử lại';

  @override
  String get unableToDownloadResources =>
      'Không thể tải xuống tài nguyên...\nĐã có lỗi xảy ra';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Đang tải xuống phần đọc Kinh Qur\'an theo đoạn';

  @override
  String get processingSegmentedQuranRecitation =>
      'Đang xử lý phần đọc Kinh Qur\'an theo đoạn';

  @override
  String get footnote => 'Chú thích cuối trang';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Từng từ';

  @override
  String get pleaseSelectRequiredOption => 'Vui lòng chọn tùy chọn cần thiết';

  @override
  String get rememberHomeTab => 'Ghi nhớ Tab Trang chủ';

  @override
  String get rememberHomeTabSubtitle =>
      'Ứng dụng sẽ ghi nhớ tab được mở lần cuối trên màn hình chính.';

  @override
  String get wakeLock => 'Giữ màn hình luôn bật';

  @override
  String get wakeLockSubtitle => 'Ngăn màn hình tự động tắt.';

  @override
  String get settings => 'Cài đặt';

  @override
  String get appTheme => 'Chủ đề ứng dụng';

  @override
  String get quranStyle => 'Kiểu chữ Kinh Qur\'an';

  @override
  String get changeTheme => 'Thay đổi Chủ đề';

  @override
  String get verseCount => 'Số lượng câu (Ayah): ';

  @override
  String get translation => 'Bản dịch';

  @override
  String get tafsirNotFound => 'Không tìm thấy';

  @override
  String get moreInfo => 'thêm thông tin';

  @override
  String get playAudio => 'Phát Âm thanh';

  @override
  String get preview => 'Xem trước';

  @override
  String get loading => 'Đang tải...';

  @override
  String get errorFetchingAddress => 'Lỗi khi lấy địa chỉ';

  @override
  String get addressNotAvailable => 'Không có địa chỉ';

  @override
  String get latitude => 'Vĩ độ: ';

  @override
  String get longitude => 'Kinh độ: ';

  @override
  String get name => 'Tên: ';

  @override
  String get location => 'Vị trí: ';

  @override
  String get parameters => 'Thông số: ';

  @override
  String get selectCalculationMethod => 'Chọn Phương pháp Tính toán';

  @override
  String get shareSelectAyahs => 'Chia sẻ các Ayah đã chọn';

  @override
  String get selectionEmpty => 'Chưa chọn mục nào';

  @override
  String get generatingImagePleaseWait => 'Đang tạo ảnh... Vui lòng đợi';

  @override
  String get asImage => 'Dưới dạng Ảnh';

  @override
  String get asText => 'Dưới dạng Văn bản';

  @override
  String get playFromSelectedAyah => 'Phát từ Ayah đã chọn';

  @override
  String get toTafsir => 'Đến Tafsir';

  @override
  String get selectAyah => 'Chọn Ayah';

  @override
  String get toAyah => 'Đến Ayah';

  @override
  String get searchForASurah => 'Tìm kiếm một surah';

  @override
  String get bugReportTitle => 'Báo cáo lỗi';

  @override
  String get audioCached => 'Âm thanh đã được lưu vào bộ nhớ đệm';

  @override
  String get others => 'Khác';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Kinh Qur\'an|Bản dịch|Ayah, Phải bật ít nhất một mục';

  @override
  String get quranFontSize => 'Cỡ chữ Kinh Qur\'an';

  @override
  String get quranLineHeight => 'Chiều cao dòng Kinh Qur\'an';

  @override
  String get translationAndTafsirFontSize => 'Cỡ chữ Bản dịch & Tafsir';

  @override
  String get quranAyah => 'Ayah Kinh Qur\'an';

  @override
  String get topToolbar => 'Thanh công cụ trên';

  @override
  String get keepOpenWordByWord => 'Luôn mở phần dịch Từng từ';

  @override
  String get wordByWordHighlight => 'Tô sáng Từng từ';

  @override
  String get quranScriptSettings => 'Cài đặt chữ viết Kinh Qur\'an';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Trang: ';

  @override
  String get quranResources => 'Tài nguyên Kinh Qur\'an';

  @override
  String alreadySelected(String name) {
    return 'Ngôn ngữ \'$name\' đã được chọn.';
  }

  @override
  String get unableToGetCompassData => 'Không thể lấy dữ liệu la bàn';

  @override
  String get deviceDoesNotHaveSensors => 'Thiết bị không có cảm biến!';

  @override
  String get north => 'B';

  @override
  String get east => 'Đ';

  @override
  String get south => 'N';

  @override
  String get west => 'T';

  @override
  String get address => 'Địa chỉ: ';

  @override
  String get change => 'Thay đổi';

  @override
  String get calculationMethod => 'Phương pháp tính toán: ';

  @override
  String get downloadPrayerTime => 'Tải xuống Giờ cầu nguyện';

  @override
  String get calculationMethodsListEmpty =>
      'Danh sách phương pháp tính toán trống.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Không tìm thấy phương pháp tính toán nào với dữ liệu vị trí.';

  @override
  String get prayerSettings => 'Cài đặt Cầu nguyện';

  @override
  String get reminderSettings => 'Cài đặt Nhắc nhở';

  @override
  String get adjustReminderTime => 'Điều chỉnh Thời gian Nhắc nhở';

  @override
  String get enforceAlarmSound => 'Bắt buộc phát âm thanh báo thức';

  @override
  String get enforceAlarmSoundDescription =>
      'Nếu được bật, tính năng này sẽ phát báo thức ở mức âm lượng được đặt ở đây, ngay cả khi âm thanh điện thoại của bạn ở mức thấp. Điều này đảm bảo bạn không bỏ lỡ báo thức do âm lượng điện thoại thấp.';

  @override
  String get volume => 'Âm lượng';

  @override
  String get atPrayerTime => 'Vào giờ cầu nguyện';

  @override
  String minBefore(int minutes) {
    return '$minutes phút trước';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes phút sau';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Giờ $prayerName là vào $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Đã đến giờ $prayerName';
  }

  @override
  String get stopTheAdhan => 'Dừng Adhan';

  @override
  String dateFoundEmpty(String date) {
    return 'Không tìm thấy dữ liệu cho ngày $date';
  }

  @override
  String get today => 'Hôm nay';

  @override
  String get left => 'Còn lại';

  @override
  String reminderAdded(String prayerName) {
    return 'Đã thêm nhắc nhở cho $prayerName';
  }

  @override
  String get allowNotificationPermission =>
      'Vui lòng cho phép quyền thông báo để sử dụng tính năng này';

  @override
  String reminderRemoved(String prayerName) {
    return 'Đã xóa nhắc nhở cho $prayerName';
  }

  @override
  String get getPrayerTimesAndQibla => 'Lấy Giờ cầu nguyện và Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Tính toán Giờ cầu nguyện và Qibla cho bất kỳ vị trí nào.';

  @override
  String get getFromGPS => 'Lấy từ GPS';

  @override
  String get or => 'Hoặc';

  @override
  String get selectYourCity => 'Chọn Thành phố của bạn';

  @override
  String get noteAboutGPS =>
      'Lưu ý: Nếu bạn không muốn sử dụng GPS hoặc cảm thấy không an toàn, bạn có thể chọn thành phố của mình.';

  @override
  String get downloadingLocationResources =>
      'Đang tải xuống tài nguyên vị trí...';

  @override
  String get somethingWentWrong => 'Đã có lỗi xảy ra';

  @override
  String get selectYourCountry => 'Chọn Quốc gia của bạn';

  @override
  String get searchForACountry => 'Tìm kiếm quốc gia';

  @override
  String get selectYourAdministrator => 'Chọn Khu vực Hành chính của bạn';

  @override
  String get searchForAnAdministrator => 'Tìm kiếm khu vực hành chính';

  @override
  String get searchForACity => 'Tìm kiếm thành phố';

  @override
  String get pleaseEnableLocationService => 'Vui lòng bật dịch vụ vị trí';

  @override
  String get donateUs => 'Ủng hộ chúng tôi';

  @override
  String get underDevelopment => 'Đang phát triển';

  @override
  String get versionLoading => 'Đang tải...';

  @override
  String get alQuran => 'Al Qur\'an';

  @override
  String get mainMenu => 'Menu Chính';

  @override
  String get notes => 'Ghi chú';

  @override
  String get pinned => 'Đã ghim';

  @override
  String get jumpToAyah => 'Chuyển đến Ayah';

  @override
  String get shareMultipleAyah => 'Chia sẻ nhiều Ayah';

  @override
  String get shareThisApp => 'Chia sẻ ứng dụng này';

  @override
  String get giveRating => 'Đánh giá';

  @override
  String get bugReport => 'Báo cáo lỗi';

  @override
  String get privacyPolicy => 'Chính sách Bảo mật';

  @override
  String get aboutTheApp => 'Về ứng dụng';

  @override
  String get resetTheApp => 'Đặt lại ứng dụng';

  @override
  String get resetAppWarningTitle => 'Đặt lại Dữ liệu Ứng dụng';

  @override
  String get resetAppWarningMessage =>
      'Bạn có chắc chắn muốn đặt lại ứng dụng không? Tất cả dữ liệu của bạn sẽ bị mất và bạn sẽ cần phải thiết lập lại ứng dụng từ đầu.';

  @override
  String get cancel => 'Hủy';

  @override
  String get reset => 'Đặt lại';

  @override
  String get shareAppSubject => 'Hãy xem ứng dụng Al Qur\'an này!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Hãy xem ứng dụng Al Qur\'an này để đọc và suy ngẫm hàng ngày. Ứng dụng giúp kết nối với lời của Allah. Tải xuống tại đây: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Mở Menu';

  @override
  String get quran => 'Qur\'an';

  @override
  String get prayer => 'Cầu nguyện';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Âm thanh';

  @override
  String get surah => 'Surah';

  @override
  String get pages => 'Trang';

  @override
  String get note => 'Ghi chú:';

  @override
  String get linkedAyahs => 'Các Ayah được liên kết:';

  @override
  String get emptyNoteCollection =>
      'Bộ sưu tập ghi chú này trống.\nThêm vài ghi chú để xem chúng ở đây.';

  @override
  String get emptyPinnedCollection =>
      'Chưa có Ayah nào được ghim vào bộ sưu tập này.\nGhim Ayah để xem chúng ở đây.';

  @override
  String get noContentAvailable => 'Không có nội dung.';

  @override
  String failedToLoadCollections(String error) {
    return 'Tải bộ sưu tập thất bại: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Tìm theo tên $collectionType...';
  }

  @override
  String get sortBy => 'Sắp xếp theo';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Chưa có $collectionType nào được thêm';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count mục đã ghim';
  }

  @override
  String notesCount(int count) {
    return '$count ghi chú';
  }

  @override
  String get emptyNameNotAllowed => 'Tên không được để trống';

  @override
  String updatedTo(String collectionName) {
    return 'Đã cập nhật thành $collectionName';
  }

  @override
  String get changeName => 'Đổi tên';

  @override
  String get changeColor => 'Đổi màu';

  @override
  String get colorUpdated => 'Đã cập nhật màu';

  @override
  String collectionDeleted(String collectionName) {
    return 'Đã xóa $collectionName';
  }

  @override
  String get delete => 'Xóa';

  @override
  String get save => 'Lưu';

  @override
  String get collectionNameCannotBeEmpty =>
      'Tên bộ sưu tập không được để trống.';

  @override
  String get addedNewCollection => 'Đã thêm Bộ sưu tập mới';

  @override
  String ayahCount(int count) {
    return '$count Ayah';
  }

  @override
  String get byNameAtoZ => 'Tên A-Z';

  @override
  String get byNameZtoA => 'Tên Z-A';

  @override
  String get byElementNumberAscending => 'Số lượng phần tử tăng dần';

  @override
  String get byElementNumberDescending => 'Số lượng phần tử giảm dần';

  @override
  String get byUpdateDateAscending => 'Ngày cập nhật tăng dần';

  @override
  String get byUpdateDateDescending => 'Ngày cập nhật giảm dần';

  @override
  String get byCreateDateAscending => 'Ngày tạo tăng dần';

  @override
  String get byCreateDateDescending => 'Ngày tạo giảm dần';

  @override
  String get translationNotFound => 'Không tìm thấy bản dịch';

  @override
  String get translationTitle => 'Bản dịch:';

  @override
  String get footNoteTitle => 'Chú thích:';

  @override
  String get wordByWordTranslation => 'Dịch từng từ:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Chia sẻ';

  @override
  String get addNoteButton => 'Thêm ghi chú';

  @override
  String get pinToCollectionButton => 'Ghim vào bộ sưu tập';

  @override
  String get shareAsText => 'Chia sẻ dưới dạng văn bản';

  @override
  String get copiedWithTafsir => 'Đã sao chép kèm Tafsir';

  @override
  String get shareAsImage => 'Chia sẻ dưới dạng hình ảnh';

  @override
  String get shareWithTafsir => 'Chia sẻ kèm Tafsir';

  @override
  String get notFound => 'Không tìm thấy';

  @override
  String get noteContentCannotBeEmpty =>
      'Nội dung ghi chú không được để trống.';

  @override
  String get noteSavedSuccessfully => 'Đã lưu ghi chú thành công!';

  @override
  String get selectCollections => 'Chọn bộ sưu tập';

  @override
  String get addNote => 'Thêm ghi chú';

  @override
  String get writeCollectionName => 'Nhập tên bộ sưu tập...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Chưa có bộ sưu tập nào. Hãy thêm một cái mới!';

  @override
  String get pleaseWriteYourNoteFirst => 'Vui lòng viết ghi chú của bạn trước.';

  @override
  String get noCollectionSelected => 'Chưa chọn bộ sưu tập';

  @override
  String get saveNote => 'Lưu ghi chú';

  @override
  String get nextSelectCollections => 'Tiếp theo: Chọn bộ sưu tập';

  @override
  String get addToPinned => 'Thêm vào mục đã ghim';

  @override
  String get pinnedSavedSuccessfully => 'Đã lưu ghim thành công!';

  @override
  String get savePinned => 'Lưu mục đã ghim';

  @override
  String get closeAudioController => 'Đóng trình điều khiển âm thanh';

  @override
  String get previous => 'Trước';

  @override
  String get rewind => 'Tua lại';

  @override
  String get fastForward => 'Tua đi';

  @override
  String get playNextAyah => 'Phát Ayah tiếp theo';

  @override
  String get repeat => 'Lặp lại';

  @override
  String get playAsPlaylist => 'Phát dưới dạng danh sách';

  @override
  String style(String style) {
    return 'Kiểu: $style';
  }

  @override
  String get stopAndClose => 'Dừng & Đóng';

  @override
  String get play => 'Phát';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get selectReciter => 'Chọn người đọc';

  @override
  String source(String source) {
    return 'Nguồn: $source';
  }

  @override
  String get newText => 'Mới';

  @override
  String get more => 'Thêm: ';

  @override
  String get cacheNotFound => 'Không tìm thấy bộ nhớ đệm';

  @override
  String get cacheSize => 'Kích thước bộ nhớ đệm';

  @override
  String error(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get clean => 'Dọn dẹp';

  @override
  String get lastModified => 'Sửa đổi lần cuối';

  @override
  String get oneYearAgo => '1 năm trước';

  @override
  String monthsAgo(String number) {
    return '$number tháng trước';
  }

  @override
  String weeksAgo(String number) {
    return '$number tuần trước';
  }

  @override
  String daysAgo(String number) {
    return '$number ngày trước';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour giờ trước';
  }

  @override
  String get aboutAlQuran => 'Về Al Qur\'an';

  @override
  String get appFullName => 'Al Qur\'an (Tafsir, Cầu nguyện, Qibla, Âm thanh)';

  @override
  String get appDescription =>
      'Một ứng dụng Hồi giáo toàn diện cho Android, iOS, MacOS, Web, Linux và Windows, cung cấp việc đọc Kinh Qur\'an với Tafsir & nhiều bản dịch (bao gồm cả dịch từng từ), thời gian cầu nguyện trên toàn thế giới với thông báo, la bàn Qibla, và phần đọc âm thanh đồng bộ từng từ.';

  @override
  String get dataSourcesNote =>
      'Lưu ý: Văn bản Kinh Qur\'an, Tafsir, các bản dịch, và tài nguyên âm thanh được lấy từ Quran.com, Everyayah.com, và các nguồn mở đã được xác minh khác.';

  @override
  String get adFreePromise =>
      'Ứng dụng này được xây dựng để tìm kiếm sự hài lòng của Allah. Do đó, nó hoàn toàn không có quảng cáo và sẽ luôn như vậy.';

  @override
  String get coreFeatures => 'Các tính năng chính';

  @override
  String get coreFeaturesDescription =>
      'Khám phá các chức năng chính làm cho Al Qur\'an v3 trở thành một công cụ không thể thiếu cho các hoạt động Hồi giáo hàng ngày của bạn:';

  @override
  String get prayerTimesTitle => 'Giờ cầu nguyện & Cảnh báo';

  @override
  String get prayerTimesDescription =>
      'Thời gian cầu nguyện chính xác cho bất kỳ địa điểm nào trên toàn thế giới bằng nhiều phương pháp tính toán khác nhau. Đặt lời nhắc với thông báo Adhan.';

  @override
  String get qiblaDirectionTitle => 'Hướng Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Dễ dàng tìm hướng Qibla với chế độ xem la bàn rõ ràng và chính xác.';

  @override
  String get translationTafsirTitle => 'Bản dịch & Tafsir Kinh Qur\'an';

  @override
  String get translationTafsirDescription =>
      'Truy cập hơn 120 sách dịch (bao gồm cả dịch từng từ) bằng 69 ngôn ngữ, và hơn 30 sách Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Âm thanh & Tô sáng từng từ';

  @override
  String get wordByWordAudioDescription =>
      'Theo dõi phần đọc âm thanh và tô sáng đồng bộ từng từ để có trải nghiệm học tập sâu sắc.';

  @override
  String get ayahAudioRecitationTitle => 'Đọc âm thanh Ayah';

  @override
  String get ayahAudioRecitationDescription =>
      'Nghe các bài đọc Ayah đầy đủ từ hơn 40 người đọc nổi tiếng.';

  @override
  String get notesCloudBackupTitle => 'Ghi chú với Sao lưu trên đám mây';

  @override
  String get notesCloudBackupDescription =>
      'Lưu các ghi chú và suy ngẫm cá nhân, được sao lưu an toàn lên đám mây (tính năng đang phát triển/sắp ra mắt).';

  @override
  String get crossPlatformSupportTitle => 'Hỗ trợ đa nền tảng';

  @override
  String get crossPlatformSupportDescription =>
      'Được hỗ trợ trên Android, Web, Linux và Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Phát âm thanh trong nền';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Tiếp tục nghe đọc Kinh Qur\'an ngay cả khi ứng dụng đang chạy ở chế độ nền.';

  @override
  String get audioDataCachingTitle => 'Lưu trữ đệm Âm thanh & Dữ liệu';

  @override
  String get audioDataCachingDescription =>
      'Cải thiện khả năng phát và sử dụng ngoại tuyến với việc lưu trữ đệm dữ liệu âm thanh và Kinh Qur\'an mạnh mẽ.';

  @override
  String get minimalisticInterfaceTitle => 'Giao diện tối giản & Sạch sẽ';

  @override
  String get minimalisticInterfaceDescription =>
      'Giao diện dễ điều hướng, tập trung vào trải nghiệm người dùng và tính dễ đọc.';

  @override
  String get optimizedPerformanceTitle =>
      'Hiệu suất & Kích thước được tối ưu hóa';

  @override
  String get optimizedPerformanceDescription =>
      'Một ứng dụng giàu tính năng được thiết kế để nhẹ và có hiệu suất cao.';

  @override
  String get languageSupport => 'Hỗ trợ ngôn ngữ';

  @override
  String get languageSupportDescription =>
      'Ứng dụng này được thiết kế để có thể truy cập bởi khán giả toàn cầu với sự hỗ trợ cho các ngôn ngữ sau (và nhiều ngôn ngữ khác đang được thêm vào liên tục):';

  @override
  String get technologyAndResources => 'Công nghệ & Tài nguyên';

  @override
  String get technologyAndResourcesDescription =>
      'Ứng dụng này được xây dựng bằng các công nghệ tiên tiến và các tài nguyên đáng tin cậy:';

  @override
  String get flutterFrameworkTitle => 'Khung Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Được xây dựng bằng Flutter để có trải nghiệm đa nền tảng đẹp mắt, được biên dịch gốc từ một cơ sở mã duy nhất.';

  @override
  String get advancedAudioEngineTitle => 'Công cụ âm thanh nâng cao';

  @override
  String get advancedAudioEngineDescription =>
      'Được cung cấp bởi các gói Flutter `just_audio` và `just_audio_background` để phát và kiểm soát âm thanh mạnh mẽ.';

  @override
  String get reliableQuranDataTitle => 'Dữ liệu Kinh Qur\'an đáng tin cậy';

  @override
  String get reliableQuranDataDescription =>
      'Văn bản, bản dịch, tafsir và âm thanh của Al Qur\'an được lấy từ các API mở và cơ sở dữ liệu đã được xác minh như Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Công cụ tính giờ cầu nguyện';

  @override
  String get prayerTimeEngineDescription =>
      'Sử dụng các phương pháp tính toán đã được thiết lập để có thời gian cầu nguyện chính xác. Thông báo được xử lý bởi `flutter_local_notifications` và các tác vụ nền.';

  @override
  String get crossPlatformSupport => 'Hỗ trợ đa nền tảng';

  @override
  String get crossPlatformSupportDescription2 =>
      'Tận hưởng quyền truy cập liền mạch trên nhiều nền tảng khác nhau:';

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
  String get ourLifetimePromise => 'Lời hứa trọn đời của chúng tôi';

  @override
  String get lifetimePromiseDescription =>
      'Cá nhân tôi hứa sẽ cung cấp hỗ trợ và bảo trì liên tục cho ứng dụng này trong suốt cuộc đời mình, In Sha Allah. Mục tiêu của tôi là đảm bảo ứng dụng này vẫn là một nguồn tài nguyên hữu ích cho Ummah trong nhiều năm tới.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Bình minh';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Nửa đêm';

  @override
  String get alarm => 'Báo thức';

  @override
  String get notification => 'Thông báo';

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
  String get sajdaAyah => 'Ayah Sajda';

  @override
  String get required => 'Bắt buộc';

  @override
  String get optional => 'Tùy chọn';

  @override
  String get notificationScheduleWarning =>
      'Lưu ý: Thông báo hoặc Lời nhắc đã lên lịch có thể bị bỏ lỡ do các hạn chế về quy trình nền của hệ điều hành trên điện thoại của bạn. Ví dụ: Origin OS của Vivo, One UI của Samsung, ColorOS của Oppo, v.v. đôi khi sẽ hủy Thông báo hoặc Lời nhắc đã lên lịch. Vui lòng kiểm tra cài đặt hệ điều hành của bạn để ứng dụng không bị hạn chế khỏi quy trình nền.';

  @override
  String get scrollWithRecitation => 'Cuộn với đọc thuộc lòng';

  @override
  String get quickAccess => 'Truy cập nhanh';

  @override
  String get initiallyScrollAyah => 'Ban đầu cuộn đến ayah';

  @override
  String get tajweedGuide => 'Hướng dẫn Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Khi được bật, ayah Kinh Qur\'an sẽ tự động cuộn đồng bộ với phần đọc lại âm thanh.';

  @override
  String get configuration => 'Cấu hình';

  @override
  String get restoreFromBackup => 'Khôi phục từ bản sao lưu';

  @override
  String get history => 'Lịch sử';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get useAudioStream => 'Sử dụng luồng âm thanh';

  @override
  String get useAudioStreamDesc =>
      'Truyền phát âm thanh trực tiếp từ internet thay vì tải xuống.';

  @override
  String get notUseAudioStreamDesc =>
      'Tải xuống âm thanh để sử dụng ngoại tuyến và giảm mức tiêu thụ dữ liệu.';

  @override
  String get audioSettings => 'Cài đặt âm thanh';

  @override
  String get playbackSpeed => 'Tốc độ phát lại';

  @override
  String get playbackSpeedDesc => 'Điều chỉnh tốc độ đọc Kinh Qur\'an.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Vui lòng đợi quá trình tải xuống hiện tại kết thúc.';

  @override
  String get areYouSure => 'Bạn có chắc không?';

  @override
  String get checkYourInternetConnection =>
      'Kiểm tra kết nối internet của bạn.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Cần tải xuống $requiredDownload trong tổng số $totalVersesCount ayah.';
  }

  @override
  String get download => 'Tải xuống';

  @override
  String get audioDownload => 'Tải xuống âm thanh';

  @override
  String get am => 'SA';

  @override
  String get pm => 'CH';

  @override
  String get optimizingQuranScript => 'Tối ưu hóa kịch bản Kinh Qur\'an';

  @override
  String get supportOnGithub => 'Hỗ trợ trên GitHub';

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
