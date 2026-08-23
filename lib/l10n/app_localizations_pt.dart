// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
    return 'Tafsir não está disponível para $ayahKey';
  }

  @override
  String tafsirFoundAt(String anotherAyahLinkKey) {
    return 'O Tafsir será encontrado em: $anotherAyahLinkKey';
  }

  @override
  String tafsirJumpTo(String anotherAyahLinkKey) {
    return 'Ir para $anotherAyahLinkKey';
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
  String get languageSettings => 'Configurações de Idioma';

  @override
  String surahAyah(String surahName, String ayahKey) {
    return '$surahName $ayahKey';
  }

  @override
  String ayahsCount(String count) {
    return '$count Versículos';
  }

  @override
  String get saveAndDownload => 'Salvar e Baixar';

  @override
  String get appLanguage => 'Idioma do Aplicativo';

  @override
  String get selectAppLanguage => 'Selecione o idioma do aplicativo...';

  @override
  String get pleaseSelectOne => 'Por favor, selecione um';

  @override
  String get quranTranslationLanguage => 'Idioma da Tradução do Alcorão';

  @override
  String get selectTranslationLanguage => 'Selecione o idioma da tradução...';

  @override
  String get quranTranslationBook => 'Livro de Tradução do Alcorão';

  @override
  String get selectTranslationBook => 'Selecione o livro de tradução...';

  @override
  String get quranTafsirLanguage => 'Idioma do Tafsir do Alcorão';

  @override
  String get selectTafsirLanguage => 'Selecione o idioma do tafsir...';

  @override
  String get quranTafsirBook => 'Livro de Tafsir do Alcorão';

  @override
  String get selectTafsirBook => 'Selecione o livro de tafsir...';

  @override
  String get quranScriptAndStyle => 'Escrita e Estilo do Alcorão';

  @override
  String get justAMoment => 'Só um momento...';

  @override
  String processProgress(String processName, String percentage) {
    return '$processName $percentage';
  }

  @override
  String get success => 'Sucesso';

  @override
  String get retry => 'Tentar Novamente';

  @override
  String get unableToDownloadResources =>
      'Não foi possível baixar os recursos...\nAlgo deu errado';

  @override
  String get downloadingSegmentedQuranRecitation =>
      'Baixando Recitação Segmentada do Alcorão';

  @override
  String get processingSegmentedQuranRecitation =>
      'Processando Recitação Segmentada do Alcorão';

  @override
  String get footnote => 'Nota de Rodapé';

  @override
  String get tafsir => 'Tafsir';

  @override
  String get wordByWord => 'Palavra por Palavra';

  @override
  String get pleaseSelectRequiredOption =>
      'Por favor, selecione a opção necessária';

  @override
  String get rememberHomeTab => 'Lembrar Aba Inicial';

  @override
  String get rememberHomeTabSubtitle =>
      'O aplicativo lembrará a última aba aberta na tela inicial.';

  @override
  String get wakeLock => 'Manter Tela Ativa';

  @override
  String get wakeLockSubtitle => 'Impede que a tela se apague automaticamente.';

  @override
  String get settings => 'Configurações';

  @override
  String get appTheme => 'Tema do Aplicativo';

  @override
  String get quranStyle => 'Estilo do Alcorão';

  @override
  String get changeTheme => 'Mudar Tema';

  @override
  String get verseCount => 'Contagem de Versículos: ';

  @override
  String get translation => 'Tradução';

  @override
  String get tafsirNotFound => 'Não Encontrado';

  @override
  String get moreInfo => 'mais informações';

  @override
  String get playAudio => 'Reproduzir Áudio';

  @override
  String get preview => 'Pré-visualizar';

  @override
  String get loading => 'Carregando...';

  @override
  String get errorFetchingAddress => 'Erro ao buscar endereço';

  @override
  String get addressNotAvailable => 'Endereço não disponível';

  @override
  String get latitude => 'Latitude: ';

  @override
  String get longitude => 'Longitude: ';

  @override
  String get name => 'Nome: ';

  @override
  String get location => 'Localização: ';

  @override
  String get parameters => 'Parâmetros: ';

  @override
  String get selectCalculationMethod => 'Selecione o Método de Cálculo';

  @override
  String get shareSelectAyahs => 'Compartilhar Versículos Selecionados';

  @override
  String get selectionEmpty => 'Seleção Vazia';

  @override
  String get generatingImagePleaseWait =>
      'Gerando Imagem... Por Favor, Aguarde';

  @override
  String get asImage => 'Como Imagem';

  @override
  String get asText => 'Como Texto';

  @override
  String get playFromSelectedAyah =>
      'Reproduzir a Partir do Versículo Selecionado';

  @override
  String get toTafsir => 'Para o Tafsir';

  @override
  String get selectAyah => 'Selecionar Versículo';

  @override
  String get toAyah => 'Para o Versículo';

  @override
  String get searchForASurah => 'Procurar uma surata';

  @override
  String get bugReportTitle => 'Relatório de Erro';

  @override
  String get audioCached => 'Áudio em Cache';

  @override
  String get others => 'Outros';

  @override
  String get quranTranslationAyahOneMustEnabled =>
      'Alcorão|Tradução|Versículo, Um Deve Estar Ativado';

  @override
  String get quranFontSize => 'Tamanho da Fonte do Alcorão';

  @override
  String get quranLineHeight => 'Altura da Linha do Alcorão';

  @override
  String get translationAndTafsirFontSize =>
      'Tamanho da Fonte da Tradução e Tafsir';

  @override
  String get quranAyah => 'Versículo do Alcorão';

  @override
  String get topToolbar => 'Barra de Ferramentas Superior';

  @override
  String get keepOpenWordByWord => 'Manter Palavra por Palavra Aberto';

  @override
  String get wordByWordHighlight => 'Destaque Palavra por Palavra';

  @override
  String get quranScriptSettings => 'Configurações da Escrita do Alcorão';

  @override
  String surahName(String nameSimple) {
    return '$nameSimple';
  }

  @override
  String get pageNumber => 'Página: ';

  @override
  String get quranResources => 'Recursos do Alcorão';

  @override
  String alreadySelected(String name) {
    return 'O idioma \'$name\' já está selecionado.';
  }

  @override
  String get unableToGetCompassData =>
      'Não foi possível obter os dados da bússola';

  @override
  String get deviceDoesNotHaveSensors => 'O dispositivo não possui sensores!';

  @override
  String get north => 'N';

  @override
  String get east => 'L';

  @override
  String get south => 'S';

  @override
  String get west => 'O';

  @override
  String get address => 'Endereço: ';

  @override
  String get change => 'Alterar';

  @override
  String get calculationMethod => 'Método de Cálculo: ';

  @override
  String get downloadPrayerTime => 'Baixar Horários de Oração';

  @override
  String get calculationMethodsListEmpty =>
      'A lista de métodos de cálculo está vazia.';

  @override
  String get noCalculationMethodWithLocationData =>
      'Não foi possível encontrar nenhum método de cálculo com os dados de localização.';

  @override
  String get prayerSettings => 'Configurações de Oração';

  @override
  String get reminderSettings => 'Configurações de Lembrete';

  @override
  String get adjustReminderTime => 'Ajustar Hora do Lembrete';

  @override
  String get enforceAlarmSound => 'Forçar Som do Alarme';

  @override
  String get enforceAlarmSoundDescription =>
      'Se ativado, este recurso tocará o alarme no volume definido aqui, mesmo que o som do seu telefone esteja baixo. Isso garante que você não perca o alarme devido ao volume baixo do telefone.';

  @override
  String get volume => 'Volume';

  @override
  String get atPrayerTime => 'Na hora da oração';

  @override
  String minBefore(int minutes) {
    return '$minutes min antes';
  }

  @override
  String minAfter(int minutes) {
    return '$minutes min depois';
  }

  @override
  String prayerTimeIsAt(String prayerName, String prayerTime) {
    return 'A oração de $prayerName é às $prayerTime';
  }

  @override
  String itsTimeOf(String prayerName) {
    return 'É hora da oração de $prayerName';
  }

  @override
  String get stopTheAdhan => 'Parar o Adhan';

  @override
  String dateFoundEmpty(String date) {
    return 'Nenhum dado encontrado para $date';
  }

  @override
  String get today => 'Hoje';

  @override
  String get left => 'Faltam';

  @override
  String reminderAdded(String prayerName) {
    return 'Lembrete para $prayerName adicionado';
  }

  @override
  String get allowNotificationPermission =>
      'Por favor, permita a permissão de notificação para usar este recurso';

  @override
  String reminderRemoved(String prayerName) {
    return 'Lembrete para $prayerName removido';
  }

  @override
  String get getPrayerTimesAndQibla => 'Obter Horários de Oração e Qibla';

  @override
  String get getPrayerTimesAndQiblaDescription =>
      'Calcule os Horários de Oração e a Qibla para qualquer localização.';

  @override
  String get getFromGPS => 'Obter do GPS';

  @override
  String get or => 'Ou';

  @override
  String get selectYourCity => 'Selecione sua Cidade';

  @override
  String get noteAboutGPS =>
      'Nota: Se não quiser usar o GPS ou não se sentir seguro, pode selecionar a sua cidade.';

  @override
  String get downloadingLocationResources =>
      'Baixando recursos de localização...';

  @override
  String get somethingWentWrong => 'Algo deu errado';

  @override
  String get selectYourCountry => 'Selecione seu País';

  @override
  String get searchForACountry => 'Procurar um país';

  @override
  String get selectYourAdministrator => 'Selecione sua Região';

  @override
  String get searchForAnAdministrator => 'Procurar uma região';

  @override
  String get searchForACity => 'Procurar uma cidade';

  @override
  String get pleaseEnableLocationService =>
      'Por favor, ative o serviço de localização';

  @override
  String get donateUs => 'Faça uma Doação';

  @override
  String get underDevelopment => 'Em desenvolvimento';

  @override
  String get versionLoading => 'Carregando...';

  @override
  String get alQuran => 'Alcorão';

  @override
  String get mainMenu => 'Menu Principal';

  @override
  String get notes => 'Notas';

  @override
  String get pinned => 'Fixados';

  @override
  String get jumpToAyah => 'Ir para Versículo';

  @override
  String get shareMultipleAyah => 'Compartilhar Múltiplos Versículos';

  @override
  String get shareThisApp => 'Compartilhar este Aplicativo';

  @override
  String get giveRating => 'Avaliar';

  @override
  String get bugReport => 'Relatar Erro';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get aboutTheApp => 'Sobre o Aplicativo';

  @override
  String get resetTheApp => 'Redefinir o Aplicativo';

  @override
  String get resetAppWarningTitle => 'Redefinir Dados do Aplicativo';

  @override
  String get resetAppWarningMessage =>
      'Tem certeza de que deseja redefinir o aplicativo? Todos os seus dados serão perdidos e você precisará configurar o aplicativo desde o início.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Redefinir';

  @override
  String get shareAppSubject => 'Confira este aplicativo do Alcorão!';

  @override
  String shareAppBody(String appLink) {
    return 'Assalamualaikum! Confira este aplicativo do Alcorão para leitura e reflexão diária. Ele ajuda a se conectar com as palavras de Allah. Baixe aqui: $appLink';
  }

  @override
  String get openDrawerTooltip => 'Abrir Menu';

  @override
  String get quran => 'Alcorão';

  @override
  String get prayer => 'Oração';

  @override
  String get qibla => 'Qibla';

  @override
  String get audio => 'Áudio';

  @override
  String get surah => 'Surata';

  @override
  String get pages => 'Páginas';

  @override
  String get note => 'Nota:';

  @override
  String get linkedAyahs => 'Versículos Vinculados:';

  @override
  String get emptyNoteCollection =>
      'Esta coleção de notas está vazia.\nAdicione algumas notas para vê-las aqui.';

  @override
  String get emptyPinnedCollection =>
      'Nenhum versículo fixado nesta coleção ainda.\nFixe versículos para vê-los aqui.';

  @override
  String get noContentAvailable => 'Nenhum conteúdo disponível.';

  @override
  String failedToLoadCollections(String error) {
    return 'Falha ao carregar coleções: $error';
  }

  @override
  String searchByCollectionName(String collectionType) {
    return 'Buscar por Nome de $collectionType...';
  }

  @override
  String get sortBy => 'Ordenar por';

  @override
  String noCollectionAddedYet(String collectionType) {
    return 'Nenhuma $collectionType adicionada ainda';
  }

  @override
  String pinnedItemsCount(int count) {
    return '$count itens fixados';
  }

  @override
  String notesCount(int count) {
    return '$count notas';
  }

  @override
  String get emptyNameNotAllowed => 'Nome em branco não é permitido';

  @override
  String updatedTo(String collectionName) {
    return 'Atualizado para $collectionName';
  }

  @override
  String get changeName => 'Alterar Nome';

  @override
  String get changeColor => 'Alterar Cor';

  @override
  String get colorUpdated => 'Cor atualizada';

  @override
  String collectionDeleted(String collectionName) {
    return '$collectionName Excluída';
  }

  @override
  String get delete => 'Excluir';

  @override
  String get save => 'Salvar';

  @override
  String get collectionNameCannotBeEmpty =>
      'O nome da coleção não pode estar vazio.';

  @override
  String get addedNewCollection => 'Nova Coleção Adicionada';

  @override
  String ayahCount(int count) {
    return '$count Versículo';
  }

  @override
  String get byNameAtoZ => 'Nome A-Z';

  @override
  String get byNameZtoA => 'Nome Z-A';

  @override
  String get byElementNumberAscending => 'Número de Elementos Ascendente';

  @override
  String get byElementNumberDescending => 'Número de Elementos Descendente';

  @override
  String get byUpdateDateAscending => 'Data de Atualização Ascendente';

  @override
  String get byUpdateDateDescending => 'Data de Atualização Descendente';

  @override
  String get byCreateDateAscending => 'Data de Criação Ascendente';

  @override
  String get byCreateDateDescending => 'Data de Criação Descendente';

  @override
  String get translationNotFound => 'Tradução Não Encontrada';

  @override
  String get translationTitle => 'Tradução:';

  @override
  String get footNoteTitle => 'Nota de Rodapé:';

  @override
  String get wordByWordTranslation => 'Tradução Palavra por Palavra:';

  @override
  String get tafsirButton => 'Tafsir';

  @override
  String get shareButton => 'Compartilhar';

  @override
  String get addNoteButton => 'Adicionar Nota';

  @override
  String get pinToCollectionButton => 'Fixar na Coleção';

  @override
  String get shareAsText => 'Compartilhar como Texto';

  @override
  String get copiedWithTafsir => 'Copiado com Tafsir';

  @override
  String get shareAsImage => 'Compartilhar como Imagem';

  @override
  String get shareWithTafsir => 'Compartilhar com Tafsir';

  @override
  String get notFound => 'Não encontrado';

  @override
  String get noteContentCannotBeEmpty =>
      'O conteúdo da nota não pode estar vazio.';

  @override
  String get noteSavedSuccessfully => 'Nota salva com sucesso!';

  @override
  String get selectCollections => 'Selecionar Coleções';

  @override
  String get addNote => 'Adicionar Nota';

  @override
  String get writeCollectionName => 'Escreva o nome da coleção...';

  @override
  String get noCollectionsYetAddANewOne =>
      'Ainda não há coleções. Adicione uma nova!';

  @override
  String get pleaseWriteYourNoteFirst =>
      'Por favor, escreva sua nota primeiro.';

  @override
  String get noCollectionSelected => 'Nenhuma Coleção selecionada';

  @override
  String get saveNote => 'Salvar Nota';

  @override
  String get nextSelectCollections => 'Próximo: Selecionar Coleções';

  @override
  String get addToPinned => 'Adicionar aos Fixados';

  @override
  String get pinnedSavedSuccessfully => 'Fixado salvo com sucesso!';

  @override
  String get savePinned => 'Salvar Fixado';

  @override
  String get closeAudioController => 'Fechar Controlador de Áudio';

  @override
  String get previous => 'Anterior';

  @override
  String get rewind => 'Retroceder';

  @override
  String get fastForward => 'Avançar';

  @override
  String get playNextAyah => 'Reproduzir Próximo Versículo';

  @override
  String get repeat => 'Repetir';

  @override
  String get playAsPlaylist => 'Reproduzir como Playlist';

  @override
  String style(String style) {
    return 'Estilo: $style';
  }

  @override
  String get stopAndClose => 'Parar e Fechar';

  @override
  String get play => 'Reproduzir';

  @override
  String get pause => 'Pausar';

  @override
  String get selectReciter => 'Selecionar Recitador';

  @override
  String source(String source) {
    return 'Fonte: $source';
  }

  @override
  String get newText => 'Novo';

  @override
  String get more => 'Mais: ';

  @override
  String get cacheNotFound => 'Cache Não Encontrado';

  @override
  String get cacheSize => 'Tamanho do Cache';

  @override
  String error(String error) {
    return 'Erro: $error';
  }

  @override
  String get clean => 'Limpar';

  @override
  String get lastModified => 'Última Modificação';

  @override
  String get oneYearAgo => 'Há 1 ano';

  @override
  String monthsAgo(String number) {
    return 'Há $number meses';
  }

  @override
  String weeksAgo(String number) {
    return 'Há $number semanas';
  }

  @override
  String daysAgo(String number) {
    return 'Há $number dias';
  }

  @override
  String hoursAgo(int hour) {
    return 'Há $hour horas';
  }

  @override
  String get aboutAlQuran => 'Sobre o Alcorão';

  @override
  String get appFullName => 'Alcorão (Tafsir, Oração, Qibla, Áudio)';

  @override
  String get appDescription =>
      'Uma aplicação islâmica completa para Android, iOS, MacOS, Web, Linux e Windows, que oferece leitura do Alcorão com Tafsir e múltiplas traduções (incluindo palavra por palavra), horários de oração mundiais com notificações, bússola Qibla e recitação de áudio sincronizada palavra por palavra.';

  @override
  String get dataSourcesNote =>
      'Nota: Os textos do Alcorão, Tafsir, traduções e recursos de áudio são provenientes de Quran.com, Everyayah.com e outras fontes abertas verificadas.';

  @override
  String get adFreePromise =>
      'Este aplicativo foi construído para buscar o agrado de Allah. Portanto, é e sempre será completamente livre de anúncios.';

  @override
  String get coreFeatures => 'Recursos Principais';

  @override
  String get coreFeaturesDescription =>
      'Explore as funcionalidades chave que tornam o Alcorão v3 uma ferramenta indispensável para as suas práticas islâmicas diárias:';

  @override
  String get prayerTimesTitle => 'Horários de Oração e Alertas';

  @override
  String get prayerTimesDescription =>
      'Horários de oração precisos para qualquer local do mundo usando vários métodos de cálculo. Defina lembretes com notificações de Adhan.';

  @override
  String get qiblaDirectionTitle => 'Direção da Qibla';

  @override
  String get qiblaDirectionDescription =>
      'Encontre facilmente a direção da Qibla com uma visão de bússola clara e precisa.';

  @override
  String get translationTafsirTitle => 'Tradução e Tafsir do Alcorão';

  @override
  String get translationTafsirDescription =>
      'Acesse mais de 120 livros de tradução (incluindo palavra por palavra) em 69 idiomas e mais de 30 livros de Tafsir.';

  @override
  String get wordByWordAudioTitle => 'Áudio Palavra por Palavra e Destaque';

  @override
  String get wordByWordAudioDescription =>
      'Acompanhe a recitação de áudio sincronizada palavra por palavra e o destaque para uma experiência de aprendizado imersiva.';

  @override
  String get ayahAudioRecitationTitle => 'Recitação de Áudio do Versículo';

  @override
  String get ayahAudioRecitationDescription =>
      'Ouça recitações completas de versículos de mais de 40 recitadores renomados.';

  @override
  String get notesCloudBackupTitle => 'Notas com Backup em Nuvem';

  @override
  String get notesCloudBackupDescription =>
      'Salve notas e reflexões pessoais, com backup seguro na nuvem (recurso em desenvolvimento/em breve).';

  @override
  String get crossPlatformSupportTitle => 'Suporte Multiplataforma';

  @override
  String get crossPlatformSupportDescription =>
      'Suportado em Android, Web, Linux e Windows.';

  @override
  String get backgroundAudioPlaybackTitle =>
      'Reprodução de Áudio em Segundo Plano';

  @override
  String get backgroundAudioPlaybackDescription =>
      'Continue a ouvir a recitação do Alcorão mesmo quando o aplicativo está em segundo plano.';

  @override
  String get audioDataCachingTitle => 'Cache de Áudio e Dados';

  @override
  String get audioDataCachingDescription =>
      'Reprodução aprimorada e capacidades offline com cache robusto de áudio e dados do Alcorão.';

  @override
  String get minimalisticInterfaceTitle => 'Interface Minimalista e Limpa';

  @override
  String get minimalisticInterfaceDescription =>
      'Interface de fácil navegação com foco na experiência do usuário e legibilidade.';

  @override
  String get optimizedPerformanceTitle => 'Desempenho e Tamanho Otimizados';

  @override
  String get optimizedPerformanceDescription =>
      'Uma aplicação rica em recursos, projetada para ser leve e performática.';

  @override
  String get languageSupport => 'Suporte a Idiomas';

  @override
  String get languageSupportDescription =>
      'Esta aplicação foi projetada para ser acessível a um público global com suporte para os seguintes idiomas (e mais estão sendo continuamente adicionados):';

  @override
  String get technologyAndResources => 'Tecnologia e Recursos';

  @override
  String get technologyAndResourcesDescription =>
      'Este aplicativo é construído usando tecnologias de ponta e recursos confiáveis:';

  @override
  String get flutterFrameworkTitle => 'Framework Flutter';

  @override
  String get flutterFrameworkDescription =>
      'Construído com Flutter para uma experiência bonita, compilada nativamente e multiplataforma a partir de um único código-base.';

  @override
  String get advancedAudioEngineTitle => 'Motor de Áudio Avançado';

  @override
  String get advancedAudioEngineDescription =>
      'Alimentado pelos pacotes Flutter `just_audio` e `just_audio_background` para reprodução e controle de áudio robustos.';

  @override
  String get reliableQuranDataTitle => 'Dados Confiáveis do Alcorão';

  @override
  String get reliableQuranDataDescription =>
      'Os textos, traduções, tafsires e áudios do Alcorão são provenientes de APIs e bancos de dados abertos e verificados como Quran.com e Everyayah.com.';

  @override
  String get prayerTimeEngineTitle => 'Motor de Horários de Oração';

  @override
  String get prayerTimeEngineDescription =>
      'Utiliza métodos de cálculo estabelecidos para horários de oração precisos. As notificações são gerenciadas por `flutter_local_notifications` e tarefas em segundo plano.';

  @override
  String get crossPlatformSupport => 'Suporte Multiplataforma';

  @override
  String get crossPlatformSupportDescription2 =>
      'Desfrute de acesso contínuo em várias plataformas:';

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
  String get ourLifetimePromise => 'Nossa Promessa Vitalícia';

  @override
  String get lifetimePromiseDescription =>
      'Eu, pessoalmente, prometo fornecer suporte e manutenção contínuos para esta aplicação durante toda a minha vida, In Sha Allah. Meu objetivo é garantir que este aplicativo permaneça um recurso benéfico para a Ummah nos próximos anos.';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Nascer do sol';

  @override
  String get noon => 'Meio-dia';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get sunset => 'Pôr do sol';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get midnight => 'Meia-noite';

  @override
  String get alarm => 'Alarme';

  @override
  String get notification => 'Notificação';

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
  String get sajdaAyah => 'Versículo de Sajda';

  @override
  String get required => 'Obrigatório';

  @override
  String get optional => 'Opcional';

  @override
  String get notificationScheduleWarning =>
      'Observação: notificações ou lembretes agendados podem ser perdidos devido às restrições de processo em segundo plano do sistema operacional do seu telefone. Por exemplo: Origin OS da Vivo, One UI da Samsung, ColorOS do Oppo, etc., às vezes encerram notificações ou lembretes agendados. Verifique as configurações do seu sistema operacional para que o aplicativo não seja restringido do processo em segundo plano.';

  @override
  String get scrollWithRecitation => 'Rolar com recitação';

  @override
  String get quickAccess => 'Acesso rápido';

  @override
  String get initiallyScrollAyah => 'Inicialmente, role para o ayah';

  @override
  String get tajweedGuide => 'Guia de Tajweed';

  @override
  String get scrollWithRecitationDesc =>
      'Quando ativado, o ayah do Alcorão rolará automaticamente em sincronia com a recitação de áudio.';

  @override
  String get configuration => 'Configuração';

  @override
  String get restoreFromBackup => 'Restaurar do backup';

  @override
  String get history => 'História';

  @override
  String get search => 'Procurar';

  @override
  String get useAudioStream => 'Usar fluxo de áudio';

  @override
  String get useAudioStreamDesc =>
      'Transmita áudio diretamente da Internet em vez de fazer o download.';

  @override
  String get notUseAudioStreamDesc =>
      'Baixe o áudio para uso offline e reduza o consumo de dados.';

  @override
  String get audioSettings => 'Configurações de áudio';

  @override
  String get playbackSpeed => 'Velocidade de reprodução';

  @override
  String get playbackSpeedDesc =>
      'Ajuste a velocidade da Recitação do Alcorão.';

  @override
  String get waitForCurrentDownloadToFinish =>
      'Aguarde o download atual terminar.';

  @override
  String get areYouSure => 'Você tem certeza?';

  @override
  String get checkYourInternetConnection =>
      'Verifique sua conexão com a internet.';

  @override
  String audioDownloadAlert(int requiredDownload, int totalVersesCount) {
    return 'Precisa baixar $requiredDownload de $totalVersesCount ayahs.';
  }

  @override
  String get download => 'Baixar';

  @override
  String get audioDownload => 'Download de áudio';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get optimizingQuranScript => 'Otimizando o Roteiro do Alcorão';

  @override
  String get supportOnGithub => 'Apoie no GitHub';

  @override
  String get forbiddenSalatTimes => 'Horários de oração proibidos';

  @override
  String get prayerTimes => 'Horários de oração';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafie => 'Shafi\'i';

  @override
  String get suhurEnd => 'Fim do Suhur';

  @override
  String get iftarStart => 'Início do Iftar';

  @override
  String get tahajjudStart => 'Início do Tahajjud';

  @override
  String get tahajjud => 'Tahajjud';

  @override
  String get dhuha => 'Dhuha';

  @override
  String get indopakFont => 'Fonte Indopak';

  @override
  String get uthmaniFont => 'Fonte Uthmani';

  @override
  String get close => 'Fechar';

  @override
  String get goToSettings => 'Ir para configurações';

  @override
  String get scriptSettingsUpdated => 'Configurações de script atualizadas';

  @override
  String get scriptSettingsUpdatedDescription =>
      'Simplificamos nossas opções de script e adicionamos mais fontes.';

  @override
  String get enterPageNumber => 'Insira um número de página entre 1 e 604';

  @override
  String get deleteMushafData => 'Excluir dados do Mushaf';

  @override
  String get deleteMushafDataDescription =>
      'Tem certeza de que deseja excluir todos os dados do Mushaf?';

  @override
  String get invalidPage => 'Página inválida (1-604)';

  @override
  String get goToPage => 'Ir para a página';

  @override
  String get resources => 'Recursos';

  @override
  String get mushaf => 'Mushaf';

  @override
  String get circleJojomInQuranScript =>
      'Círculo Jojom/Sukun na escrita do Alcorão';

  @override
  String get copy => 'Copiar';

  @override
  String get share => 'Compartilhar';

  @override
  String get warningMessageOnIndopakTajweedEnable =>
      'Encontramos alguns problemas de renderização na cor do tajweed Indopak em algumas fontes. Portanto, você pode ver inconsistências na renderização das cores da escrita. Tem certeza de que deseja aplicar tajweed no Indopak?';

  @override
  String get apply => 'Aplicar';

  @override
  String get warning => 'Aviso';

  @override
  String get hijri => 'Hégira';

  @override
  String get gregorian => 'Gregoriano';

  @override
  String get prayerTimesCalender => 'Calendário de Horários de Oração';

  @override
  String get allowLocation => 'Permitir localização';

  @override
  String get allowLocationDescription =>
      'Atualiza automaticamente os horários de oração.';

  @override
  String get manualLocation => 'Localização manual';

  @override
  String get manualLocationDescription =>
      'Selecione manualmente o país e a cidade. Você precisa atualizar a localização se mudar de cidade.';

  @override
  String get selectLocation => 'Selecionar localização';

  @override
  String get selectCountry => 'Selecionar país';

  @override
  String get selectCity => 'Selecionar cidade';

  @override
  String get sunRising => 'Nascer do sol';

  @override
  String get sunSetting => 'Pôr do sol';

  @override
  String get sunTopOfTheHead => 'Sol no zênite';

  @override
  String get salatTime => 'Tempo de Oração';

  @override
  String get forbiddenSalatTime => 'Tempo de oração proibido';

  @override
  String get translationDatabase => 'Banco de dados de tradução';

  @override
  String get translationDatabaseSubtitle =>
      'Baixando texto de tradução selecionado';

  @override
  String get tafsirCommentary => 'Comentário Tafsir';

  @override
  String get tafsirCommentarySubtitle => 'Preparando recursos de tafsir';

  @override
  String get wordByWordAnalysis => 'Análise palavra por palavra';

  @override
  String get wordByWordAnalysisSubtitle =>
      'Configurando divisão de vocabulário';

  @override
  String get audioRecitationSegments => 'Segmentos de recitação de áudio';

  @override
  String get audioRecitationSegmentsSubtitle =>
      'Configurando segmentos de tempo de versos';

  @override
  String get locationQiblaMetadata => 'Metadados de localização e Qibla';

  @override
  String get locationQiblaMetadataSubtitle =>
      'Baixando dados de localização de cidades globais';

  @override
  String get preparingResources => 'Preparando recursos...';

  @override
  String get setupCompletedOpeningQuran =>
      'Configuração concluída! Abrindo o Al-Corão...';

  @override
  String get unexpectedErrorSetup =>
      'Ocorreu um erro inesperado durante a configuração.';

  @override
  String get heading => 'Rumo';

  @override
  String get alignedWithKaaba => 'Alinhado com a Caaba';

  @override
  String turnRight(Object degrees) {
    return 'Vire $degrees° à direita';
  }

  @override
  String turnLeft(Object degrees) {
    return 'Vire $degrees° à esquerda';
  }

  @override
  String get streamingAndNetwork => 'Transmissão e rede';

  @override
  String get next => 'Próximo';

  @override
  String get now => 'Agora';

  @override
  String get current => 'Atual';

  @override
  String get active => 'Ativo';

  @override
  String get activeNow => 'Ativo agora';

  @override
  String get hours => 'Horas';

  @override
  String get minutes => 'Minutos';

  @override
  String get seconds => 'Segundos';

  @override
  String get fastingAndVoluntaryTimes =>
      'Horários de jejum e orações voluntárias';

  @override
  String get imsak => 'Imsak';

  @override
  String get ishraqAndDuha => 'Ishraq e Duha';

  @override
  String get lastThirdOfNight => 'Último terço da noite';

  @override
  String get awqatAlNahy => 'Horários proibidos de oração';

  @override
  String get forbiddenSunriseDescription =>
      'Do nascer do sol até subir a altura de uma lança (~15 min)';

  @override
  String get forbiddenNoonDescription =>
      'Quando o sol está no zênite até o início de Dhuhr (~8 min)';

  @override
  String get forbiddenSunsetDescription =>
      'Quando o sol amarela até o pôr do sol completo (~15 min)';

  @override
  String get forbiddenTimesHadith =>
      'According to authentic Hadith in Sahih Muslim (832), \'Uqbah ibn \'Amir al-Juhani said:\n\n\"There are three times at which the Messenger of Allah (peace and blessings be upon him) forbade us to pray or to bury our dead:\n1. When the sun begins to rise until it is fully risen (~15 mins after sunrise).\n2. When the sun is at its height at midday until it has passed the meridian (~8-10 mins before Dhuhr).\n3. When the sun begins to set until it has completely set (~15 mins before Maghrib).\"';

  @override
  String get readMoreOnIslamQA => 'Ler fatwa completa no IslamQA';

  @override
  String get asrJurisprudence => 'Jurisprudência de Asr (Madhab)';

  @override
  String get shafieDescription => 'Padrão (Shafi\'i, Maliki, Hanbali)';

  @override
  String get hanafiDescription => 'Escola Hanafi';

  @override
  String get shafieShadow => 'Padrão (Sombra 1x)';

  @override
  String get hanafiShadow => 'Hanafi (Sombra 2x)';

  @override
  String get calculationAndJurisprudence => 'Cálculo e Jurisprudência';

  @override
  String get notificationsAndAudio => 'Notificações e Áudio';

  @override
  String get enablePrayerReminders => 'Ativar lembretes de oração';

  @override
  String get enablePrayerRemindersDescription =>
      'Receba alertas de notificação para todos os próximos horários de oração.';

  @override
  String get adjustReminderTimingDescription =>
      'Ajuste o horário do lembrete (+/- minutos do horário real).';

  @override
  String get exactTime => 'Horário exato';

  @override
  String actualTime(String time) {
    return 'Horário real: $time';
  }

  @override
  String get jumpToToday => 'Ir para hoje';

  @override
  String get dateAndHijri => 'Data / Hijri';

  @override
  String get selectedLocation => 'Localização selecionada';

  @override
  String nextPrayerLabel(String prayerName) {
    return 'Próxima: $prayerName';
  }

  @override
  String currentPrayerLabel(String prayerName) {
    return 'Agora: $prayerName';
  }

  @override
  String startsAt(String prayerName, String time) {
    return '$prayerName começa às $time';
  }

  @override
  String get continueReading => 'Continuar lendo';

  @override
  String get lastRead => 'Última leitura';

  @override
  String get resume => 'Retomar';

  @override
  String get startReading => 'Começar a ler';

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
  String get searchQuranHint => 'Search Quran, Surah, 2:255, Translation...';

  @override
  String get searchFiltersAndOptions => 'Filtros e opções de pesquisa';

  @override
  String get exactPhrase => 'Frase exata';

  @override
  String surahsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count suratas encontradas',
      one: '1 surata encontrada',
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
    return 'No Surahs matching \"$query\"';
  }

  @override
  String get noResultsFound => 'Nenhum resultado encontrado';

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
  String get noActiveShortcuts => 'Nenhum atalho ativo encontrado';

  @override
  String get customize => 'Personalizar';

  @override
  String get bismillahPreview => 'Pré-visualização de Bismillah';

  @override
  String get tajweedRules => 'Regras de Tajweed';

  @override
  String get makki => 'Mequense';

  @override
  String get madani => 'Medinense';

  @override
  String get exactPhraseMatch => 'Correspondência exata de frase';

  @override
  String get matchExactWordsDesc =>
      'Corresponder palavras exatas em sequência contínua';

  @override
  String get filterBySurah => 'Filtrar por surata';

  @override
  String get all114SurahsEntireQuran =>
      'Todas as 114 suratas (Alcorão completo)';

  @override
  String get revelationType => 'Local de revelação';

  @override
  String get searchInTranslations => 'Pesquisar nas traduções';

  @override
  String get searchInTafsirs => 'Pesquisar nos tafsirs';

  @override
  String activeCount(int selected, int total) {
    return '$selected/$total ativo(s)';
  }

  @override
  String get recentSearches => 'Pesquisas recentes';

  @override
  String get clearAll => 'Limpar tudo';

  @override
  String get searchGuideTitle => 'Pesquisar no Sagrado Alcorão';

  @override
  String get searchGuideDescription =>
      'Pesquise por nome de surata, referência de versículo (ex. 2:255) ou palavras em traduções e tafsir.';

  @override
  String get madani15Line => 'Madani de 15 linhas';

  @override
  String get totalPagesCount => '604 Páginas';

  @override
  String get wordAudio => 'Áudio por palavra';

  @override
  String get offlineReady => 'Pronto offline';

  @override
  String get vectorFonts => 'Fontes vetoriais';

  @override
  String get madaniMushafLayout => 'Layout do Mushaf Madani';

  @override
  String get kfgqpcDescription =>
      'Complexo do Rei Fahd para Impressão do Alcorão (V4)';

  @override
  String get downloadingMushafPackage => 'Baixando pacote do Mushaf...';

  @override
  String get extractingAndInstallingData => 'Extraindo e instalando dados...';

  @override
  String get settingUpOfflinePages => 'Configurando páginas offline...';

  @override
  String get fetchingLayoutArchive => 'Buscando arquivo de layout...';

  @override
  String get keepAppOpenDuringDownload =>
      'Por favor, mantenha o aplicativo aberto até que o download seja concluído.';

  @override
  String get downloadFailed => 'Falha no download';

  @override
  String get retryDownload => 'Tentar baixar novamente';

  @override
  String get packageSize => 'Tamanho do pacote';

  @override
  String get loadingMushafPage => 'Carregando página do Mushaf...';

  @override
  String get quickPageJump => 'Salto rápido de página';

  @override
  String get searchSurahHint => 'Pesquisar surata por nome ou número...';

  @override
  String get fullscreen => 'Tela cheia';

  @override
  String get back => 'Voltar';

  @override
  String get script => 'Escrita';

  @override
  String get muted => 'Silenciado';

  @override
  String get alerts => 'Alertas';

  @override
  String get off => 'Desligado';

  @override
  String get on => 'Ligado';

  @override
  String get homeAndLockWidgets => 'Widgets de Início e Bloqueio';

  @override
  String get glanceableWidgets => 'Widgets Rápidos';

  @override
  String get glanceableWidgetsDesc =>
      'Exiba versículos diários e horários de oração na tela inicial e na tela de bloqueio.';

  @override
  String get ayahWidgetDisplayMode =>
      'Modo de Exibição do Widget de Versículos';

  @override
  String get dailyInspiringAyah => 'Versículo Inspirador Diário (Selecionado)';

  @override
  String get dailyInspiringAyahDesc =>
      'Muda todos os dias à meia-noite com mais de 365 versículos profundos.';

  @override
  String get lastReadAyah => 'Último Versículo Lido';

  @override
  String get lastReadAyahDesc =>
      'Sincroniza com sua última posição de leitura para retomar com 1 toque.';

  @override
  String get pinnedCustomVerse => 'Versículo Personalizado Fixado';

  @override
  String get randomDailyAyah => 'Versículo Diário Aleatório';

  @override
  String get randomDailyAyahDesc =>
      'Escolhe um versículo aleatório todos os dias para uma nova reflexão.';

  @override
  String get updateAllWidgetsNow => 'Atualizar Todos os Widgets Agora';

  @override
  String get widgetsUpdatedSuccessfully => 'Widgets atualizados com sucesso!';

  @override
  String get ayahPinnedToWidgets =>
      'Versículo fixado nos Widgets de Início e Bloqueio!';

  @override
  String get pinToWidgets => 'Fixar nos Widgets';

  @override
  String get selectPinnedAyah => 'Selecionar Versículo para Fixar';

  @override
  String get saveAndApplyToWidget => 'Salvar e Aplicar ao Widget';

  @override
  String get howToAddWidgets => 'Como Adicionar Widgets';

  @override
  String get customizeWidgetAyahAndPrayers =>
      'Personalizar Versículos e Orações do Widget';

  @override
  String get customizeWidgetAyahAndPrayersDesc =>
      'Escolha entre versículos selecionados diários, últimos lidos ou fixados';

  @override
  String get accountAndSync => 'Conta e Sincronização na Nuvem';

  @override
  String get signIn => 'Entrar';

  @override
  String get signUp => 'Criar Conta';

  @override
  String get signOut => 'Sair';

  @override
  String get deleteAccount => 'Excluir Conta e Dados';

  @override
  String get deleteAccountTitle => 'Excluir Conta?';

  @override
  String get deleteAccountWarning =>
      'Isso excluirá permanentemente sua conta e todas as suas notas, favoritos e histórico de leitura sincronizados na nuvem. Esta ação não pode ser desfeita.';

  @override
  String get deleteAccountConfirm => 'Sim, Excluir Tudo';

  @override
  String get syncNow => 'Sincronizar Agora';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get syncSuccess => 'Dados sincronizados com sucesso!';

  @override
  String get syncFailed =>
      'Falha na sincronização. Verifique sua conexão com a internet.';

  @override
  String get googleSignIn => 'Continuar com o Google';

  @override
  String get email => 'Endereço de E-mail';

  @override
  String get password => 'Senha';

  @override
  String get fullName => 'Nome Completo';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get sendResetLink => 'Enviar Link de Redefinição';

  @override
  String get resetPasswordEmailSent =>
      'Link de redefinição de senha enviado para seu e-mail!';

  @override
  String get continueAsGuest => 'Continuar como Convidado';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta? Entrar';

  @override
  String get dontHaveAccount => 'Não tem uma conta? Cadastre-se';

  @override
  String get privacyPolicyNotice =>
      'Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.';

  @override
  String get guestUser => 'Usuário Convidado';

  @override
  String get syncedCloudBackup => 'Sincronização na Nuvem';

  @override
  String get syncedCloudBackupDesc =>
      'Mantenha suas notas, pins e histórico de leitura sincronizados em todos os seus dispositivos.';

  @override
  String get alHadith => 'Al Hadith';

  @override
  String get hadithCompanion => 'Companheiro';

  @override
  String get hadithCompanionDesc =>
      'Sahih al-Bukhari, Muslim e coleções autênticas de hadiths.';

  @override
  String get open => 'Abrir';

  @override
  String get install => 'Instalar';

  @override
  String get companionApps => 'Aplicativos Companheiros';

  @override
  String get hadithCollectionsBrief => 'Bukhari, Muslim e mais';

  @override
  String get explore => 'Explorar';

  @override
  String get ourIslamicCompanionApps =>
      'Nossos Aplicativos Islâmicos Companheiros';

  @override
  String get ourIslamicCompanionAppsDesc =>
      'Desenvolvido puramente pelo amor de Allah (Sadaqah Jariyah) com uma experiência 100% gratuita e sem anúncios para a Ummah Muçulmana.';
}
