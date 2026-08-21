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
  String get saveAndDownload => 'Salva e Scarica';

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
  String get noon => 'Mezzogiorno';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Tramonto';

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
  String get forbiddenSalatTimes => 'Orari di preghiera proibiti';

  @override
  String get prayerTimes => 'Orari di preghiera';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafi\'i';

  @override
  String get suhurEnd => 'Fine Suhur';

  @override
  String get iftarStart => 'Inizio Iftar';

  @override
  String get tahajjudStart => 'Inizio Tahajjud';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';

  @override
  String get indopakFont => 'Carattere Indopak';

  @override
  String get uthmaniFont => 'Carattere Uthmani';

  @override
  String get close => 'Chiudi';

  @override
  String get goToSettings => 'Vai alle impostazioni';

  @override
  String get scriptSettingsUpdated => 'Impostazioni dello script aggiornate';

  @override
  String get scriptSettingsUpdatedDescription =>
      'Abbiamo semplificato le nostre opzioni di script e aggiunto altri caratteri.';

  @override
  String get enterPageNumber => 'Inserisci un numero di pagina tra 1 e 604';

  @override
  String get deleteMushafData => 'Elimina dati Mushaf';

  @override
  String get deleteMushafDataDescription =>
      'Sei sicuro di voler eliminare tutti i dati del Mushaf?';

  @override
  String get invalidPage => 'Pagina non valida (1-604)';

  @override
  String get goToPage => 'Vai alla pagina';

  @override
  String get resources => 'Risorse';

  @override
  String get mushaf => 'Mushaf';

  @override
  String get circleJojomInQuranScript =>
      'Cerchio Jojom/Sukun nella scrittura del Corano';

  @override
  String get copy => 'Copia';

  @override
  String get share => 'Condividi';

  @override
  String get warningMessageOnIndopakTajweedEnable =>
      'Abbiamo riscontrato alcuni problemi di rendering sul colore del tajweed Indopak su alcuni caratteri. Pertanto, potresti riscontrare incongruenze nel rendering dei colori dello script. Sei sicuro di voler applicare il tajweed all\'Indopak?';

  @override
  String get apply => 'Applica';

  @override
  String get warning => 'Avviso';

  @override
  String get hijri => 'Egira';

  @override
  String get gregorian => 'Gregoriano';

  @override
  String get prayerTimesCalender => 'Calendario dei tempi di preghiera';

  @override
  String get allowLocation => 'Consenti posizione';

  @override
  String get allowLocationDescription =>
      'Aggiorna automaticamente i tempi di preghiera.';

  @override
  String get manualLocation => 'Posizione manuale';

  @override
  String get manualLocationDescription =>
      'Seleziona manualmente il paese e la città. Devi aggiornare la posizione se cambi città.';

  @override
  String get selectLocation => 'Seleziona posizione';

  @override
  String get selectCountry => 'Seleziona paese';

  @override
  String get selectCity => 'Seleziona città';

  @override
  String get sunRising => 'Sorgere del sole';

  @override
  String get sunSetting => 'Tramonto';

  @override
  String get sunTopOfTheHead => 'Sole allo zenit';

  @override
  String get salatTime => 'Tempo di preghiera';

  @override
  String get forbiddenSalatTime => 'Tempo di preghiera proibito';

  @override
  String get translationDatabase => 'Database traduzioni';

  @override
  String get translationDatabaseSubtitle =>
      'Download testo della traduzione selezionata';

  @override
  String get tafsirCommentary => 'Commento Tafsir';

  @override
  String get tafsirCommentarySubtitle => 'Preparazione risorse tafsir';

  @override
  String get wordByWordAnalysis => 'Analisi parola per parola';

  @override
  String get wordByWordAnalysisSubtitle =>
      'Impostazione scomposizione vocabolario';

  @override
  String get audioRecitationSegments => 'Segmenti di recitazione audio';

  @override
  String get audioRecitationSegmentsSubtitle =>
      'Configurazione segmenti temporali versi';

  @override
  String get locationQiblaMetadata => 'Metadati posizione e Qibla';

  @override
  String get locationQiblaMetadataSubtitle =>
      'Download dati posizione città globali';

  @override
  String get preparingResources => 'Preparazione risorse...';

  @override
  String get setupCompletedOpeningQuran =>
      'Configurazione completata! Apertura del Corano...';

  @override
  String get unexpectedErrorSetup =>
      'Si è verificato un errore imprevisto durante la configurazione.';

  @override
  String get heading => 'Rilevamento';

  @override
  String get alignedWithKaaba => 'Allineato con la Kaaba';

  @override
  String turnRight(Object degrees) {
    return 'Gira di $degrees° a destra';
  }

  @override
  String turnLeft(Object degrees) {
    return 'Gira di $degrees° a sinistra';
  }

  @override
  String get streamingAndNetwork => 'Streaming e rete';

  @override
  String get next => 'Successivo';

  @override
  String get now => 'Adesso';

  @override
  String get current => 'Attuale';

  @override
  String get active => 'Attivo';

  @override
  String get activeNow => 'Attivo ora';

  @override
  String get hours => 'Ore';

  @override
  String get minutes => 'Minuti';

  @override
  String get seconds => 'Secondi';

  @override
  String get fastingAndVoluntaryTimes =>
      'Orari di digiuno e preghiere volontarie';

  @override
  String get imsak => 'Imsak';

  @override
  String get ishraqAndDuha => 'Ishraq e Duha';

  @override
  String get lastThirdOfNight => 'Ultimo terzo della notte';

  @override
  String get awqatAlNahy => 'Orari proibiti per la preghiera';

  @override
  String get forbiddenSunriseDescription =>
      'Dall\'alba fino a quando il sole non sale all\'altezza di una lancia (~15 min)';

  @override
  String get forbiddenNoonDescription =>
      'Quando il sole è allo zenit fino all\'inizio di Dhuhr (~8 min)';

  @override
  String get forbiddenSunsetDescription =>
      'Quando il sole ingiallisce fino al tramonto completo (~15 min)';

  @override
  String get forbiddenTimesHadith =>
      'According to authentic Hadith in Sahih Muslim (832), \'Uqbah ibn \'Amir al-Juhani said:\n\n\"There are three times at which the Messenger of Allah (peace and blessings be upon him) forbade us to pray or to bury our dead:\n1. When the sun begins to rise until it is fully risen (~15 mins after sunrise).\n2. When the sun is at its height at midday until it has passed the meridian (~8-10 mins before Dhuhr).\n3. When the sun begins to set until it has completely set (~15 mins before Maghrib).\"';

  @override
  String get readMoreOnIslamQA => 'Leggi la fatwa completa su IslamQA';

  @override
  String get asrJurisprudence => 'Giurisprudenza di Asr (Madhhab)';

  @override
  String get shafieDescription => 'Standard (Shafi\'i, Maliki, Hanbali)';

  @override
  String get hanafiDescription => 'Scuola Hanafita';

  @override
  String get shafieShadow => 'Standard (Ombra 1x)';

  @override
  String get hanafiShadow => 'Hanafi (Ombra 2x)';

  @override
  String get calculationAndJurisprudence => 'Calcolo e Giurisprudenza';

  @override
  String get notificationsAndAudio => 'Notifiche e Audio';

  @override
  String get enablePrayerReminders => 'Attiva promemoria preghiera';

  @override
  String get enablePrayerRemindersDescription =>
      'Ricevi notifiche per tutte le prossime preghiere.';

  @override
  String get adjustReminderTimingDescription =>
      'Regola l\'orario del promemoria (+/- minuti dall\'orario effettivo).';

  @override
  String get exactTime => 'Orario esatto';

  @override
  String actualTime(String time) {
    return 'Ora effettiva: $time';
  }

  @override
  String get jumpToToday => 'Vai a oggi';

  @override
  String get dateAndHijri => 'Data / Hijri';

  @override
  String get selectedLocation => 'Posizione selezionata';

  @override
  String nextPrayerLabel(String prayerName) {
    return 'Successiva: $prayerName';
  }

  @override
  String currentPrayerLabel(String prayerName) {
    return 'Ora: $prayerName';
  }

  @override
  String startsAt(String prayerName, String time) {
    return '$prayerName inizia alle $time';
  }

  @override
  String get continueReading => 'Continua a leggere';

  @override
  String get lastRead => 'Ultima lettura';

  @override
  String get resume => 'Riprendi';

  @override
  String get startReading => 'Inizia a leggere';

  @override
  String get verses => 'Versetti';

  @override
  String get ayah => 'Versetto';

  @override
  String get edit => 'Modifica';

  @override
  String get searchAll => 'Tutti';

  @override
  String get searchArabic => 'Arabo';

  @override
  String get searchQuranHint => 'Search Quran, Surah, 2:255, Translation...';

  @override
  String get searchFiltersAndOptions => 'Filtri e opzioni di ricerca';

  @override
  String get exactPhrase => 'Frase esatta';

  @override
  String surahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sure trovate',
      one: '1 sura trovata',
    );
    return '$_temp0';
  }

  @override
  String ayahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count versetti trovati',
      one: '1 versetto trovato',
    );
    return '$_temp0';
  }

  @override
  String noMatchingSurahs(String query) {
    return 'No Surahs matching \"$query\"';
  }

  @override
  String get noResultsFound => 'Nessun risultato trovato';

  @override
  String get trySearchingFor =>
      'Try searching for a Surah name, verse number (e.g. 2:255), or topics';

  @override
  String allSurahsCount(int count) {
    return 'All Surahs ($count)';
  }

  @override
  String activeShortcutsCount(int count) {
    return 'Active Shortcuts ($count)';
  }

  @override
  String get noActiveShortcuts => 'Nessuna scorciatoia attiva trovata';

  @override
  String get customize => 'Personalizza';

  @override
  String get bismillahPreview => 'Anteprima di Bismillah';

  @override
  String get tajweedRules => 'Regole di Tajweed';

  @override
  String get makki => 'Meccana';

  @override
  String get madani => 'Medinese';

  @override
  String get exactPhraseMatch => 'Corrispondenza esatta della frase';

  @override
  String get matchExactWordsDesc =>
      'Abbina le parole esatte in sequenza continua';

  @override
  String get filterBySurah => 'Filtra per sura';

  @override
  String get all114SurahsEntireQuran => 'Tutte le 114 sure (Intero Corano)';

  @override
  String get revelationType => 'Luogo di rivelazione';

  @override
  String get searchInTranslations => 'Cerca nelle traduzioni';

  @override
  String get searchInTafsirs => 'Cerca nei tafsir';

  @override
  String activeCount(int selected, int total) {
    return '$selected/$total attivo/i';
  }

  @override
  String get recentSearches => 'Ricerche recenti';

  @override
  String get clearAll => 'Cancella tutto';

  @override
  String get searchGuideTitle => 'Cerca nel Sacro Corano';

  @override
  String get searchGuideDescription =>
      'Cerca per nome della sura, riferimento del versetto (es. 2:255) o parole nelle traduzioni e nei tafsir.';

  @override
  String get madani15Line => 'Madani a 15 righe';

  @override
  String get totalPagesCount => '604 Pagine';

  @override
  String get wordAudio => 'Audio per parola';

  @override
  String get offlineReady => 'Pronto offline';

  @override
  String get vectorFonts => 'Font vettoriali';

  @override
  String get madaniMushafLayout => 'Layout del Mushaf Madani';

  @override
  String get kfgqpcDescription =>
      'Complesso Re Fahd per la stampa del Corano (V4)';

  @override
  String get downloadingMushafPackage => 'Download del pacchetto Mushaf...';

  @override
  String get extractingAndInstallingData =>
      'Estrazione e installazione dei dati...';

  @override
  String get settingUpOfflinePages => 'Configurazione delle pagine offline...';

  @override
  String get fetchingLayoutArchive => 'Recupero dell\'archivio del layout...';

  @override
  String get keepAppOpenDuringDownload =>
      'Si prega di mantenere l\'app aperta fino al completamento del download.';

  @override
  String get downloadFailed => 'Download non riuscito';

  @override
  String get retryDownload => 'Riprova il download';

  @override
  String get packageSize => 'Dimensione del pacchetto';

  @override
  String get loadingMushafPage => 'Caricamento della pagina del Mushaf...';

  @override
  String get quickPageJump => 'Salto rapido di pagina';

  @override
  String get searchSurahHint => 'Cerca la sura per nome o numero...';

  @override
  String get fullscreen => 'Schermo intero';

  @override
  String get back => 'Indietro';

  @override
  String get script => 'Scrittura';

  @override
  String get muted => 'Disattivato';

  @override
  String get alerts => 'Avvisi';

  @override
  String get off => 'Spento';

  @override
  String get on => 'Acceso';

  @override
  String get homeAndLockWidgets => 'Widget Schermata Home e Blocco';

  @override
  String get glanceableWidgets => 'Widget a Colpo d\'Occhio';

  @override
  String get glanceableWidgetsDesc =>
      'Mostra i versetti quotidiani e gli orari di preghiera sulla schermata iniziale e di blocco.';

  @override
  String get ayahWidgetDisplayMode =>
      'Modalità di Visualizzazione Widget Versetto';

  @override
  String get dailyInspiringAyah =>
      'Versetto Ispiratore Quotidiano (Selezionato)';

  @override
  String get dailyInspiringAyahDesc =>
      'Cambia ogni giorno a mezzanotte con oltre 365 versetti profondi.';

  @override
  String get lastReadAyah => 'Ultimo Versetto Letto';

  @override
  String get lastReadAyahDesc =>
      'Si sincronizza con la tua ultima posizione di lettura per riprendere con un tocco.';

  @override
  String get pinnedCustomVerse => 'Versetto Personalizzato Fissato';

  @override
  String get randomDailyAyah => 'Versetto Giornaliero Casuale';

  @override
  String get randomDailyAyahDesc =>
      'Sceglie un versetto casuale ogni giorno per una nuova riflessione.';

  @override
  String get updateAllWidgetsNow => 'Aggiorna Tutti i Widget Ora';

  @override
  String get widgetsUpdatedSuccessfully => 'Widget aggiornati con successo!';

  @override
  String get ayahPinnedToWidgets =>
      'Versetto fissato sui Widget della Schermata Home e Blocco!';

  @override
  String get pinToWidgets => 'Fissa sui Widget';

  @override
  String get selectPinnedAyah => 'Seleziona Versetto da Fissare';

  @override
  String get saveAndApplyToWidget => 'Salva e Applica al Widget';

  @override
  String get howToAddWidgets => 'Come Aggiungere Widget';

  @override
  String get customizeWidgetAyahAndPrayers =>
      'Personalizza Versetto e Preghiere del Widget';

  @override
  String get customizeWidgetAyahAndPrayersDesc =>
      'Scegli tra versetti selezionati ogni giorno, ultimi letti o fissati';
}
