// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey에 대한 타프시르를 찾을 수 없습니다';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return '타프시르는 $anotherAyahLinkKey에서 찾을 수 있습니다';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey(으)로 이동';
  }

  @override
  String get hizb => '히즈브';

  @override
  String get juz => '주즈';

  @override
  String get page => '페이지';

  @override
  String get ruku => '루쿠';

  @override
  String get languageSettings => '언어 설정';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey절';
  }

  @override
  String ayahsCount(String count) {
    return '$count개 절';
  }

  @override
  String get saveAndDownload => '저장 및 다운로드';

  @override
  String get appLanguage => '앱 언어';

  @override
  String get selectAppLanguage => '앱 언어 선택...';

  @override
  String get pleaseSelectOne => '하나를 선택해주세요';

  @override
  String get quranTranslationLanguage => '꾸란 번역 언어';

  @override
  String get selectTranslationLanguage => '번역 언어 선택...';

  @override
  String get quranTranslationBook => '꾸란 번역본';

  @override
  String get selectTranslationBook => '번역본 선택...';

  @override
  String get quranTafsirLanguage => '꾸란 타프시르 언어';

  @override
  String get selectTafsirLanguage => '타프시르 언어 선택...';

  @override
  String get quranTafsirBook => '꾸란 타프시르 책';

  @override
  String get selectTafsirBook => '타프시르 책 선택...';

  @override
  String get quranScriptAndStyle => '꾸란 서체 및 스타일';

  @override
  String get justAMoment => '잠시만 기다려주세요...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => '성공';

  @override
  String get retry => '재시도';

  @override
  String get unableToDownloadResources => '리소스를 다운로드할 수 없습니다...\n문제가 발생했습니다';

  @override
  String get downloadingSegmentedQuranRecitation => '구분된 꾸란 낭송 다운로드 중';

  @override
  String get processingSegmentedQuranRecitation => '구분된 꾸란 낭송 처리 중';

  @override
  String get footnote => '각주';

  @override
  String get tafsir => '타프시르';

  @override
  String get wordByWord => '단어별';

  @override
  String get pleaseSelectRequiredOption => '필수 옵션을 선택해주세요';

  @override
  String get rememberHomeTab => '홈 탭 기억하기';

  @override
  String get rememberHomeTabSubtitle => '앱이 홈 화면에서 마지막으로 열었던 탭을 기억합니다.';

  @override
  String get wakeLock => '화면 꺼짐 방지';

  @override
  String get wakeLockSubtitle => '화면이 자동으로 꺼지는 것을 방지합니다.';

  @override
  String get settings => '설정';

  @override
  String get appTheme => '앱 테마';

  @override
  String get quranStyle => '꾸란 스타일';

  @override
  String get changeTheme => '테마 변경';

  @override
  String get verseCount => '절 수: ';

  @override
  String get translation => '번역';

  @override
  String get tafsirNotFound => '찾을 수 없음';

  @override
  String get moreInfo => '더 보기';

  @override
  String get playAudio => '오디오 재생';

  @override
  String get preview => '미리보기';

  @override
  String get loading => '로딩 중...';

  @override
  String get errorFetchingAddress => '주소를 가져오는 중 오류 발생';

  @override
  String get addressNotAvailable => '주소를 사용할 수 없음';

  @override
  String get latitude => '위도: ';

  @override
  String get longitude => '경도: ';

  @override
  String get name => '이름: ';

  @override
  String get location => '위치: ';

  @override
  String get parameters => '매개변수: ';

  @override
  String get selectCalculationMethod => '계산 방법 선택';

  @override
  String get shareSelectAyahs => '선택한 아야 공유';

  @override
  String get selectionEmpty => '선택 항목 없음';

  @override
  String get generatingImagePleaseWait => '이미지 생성 중... 잠시만 기다려주세요';

  @override
  String get asImage => '이미지로';

  @override
  String get asText => '텍스트로';

  @override
  String get playFromSelectedAyah => '선택한 아야부터 재생';

  @override
  String get toTafsir => '타프시르로';

  @override
  String get selectAyah => '아야 선택';

  @override
  String get toAyah => '아야로';

  @override
  String get searchForASurah => '수라 검색';

  @override
  String get bugReportTitle => '버그 신고';

  @override
  String get audioCached => '오디오 캐시됨';

  @override
  String get others => '기타';

  @override
  String get quranTranslationAyahOneMustEnabled => '꾸란|번역|아야 중 하나는 활성화해야 합니다';

  @override
  String get quranFontSize => '꾸란 글꼴 크기';

  @override
  String get quranLineHeight => '꾸란 줄 간격';

  @override
  String get translationAndTafsirFontSize => '번역 및 타프시르 글꼴 크기';

  @override
  String get quranAyah => '꾸란 아야';

  @override
  String get topToolbar => '상단 도구 모음';

  @override
  String get keepOpenWordByWord => '단어별 번역 열어두기';

  @override
  String get wordByWordHighlight => '단어별 하이라이트';

  @override
  String get quranScriptSettings => '꾸란 서체 설정';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => '페이지: ';

  @override
  String get quranResources => '꾸란 자료';

  @override
  String alreadySelected(String name) {
    return '\'$name\' 언어는 이미 선택되었습니다.';
  }

  @override
  String get unableToGetCompassData => '나침반 데이터를 가져올 수 없습니다';

  @override
  String get deviceDoesNotHaveSensors => '기기에 센서가 없습니다!';

  @override
  String get north => '북';

  @override
  String get east => '동';

  @override
  String get south => '남';

  @override
  String get west => '서';

  @override
  String get address => '주소: ';

  @override
  String get change => '변경';

  @override
  String get calculationMethod => '계산 방법: ';

  @override
  String get downloadPrayerTime => '기도 시간 다운로드';

  @override
  String get calculationMethodsListEmpty => '계산 방법 목록이 비어 있습니다.';

  @override
  String get noCalculationMethodWithLocationData =>
      '위치 데이터에 맞는 계산 방법을 찾을 수 없습니다.';

  @override
  String get prayerSettings => '기도 설정';

  @override
  String get reminderSettings => '알림 설정';

  @override
  String get adjustReminderTime => '알림 시간 조정';

  @override
  String get enforceAlarmSound => '알람 소리 강제 설정';

  @override
  String get enforceAlarmSoundDescription =>
      '활성화하면 휴대폰 소리가 작더라도 여기서 설정한 볼륨으로 알람이 울립니다. 이 기능은 휴대폰 볼륨이 작아서 알람을 놓치는 것을 방지합니다.';

  @override
  String get volume => '볼륨';

  @override
  String get atPrayerTime => '기도 시간에';

  @override
  String minBefore(int minutes) {
    return '$minutes분 전';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes분 후';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName 시간은 $prayerTime입니다';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerName 시간입니다';
  }

  @override
  String get stopTheAdhan => '아잔 중지';

  @override
  String dateFoundEmpty(String date) {
    return '$date를 찾을 수 없음';
  }

  @override
  String get today => '오늘';

  @override
  String get left => '남음';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName 알림이 추가되었습니다';
  }

  @override
  String get allowNotificationPermission => '이 기능을 사용하려면 알림 권한을 허용해주세요';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName 알림이 제거되었습니다';
  }

  @override
  String get getPrayerTimesAndQibla => '기도 시간 및 키블라 확인';

  @override
  String get getPrayerTimesAndQiblaDescription => '지정된 위치의 기도 시간과 키블라를 계산합니다.';

  @override
  String get getFromGPS => 'GPS에서 가져오기';

  @override
  String get or => '또는';

  @override
  String get selectYourCity => '도시 선택';

  @override
  String get noteAboutGPS =>
      '참고: GPS를 사용하고 싶지 않거나 보안이 우려되는 경우, 도시를 직접 선택할 수 있습니다.';

  @override
  String get downloadingLocationResources => '위치 리소스 다운로드 중...';

  @override
  String get somethingWentWrong => '문제가 발생했습니다';

  @override
  String get selectYourCountry => '국가 선택';

  @override
  String get searchForACountry => '국가 검색';

  @override
  String get selectYourAdministrator => '지역 선택';

  @override
  String get searchForAnAdministrator => '지역 검색';

  @override
  String get searchForACity => '도시 검색';

  @override
  String get pleaseEnableLocationService => '위치 서비스를 활성화해주세요';

  @override
  String get donateUs => '후원하기';

  @override
  String get underDevelopment => '개발 중';

  @override
  String get versionLoading => '로딩 중...';

  @override
  String get alQuran => '알 꾸란';

  @override
  String get mainMenu => '메인 메뉴';

  @override
  String get notes => '노트';

  @override
  String get pinned => '고정됨';

  @override
  String get jumpToAyah => '아야로 이동';

  @override
  String get shareMultipleAyah => '여러 아야 공유';

  @override
  String get shareThisApp => '이 앱 공유하기';

  @override
  String get giveRating => '평점 남기기';

  @override
  String get bugReport => '버그 신고';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get aboutTheApp => '앱 정보';

  @override
  String get resetTheApp => '앱 초기화';

  @override
  String get resetAppWarningTitle => '앱 데이터 초기화';

  @override
  String get resetAppWarningMessage =>
      '앱을 초기화하시겠습니까? 모든 데이터가 삭제되며, 앱을 처음부터 다시 설정해야 합니다.';

  @override
  String get cancel => '취소';

  @override
  String get reset => '초기화';

  @override
  String get shareAppSubject => '이 알 꾸란 앱을 확인해보세요!';

  @override
  String shareAppBody(String appLink) {
    return '앗살라무 알라이쿰! 매일 꾸란을 읽고 묵상할 수 있는 이 알 꾸란 앱을 확인해보세요. 알라의 말씀을 더 가까이하는 데 도움이 됩니다. 다운로드 링크: $appLink';
  }

  @override
  String get openDrawerTooltip => '메뉴 열기';

  @override
  String get quran => '꾸란';

  @override
  String get prayer => '기도';

  @override
  String get qibla => '키블라';

  @override
  String get audio => '오디오';

  @override
  String get surah => '수라';

  @override
  String get pages => '페이지';

  @override
  String get note => '참고:';

  @override
  String get linkedAyahs => '연결된 아야:';

  @override
  String get emptyNoteCollection => '노트 모음이 비어 있습니다.\n여기에 노트를 추가하여 확인하세요.';

  @override
  String get emptyPinnedCollection =>
      '이 모음에 고정된 아야가 없습니다.\n아야를 고정하여 여기에서 확인하세요.';

  @override
  String get noContentAvailable => '사용 가능한 콘텐츠가 없습니다.';

  @override
  String failedToLoadCollections(String error) {
    return '모음을 불러오는 데 실패했습니다: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType 이름으로 검색...';
  }

  @override
  String get sortBy => '정렬 기준';

  @override
  String noCollectionAddedYet(String collectionType) {
    return '아직 추가된 $collectionType이(가) 없습니다';
  }

  @override
  String pinnedItemsCount(int count) {
    return '고정된 항목 $count개';
  }

  @override
  String notesCount(int count) {
    return '노트 $count개';
  }

  @override
  String get emptyNameNotAllowed => '이름을 비워둘 수 없습니다';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName(으)로 업데이트됨';
  }

  @override
  String get changeName => '이름 변경';

  @override
  String get changeColor => '색상 변경';

  @override
  String get colorUpdated => '색상이 업데이트되었습니다';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName 삭제됨';
  }

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get collectionNameCannotBeEmpty => '모음 이름은 비워둘 수 없습니다.';

  @override
  String get addedNewCollection => '새 모음 추가됨';

  @override
  String ayahCount(int count) {
    return '아야 $count개';
  }

  @override
  String get byNameAtoZ => '이름 오름차순 (A-Z)';

  @override
  String get byNameZtoA => '이름 내림차순 (Z-A)';

  @override
  String get byElementNumberAscending => '항목 번호 오름차순';

  @override
  String get byElementNumberDescending => '항목 번호 내림차순';

  @override
  String get byUpdateDateAscending => '업데이트 날짜 오름차순';

  @override
  String get byUpdateDateDescending => '업데이트 날짜 내림차순';

  @override
  String get byCreateDateAscending => '생성 날짜 오름차순';

  @override
  String get byCreateDateDescending => '생성 날짜 내림차순';

  @override
  String get translationNotFound => '번역을 찾을 수 없음';

  @override
  String get translationTitle => '번역:';

  @override
  String get footNoteTitle => '각주:';

  @override
  String get wordByWordTranslation => '단어별 번역:';

  @override
  String get tafsirButton => '타프시르';

  @override
  String get shareButton => '공유';

  @override
  String get addNoteButton => '노트 추가';

  @override
  String get pinToCollectionButton => '모음에 고정';

  @override
  String get shareAsText => '텍스트로 공유';

  @override
  String get copiedWithTafsir => '타프시르와 함께 복사됨';

  @override
  String get shareAsImage => '이미지로 공유';

  @override
  String get shareWithTafsir => '타프시르와 함께 공유';

  @override
  String get notFound => '찾을 수 없음';

  @override
  String get noteContentCannotBeEmpty => '노트 내용은 비워둘 수 없습니다.';

  @override
  String get noteSavedSuccessfully => '노트가 성공적으로 저장되었습니다!';

  @override
  String get selectCollections => '모음 선택';

  @override
  String get addNote => '노트 추가';

  @override
  String get writeCollectionName => '모음 이름 입력...';

  @override
  String get noCollectionsYetAddANewOne => '아직 모음이 없습니다. 새 모음을 추가하세요!';

  @override
  String get pleaseWriteYourNoteFirst => '먼저 노트를 작성해주세요.';

  @override
  String get noCollectionSelected => '선택된 모음 없음';

  @override
  String get saveNote => '노트 저장';

  @override
  String get nextSelectCollections => '다음: 모음 선택';

  @override
  String get addToPinned => '고정 항목에 추가';

  @override
  String get pinnedSavedSuccessfully => '고정 항목이 성공적으로 저장되었습니다!';

  @override
  String get savePinned => '고정 항목 저장';

  @override
  String get closeAudioController => '오디오 컨트롤러 닫기';

  @override
  String get previous => '이전';

  @override
  String get rewind => '되감기';

  @override
  String get fastForward => '빨리 감기';

  @override
  String get playNextAyah => '다음 아야 재생';

  @override
  String get repeat => '반복';

  @override
  String get playAsPlaylist => '재생 목록으로 재생';

  @override
  String style(String style) {
    return '스타일: $style';
  }

  @override
  String get stopAndClose => '중지 및 닫기';

  @override
  String get play => '재생';

  @override
  String get pause => '일시정지';

  @override
  String get selectReciter => '낭송가 선택';

  @override
  String source(String source) {
    return '출처: $source';
  }

  @override
  String get newText => '새로움';

  @override
  String get more => '더보기: ';

  @override
  String get cacheNotFound => '캐시를 찾을 수 없음';

  @override
  String get cacheSize => '캐시 크기';

  @override
  String error(String error) {
    return '오류: $error';
  }

  @override
  String get clean => '정리';

  @override
  String get lastModified => '마지막 수정';

  @override
  String get oneYearAgo => '1년 전';

  @override
  String monthsAgo(String number) {
    return '$number개월 전';
  }

  @override
  String weeksAgo(String number) {
    return '$number주 전';
  }

  @override
  String daysAgo(String number) {
    return '$number일 전';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour시간 전';
  }

  @override
  String get aboutAlQuran => '알 꾸란 정보';

  @override
  String get appFullName => '알 꾸란 (타프시르, 기도, 키블라, 오디오)';

  @override
  String get appDescription =>
      '안드로이드, iOS, MacOS, 웹, 리눅스, 윈도우를 위한 종합 이슬람 애플리케이션으로, 타프시르 및 다중 번역(단어별 번역 포함)과 함께 꾸란 읽기, 알림 기능이 있는 전 세계 기도 시간, 키블라 나침반, 단어별 동기화 오디오 낭송을 제공합니다.';

  @override
  String get dataSourcesNote =>
      '참고: 꾸란 본문, 타프시르, 번역, 오디오 자료는 Quran.com, Everyayah.com 및 기타 검증된 오픈 소스에서 가져옵니다.';

  @override
  String get adFreePromise =>
      '이 앱은 알라의 기쁨을 구하기 위해 만들어졌습니다. 따라서 현재도, 그리고 앞으로도 항상 완전한 광고 없는 앱이 될 것입니다.';

  @override
  String get coreFeatures => '주요 기능';

  @override
  String get coreFeaturesDescription =>
      '알 꾸란 v3를 매일의 이슬람 실천에 필수적인 도구로 만들어주는 주요 기능들을 살펴보세요:';

  @override
  String get prayerTimesTitle => '기도 시간 및 알림';

  @override
  String get prayerTimesDescription =>
      '다양한 계산 방법을 사용하여 전 세계 모든 위치의 정확한 기도 시간을 제공합니다. 아잔 알림으로 리마인더를 설정하세요.';

  @override
  String get qiblaDirectionTitle => '키블라 방향';

  @override
  String get qiblaDirectionDescription =>
      '명확하고 정확한 나침반 뷰로 키블라 방향을 쉽게 찾을 수 있습니다.';

  @override
  String get translationTafsirTitle => '꾸란 번역 및 타프시르';

  @override
  String get translationTafsirDescription =>
      '69개 언어로 된 120개 이상의 번역본(단어별 번역 포함)과 30개 이상의 타프시르 책에 접근할 수 있습니다.';

  @override
  String get wordByWordAudioTitle => '단어별 오디오 및 하이라이트';

  @override
  String get wordByWordAudioDescription =>
      '동기화된 단어별 오디오 낭송과 하이라이트를 따라가며 몰입감 있는 학습 경험을 해보세요.';

  @override
  String get ayahAudioRecitationTitle => '아야 오디오 낭송';

  @override
  String get ayahAudioRecitationDescription =>
      '40명 이상의 유명 낭송가들의 전체 아야 낭송을 들어보세요.';

  @override
  String get notesCloudBackupTitle => '클라우드 백업이 지원되는 노트';

  @override
  String get notesCloudBackupDescription =>
      '개인적인 노트와 묵상을 안전하게 클라우드에 백업하여 저장하세요 (기능 개발 중/출시 예정).';

  @override
  String get crossPlatformSupportTitle => '크로스 플랫폼 지원';

  @override
  String get crossPlatformSupportDescription => '안드로이드, 웹, 리눅스, 윈도우에서 지원됩니다.';

  @override
  String get backgroundAudioPlaybackTitle => '백그라운드 오디오 재생';

  @override
  String get backgroundAudioPlaybackDescription =>
      '앱이 백그라운드에 있을 때도 꾸란 낭송을 계속 들을 수 있습니다.';

  @override
  String get audioDataCachingTitle => '오디오 및 데이터 캐싱';

  @override
  String get audioDataCachingDescription =>
      '강력한 오디오 및 꾸란 데이터 캐싱으로 향상된 재생 및 오프라인 기능을 제공합니다.';

  @override
  String get minimalisticInterfaceTitle => '미니멀하고 깔끔한 인터페이스';

  @override
  String get minimalisticInterfaceDescription =>
      '사용자 경험과 가독성에 초점을 맞춘 탐색하기 쉬운 인터페이스.';

  @override
  String get optimizedPerformanceTitle => '최적화된 성능 및 크기';

  @override
  String get optimizedPerformanceDescription =>
      '가볍고 성능이 뛰어나도록 설계된 기능이 풍부한 애플리케이션입니다.';

  @override
  String get languageSupport => '언어 지원';

  @override
  String get languageSupportDescription =>
      '이 애플리케이션은 다음 언어를 지원하여 전 세계 사용자가 접근할 수 있도록 설계되었습니다 (더 많은 언어가 계속 추가될 예정입니다):';

  @override
  String get technologyAndResources => '기술 및 자료';

  @override
  String get technologyAndResourcesDescription =>
      '이 앱은 최첨단 기술과 신뢰할 수 있는 자료를 사용하여 제작되었습니다:';

  @override
  String get flutterFrameworkTitle => '플러터 프레임워크';

  @override
  String get flutterFrameworkDescription =>
      '단일 코드베이스에서 아름답고, 네이티브로 컴파일된, 멀티플랫폼 경험을 제공하기 위해 플러터로 제작되었습니다.';

  @override
  String get advancedAudioEngineTitle => '고급 오디오 엔진';

  @override
  String get advancedAudioEngineDescription =>
      '강력한 오디오 재생 및 제어를 위해 `just_audio` 및 `just_audio_background` 플러터 패키지를 사용합니다.';

  @override
  String get reliableQuranDataTitle => '신뢰할 수 있는 꾸란 데이터';

  @override
  String get reliableQuranDataDescription =>
      '알 꾸란 본문, 번역, 타프시르, 오디오는 Quran.com 및 Everyayah.com과 같은 검증된 오픈 API 및 데이터베이스에서 제공됩니다.';

  @override
  String get prayerTimeEngineTitle => '기도 시간 엔진';

  @override
  String get prayerTimeEngineDescription =>
      '정확한 기도 시간을 위해 확립된 계산 방법을 활용합니다. 알림은 `flutter_local_notifications` 및 백그라운드 작업을 통해 처리됩니다.';

  @override
  String get crossPlatformSupport => '크로스 플랫폼 지원';

  @override
  String get crossPlatformSupportDescription2 => '다양한 플랫폼에서 원활한 접근을 즐기세요:';

  @override
  String get android => '안드로이드';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => '웹';

  @override
  String get linux => '리눅스';

  @override
  String get windows => '윈도우';

  @override
  String get ourLifetimePromise => '평생의 약속';

  @override
  String get lifetimePromiseDescription =>
      '인샤알라, 저는 평생 이 애플리케이션에 대한 지속적인 지원과 유지보수를 제공할 것을 개인적으로 약속합니다. 제 목표는 이 앱이 앞으로 수년간 움마(이슬람 공동체)에게 유익한 자원으로 남도록 하는 것입니다.';

  @override
  String get fajr => '파즈르';

  @override
  String get sunrise => '일출';

  @override
  String get dhuhr => '두흐르';

  @override
  String get asr => '아스르';

  @override
  String get maghrib => '마그리브';

  @override
  String get isha => '이샤';

  @override
  String get midnight => '자정';

  @override
  String get alarm => '알람';

  @override
  String get notification => '알림';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$country $administrativeArea $subAdministrativeArea';
  }

  @override
  String get quranScriptTajweed => '타즈위드';

  @override
  String get quranScriptUthmani => '우스마니체';

  @override
  String get quranScriptIndopak => '인도파크체';

  @override
  String get sajdaAyah => '사즈다 구절';

  @override
  String get required => '필수';

  @override
  String get optional => '선택';

  @override
  String get notificationScheduleWarning =>
      '참고: 휴대폰 OS의 백그라운드 프로세스 제한으로 인해 예약된 알림이나 미리 알림을 놓칠 수 있습니다. 예: Vivo의 Origin OS, Samsung의 One UI, Oppo의 ColorOS 등은 때때로 예약된 알림이나 미리 알림을 종료합니다. 앱이 백그라운드 프로세스에서 제한되지 않도록 OS 설정을 확인하십시오.';

  @override
  String get scrollWithRecitation => '낭송으로 스크롤';

  @override
  String get quickAccess => '빠른 접근';

  @override
  String get initiallyScrollAyah => '처음에 ayah로 스크롤';

  @override
  String get tajweedGuide => '타지위드 가이드';

  @override
  String get configuration => 'Configuration';

  @override
  String get restoreFromBackup => 'Restore From Backup';
}
