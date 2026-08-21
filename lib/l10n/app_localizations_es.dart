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
    return 'El tafsir no está disponible para $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'El tafsir se encuentra en: $anotherAyahLinkKey';
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
  String get languageSettings => 'Configuración de idioma';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count aleyas';
  }

  @override
  String get saveAndDownload => 'Guardar y Descargar';

  @override
  String get appLanguage => 'Idioma de la app';

  @override
  String get selectAppLanguage => 'Selecciona el idioma de la app...';

  @override
  String get pleaseSelectOne => 'Por favor, selecciona uno';

  @override
  String get quranTranslationLanguage => 'Idioma de traducción del Corán';

  @override
  String get selectTranslationLanguage =>
      'Selecciona el idioma de traducción...';

  @override
  String get quranTranslationBook => 'Libro de traducción del Corán';

  @override
  String get selectTranslationBook => 'Selecciona el libro de traducción...';

  @override
  String get quranTafsirLanguage => 'Idioma de tafsir del Corán';

  @override
  String get selectTafsirLanguage => 'Selecciona el idioma de tafsir...';

  @override
  String get quranTafsirBook => 'Libro de tafsir del Corán';

  @override
  String get selectTafsirBook => 'Selecciona el libro de tafsir...';

  @override
  String get quranScriptAndStyle => 'Estilo y script del Corán';

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
      'No se pueden descargar los recursos...\nAlgo salió mal';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Descargando recitación segmentada del Corán';

  @override
  String get processingSegmentedQuranRecitation =>
      'Procesando recitación segmentada del Corán';

  @override
  String get footnote => 'Nota al pie';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Palabra por palabra';

  @override
  String get pleaseSelectRequiredOption =>
      'Por favor, selecciona la opción requerida';

  @override
  String get rememberHomeTab => 'Recordar pestaña de inicio';

  @override
  String get rememberHomeTabSubtitle =>
      'La app recordará la última pestaña abierta en la pantalla de inicio.';

  @override
  String get wakeLock => 'Bloqueo de pantalla';

  @override
  String get wakeLockSubtitle =>
      'Evita que la pantalla se apague automáticamente.';

  @override
  String get settings => 'Configuraciones';

  @override
  String get appTheme => 'Tema de la app';

  @override
  String get quranStyle => 'Estilo del Corán';

  @override
  String get changeTheme => 'Cambiar tema';

  @override
  String get verseCount => 'Número de versos: ';

  @override
  String get translation => 'Traducción';

  @override
  String get tafsirNotFound => 'No encontrado';

  @override
  String get moreInfo => 'más info';

  @override
  String get playAudio => 'Reproducir audio';

  @override
  String get preview => 'Vista previa';

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
  String get selectCalculationMethod => 'Selecciona el método de cálculo';

  @override
  String get shareSelectAyahs => 'Compartir aleyas seleccionadas';

  @override
  String get selectionEmpty => 'Selección vacía';

  @override
  String get generatingImagePleaseWait =>
      'Generando imagen... Por favor espera';

  @override
  String get asImage => 'Como imagen';

  @override
  String get asText => 'Como texto';

  @override
  String get playFromSelectedAyah => 'Reproducir desde la aleya seleccionada';

  @override
  String get toTafsir => 'A tafsir';

  @override
  String get selectAyah => 'Selecciona aleya';

  @override
  String get toAyah => 'A aleya';

  @override
  String get searchForASurah => 'Buscar una sura';

  @override
  String get bugReportTitle => 'Reporte de error';

  @override
  String get audioCached => 'Audio en caché';

  @override
  String get others => 'Otros';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Corán|Traducción|Aleya, uno debe estar activado';

  @override
  String get quranFontSize => 'Tamaño de fuente del Corán';

  @override
  String get quranLineHeight => 'Altura de línea del Corán';

  @override
  String get translationAndTafsirFontSize =>
      'Tamaño de fuente de traducción y tafsir';

  @override
  String get quranAyah => 'Aleya del Corán';

  @override
  String get topToolbar => 'Barra superior';

  @override
  String get keepOpenWordByWord => 'Mantener abierto palabra por palabra';

  @override
  String get wordByWordHighlight => 'Resaltar palabra por palabra';

  @override
  String get quranScriptSettings => 'Configuraciones de script del Corán';

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
      'No se pueden obtener datos de la brújula';

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
  String get calculationMethod => 'Método de cálculo: ';

  @override
  String get downloadPrayerTime => 'Descargar horarios de oración';

  @override
  String get calculationMethodsListEmpty =>
      'La lista de métodos de cálculo está vacía.';

  @override
  String get noCalculationMethodWithLocationData =>
      'No se encontró ningún método de cálculo con datos de ubicación.';

  @override
  String get prayerSettings => 'Configuraciones de oración';

  @override
  String get reminderSettings => 'Configuraciones de recordatorios';

  @override
  String get adjustReminderTime => 'Ajustar tiempo de recordatorio';

  @override
  String get enforceAlarmSound => 'Forzar sonido de alarma';

  @override
  String get enforceAlarmSoundDescription =>
      'Si está activado, esta función reproducirá la alarma al volumen establecido aquí, incluso si el sonido de tu teléfono está bajo. Esto asegura que no te pierdas la alarma por volumen bajo.';

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
    return 'Es hora de $prayerName';
  }

  @override
  String get stopTheAdhan => 'Detener el Adhan';

  @override
  String dateFoundEmpty(String date) {
    return '$date encontrado vacío';
  }

  @override
  String get today => 'Hoy';

  @override
  String get left => 'Restante';

  @override
  String reminderAdded(String prayerName) {
    return 'Recordatorio para $prayerName agregado';
  }

  @override
  String get allowNotificationPermission =>
      'Por favor, permite el permiso de notificaciones para usar esta función';

  @override
  String reminderRemoved(String prayerName) {
    return 'Recordatorio para $prayerName eliminado';
  }

  @override
  String get getPrayerTimesAndQibla => 'Obtener horarios de oración y Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calcula horarios de oración y Qibla para cualquier ubicación dada.';

  @override
  String get getFromGPS => 'Obtener del GPS';

  @override
  String get or => 'O';

  @override
  String get selectYourCity => 'Selecciona tu ciudad';

  @override
  String get noteAboutGPS =>
      'Nota: Si no quieres usar GPS o no te sientes seguro, puedes seleccionar tu ciudad.';

  @override
  String get downloadingLocationResources =>
      'Descargando recursos de ubicación...';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get selectYourCountry => 'Selecciona tu país';

  @override
  String get searchForACountry => 'Buscar un país';

  @override
  String get selectYourAdministrator => 'Selecciona tu administrador';

  @override
  String get searchForAnAdministrator => 'Buscar un administrador';

  @override
  String get searchForACity => 'Buscar una ciudad';

  @override
  String get pleaseEnableLocationService =>
      'Por favor, activa el servicio de ubicación';

  @override
  String get donateUs => 'Donar';

  @override
  String get underDevelopment => 'En desarrollo';

  @override
  String get versionLoading => 'Cargando...';

  @override
  String get alQuran => 'Al Corán';

  @override
  String get mainMenu => 'Menú principal';

  @override
  String get notes => 'Notas';

  @override
  String get pinned => 'Fijados';

  @override
  String get jumpToAyah => 'Ir a aleya';

  @override
  String get shareMultipleAyah => 'Compartir múltiples aleyas';

  @override
  String get shareThisApp => 'Compartir esta app';

  @override
  String get giveRating => 'Dar calificación';

  @override
  String get bugReport => 'Reporte de error';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get aboutTheApp => 'Sobre la app';

  @override
  String get resetTheApp => 'Restablecer la app';

  @override
  String get resetAppWarningTitle => 'Restablecer datos de la app';

  @override
  String get resetAppWarningMessage =>
      '¿Estás seguro de que quieres restablecer la app? Todos tus datos se perderán y tendrás que configurar la app desde el principio.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Restablecer';

  @override
  String get shareAppSubject => '¡Mira esta app de Al Corán!';

  @override
  String shareAppBody(String appLink) {
    return '¡Assalamualaikum! Mira esta app de Al Corán para lectura y reflexión diaria. Ayuda a conectar con las palabras de Allah. Descárgala aquí: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Abrir cajón';

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
  String get linkedAyahs => 'Aleyas vinculadas:';

  @override
  String get emptyNoteCollection =>
      'Esta colección de notas está vacía.\nAgrega algunas notas para verlas aquí.';

  @override
  String get emptyPinnedCollection =>
      'No hay aleyas fijadas en esta colección aún.\nFija aleyas para verlas aquí.';

  @override
  String get noContentAvailable => 'No hay contenido disponible.';

  @override
  String failedToLoadCollections(String error) {
    return 'Error al cargar colecciones: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Buscar por nombre de $collectionType...';
  }

  @override
  String get sortBy => 'Ordenar por';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'No se ha agregado $collectionType aún';
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
  String get emptyNameNotAllowed => 'Nombre vacío no permitido';

  @override
  String updatedTo(String collectionName) {
    return 'Actualizado a $collectionName';
  }

  @override
  String get changeName => 'Cambiar nombre';

  @override
  String get changeColor => 'Cambiar color';

  @override
  String get colorUpdated => 'Color actualizado';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName eliminado';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get collectionNameCannotBeEmpty =>
      'El nombre de la colección no puede estar vacío.';

  @override
  String get addedNewCollection => 'Nueva colección agregada';

  @override
  String ayahCount(int count) {
    return '$count aleya';
  }

  @override
  String get byNameAtoZ => 'Nombre A-Z';

  @override
  String get byNameZtoA => 'Nombre Z-A';

  @override
  String get byElementNumberAscending => 'Número de elemento ascendente';

  @override
  String get byElementNumberDescending => 'Número de elemento descendente';

  @override
  String get byUpdateDateAscending => 'Fecha de actualización ascendente';

  @override
  String get byUpdateDateDescending => 'Fecha de actualización descendente';

  @override
  String get byCreateDateAscending => 'Fecha de creación ascendente';

  @override
  String get byCreateDateDescending => 'Fecha de creación descendente';

  @override
  String get translationNotFound => 'Traducción no encontrada';

  @override
  String get translationTitle => 'Traducción:';

  @override
  String get footNoteTitle => 'Nota al pie:';

  @override
  String get wordByWordTranslation => 'Traducción palabra por palabra:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Compartir';

  @override
  String get addNoteButton => 'Agregar nota';

  @override
  String get pinToCollectionButton => 'Fijar a colección';

  @override
  String get shareAsText => 'Compartir como texto';

  @override
  String get copiedWithTafsir => 'Copiado con tafsir';

  @override
  String get shareAsImage => 'Compartir como imagen';

  @override
  String get shareWithTafsir => 'Compartir con tafsir';

  @override
  String get notFound => 'No encontrado';

  @override
  String get noteContentCannotBeEmpty =>
      'El contenido de la nota no puede estar vacío.';

  @override
  String get noteSavedSuccessfully => '¡Nota guardada con éxito!';

  @override
  String get selectCollections => 'Selecciona colecciones';

  @override
  String get addNote => 'Agregar nota';

  @override
  String get writeCollectionName => 'Escribe el nombre de la colección...';

  @override
  String get noCollectionsYetAddANewOne =>
      'No hay colecciones aún. ¡Agrega una nueva!';

  @override
  String get pleaseWriteYourNoteFirst => 'Por favor, escribe tu nota primero.';

  @override
  String get noCollectionSelected => 'No se seleccionó colección';

  @override
  String get saveNote => 'Guardar nota';

  @override
  String get nextSelectCollections => 'Siguiente: Selecciona colecciones';

  @override
  String get addToPinned => 'Agregar a fijados';

  @override
  String get pinnedSavedSuccessfully => '¡Fijado guardado con éxito!';

  @override
  String get savePinned => 'Guardar fijado';

  @override
  String get closeAudioController => 'Cerrar controlador de audio';

  @override
  String get previous => 'Anterior';

  @override
  String get rewind => 'Rebobinar';

  @override
  String get fastForward => 'Avanzar rápido';

  @override
  String get playNextAyah => 'Reproducir siguiente aleya';

  @override
  String get repeat => 'Repetir';

  @override
  String get playAsPlaylist => 'Reproducir como lista';

  @override
  String style(String style) {
    return 'Estilo: $style';
  }

  @override
  String get stopAndClose => 'Detener y cerrar';

  @override
  String get play => 'Reproducir';

  @override
  String get pause => 'Pausar';

  @override
  String get selectReciter => 'Selecciona recitador';

  @override
  String source(String source) {
    return 'Fuente: $source';
  }

  @override
  String get newText => 'Nuevo';

  @override
  String get more => 'Más: ';

  @override
  String get cacheNotFound => 'Caché no encontrado';

  @override
  String get cacheSize => 'Tamaño de caché';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get clean => 'Limpiar';

  @override
  String get lastModified => 'Última modificación';

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
  String get aboutAlQuran => 'Sobre Al Corán';

  @override
  String get appFullName => 'Al Corán (Tafsir, Oración, Qibla, Audio)';

  @override
  String get appDescription =>
      'Una aplicación islámica completa para Android, iOS, MacOS, Web, Linux y Windows, que ofrece lectura del Corán con tafsir y múltiples traducciones (incluyendo palabra por palabra), horarios de oración mundiales con notificaciones, brújula Qibla y recitación de audio sincronizada palabra por palabra.';

  @override
  String get dataSourcesNote =>
      'Nota: Los textos del Corán, tafsir, traducciones y recursos de audio provienen de Quran.com, Everyayah.com y otras fuentes abiertas verificadas.';

  @override
  String get adFreePromise =>
      'Esta app se ha creado para buscar el placer de Allah. Por lo tanto, es y siempre será completamente libre de anuncios.';

  @override
  String get coreFeatures => 'Funciones principales';

  @override
  String get coreFeaturesDescription =>
      'Explora las funcionalidades clave que hacen de Al Corán v3 una herramienta indispensable para tus prácticas islámicas diarias:';

  @override
  String get prayerTimesTitle => 'Horarios de oración y alertas';

  @override
  String get prayerTimesDescription =>
      'Horarios de oración precisos para cualquier ubicación mundial usando varios métodos de cálculo. Configura recordatorios con notificaciones de Adhan.';

  @override
  String get qiblaDirectionTitle => 'Dirección Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Encuentra fácilmente la dirección Qibla con una vista de brújula clara y precisa.';

  @override
  String get translationTafsirTitle => 'Traducción y tafsir del Corán';

  @override
  String get translationTafsirDescription =>
      'Accede a más de 120 libros de traducción (incluyendo palabra por palabra) en 69 idiomas y más de 30 libros de tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio y resaltado palabra por palabra';

  @override
  String get wordByWordAudioDescription =>
      'Sigue con recitación de audio sincronizada palabra por palabra y resaltado para una experiencia de aprendizaje inmersiva.';

  @override
  String get ayahAudioRecitationTitle => 'Recitación de audio de aleya';

  @override
  String get ayahAudioRecitationDescription =>
      'Escucha recitaciones completas de aleyas de más de 40 recitadores renombrados.';

  @override
  String get notesCloudBackupTitle => 'Notas con respaldo en la nube';

  @override
  String get notesCloudBackupDescription =>
      'Guarda notas y reflexiones personales, respaldadas de forma segura en la nube (función en desarrollo/próximamente).';

  @override
  String get crossPlatformSupportTitle => 'Soporte multiplataforma';

  @override
  String get crossPlatformSupportDescription =>
      'Soportado en Android, Web, Linux y Windows.';

  @override
  String get backgroundAudioPlaybackTitle =>
      'Reproducción de audio en segundo plano';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continúa escuchando la recitación del Corán incluso cuando la app está en segundo plano.';

  @override
  String get audioDataCachingTitle => 'Caché de audio y datos';

  @override
  String get audioDataCachingDescription =>
      'Mejora la reproducción y capacidades offline con caché robusto de audio y datos del Corán.';

  @override
  String get minimalisticInterfaceTitle => 'Interfaz minimalista y limpia';

  @override
  String get minimalisticInterfaceDescription =>
      'Interfaz fácil de navegar con enfoque en la experiencia del usuario y legibilidad.';

  @override
  String get optimizedPerformanceTitle => 'Rendimiento y tamaño optimizados';

  @override
  String get optimizedPerformanceDescription =>
      'Una aplicación rica en funciones diseñada para ser ligera y de alto rendimiento.';

  @override
  String get languageSupport => 'Soporte de idiomas';

  @override
  String get languageSupportDescription =>
      'Esta aplicación está diseñada para ser accesible a una audiencia global con soporte para los siguientes idiomas (y se agregan más continuamente):';

  @override
  String get technologyAndResources => 'Tecnología y recursos';

  @override
  String get technologyAndResourcesDescription =>
      'Esta app se construye usando tecnologías de vanguardia y recursos confiables:';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Construida con Flutter para una experiencia hermosa, compilada nativamente y multiplataforma desde un solo código base.';

  @override
  String get advancedAudioEngineTitle => 'Motor de audio avanzado';

  @override
  String get advancedAudioEngineDescription =>
      'Impulsado por los paquetes Flutter `just_audio` y `just_audio_background` para reproducción y control de audio robustos.';

  @override
  String get reliableQuranDataTitle => 'Datos del Corán confiables';

  @override
  String get reliableQuranDataDescription =>
      'Textos del Corán, traducciones, tafsirs y audio provienen de APIs abiertas verificadas y bases de datos como Quran.com y Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Motor de horarios de oración';

  @override
  String get prayerTimeEngineDescription =>
      'Utiliza métodos de cálculo establecidos para horarios de oración precisos. Notificaciones manejadas por `flutter_local_notifications` y tareas en segundo plano.';

  @override
  String get crossPlatformSupport => 'Soporte multiplataforma';

  @override
  String get crossPlatformSupportDescription2 =>
      'Disfruta de acceso fluido en varias plataformas:';

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
  String get ourLifetimePromise => 'Nuestra promesa de por vida';

  @override
  String get lifetimePromiseDescription =>
      'Prometo personalmente proporcionar soporte y mantenimiento continuo para esta aplicación durante toda mi vida, In Sha Allah. Mi objetivo es asegurar que esta app siga siendo un recurso beneficioso para la Ummah por años.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Amanecer';

  @override
  String get noon => 'Mediodía';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Atardecer';

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
  String get sajdaAyah => 'Aleya de sajda';

  @override
  String get required => 'Requerido';

  @override
  String get optional => 'Opcional';

  @override
  String get notificationScheduleWarning =>
      'Nota: La notificación programada o recordatorio puede fallar debido a restricciones del proceso en segundo plano de tu teléfono. Por ejemplo: Origin OS de Vivo, One UI de Samsung, ColorOS de Oppo a veces eliminan notificaciones o recordatorios programados. Por favor, revisa la configuración de tu OS para que la app no esté restringida en procesos en segundo plano.';

  @override
  String get scrollWithRecitation => 'Desplazar con recitación';

  @override
  String get quickAccess => 'Acceso rápido';

  @override
  String get initiallyScrollAyah => 'Desplazar inicialmente a aleya';

  @override
  String get tajweedGuide => 'Guía de tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Cuando está activado, la aleya del Corán se desplazará automáticamente en sincronía con la recitación de audio.';

  @override
  String get configuration => 'Configuración';

  @override
  String get restoreFromBackup => 'Restaurar desde respaldo';

  @override
  String get history => 'Historial';

  @override
  String get search => 'Buscar';

  @override
  String get useAudioStream => 'Usar transmisión de audio';

  @override
  String get useAudioStreamDesc =>
      'Transmite audio directamente desde internet en lugar de descargar.';

  @override
  String get notUseAudioStreamDesc =>
      'Descarga audio para uso offline y reduce el consumo de datos.';

  @override
  String get audioSettings => 'Configuraciones de audio';

  @override
  String get playbackSpeed => 'Velocidad de reproducción';

  @override
  String get playbackSpeedDesc =>
      'Ajusta la velocidad de la recitación del Corán.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Por favor, espera a que termine la descarga actual.';

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

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Optimizando script del Corán';

  @override
  String get supportOnGithub => 'Apoyar en GitHub';

  @override
  String get forbiddenSalatTimes => 'Horarios de oración prohibidos';

  @override
  String get prayerTimes => 'Horarios de oración';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafi\'i';

  @override
  String get suhurEnd => 'Fin de Suhur';

  @override
  String get iftarStart => 'Inicio de Iftar';

  @override
  String get tahajjudStart => 'Inicio de Tahajjud';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';

  @override
  String get indopakFont => 'Fuente Indopak';

  @override
  String get uthmaniFont => 'Fuente Uzmaní';

  @override
  String get close => 'Cerrar';

  @override
  String get goToSettings => 'Ir a ajustes';

  @override
  String get scriptSettingsUpdated => 'Ajustes de script actualizados';

  @override
  String get scriptSettingsUpdatedDescription =>
      'Hemos simplificado nuestras opciones de script y añadido más fuentes.';

  @override
  String get enterPageNumber => 'Introduce un número de página entre 1 y 604';

  @override
  String get deleteMushafData => 'Eliminar datos del Mushaf';

  @override
  String get deleteMushafDataDescription =>
      '¿Estás seguro de que quieres eliminar todos los datos del Mushaf?';

  @override
  String get invalidPage => 'Página no válida (1-604)';

  @override
  String get goToPage => 'Ir a la página';

  @override
  String get resources => 'Recursos';

  @override
  String get mushaf => 'Mushaf';

  @override
  String get circleJojomInQuranScript =>
      'Círculo Jojom/Sukun en la escritura del Corán';

  @override
  String get copy => 'Copiar';

  @override
  String get share => 'Compartir';

  @override
  String get warningMessageOnIndopakTajweedEnable =>
      'Hemos encontrado algunos problemas de renderizado en el color del tajweed Indopak en algunas fuentes. Por lo tanto, podrías ver inconsistencias en el renderizado del color de la escritura. ¿Estás seguro de que quieres aplicar tajweed en Indopak?';

  @override
  String get apply => 'Aplicar';

  @override
  String get warning => 'Advertencia';

  @override
  String get hijri => 'Hégira';

  @override
  String get gregorian => 'Gregoriano';

  @override
  String get prayerTimesCalender => 'Calendario de Tiempos de Oración';

  @override
  String get allowLocation => 'Permitir ubicación';

  @override
  String get allowLocationDescription =>
      'Actualiza automáticamente los tiempos de oración.';

  @override
  String get manualLocation => 'Ubicación manual';

  @override
  String get manualLocationDescription =>
      'Seleccione manualmente el país y la ciudad. Necesita actualizar la ubicación si cambia de ciudad.';

  @override
  String get selectLocation => 'Seleccionar ubicación';

  @override
  String get selectCountry => 'Seleccionar país';

  @override
  String get selectCity => 'Seleccionar ciudad';

  @override
  String get sunRising => 'Salida del sol';

  @override
  String get sunSetting => 'Puesta del sol';

  @override
  String get sunTopOfTheHead => 'Sol en el cenit';

  @override
  String get salatTime => 'Tiempo de Oración';

  @override
  String get forbiddenSalatTime => 'Tiempo de oración prohibido';

  @override
  String get translationDatabase => 'Base de datos de traducción';

  @override
  String get translationDatabaseSubtitle =>
      'Descargando el texto de traducción seleccionado';

  @override
  String get tafsirCommentary => 'Comentario de Tafsir';

  @override
  String get tafsirCommentarySubtitle => 'Preparando recursos de tafsir';

  @override
  String get wordByWordAnalysis => 'Análisis palabra por palabra';

  @override
  String get wordByWordAnalysisSubtitle =>
      'Configurando el desglose del vocabulario';

  @override
  String get audioRecitationSegments => 'Segmentos de recitación de audio';

  @override
  String get audioRecitationSegmentsSubtitle =>
      'Configurando los segmentos de tiempo de las aleyas';

  @override
  String get locationQiblaMetadata => 'Metadatos de ubicación y Quibla';

  @override
  String get locationQiblaMetadataSubtitle =>
      'Descargando datos de ubicación de ciudades globales';

  @override
  String get preparingResources => 'Preparando recursos...';

  @override
  String get setupCompletedOpeningQuran =>
      '¡Configuración completada! Abriendo Al-Corán...';

  @override
  String get unexpectedErrorSetup =>
      'Ocurrió un error inesperado durante la configuración.';

  @override
  String get heading => 'Rumbo';

  @override
  String get alignedWithKaaba => 'Alineado con la Kaaba';

  @override
  String turnRight(Object degrees) {
    return 'Gira $degrees° a la derecha';
  }

  @override
  String turnLeft(Object degrees) {
    return 'Gira $degrees° a la izquierda';
  }

  @override
  String get streamingAndNetwork => 'Transmisión y red';

  @override
  String get next => 'Siguiente';

  @override
  String get now => 'Ahora';

  @override
  String get current => 'Actual';

  @override
  String get active => 'Activo';

  @override
  String get activeNow => 'Activo ahora';

  @override
  String get hours => 'Horas';

  @override
  String get minutes => 'Minutos';

  @override
  String get seconds => 'Segundos';

  @override
  String get fastingAndVoluntaryTimes =>
      'Horarios de ayuno y oraciones voluntarias';

  @override
  String get imsak => 'Imsak';

  @override
  String get ishraqAndDuha => 'Ishraq y Duha';

  @override
  String get lastThirdOfNight => 'Último tercio de la noche';

  @override
  String get awqatAlNahy => 'Tiempos prohibidos de oración (Awqat al-Nahy)';

  @override
  String get forbiddenSunriseDescription =>
      'Desde la salida del sol hasta que se eleva la altura de una lanza (~15 min)';

  @override
  String get forbiddenNoonDescription =>
      'Cuando el sol está en el cenit hasta el inicio de Dhuhr (~8 min)';

  @override
  String get forbiddenSunsetDescription =>
      'Cuando el sol se pone amarillento hasta la puesta total (~15 min)';

  @override
  String get forbiddenTimesHadith =>
      'According to authentic Hadith in Sahih Muslim (832), \'Uqbah ibn \'Amir al-Juhani said:\n\n\"There are three times at which the Messenger of Allah (peace and blessings be upon him) forbade us to pray or to bury our dead:\n1. When the sun begins to rise until it is fully risen (~15 mins after sunrise).\n2. When the sun is at its height at midday until it has passed the meridian (~8-10 mins before Dhuhr).\n3. When the sun begins to set until it has completely set (~15 mins before Maghrib).\"';

  @override
  String get readMoreOnIslamQA => 'Leer fatwa completa en IslamQA';

  @override
  String get asrJurisprudence => 'Jurisprudencia de Asr (Madhab)';

  @override
  String get shafieDescription => 'Estándar (Shafi\'i, Maliki, Hanbali)';

  @override
  String get hanafiDescription => 'Escuela Hanafí';

  @override
  String get shafieShadow => 'Estándar (Sombra 1x)';

  @override
  String get hanafiShadow => 'Hanafí (Sombra 2x)';

  @override
  String get calculationAndJurisprudence => 'Cálculo y Jurisprudencia';

  @override
  String get notificationsAndAudio => 'Notificaciones y Audio';

  @override
  String get enablePrayerReminders => 'Activar recordatorios de oración';

  @override
  String get enablePrayerRemindersDescription =>
      'Reciba alertas para todas las próximas oraciones.';

  @override
  String get adjustReminderTimingDescription =>
      'Ajustar el tiempo del recordatorio (+/- minutos de la hora real).';

  @override
  String get exactTime => 'Hora exacta';

  @override
  String actualTime(String time) {
    return 'Hora real: $time';
  }

  @override
  String get jumpToToday => 'Ir a hoy';

  @override
  String get dateAndHijri => 'Fecha / Hiyri';

  @override
  String get selectedLocation => 'Ubicación seleccionada';

  @override
  String nextPrayerLabel(String prayerName) {
    return 'Siguiente: $prayerName';
  }

  @override
  String currentPrayerLabel(String prayerName) {
    return 'Ahora: $prayerName';
  }

  @override
  String startsAt(String prayerName, String time) {
    return '$prayerName comienza a las $time';
  }

  @override
  String get continueReading => 'Continuar leyendo';

  @override
  String get lastRead => 'Última lectura';

  @override
  String get resume => 'Reanudar';

  @override
  String get startReading => 'Empezar a leer';

  @override
  String get verses => 'Versículos';

  @override
  String get ayah => 'Versículo';

  @override
  String get edit => 'Editar';

  @override
  String get searchAll => 'Todos';

  @override
  String get searchArabic => 'Árabe';

  @override
  String get searchQuranHint => 'Buscar Corán, Sura, 2:255, Traducción...';

  @override
  String get searchFiltersAndOptions => 'Filtros y opciones de búsqueda';

  @override
  String get exactPhrase => 'Frase exacta';

  @override
  String surahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count suras encontradas',
      one: '1 sura encontrada',
    );
    return '$_temp0';
  }

  @override
  String ayahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versículos encontrados',
      one: '1 versículo encontrado',
    );
    return '$_temp0';
  }

  @override
  String noMatchingSurahs(String query) {
    return 'No hay suras que coincidan con \"$query\"';
  }

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String get trySearchingFor =>
      'Intente buscar un nombre de sura, número de versículo (ej. 2:255) o temas';

  @override
  String allSurahsCount(int count) {
    return 'Todas las suras ($count)';
  }

  @override
  String activeShortcutsCount(int count) {
    return 'Accesos directos activos ($count)';
  }

  @override
  String get noActiveShortcuts => 'No se encontraron accesos directos activos';

  @override
  String get customize => 'Personalizar';

  @override
  String get bismillahPreview => 'Vista previa de Bismillah';

  @override
  String get tajweedRules => 'Reglas de Tajweed';

  @override
  String get makki => 'Mequí';

  @override
  String get madani => 'Mediní';

  @override
  String get exactPhraseMatch => 'Coincidencia exacta de frase';

  @override
  String get matchExactWordsDesc =>
      'Coincidir palabras exactas en secuencia continua';

  @override
  String get filterBySurah => 'Filtrar por sura';

  @override
  String get all114SurahsEntireQuran => 'Las 114 suras (Corán completo)';

  @override
  String get revelationType => 'Lugar de revelación';

  @override
  String get searchInTranslations => 'Buscar en traducciones';

  @override
  String get searchInTafsirs => 'Buscar en tafsires';

  @override
  String activeCount(int selected, int total) {
    return '$selected/$total activo(s)';
  }

  @override
  String get recentSearches => 'Búsquedas recientes';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get searchGuideTitle => 'Buscar en el Sagrado Corán';

  @override
  String get searchGuideDescription =>
      'Busque por nombre de sura, referencia de versículo (ej. 2:255) o palabras en traducciones y tafsir.';

  @override
  String get madani15Line => 'Madani de 15 líneas';

  @override
  String get totalPagesCount => '604 Páginas';

  @override
  String get wordAudio => 'Audio palabra por palabra';

  @override
  String get offlineReady => 'Listo sin conexión';

  @override
  String get vectorFonts => 'Fuentes vectoriales';

  @override
  String get madaniMushafLayout => 'Diseño del Mushaf Madani';

  @override
  String get kfgqpcDescription =>
      'Complejo del Rey Fahd para la impresión del Corán (V4)';

  @override
  String get downloadingMushafPackage => 'Descargando paquete de Mushaf...';

  @override
  String get extractingAndInstallingData => 'Extrayendo e instalando datos...';

  @override
  String get settingUpOfflinePages => 'Configurando páginas sin conexión...';

  @override
  String get fetchingLayoutArchive => 'Obteniendo archivo de diseño...';

  @override
  String get keepAppOpenDuringDownload =>
      'Por favor, mantenga la aplicación abierta mientras se completa la descarga.';

  @override
  String get downloadFailed => 'Error en la descarga';

  @override
  String get retryDownload => 'Reintentar descarga';

  @override
  String get packageSize => 'Tamaño del paquete';

  @override
  String get loadingMushafPage => 'Cargando página del Mushaf...';

  @override
  String get quickPageJump => 'Salto rápido de página';

  @override
  String get searchSurahHint => 'Buscar sura por nombre o número...';

  @override
  String get fullscreen => 'Pantalla completa';

  @override
  String get back => 'Atrás';

  @override
  String get script => 'Escritura';

  @override
  String get muted => 'Silenciado';

  @override
  String get alerts => 'Alertas';

  @override
  String get off => 'Desactivado';

  @override
  String get on => 'Activado';

  @override
  String get homeAndLockWidgets => 'Widgets de inicio y bloqueo';

  @override
  String get glanceableWidgets => 'Widgets de un vistazo';

  @override
  String get glanceableWidgetsDesc =>
      'Muestra versículos diarios y horarios de oración en tu pantalla de inicio y bloqueo.';

  @override
  String get ayahWidgetDisplayMode =>
      'Modo de visualización del widget de versículo';

  @override
  String get dailyInspiringAyah => 'Versículo inspirador diario (Seleccionado)';

  @override
  String get dailyInspiringAyahDesc =>
      'Cambia cada día a medianoche con más de 365 versículos profundos seleccionados.';

  @override
  String get lastReadAyah => 'Último versículo leído';

  @override
  String get lastReadAyahDesc =>
      'Se sincroniza con tu última posición de lectura para continuar con un toque.';

  @override
  String get pinnedCustomVerse => 'Versículo personalizado fijado';

  @override
  String get randomDailyAyah => 'Versículo diario aleatorio';

  @override
  String get randomDailyAyahDesc =>
      'Elige un versículo aleatorio cada día para una nueva reflexión.';

  @override
  String get updateAllWidgetsNow => 'Actualizar todos los widgets ahora';

  @override
  String get widgetsUpdatedSuccessfully => '¡Widgets actualizados con éxito!';

  @override
  String get ayahPinnedToWidgets =>
      '¡Versículo fijado en los widgets de inicio y bloqueo!';

  @override
  String get pinToWidgets => 'Fijar en widgets';

  @override
  String get selectPinnedAyah => 'Seleccionar versículo para fijar';

  @override
  String get saveAndApplyToWidget => 'Guardar y aplicar al widget';

  @override
  String get howToAddWidgets => 'Cómo agregar widgets';

  @override
  String get customizeWidgetAyahAndPrayers =>
      'Personalizar versículo y oraciones del widget';

  @override
  String get customizeWidgetAyahAndPrayersDesc =>
      'Elige entre versículos seleccionados diarios, último leído o versículos fijados';
}
