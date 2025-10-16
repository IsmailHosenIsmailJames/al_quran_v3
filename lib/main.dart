import "dart:convert";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/get_location_data.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/segmented_resources_manager.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/collections/collection_page.dart";
import "package:al_quran_v3/src/screen/home/home_page.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/landscape_scroll_effect.dart";
import "package:al_quran_v3/src/screen/search/cubit/search_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/widget/history/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:just_audio_media_kit/just_audio_media_kit.dart";

import "src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "src/screen/prayer_time/functions/prayers_time_function.dart";

Map<String, dynamic> quranScript = {};

Map<String, dynamic> metaDataJuz = {};
List<Map> metaDataSajda = [];
Map<String, dynamic> metaDataSurah = {};
Map<String, dynamic> surahNameLocalization = {};
Map<String, dynamic> surahMeaningLocalization = {};

Future<void> loadQuranScript(QuranScriptType scriptType) async {
  switch (scriptType) {
    case QuranScriptType.tajweed:
      quranScript = jsonDecode(
        await rootBundle.loadString(
          "assets/quran_script/QPC_Hafs_Tajweed_Compress.json",
        ),
      );
    case QuranScriptType.uthmani:
      quranScript = jsonDecode(
        await rootBundle.loadString("assets/quran_script/Uthmani.json"),
      );
    case QuranScriptType.indopak:
      quranScript = jsonDecode(
        await rootBundle.loadString("assets/quran_script/Indopak.json"),
      );
  }
}

String? applicationDataPath;
platform_services.PlatformOwn platformOwn = platform_services.getPlatform();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await platform_services.initializePlatform();

  if (platformOwn != platform_services.PlatformOwn.isLinux &&
      platformOwn != platform_services.PlatformOwn.isWindows) {
    await platform_services.initAwesomeNotification();

    await JustAudioBackground.init(
      androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true,
    );
  } else {
    // by default, windows and linux are enabled
    JustAudioMediaKit.ensureInitialized();
    JustAudioMediaKit.bufferSize = 8 * 1024 * 1024; // 8 MB
    JustAudioMediaKit.title = "Al Quran Audio";
  }
  applicationDataPath = await platform_services.getApplicationDataPath();

  if (platformOwn == platform_services.PlatformOwn.isWindows ||
      platformOwn == platform_services.PlatformOwn.isLinux ||
      platformOwn == platform_services.PlatformOwn.isMac) {
    Hive.init("${applicationDataPath!}/db");
  } else {
    await Hive.initFlutter();
  }

  await Hive.openBox("user");
  await Hive.openBox("segmented_quran_recitation");

  await QuranTranslationFunction.init();
  await WordByWordFunction.init();
  await Hive.openBox(CollectionType.notes.name);
  await Hive.openBox(CollectionType.pinned.name);
  await SegmentedResourcesManager.init();
  await PrayersTimeFunction.init();

  await loadQuranScript(
    QuranScriptType.values.firstWhere(
      (element) =>
          Hive.box("user").get(
            "selected_quran_script_type",
            defaultValue: QuranScriptType.values.first.name,
          ) ==
          element.name,
    ),
  );

  metaDataJuz = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Juz.json"),
  );
  metaDataSurah = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Surah.json"),
  );

  surahNameLocalization = jsonDecode(
    await rootBundle.loadString(
      "assets/meta_data/surah_name_localization.json",
    ),
  );

  surahMeaningLocalization = jsonDecode(
    await rootBundle.loadString(
      "assets/meta_data/surah_meaning_localization.json",
    ),
  );

  await ThemeFunctions.initThemeFunction();

  PrayerReminderState prayerReminderState = PrayerReminderState(
    prayerToRemember: PrayersTimeFunction.getListOfPrayerToRemember(),
    previousReminderModes: PrayersTimeFunction.getPreviousReminderModes(),
    reminderTimeAdjustment: PrayersTimeFunction.getAdjustReminderTime(),
    enforceAlarmSound: PrayersTimeFunction.getEnforceAlarmSound(),
    soundVolume: PrayersTimeFunction.getSoundVolume(),
  );

  LocationQiblaPrayerDataState locationQiblaPrayerDataState =
      await getSavedLocation();

  MyAppLocalization initialLocale = await LanguageCubit.getInitialLocale();

  runApp(
    MyApp(
      initialLocale: initialLocale,
      prayerReminderState: prayerReminderState,
      locationQiblaPrayerDataState: locationQiblaPrayerDataState,
    ),
  );
  platform_services.hideLoadingIndicator();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

TextTheme getTextTheme(Locale locale, bool isDarkMode) {
  TextTheme baseTextTheme;
  switch (locale.languageCode) {
    case 'ar':
    case 'fa':
    case 'ug': // Uighur
      baseTextTheme = GoogleFonts.notoSansArabicTextTheme();
      break;
    case 'ur':
      baseTextTheme = GoogleFonts.notoNastaliqUrduTextTheme();
      break;
    case 'bn':
    case 'as': // Assamese
      baseTextTheme = GoogleFonts.notoSansBengaliTextTheme();
      break;
    case 'hi':
    case 'mr': // Marathi
    case 'ne': // Nepali
      baseTextTheme = GoogleFonts.notoSansDevanagariTextTheme();
      break;
    case 'ja':
      baseTextTheme = GoogleFonts.notoSansJpTextTheme();
      break;
    case 'ko':
      baseTextTheme = GoogleFonts.notoSansKrTextTheme();
      break;
    case 'zh':
      baseTextTheme = GoogleFonts.notoSansScTextTheme();
      break;
    case 'ta': // Tamil
      baseTextTheme = GoogleFonts.notoSansTamilTextTheme();
      break;
    case 'te': // Telugu
      baseTextTheme = GoogleFonts.notoSansTeluguTextTheme();
      break;
    case 'kn': // Kannada
      baseTextTheme = GoogleFonts.notoSansKannadaTextTheme();
      break;
    case 'ml': // Malayalam
      baseTextTheme = GoogleFonts.notoSansMalayalamTextTheme();
      break;
    case 'gu': // Gujarati
      baseTextTheme = GoogleFonts.notoSansGujaratiTextTheme();
      break;
    case 'si': // Sinhala
      baseTextTheme = GoogleFonts.notoSansSinhalaTextTheme();
      break;
    case 'th': // Thai
      baseTextTheme = GoogleFonts.notoSansThaiTextTheme();
      break;
    case 'km': // Khmer
      baseTextTheme = GoogleFonts.notoSansKhmerTextTheme();
      break;
    case 'he': // Hebrew
      baseTextTheme = GoogleFonts.notoSansHebrewTextTheme();
      break;
    case 'am': // Amharic
      baseTextTheme = GoogleFonts.notoSansEthiopicTextTheme();
      break;
    case 'dv': // Divehi
      baseTextTheme = GoogleFonts.notoSansThaanaTextTheme();
      break;
    case 'zgh': // Amazigh
      baseTextTheme = GoogleFonts.notoSansTifinaghTextTheme();
      break;
    default:
      baseTextTheme = GoogleFonts.notoSansBengaliTextTheme();
  }

  return baseTextTheme.apply(
    bodyColor: isDarkMode ? Colors.white : Colors.black,
    displayColor: isDarkMode ? Colors.white : Colors.black,
    decorationColor: isDarkMode ? Colors.white : Colors.black,
  );
}

class MyApp extends StatelessWidget {
  final MyAppLocalization initialLocale;
  final PrayerReminderState prayerReminderState;
  final LocationQiblaPrayerDataState locationQiblaPrayerDataState;

  const MyApp({
    super.key,
    required this.initialLocale,
    required this.prayerReminderState,
    required this.locationQiblaPrayerDataState,
  });

  @override
  Widget build(BuildContext context) {
    final PageTransitionsTheme pageTransitionsTheme =
        const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          },
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ResourcesProgressCubitCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => AyahByAyahInScrollInfoCubit()),
        BlocProvider(
          create:
              (context) => LocationQiblaPrayerDataCubit(
                initState: locationQiblaPrayerDataState,
              ),
        ),
        BlocProvider(create: (context) => SegmentedQuranReciterCubit()),
        BlocProvider(create: (context) => PlayerStateCubit(PlayerState())),
        BlocProvider(create: (context) => WordPlayingStateCubit()),
        BlocProvider(create: (context) => AudioTabReciterCubit()),
        BlocProvider(create: (context) => AyahByAyahInScrollInfoCubit()),
        BlocProvider(create: (context) => QuranViewCubit()),
        BlocProvider(
          create:
              (context) => PrayerReminderCubit(initState: prayerReminderState),
        ),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => OthersSettingsCubit()),
        BlocProvider(create: (context) => LanguageCubit(initialLocale)),
        BlocProvider(create: (context) => LandscapeScrollEffect()),
        BlocProvider(create: (context) => QuickAccessCubit()),
        BlocProvider(create: (context) => QuranHistoryCubit()),
        BlocProvider(create: (context) => AudioDownloadCubit()),
        BlocProvider(create: (context) => AyahToHighlight(null)),
      ],

      child: BlocBuilder<LanguageCubit, MyAppLocalization>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: languageState.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateTitle: (context) => "Al Quran App",
                theme: ThemeData(brightness: Brightness.light).copyWith(
                  pageTransitionsTheme: pageTransitionsTheme,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary,
                    brightness: Brightness.light,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeState.primary,
                      foregroundColor: Colors.white,
                      iconColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
                  bottomSheetTheme: BottomSheetThemeData(
                    backgroundColor: Colors.grey.shade100,
                  ),
                  textTheme: getTextTheme(languageState.locale, false),
                ),
                darkTheme: ThemeData(brightness: Brightness.dark).copyWith(
                  pageTransitionsTheme: pageTransitionsTheme,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary,
                    brightness: Brightness.dark,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeState.primary,
                      foregroundColor: Colors.white,
                      iconColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
                  bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Color.fromARGB(255, 15, 15, 15),
                  ),
                  textTheme: getTextTheme(languageState.locale, true),
                ),
                themeMode: themeState.themeMode,
                home:
                    Hive.box(
                          "user",
                        ).get("is_setup_complete", defaultValue: false)
                        ? const HomePage()
                        : const AppSetupPage(),
              );
            },
          );
        },
      ),
    );
  }
}
