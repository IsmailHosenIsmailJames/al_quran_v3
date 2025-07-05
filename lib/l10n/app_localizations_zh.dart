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
    return '$nameSimple（$nameArabic）- $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return '$ayahKey 无可用经注';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return '经注位于：$anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '跳转至 $anotherAyahLinkKey';
  }

  @override
  String get hizb => '希兹布';

  @override
  String get juz => '卷';

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
    return '$count 节';
  }

  @override
  String get saveAndDownload => '保存并下载';

  @override
  String get appLanguage => '应用语言';

  @override
  String get selectAppLanguage => '选择应用语言...';

  @override
  String get pleaseSelectOne => '请选择一项';

  @override
  String get quranTranslationLanguage => '古兰经翻译语言';

  @override
  String get selectTranslationLanguage => '选择翻译语言...';

  @override
  String get quranTranslationBook => '古兰经翻译版本';

  @override
  String get selectTranslationBook => '选择翻译版本...';

  @override
  String get quranTafsirLanguage => '古兰经经注语言';

  @override
  String get selectTafsirLanguage => '选择经注语言...';

  @override
  String get quranTafsirBook => '古兰经经注版本';

  @override
  String get selectTafsirBook => '选择经注版本...';

  @override
  String get quranScriptAndStyle => '古兰经字体与样式';

  @override
  String get justAMoment => '请稍候...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => '成功';

  @override
  String get retry => '重试';

  @override
  String get unableToDownloadResources => '无法下载资源...\n出现了一些问题';

  @override
  String get downloadingSegmentedQuranRecitation => '正在下载分段式古兰经诵读';

  @override
  String get processingSegmentedQuranRecitation => '正在处理分段式古兰经诵读';

  @override
  String get footnote => '脚注';

  @override
  String get tafsir => '经注';

  @override
  String get wordByWord => '逐词翻译';

  @override
  String get pleaseSelectRequiredOption => '请选择所需选项';

  @override
  String get rememberHomeTab => '记住主页标签';

  @override
  String get rememberHomeTabSubtitle => '应用将记住主屏幕上最后打开的标签页。';

  @override
  String get wakeLock => '屏幕常亮';

  @override
  String get wakeLockSubtitle => '防止屏幕自动关闭。';

  @override
  String get settings => '设置';

  @override
  String get appTheme => '应用主题';

  @override
  String get quranStyle => '古兰经样式';

  @override
  String get changeTheme => '更换主题';

  @override
  String get verseCount => '节数：';

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
  String get errorFetchingAddress => '获取地址时出错';

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
  String get shareSelectAyahs => '分享所选节';

  @override
  String get selectionEmpty => '选择为空';

  @override
  String get generatingImagePleaseWait => '正在生成图片... 请稍候';

  @override
  String get asImage => '作为图片';

  @override
  String get asText => '作为文本';

  @override
  String get playFromSelectedAyah => '从所选节开始播放';

  @override
  String get toTafsir => '前往经注';

  @override
  String get selectAyah => '选择节';

  @override
  String get toAyah => '前往节';

  @override
  String get searchForASurah => '搜索章';

  @override
  String get bugReportTitle => '错误报告';

  @override
  String get audioCached => '音频已缓存';

  @override
  String get others => '其他';

  @override
  String get quranTranslationAyahOneMustEnabled => '古兰经|翻译|节，必须启用其中一项';

  @override
  String get quranFontSize => '古兰经字号';

  @override
  String get quranLineHeight => '古兰经行高';

  @override
  String get translationAndTafsirFontSize => '翻译和经注字号';

  @override
  String get quranAyah => '古兰经文';

  @override
  String get topToolbar => '顶部工具栏';

  @override
  String get keepOpenWordByWord => '保持逐词翻译展开';

  @override
  String get wordByWordHighlight => '逐词高亮';

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
    return '语言“$name”已被选中。';
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
  String get enforceAlarmSound => '强制闹钟音量';

  @override
  String get enforceAlarmSoundDescription =>
      '启用后，此功能将以设定的音量播放闹钟，即使您的手机音量很低。这能确保您不会因手机音量低而错过闹钟。';

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
    return '$prayerName时间是 $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '现在是$prayerName时间';
  }

  @override
  String get stopTheAdhan => '停止宣礼';

  @override
  String dateFoundEmpty(String date) {
    return '$date 数据为空';
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
  String get getPrayerTimesAndQibla => '获取礼拜时间和朝向';

  @override
  String get getPrayerTimesAndQiblaDescription => '为任何给定地点计算礼拜时间和朝向。';

  @override
  String get getFromGPS => '从 GPS 获取';

  @override
  String get or => '或';

  @override
  String get selectYourCity => '选择您的城市';

  @override
  String get noteAboutGPS => '注意：如果您不想使用 GPS 或觉得不安全，可以选择您的城市。';

  @override
  String get downloadingLocationResources => '正在下载位置资源...';

  @override
  String get somethingWentWrong => '出现了一些问题';

  @override
  String get selectYourCountry => '选择您的国家';

  @override
  String get searchForACountry => '搜索国家';

  @override
  String get selectYourAdministrator => '选择您的行政区域';

  @override
  String get searchForAnAdministrator => '搜索行政区域';

  @override
  String get searchForACity => '搜索城市';

  @override
  String get pleaseEnableLocationService => '请启用定位服务';

  @override
  String get donateUs => '支持我们';

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
  String get jumpToAyah => '跳转到节';

  @override
  String get shareMultipleAyah => '分享多节经文';

  @override
  String get shareThisApp => '分享此应用';

  @override
  String get giveRating => '评价';

  @override
  String get bugReport => '错误报告';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get aboutTheApp => '关于应用';

  @override
  String get resetTheApp => '重置应用';

  @override
  String get resetAppWarningTitle => '重置应用数据';

  @override
  String get resetAppWarningMessage => '您确定要重置应用吗？您的所有数据都将丢失，并且需要从头开始设置应用。';

  @override
  String get cancel => '取消';

  @override
  String get reset => '重置';

  @override
  String get shareAppSubject => '快来看看这款“古兰经”应用！';

  @override
  String shareAppBody(String appLink) {
    return '色兰！快来看看这款“古兰经”应用，适合每日诵读和思考。它能帮助您与安拉的言语建立联系。下载地址：$appLink';
  }

  @override
  String get openDrawerTooltip => '打开抽屉菜单';

  @override
  String get quran => '古兰经';

  @override
  String get prayer => '礼拜';

  @override
  String get qibla => '朝向';

  @override
  String get audio => '音频';

  @override
  String get surah => '章';

  @override
  String get pages => '页';

  @override
  String get note => '笔记：';

  @override
  String get linkedAyahs => '相关经文：';

  @override
  String get emptyNoteCollection => '此笔记集为空。\n添加一些笔记以在此处查看。';

  @override
  String get emptyPinnedCollection => '此收藏夹中还没有固定的经文。\n固定一些经文以在此处查看。';

  @override
  String get noContentAvailable => '无可用内容。';

  @override
  String failedToLoadCollections(String error) {
    return '加载收藏夹失败：$error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '按$collectionType名称搜索...';
  }

  @override
  String get sortBy => '排序方式';

  @override
  String noCollectionAddedYet(String collectionType) {
    return '尚未添加任何$collectionType';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count 个已固定项目';
  }

  @override
  String notesCount(int count) {
    return '$count 条笔记';
  }

  @override
  String get emptyNameNotAllowed => '名称不能为空';

  @override
  String updatedTo(String collectionName) {
    return '已更新为 $collectionName';
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
  String get collectionNameCannotBeEmpty => '收藏夹名称不能为空。';

  @override
  String get addedNewCollection => '已添加新收藏夹';

  @override
  String ayahCount(int count) {
    return '$count 节';
  }

  @override
  String get byNameAtoZ => '名称 A-Z';

  @override
  String get byNameZtoA => '名称 Z-A';

  @override
  String get byElementNumberAscending => '元素数量升序';

  @override
  String get byElementNumberDescending => '元素数量降序';

  @override
  String get byUpdateDateAscending => '更新日期升序';

  @override
  String get byUpdateDateDescending => '更新日期降序';

  @override
  String get byCreateDateAscending => '创建日期升序';

  @override
  String get byCreateDateDescending => '创建日期降序';

  @override
  String get translationNotFound => '未找到翻译';

  @override
  String get translationTitle => '翻译：';

  @override
  String get footNoteTitle => '脚注：';

  @override
  String get wordByWordTranslation => '逐词翻译：';

  @override
  String get tafsirButton => '经注';

  @override
  String get shareButton => '分享';

  @override
  String get addNoteButton => '添加笔记';

  @override
  String get pinToCollectionButton => '固定到收藏夹';

  @override
  String get shareAsText => '以文本分享';

  @override
  String get copiedWithTafsir => '已复制（含经注）';

  @override
  String get shareAsImage => '以图片分享';

  @override
  String get shareWithTafsir => '分享（含经注）';

  @override
  String get notFound => '未找到';

  @override
  String get noteContentCannotBeEmpty => '笔记内容不能为空。';

  @override
  String get noteSavedSuccessfully => '笔记已成功保存！';

  @override
  String get selectCollections => '选择收藏夹';

  @override
  String get addNote => '添加笔记';

  @override
  String get writeCollectionName => '输入收藏夹名称...';

  @override
  String get noCollectionsYetAddANewOne => '还没有收藏夹。添加一个新的吧！';

  @override
  String get pleaseWriteYourNoteFirst => '请先写下您的笔记。';

  @override
  String get noCollectionSelected => '未选择收藏夹';

  @override
  String get saveNote => '保存笔记';

  @override
  String get nextSelectCollections => '下一步：选择收藏夹';

  @override
  String get addToPinned => '添加到已固定';

  @override
  String get pinnedSavedSuccessfully => '已成功保存到固定项！';

  @override
  String get savePinned => '保存固定项';

  @override
  String get closeAudioController => '关闭音频控制器';

  @override
  String get previous => '上一首';

  @override
  String get rewind => '快退';

  @override
  String get fastForward => '快进';

  @override
  String get playNextAyah => '播放下一节';

  @override
  String get repeat => '重复';

  @override
  String get playAsPlaylist => '作为播放列表播放';

  @override
  String style(String style) {
    return '样式：$style';
  }

  @override
  String get stopAndClose => '停止并关闭';

  @override
  String get play => '播放';

  @override
  String get pause => '暂停';

  @override
  String get selectReciter => '选择诵读者';

  @override
  String source(String source) {
    return '来源：$source';
  }

  @override
  String get newText => '新';

  @override
  String get more => '更多：';

  @override
  String get cacheNotFound => '未找到缓存';

  @override
  String get cacheSize => '缓存大小';

  @override
  String error(String error) {
    return '错误：$error';
  }

  @override
  String get clean => '清理';

  @override
  String get lastModified => '上次修改';

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
  String hoursAgo(Object hour) {
    return '$hour 小时前';
  }

  @override
  String get aboutAlQuran => '关于“古兰经”应用';

  @override
  String get appFullName => '古兰经 (经注, 礼拜, 朝向, 音频)';

  @override
  String get appDescription =>
      '一款全面的伊斯兰应用程序，适用于安卓、iOS、MacOS、网页、Linux和Windows。提供带经注和多种翻译（包括逐词翻译）的古兰经阅读、带通知的全球礼拜时间、朝向指南针，以及同步的逐词音频诵读。';

  @override
  String get dataSourcesNote =>
      '注：古兰经文本、经注、翻译和音频资源来自 Quran.com、Everyayah.com 及其他经过验证的开放源。';

  @override
  String get adFreePromise => '此应用的开发旨在寻求安拉的喜悦。因此，它现在并且永远完全无广告。';

  @override
  String get coreFeatures => '核心功能';

  @override
  String get coreFeaturesDescription => '探索使“古兰经 v3”成为您日常伊斯兰实践不可或缺的工具的关键功能：';

  @override
  String get prayerTimesTitle => '礼拜时间与提醒';

  @override
  String get prayerTimesDescription => '使用多种计算方法，为全球任何地点提供精确的礼拜时间。设置带有宣礼通知的提醒。';

  @override
  String get qiblaDirectionTitle => '朝向';

  @override
  String get qiblaDirectionDescription => '通过清晰准确的罗盘视图轻松找到朝向。';

  @override
  String get translationTafsirTitle => '古兰经翻译与经注';

  @override
  String get translationTafsirDescription =>
      '访问 69 种语言的 120 多种翻译版本（包括逐词翻译）和 30 多种经注版本。';

  @override
  String get wordByWordAudioTitle => '逐词音频与高亮';

  @override
  String get wordByWordAudioDescription => '跟随同步的逐词音频诵读和高亮，获得沉浸式学习体验。';

  @override
  String get ayahAudioRecitationTitle => '整节音频诵读';

  @override
  String get ayahAudioRecitationDescription => '聆听超过 40 位著名诵读家的完整经文诵读。';

  @override
  String get notesCloudBackupTitle => '带云备份的笔记';

  @override
  String get notesCloudBackupDescription => '保存个人笔记和感悟，安全备份到云端（功能开发中/即将推出）。';

  @override
  String get crossPlatformSupportTitle => '跨平台支持';

  @override
  String get crossPlatformSupportDescription => '支持安卓、网页、Linux 和 Windows。';

  @override
  String get backgroundAudioPlaybackTitle => '后台音频播放';

  @override
  String get backgroundAudioPlaybackDescription => '即使应用在后台运行，也能继续聆听古兰经诵读。';

  @override
  String get audioDataCachingTitle => '音频与数据缓存';

  @override
  String get audioDataCachingDescription => '通过强大的音频和古兰经数据缓存，改善播放效果和离线能力。';

  @override
  String get minimalisticInterfaceTitle => '简约清晰的界面';

  @override
  String get minimalisticInterfaceDescription => '易于导航的界面，注重用户体验和可读性。';

  @override
  String get optimizedPerformanceTitle => '优化的性能与体积';

  @override
  String get optimizedPerformanceDescription => '一款功能丰富、设计轻巧、性能卓越的应用程序。';

  @override
  String get languageSupport => '语言支持';

  @override
  String get languageSupportDescription => '本应用旨在通过支持以下语言（并持续增加更多语言）来服务全球用户：';

  @override
  String get technologyAndResources => '技术与资源';

  @override
  String get technologyAndResourcesDescription => '本应用采用尖端技术和可靠资源构建：';

  @override
  String get flutterFrameworkTitle => 'Flutter 框架';

  @override
  String get flutterFrameworkDescription =>
      '使用 Flutter 构建，通过单一代码库实现美观、原生编译的多平台体验。';

  @override
  String get advancedAudioEngineTitle => '高级音频引擎';

  @override
  String get advancedAudioEngineDescription =>
      '由 `just_audio` 和 `just_audio_background` Flutter 包提供支持，实现强大的音频播放和控制。';

  @override
  String get reliableQuranDataTitle => '可靠的古兰经数据';

  @override
  String get reliableQuranDataDescription =>
      '古兰经文本、翻译、经注和音频均来自 Quran.com 和 Everyayah.com 等经过验证的开放 API 和数据库。';

  @override
  String get prayerTimeEngineTitle => '礼拜时间引擎';

  @override
  String get prayerTimeEngineDescription =>
      '利用成熟的计算方法获取准确的礼拜时间。通知由 `flutter_local_notifications` 和后台任务处理。';

  @override
  String get crossPlatformSupport => '跨平台支持';

  @override
  String get crossPlatformSupportDescription2 => '在各种平台上享受无缝访问：';

  @override
  String get android => '安卓';

  @override
  String get ios => 'iOS';

  @override
  String get macos => 'macOS';

  @override
  String get web => '网页';

  @override
  String get linux => 'Linux';

  @override
  String get windows => 'Windows';

  @override
  String get ourLifetimePromise => '我们的终身承诺';

  @override
  String get lifetimePromiseDescription =>
      '我个人承诺，在我有生之年，将为这个应用提供持续的支持和维护， إن شاء الله (如果安拉意欲)。我的目标是确保这个应用在未来的岁月里，能一直成为穆斯林社群（乌玛）的一个有益资源。';

  @override
  String get fajr => '晨礼';

  @override
  String get sunrise => '日出';

  @override
  String get dhuhr => '晌礼';

  @override
  String get asr => '晡礼';

  @override
  String get maghrib => '昏礼';

  @override
  String get isha => '宵礼';

  @override
  String get midnight => '午夜';

  @override
  String get alarm => '闹钟';

  @override
  String get notification => '通知';

  @override
  String formattedAddress(
    Object administrativeArea,
    Object country,
    Object subAdministrativeArea,
  ) {
    return '$subAdministrativeArea，$administrativeArea，$country';
  }

  @override
  String get quranScriptTajweed => '泰吉威德';

  @override
  String get quranScriptUthmani => '奥斯曼体';

  @override
  String get quranScriptIndopak => '印度-巴基斯坦体';
}
