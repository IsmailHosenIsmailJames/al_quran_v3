// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Al Corán en Audio';

  @override
  String get settingsPageTitle => 'Ajustes';

  @override
  String get settingsQuranFontSize => 'Tamaño de fuente del Corán';

  @override
  String get settingsAppTheme => 'Tema de la aplicación';

  @override
  String get settingsAppLanguage => 'Idioma de la aplicación';

  @override
  String get settingsAudioCached => 'Audio en caché';

  @override
  String get audioPageTitle => 'Al Corán en Audio';

  @override
  String get audioPlayerTooltipPlay => 'Reproducir';

  @override
  String get audioPlayerTooltipPause => 'Pausar';

  @override
  String audioPageSurahAyahDisplay(String surahName, String ayahKey) {
    return '$surahName - $ayahKey';
  }

  @override
  String get changeReciterTitle => 'Seleccionar recitador';

  @override
  String reciterStyleLabel(String style) {
    return 'Estilo: $style';
  }

  @override
  String reciterSourceLabel(String source) {
    return 'Fuente: $source';
  }

  @override
  String get reciterMoreInfoLabel => 'Más: ';

  @override
  String get saveButtonLabel => 'Guardar';

  @override
  String get audioSettingsCacheNotFound => 'Caché no encontrado';

  @override
  String get audioSettingsCacheSizeLabel => 'Tamaño del caché';

  @override
  String audioSettingsErrorLabel(String error) {
    return 'Error: $error';
  }

  @override
  String get audioSettingsCleanButtonLabel => 'Limpiar';

  @override
  String get audioSettingsLastModifiedLabel => 'Última modificación';

  @override
  String get timeAgo1Year => 'Hace 1 año';

  @override
  String get timeAgo6Months => 'Hace 6 meses';

  @override
  String get timeAgo3Months => 'Hace 3 meses';

  @override
  String get timeAgo2Months => 'Hace 2 meses';

  @override
  String get timeAgo1Month => 'Hace 1 mes';

  @override
  String get timeAgo3Weeks => 'Hace 3 semanas';

  @override
  String get timeAgo2Weeks => 'Hace 2 semanas';

  @override
  String get timeAgo1Week => 'Hace 1 semana';

  @override
  String get timeAgo6Days => 'Hace 6 días';

  @override
  String get timeAgo5Days => 'Hace 5 días';

  @override
  String get timeAgo4Days => 'Hace 4 días';

  @override
  String get timeAgo3Days => 'Hace 3 días';

  @override
  String get timeAgo2Days => 'Hace 2 días';

  @override
  String get timeAgo1Day => 'Ayer';

  @override
  String get timeToday => 'Hoy';

  @override
  String get drawerVersionLoading => 'Cargando...';

  @override
  String get drawerAppNameSubtitle => 'Al Corán';

  @override
  String get drawerSettingsTitle => 'Ajustes';

  @override
  String get drawerShareAppTitle => 'Compartir esta aplicación';

  @override
  String get drawerShareAppSubject =>
      '¡Echa un vistazo a esta app de Al Corán!';

  @override
  String drawerShareAppBody(String appLink) {
    return '¡Assalamualaikum! Echa un vistazo a esta aplicación de Al Corán para la lectura y reflexión diarias. Ayuda a conectar con las palabras de Alá. Descárgala aquí: $appLink';
  }

  @override
  String get drawerGiveRatingTitle => 'Calificar la aplicación';

  @override
  String get drawerBugReportTitle => 'Informar de un error';

  @override
  String get drawerPrivacyPolicyTitle => 'Política de privacidad';

  @override
  String get bugReportDialogTitle => 'Informar de un error';

  @override
  String get bugReportEmailSubject => 'Informe de error - Al Corán en Audio';

  @override
  String get bugReportEmailBodyDeviceInfo => 'Información del dispositivo:';

  @override
  String get bugReportEmailBodyAppInfo => 'Información de la aplicación:';

  @override
  String get bugReportEmailBodyDescribeBug => 'Describe el error:';

  @override
  String get bugReportEmailBodyToReproduce => 'Pasos para reproducir:';

  @override
  String get bugReportEmailBodyExpectedBehavior => 'Comportamiento esperado:';

  @override
  String get bugReportEmailBodyScreenshots =>
      'Capturas de pantalla (opcional):';

  @override
  String get bugReportOptionEmail => 'Por correo electrónico';

  @override
  String get bugReportOptionDiscord => 'En Discord';

  @override
  String get deviceInfoPlatformWeb => 'Plataforma: Web';

  @override
  String deviceInfoBrowser(String browserName) {
    return 'Navegador: $browserName';
  }

  @override
  String deviceInfoUserAgent(String userAgent) {
    return 'Agente de usuario: $userAgent';
  }

  @override
  String get deviceInfoPlatformAndroid => 'Plataforma: Android';

  @override
  String deviceInfoDevice(String deviceName) {
    return 'Dispositivo: $deviceName';
  }

  @override
  String deviceInfoManufacturer(String manufacturerName) {
    return 'Fabricante: $manufacturerName';
  }

  @override
  String deviceInfoOsVersion(String osVersion) {
    return 'Versión del SO: $osVersion';
  }

  @override
  String deviceInfoSdkVersion(String sdkVersion) {
    return 'Versión del SDK: $sdkVersion';
  }

  @override
  String get deviceInfoPlatformIOS => 'Plataforma: iOS';

  @override
  String deviceInfoModel(String modelName) {
    return 'Modelo: $modelName';
  }

  @override
  String get deviceInfoPlatformLinux => 'Plataforma: Linux';

  @override
  String deviceInfoName(String name) {
    return 'Nombre: $name';
  }

  @override
  String deviceInfoVersion(String version) {
    return 'Versión: $version';
  }

  @override
  String get deviceInfoPlatformMacOS => 'Plataforma: macOS';

  @override
  String get deviceInfoPlatformWindows => 'Plataforma: Windows';

  @override
  String deviceInfoComputerName(String computerName) {
    return 'Nombre del equipo: $computerName';
  }

  @override
  String deviceInfoError(String error) {
    return 'Error al obtener la información del dispositivo: $error';
  }

  @override
  String get deviceInfoUnknownPlatform => 'Plataforma desconocida';

  @override
  String appInfoAppName(String appName) {
    return 'Nombre de la app: $appName';
  }

  @override
  String appInfoPackageName(String packageName) {
    return 'Nombre del paquete: $packageName';
  }

  @override
  String appInfoBuildNumber(String buildNumber) {
    return 'Número de compilación: $buildNumber';
  }

  @override
  String get jumpToAyahDialogTitle => 'Ir a la aleya';

  @override
  String get jumpToAyahSearchSurahHint => 'Buscar una sura';

  @override
  String get jumpToAyahPlayButtonLabel =>
      'Reproducir desde la aleya seleccionada';

  @override
  String get themeIconButtonTooltip => 'Cambiar tema';
}
