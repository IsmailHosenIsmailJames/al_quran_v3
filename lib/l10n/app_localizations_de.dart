// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
    return 'Für $ayahKey ist kein Tafsir verfügbar';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Tafsir befindet sich bei: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Springe zu $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Seite';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Spracheinstellungen';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Verse';
  }

  @override
  String get saveAndDownload => 'Speichern und Herunterladen';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get selectAppLanguage => 'App-Sprache auswählen...';

  @override
  String get pleaseSelectOne => 'Bitte wähle eine Option';

  @override
  String get quranTranslationLanguage => 'Sprache der Koranübersetzung';

  @override
  String get selectTranslationLanguage => 'Übersetzungssprache auswählen...';

  @override
  String get quranTranslationBook => 'Koran-Übersetzungsbuch';

  @override
  String get selectTranslationBook => 'Übersetzungsbuch auswählen...';

  @override
  String get quranTafsirLanguage => 'Sprache des Tafsir';

  @override
  String get selectTafsirLanguage => 'Tafsir-Sprache auswählen...';

  @override
  String get quranTafsirBook => 'Tafsir-Buch';

  @override
  String get selectTafsirBook => 'Tafsir-Buch auswählen...';

  @override
  String get quranScriptAndStyle => 'Koranschrift & Stil';

  @override
  String get justAMoment => 'Einen Moment bitte...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Erfolgreich';

  @override
  String get retry => 'Wiederholen';

  @override
  String get unableToDownloadResources =>
      'Ressourcen konnten nicht heruntergeladen werden...\nEtwas ist schiefgelaufen';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Segmentierte Koranrezitation wird heruntergeladen';

  @override
  String get processingSegmentedQuranRecitation =>
      'Segmentierte Koranrezitation wird verarbeitet';

  @override
  String get footnote => 'Fußnote';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Wort für Wort';

  @override
  String get pleaseSelectRequiredOption =>
      'Bitte wähle die erforderliche Option aus';

  @override
  String get rememberHomeTab => 'Start-Tab merken';

  @override
  String get rememberHomeTabSubtitle =>
      'Die App merkt sich den zuletzt geöffneten Tab auf dem Startbildschirm.';

  @override
  String get wakeLock => 'Bildschirm aktiv lassen';

  @override
  String get wakeLockSubtitle =>
      'Verhindert, dass sich der Bildschirm automatisch ausschaltet.';

  @override
  String get settings => 'Einstellungen';

  @override
  String get appTheme => 'App-Design';

  @override
  String get quranStyle => 'Koran-Stil';

  @override
  String get changeTheme => 'Design ändern';

  @override
  String get verseCount => 'Anzahl der Verse: ';

  @override
  String get translation => 'Übersetzung';

  @override
  String get tafsirNotFound => 'Nicht gefunden';

  @override
  String get moreInfo => 'mehr Infos';

  @override
  String get playAudio => 'Audio abspielen';

  @override
  String get preview => 'Vorschau';

  @override
  String get loading => 'Lädt...';

  @override
  String get errorFetchingAddress => 'Fehler beim Abrufen der Adresse';

  @override
  String get addressNotAvailable => 'Adresse nicht verfügbar';

  @override
  String get latitude => 'Breitengrad: ';

  @override
  String get longitude => 'Längengrad: ';

  @override
  String get name => 'Name: ';

  @override
  String get location => 'Standort: ';

  @override
  String get parameters => 'Parameter: ';

  @override
  String get selectCalculationMethod => 'Berechnungsmethode auswählen';

  @override
  String get shareSelectAyahs => 'Ausgewählte Verse teilen';

  @override
  String get selectionEmpty => 'Auswahl leer';

  @override
  String get generatingImagePleaseWait => 'Bild wird erstellt... Bitte warten';

  @override
  String get asImage => 'Als Bild';

  @override
  String get asText => 'Als Text';

  @override
  String get playFromSelectedAyah => 'Ab ausgewähltem Vers abspielen';

  @override
  String get toTafsir => 'Zum Tafsir';

  @override
  String get selectAyah => 'Vers auswählen';

  @override
  String get toAyah => 'Zum Vers';

  @override
  String get searchForASurah => 'Suche eine Sure';

  @override
  String get bugReportTitle => 'Fehlerbericht';

  @override
  String get audioCached => 'Audio zwischengespeichert';

  @override
  String get others => 'Andere';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Koran|Übersetzung|Aya, eine Option muss aktiviert sein';

  @override
  String get quranFontSize => 'Schriftgröße des Korans';

  @override
  String get quranLineHeight => 'Zeilenhöhe des Korans';

  @override
  String get translationAndTafsirFontSize =>
      'Schriftgröße für Übersetzung & Tafsir';

  @override
  String get quranAyah => 'Koranvers';

  @override
  String get topToolbar => 'Obere Werkzeugleiste';

  @override
  String get keepOpenWordByWord => 'Wort-für-Wort-Ansicht geöffnet lassen';

  @override
  String get wordByWordHighlight => 'Wort-für-Wort-Hervorhebung';

  @override
  String get quranScriptSettings => 'Einstellungen zur Koranschrift';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Seite: ';

  @override
  String get quranResources => 'Koran-Ressourcen';

  @override
  String alreadySelected(String name) {
    return 'Sprache \'$name\' ist bereits ausgewählt.';
  }

  @override
  String get unableToGetCompassData =>
      'Kompassdaten konnten nicht abgerufen werden';

  @override
  String get deviceDoesNotHaveSensors => 'Gerät hat keine Sensoren!';

  @override
  String get north => 'N';

  @override
  String get east => 'O';

  @override
  String get south => 'S';

  @override
  String get west => 'W';

  @override
  String get address => 'Adresse: ';

  @override
  String get change => 'Ändern';

  @override
  String get calculationMethod => 'Berechnungsmethode: ';

  @override
  String get downloadPrayerTime => 'Gebetszeiten herunterladen';

  @override
  String get calculationMethodsListEmpty =>
      'Die Liste der Berechnungsmethoden ist leer.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Keine Berechnungsmethode mit Standortdaten gefunden.';

  @override
  String get prayerSettings => 'Gebetseinstellungen';

  @override
  String get reminderSettings => 'Erinnerungseinstellungen';

  @override
  String get adjustReminderTime => 'Erinnerungszeit anpassen';

  @override
  String get enforceAlarmSound => 'Alarmton erzwingen';

  @override
  String get enforceAlarmSoundDescription =>
      'Wenn aktiviert, wird der Alarm mit der hier eingestellten Lautstärke abgespielt, auch wenn die Lautstärke deines Telefons niedrig ist. Dies stellt sicher, dass du den Alarm nicht aufgrund geringer Telefonlautstärke verpasst.';

  @override
  String get volume => 'Lautstärke';

  @override
  String get atPrayerTime => 'Zur Gebetszeit';

  @override
  String minBefore(int minutes) {
    return '$minutes Min. vorher';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes Min. nachher';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName ist um $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'Es ist Zeit für $prayerName';
  }

  @override
  String get stopTheAdhan => 'Adhan stoppen';

  @override
  String dateFoundEmpty(String date) {
    return '$date leer gefunden';
  }

  @override
  String get today => 'Heute';

  @override
  String get left => 'Verbleibend';

  @override
  String reminderAdded(String prayerName) {
    return 'Erinnerung für $prayerName hinzugefügt';
  }

  @override
  String get allowNotificationPermission =>
      'Bitte erlaube Benachrichtigungen, um diese Funktion zu nutzen';

  @override
  String reminderRemoved(String prayerName) {
    return 'Erinnerung für $prayerName entfernt';
  }

  @override
  String get getPrayerTimesAndQibla => 'Gebetszeiten und Qibla abrufen';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Berechne Gebetszeiten und Qibla für jeden beliebigen Ort.';

  @override
  String get getFromGPS => 'Von GPS abrufen';

  @override
  String get or => 'Oder';

  @override
  String get selectYourCity => 'Wähle deine Stadt';

  @override
  String get noteAboutGPS =>
      'Hinweis: Wenn du kein GPS verwenden möchtest oder dich nicht sicher fühlst, kannst du deine Stadt auswählen.';

  @override
  String get downloadingLocationResources =>
      'Standort-Ressourcen werden heruntergeladen...';

  @override
  String get somethingWentWrong => 'Etwas ist schiefgelaufen';

  @override
  String get selectYourCountry => 'Wähle dein Land';

  @override
  String get searchForACountry => 'Suche ein Land';

  @override
  String get selectYourAdministrator => 'Wähle dein Bundesland';

  @override
  String get searchForAnAdministrator => 'Suche ein Bundesland';

  @override
  String get searchForACity => 'Suche eine Stadt';

  @override
  String get pleaseEnableLocationService =>
      'Bitte aktiviere die Standortermittlung';

  @override
  String get donateUs => 'Spende für uns';

  @override
  String get underDevelopment => 'In Entwicklung';

  @override
  String get versionLoading => 'Lädt...';

  @override
  String get alQuran => 'Al-Quran';

  @override
  String get mainMenu => 'Hauptmenü';

  @override
  String get notes => 'Notizen';

  @override
  String get pinned => 'Gepinnt';

  @override
  String get jumpToAyah => 'Springe zu Vers';

  @override
  String get shareMultipleAyah => 'Mehrere Verse teilen';

  @override
  String get shareThisApp => 'Diese App teilen';

  @override
  String get giveRating => 'Bewertung abgeben';

  @override
  String get bugReport => 'Fehler melden';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get aboutTheApp => 'Über die App';

  @override
  String get resetTheApp => 'App zurücksetzen';

  @override
  String get resetAppWarningTitle => 'App-Daten zurücksetzen';

  @override
  String get resetAppWarningMessage =>
      'Bist du sicher, dass du die App zurücksetzen möchtest? Alle deine Daten gehen verloren und du musst die App von Anfang an neu einrichten.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get shareAppSubject => 'Schau dir diese Al-Quran-App an!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Schau dir diese Al-Quran-App zum täglichen Lesen und Nachdenken an. Sie hilft, sich mit den Worten Allahs zu verbinden. Lade sie hier herunter: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Menü öffnen';

  @override
  String get quran => 'Koran';

  @override
  String get prayer => 'Gebet';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Sure';

  @override
  String get pages => 'Seiten';

  @override
  String get note => 'Notiz:';

  @override
  String get linkedAyahs => 'Verlinkte Verse:';

  @override
  String get emptyNoteCollection =>
      'Diese Notizsammlung ist leer.\nFüge Notizen hinzu, um sie hier zu sehen.';

  @override
  String get emptyPinnedCollection =>
      'Noch keine Verse an diese Sammlung angeheftet.\nHeften Sie Verse an, um sie hier zu sehen.';

  @override
  String get noContentAvailable => 'Kein Inhalt verfügbar.';

  @override
  String failedToLoadCollections(String error) {
    return 'Sammlungen konnten nicht geladen werden: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Nach $collectionType-Name suchen...';
  }

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Noch keine $collectionType hinzugefügt';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count gepinnte Elemente';
  }

  @override
  String notesCount(int count) {
    return '$count Notizen';
  }

  @override
  String get emptyNameNotAllowed => 'Leerer Name nicht erlaubt';

  @override
  String updatedTo(String collectionName) {
    return 'Aktualisiert zu $collectionName';
  }

  @override
  String get changeName => 'Namen ändern';

  @override
  String get changeColor => 'Farbe ändern';

  @override
  String get colorUpdated => 'Farbe aktualisiert';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName gelöscht';
  }

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get collectionNameCannotBeEmpty =>
      'Der Sammlungsname darf nicht leer sein.';

  @override
  String get addedNewCollection => 'Neue Sammlung hinzugefügt';

  @override
  String ayahCount(int count) {
    return '$count Vers';
  }

  @override
  String get byNameAtoZ => 'Name A-Z';

  @override
  String get byNameZtoA => 'Name Z-A';

  @override
  String get byElementNumberAscending => 'Anzahl der Elemente aufsteigend';

  @override
  String get byElementNumberDescending => 'Anzahl der Elemente absteigend';

  @override
  String get byUpdateDateAscending => 'Aktualisierungsdatum aufsteigend';

  @override
  String get byUpdateDateDescending => 'Aktualisierungsdatum absteigend';

  @override
  String get byCreateDateAscending => 'Erstellungsdatum aufsteigend';

  @override
  String get byCreateDateDescending => 'Erstellungsdatum absteigend';

  @override
  String get translationNotFound => 'Übersetzung nicht gefunden';

  @override
  String get translationTitle => 'Übersetzung:';

  @override
  String get footNoteTitle => 'Fußnote:';

  @override
  String get wordByWordTranslation => 'Wort-für-Wort-Übersetzung:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Teilen';

  @override
  String get addNoteButton => 'Notiz hinzufügen';

  @override
  String get pinToCollectionButton => 'An Sammlung anheften';

  @override
  String get shareAsText => 'Als Text teilen';

  @override
  String get copiedWithTafsir => 'Mit Tafsir kopiert';

  @override
  String get shareAsImage => 'Als Bild teilen';

  @override
  String get shareWithTafsir => 'Mit Tafsir teilen';

  @override
  String get notFound => 'Nicht gefunden';

  @override
  String get noteContentCannotBeEmpty =>
      'Der Notizinhalt darf nicht leer sein.';

  @override
  String get noteSavedSuccessfully => 'Notiz erfolgreich gespeichert!';

  @override
  String get selectCollections => 'Sammlungen auswählen';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get writeCollectionName => 'Schreibe den Sammlungsnamen...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Noch keine Sammlungen vorhanden. Füge eine neue hinzu!';

  @override
  String get pleaseWriteYourNoteFirst => 'Bitte schreibe zuerst deine Notiz.';

  @override
  String get noCollectionSelected => 'Keine Sammlung ausgewählt';

  @override
  String get saveNote => 'Notiz speichern';

  @override
  String get nextSelectCollections => 'Weiter: Sammlungen auswählen';

  @override
  String get addToPinned => 'Zu Gepnnten hinzufügen';

  @override
  String get pinnedSavedSuccessfully => 'Gepinnte erfolgreich gespeichert!';

  @override
  String get savePinned => 'Gepinntes speichern';

  @override
  String get closeAudioController => 'Audiosteuerung schließen';

  @override
  String get previous => 'Zurück';

  @override
  String get rewind => 'Zurückspulen';

  @override
  String get fastForward => 'Vorspulen';

  @override
  String get playNextAyah => 'Nächsten Vers abspielen';

  @override
  String get repeat => 'Wiederholen';

  @override
  String get playAsPlaylist => 'Als Wiedergabeliste abspielen';

  @override
  String style(String style) {
    return 'Stil: $style';
  }

  @override
  String get stopAndClose => 'Stopp & Schließen';

  @override
  String get play => 'Abspielen';

  @override
  String get pause => 'Pause';

  @override
  String get selectReciter => 'Rezitator auswählen';

  @override
  String source(String source) {
    return 'Quelle: $source';
  }

  @override
  String get newText => 'Neu';

  @override
  String get more => 'Mehr: ';

  @override
  String get cacheNotFound => 'Cache nicht gefunden';

  @override
  String get cacheSize => 'Cache-Größe';

  @override
  String error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get clean => 'Leeren';

  @override
  String get lastModified => 'Zuletzt geändert';

  @override
  String get oneYearAgo => 'Vor 1 Jahr';

  @override
  String monthsAgo(String number) {
    return 'Vor $number Monaten';
  }

  @override
  String weeksAgo(String number) {
    return 'Vor $number Wochen';
  }

  @override
  String daysAgo(String number) {
    return 'Vor $number Tagen';
  }

  @override
  String hoursAgo(int hour) {
    return 'Vor $hour Stunden';
  }

  @override
  String get aboutAlQuran => 'Über Al-Quran';

  @override
  String get appFullName => 'Al-Quran (Tafsir, Gebet, Qibla, Audio)';

  @override
  String get appDescription =>
      'Eine umfassende islamische Anwendung für Android, iOS, MacOS, Web, Linux und Windows, die das Lesen des Korans mit Tafsir & mehreren Übersetzungen (einschließlich Wort-für-Wort), weltweite Gebetszeiten mit Benachrichtigungen, einen Qibla-Kompass und synchronisierte Wort-für-Wort-Audio-Rezitation bietet.';

  @override
  String get dataSourcesNote =>
      'Hinweis: Korantexte, Tafsir, Übersetzungen und Audioressourcen stammen von Quran.com, Everyayah.com und anderen verifizierten offenen Quellen.';

  @override
  String get adFreePromise =>
      'Diese App wurde entwickelt, um das Wohlgefallen Allahs zu erlangen. Daher ist sie und wird sie immer vollständig werbefrei sein.';

  @override
  String get coreFeatures => 'Kernfunktionen';

  @override
  String get coreFeaturesDescription =>
      'Entdecke die Schlüsselfunktionen, die Al-Quran v3 zu einem unverzichtbaren Werkzeug für deine täglichen islamischen Praktiken machen:';

  @override
  String get prayerTimesTitle => 'Gebetszeiten & Benachrichtigungen';

  @override
  String get prayerTimesDescription =>
      'Genaue Gebetszeiten für jeden Ort weltweit mit verschiedenen Berechnungsmethoden. Richte Erinnerungen mit Adhan-Benachrichtigungen ein.';

  @override
  String get qiblaDirectionTitle => 'Qibla-Richtung';

  @override
  String get qiblaDirectionDescription =>
      'Finde einfach die Qibla-Richtung mit einer klaren und genauen Kompassansicht.';

  @override
  String get translationTafsirTitle => 'Koranübersetzung & Tafsir';

  @override
  String get translationTafsirDescription =>
      'Greife auf über 120 Übersetzungsbücher (einschließlich Wort-für-Wort) in 69 Sprachen und über 30 Tafsir-Bücher zu.';

  @override
  String get wordByWordAudioTitle => 'Wort-für-Wort-Audio & Hervorhebung';

  @override
  String get wordByWordAudioDescription =>
      'Folge der synchronisierten Wort-für-Wort-Audio-Rezitation und Hervorhebung für ein intensives Lernerlebnis.';

  @override
  String get ayahAudioRecitationTitle => 'Audio-Rezitation von Versen';

  @override
  String get ayahAudioRecitationDescription =>
      'Höre vollständige Vers-Rezitationen von über 40 renommierten Rezitatoren.';

  @override
  String get notesCloudBackupTitle => 'Notizen mit Cloud-Backup';

  @override
  String get notesCloudBackupDescription =>
      'Speichere persönliche Notizen und Reflexionen, sicher in der Cloud gesichert (Funktion in Entwicklung/bald verfügbar).';

  @override
  String get crossPlatformSupportTitle =>
      'Plattformübergreifende Unterstützung';

  @override
  String get crossPlatformSupportDescription =>
      'Unterstützt auf Android, Web, Linux und Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Hintergrund-Audio-Wiedergabe';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Höre die Koranrezitation weiter, auch wenn die App im Hintergrund ist.';

  @override
  String get audioDataCachingTitle => 'Audio- & Daten-Caching';

  @override
  String get audioDataCachingDescription =>
      'Verbesserte Wiedergabe und Offline-Fähigkeiten durch robustes Caching von Audio- und Korandaten.';

  @override
  String get minimalisticInterfaceTitle =>
      'Minimalistische & saubere Benutzeroberfläche';

  @override
  String get minimalisticInterfaceDescription =>
      'Leicht zu navigierende Benutzeroberfläche mit Fokus auf Benutzererfahrung und Lesbarkeit.';

  @override
  String get optimizedPerformanceTitle => 'Optimierte Leistung & Größe';

  @override
  String get optimizedPerformanceDescription =>
      'Eine funktionsreiche Anwendung, die leichtgewichtig und leistungsstark konzipiert wurde.';

  @override
  String get languageSupport => 'Sprachunterstützung';

  @override
  String get languageSupportDescription =>
      'Diese Anwendung ist so konzipiert, dass sie für ein globales Publikum zugänglich ist und die folgenden Sprachen unterstützt (und weitere werden kontinuierlich hinzugefügt):';

  @override
  String get technologyAndResources => 'Technologie & Ressourcen';

  @override
  String get technologyAndResourcesDescription =>
      'Diese App wurde unter Verwendung modernster Technologien und zuverlässiger Ressourcen entwickelt:';

  @override
  String get flutterFrameworkTitle => 'Flutter Framework';

  @override
  String get flutterFrameworkDescription =>
      'Entwickelt mit Flutter für ein schönes, nativ kompiliertes, plattformübergreifendes Erlebnis aus einer einzigen Codebasis.';

  @override
  String get advancedAudioEngineTitle => 'Fortschrittliche Audio-Engine';

  @override
  String get advancedAudioEngineDescription =>
      'Angetrieben durch die Flutter-Pakete `just_audio` und `just_audio_background` für robuste Audiowiedergabe und -steuerung.';

  @override
  String get reliableQuranDataTitle => 'Zuverlässige Korandaten';

  @override
  String get reliableQuranDataDescription =>
      'Al-Quran-Texte, Übersetzungen, Tafsire und Audiodaten stammen von verifizierten offenen APIs und Datenbanken wie Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Gebetszeiten-Engine';

  @override
  String get prayerTimeEngineDescription =>
      'Verwendet etablierte Berechnungsmethoden für genaue Gebetszeiten. Benachrichtigungen werden von `flutter_local_notifications` und Hintergrundaufgaben verwaltet.';

  @override
  String get crossPlatformSupport => 'Plattformübergreifende Unterstützung';

  @override
  String get crossPlatformSupportDescription2 =>
      'Genieße nahtlosen Zugriff auf verschiedenen Plattformen:';

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
  String get ourLifetimePromise => 'Unser lebenslanges Versprechen';

  @override
  String get lifetimePromiseDescription =>
      'Ich persönlich verspreche, diese Anwendung mein Leben lang kontinuierlich zu unterstützen und zu warten, In Sha Allah. Mein Ziel ist es sicherzustellen, dass diese App für die Ummah in den kommenden Jahren eine nützliche Ressource bleibt.';

  @override
  String get fajr => 'Fadschr';

  @override
  String get sunrise => 'Sonnenaufgang';

  @override
  String get noon => 'Mittag';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Sonnenuntergang';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Ischa';

  @override
  String get midnight => 'Mitternacht';

  @override
  String get alarm => 'Alarm';

  @override
  String get notification => 'Benachrichtigung';

  @override
  String formattedAddress(
    String subAdministrativeArea,
    String administrativeArea,
    String country,
  ) {
    return '$subAdministrativeArea, $administrativeArea, $country';
  }

  @override
  String get quranScriptTajweed => 'Tadschwīd';

  @override
  String get quranScriptUthmani => 'Uthmani';

  @override
  String get quranScriptIndopak => 'Indo-Pak';

  @override
  String get sajdaAyah => 'Sajda-Vers';

  @override
  String get required => 'Erforderlich';

  @override
  String get optional => 'Optional';

  @override
  String get notificationScheduleWarning =>
      'Hinweis: Geplante Benachrichtigungen oder Erinnerungen können aufgrund von Hintergrundprozessbeschränkungen Ihres Betriebssystems verpasst werden. Zum Beispiel: Origin OS von Vivo, One UI von Samsung, ColorOS von Oppo usw. beenden manchmal geplante Benachrichtigungen oder Erinnerungen. Bitte überprüfen Sie Ihre Betriebssystemeinstellungen, um die App von Hintergrundprozessen auszunehmen.';

  @override
  String get scrollWithRecitation => 'Scrollen mit Rezitation';

  @override
  String get quickAccess => 'Schnellzugriff';

  @override
  String get initiallyScrollAyah => 'Zuerst zu Ayah scrollen';

  @override
  String get tajweedGuide => 'Tajweed-Anleitung';

  @override
  String get scrollWithRecitationDesc =>
      'Wenn aktiviert, wird die Koran-Ayah automatisch synchron mit der Audio-Rezitation gescrollt.';

  @override
  String get configuration => 'Konfiguration';

  @override
  String get restoreFromBackup => 'Aus Backup wiederherstellen';

  @override
  String get history => 'Verlauf';

  @override
  String get search => 'Suchen';

  @override
  String get useAudioStream => 'Audiostream verwenden';

  @override
  String get useAudioStreamDesc =>
      'Audio direkt aus dem Internet streamen, anstatt es herunterzuladen.';

  @override
  String get notUseAudioStreamDesc =>
      'Laden Sie Audio für die Offline-Nutzung herunter und reduzieren Sie den Datenverbrauch.';

  @override
  String get audioSettings => 'Audioeinstellungen';

  @override
  String get playbackSpeed => 'Wiedergabegeschwindigkeit';

  @override
  String get playbackSpeedDesc =>
      'Passen Sie die Geschwindigkeit der Koranrezitation an.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Bitte warten Sie, bis der aktuelle Download abgeschlossen ist.';

  @override
  String get areYouSure => 'Bist du sicher?';

  @override
  String get checkYourInternetConnection =>
      'Überprüfen Sie Ihre Internetverbindung.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Muss $requiredDownload von $totalVersesCount Ayahs herunterladen.';
  }

  @override
  String get download => 'Herunterladen';

  @override
  String get audioDownload => 'Audio-Download';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Optimierung des Koranskripts';

  @override
  String get supportOnGithub => 'Auf GitHub unterstützen';

  @override
  String get forbiddenSalatTimes => 'Verbotene Gebetszeiten';

  @override
  String get prayerTimes => 'Gebetszeiten';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafi\'i';

  @override
  String get suhurEnd => 'Suhur Ende';

  @override
  String get iftarStart => 'Iftar Start';

  @override
  String get tahajjudStart => 'Tahajjud Start';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';
}
