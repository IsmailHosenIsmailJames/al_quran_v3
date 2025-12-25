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
  String get saveAndDownload => 'Guardar y descargar';

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
