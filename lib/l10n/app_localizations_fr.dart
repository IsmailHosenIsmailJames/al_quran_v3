// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

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
    return 'Le tafsir n\'est pas disponible pour $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'Le tafsir se trouve à : $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Aller à $anotherAyahLinkKey';
  }

  @override
  String get hizb => 'Hizb';

  @override
  String get juz => 'Juz';

  @override
  String get page => 'Page';

  @override
  String get ruku => 'Ruku';

  @override
  String get languageSettings => 'Paramètres de langue';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count versets';
  }

  @override
  String get saveAndDownload => 'Enregistrer et télécharger';

  @override
  String get appLanguage => 'Langue de l\'app';

  @override
  String get selectAppLanguage => 'Sélectionnez la langue de l\'app...';

  @override
  String get pleaseSelectOne => 'Veuillez en sélectionner une';

  @override
  String get quranTranslationLanguage => 'Langue de traduction du Coran';

  @override
  String get selectTranslationLanguage =>
      'Sélectionnez la langue de traduction...';

  @override
  String get quranTranslationBook => 'Livre de traduction du Coran';

  @override
  String get selectTranslationBook => 'Sélectionnez le livre de traduction...';

  @override
  String get quranTafsirLanguage => 'Langue du tafsir du Coran';

  @override
  String get selectTafsirLanguage => 'Sélectionnez la langue du tafsir...';

  @override
  String get quranTafsirBook => 'Livre de tafsir du Coran';

  @override
  String get selectTafsirBook => 'Sélectionnez le livre de tafsir...';

  @override
  String get quranScriptAndStyle => 'Écriture et style du Coran';

  @override
  String get justAMoment => 'Un instant...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Succès';

  @override
  String get retry => 'Réessayer';

  @override
  String get unableToDownloadResources =>
      'Impossible de télécharger les ressources...\nQuelque chose s\'est mal passé';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Téléchargement de la récitation segmentée du Coran';

  @override
  String get processingSegmentedQuranRecitation =>
      'Traitement de la récitation segmentée du Coran';

  @override
  String get footnote => 'Note de bas de page';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Mot par mot';

  @override
  String get pleaseSelectRequiredOption =>
      'Veuillez sélectionner l\'option requise';

  @override
  String get rememberHomeTab => 'Se souvenir de l\'onglet d\'accueil';

  @override
  String get rememberHomeTabSubtitle =>
      'L\'app se souviendra du dernier onglet ouvert sur l\'écran d\'accueil.';

  @override
  String get wakeLock => 'Verrouillage d\'écran';

  @override
  String get wakeLockSubtitle =>
      'Empêche l\'écran de s\'éteindre automatiquement.';

  @override
  String get settings => 'Paramètres';

  @override
  String get appTheme => 'Thème de l\'app';

  @override
  String get quranStyle => 'Style du Coran';

  @override
  String get changeTheme => 'Changer de thème';

  @override
  String get verseCount => 'Nombre de versets : ';

  @override
  String get translation => 'Traduction';

  @override
  String get tafsirNotFound => 'Non trouvé';

  @override
  String get moreInfo => 'plus d\'infos';

  @override
  String get playAudio => 'Lire l\'audio';

  @override
  String get preview => 'Aperçu';

  @override
  String get loading => 'Chargement...';

  @override
  String get errorFetchingAddress =>
      'Erreur lors de la récupération de l\'adresse';

  @override
  String get addressNotAvailable => 'Adresse non disponible';

  @override
  String get latitude => 'Latitude : ';

  @override
  String get longitude => 'Longitude : ';

  @override
  String get name => 'Nom : ';

  @override
  String get location => 'Emplacement : ';

  @override
  String get parameters => 'Paramètres : ';

  @override
  String get selectCalculationMethod => 'Sélectionnez la méthode de calcul';

  @override
  String get shareSelectAyahs => 'Partager les versets sélectionnés';

  @override
  String get selectionEmpty => 'Sélection vide';

  @override
  String get generatingImagePleaseWait =>
      'Génération de l\'image... Veuillez patienter';

  @override
  String get asImage => 'Sous forme d\'image';

  @override
  String get asText => 'Sous forme de texte';

  @override
  String get playFromSelectedAyah => 'Lire à partir du verset sélectionné';

  @override
  String get toTafsir => 'Au tafsir';

  @override
  String get selectAyah => 'Sélectionnez un verset';

  @override
  String get toAyah => 'Au verset';

  @override
  String get searchForASurah => 'Rechercher une sourate';

  @override
  String get bugReportTitle => 'Rapport de bug';

  @override
  String get audioCached => 'Audio mis en cache';

  @override
  String get others => 'Autres';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Coran|Traduction|Verset, un doit être activé';

  @override
  String get quranFontSize => 'Taille de police du Coran';

  @override
  String get quranLineHeight => 'Hauteur de ligne du Coran';

  @override
  String get translationAndTafsirFontSize =>
      'Taille de police de la traduction et du tafsir';

  @override
  String get quranAyah => 'Verset du Coran';

  @override
  String get topToolbar => 'Barre d\'outils supérieure';

  @override
  String get keepOpenWordByWord => 'Garder ouvert mot par mot';

  @override
  String get wordByWordHighlight => 'Surlignage mot par mot';

  @override
  String get quranScriptSettings => 'Paramètres d\'écriture du Coran';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Page : ';

  @override
  String get quranResources => 'Ressources du Coran';

  @override
  String alreadySelected(String name) {
    return 'La langue \'$name\' est déjà sélectionnée.';
  }

  @override
  String get unableToGetCompassData =>
      'Impossible d\'obtenir les données de la boussole';

  @override
  String get deviceDoesNotHaveSensors => 'L\'appareil n\'a pas de capteurs !';

  @override
  String get north => 'N';

  @override
  String get east => 'E';

  @override
  String get south => 'S';

  @override
  String get west => 'O';

  @override
  String get address => 'Adresse : ';

  @override
  String get change => 'Changer';

  @override
  String get calculationMethod => 'Méthode de calcul : ';

  @override
  String get downloadPrayerTime => 'Télécharger les horaires de prière';

  @override
  String get calculationMethodsListEmpty =>
      'La liste des méthodes de calcul est vide.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Aucune méthode de calcul avec données de localisation n\'a été trouvée.';

  @override
  String get prayerSettings => 'Paramètres de prière';

  @override
  String get reminderSettings => 'Paramètres de rappel';

  @override
  String get adjustReminderTime => 'Ajuster l\'heure de rappel';

  @override
  String get enforceAlarmSound => 'Forcer le son de l\'alarme';

  @override
  String get enforceAlarmSoundDescription =>
      'Si activé, cette fonction jouera l\'alarme au volume défini ici, même si le son de votre téléphone est bas. Cela assure que vous ne manquiez pas l\'alarme à cause d\'un volume faible.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'À l\'heure de la prière';

  @override
  String minBefore(int minutes) {
    return '$minutes min avant';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min après';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return '$prayerName est à $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'C\'est l\'heure de $prayerName';
  }

  @override
  String get stopTheAdhan => 'Arrêter l\'Adhan';

  @override
  String dateFoundEmpty(String date) {
    return '$date trouvé vide';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get left => 'Restant';

  @override
  String reminderAdded(String prayerName) {
    return 'Rappel pour $prayerName ajouté';
  }

  @override
  String get allowNotificationPermission =>
      'Veuillez autoriser la permission de notification pour utiliser cette fonction';

  @override
  String reminderRemoved(String prayerName) {
    return 'Rappel pour $prayerName supprimé';
  }

  @override
  String get getPrayerTimesAndQibla =>
      'Obtenir les horaires de prière et la Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calculez les horaires de prière et la Qibla pour n\'importe quel emplacement.';

  @override
  String get getFromGPS => 'Obtenir via GPS';

  @override
  String get or => 'Ou';

  @override
  String get selectYourCity => 'Sélectionnez votre ville';

  @override
  String get noteAboutGPS =>
      'Note : Si vous ne voulez pas utiliser le GPS ou ne vous sentez pas en sécurité, vous pouvez sélectionner votre ville.';

  @override
  String get downloadingLocationResources =>
      'Téléchargement des ressources de localisation...';

  @override
  String get somethingWentWrong => 'Quelque chose s\'est mal passé';

  @override
  String get selectYourCountry => 'Sélectionnez votre pays';

  @override
  String get searchForACountry => 'Rechercher un pays';

  @override
  String get selectYourAdministrator => 'Sélectionnez votre administrateur';

  @override
  String get searchForAnAdministrator => 'Rechercher un administrateur';

  @override
  String get searchForACity => 'Rechercher une ville';

  @override
  String get pleaseEnableLocationService =>
      'Veuillez activer le service de localisation';

  @override
  String get donateUs => 'Faites-nous un don';

  @override
  String get underDevelopment => 'En développement';

  @override
  String get versionLoading => 'Chargement...';

  @override
  String get alQuran => 'Al Coran';

  @override
  String get mainMenu => 'Menu principal';

  @override
  String get notes => 'Notes';

  @override
  String get pinned => 'Épinglé';

  @override
  String get jumpToAyah => 'Aller au verset';

  @override
  String get shareMultipleAyah => 'Partager plusieurs versets';

  @override
  String get shareThisApp => 'Partager cette app';

  @override
  String get giveRating => 'Donner une note';

  @override
  String get bugReport => 'Rapport de bug';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get aboutTheApp => 'À propos de l\'app';

  @override
  String get resetTheApp => 'Réinitialiser l\'app';

  @override
  String get resetAppWarningTitle => 'Réinitialiser les données de l\'app';

  @override
  String get resetAppWarningMessage =>
      'Êtes-vous sûr de vouloir réinitialiser l\'app ? Toutes vos données seront perdues, et vous devrez configurer l\'app depuis le début.';

  @override
  String get cancel => 'Annuler';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get shareAppSubject => 'Découvrez cette app Al Coran !';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum ! Découvrez cette app Al Coran pour une lecture et une réflexion quotidiennes. Elle aide à se connecter avec les paroles d\'Allah. Téléchargez ici : $appLink';
  }

  @override
  String get openDrawerTooltip => 'Ouvrir le tiroir';

  @override
  String get quran => 'Coran';

  @override
  String get prayer => 'Prière';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Audio';

  @override
  String get surah => 'Sourate';

  @override
  String get pages => 'Pages';

  @override
  String get note => 'Note :';

  @override
  String get linkedAyahs => 'Versets liés :';

  @override
  String get emptyNoteCollection =>
      'Cette collection de notes est vide.\nAjoutez des notes pour les voir ici.';

  @override
  String get emptyPinnedCollection =>
      'Aucun verset épinglé dans cette collection pour l\'instant.\nÉpinglez des versets pour les voir ici.';

  @override
  String get noContentAvailable => 'Aucun contenu disponible.';

  @override
  String failedToLoadCollections(String error) {
    return 'Échec du chargement des collections : $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Rechercher par nom de $collectionType...';
  }

  @override
  String get sortBy => 'Trier par';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Aucune $collectionType ajoutée pour l\'instant';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count éléments épinglés';
  }

  @override
  String notesCount(int count) {
    return '$count notes';
  }

  @override
  String get emptyNameNotAllowed => 'Nom vide non autorisé';

  @override
  String updatedTo(String collectionName) {
    return 'Mis à jour vers $collectionName';
  }

  @override
  String get changeName => 'Changer le nom';

  @override
  String get changeColor => 'Changer la couleur';

  @override
  String get colorUpdated => 'Couleur mise à jour';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName supprimé';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get save => 'Enregistrer';

  @override
  String get collectionNameCannotBeEmpty =>
      'Le nom de la collection ne peut pas être vide.';

  @override
  String get addedNewCollection => 'Nouvelle collection ajoutée';

  @override
  String ayahCount(int count) {
    return '$count verset';
  }

  @override
  String get byNameAtoZ => 'Nom A-Z';

  @override
  String get byNameZtoA => 'Nom Z-A';

  @override
  String get byElementNumberAscending => 'Numéro d\'élément croissant';

  @override
  String get byElementNumberDescending => 'Numéro d\'élément décroissant';

  @override
  String get byUpdateDateAscending => 'Date de mise à jour croissante';

  @override
  String get byUpdateDateDescending => 'Date de mise à jour décroissante';

  @override
  String get byCreateDateAscending => 'Date de création croissante';

  @override
  String get byCreateDateDescending => 'Date de création décroissante';

  @override
  String get translationNotFound => 'Traduction non trouvée';

  @override
  String get translationTitle => 'Traduction :';

  @override
  String get footNoteTitle => 'Note de bas de page :';

  @override
  String get wordByWordTranslation => 'Traduction mot par mot :';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Partager';

  @override
  String get addNoteButton => 'Ajouter une note';

  @override
  String get pinToCollectionButton => 'Épingler à la collection';

  @override
  String get shareAsText => 'Partager sous forme de texte';

  @override
  String get copiedWithTafsir => 'Copié avec tafsir';

  @override
  String get shareAsImage => 'Partager sous forme d\'image';

  @override
  String get shareWithTafsir => 'Partager avec tafsir';

  @override
  String get notFound => 'Non trouvé';

  @override
  String get noteContentCannotBeEmpty =>
      'Le contenu de la note ne peut pas être vide.';

  @override
  String get noteSavedSuccessfully => 'Note enregistrée avec succès !';

  @override
  String get selectCollections => 'Sélectionnez les collections';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get writeCollectionName => 'Écrivez le nom de la collection...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Aucune collection pour l\'instant. Ajoutez-en une nouvelle !';

  @override
  String get pleaseWriteYourNoteFirst => 'Veuillez d\'abord écrire votre note.';

  @override
  String get noCollectionSelected => 'Aucune collection sélectionnée';

  @override
  String get saveNote => 'Enregistrer la note';

  @override
  String get nextSelectCollections => 'Suivant : Sélectionnez les collections';

  @override
  String get addToPinned => 'Ajouter aux épinglés';

  @override
  String get pinnedSavedSuccessfully => 'Épinglé enregistré avec succès !';

  @override
  String get savePinned => 'Enregistrer l\'épinglé';

  @override
  String get closeAudioController => 'Fermer le contrôleur audio';

  @override
  String get previous => 'Précédent';

  @override
  String get rewind => 'Rembobiner';

  @override
  String get fastForward => 'Avancer rapidement';

  @override
  String get playNextAyah => 'Lire le verset suivant';

  @override
  String get repeat => 'Répéter';

  @override
  String get playAsPlaylist => 'Lire comme playlist';

  @override
  String style(String style) {
    return 'Style : $style';
  }

  @override
  String get stopAndClose => 'Arrêter et fermer';

  @override
  String get play => 'Lire';

  @override
  String get pause => 'Pause';

  @override
  String get selectReciter => 'Sélectionnez le récitateur';

  @override
  String source(String source) {
    return 'Source : $source';
  }

  @override
  String get newText => 'Nouveau';

  @override
  String get more => 'Plus : ';

  @override
  String get cacheNotFound => 'Cache non trouvé';

  @override
  String get cacheSize => 'Taille du cache';

  @override
  String error(String error) {
    return 'Erreur : $error';
  }

  @override
  String get clean => 'Nettoyer';

  @override
  String get lastModified => 'Dernière modification';

  @override
  String get oneYearAgo => 'Il y a 1 an';

  @override
  String monthsAgo(String number) {
    return 'Il y a $number mois';
  }

  @override
  String weeksAgo(String number) {
    return 'Il y a $number semaines';
  }

  @override
  String daysAgo(String number) {
    return 'Il y a $number jours';
  }

  @override
  String hoursAgo(int hour) {
    return 'Il y a $hour heures';
  }

  @override
  String get aboutAlQuran => 'À propos d\'Al Coran';

  @override
  String get appFullName => 'Al Coran (Tafsir, Prière, Qibla, Audio)';

  @override
  String get appDescription =>
      'Une application islamique complète pour Android, iOS, MacOS, Web, Linux et Windows, offrant la lecture du Coran avec tafsir et plusieurs traductions (y compris mot par mot), les horaires de prière mondiaux avec notifications, une boussole Qibla, et une récitation audio mot par mot synchronisée.';

  @override
  String get dataSourcesNote =>
      'Note : Les textes du Coran, tafsir, traductions et ressources audio proviennent de Quran.com, Everyayah.com et d\'autres sources ouvertes vérifiées.';

  @override
  String get adFreePromise =>
      'Cette app a été créée pour chercher le plaisir d\'Allah. Elle est et restera toujours sans publicité.';

  @override
  String get coreFeatures => 'Fonctionnalités principales';

  @override
  String get coreFeaturesDescription =>
      'Découvrez les fonctionnalités clés qui font d\'Al Coran v3 un outil indispensable pour vos pratiques islamiques quotidiennes :';

  @override
  String get prayerTimesTitle => 'Horaires de prière et alertes';

  @override
  String get prayerTimesDescription =>
      'Horaires de prière précis pour n\'importe quel emplacement mondial en utilisant diverses méthodes de calcul. Définissez des rappels avec notifications d\'Adhan.';

  @override
  String get qiblaDirectionTitle => 'Direction de la Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Trouvez facilement la direction de la Qibla avec une vue claire et précise de la boussole.';

  @override
  String get translationTafsirTitle => 'Traduction et tafsir du Coran';

  @override
  String get translationTafsirDescription =>
      'Accédez à plus de 120 livres de traduction (y compris mot par mot) en 69 langues, et plus de 30 livres de tafsir.';

  @override
  String get wordByWordAudioTitle => 'Audio et surlignage mot par mot';

  @override
  String get wordByWordAudioDescription =>
      'Suivez avec une récitation audio mot par mot synchronisée et un surlignage pour une expérience d\'apprentissage immersive.';

  @override
  String get ayahAudioRecitationTitle => 'Récitation audio des versets';

  @override
  String get ayahAudioRecitationDescription =>
      'Écoutez des récitations complètes de versets par plus de 40 récitateurs renommés.';

  @override
  String get notesCloudBackupTitle => 'Notes avec sauvegarde cloud';

  @override
  String get notesCloudBackupDescription =>
      'Enregistrez des notes et réflexions personnelles, sécurisées avec sauvegarde cloud (fonction en développement/bientôt disponible).';

  @override
  String get crossPlatformSupportTitle => 'Support multiplateforme';

  @override
  String get crossPlatformSupportDescription =>
      'Supporté sur Android, Web, Linux et Windows.';

  @override
  String get backgroundAudioPlaybackTitle => 'Lecture audio en arrière-plan';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continuez à écouter la récitation du Coran même quand l\'app est en arrière-plan.';

  @override
  String get audioDataCachingTitle => 'Mise en cache audio et données';

  @override
  String get audioDataCachingDescription =>
      'Amélioration de la lecture et des capacités hors ligne avec une mise en cache robuste des données audio et du Coran.';

  @override
  String get minimalisticInterfaceTitle => 'Interface minimaliste et propre';

  @override
  String get minimalisticInterfaceDescription =>
      'Interface facile à naviguer avec un focus sur l\'expérience utilisateur et la lisibilité.';

  @override
  String get optimizedPerformanceTitle => 'Performance et taille optimisées';

  @override
  String get optimizedPerformanceDescription =>
      'Une application riche en fonctionnalités conçue pour être légère et performante.';

  @override
  String get languageSupport => 'Support linguistique';

  @override
  String get languageSupportDescription =>
      'Cette application est conçue pour être accessible à un public mondial avec support pour les langues suivantes (et d\'autres sont ajoutées en continu) :';

  @override
  String get technologyAndResources => 'Technologie et ressources';

  @override
  String get technologyAndResourcesDescription =>
      'Cette app est construite avec des technologies de pointe et des ressources fiables :';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Construite avec Flutter pour une expérience belle, compilée nativement, multiplateforme à partir d\'une base de code unique.';

  @override
  String get advancedAudioEngineTitle => 'Moteur audio avancé';

  @override
  String get advancedAudioEngineDescription =>
      'Alimenté par les packages Flutter `just_audio` et `just_audio_background` pour une lecture et un contrôle audio robustes.';

  @override
  String get reliableQuranDataTitle => 'Données du Coran fiables';

  @override
  String get reliableQuranDataDescription =>
      'Les textes, traductions, tafsirs et audio du Coran proviennent d\'APIs ouvertes vérifiées et de bases de données comme Quran.com & Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Moteur d\'horaires de prière';

  @override
  String get prayerTimeEngineDescription =>
      'Utilise des méthodes de calcul établies pour des horaires de prière précis. Notifications gérées par `flutter_local_notifications` et tâches en arrière-plan.';

  @override
  String get crossPlatformSupport => 'Support multiplateforme';

  @override
  String get crossPlatformSupportDescription2 =>
      'Profitez d\'un accès fluide sur diverses plateformes :';

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
  String get ourLifetimePromise => 'Notre promesse à vie';

  @override
  String get lifetimePromiseDescription =>
      'Je promets personnellement de fournir un support et une maintenance continus pour cette application tout au long de ma vie, In Sha Allah. Mon objectif est de m\'assurer que cette app reste une ressource bénéfique pour l\'Ummah pendant des années.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Lever du soleil';

  @override
  String get noon => 'Midi';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Coucher du soleil';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Minuit';

  @override
  String get alarm => 'Alarme';

  @override
  String get notification => 'Notification';

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
  String get sajdaAyah => 'Verset de Sajda';

  @override
  String get required => 'Requis';

  @override
  String get optional => 'Optionnel';

  @override
  String get notificationScheduleWarning =>
      'Note : Les notifications ou rappels programmés peuvent être manqués en raison des restrictions de processus en arrière-plan de votre OS téléphone. Par exemple : Origin OS de Vivo, One UI de Samsung, ColorOS d\'Oppo etc. tuent parfois les notifications ou rappels programmés. Vérifiez les paramètres de votre OS pour que l\'app ne soit pas restreinte des processus en arrière-plan.';

  @override
  String get scrollWithRecitation => 'Défiler avec la récitation';

  @override
  String get quickAccess => 'Accès rapide';

  @override
  String get initiallyScrollAyah => 'Défiler initialement au verset';

  @override
  String get tajweedGuide => 'Guide Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Quand activé, le verset du Coran défilera automatiquement en sync avec la récitation audio.';

  @override
  String get configuration => 'Configuration';

  @override
  String get restoreFromBackup => 'Restaurer depuis la sauvegarde';

  @override
  String get history => 'Historique';

  @override
  String get search => 'Rechercher';

  @override
  String get useAudioStream => 'Utiliser le flux audio';

  @override
  String get useAudioStreamDesc =>
      'Diffuser l\'audio directement depuis internet au lieu de télécharger.';

  @override
  String get notUseAudioStreamDesc =>
      'Télécharger l\'audio pour une utilisation hors ligne et réduire la consommation de données.';

  @override
  String get audioSettings => 'Paramètres audio';

  @override
  String get playbackSpeed => 'Vitesse de lecture';

  @override
  String get playbackSpeedDesc =>
      'Ajustez la vitesse de la récitation du Coran.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Veuillez attendre la fin du téléchargement en cours.';

  @override
  String get areYouSure => 'Êtes-vous sûr ?';

  @override
  String get checkYourInternetConnection =>
      'Vérifiez votre connexion internet.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Besoin de télécharger $requiredDownload sur $totalVersesCount versets.';
  }

  @override
  String get download => 'Télécharger';

  @override
  String get audioDownload => 'Téléchargement audio';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Optimisation de l\'écriture du Coran';

  @override
  String get supportOnGithub => 'Soutenir sur GitHub';

  @override
  String get forbiddenSalatTimes => 'Heures de prière interdites';

  @override
  String get prayerTimes => 'Horaires des prières';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafi\'i';

  @override
  String get suhurEnd => 'Fin du Suhur';

  @override
  String get iftarStart => 'Début de l\'Iftar';

  @override
  String get tahajjudStart => 'Début du Tahajjud';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';
}
