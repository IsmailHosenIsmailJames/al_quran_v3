// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
    return 'Тафсир недоступен для $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Тафсир можно найти в: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Перейти к $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Хизб';

  @override
  String get juz => 'Джуз';

  @override
  String get page => 'Страница';

  @override
  String get ruku => 'Руку';

  @override
  String get languageSettings => 'Настройки языка';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count аятов';
  }

  @override
  String get saveAndDownload => 'Сохранить и скачать';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get selectAppLanguage => 'Выберите язык приложения...';

  @override
  String get pleaseSelectOne => 'Пожалуйста, выберите один';

  @override
  String get quranTranslationLanguage => 'Язык перевода Корана';

  @override
  String get selectTranslationLanguage => 'Выберите язык перевода...';

  @override
  String get quranTranslationBook => 'Книга перевода Корана';

  @override
  String get selectTranslationBook => 'Выберите книгу перевода...';

  @override
  String get quranTafsirLanguage => 'Язык тафсира Корана';

  @override
  String get selectTafsirLanguage => 'Выберите язык тафсира...';

  @override
  String get quranTafsirBook => 'Книга тафсира Корана';

  @override
  String get selectTafsirBook => 'Выберите книгу тафсира...';

  @override
  String get quranScriptAndStyle => 'Стиль и шрифт Корана';

  @override
  String get justAMoment => 'Подождите немного...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Успех';

  @override
  String get retry => 'Повторить';

  @override
  String get unableToDownloadResources =>
      'Не удалось скачать ресурсы...\nЧто-то пошло не так';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Скачивание сегментированного чтения Корана';

  @override
  String get processingSegmentedQuranRecitation =>
      'Обработка сегментированного чтения Корана';

  @override
  String get footnote => 'Сноска';

  @override
  String get tafsir => 'Тафсир';

  @override
  String get wordByWord => 'Слово за словом';

  @override
  String get pleaseSelectRequiredOption =>
      'Пожалуйста, выберите необходимый вариант';

  @override
  String get rememberHomeTab => 'Запоминать вкладку на главном экране';

  @override
  String get rememberHomeTabSubtitle =>
      'Приложение запомнит последнюю открытую вкладку на главном экране.';

  @override
  String get wakeLock => 'Блокировка выключения экрана';

  @override
  String get wakeLockSubtitle =>
      'Предотвращает автоматическое выключение экрана.';

  @override
  String get settings => 'Настройки';

  @override
  String get appTheme => 'Тема приложения';

  @override
  String get quranStyle => 'Стиль Корана';

  @override
  String get changeTheme => 'Изменить тему';

  @override
  String get verseCount => 'Количество аятов: ';

  @override
  String get translation => 'Перевод';

  @override
  String get tafsirNotFound => 'Не найдено';

  @override
  String get moreInfo => 'больше информации';

  @override
  String get playAudio => 'Воспроизвести аудио';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get loading => 'Загрузка...';

  @override
  String get errorFetchingAddress => 'Ошибка получения адреса';

  @override
  String get addressNotAvailable => 'Адрес недоступен';

  @override
  String get latitude => 'Широта: ';

  @override
  String get longitude => 'Долгота: ';

  @override
  String get name => 'Имя: ';

  @override
  String get location => 'Местоположение: ';

  @override
  String get parameters => 'Параметры: ';

  @override
  String get selectCalculationMethod => 'Выберите метод расчета';

  @override
  String get shareSelectAyahs => 'Поделиться выбранными аятами';

  @override
  String get selectionEmpty => 'Выбор пуст';

  @override
  String get generatingImagePleaseWait => 'Генерация изображения... Подождите';

  @override
  String get asImage => 'Как изображение';

  @override
  String get asText => 'Как текст';

  @override
  String get playFromSelectedAyah => 'Воспроизвести с выбранного аята';

  @override
  String get toTafsir => 'К тафсиру';

  @override
  String get selectAyah => 'Выберите аят';

  @override
  String get toAyah => 'К аяту';

  @override
  String get searchForASurah => 'Поиск суры';

  @override
  String get bugReportTitle => 'Отчет об ошибке';

  @override
  String get audioCached => 'Аудио в кэше';

  @override
  String get others => 'Другие';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Коран|Перевод|Аят, один должен быть включен';

  @override
  String get quranFontSize => 'Размер шрифта Корана';

  @override
  String get quranLineHeight => 'Высота строки Корана';

  @override
  String get translationAndTafsirFontSize => 'Размер шрифта перевода и тафсира';

  @override
  String get quranAyah => 'Аят Корана';

  @override
  String get topToolbar => 'Верхняя панель инструментов';

  @override
  String get keepOpenWordByWord => 'Оставить открытым слово за словом';

  @override
  String get wordByWordHighlight => 'Подсветка слово за словом';

  @override
  String get quranScriptSettings => 'Настройки шрифта Корана';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Страница: ';

  @override
  String get quranResources => 'Ресурсы Корана';

  @override
  String alreadySelected(String name) {
    return 'Язык \'$name\' уже выбран.';
  }

  @override
  String get unableToGetCompassData => 'Не удалось получить данные компаса';

  @override
  String get deviceDoesNotHaveSensors => 'Устройство не имеет датчиков!';

  @override
  String get north => 'С';

  @override
  String get east => 'В';

  @override
  String get south => 'Ю';

  @override
  String get west => 'З';

  @override
  String get address => 'Адрес: ';

  @override
  String get change => 'Изменить';

  @override
  String get calculationMethod => 'Метод расчета: ';

  @override
  String get downloadPrayerTime => 'Скачать время намаза';

  @override
  String get calculationMethodsListEmpty => 'Список методов расчета пуст.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Не удалось найти метод расчета с данными о местоположении.';

  @override
  String get prayerSettings => 'Настройки намаза';

  @override
  String get reminderSettings => 'Настройки напоминаний';

  @override
  String get adjustReminderTime => 'Настроить время напоминания';

  @override
  String get enforceAlarmSound => 'Принудительный звук будильника';

  @override
  String get enforceAlarmSoundDescription =>
      'Если включено, эта функция воспроизведет будильник на установленной здесь громкости, даже если звук телефона низкий. Это гарантирует, что вы не пропустите будильник из-за низкой громкости.';

  @override
  String get volume => 'Громкость';

  @override
  String get atPrayerTime => 'В время намаза';

  @override
  String minBefore(int minutes) {
    return '$minutes мин до';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes мин после';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName в $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Время $prayerName';
  }

  @override
  String get stopTheAdhan => 'Остановить азан';

  @override
  String dateFoundEmpty(String date) {
    return '$date Пусто';
  }

  @override
  String get today => 'Сегодня';

  @override
  String get left => 'Осталось';

  @override
  String reminderAdded(String prayerName) {
    return 'Напоминание для $prayerName добавлено';
  }

  @override
  String get allowNotificationPermission =>
      'Пожалуйста, разрешите уведомления для использования этой функции';

  @override
  String reminderRemoved(String prayerName) {
    return 'Напоминание для $prayerName удалено';
  }

  @override
  String get getPrayerTimesAndQibla => 'Получить время намаза и киблу';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Рассчитать время намаза и киблу для любого местоположения.';

  @override
  String get getFromGPS => 'Получить из GPS';

  @override
  String get or => 'Или';

  @override
  String get selectYourCity => 'Выберите свой город';

  @override
  String get noteAboutGPS =>
      'Примечание: Если вы не хотите использовать GPS или не чувствуете себя в безопасности, вы можете выбрать свой город.';

  @override
  String get downloadingLocationResources =>
      'Скачивание ресурсов местоположения...';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get selectYourCountry => 'Выберите свою страну';

  @override
  String get searchForACountry => 'Поиск страны';

  @override
  String get selectYourAdministrator => 'Выберите администратора';

  @override
  String get searchForAnAdministrator => 'Поиск администратора';

  @override
  String get searchForACity => 'Поиск города';

  @override
  String get pleaseEnableLocationService =>
      'Пожалуйста, включите службу геолокации';

  @override
  String get donateUs => 'Пожертвуйте нам';

  @override
  String get underDevelopment => 'В разработке';

  @override
  String get versionLoading => 'Загрузка...';

  @override
  String get alQuran => 'Аль-Коран';

  @override
  String get mainMenu => 'Главное меню';

  @override
  String get notes => 'Заметки';

  @override
  String get pinned => 'Закрепленные';

  @override
  String get jumpToAyah => 'Перейти к аяту';

  @override
  String get shareMultipleAyah => 'Поделиться несколькими аятами';

  @override
  String get shareThisApp => 'Поделиться приложением';

  @override
  String get giveRating => 'Оценить';

  @override
  String get bugReport => 'Отчет об ошибке';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get aboutTheApp => 'О приложении';

  @override
  String get resetTheApp => 'Сбросить приложение';

  @override
  String get resetAppWarningTitle => 'Сброс данных приложения';

  @override
  String get resetAppWarningMessage =>
      'Вы уверены, что хотите сбросить приложение? Все ваши данные будут потеряны, и вам придется настроить приложение заново.';

  @override
  String get cancel => 'Отмена';

  @override
  String get reset => 'Сброс';

  @override
  String get shareAppSubject => 'Посмотрите это приложение Аль-Коран!';

  @override
  String shareAppBody(String appLink) {
    return 'Ассаламу алейкум! Посмотрите это приложение Аль-Коран для ежедневного чтения и размышлений. Оно помогает связаться со словами Аллаха. Скачайте здесь: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Открыть меню';

  @override
  String get quran => 'Коран';

  @override
  String get prayer => 'Намаз';

  @override
  String get qibla => 'Кибла';

  @override
  String get audio => 'Аудио';

  @override
  String get surah => 'Сура';

  @override
  String get pages => 'Страницы';

  @override
  String get note => 'Заметка:';

  @override
  String get linkedAyahs => 'Связанные аяты:';

  @override
  String get emptyNoteCollection =>
      'Эта коллекция заметок пуста.\nДобавьте заметки, чтобы увидеть их здесь.';

  @override
  String get emptyPinnedCollection =>
      'Нет закрепленных аятов в этой коллекции.\nЗакрепите аяты, чтобы увидеть их здесь.';

  @override
  String get noContentAvailable => 'Нет доступного содержимого.';

  @override
  String failedToLoadCollections(String error) {
    return 'Не удалось загрузить коллекции: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Поиск по имени $collectionType...';
  }

  @override
  String get sortBy => 'Сортировать по';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Нет добавленных $collectionType пока';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count закрепленных элементов';
  }

  @override
  String notesCount(int count) {
    return '$count заметок';
  }

  @override
  String get emptyNameNotAllowed => 'Пустое имя не разрешено';

  @override
  String updatedTo(String collectionName) {
    return 'Обновлено до $collectionName';
  }

  @override
  String get changeName => 'Изменить имя';

  @override
  String get changeColor => 'Изменить цвет';

  @override
  String get colorUpdated => 'Цвет обновлен';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Удалено';
  }

  @override
  String get delete => 'Удалить';

  @override
  String get save => 'Сохранить';

  @override
  String get collectionNameCannotBeEmpty =>
      'Имя коллекции не может быть пустым.';

  @override
  String get addedNewCollection => 'Добавлена новая коллекция';

  @override
  String ayahCount(int count) {
    return '$count аят';
  }

  @override
  String get byNameAtoZ => 'Имя A-Я';

  @override
  String get byNameZtoA => 'Имя Я-A';

  @override
  String get byElementNumberAscending => 'Номер элемента по возрастанию';

  @override
  String get byElementNumberDescending => 'Номер элемента по убыванию';

  @override
  String get byUpdateDateAscending => 'Дата обновления по возрастанию';

  @override
  String get byUpdateDateDescending => 'Дата обновления по убыванию';

  @override
  String get byCreateDateAscending => 'Дата создания по возрастанию';

  @override
  String get byCreateDateDescending => 'Дата создания по убыванию';

  @override
  String get translationNotFound => 'Перевод не найден';

  @override
  String get translationTitle => 'Перевод:';

  @override
  String get footNoteTitle => 'Сноска:';

  @override
  String get wordByWordTranslation => 'Перевод слово за словом:';

  @override
  String get tafsirButton => 'Тафсир';

  @override
  String get shareButton => 'Поделиться';

  @override
  String get addNoteButton => 'Добавить заметку';

  @override
  String get pinToCollectionButton => 'Закрепить в коллекции';

  @override
  String get shareAsText => 'Поделиться как текст';

  @override
  String get copiedWithTafsir => 'Скопировано с тафсиром';

  @override
  String get shareAsImage => 'Поделиться как изображение';

  @override
  String get shareWithTafsir => 'Поделиться с тафсиром';

  @override
  String get notFound => 'Не найдено';

  @override
  String get noteContentCannotBeEmpty =>
      'Содержимое заметки не может быть пустым.';

  @override
  String get noteSavedSuccessfully => 'Заметка сохранена успешно!';

  @override
  String get selectCollections => 'Выберите коллекции';

  @override
  String get addNote => 'Добавить заметку';

  @override
  String get writeCollectionName => 'Напишите имя коллекции...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Нет коллекций пока. Добавьте новую!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Пожалуйста, сначала напишите заметку.';

  @override
  String get noCollectionSelected => 'Коллекция не выбрана';

  @override
  String get saveNote => 'Сохранить заметку';

  @override
  String get nextSelectCollections => 'Далее: Выберите коллекции';

  @override
  String get addToPinned => 'Добавить в закрепленные';

  @override
  String get pinnedSavedSuccessfully => 'Закрепленное сохранено успешно!';

  @override
  String get savePinned => 'Сохранить закрепленное';

  @override
  String get closeAudioController => 'Закрыть контроллер аудио';

  @override
  String get previous => 'Предыдущий';

  @override
  String get rewind => 'Перемотать назад';

  @override
  String get fastForward => 'Перемотать вперед';

  @override
  String get playNextAyah => 'Воспроизвести следующий аят';

  @override
  String get repeat => 'Повтор';

  @override
  String get playAsPlaylist => 'Воспроизвести как плейлист';

  @override
  String style(String style) {
    return 'Стиль: $style';
  }

  @override
  String get stopAndClose => 'Остановить и закрыть';

  @override
  String get play => 'Воспроизвести';

  @override
  String get pause => 'Пауза';

  @override
  String get selectReciter => 'Выберите чтеца';

  @override
  String source(String source) {
    return 'Источник: $source';
  }

  @override
  String get newText => 'Новое';

  @override
  String get more => 'Больше: ';

  @override
  String get cacheNotFound => 'Кэш не найден';

  @override
  String get cacheSize => 'Размер кэша';

  @override
  String error(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get clean => 'Очистить';

  @override
  String get lastModified => 'Последнее изменение';

  @override
  String get oneYearAgo => '1 год назад';

  @override
  String monthsAgo(String number) {
    return '$number месяцев назад';
  }

  @override
  String weeksAgo(String number) {
    return '$number недель назад';
  }

  @override
  String daysAgo(String number) {
    return '$number дней назад';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour часов назад';
  }

  @override
  String get aboutAlQuran => 'О Аль-Коране';

  @override
  String get appFullName => 'Аль-Коран (Тафсир, Намаз, Кибла, Аудио)';

  @override
  String get appDescription =>
      'Комплексное исламское приложение для Android, iOS, MacOS, Web, Linux и Windows, предлагающее чтение Корана с тафсиром и несколькими переводами (включая слово за словом), время намаза по всему миру с уведомлениями, компас киблы и синхронизированное чтение слово за словом.';

  @override
  String get dataSourcesNote =>
      'Примечание: Тексты Корана, тафсир, переводы и аудиоресурсы взяты из Quran.com, Everyayah.com и других проверенных открытых источников.';

  @override
  String get adFreePromise =>
      'Это приложение создано для поиска довольства Аллаха. Поэтому оно всегда будет полностью без рекламы.';

  @override
  String get coreFeatures => 'Основные функции';

  @override
  String get coreFeaturesDescription =>
      'Изучите ключевые функции, которые делают Аль-Коран v3 незаменимым инструментом для ваших ежедневных исламских практик:';

  @override
  String get prayerTimesTitle => 'Время намаза и оповещения';

  @override
  String get prayerTimesDescription =>
      'Точные времена намаза для любого местоположения по всему миру с использованием различных методов расчета. Установите напоминания с уведомлениями азана.';

  @override
  String get qiblaDirectionTitle => 'Направление киблы';

  @override
  String get qiblaDirectionDescription =>
      'Легко найдите направление киблы с четким и точным видом компаса.';

  @override
  String get translationTafsirTitle => 'Перевод и тафсир Корана';

  @override
  String get translationTafsirDescription =>
      'Доступ к более 120 книгам переводов (включая слово за словом) на 69 языках и более 30 книгам тафсира.';

  @override
  String get wordByWordAudioTitle => 'Аудио слово за словом и подсветка';

  @override
  String get wordByWordAudioDescription =>
      'Следите за синхронизированным аудио чтением слово за словом и подсветкой для immersive опыта обучения.';

  @override
  String get ayahAudioRecitationTitle => 'Аудио чтение аятов';

  @override
  String get ayahAudioRecitationDescription =>
      'Слушайте полные чтения аятов от более 40 известных чтецов.';

  @override
  String get notesCloudBackupTitle =>
      'Заметки с облачным резервным копированием';

  @override
  String get notesCloudBackupDescription =>
      'Сохраняйте личные заметки и размышления, безопасно сохраненные в облаке (функция в разработке/скоро).';

  @override
  String get crossPlatformSupportTitle => 'Поддержка нескольких платформ';

  @override
  String get crossPlatformSupportDescription =>
      'Поддерживается на Android, Web, Linux и Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Воспроизведение аудио в фоне';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Продолжайте слушать чтение Корана даже когда приложение в фоне.';

  @override
  String get audioDataCachingTitle => 'Кэширование аудио и данных';

  @override
  String get audioDataCachingDescription =>
      'Улучшенное воспроизведение и оффлайн возможности с надежным кэшированием аудио и данных Корана.';

  @override
  String get minimalisticInterfaceTitle => 'Минималистичный и чистый интерфейс';

  @override
  String get minimalisticInterfaceDescription =>
      'Легкий в навигации интерфейс с фокусом на пользовательский опыт и читаемость.';

  @override
  String get optimizedPerformanceTitle =>
      'Оптимизированная производительность и размер';

  @override
  String get optimizedPerformanceDescription =>
      'Функциональное приложение, разработанное чтобы быть легким и производительным.';

  @override
  String get languageSupport => 'Поддержка языков';

  @override
  String get languageSupportDescription =>
      'Это приложение предназначено для глобальной аудитории с поддержкой следующих языков (и добавляются еще):';

  @override
  String get technologyAndResources => 'Технологии и ресурсы';

  @override
  String get technologyAndResourcesDescription =>
      'Это приложение построено с использованием передовых технологий и надежных ресурсов:';

  @override
  String get flutterFrameworkTitle => 'Фреймворк Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Построено на Flutter для красивого, нативно компилируемого, мультиплатформенного опыта из единой кодовой базы.';

  @override
  String get advancedAudioEngineTitle => 'Продвинутый аудио движок';

  @override
  String get advancedAudioEngineDescription =>
      'Работает на пакетах Flutter `just_audio` и `just_audio_background` для надежного воспроизведения и контроля аудио.';

  @override
  String get reliableQuranDataTitle => 'Надежные данные Корана';

  @override
  String get reliableQuranDataDescription =>
      'Тексты Аль-Корана, переводы, тафсиры и аудио взяты из проверенных открытых API и баз данных вроде Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Движок времени намаза';

  @override
  String get prayerTimeEngineDescription =>
      'Использует установленные методы расчета для точного времени намаза. Уведомления обрабатываются `flutter_local_notifications` и фоновыми задачами.';

  @override
  String get crossPlatformSupport => 'Поддержка нескольких платформ';

  @override
  String get crossPlatformSupportDescription2 =>
      'Наслаждайтесь seamless доступом на различных платформах:';

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
  String get ourLifetimePromise => 'Наше обещание на всю жизнь';

  @override
  String get lifetimePromiseDescription =>
      'Я лично обещаю предоставлять непрерывную поддержку и обслуживание этого приложения на протяжении всей моей жизни, Инша Аллах. Моя цель - убедиться, что это приложение остается полезным ресурсом для Уммы на годы вперед.';

  @override
  String get fajr => 'Фаджр';

  @override
  String get sunrise => 'Восход';

  @override
  String get noon => 'Noon';

  @override
  String get dhuhr => 'Зухр';

  @override
  String get asr => 'Аср';

  @override
  String get sunset => 'Sunset';

  @override
  String get maghrib => 'Магриб';

  @override
  String get isha => 'Иша';

  @override
  String get midnight => 'Полночь';

  @override
  String get alarm => 'Будильник';

  @override
  String get notification => 'Уведомление';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Таджвид';

  @override
  String get quranScriptUthmani => 'Усмани';

  @override
  String get quranScriptIndopak => 'Индопак';

  @override
  String get sajdaAyah => 'Аят саджда';

  @override
  String get required => 'Обязательно';

  @override
  String get optional => 'Опционально';

  @override
  String get notificationScheduleWarning =>
      'Примечание: Запланированные уведомления или напоминания могут быть пропущены из-за ограничений фоновых процессов ОС вашего телефона. Например: Origin OS от Vivo, One UI от Samsung, ColorOS от Oppo иногда убивают запланированные уведомления или напоминания. Пожалуйста, проверьте настройки ОС, чтобы приложение не было ограничено в фоновых процессах.';

  @override
  String get scrollWithRecitation => 'Прокрутка с чтением';

  @override
  String get quickAccess => 'Быстрый доступ';

  @override
  String get initiallyScrollAyah => 'Изначально прокрутить к аяту';

  @override
  String get tajweedGuide => 'Руководство по таджвиду';

  @override
  String get scrollWithRecitationDesc =>
      'Когда включено, аяты Корана будут автоматически прокручиваться в синхронизации с аудио чтением.';

  @override
  String get configuration => 'Конфигурация';

  @override
  String get restoreFromBackup => 'Восстановить из резервной копии';

  @override
  String get history => 'История';

  @override
  String get search => 'Поиск';

  @override
  String get useAudioStream => 'Использовать потоковое аудио';

  @override
  String get useAudioStreamDesc =>
      'Потоковое аудио напрямую из интернета вместо скачивания.';

  @override
  String get notUseAudioStreamDesc =>
      'Скачивайте аудио для оффлайн использования и снижения потребления данных.';

  @override
  String get audioSettings => 'Настройки аудио';

  @override
  String get playbackSpeed => 'Скорость воспроизведения';

  @override
  String get playbackSpeedDesc => 'Настройте скорость чтения Корана.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Пожалуйста, подождите завершения текущей загрузки.';

  @override
  String get areYouSure => 'Вы уверены?';

  @override
  String get checkYourInternetConnection =>
      'Проверьте подключение к интернету.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Нужно скачать $requiredDownload из $totalVersesCount аятов.';
  }

  @override
  String get download => 'Скачать';

  @override
  String get audioDownload => 'Скачивание аудио';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Оптимизация шрифта Корана';

  @override
  String get supportOnGithub => 'Поддержать на GitHub';
}
