// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

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
    return 'El Tafsir no está disponible para $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'El Tafsir se encuentra en: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Ir a $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Página';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Configuración de Idioma';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName, $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Aleyas';
  }

  @override
  String get saveAndDownload => 'Guardar y Descargar';

  @override
  String get appLanguage => 'Idioma de la App';

  @override
  String get selectAppLanguage => 'Seleccionar idioma de la app...';

  @override
  String get pleaseSelectOne => 'Por favor, seleccione uno';

  @override
  String get quranTranslationLanguage => 'Idioma de Traducción del Corán';

  @override
  String get selectTranslationLanguage => 'Seleccionar idioma de traducción...';

  @override
  String get quranTranslationBook => 'Libro de Traducción del Corán';

  @override
  String get selectTranslationBook => 'Seleccionar libro de traducción...';

  @override
  String get quranTafsirLanguage => 'Idioma del Tafsir del Corán';

  @override
  String get selectTafsirLanguage => 'Seleccionar idioma del tafsir...';

  @override
  String get quranTafsirBook => 'Libro de Tafsir del Corán';

  @override
  String get selectTafsirBook => 'Seleccionar libro de tafsir...';

  @override
  String get quranScriptAndStyle => 'Escritura y Estilo del Corán';

  @override
  String get justAMoment => 'Un momento...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Éxito';

  @override
  String get retry => 'Reintentar';

  @override
  String get unableToDownloadResources =>
      'No se pudieron descargar los recursos...\nAlgo salió mal';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Descargando Recitación Segmentada del Corán';

  @override
  String get processingSegmentedQuranRecitation =>
      'Procesando Recitación Segmentada del Corán';

  @override
  String get footnote => 'Nota al pie';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Palabra por Palabra';

  @override
  String get pleaseSelectRequiredOption =>
      'Por favor, seleccione la opción requerida';

  @override
  String get rememberHomeTab => 'Recordar Pestaña de Inicio';

  @override
  String get rememberHomeTabSubtitle =>
      'La app recordará la última pestaña abierta en la pantalla de inicio.';

  @override
  String get wakeLock => 'Mantener Pantalla Encendida';

  @override
  String get wakeLockSubtitle =>
      'Evita que la pantalla se apague automáticamente.';

  @override
  String get settings => 'Configuración';

  @override
  String get appTheme => 'Tema de la App';

  @override
  String get quranStyle => 'Estilo del Corán';

  @override
  String get changeTheme => 'Cambiar Tema';

  @override
  String get verseCount => 'Número de Aleyas: ';

  @override
  String get translation => 'Traducción';

  @override
  String get tafsirNotFound => 'No Encontrado';

  @override
  String get moreInfo => 'más info';

  @override
  String get playAudio => 'Reproducir Audio';

  @override
  String get preview => 'Vista Previa';

  @override
  String get loading => 'Cargando...';

  @override
  String get errorFetchingAddress => 'Error al obtener la dirección';

  @override
  String get addressNotAvailable => 'Dirección no disponible';

  @override
  String get latitude => 'Latitud: ';

  @override
  String get longitude => 'Longitud: ';

  @override
  String get name => 'Nombre: ';

  @override
  String get location => 'Ubicación: ';

  @override
  String get parameters => 'Parámetros: ';

  @override
  String get selectCalculationMethod => 'Seleccionar Método de Cálculo';

  @override
  String get shareSelectAyahs => 'Compartir Aleyas Seleccionadas';

  @override
  String get selectionEmpty => 'Selección Vacía';

  @override
  String get generatingImagePleaseWait =>
      'Generando imagen... Por favor, espere';

  @override
  String get asImage => 'Como Imagen';

  @override
  String get asText => 'Como Texto';

  @override
  String get playFromSelectedAyah => 'Reproducir desde la Aleya Seleccionada';

  @override
  String get toTafsir => 'Ir al Tafsir';

  @override
  String get selectAyah => 'Seleccionar Aleya';

  @override
  String get toAyah => 'Ir a la Aleya';

  @override
  String get searchForASurah => 'Buscar una sura';

  @override
  String get bugReportTitle => 'Informe de Error';

  @override
  String get audioCached => 'Audio en Caché';

  @override
  String get others => 'Otros';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Corán|Traducción|Aleya, al menos uno debe estar habilitado';

  @override
  String get quranFontSize => 'Tamaño de Fuente del Corán';

  @override
  String get quranLineHeight => 'Altura de Línea del Corán';

  @override
  String get translationAndTafsirFontSize =>
      'Tamaño de Fuente de Traducción y Tafsir';

  @override
  String get quranAyah => 'Aleya del Corán';

  @override
  String get topToolbar => 'Barra de Herramientas Superior';

  @override
  String get keepOpenWordByWord => 'Mantener Abierto Palabra por Palabra';

  @override
  String get wordByWordHighlight => 'Resaltado Palabra por Palabra';

  @override
  String get quranScriptSettings => 'Configuración de Escritura del Corán';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Página: ';

  @override
  String get quranResources => 'Recursos del Corán';

  @override
  String alreadySelected(String name) {
    return 'El idioma \'$name\' ya está seleccionado.';
  }

  @override
  String get unableToGetCompassData =>
      'No se pudieron obtener los datos de la brújula';

  @override
  String get deviceDoesNotHaveSensors => '¡El dispositivo no tiene sensores!';

  @override
  String get north => 'N';

  @override
  String get east => 'E';

  @override
  String get south => 'S';

  @override
  String get west => 'O';

  @override
  String get address => 'Dirección: ';

  @override
  String get change => 'Cambiar';

  @override
  String get calculationMethod => 'Método de Cálculo: ';

  @override
  String get downloadPrayerTime => 'Descargar Horarios de Oración';

  @override
  String get calculationMethodsListEmpty =>
      'La lista de métodos de cálculo está vacía.';

  @override
  String get noCalculationMethodWithLocationData =>
      'No se encontró ningún método de cálculo con los datos de ubicación.';

  @override
  String get prayerSettings => 'Configuración de Oración';

  @override
  String get reminderSettings => 'Configuración de Recordatorios';

  @override
  String get adjustReminderTime => 'Ajustar Hora del Recordatorio';

  @override
  String get enforceAlarmSound => 'Forzar Sonido de la Alarma';

  @override
  String get enforceAlarmSoundDescription =>
      'Si está activada, esta función reproducirá la alarma al volumen establecido aquí, incluso si el sonido de su teléfono está bajo. Esto asegura que no se pierda la alarma debido al bajo volumen del teléfono.';

  @override
  String get volume => 'Volumen';

  @override
  String get atPrayerTime => 'A la hora de la oración';

  @override
  String minBefore(int minutes) {
    return '$minutes min antes';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min después';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName es a las $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Es la hora de $prayerName';
  }

  @override
  String get stopTheAdhan => 'Detener el Adhan';

  @override
  String dateFoundEmpty(String date) {
    return '$date Encontrado Vacío';
  }

  @override
  String get today => 'Hoy';

  @override
  String get left => 'Quedan';

  @override
  String reminderAdded(String prayerName) {
    return 'Recordatorio para $prayerName añadido';
  }

  @override
  String get allowNotificationPermission =>
      'Por favor, permita el permiso de notificaciones para usar esta función';

  @override
  String reminderRemoved(String prayerName) {
    return 'Recordatorio para $prayerName eliminado';
  }

  @override
  String get getPrayerTimesAndQibla => 'Obtener Horarios de Oración y Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calcular los horarios de oración y la Qibla para cualquier ubicación.';

  @override
  String get getFromGPS => 'Obtener desde GPS';

  @override
  String get or => 'O';

  @override
  String get selectYourCity => 'Seleccione su Ciudad';

  @override
  String get noteAboutGPS =>
      'Nota: Si no desea usar el GPS o no se siente seguro, puede seleccionar su ciudad.';

  @override
  String get downloadingLocationResources =>
      'Descargando recursos de ubicación...';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get selectYourCountry => 'Seleccione su País';

  @override
  String get searchForACountry => 'Buscar un país';

  @override
  String get selectYourAdministrator => 'Seleccione su Administrador';

  @override
  String get searchForAnAdministrator => 'Buscar un administrador';

  @override
  String get searchForACity => 'Buscar una ciudad';

  @override
  String get pleaseEnableLocationService =>
      'Por favor, active el servicio de ubicación';

  @override
  String get donateUs => 'Dónanos';

  @override
  String get underDevelopment => 'En desarrollo';

  @override
  String get versionLoading => 'Cargando...';

  @override
  String get alQuran => 'Al Quran';

  @override
  String get mainMenu => 'Menú Principal';

  @override
  String get notes => 'Notas';

  @override
  String get pinned => 'Fijados';

  @override
  String get jumpToAyah => 'Ir a la Aleya';

  @override
  String get shareMultipleAyah => 'Compartir Múltiples Aleyas';

  @override
  String get shareThisApp => 'Compartir esta App';

  @override
  String get giveRating => 'Calificar';

  @override
  String get bugReport => 'Informe de Error';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get aboutTheApp => 'Acerca de la App';

  @override
  String get resetTheApp => 'Restablecer la App';

  @override
  String get resetAppWarningTitle => 'Restablecer Datos de la App';

  @override
  String get resetAppWarningMessage =>
      '¿Estás seguro de que quieres restablecer la aplicación? Todos tus datos se perderán y tendrás que configurar la aplicación desde el principio.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Restablecer';

  @override
  String get shareAppSubject => '¡Echa un vistazo a esta app de Al Quran!';

  @override
  String shareAppBody(String appLink) {
    return '¡As-salamu alaykum! Echa un vistazo a esta app de Al Quran para la lectura y reflexión diaria. Ayuda a conectar con las palabras de Allah. Descárgala aquí: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Abrir Menú';

  @override
  String get quran => 'Corán';

  @override
  String get prayer => 'Oración';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Sura';

  @override
  String get pages => 'Páginas';

  @override
  String get note => 'Nota:';

  @override
  String get linkedAyahs => 'Aleyas Vinculadas:';

  @override
  String get emptyNoteCollection =>
      'Esta colección de notas está vacía.\nAñade algunas notas para verlas aquí.';

  @override
  String get emptyPinnedCollection =>
      'Aún no hay aleyas fijadas en esta colección.\nFija aleyas para verlas aquí.';

  @override
  String get noContentAvailable => 'No hay contenido disponible.';

  @override
  String failedToLoadCollections(String error) {
    return 'Error al cargar las colecciones: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Buscar por Nombre de $collectionType...';
  }

  @override
  String get sortBy => 'Ordenar por';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Aún no se ha añadido ninguna $collectionType';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count elementos fijados';
  }

  @override
  String notesCount(int count) {
    return '$count notas';
  }

  @override
  String get emptyNameNotAllowed => 'No se permite un nombre vacío';

  @override
  String updatedTo(String collectionName) {
    return 'Actualizado a $collectionName';
  }

  @override
  String get changeName => 'Cambiar Nombre';

  @override
  String get changeColor => 'Cambiar Color';

  @override
  String get colorUpdated => 'Color actualizado';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Eliminada';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get collectionNameCannotBeEmpty =>
      'El nombre de la colección no puede estar vacío.';

  @override
  String get addedNewCollection => 'Nueva Colección Añadida';

  @override
  String ayahCount(int count) {
    return '$count Aleya';
  }

  @override
  String get byNameAtoZ => 'Nombre A-Z';

  @override
  String get byNameZtoA => 'Nombre Z-A';

  @override
  String get byElementNumberAscending => 'Número de Elemento Ascendente';

  @override
  String get byElementNumberDescending => 'Número de Elemento Descendente';

  @override
  String get byUpdateDateAscending => 'Fecha de Actualización Ascendente';

  @override
  String get byUpdateDateDescending => 'Fecha de Actualización Descendente';

  @override
  String get byCreateDateAscending => 'Fecha de Creación Ascendente';

  @override
  String get byCreateDateDescending => 'Fecha de Creación Descendente';

  @override
  String get translationNotFound => 'Traducción No Encontrada';

  @override
  String get translationTitle => 'Traducción:';

  @override
  String get footNoteTitle => 'Nota al Pie:';

  @override
  String get wordByWordTranslation => 'Traducción Palabra por Palabra:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Compartir';

  @override
  String get addNoteButton => 'Añadir Nota';

  @override
  String get pinToCollectionButton => 'Fijar a Colección';

  @override
  String get shareAsText => 'Compartir como Texto';

  @override
  String get copiedWithTafsir => 'Copiado con Tafsir';

  @override
  String get shareAsImage => 'Compartir como Imagen';

  @override
  String get shareWithTafsir => 'Compartir con Tafsir';

  @override
  String get notFound => 'No encontrado';

  @override
  String get noteContentCannotBeEmpty =>
      'El contenido de la nota no puede estar vacío.';

  @override
  String get noteSavedSuccessfully => '¡Nota guardada con éxito!';

  @override
  String get selectCollections => 'Seleccionar Colecciones';

  @override
  String get addNote => 'Añadir Nota';

  @override
  String get writeCollectionName => 'Escribe el nombre de la colección...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Aún no hay colecciones. ¡Añade una nueva!';

  @override
  String get pleaseWriteYourNoteFirst => 'Por favor, escribe tu nota primero.';

  @override
  String get noCollectionSelected => 'Ninguna colección seleccionada';

  @override
  String get saveNote => 'Guardar Nota';

  @override
  String get nextSelectCollections => 'Siguiente: Seleccionar Colecciones';

  @override
  String get addToPinned => 'Añadir a Fijados';

  @override
  String get pinnedSavedSuccessfully => '¡Fijado guardado con éxito!';

  @override
  String get savePinned => 'Guardar Fijado';

  @override
  String get closeAudioController => 'Cerrar Controlador de Audio';

  @override
  String get previous => 'Anterior';

  @override
  String get rewind => 'Rebobinar';

  @override
  String get fastForward => 'Avance Rápido';

  @override
  String get playNextAyah => 'Reproducir Siguiente Aleya';

  @override
  String get repeat => 'Repetir';

  @override
  String get playAsPlaylist => 'Reproducir como Lista';

  @override
  String style(String style) {
    return 'Estilo: $style';
  }

  @override
  String get stopAndClose => 'Detener y Cerrar';

  @override
  String get play => 'Reproducir';

  @override
  String get pause => 'Pausa';

  @override
  String get selectReciter => 'Seleccionar Recitador';

  @override
  String source(String source) {
    return 'Fuente: $source';
  }

  @override
  String get newText => 'Nuevo';

  @override
  String get more => 'Más: ';

  @override
  String get cacheNotFound => 'Caché No Encontrado';

  @override
  String get cacheSize => 'Tamaño del Caché';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get clean => 'Limpiar';

  @override
  String get lastModified => 'Última Modificación';

  @override
  String get oneYearAgo => 'Hace 1 año';

  @override
  String monthsAgo(String number) {
    return 'Hace $number meses';
  }

  @override
  String weeksAgo(String number) {
    return 'Hace $number semanas';
  }

  @override
  String daysAgo(String number) {
    return 'Hace $number días';
  }

  @override
  String hoursAgo(int hour) {
    return 'Hace $hour horas';
  }

  @override
  String get aboutAlQuran => 'Acerca de Al Quran';

  @override
  String get appFullName => 'Al Quran (Tafsir, Oración, Qibla, Audio)';

  @override
  String get appDescription =>
      'Una completa aplicación islámica para Android, iOS, MacOS, Web, Linux y Windows, que ofrece la lectura del Corán con Tafsir y múltiples traducciones (incluida palabra por palabra), horarios de oración mundiales con notificaciones, brújula de Qibla y recitación de audio sincronizada palabra por palabra.';

  @override
  String get dataSourcesNote =>
      'Nota: Los textos del Corán, Tafsir, traducciones y recursos de audio provienen de Quran.com, Everyayah.com y otras fuentes abiertas verificadas.';

  @override
  String get adFreePromise =>
      'Esta aplicación ha sido creada para buscar el agrado de Allah. Por lo tanto, es y siempre será completamente Libre de Anuncios.';

  @override
  String get coreFeatures => 'Características Principales';

  @override
  String get coreFeaturesDescription =>
      'Explore las funcionalidades clave que hacen de Al Quran v3 una herramienta indispensable para sus prácticas islámicas diarias:';

  @override
  String get prayerTimesTitle => 'Horarios de Oración y Alertas';

  @override
  String get prayerTimesDescription =>
      'Horarios de oración precisos para cualquier lugar del mundo utilizando varios métodos de cálculo. Establezca recordatorios con notificaciones de Adhan.';

  @override
  String get qiblaDirectionTitle => 'Dirección de la Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Encuentre fácilmente la dirección de la Qibla con una vista de brújula clara y precisa.';

  @override
  String get translationTafsirTitle => 'Traducción y Tafsir del Corán';

  @override
  String get translationTafsirDescription =>
      'Acceda a más de 120 libros de traducción (incluida palabra por palabra) en 69 idiomas, y más de 30 libros de Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio y Resaltado Palabra por Palabra';

  @override
  String get wordByWordAudioDescription =>
      'Siga la recitación de audio sincronizada palabra por palabra y el resaltado para una experiencia de aprendizaje inmersiva.';

  @override
  String get ayahAudioRecitationTitle => 'Recitación de Audio de Aleyas';

  @override
  String get ayahAudioRecitationDescription =>
      'Escuche recitaciones completas de aleyas de más de 40 recitadores de renombre.';

  @override
  String get notesCloudBackupTitle => 'Notas con Copia de Seguridad en la Nube';

  @override
  String get notesCloudBackupDescription =>
      'Guarde notas y reflexiones personales, respaldadas de forma segura en la nube (función en desarrollo/próximamente).';

  @override
  String get crossPlatformSupportTitle => 'Soporte Multiplataforma';

  @override
  String get crossPlatformSupportDescription =>
      'Soportado en Android, Web, Linux y Windows.';

  @override
  String get backgroundAudioPlaybackTitle =>
      'Reproducción de Audio en Segundo Plano';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continúe escuchando la recitación del Corán incluso cuando la aplicación está en segundo plano.';

  @override
  String get audioDataCachingTitle => 'Caché de Audio y Datos';

  @override
  String get audioDataCachingDescription =>
      'Reproducción mejorada y capacidades sin conexión con un robusto almacenamiento en caché de audio y datos del Corán.';

  @override
  String get minimalisticInterfaceTitle => 'Interfaz Minimalista y Limpia';

  @override
  String get minimalisticInterfaceDescription =>
      'Interfaz fácil de navegar con enfoque en la experiencia del usuario y la legibilidad.';

  @override
  String get optimizedPerformanceTitle => 'Rendimiento y Tamaño Optimizados';

  @override
  String get optimizedPerformanceDescription =>
      'Una aplicación rica en funciones diseñada para ser ligera y de alto rendimiento.';

  @override
  String get languageSupport => 'Soporte de Idiomas';

  @override
  String get languageSupportDescription =>
      'Esta aplicación está diseñada para ser accesible a una audiencia global con soporte para los siguientes idiomas (y se agregan más continuamente):';

  @override
  String get technologyAndResources => 'Tecnología y Recursos';

  @override
  String get technologyAndResourcesDescription =>
      'Esta aplicación está construida utilizando tecnologías de vanguardia y recursos confiables:';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Construido con Flutter para una experiencia multiplataforma hermosa, compilada nativamente, desde una única base de código.';

  @override
  String get advancedAudioEngineTitle => 'Motor de Audio Avanzado';

  @override
  String get advancedAudioEngineDescription =>
      'Potenciado por los paquetes de Flutter `just_audio` y `just_audio_background` para una reproducción y control de audio robustos.';

  @override
  String get reliableQuranDataTitle => 'Datos Confiables del Corán';

  @override
  String get reliableQuranDataDescription =>
      'Los textos, traducciones, tafsirs y audios de Al Quran provienen de APIs y bases de datos abiertas verificadas como Quran.com y Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Motor de Horarios de Oración';

  @override
  String get prayerTimeEngineDescription =>
      'Utiliza métodos de cálculo establecidos para horarios de oración precisos. Las notificaciones se manejan con `flutter_local_notifications` y tareas en segundo plano.';

  @override
  String get crossPlatformSupport => 'Soporte Multiplataforma';

  @override
  String get crossPlatformSupportDescription2 =>
      'Disfrute de un acceso sin interrupciones en varias plataformas:';

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
  String get ourLifetimePromise => 'Nuestra Promesa de por Vida';

  @override
  String get lifetimePromiseDescription =>
      'Personalmente prometo brindar soporte y mantenimiento continuo para esta aplicación durante toda mi vida, In Sha Allah. Mi objetivo es asegurar que esta aplicación siga siendo un recurso beneficioso para la Ummah en los años venideros.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Amanecer';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Medianoche';

  @override
  String get alarm => 'Alarma';

  @override
  String get notification => 'Notificación';

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
  String get sajdaAyah => 'Aleya de Sayda';

  @override
  String get required => 'Obligatorio';

  @override
  String get optional => 'Opcional';

  @override
  String get notificationScheduleWarning =>
      'Nota: Las notificaciones o recordatorios programados pueden perderse debido a las restricciones de procesos en segundo plano del sistema operativo de su teléfono. Por ejemplo: Origin OS de Vivo, One UI de Samsung, ColorOS de Oppo, etc., a veces eliminan las notificaciones o recordatorios programados. Verifique la configuración de su sistema operativo para que la aplicación no esté restringida de los procesos en segundo plano.';

  @override
  String get scrollWithRecitation => 'Desplazarse con recitación';

  @override
  String get quickAccess => 'Acceso rápido';

  @override
  String get initiallyScrollAyah => 'Desplazarse inicialmente a la aleya';

  @override
  String get tajweedGuide => 'Guía de Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Cuando está habilitado, el ayah del Corán se desplazará automáticamente en sincronía con la recitación de audio.';

  @override
  String get configuration => 'Configuración';

  @override
  String get restoreFromBackup => 'Restaurar desde copia de seguridad';

  @override
  String get history => 'Historia';

  @override
  String get search => 'Buscar';

  @override
  String get useAudioStream => 'Usar transmisión de audio';

  @override
  String get useAudioStreamDesc =>
      'Transmita audio directamente desde Internet en lugar de descargarlo.';

  @override
  String get notUseAudioStreamDesc =>
      'Descargue audio para usarlo sin conexión y reduzca el consumo de datos.';

  @override
  String get audioSettings => 'Configuraciones de audio';

  @override
  String get playbackSpeed => 'Velocidad de reproducción';

  @override
  String get playbackSpeedDesc =>
      'Ajusta la velocidad de la recitación del Corán.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Espere a que finalice la descarga actual.';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get checkYourInternetConnection => 'Revisa tu conexión a internet.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Necesitas descargar $requiredDownload de $totalVersesCount aleyas.';
  }

  @override
  String get download => 'Descargar';

  @override
  String get audioDownload => 'Descarga de audio';
}
