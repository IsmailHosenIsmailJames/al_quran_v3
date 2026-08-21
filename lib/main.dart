import "dart:developer";

import "package:al_quran_v3/firebase_options.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_cubit.dart";
import "package:firebase_core/firebase_core.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart"
    as platform_services;
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/word_by_word_function.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/prayer_background_worker.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/screens/setup_screen.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_page.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/home/presentation/screens/home_page.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/landscape_scroll_effect.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:just_audio_media_kit/just_audio_media_kit.dart";

import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";

String? applicationDataPath;
platform_services.PlatformOwn platformOwn = platform_services.getPlatform();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (kIsWeb ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint("Firebase initialization skipped: $e");
    }
  }

  platform_services.initializePlatform();

  if (platformOwn != platform_services.PlatformOwn.isLinux &&
      platformOwn != platform_services.PlatformOwn.isWindows &&
      !kIsWeb) {
    await platform_services.initAwesomeNotification();

    JustAudioBackground.init(
      androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true,
      androidNotificationIcon: "mipmap/ic_launcher",
    );
  } else {
    // by default, windows and linux are enabled
    try {
      JustAudioMediaKit.ensureInitialized();
      JustAudioMediaKit.bufferSize = 8 * 1024 * 1024; // 8 MB
      JustAudioMediaKit.title = "Al Quran Audio";
    } catch (e) {
      log("Unable To Config JustAudioMediaKit with error: $e");
    }
  }
  applicationDataPath = await platform_services.getApplicationDataPath();

  if (platformOwn == platform_services.PlatformOwn.isWindows ||
      platformOwn == platform_services.PlatformOwn.isLinux) {
    Hive.init("${applicationDataPath!}/db");
  } else {
    await Hive.initFlutter();
  }

  await Hive.openBox("user");
  await configureDependencies();

  MyAppLocalization initialLocale = await LanguageCubit.getInitialLocale();

  await QuranTranslationFunction.init(locale: initialLocale.locale);
  await WordByWordFunction.init();
  await Hive.openBox(CollectionType.notes.name);
  await Hive.openBox(CollectionType.pinned.name);
  await SegmentedResourcesManager.init();

  final scriptOnDb = Hive.box("user").get(
    "selected_quran_script_type",
    defaultValue: QuranScriptType.values.first.name,
  );

  await QuranScriptFunction.loadScript(
    QuranScriptType.values.firstOrNullWhere(
          (element) => scriptOnDb == element.name,
        ) ??
        QuranScriptType.uthmani,
  );

  await ThemeFunctions.initThemeFunction();

  LocationQiblaPrayerDataState locationQiblaPrayerDataState =
      await LocationQiblaPrayerDataCubit.getSavedState();

  if (platformOwn != platform_services.PlatformOwn.isLinux &&
      platformOwn != platform_services.PlatformOwn.isWindows &&
      !kIsWeb) {
    await ReminderScheduler.init();
    PrayerBackgroundWorker.registerWorker();
  }

  runApp(
    MyApp(
      initialLocale: initialLocale,
      locationQiblaPrayerDataState: locationQiblaPrayerDataState,
    ),
  );
  platform_services.hideLoadingIndicator();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

TextTheme getTextTheme(Locale locale, bool isDarkMode) {
  final textTheme = isDarkMode
      ? ThemeData.dark().textTheme
      : ThemeData.light().textTheme;
  TextTheme baseTextTheme;
  switch (locale.languageCode) {
    case "ar":
    case "fa":
    case "ug": // Uighur
      baseTextTheme = GoogleFonts.notoSansArabicTextTheme(textTheme);
      break;
    case "ur":
      baseTextTheme = GoogleFonts.notoNastaliqUrduTextTheme(textTheme);
      break;
    case "bn":
    case "as": // Assamese
      baseTextTheme = GoogleFonts.notoSansBengaliTextTheme(textTheme);
      break;
    case "hi":
    case "mr": // Marathi
    case "ne": // Nepali
      baseTextTheme = GoogleFonts.notoSansDevanagariTextTheme(textTheme);
      break;
    case "ja":
      baseTextTheme = GoogleFonts.notoSansJpTextTheme(textTheme);
      break;
    case "ko":
      baseTextTheme = GoogleFonts.notoSansKrTextTheme(textTheme);
      break;
    case "zh":
      baseTextTheme = GoogleFonts.notoSansScTextTheme(textTheme);
      break;
    case "ta": // Tamil
      baseTextTheme = GoogleFonts.notoSansTamilTextTheme(textTheme);
      break;
    case "te": // Telugu
      baseTextTheme = GoogleFonts.notoSansTeluguTextTheme(textTheme);
      break;
    case "kn": // Kannada
      baseTextTheme = GoogleFonts.notoSansKannadaTextTheme(textTheme);
      break;
    case "ml": // Malayalam
      baseTextTheme = GoogleFonts.notoSansMalayalamTextTheme(textTheme);
      break;
    case "gu": // Gujarati
      baseTextTheme = GoogleFonts.notoSansGujaratiTextTheme(textTheme);
      break;
    case "si": // Sinhala
      baseTextTheme = GoogleFonts.notoSansSinhalaTextTheme(textTheme);
      break;
    case "th": // Thai
      baseTextTheme = GoogleFonts.notoSansThaiTextTheme(textTheme);
      break;
    case "km": // Khmer
      baseTextTheme = GoogleFonts.notoSansKhmerTextTheme(textTheme);
      break;
    case "he": // Hebrew
      baseTextTheme = GoogleFonts.notoSansHebrewTextTheme(textTheme);
      break;
    case "am": // Amharic
      baseTextTheme = GoogleFonts.notoSansEthiopicTextTheme(textTheme);
      break;
    case "dv": // Divehi
      baseTextTheme = GoogleFonts.notoSansThaanaTextTheme(textTheme);
      break;
    case "zgh": // Amazigh
      baseTextTheme = GoogleFonts.notoSansTifinaghTextTheme(textTheme);
      break;
    default:
      baseTextTheme = GoogleFonts.notoSansBengaliTextTheme(textTheme);
  }

  return baseTextTheme;
}

class MyApp extends StatelessWidget {
  final MyAppLocalization initialLocale;
  final LocationQiblaPrayerDataState locationQiblaPrayerDataState;

  const MyApp({
    super.key,
    required this.initialLocale,
    required this.locationQiblaPrayerDataState,
  });

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
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
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<AudioUiCubit>()),
        BlocProvider(create: (context) => getIt<PlayerPositionCubit>()),
        BlocProvider(create: (context) => getIt<AyahKeyCubit>()),
        BlocProvider(create: (context) => getIt<AyahByAyahInScrollInfoCubit>()),
        BlocProvider(
          create: (context) => getIt<LocationQiblaPrayerDataCubit>(
            param1: locationQiblaPrayerDataState,
          ),
        ),
        BlocProvider(create: (context) => getIt<SegmentedQuranReciterCubit>()),
        BlocProvider(create: (context) => getIt<PlayerStateCubit>()),
        BlocProvider(create: (context) => getIt<WordPlayingStateCubit>()),
        BlocProvider(create: (context) => getIt<AudioTabReciterCubit>()),
        BlocProvider(create: (context) => getIt<QuranViewCubit>()),
        BlocProvider(create: (context) => getIt<PrayerReminderCubit>()),
        BlocProvider(create: (context) => getIt<OthersSettingsCubit>()),
        BlocProvider(
          create: (context) => getIt<LanguageCubit>(param1: initialLocale),
        ),
        BlocProvider(create: (context) => getIt<LandscapeScrollEffect>()),
        BlocProvider(create: (context) => getIt<QuickAccessCubit>()),
        BlocProvider(create: (context) => getIt<QuranHistoryCubit>()),
        BlocProvider(create: (context) => getIt<AudioDownloadCubit>()),
        BlocProvider(create: (context) => getIt<AudioLoopCubit>()),
        BlocProvider(create: (context) => getIt<AyahToHighlight>()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<SyncCubit>()),
      ],

      child: BlocBuilder<LanguageCubit, MyAppLocalization>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                color: themeState.primary,
                locale: languageState.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateTitle: (context) => "Quran's Tafsir, Audio & Prayer",
                theme: ThemeData(brightness: Brightness.light).copyWith(
                  scaffoldBackgroundColor: const Color(0xFFF9FAFB),
                  cardColor: Colors.white,
                  dividerColor: Colors.grey.shade200,
                  pageTransitionsTheme: pageTransitionsTheme,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary,
                    brightness: Brightness.light,
                  ).copyWith(surface: Colors.white),
                  dialogTheme: const DialogThemeData(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
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
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                  ),
                  textTheme: getTextTheme(languageState.locale, false),
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    titleSpacing: 0,
                    iconTheme: IconThemeData(color: Colors.grey.shade800),
                  ),
                  chipTheme: ChipThemeData(
                    checkmarkColor: Colors.white,
                    selectedColor: themeState.primary,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                    secondaryLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    selectedItemColor: themeState.primary,
                    unselectedItemColor: Colors.grey.shade600,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
                darkTheme: ThemeData(brightness: Brightness.dark).copyWith(
                  scaffoldBackgroundColor: const Color(0xFF121212),
                  cardColor: const Color(0xFF181818),
                  dividerColor: Colors.white.withValues(alpha: 0.08),
                  pageTransitionsTheme: pageTransitionsTheme,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary,
                    brightness: Brightness.dark,
                  ).copyWith(surface: const Color(0xFF181818)),
                  dialogTheme: const DialogThemeData(
                    backgroundColor: Color(0xFF181818),
                    surfaceTintColor: Colors.transparent,
                  ),
                  chipTheme: ChipThemeData(
                    checkmarkColor: Colors.white,
                    selectedColor: themeState.primary,
                    backgroundColor: const Color(0xFF1E1E1E),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade300,
                    ),
                    secondaryLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
                    backgroundColor: Color(0xFF181818),
                    surfaceTintColor: Colors.transparent,
                  ),
                  textTheme: getTextTheme(languageState.locale, true),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF121212),
                    surfaceTintColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    titleSpacing: 0,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: const Color(0xFF121212),
                    elevation: 0,
                    selectedItemColor: themeState.primary,
                    unselectedItemColor: Colors.grey.shade400,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
                themeMode: themeState.themeMode,
                home: isSetupComplete()
                    ? const HomePage()
                    : const SetupScreen(),
              );
            },
          );
        },
      ),
    );
  }

  bool isSetupComplete() {
    final userBox = Hive.box("user");
    return userBox.get("is_setup_complete", defaultValue: false);
  }
}
