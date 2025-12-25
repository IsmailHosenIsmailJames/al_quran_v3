// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String tafsirAppBarTitle(
    String nameSimple,
    String nameArabic,
    String ayahKey,
  ) {
    return '$nameSimple ($nameArabic) - $ayahKey';
  }

  @override
  String tafsirNotAvailable(String ayahKey) {
    return 'Tafsir non disponibile per $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Il Tafsir si trova in: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Vai a $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Pagina';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Impostazioni lingua';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count versetti';
  }

  @override
  String get saveAndDownload => 'Salva e scarica';

  @override
  String get appLanguage => 'Lingua dell\'app';

  @override
  String get selectAppLanguage => 'Seleziona la lingua dell\'app...';

  @override
  String get pleaseSelectOne => 'Selezionane uno';

  @override
  String get quranTranslationLanguage => 'Lingua traduzione Corano';

  @override
  String get selectTranslationLanguage =>
      'Seleziona la lingua di traduzione...';

  @override
  String get quranTranslationBook => 'Libro di traduzione del Corano';

  @override
  String get selectTranslationBook => 'Seleziona il libro di traduzione...';

  @override
  String get quranTafsirLanguage => 'Lingua Tafsir Corano';

  @override
  String get selectTafsirLanguage => 'Seleziona la lingua del tafsir...';

  @override
  String get quranTafsirBook => 'Libro di Tafsir del Corano';

  @override
  String get selectTafsirBook => 'Seleziona il libro di tafsir...';

  @override
  String get quranScriptAndStyle => 'Scrittura e stile del Corano';

  @override
  String get justAMoment => 'Un momento...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Successo';

  @override
  String get retry => 'Riprova';

  @override
  String get unableToDownloadResources =>
      'Impossibile scaricare le risorse...\nQualcosa è andato storto';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Scaricamento recitazione segmentata del Corano';

  @override
  String get processingSegmentedQuranRecitation =>
      'Elaborazione recitazione segmentata del Corano';

  @override
  String get footnote => 'Nota a piè di pagina';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Parola per parola';

  @override
  String get pleaseSelectRequiredOption => 'Seleziona l\'opzione richiesta';

  @override
  String get rememberHomeTab => 'Ricorda la scheda Home';

  @override
  String get rememberHomeTabSubtitle =>
      'L\'app ricorderà l\'ultima scheda aperta nella schermata principale.';

  @override
  String get wakeLock => 'Blocco schermo attivo';

  @override
  String get wakeLockSubtitle =>
      'Impedisce allo schermo di spegnersi automaticamente.';

  @override
  String get settings => 'Impostazioni';

  @override
  String get appTheme => 'Tema dell\'app';

  @override
  String get quranStyle => 'Stile del Corano';

  @override
  String get changeTheme => 'Cambia tema';

  @override
  String get verseCount => 'Numero versetti: ';

  @override
  String get translation => 'Traduzione';

  @override
  String get tafsirNotFound => 'Non trovato';

  @override
  String get moreInfo => 'più info';

  @override
  String get playAudio => 'Riproduci audio';

  @override
  String get preview => 'Anteprima';

  @override
  String get loading => 'Caricamento...';

  @override
  String get errorFetchingAddress => 'Errore nel recupero dell\'indirizzo';

  @override
  String get addressNotAvailable => 'Indirizzo non disponibile';

  @override
  String get latitude => 'Latitudine: ';

  @override
  String get longitude => 'Longitudine: ';

  @override
  String get name => 'Nome: ';

  @override
  String get location => 'Posizione: ';

  @override
  String get parameters => 'Parametri: ';

  @override
  String get selectCalculationMethod => 'Seleziona metodo di calcolo';

  @override
  String get shareSelectAyahs => 'Condividi i versetti selezionati';

  @override
  String get selectionEmpty => 'Nessuna selezione';

  @override
  String get generatingImagePleaseWait =>
      'Generazione immagine... Attendere prego';

  @override
  String get asImage => 'Come immagine';

  @override
  String get asText => 'Come testo';

  @override
  String get playFromSelectedAyah => 'Riproduci dal versetto selezionato';

  @override
  String get toTafsir => 'Vai al Tafsir';

  @override
  String get selectAyah => 'Seleziona versetto';

  @override
  String get toAyah => 'Vai al versetto';

  @override
  String get searchForASurah => 'Cerca una sura';

  @override
  String get bugReportTitle => 'Segnalazione bug';

  @override
  String get audioCached => 'Audio memorizzato nella cache';

  @override
  String get others => 'Altro';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Corano|Traduzione|Versetto, uno deve essere abilitato';

  @override
  String get quranFontSize => 'Dimensione carattere Corano';

  @override
  String get quranLineHeight => 'Altezza riga Corano';

  @override
  String get translationAndTafsirFontSize =>
      'Dimensione carattere Traduzione e Tafsir';

  @override
  String get quranAyah => 'Versetto del Corano';

  @override
  String get topToolbar => 'Barra degli strumenti superiore';

  @override
  String get keepOpenWordByWord =>
      'Mantieni aperta la traduzione Parola per Parola';

  @override
  String get wordByWordHighlight => 'Evidenziazione Parola per Parola';

  @override
  String get quranScriptSettings => 'Impostazioni scrittura Corano';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Pagina: ';

  @override
  String get quranResources => 'Risorse del Corano';

  @override
  String alreadySelected(String name) {
    return 'La lingua \'$name\' è già selezionata.';
  }

  @override
  String get unableToGetCompassData =>
      'Impossibile ottenere i dati della bussola';

  @override
  String get deviceDoesNotHaveSensors => 'Il dispositivo non ha sensori!';

  @override
  String get north => 'N';

  @override
  String get east => 'E';

  @override
  String get south => 'S';

  @override
  String get west => 'O';

  @override
  String get address => 'Indirizzo: ';

  @override
  String get change => 'Modifica';

  @override
  String get calculationMethod => 'Metodo di calcolo: ';

  @override
  String get downloadPrayerTime => 'Scarica orari di preghiera';

  @override
  String get calculationMethodsListEmpty =>
      'L\'elenco dei metodi di calcolo è vuoto.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Nessun metodo di calcolo trovato con i dati di localizzazione.';

  @override
  String get prayerSettings => 'Impostazioni di preghiera';

  @override
  String get reminderSettings => 'Impostazioni promemoria';

  @override
  String get adjustReminderTime => 'Regola l\'orario del promemoria';

  @override
  String get enforceAlarmSound => 'Forza suono della sveglia';

  @override
  String get enforceAlarmSoundDescription =>
      'Se abilitata, questa funzione riprodurrà la sveglia al volume impostato qui, anche se il volume del telefono è basso. Ciò assicura di non perdere la sveglia a causa del basso volume del telefono.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'All\'ora della preghiera';

  @override
  String minBefore(int minutes) {
    return '$minutes min prima';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min dopo';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'L\'ora di $prayerName è alle $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'È l\'ora di $prayerName';
  }

  @override
  String get stopTheAdhan => 'Ferma l\'Adhan';

  @override
  String dateFoundEmpty(String date) {
    return '$date non trovato';
  }

  @override
  String get today => 'Oggi';

  @override
  String get left => 'Rimanente';

  @override
  String reminderAdded(String prayerName) {
    return 'Promemoria per $prayerName aggiunto';
  }

  @override
  String get allowNotificationPermission =>
      'Si prega di consentire il permesso di notifica per utilizzare questa funzione';

  @override
  String reminderRemoved(String prayerName) {
    return 'Promemoria per $prayerName rimosso';
  }

  @override
  String get getPrayerTimesAndQibla => 'Ottieni orari di preghiera e Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calcola gli orari di preghiera e la Qibla per qualsiasi località.';

  @override
  String get getFromGPS => 'Ottieni da GPS';

  @override
  String get or => 'O';

  @override
  String get selectYourCity => 'Seleziona la tua città';

  @override
  String get noteAboutGPS =>
      'Nota: se non vuoi usare il GPS o non ti senti sicuro, puoi selezionare la tua città.';

  @override
  String get downloadingLocationResources =>
      'Scaricamento delle risorse di localizzazione...';

  @override
  String get somethingWentWrong => 'Qualcosa è andato storto';

  @override
  String get selectYourCountry => 'Seleziona il tuo Paese';

  @override
  String get searchForACountry => 'Cerca un Paese';

  @override
  String get selectYourAdministrator => 'Seleziona la tua regione';

  @override
  String get searchForAnAdministrator => 'Cerca una regione';

  @override
  String get searchForACity => 'Cerca una città';

  @override
  String get pleaseEnableLocationService =>
      'Abilita il servizio di localizzazione';

  @override
  String get donateUs => 'Donaci';

  @override
  String get underDevelopment => 'In fase di sviluppo';

  @override
  String get versionLoading => 'Caricamento...';

  @override
  String get alQuran => 'Al Quran';

  @override
  String get mainMenu => 'Menu principale';

  @override
  String get notes => 'Note';

  @override
  String get pinned => 'Aggiunti';

  @override
  String get jumpToAyah => 'Vai al versetto';

  @override
  String get shareMultipleAyah => 'Condividi più versetti';

  @override
  String get shareThisApp => 'Condividi questa app';

  @override
  String get giveRating => 'Dai una valutazione';

  @override
  String get bugReport => 'Segnalazione bug';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get aboutTheApp => 'Informazioni sull\'app';

  @override
  String get resetTheApp => 'Reimposta l\'app';

  @override
  String get resetAppWarningTitle => 'Reimposta dati dell\'app';

  @override
  String get resetAppWarningMessage =>
      'Sei sicuro di voler reimpostare l\'app? Tutti i tuoi dati andranno persi e dovrai configurare l\'app dall\'inizio.';

  @override
  String get cancel => 'Annulla';

  @override
  String get reset => 'Reimposta';

  @override
  String get shareAppSubject => 'Dai un\'occhiata a questa app Al Quran!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Dai un\'occhiata a questa app Al Quran per la lettura e la riflessione quotidiana. Aiuta a connettersi con le parole di Allah. Scarica qui: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Apri menu';

  @override
  String get quran => 'Corano';

  @override
  String get prayer => 'Preghiera';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Sura';

  @override
  String get pages => 'Pagine';

  @override
  String get note => 'Nota:';

  @override
  String get linkedAyahs => 'Versetti collegati:';

  @override
  String get emptyNoteCollection =>
      'Questa raccolta di note è vuota.\nAggiungi delle note per vederle qui.';

  @override
  String get emptyPinnedCollection =>
      'Nessun versetto aggiunto a questa raccolta.\nAggiungi dei versetti per vederli qui.';

  @override
  String get noContentAvailable => 'Nessun contenuto disponibile.';

  @override
  String failedToLoadCollections(String error) {
    return 'Caricamento delle raccolte non riuscito: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Cerca per nome $collectionType...';
  }

  @override
  String get sortBy => 'Ordina per';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Nessuna $collectionType ancora aggiunta';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count elementi aggiunti';
  }

  @override
  String notesCount(int count) {
    return '$count note';
  }

  @override
  String get emptyNameNotAllowed => 'Il nome non può essere vuoto';

  @override
  String updatedTo(String collectionName) {
    return 'Aggiornato a $collectionName';
  }

  @override
  String get changeName => 'Cambia nome';

  @override
  String get changeColor => 'Cambia colore';

  @override
  String get colorUpdated => 'Colore aggiornato';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName eliminata';
  }

  @override
  String get delete => 'Elimina';

  @override
  String get save => 'Salva';

  @override
  String get collectionNameCannotBeEmpty =>
      'Il nome della raccolta non può essere vuoto.';

  @override
  String get addedNewCollection => 'Aggiunta nuova raccolta';

  @override
  String ayahCount(int count) {
    return '$count versetto';
  }

  @override
  String get byNameAtoZ => 'Nome A-Z';

  @override
  String get byNameZtoA => 'Nome Z-A';

  @override
  String get byElementNumberAscending => 'Numero elemento crescente';

  @override
  String get byElementNumberDescending => 'Numero elemento decrescente';

  @override
  String get byUpdateDateAscending => 'Data aggiornamento crescente';

  @override
  String get byUpdateDateDescending => 'Data aggiornamento decrescente';

  @override
  String get byCreateDateAscending => 'Data creazione crescente';

  @override
  String get byCreateDateDescending => 'Data creazione decrescente';

  @override
  String get translationNotFound => 'Traduzione non trovata';

  @override
  String get translationTitle => 'Traduzione:';

  @override
  String get footNoteTitle => 'Nota a piè di pagina:';

  @override
  String get wordByWordTranslation => 'Traduzione parola per parola:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Condividi';

  @override
  String get addNoteButton => 'Aggiungi nota';

  @override
  String get pinToCollectionButton => 'Aggiungi alla raccolta';

  @override
  String get shareAsText => 'Condividi come testo';

  @override
  String get copiedWithTafsir => 'Copiato con Tafsir';

  @override
  String get shareAsImage => 'Condividi come immagine';

  @override
  String get shareWithTafsir => 'Condividi con Tafsir';

  @override
  String get notFound => 'Non trovato';

  @override
  String get noteContentCannotBeEmpty =>
      'Il contenuto della nota non può essere vuoto.';

  @override
  String get noteSavedSuccessfully => 'Nota salvata con successo!';

  @override
  String get selectCollections => 'Seleziona raccolte';

  @override
  String get addNote => 'Aggiungi nota';

  @override
  String get writeCollectionName => 'Scrivi il nome della raccolta...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Nessuna raccolta ancora. Aggiungine una nuova!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Per favore, scrivi prima la tua nota.';

  @override
  String get noCollectionSelected => 'Nessuna raccolta selezionata';

  @override
  String get saveNote => 'Salva nota';

  @override
  String get nextSelectCollections => 'Avanti: Seleziona raccolte';

  @override
  String get addToPinned => 'Aggiungi ai preferiti';

  @override
  String get pinnedSavedSuccessfully => 'Aggiunto ai preferiti con successo!';

  @override
  String get savePinned => 'Salva preferito';

  @override
  String get closeAudioController => 'Chiudi controller audio';

  @override
  String get previous => 'Precedente';

  @override
  String get rewind => 'Riavvolgi';

  @override
  String get fastForward => 'Avanti veloce';

  @override
  String get playNextAyah => 'Riproduci versetto successivo';

  @override
  String get repeat => 'Ripeti';

  @override
  String get playAsPlaylist => 'Riproduci come playlist';

  @override
  String style(String style) {
    return 'Stile: $style';
  }

  @override
  String get stopAndClose => 'Ferma e chiudi';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pausa';

  @override
  String get selectReciter => 'Seleziona recitatore';

  @override
  String source(String source) {
    return 'Fonte: $source';
  }

  @override
  String get newText => 'Nuovo';

  @override
  String get more => 'Altro: ';

  @override
  String get cacheNotFound => 'Cache non trovata';

  @override
  String get cacheSize => 'Dimensione cache';

  @override
  String error(String error) {
    return 'Errore: $error';
  }

  @override
  String get clean => 'Pulisci';

  @override
  String get lastModified => 'Ultima modifica';

  @override
  String get oneYearAgo => '1 anno fa';

  @override
  String monthsAgo(String number) {
    return '$number mesi fa';
  }

  @override
  String weeksAgo(String number) {
    return '$number settimane fa';
  }

  @override
  String daysAgo(String number) {
    return '$number giorni fa';
  }

  @override
  String hoursAgo(int hour) {
    return '$hour ore fa';
  }

  @override
  String get aboutAlQuran => 'Informazioni su Al Quran';

  @override
  String get appFullName => 'Al Quran (Tafsir, Preghiera, Qibla, Audio)';

  @override
  String get appDescription =>
      'Un\'applicazione islamica completa per Android, iOS, MacOS, Web, Linux e Windows, che offre la lettura del Corano con Tafsir e traduzioni multiple (inclusa parola per parola), orari di preghiera mondiali con notifiche, bussola Qibla e recitazione audio sincronizzata parola per parola.';

  @override
  String get dataSourcesNote =>
      'Nota: i testi del Corano, il Tafsir, le traduzioni e le risorse audio provengono da Quran.com, Everyayah.com e altre fonti aperte verificate.';

  @override
  String get adFreePromise =>
      'Questa app è stata creata per cercare il compiacimento di Allah. Pertanto, è e sarà sempre completamente priva di pubblicità.';

  @override
  String get coreFeatures => 'Caratteristiche principali';

  @override
  String get coreFeaturesDescription =>
      'Esplora le funzionalità chiave che rendono Al Quran v3 uno strumento indispensabile per le tue pratiche islamiche quotidiane:';

  @override
  String get prayerTimesTitle => 'Orari di preghiera e avvisi';

  @override
  String get prayerTimesDescription =>
      'Orari di preghiera precisi per qualsiasi località del mondo utilizzando vari metodi di calcolo. Imposta promemoria con notifiche Adhan.';

  @override
  String get qiblaDirectionTitle => 'Direzione della Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Trova facilmente la direzione della Qibla con una visualizzazione della bussola chiara e precisa.';

  @override
  String get translationTafsirTitle => 'Traduzione e Tafsir del Corano';

  @override
  String get translationTafsirDescription =>
      'Accedi a oltre 120 libri di traduzione (inclusa parola per parola) in 69 lingue e a oltre 30 libri di Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio e evidenziazione parola per parola';

  @override
  String get wordByWordAudioDescription =>
      'Segui la recitazione audio sincronizzata parola per parola e l\'evidenziazione per un\'esperienza di apprendimento immersiva.';

  @override
  String get ayahAudioRecitationTitle => 'Recitazione audio dei versetti';

  @override
  String get ayahAudioRecitationDescription =>
      'Ascolta le recitazioni complete dei versetti di oltre 40 recitatori di fama.';

  @override
  String get notesCloudBackupTitle => 'Note con backup su cloud';

  @override
  String get notesCloudBackupDescription =>
      'Salva note e riflessioni personali, con backup sicuro su cloud (funzionalità in sviluppo/prossimamente).';

  @override
  String get crossPlatformSupportTitle => 'Supporto multipiattaforma';

  @override
  String get crossPlatformSupportDescription =>
      'Supportato su Android, Web, Linux e Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Riproduzione audio in background';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continua ad ascoltare la recitazione del Corano anche quando l\'app è in background.';

  @override
  String get audioDataCachingTitle => 'Caching di audio e dati';

  @override
  String get audioDataCachingDescription =>
      'Riproduzione migliorata e funzionalità offline con un robusto caching di audio e dati del Corano.';

  @override
  String get minimalisticInterfaceTitle => 'Interfaccia minimalista e pulita';

  @override
  String get minimalisticInterfaceDescription =>
      'Interfaccia facile da navigare con focus sull\'esperienza utente e la leggibilità.';

  @override
  String get optimizedPerformanceTitle =>
      'Prestazioni e dimensioni ottimizzate';

  @override
  String get optimizedPerformanceDescription =>
      'Un\'applicazione ricca di funzionalità progettata per essere leggera e performante.';

  @override
  String get languageSupport => 'Supporto linguistico';

  @override
  String get languageSupportDescription =>
      'Questa applicazione è progettata per essere accessibile a un pubblico globale con supporto per le seguenti lingue (e altre vengono aggiunte continuamente):';

  @override
  String get technologyAndResources => 'Tecnologia e risorse';

  @override
  String get technologyAndResourcesDescription =>
      'Questa app è costruita utilizzando tecnologie all\'avanguardia e risorse affidabili:';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Costruita con Flutter per un\'esperienza multipiattaforma bella, compilata in modo nativo, da un\'unica base di codice.';

  @override
  String get advancedAudioEngineTitle => 'Motore audio avanzato';

  @override
  String get advancedAudioEngineDescription =>
      'Alimentato dai pacchetti Flutter `just_audio` e `just_audio_background` per una riproduzione e un controllo audio robusti.';

  @override
  String get reliableQuranDataTitle => 'Dati del Corano affidabili';

  @override
  String get reliableQuranDataDescription =>
      'I testi, le traduzioni, i tafsir e l\'audio del Corano provengono da API e database aperti e verificati come Quran.com e Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Motore per gli orari di preghiera';

  @override
  String get prayerTimeEngineDescription =>
      'Utilizza metodi di calcolo consolidati per orari di preghiera accurati. Notifiche gestite da `flutter_local_notifications` e attività in background.';

  @override
  String get crossPlatformSupport => 'Supporto multipiattaforma';

  @override
  String get crossPlatformSupportDescription2 =>
      'Goditi un accesso senza interruzioni su varie piattaforme:';

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
  String get ourLifetimePromise => 'La nostra promessa a vita';

  @override
  String get lifetimePromiseDescription =>
      'Prometto personalmente di fornire supporto e manutenzione continui per questa applicazione per tutta la mia vita, In Sha Allah. Il mio obiettivo è garantire che questa app rimanga una risorsa benefica per l\'Ummah per gli anni a venire.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Alba';

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
  String get midnight => 'Mezzanotte';

  @override
  String get alarm => 'Sveglia';

  @override
  String get notification => 'Notifica';

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
  String get sajdaAyah => 'Versetto di Sajda';

  @override
  String get required => 'Obbligatorio';

  @override
  String get optional => 'Facoltativo';

  @override
  String get notificationScheduleWarning =>
      'Nota: le notifiche o i promemoria programmati potrebbero non essere visualizzati a causa delle restrizioni dei processi in background del sistema operativo del telefono. Ad esempio: Origin OS di Vivo, One UI di Samsung, ColorOS di Oppo, ecc. a volte interrompono le notifiche o i promemoria programmati. Controlla le impostazioni del tuo sistema operativo per consentire all\'app di non essere limitata dai processi in background.';

  @override
  String get scrollWithRecitation => 'Scorri con la recitazione';

  @override
  String get quickAccess => 'Accesso rapido';

  @override
  String get initiallyScrollAyah => 'Inizialmente scorri fino all\'ayah';

  @override
  String get tajweedGuide => 'Guida al Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Quando abilitato, l\'ayah del Corano scorrerà automaticamente in sincronia con la recitazione audio.';

  @override
  String get configuration => 'Configurazione';

  @override
  String get restoreFromBackup => 'Ripristina da backup';

  @override
  String get history => 'Storia';

  @override
  String get search => 'Ricerca';

  @override
  String get useAudioStream => 'Usa streaming audio';

  @override
  String get useAudioStreamDesc =>
      'Riproduci l\'audio in streaming directly da Internet invece di scaricarlo.';

  @override
  String get notUseAudioStreamDesc =>
      'Scarica l\'audio per l\'utilizzo offline e riduci il consumo di dati.';

  @override
  String get audioSettings => 'Impostazioni audio';

  @override
  String get playbackSpeed => 'Velocità di riproduzione';

  @override
  String get playbackSpeedDesc =>
      'Regola la velocità della recitazione del Corano.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Attendi il completamento del download corrente.';

  @override
  String get areYouSure => 'Sei sicuro?';

  @override
  String get checkYourInternetConnection =>
      'Controlla la tua connessione internet.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Necessario scaricare $requiredDownload di $totalVersesCount ayah.';
  }

  @override
  String get download => 'Scarica';

  @override
  String get audioDownload => 'Download audio';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Ottimizzazione dello script del Corano';

  @override
  String get supportOnGithub => 'Supporta su GitHub';

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
