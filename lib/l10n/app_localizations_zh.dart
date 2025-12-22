// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple（$nameArabic） - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey 的塔夫西尔不可用';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return '塔夫西尔可在：$anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '跳转到 $anotherAyahLinkKey';
  }

  @override
  String get hizb => '希兹布';

  @override
  String get juz => '朱兹';

  @override
  String get page => '页';

  @override
  String get ruku => '鲁库';

  @override
  String get languageSettings => '语言设置';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count 经节';
  }

  @override
  String get saveAndDownload => '保存并下载';

  @override
  String get appLanguage => '应用语言';

  @override
  String get selectAppLanguage => '选择应用语言...';

  @override
  String get pleaseSelectOne => '请选择一个';

  @override
  String get quranTranslationLanguage => '古兰经翻译语言';

  @override
  String get selectTranslationLanguage => '选择翻译语言...';

  @override
  String get quranTranslationBook => '古兰经翻译书籍';

  @override
  String get selectTranslationBook => '选择翻译书籍...';

  @override
  String get quranTafsirLanguage => '古兰经塔夫西尔语言';

  @override
  String get selectTafsirLanguage => '选择塔夫西尔语言...';

  @override
  String get quranTafsirBook => '古兰经塔夫西尔书籍';

  @override
  String get selectTafsirBook => '选择塔夫西尔书籍...';

  @override
  String get quranScriptAndStyle => '古兰经字体与风格';

  @override
  String get justAMoment => '稍等片刻...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => '成功';

  @override
  String get retry => '重试';

  @override
  String get unableToDownloadResources => '无法下载资源...\n出了点问题';

  @override
  String get downloadingSegmentedQuranRecitation => '下载分段古兰经朗诵';

  @override
  String get processingSegmentedQuranRecitation => '处理分段古兰经朗诵';

  @override
  String get footnote => '脚注';

  @override
  String get tafsir => '塔夫西尔';

  @override
  String get wordByWord => '逐字';

  @override
  String get pleaseSelectRequiredOption => '请选择所需选项';

  @override
  String get rememberHomeTab => '记住首页标签';

  @override
  String get rememberHomeTabSubtitle => '应用将记住首页中最后打开的标签。';

  @override
  String get wakeLock => '保持屏幕常亮';

  @override
  String get wakeLockSubtitle => '防止屏幕自动关闭。';

  @override
  String get settings => '设置';

  @override
  String get appTheme => '应用主题';

  @override
  String get quranStyle => '古兰经风格';

  @override
  String get changeTheme => '更改主题';

  @override
  String get verseCount => '经节数：';

  @override
  String get translation => '翻译';

  @override
  String get tafsirNotFound => '未找到';

  @override
  String get moreInfo => '更多信息';

  @override
  String get playAudio => '播放音频';

  @override
  String get preview => '预览';

  @override
  String get loading => '加载中...';

  @override
  String get errorFetchingAddress => '获取地址出错';

  @override
  String get addressNotAvailable => '地址不可用';

  @override
  String get latitude => '纬度：';

  @override
  String get longitude => '经度：';

  @override
  String get name => '名称：';

  @override
  String get location => '位置：';

  @override
  String get parameters => '参数：';

  @override
  String get selectCalculationMethod => '选择计算方法';

  @override
  String get shareSelectAyahs => '分享选中的经节';

  @override
  String get selectionEmpty => '选择为空';

  @override
  String get generatingImagePleaseWait => '生成图像... 请稍等';

  @override
  String get asImage => '作为图像';

  @override
  String get asText => '作为文本';

  @override
  String get playFromSelectedAyah => '从选中的经节播放';

  @override
  String get toTafsir => '到塔夫西尔';

  @override
  String get selectAyah => '选择经节';

  @override
  String get toAyah => '到经节';

  @override
  String get searchForASurah => '搜索章节';

  @override
  String get bugReportTitle => 'bug报告';

  @override
  String get audioCached => '音频已缓存';

  @override
  String get others => '其他';

  @override
  String get quranTranslationAyahOneMustEnabled => '古兰经|翻译|经节，必须启用一个';

  @override
  String get quranFontSize => '古兰经字体大小';

  @override
  String get quranLineHeight => '古兰经行高';

  @override
  String get translationAndTafsirFontSize => '翻译与塔夫西尔字体大小';

  @override
  String get quranAyah => '古兰经经节';

  @override
  String get topToolbar => '顶部工具栏';

  @override
  String get keepOpenWordByWord => '保持逐字打开';

  @override
  String get wordByWordHighlight => '逐字高亮';

  @override
  String get quranScriptSettings => '古兰经字体设置';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => '页码：';

  @override
  String get quranResources => '古兰经资源';

  @override
  String alreadySelected(String name) {
    return '语言 \'$name\' 已选中。';
  }

  @override
  String get unableToGetCompassData => '无法获取罗盘数据';

  @override
  String get deviceDoesNotHaveSensors => '设备没有传感器！';

  @override
  String get north => '北';

  @override
  String get east => '东';

  @override
  String get south => '南';

  @override
  String get west => '西';

  @override
  String get address => '地址：';

  @override
  String get change => '更改';

  @override
  String get calculationMethod => '计算方法：';

  @override
  String get downloadPrayerTime => '下载礼拜时间';

  @override
  String get calculationMethodsListEmpty => '计算方法列表为空。';

  @override
  String get noCalculationMethodWithLocationData => '找不到带有位置数据的计算方法。';

  @override
  String get prayerSettings => '礼拜设置';

  @override
  String get reminderSettings => '提醒设置';

  @override
  String get adjustReminderTime => '调整提醒时间';

  @override
  String get enforceAlarmSound => '强制闹铃声音';

  @override
  String get enforceAlarmSoundDescription =>
      '如果启用，此功能将以此处设置的音量播放闹铃，即使手机声音很低。这确保您不会因手机音量低而错过闹铃。';

  @override
  String get volume => '音量';

  @override
  String get atPrayerTime => '在礼拜时间';

  @override
  String minBefore(int minutes) {
    return '$minutes 分钟前';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes 分钟后';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName 在 $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '现在是 $prayerName 的时间';
  }

  @override
  String get stopTheAdhan => '停止宣礼';

  @override
  String dateFoundEmpty(String date) {
    return '$date 为空';
  }

  @override
  String get today => '今天';

  @override
  String get left => '剩余';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerName 的提醒已添加';
  }

  @override
  String get allowNotificationPermission => '请允许通知权限以使用此功能';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerName 的提醒已移除';
  }

  @override
  String get getPrayerTimesAndQibla => '获取礼拜时间和克尔白方向';

  @override
  String get getPrayerTimesAndQiblaDescription => '为任何给定位置计算礼拜时间和克尔白方向。';

  @override
  String get getFromGPS => '从 GPS 获取';

  @override
  String get or => '或';

  @override
  String get selectYourCity => '选择您的城市';

  @override
  String get noteAboutGPS => '注意：如果您不想使用 GPS 或觉得不安全，您可以选择您的城市。';

  @override
  String get downloadingLocationResources => '下载位置资源...';

  @override
  String get somethingWentWrong => '出了点问题';

  @override
  String get selectYourCountry => '选择您的国家';

  @override
  String get searchForACountry => '搜索国家';

  @override
  String get selectYourAdministrator => '选择您的行政区';

  @override
  String get searchForAnAdministrator => '搜索行政区';

  @override
  String get searchForACity => '搜索城市';

  @override
  String get pleaseEnableLocationService => '请启用位置服务';

  @override
  String get donateUs => '捐赠我们';

  @override
  String get underDevelopment => '开发中';

  @override
  String get versionLoading => '加载中...';

  @override
  String get alQuran => '古兰经';

  @override
  String get mainMenu => '主菜单';

  @override
  String get notes => '笔记';

  @override
  String get pinned => '已固定';

  @override
  String get jumpToAyah => '跳转到经节';

  @override
  String get shareMultipleAyah => '分享多个经节';

  @override
  String get shareThisApp => '分享此应用';

  @override
  String get giveRating => '给予评分';

  @override
  String get bugReport => 'bug报告';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get aboutTheApp => '关于应用';

  @override
  String get resetTheApp => '重置应用';

  @override
  String get resetAppWarningTitle => '重置应用数据';

  @override
  String get resetAppWarningMessage => '您确定要重置应用吗？所有数据将丢失，您需要从头设置应用。';

  @override
  String get cancel => '取消';

  @override
  String get reset => '重置';

  @override
  String get shareAppSubject => '看看这个古兰经应用！';

  @override
  String shareAppBody(String appLink) {
    return '阿萨拉姆阿拉伊库姆！看看这个古兰经应用，用于日常阅读和反思。它帮助与安拉的话语连接。在此下载：$appLink';
  }

  @override
  String get openDrawerTooltip => '打开抽屉';

  @override
  String get quran => '古兰经';

  @override
  String get prayer => '礼拜';

  @override
  String get qibla => '克尔白';

  @override
  String get audio => '音频';

  @override
  String get surah => '章节';

  @override
  String get pages => '页';

  @override
  String get note => '笔记：';

  @override
  String get linkedAyahs => '链接经节：';

  @override
  String get emptyNoteCollection => '此笔记集合为空。\n添加一些笔记以在此处查看。';

  @override
  String get emptyPinnedCollection => '尚未固定经节到此集合。\n固定经节以在此处查看。';

  @override
  String get noContentAvailable => '无可用内容。';

  @override
  String failedToLoadCollections(String error) {
    return '加载集合失败：$error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '按 $collectionType 名称搜索...';
  }

  @override
  String get sortBy => '排序方式';

  @override
  String noCollectionAddedYet(String collectionType) {
    return '尚未添加 $collectionType';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count 个固定项';
  }

  @override
  String notesCount(int count) {
    return '$count 个笔记';
  }

  @override
  String get emptyNameNotAllowed => '不允许空名称';

  @override
  String updatedTo(String collectionName) {
    return '更新为 $collectionName';
  }

  @override
  String get changeName => '更改名称';

  @override
  String get changeColor => '更改颜色';

  @override
  String get colorUpdated => '颜色已更新';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName 已删除';
  }

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get collectionNameCannotBeEmpty => '集合名称不能为空。';

  @override
  String get addedNewCollection => '添加新集合';

  @override
  String ayahCount(int count) {
    return '$count 经节';
  }

  @override
  String get byNameAtoZ => '名称 A-Z';

  @override
  String get byNameZtoA => '名称 Z-A';

  @override
  String get byElementNumberAscending => '元素编号升序';

  @override
  String get byElementNumberDescending => '元素编号降序';

  @override
  String get byUpdateDateAscending => '更新日期升序';

  @override
  String get byUpdateDateDescending => '更新日期降序';

  @override
  String get byCreateDateAscending => '创建日期升序';

  @override
  String get byCreateDateDescending => '创建日期降序';

  @override
  String get translationNotFound => '翻译未找到';

  @override
  String get translationTitle => '翻译：';

  @override
  String get footNoteTitle => '脚注：';

  @override
  String get wordByWordTranslation => '逐字翻译：';

  @override
  String get tafsirButton => '塔夫西尔';

  @override
  String get shareButton => '分享';

  @override
  String get addNoteButton => '添加笔记';

  @override
  String get pinToCollectionButton => '固定到集合';

  @override
  String get shareAsText => '作为文本分享';

  @override
  String get copiedWithTafsir => '已复制带塔夫西尔';

  @override
  String get shareAsImage => '作为图像分享';

  @override
  String get shareWithTafsir => '带塔夫西尔分享';

  @override
  String get notFound => '未找到';

  @override
  String get noteContentCannotBeEmpty => '笔记内容不能为空。';

  @override
  String get noteSavedSuccessfully => '笔记保存成功！';

  @override
  String get selectCollections => '选择集合';

  @override
  String get addNote => '添加笔记';

  @override
  String get writeCollectionName => '写入集合名称...';

  @override
  String get noCollectionsYetAddANewOne => '尚未有集合。添加一个新的！';

  @override
  String get pleaseWriteYourNoteFirst => '请先写您的笔记。';

  @override
  String get noCollectionSelected => '未选择集合';

  @override
  String get saveNote => '保存笔记';

  @override
  String get nextSelectCollections => '下一步：选择集合';

  @override
  String get addToPinned => '添加到固定';

  @override
  String get pinnedSavedSuccessfully => '固定保存成功！';

  @override
  String get savePinned => '保存固定';

  @override
  String get closeAudioController => '关闭音频控制器';

  @override
  String get previous => '上一个';

  @override
  String get rewind => '倒回';

  @override
  String get fastForward => '快进';

  @override
  String get playNextAyah => '播放下一个经节';

  @override
  String get repeat => '重复';

  @override
  String get playAsPlaylist => '作为播放列表播放';

  @override
  String style(String style) {
    return '风格：$style';
  }

  @override
  String get stopAndClose => '停止并关闭';

  @override
  String get play => '播放';

  @override
  String get pause => '暂停';

  @override
  String get selectReciter => '选择朗诵者';

  @override
  String source(String source) {
    return '来源：$source';
  }

  @override
  String get newText => '新';

  @override
  String get more => '更多：';

  @override
  String get cacheNotFound => '缓存未找到';

  @override
  String get cacheSize => '缓存大小';

  @override
  String error(String error) {
    return '错误：$error';
  }

  @override
  String get clean => '清理';

  @override
  String get lastModified => '最后修改';

  @override
  String get oneYearAgo => '1 年前';

  @override
  String monthsAgo(String number) {
    return '$number 个月前';
  }

  @override
  String weeksAgo(String number) {
    return '$number 周前';
  }

  @override
  String daysAgo(String number) {
    return '$number 天前';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour 小时前';
  }

  @override
  String get aboutAlQuran => '关于古兰经';

  @override
  String get appFullName => '古兰经（塔夫西尔、礼拜、克尔白、音频）';

  @override
  String get appDescription =>
      '一款全面的伊斯兰应用，支持 Android、iOS、MacOS、Web、Linux 和 Windows，提供古兰经阅读带塔夫西尔和多种翻译（包括逐字）、全球礼拜时间带通知、克尔白罗盘，以及同步逐字音频朗诵。';

  @override
  String get dataSourcesNote =>
      '注意：古兰经文本、塔夫西尔、翻译和音频资源来源于 Quran.com、Everyayah.com 和其他验证的开源。';

  @override
  String get adFreePromise => '此应用是为寻求安拉喜悦而构建。因此，它现在和永远完全无广告。';

  @override
  String get coreFeatures => '核心功能';

  @override
  String get coreFeaturesDescription => '探索使古兰经 v3 成为您日常伊斯兰实践不可或缺工具的关键功能：';

  @override
  String get prayerTimesTitle => '礼拜时间与警报';

  @override
  String get prayerTimesDescription => '使用各种计算方法为全球任何位置提供准确的礼拜时间。设置带宣礼通知的提醒。';

  @override
  String get qiblaDirectionTitle => '克尔白方向';

  @override
  String get qiblaDirectionDescription => '使用清晰准确的罗盘视图轻松找到克尔白方向。';

  @override
  String get translationTafsirTitle => '古兰经翻译与塔夫西尔';

  @override
  String get translationTafsirDescription =>
      '访问 120+ 翻译书籍（包括逐字）支持 69 种语言，以及 30+ 塔夫西尔书籍。';

  @override
  String get wordByWordAudioTitle => '逐字音频与高亮';

  @override
  String get wordByWordAudioDescription => '跟随同步逐字音频朗诵和高亮，提供沉浸式学习体验。';

  @override
  String get ayahAudioRecitationTitle => '经节音频朗诵';

  @override
  String get ayahAudioRecitationDescription => '听取来自 40+ 著名朗诵者的完整经节朗诵。';

  @override
  String get notesCloudBackupTitle => '笔记带云备份';

  @override
  String get notesCloudBackupDescription => '保存个人笔记和反思，安全备份到云（功能开发中/即将推出）。';

  @override
  String get crossPlatformSupportTitle => '跨平台支持';

  @override
  String get crossPlatformSupportDescription =>
      '支持 Android、Web、Linux 和 Windows。';

  @override
  String get backgroundAudioPlaybackTitle => '后台音频播放';

  @override
  String get backgroundAudioPlaybackDescription => '即使应用在后台，也继续听取古兰经朗诵。';

  @override
  String get audioDataCachingTitle => '音频与数据缓存';

  @override
  String get audioDataCachingDescription => '通过强大的音频和古兰经数据缓存改善播放和离线能力。';

  @override
  String get minimalisticInterfaceTitle => '简约干净界面';

  @override
  String get minimalisticInterfaceDescription => '易于导航的界面，专注于用户体验和可读性。';

  @override
  String get optimizedPerformanceTitle => '优化性能与大小';

  @override
  String get optimizedPerformanceDescription => '一款功能丰富的应用，设计为轻量级和高性能。';

  @override
  String get languageSupport => '语言支持';

  @override
  String get languageSupportDescription => '此应用旨在为全球观众提供支持，以下语言（并持续添加更多）：';

  @override
  String get technologyAndResources => '技术和资源';

  @override
  String get technologyAndResourcesDescription => '此应用使用前沿技术和可靠资源构建：';

  @override
  String get flutterFrameworkTitle => 'Flutter 框架';

  @override
  String get flutterFrameworkDescription =>
      '使用 Flutter 构建，提供美丽、本地编译、多平台体验，从单一代码库。';

  @override
  String get advancedAudioEngineTitle => '高级音频引擎';

  @override
  String get advancedAudioEngineDescription =>
      '由 `just_audio` 和 `just_audio_background` Flutter 包提供支持，用于强大的音频播放和控制。';

  @override
  String get reliableQuranDataTitle => '可靠古兰经数据';

  @override
  String get reliableQuranDataDescription =>
      '古兰经文本、翻译、塔夫西尔和音频来源于验证的开放 API 和数据库，如 Quran.com 和 Everyayah.com。';

  @override
  String get prayerTimeEngineTitle => '礼拜时间引擎';

  @override
  String get prayerTimeEngineDescription =>
      '利用established计算方法提供准确礼拜时间。通知由 `flutter_local_notifications` 和后台任务处理。';

  @override
  String get crossPlatformSupport => '跨平台支持';

  @override
  String get crossPlatformSupportDescription2 => '在各种平台上享受无缝访问：';

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
  String get ourLifetimePromise => '我们的终身承诺';

  @override
  String get lifetimePromiseDescription =>
      '我个人承诺在我的有生之年提供此应用的持续支持和维护，In Sha Allah。我的目标是确保此应用成为乌玛的有益资源多年。';

  @override
  String get fajr => '晨礼';

  @override
  String get sunrise => '日出';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => '晌礼';

  @override
  String get asr => '晡礼';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => '昏礼';

  @override
  String get isha => '宵礼';

  @override
  String get midnight => '午夜';

  @override
  String get alarm => '闹铃';

  @override
  String get notification => '通知';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea，$administrativeArea，$country';
  }

  @override
  String get quranScriptTajweed => '泰吉威德';

  @override
  String get quranScriptUthmani => '奥斯曼尼';

  @override
  String get quranScriptIndopak => '印巴';

  @override
  String get sajdaAyah => '叩头经节';

  @override
  String get required => '必需';

  @override
  String get optional => '可选';

  @override
  String get notificationScheduleWarning =>
      '注意：由于手机 OS 后台进程限制，预定通知或提醒可能被错过。例如：Vivo 的 Origin OS、Samsung 的 One UI、Oppo 的 ColorOS 等有时会杀死预定通知或提醒。请检查您的 OS 设置，使应用不受后台进程限制。';

  @override
  String get scrollWithRecitation => '随朗诵滚动';

  @override
  String get quickAccess => '快速访问';

  @override
  String get initiallyScrollAyah => '初始滚动到经节';

  @override
  String get tajweedGuide => '泰吉威德指南';

  @override
  String get scrollWithRecitationDesc => '启用时，古兰经经节将与音频朗诵同步自动滚动。';

  @override
  String get configuration => '配置';

  @override
  String get restoreFromBackup => '从备份恢复';

  @override
  String get history => '历史';

  @override
  String get search => '搜索';

  @override
  String get useAudioStream => '使用音频流';

  @override
  String get useAudioStreamDesc => '直接从互联网流式传输音频，而不是下载。';

  @override
  String get notUseAudioStreamDesc => '下载音频以离线使用并减少数据消耗。';

  @override
  String get audioSettings => '音频设置';

  @override
  String get playbackSpeed => '播放速度';

  @override
  String get playbackSpeedDesc => '调整古兰经朗诵的速度。';

  @override
  String get waitForCurrentDownloadToFinish => '请等待当前下载完成。';

  @override
  String get areYouSure => '您确定吗？';

  @override
  String get checkYourInternetConnection => '检查您的互联网连接。';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '需要下载 $requiredDownload 个经节，共 $totalVersesCount 个。';
  }

  @override
  String get download => '下载';

  @override
  String get audioDownload => '音频下载';

  @override
  String get am => '上午';

  @override
  String get pm => '下午';

  @override
  String get optimizingQuranScript => '优化古兰经字体';

  @override
  String get supportOnGithub => '在 GitHub 上支持';

  @override
  String get forbiddenSalatTimes => 'Forbidden Salat Times';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafieMalikiHanbali => 'Shafie, Maliki, Hanbali';
}
