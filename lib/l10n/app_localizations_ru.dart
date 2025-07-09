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
    return 'Тафсир для $ayahKey недоступен';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Тафсир находится в: $anotherAyahLinkKey';
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
  String get pleaseSelectOne => 'Пожалуйста, выберите';

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
  String get quranScriptAndStyle => 'Шрифт и стиль Корана';

  @override
  String get justAMoment => 'Один момент...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Успешно';

  @override
  String get retry => 'Повторить';

  @override
  String get unableToDownloadResources =>
      'Не удалось загрузить ресурсы...\nЧто-то пошло не так';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Загрузка сегментированной декламации Корана';

  @override
  String get processingSegmentedQuranRecitation =>
      'Обработка сегментированной декламации Корана';

  @override
  String get footnote => 'Сноска';

  @override
  String get tafsir => 'Тафсир';

  @override
  String get wordByWord => 'Пословный';

  @override
  String get pleaseSelectRequiredOption =>
      'Пожалуйста, выберите необходимый вариант';

  @override
  String get rememberHomeTab => 'Запомнить главную вкладку';

  @override
  String get rememberHomeTabSubtitle =>
      'Приложение запомнит последнюю открытую вкладку на главном экране.';

  @override
  String get wakeLock => 'Не выключать экран';

  @override
  String get wakeLockSubtitle => 'Запретить экрану автоматически выключаться.';

  @override
  String get settings => 'Настройки';

  @override
  String get appTheme => 'Тема приложения';

  @override
  String get quranStyle => 'Стиль Корана';

  @override
  String get changeTheme => 'Сменить тему';

  @override
  String get verseCount => 'Количество аятов: ';

  @override
  String get translation => 'Перевод';

  @override
  String get tafsirNotFound => 'Не найдено';

  @override
  String get moreInfo => 'подробнее';

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
  String get name => 'Название: ';

  @override
  String get location => 'Местоположение: ';

  @override
  String get parameters => 'Параметры: ';

  @override
  String get selectCalculationMethod => 'Выберите метод расчета';

  @override
  String get shareSelectAyahs => 'Поделиться выбранными аятами';

  @override
  String get selectionEmpty => 'Ничего не выбрано';

  @override
  String get generatingImagePleaseWait =>
      'Создание изображения... Пожалуйста, подождите';

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
  String get bugReportTitle => 'Сообщить об ошибке';

  @override
  String get audioCached => 'Аудио кэшировано';

  @override
  String get others => 'Другое';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Коран|Перевод|Аят, хотя бы одно должно быть включено';

  @override
  String get quranFontSize => 'Размер шрифта Корана';

  @override
  String get quranLineHeight => 'Высота строки Корана';

  @override
  String get translationAndTafsirFontSize => 'Размер шрифта перевода и тафсира';

  @override
  String get quranAyah => 'Аят Корана';

  @override
  String get topToolbar => 'Верхняя панель';

  @override
  String get keepOpenWordByWord => 'Оставлять пословный перевод открытым';

  @override
  String get wordByWordHighlight => 'Подсветка пословного перевода';

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
  String get deviceDoesNotHaveSensors => 'В устройстве отсутствуют датчики!';

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
  String get downloadPrayerTime => 'Загрузить время молитв';

  @override
  String get calculationMethodsListEmpty => 'Список методов расчета пуст.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Не удалось найти метод расчета с данными о местоположении.';

  @override
  String get prayerSettings => 'Настройки молитв';

  @override
  String get reminderSettings => 'Настройки напоминаний';

  @override
  String get adjustReminderTime => 'Настроить время напоминания';

  @override
  String get enforceAlarmSound => 'Принудительный звук будильника';

  @override
  String get enforceAlarmSoundDescription =>
      'Если включено, эта функция будет воспроизводить будильник с установленной здесь громкостью, даже если звук вашего телефона тихий. Это гарантирует, что вы не пропустите будильник из-за низкой громкости телефона.';

  @override
  String get volume => 'Громкость';

  @override
  String get atPrayerTime => 'Во время молитвы';

  @override
  String minBefore(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'за $minutes минуты до',
      many: 'за $minutes минут до',
      few: 'за $minutes минуты до',
      one: 'за $minutes минуту до',
    );
    return '$_temp0';
  }

  @override
  String minAfter(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'через $minutes минуты после',
      many: 'через $minutes минут после',
      few: 'через $minutes минуты после',
      one: 'через $minutes минуту после',
    );
    return '$_temp0';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'Время молитвы $prayerName в $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Время молитвы $prayerName';
  }

  @override
  String get stopTheAdhan => 'Остановить азан';

  @override
  String dateFoundEmpty(String date) {
    return 'Данные для $date не найдены';
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
      'Пожалуйста, разрешите уведомления, чтобы использовать эту функцию';

  @override
  String reminderRemoved(String prayerName) {
    return 'Напоминание для $prayerName удалено';
  }

  @override
  String get getPrayerTimesAndQibla => 'Получить время молитв и Киблу';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Рассчитайте время молитв и Киблу для любого заданного местоположения.';

  @override
  String get getFromGPS => 'Получить по GPS';

  @override
  String get or => 'Или';

  @override
  String get selectYourCity => 'Выберите ваш город';

  @override
  String get noteAboutGPS =>
      'Примечание: Если вы не хотите использовать GPS или не чувствуете себя в безопасности, вы можете выбрать свой город.';

  @override
  String get downloadingLocationResources =>
      'Загрузка ресурсов местоположения...';

  @override
  String get somethingWentWrong => 'Что-то пошло не так';

  @override
  String get selectYourCountry => 'Выберите вашу страну';

  @override
  String get searchForACountry => 'Поиск страны';

  @override
  String get selectYourAdministrator => 'Выберите ваш регион';

  @override
  String get searchForAnAdministrator => 'Поиск региона';

  @override
  String get searchForACity => 'Поиск города';

  @override
  String get pleaseEnableLocationService =>
      'Пожалуйста, включите службу определения местоположения';

  @override
  String get donateUs => 'Поддержать проект';

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
  String get pinned => 'Закрепления';

  @override
  String get jumpToAyah => 'Перейти к аяту';

  @override
  String get shareMultipleAyah => 'Поделиться несколькими аятами';

  @override
  String get shareThisApp => 'Поделиться приложением';

  @override
  String get giveRating => 'Оценить';

  @override
  String get bugReport => 'Сообщить об ошибке';

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
      'Вы уверены, что хотите сбросить приложение? Все ваши данные будут потеряны, и вам потребуется настроить приложение с самого начала.';

  @override
  String get cancel => 'Отмена';

  @override
  String get reset => 'Сбросить';

  @override
  String get shareAppSubject => 'Оцени это приложение Аль-Коран!';

  @override
  String shareAppBody(String appLink) {
    return 'Ассаляму алейкум! Оцени это приложение Аль-Коран для ежедневного чтения и размышлений. Оно помогает соединиться со словами Аллаха. Скачать здесь: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Открыть меню';

  @override
  String get quran => 'Коран';

  @override
  String get prayer => 'Молитва';

  @override
  String get qibla => 'Кибла';

  @override
  String get audio => 'Аудио';

  @override
  String get surah => 'Сура';

  @override
  String get pages => 'Страницы';

  @override
  String get note => 'Примечание:';

  @override
  String get linkedAyahs => 'Связанные аяты:';

  @override
  String get emptyNoteCollection =>
      'В этой коллекции заметок пусто.\nДобавьте заметки, чтобы увидеть их здесь.';

  @override
  String get emptyPinnedCollection =>
      'В этой коллекции пока нет закрепленных аятов.\nЗакрепите аяты, чтобы увидеть их здесь.';

  @override
  String get noContentAvailable => 'Содержимое недоступно.';

  @override
  String failedToLoadCollections(String error) {
    return 'Не удалось загрузить коллекции: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Поиск в $collectionType по названию...';
  }

  @override
  String get sortBy => 'Сортировать по';

  @override
  String noCollectionAddedYet(String collectionType) {
    return '$collectionType еще не добавлены';
  }

  @override
  String pinnedItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count закрепленного элемента',
      many: '$count закрепленных элементов',
      few: '$count закрепленных элемента',
      one: '$count закрепленный элемент',
    );
    return '$_temp0';
  }

  @override
  String notesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count заметки',
      many: '$count заметок',
      few: '$count заметки',
      one: '$count заметка',
    );
    return '$_temp0';
  }

  @override
  String get emptyNameNotAllowed => 'Имя не может быть пустым';

  @override
  String updatedTo(String collectionName) {
    return 'Обновлено до $collectionName';
  }

  @override
  String get changeName => 'Сменить имя';

  @override
  String get changeColor => 'Сменить цвет';

  @override
  String get colorUpdated => 'Цвет обновлен';

  @override
  String collectionDeleted(String collectionName) {
    return 'Коллекция \'$collectionName\' удалена';
  }

  @override
  String get delete => 'Удалить';

  @override
  String get save => 'Сохранить';

  @override
  String get collectionNameCannotBeEmpty =>
      'Название коллекции не может быть пустым.';

  @override
  String get addedNewCollection => 'Добавлена новая коллекция';

  @override
  String ayahCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count аята',
      many: '$count аятов',
      few: '$count аята',
      one: '$count аят',
    );
    return '$_temp0';
  }

  @override
  String get byNameAtoZ => 'По названию А-Я';

  @override
  String get byNameZtoA => 'По названию Я-А';

  @override
  String get byElementNumberAscending => 'По количеству (возр.)';

  @override
  String get byElementNumberDescending => 'По количеству (убыв.)';

  @override
  String get byUpdateDateAscending => 'По дате обновления (возр.)';

  @override
  String get byUpdateDateDescending => 'По дате обновления (убыв.)';

  @override
  String get byCreateDateAscending => 'По дате создания (возр.)';

  @override
  String get byCreateDateDescending => 'По дате создания (убыв.)';

  @override
  String get translationNotFound => 'Перевод не найден';

  @override
  String get translationTitle => 'Перевод:';

  @override
  String get footNoteTitle => 'Сноска:';

  @override
  String get wordByWordTranslation => 'Пословный перевод:';

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
      'Содержание заметки не может быть пустым.';

  @override
  String get noteSavedSuccessfully => 'Заметка успешно сохранена!';

  @override
  String get selectCollections => 'Выберите коллекции';

  @override
  String get addNote => 'Добавить заметку';

  @override
  String get writeCollectionName => 'Введите название коллекции...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Коллекций пока нет. Добавьте новую!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Пожалуйста, сначала напишите свою заметку.';

  @override
  String get noCollectionSelected => 'Коллекция не выбрана';

  @override
  String get saveNote => 'Сохранить заметку';

  @override
  String get nextSelectCollections => 'Далее: Выберите коллекции';

  @override
  String get addToPinned => 'Добавить в закрепленные';

  @override
  String get pinnedSavedSuccessfully => 'Закрепление успешно сохранено!';

  @override
  String get savePinned => 'Сохранить закрепление';

  @override
  String get closeAudioController => 'Закрыть аудио плеер';

  @override
  String get previous => 'Назад';

  @override
  String get rewind => 'Перемотка назад';

  @override
  String get fastForward => 'Перемотка вперед';

  @override
  String get playNextAyah => 'Следующий аят';

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
  String get more => 'Еще: ';

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
  String get aboutAlQuran => 'О приложении Al Quran';

  @override
  String get appFullName => 'Al Quran (Тафсир, Молитва, Кибла, Аудио)';

  @override
  String get appDescription =>
      'Комплексное исламское приложение для Android, iOS, MacOS, Web, Linux и Windows, предлагающее чтение Корана с тафсиром и несколькими переводами (включая пословный), мировое время молитв с уведомлениями, компас Киблы и синхронизированное пословное аудио-чтение.';

  @override
  String get dataSourcesNote =>
      'Примечание: Тексты Корана, тафсир, переводы и аудиоресурсы получены с Quran.com, Everyayah.com и других проверенных открытых источников.';

  @override
  String get adFreePromise =>
      'Это приложение было создано ради довольства Аллаха. Поэтому оно является и всегда будет полностью без рекламы.';

  @override
  String get coreFeatures => 'Основные функции';

  @override
  String get coreFeaturesDescription =>
      'Ознакомьтесь с ключевыми функциями, которые делают Al Quran v3 незаменимым инструментом для вашей ежедневной исламской практики:';

  @override
  String get prayerTimesTitle => 'Время молитв и оповещения';

  @override
  String get prayerTimesDescription =>
      'Точное время молитв для любого места в мире с использованием различных методов расчета. Установите напоминания с уведомлениями азана.';

  @override
  String get qiblaDirectionTitle => 'Направление Киблы';

  @override
  String get qiblaDirectionDescription =>
      'Легко находите направление Киблы с помощью четкого и точного компаса.';

  @override
  String get translationTafsirTitle => 'Перевод и тафсир Корана';

  @override
  String get translationTafsirDescription =>
      'Доступ к более чем 120 книгам переводов (включая пословный) на 69 языках и более 30 книгам тафсира.';

  @override
  String get wordByWordAudioTitle => 'Пословное аудио и выделение';

  @override
  String get wordByWordAudioDescription =>
      'Следите за синхронизированным пословным аудио-чтением и выделением для захватывающего опыта обучения.';

  @override
  String get ayahAudioRecitationTitle => 'Аудио-чтение аятов';

  @override
  String get ayahAudioRecitationDescription =>
      'Слушайте полные аудио-чтения аятов от более чем 40 известных чтецов.';

  @override
  String get notesCloudBackupTitle =>
      'Заметки с облачным резервным копированием';

  @override
  String get notesCloudBackupDescription =>
      'Сохраняйте личные заметки и размышления, надежно сохраненные в облаке (функция в разработке/скоро появится).';

  @override
  String get crossPlatformSupportTitle => 'Кроссплатформенная поддержка';

  @override
  String get crossPlatformSupportDescription =>
      'Поддерживается на Android, Web, Linux и Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Фоновое воспроизведение аудио';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Продолжайте слушать чтение Корана, даже когда приложение находится в фоновом режиме.';

  @override
  String get audioDataCachingTitle => 'Кэширование аудио и данных';

  @override
  String get audioDataCachingDescription =>
      'Улучшенное воспроизведение и автономные возможности с надежным кэшированием аудио и данных Корана.';

  @override
  String get minimalisticInterfaceTitle => 'Минималистичный и чистый интерфейс';

  @override
  String get minimalisticInterfaceDescription =>
      'Простой в навигации интерфейс с упором на удобство использования и читабельность.';

  @override
  String get optimizedPerformanceTitle =>
      'Оптимизированная производительность и размер';

  @override
  String get optimizedPerformanceDescription =>
      'Многофункциональное приложение, разработанное так, чтобы быть легким и производительным.';

  @override
  String get languageSupport => 'Языковая поддержка';

  @override
  String get languageSupportDescription =>
      'Это приложение разработано для глобальной аудитории с поддержкой следующих языков (и постоянно добавляются новые):';

  @override
  String get technologyAndResources => 'Технологии и ресурсы';

  @override
  String get technologyAndResourcesDescription =>
      'Это приложение создано с использованием передовых технологий и надежных ресурсов:';

  @override
  String get flutterFrameworkTitle => 'Фреймворк Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Создано с помощью Flutter для красивого, нативно скомпилированного, кроссплатформенного опыта из единой кодовой базы.';

  @override
  String get advancedAudioEngineTitle => 'Продвинутый аудио-движок';

  @override
  String get advancedAudioEngineDescription =>
      'Работает на базе пакетов Flutter `just_audio` и `just_audio_background` для надежного воспроизведения и управления аудио.';

  @override
  String get reliableQuranDataTitle => 'Надежные данные Корана';

  @override
  String get reliableQuranDataDescription =>
      'Тексты, переводы, тафсиры и аудио Корана получены из проверенных открытых API и баз данных, таких как Quran.com и Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Движок времени молитв';

  @override
  String get prayerTimeEngineDescription =>
      'Использует установленные методы расчета для точного времени молитв. Уведомления обрабатываются `flutter_local_notifications` и фоновыми задачами.';

  @override
  String get crossPlatformSupport => 'Кроссплатформенная поддержка';

  @override
  String get crossPlatformSupportDescription2 =>
      'Наслаждайтесь беспрепятственным доступом на различных платформах:';

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
  String get ourLifetimePromise => 'Наше пожизненное обещание';

  @override
  String get lifetimePromiseDescription =>
      'Я лично обещаю предоставлять постоянную поддержку и обслуживание этого приложения на протяжении всей моей жизни, ин ша\'Аллах. Моя цель — обеспечить, чтобы это приложение оставалось полезным ресурсом для уммы на долгие годы.';

  @override
  String get fajr => 'Фаджр';

  @override
  String get sunrise => 'Восход';

  @override
  String get dhuhr => 'Зухр';

  @override
  String get asr => 'Аср';

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
  String get required => 'Обязательный';

  @override
  String get optional => 'Желательный';

  @override
  String get notificationScheduleWarning =>
      'Примечание. Запланированные уведомления или напоминания могут быть пропущены из-за ограничений фоновых процессов вашей ОС. Например: Origin OS от Vivo, One UI от Samsung, ColorOS от Oppo и т. д. иногда отключают запланированные уведомления или напоминания. Пожалуйста, проверьте настройки вашей ОС, чтобы приложение не было ограничено в фоновых процессах.';
}
