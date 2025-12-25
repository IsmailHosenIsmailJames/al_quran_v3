// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

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
    return '$ayahKey のタフスィールはありません';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'タフスィールはこちらにあります：$anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return '$anotherAyahLinkKey に移動';
  }

  @override
  String get hizb => 'ヒズブ';

  @override
  String get juz => 'ジュズ';

  @override
  String get page => 'ページ';

  @override
  String get ruku => 'ルクー';

  @override
  String get languageSettings => '言語設定';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count 節';
  }

  @override
  String get saveAndDownload => '保存してダウンロード';

  @override
  String get appLanguage => 'アプリの言語';

  @override
  String get selectAppLanguage => 'アプリの言語を選択...';

  @override
  String get pleaseSelectOne => '一つ選択してください';

  @override
  String get quranTranslationLanguage => 'コーラン翻訳の言語';

  @override
  String get selectTranslationLanguage => '翻訳言語を選択...';

  @override
  String get quranTranslationBook => 'コーラン翻訳書';

  @override
  String get selectTranslationBook => '翻訳書を選択...';

  @override
  String get quranTafsirLanguage => 'コーラン・タフスィールの言語';

  @override
  String get selectTafsirLanguage => 'タフスィールの言語を選択...';

  @override
  String get quranTafsirBook => 'コーラン・タフスィール書';

  @override
  String get selectTafsirBook => 'タフスィール書を選択...';

  @override
  String get quranScriptAndStyle => 'コーランの書体とスタイル';

  @override
  String get justAMoment => 'しばらくお待ちください…';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => '成功';

  @override
  String get retry => '再試行';

  @override
  String get unableToDownloadResources => 'リソースをダウンロードできませんでした…\n問題が発生しました';

  @override
  String get downloadingSegmentedQuranRecitation => 'セグメント化されたコーランの読誦をダウンロード中';

  @override
  String get processingSegmentedQuranRecitation => 'セグメント化されたコーランの読誦を処理中';

  @override
  String get footnote => '脚注';

  @override
  String get tafsir => 'タフスィール';

  @override
  String get wordByWord => '単語ごと';

  @override
  String get pleaseSelectRequiredOption => '必要なオプションを選択してください';

  @override
  String get rememberHomeTab => 'ホームタブを記憶';

  @override
  String get rememberHomeTabSubtitle => 'アプリはホーム画面で最後に開いたタブを記憶します。';

  @override
  String get wakeLock => '画面を常にオン';

  @override
  String get wakeLockSubtitle => '画面が自動的にオフになるのを防ぎます。';

  @override
  String get settings => '設定';

  @override
  String get appTheme => 'アプリのテーマ';

  @override
  String get quranStyle => 'コーランのスタイル';

  @override
  String get changeTheme => 'テーマを変更';

  @override
  String get verseCount => '節の数: ';

  @override
  String get translation => '翻訳';

  @override
  String get tafsirNotFound => '見つかりません';

  @override
  String get moreInfo => '詳細情報';

  @override
  String get playAudio => '音声を再生';

  @override
  String get preview => 'プレビュー';

  @override
  String get loading => '読み込み中…';

  @override
  String get errorFetchingAddress => '住所の取得中にエラーが発生しました';

  @override
  String get addressNotAvailable => '住所が利用できません';

  @override
  String get latitude => '緯度: ';

  @override
  String get longitude => '経度: ';

  @override
  String get name => '名前: ';

  @override
  String get location => '場所: ';

  @override
  String get parameters => 'パラメータ: ';

  @override
  String get selectCalculationMethod => '計算方法を選択';

  @override
  String get shareSelectAyahs => '選択した節を共有';

  @override
  String get selectionEmpty => '何も選択されていません';

  @override
  String get generatingImagePleaseWait => '画像を生成中… お待ちください';

  @override
  String get asImage => '画像として';

  @override
  String get asText => 'テキストとして';

  @override
  String get playFromSelectedAyah => '選択した節から再生';

  @override
  String get toTafsir => 'タフスィールへ';

  @override
  String get selectAyah => '節を選択';

  @override
  String get toAyah => '節へ';

  @override
  String get searchForASurah => 'スーラを検索';

  @override
  String get bugReportTitle => 'バグ報告';

  @override
  String get audioCached => 'オーディオはキャッシュされました';

  @override
  String get others => 'その他';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'コーラン｜翻訳｜節のいずれか一つを有効にする必要があります';

  @override
  String get quranFontSize => 'コーランのフォントサイズ';

  @override
  String get quranLineHeight => 'コーランの行の高さ';

  @override
  String get translationAndTafsirFontSize => '翻訳とタフスィールのフォントサイズ';

  @override
  String get quranAyah => 'コーランの節';

  @override
  String get topToolbar => '上部ツールバー';

  @override
  String get keepOpenWordByWord => '単語ごとの表示を開いたままにする';

  @override
  String get wordByWordHighlight => '単語ごとのハイライト';

  @override
  String get quranScriptSettings => 'コーラン書体の設定';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'ページ: ';

  @override
  String get quranResources => 'コーランのリソース';

  @override
  String alreadySelected(String name) {
    return '言語「$name」はすでに選択されています。';
  }

  @override
  String get unableToGetCompassData => 'コンパスのデータを取得できません';

  @override
  String get deviceDoesNotHaveSensors => 'このデバイスにはセンサーがありません！';

  @override
  String get north => '北';

  @override
  String get east => '東';

  @override
  String get south => '南';

  @override
  String get west => '西';

  @override
  String get address => '住所: ';

  @override
  String get change => '変更';

  @override
  String get calculationMethod => '計算方法: ';

  @override
  String get downloadPrayerTime => '礼拝時間をダウンロード';

  @override
  String get calculationMethodsListEmpty => '計算方法のリストは空です。';

  @override
  String get noCalculationMethodWithLocationData =>
      '位置情報データを持つ計算方法が見つかりませんでした。';

  @override
  String get prayerSettings => '礼拝設定';

  @override
  String get reminderSettings => 'リマインダー設定';

  @override
  String get adjustReminderTime => 'リマインダー時間を調整';

  @override
  String get enforceAlarmSound => 'アラーム音を強制';

  @override
  String get enforceAlarmSoundDescription =>
      '有効にすると、携帯電話の音量が低くても、ここで設定した音量でアラームが再生されます。これにより、携帯電話の音量が低いためにアラームを逃すことがなくなります。';

  @override
  String get volume => '音量';

  @override
  String get atPrayerTime => '礼拝の時間に';

  @override
  String minBefore(int minutes) {
    return '$minutes 分前';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes 分後';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerNameは $prayerTime です';
  }

  @override
  String itsTimeOf(String prayerName) {
    return '$prayerNameの時間です';
  }

  @override
  String get stopTheAdhan => 'アザーンを停止';

  @override
  String dateFoundEmpty(String date) {
    return '$date は見つかりませんでした';
  }

  @override
  String get today => '今日';

  @override
  String get left => '残り';

  @override
  String reminderAdded(String prayerName) {
    return '$prayerNameのリマインダーが追加されました';
  }

  @override
  String get allowNotificationPermission => 'この機能を使用するには、通知の許可をお願いします';

  @override
  String reminderRemoved(String prayerName) {
    return '$prayerNameのリマインダーが削除されました';
  }

  @override
  String get getPrayerTimesAndQibla => '礼拝時間とキブラを取得';

  @override
  String get getPrayerTimesAndQiblaDescription => '任意の場所の礼拝時間とキブラを計算します。';

  @override
  String get getFromGPS => 'GPSから取得';

  @override
  String get or => 'または';

  @override
  String get selectYourCity => '都市を選択';

  @override
  String get noteAboutGPS => '注：GPSを使用したくない、または安全でないと感じる場合は、都市を選択できます。';

  @override
  String get downloadingLocationResources => '位置情報リソースをダウンロード中…';

  @override
  String get somethingWentWrong => '問題が発生しました';

  @override
  String get selectYourCountry => '国を選択';

  @override
  String get searchForACountry => '国を検索';

  @override
  String get selectYourAdministrator => '行政区画を選択';

  @override
  String get searchForAnAdministrator => '行政区画を検索';

  @override
  String get searchForACity => '都市を検索';

  @override
  String get pleaseEnableLocationService => '位置情報サービスを有効にしてください';

  @override
  String get donateUs => '寄付する';

  @override
  String get underDevelopment => '開発中';

  @override
  String get versionLoading => '読み込み中…';

  @override
  String get alQuran => 'アル・コーラン';

  @override
  String get mainMenu => 'メインメニュー';

  @override
  String get notes => 'ノート';

  @override
  String get pinned => 'ピン留め済み';

  @override
  String get jumpToAyah => '節へ移動';

  @override
  String get shareMultipleAyah => '複数の節を共有';

  @override
  String get shareThisApp => 'このアプリを共有';

  @override
  String get giveRating => '評価する';

  @override
  String get bugReport => 'バグ報告';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get aboutTheApp => 'アプリについて';

  @override
  String get resetTheApp => 'アプリをリセット';

  @override
  String get resetAppWarningTitle => 'アプリデータをリセット';

  @override
  String get resetAppWarningMessage =>
      'アプリをリセットしてもよろしいですか？すべてのデータが失われ、最初からアプリをセットアップする必要があります。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get reset => 'リセット';

  @override
  String get shareAppSubject => 'このアル・コーランアプリをチェック！';

  @override
  String shareAppBody(String appLink) {
    return 'アッサラーム・アライクム！日々の読誦と思索のために、このアル・コーランアプリをチェックしてみてください。アッラーの御言葉との繋がりを助けます。ダウンロードはこちら：$appLink';
  }

  @override
  String get openDrawerTooltip => 'メニューを開く';

  @override
  String get quran => 'コーラン';

  @override
  String get prayer => '礼拝';

  @override
  String get qibla => 'キブラ';

  @override
  String get audio => 'オーディオ';

  @override
  String get surah => 'スーラ';

  @override
  String get pages => 'ページ';

  @override
  String get note => '注：';

  @override
  String get linkedAyahs => '関連する節：';

  @override
  String get emptyNoteCollection => 'このノートコレクションは空です。\nノートを追加してここに表示しましょう。';

  @override
  String get emptyPinnedCollection =>
      'このコレクションにはまだピン留めされた節がありません。\n節をピン留めしてここに表示しましょう。';

  @override
  String get noContentAvailable => '利用可能なコンテンツがありません。';

  @override
  String failedToLoadCollections(String error) {
    return 'コレクションの読み込みに失敗しました：$error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return '$collectionType名で検索…';
  }

  @override
  String get sortBy => '並べ替え';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'まだ$collectionTypeが追加されていません';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count 件のピン留め済みアイテム';
  }

  @override
  String notesCount(int count) {
    return '$count 件のノート';
  }

  @override
  String get emptyNameNotAllowed => '名前を空にすることはできません';

  @override
  String updatedTo(String collectionName) {
    return '$collectionName に更新しました';
  }

  @override
  String get changeName => '名前を変更';

  @override
  String get changeColor => '色を変更';

  @override
  String get colorUpdated => '色を更新しました';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName を削除しました';
  }

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get collectionNameCannotBeEmpty => 'コレクション名は空にできません。';

  @override
  String get addedNewCollection => '新しいコレクションを追加しました';

  @override
  String ayahCount(int count) {
    return '$count 節';
  }

  @override
  String get byNameAtoZ => '名前 昇順';

  @override
  String get byNameZtoA => '名前 降順';

  @override
  String get byElementNumberAscending => '要素数 昇順';

  @override
  String get byElementNumberDescending => '要素数 降順';

  @override
  String get byUpdateDateAscending => '更新日 昇順';

  @override
  String get byUpdateDateDescending => '更新日 降順';

  @override
  String get byCreateDateAscending => '作成日 昇順';

  @override
  String get byCreateDateDescending => '作成日 降順';

  @override
  String get translationNotFound => '翻訳が見つかりません';

  @override
  String get translationTitle => '翻訳：';

  @override
  String get footNoteTitle => '脚注：';

  @override
  String get wordByWordTranslation => '単語ごとの翻訳：';

  @override
  String get tafsirButton => 'タフスィール';

  @override
  String get shareButton => '共有';

  @override
  String get addNoteButton => 'ノートを追加';

  @override
  String get pinToCollectionButton => 'コレクションにピン留め';

  @override
  String get shareAsText => 'テキストとして共有';

  @override
  String get copiedWithTafsir => 'タフスィール付きでコピーしました';

  @override
  String get shareAsImage => '画像として共有';

  @override
  String get shareWithTafsir => 'タフスィール付きで共有';

  @override
  String get notFound => '見つかりません';

  @override
  String get noteContentCannotBeEmpty => 'ノートの内容は空にできません。';

  @override
  String get noteSavedSuccessfully => 'ノートが正常に保存されました！';

  @override
  String get selectCollections => 'コレクションを選択';

  @override
  String get addNote => 'ノートを追加';

  @override
  String get writeCollectionName => 'コレクション名を入力...';

  @override
  String get noCollectionsYetAddANewOne => 'まだコレクションがありません。新しく追加しましょう！';

  @override
  String get pleaseWriteYourNoteFirst => '最初にノートを書いてください。';

  @override
  String get noCollectionSelected => 'コレクションが選択されていません';

  @override
  String get saveNote => 'ノートを保存';

  @override
  String get nextSelectCollections => '次へ：コレクションを選択';

  @override
  String get addToPinned => 'ピン留めに追加';

  @override
  String get pinnedSavedSuccessfully => 'ピン留めが正常に保存されました！';

  @override
  String get savePinned => 'ピン留めを保存';

  @override
  String get closeAudioController => 'オーディオコントローラーを閉じる';

  @override
  String get previous => '前へ';

  @override
  String get rewind => '巻き戻し';

  @override
  String get fastForward => '早送り';

  @override
  String get playNextAyah => '次の節を再生';

  @override
  String get repeat => 'リピート';

  @override
  String get playAsPlaylist => 'プレイリストとして再生';

  @override
  String style(String style) {
    return 'スタイル: $style';
  }

  @override
  String get stopAndClose => '停止して閉じる';

  @override
  String get play => '再生';

  @override
  String get pause => '一時停止';

  @override
  String get selectReciter => '読誦者を選択';

  @override
  String source(String source) {
    return '出典: $source';
  }

  @override
  String get newText => '新規';

  @override
  String get more => '詳細: ';

  @override
  String get cacheNotFound => 'キャッシュが見つかりません';

  @override
  String get cacheSize => 'キャッシュサイズ';

  @override
  String error(String error) {
    return 'エラー: $error';
  }

  @override
  String get clean => 'クリーン';

  @override
  String get lastModified => '最終更新日時';

  @override
  String get oneYearAgo => '1年前';

  @override
  String monthsAgo(String number) {
    return '$numberヶ月前';
  }

  @override
  String weeksAgo(String number) {
    return '$number週間前';
  }

  @override
  String daysAgo(String number) {
    return '$number日前';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour時間前';
  }

  @override
  String get aboutAlQuran => 'アル・コーランについて';

  @override
  String get appFullName => 'アル・コーラン（タフスィール、礼拝、キブラ、オーディオ）';

  @override
  String get appDescription =>
      'Android、iOS、MacOS、Web、Linux、Windows向けの総合的なイスラムアプリケーション。タフスィールと複数の翻訳（単語ごとの翻訳を含む）付きのコーラン読誦、通知機能付きの世界中の礼拝時間、キブラコンパス、そして同期された単語ごとのオーディオ読誦を提供します。';

  @override
  String get dataSourcesNote =>
      '注：コーランのテキスト、タフスィール、翻訳、オーディオリソースは、Quran.com、Everyayah.com、およびその他の検証済みのオープンソースから提供されています。';

  @override
  String get adFreePromise =>
      'このアプリはアッラーの御心に適うことを願って作成されました。そのため、現在も将来も完全に広告なしです。';

  @override
  String get coreFeatures => '主な機能';

  @override
  String get coreFeaturesDescription =>
      'アル・コーラン v3 を日々のイスラム実践に不可欠なツールにする主要な機能をご覧ください：';

  @override
  String get prayerTimesTitle => '礼拝時間とアラート';

  @override
  String get prayerTimesDescription =>
      '様々な計算方法を用いて、世界中のあらゆる場所の正確な礼拝時間を提供します。アザーン通知付きのリマインダーを設定できます。';

  @override
  String get qiblaDirectionTitle => 'キブラの方向';

  @override
  String get qiblaDirectionDescription => '明確で正確なコンパス表示で、キブラの方向を簡単に見つけられます。';

  @override
  String get translationTafsirTitle => 'コーランの翻訳とタフスィール';

  @override
  String get translationTafsirDescription =>
      '69言語にわたる120以上の翻訳書（単語ごとの翻訳を含む）と、30以上のタフスィール書にアクセスできます。';

  @override
  String get wordByWordAudioTitle => '単語ごとのオーディオとハイライト';

  @override
  String get wordByWordAudioDescription =>
      '同期された単語ごとのオーディオ読誦とハイライトに従って、没入感のある学習体験ができます。';

  @override
  String get ayahAudioRecitationTitle => '節ごとのオーディオ読誦';

  @override
  String get ayahAudioRecitationDescription =>
      '40人以上の著名な読誦者による完全な節の読誦を聴くことができます。';

  @override
  String get notesCloudBackupTitle => 'クラウドバックアップ付きノート';

  @override
  String get notesCloudBackupDescription =>
      '個人のノートや考察を保存し、クラウドに安全にバックアップします（機能は開発中/近日公開予定）。';

  @override
  String get crossPlatformSupportTitle => 'クロスプラットフォーム対応';

  @override
  String get crossPlatformSupportDescription =>
      'Android、Web、Linux、Windowsでサポートされています。';

  @override
  String get backgroundAudioPlaybackTitle => 'バックグラウンドでのオーディオ再生';

  @override
  String get backgroundAudioPlaybackDescription =>
      'アプリがバックグラウンドにあるときでも、コーランの読誦を聴き続けることができます。';

  @override
  String get audioDataCachingTitle => 'オーディオとデータのキャッシング';

  @override
  String get audioDataCachingDescription =>
      '堅牢なオーディオとコーランデータのキャッシングにより、再生機能とオフライン機能が向上しました。';

  @override
  String get minimalisticInterfaceTitle => 'ミニマルでクリーンなインターフェース';

  @override
  String get minimalisticInterfaceDescription =>
      'ユーザーエクスペリエンスと読みやすさに重点を置いた、ナビゲートしやすいインターフェース。';

  @override
  String get optimizedPerformanceTitle => '最適化されたパフォーマンスとサイズ';

  @override
  String get optimizedPerformanceDescription => '軽量で高性能に設計された、機能豊富なアプリケーション。';

  @override
  String get languageSupport => '言語サポート';

  @override
  String get languageSupportDescription =>
      'このアプリケーションは、以下の言語をサポートすることで、世界中のユーザーが利用できるように設計されています（さらに継続的に追加されています）：';

  @override
  String get technologyAndResources => '技術とリソース';

  @override
  String get technologyAndResourcesDescription =>
      'このアプリは、最先端の技術と信頼性の高いリソースを使用して構築されています：';

  @override
  String get flutterFrameworkTitle => 'Flutter フレームワーク';

  @override
  String get flutterFrameworkDescription =>
      '単一のコードベースから美しく、ネイティブにコンパイルされたマルチプラットフォーム体験を実現するためにFlutterで構築されています。';

  @override
  String get advancedAudioEngineTitle => '高度なオーディオエンジン';

  @override
  String get advancedAudioEngineDescription =>
      '堅牢なオーディオ再生と制御のために、Flutterパッケージ「just_audio」と「just_audio_background」を搭載しています。';

  @override
  String get reliableQuranDataTitle => '信頼性の高いコーランデータ';

  @override
  String get reliableQuranDataDescription =>
      'アル・コーランのテキスト、翻訳、タフスィール、オーディオは、Quran.comやEveryayah.comのような検証済みのオープンAPIやデータベースから提供されています。';

  @override
  String get prayerTimeEngineTitle => '礼拝時間エンジン';

  @override
  String get prayerTimeEngineDescription =>
      '確立された計算方法を利用して、正確な礼拝時間を算出します。通知は「flutter_local_notifications」とバックグラウンドタスクによって処理されます。';

  @override
  String get crossPlatformSupport => 'クロスプラットフォーム対応';

  @override
  String get crossPlatformSupportDescription2 =>
      'さまざまなプラットフォームでシームレスなアクセスをお楽しみください：';

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
  String get ourLifetimePromise => '私たちの生涯の約束';

  @override
  String get lifetimePromiseDescription =>
      '私個人として、生涯にわたり、イン・シャー・アッラー、このアプリケーションの継続的なサポートとメンテナンスを提供することをお約束します。私の目標は、このアプリが今後何年にもわたってウンマ（イスラム共同体）にとって有益なリソースであり続けることを保証することです。';

  @override
  String get fajr => 'ファジル';

  @override
  String get sunrise => '日の出';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'ズフル';

  @override
  String get asr => 'アスル';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'マグリブ';

  @override
  String get isha => 'イシャー';

  @override
  String get midnight => '真夜中';

  @override
  String get alarm => 'アラーム';

  @override
  String get notification => '通知';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$country、$administrativeArea、$subAdministrativeArea';
  }

  @override
  String get quranScriptTajweed => 'タジュウィード';

  @override
  String get quranScriptUthmani => 'ウスマーン体';

  @override
  String get quranScriptIndopak => 'インドパク体';

  @override
  String get sajdaAyah => 'サジダの節';

  @override
  String get required => '必須';

  @override
  String get optional => '任意';

  @override
  String get notificationScheduleWarning =>
      '注意：スマートフォンのOSのバックグラウンドプロセス制限により、スケジュールされた通知やリマインダーが見逃される可能性があります。例：VivoのOrigin OS、SamsungのOne UI、OppoのColorOSなどは、スケジュールされた通知やリマインダーを強制終了することがあります。アプリがバックグラウンドプロセスから制限されないように、OSの設定を確認してください。';

  @override
  String get scrollWithRecitation => '朗読でスクロール';

  @override
  String get quickAccess => 'クイックアクセス';

  @override
  String get initiallyScrollAyah => '最初にアヤにスクロールします';

  @override
  String get tajweedGuide => 'タジュウィードガイド';

  @override
  String get scrollWithRecitationDesc =>
      '有効にすると、コーランのアヤは音声の朗読と同期して自動的にスクロールします。';

  @override
  String get configuration => '構成';

  @override
  String get restoreFromBackup => 'バックアップから復元';

  @override
  String get history => '歴史';

  @override
  String get search => '検索';

  @override
  String get useAudioStream => 'オーディオストリームを使用する';

  @override
  String get useAudioStreamDesc => 'ダウンロードする代わりに、インターネットから直接オーディオをストリーミングします。';

  @override
  String get notUseAudioStreamDesc =>
      'オフラインで使用するためにオーディオをダウンロードし、データ消費量を削減します。';

  @override
  String get audioSettings => 'オーディオ設定';

  @override
  String get playbackSpeed => '再生速度';

  @override
  String get playbackSpeedDesc => 'コーランの朗読の速度を調整します。';

  @override
  String get waitForCurrentDownloadToFinish => '現在のダウンロードが完了するまでお待ちください。';

  @override
  String get areYouSure => '本気ですか？';

  @override
  String get checkYourInternetConnection => 'インターネット接続を確認してください。';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return '$totalVersesCountアーヤのうち$requiredDownloadをダウンロードする必要があります。';
  }

  @override
  String get download => 'ダウンロード';

  @override
  String get audioDownload => 'オーディオのダウンロード';

  @override
  String get am => '午前';

  @override
  String get pm => '午後';

  @override
  String get optimizingQuranScript => 'コーランのスクリプトを最適化しています';

  @override
  String get supportOnGithub => 'GitHubでサポート';

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
