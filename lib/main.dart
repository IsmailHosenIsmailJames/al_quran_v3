import "dart:async";
import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart"
    as platform_services;
import "package:flutter/cupertino.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_main_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:just_audio_media_kit/just_audio_media_kit.dart";

String? applicationDataPath;
platform_services.PlatformOwn platformOwn = platform_services.getPlatform();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  platform_services.initializePlatform();

  if (platformOwn != platform_services.PlatformOwn.isLinux &&
      platformOwn != platform_services.PlatformOwn.isWindows &&
      !kIsWeb) {
    await platform_services.initAwesomeNotification();

    JustAudioBackground.init(
      androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
      androidNotificationChannelName: "Quran Audio Playback",
      androidNotificationOngoing: true,
      androidNotificationIcon: "mipmap/launcher_icon",
    );
  } else {
    // Windows and Linux media-kit
    try {
      JustAudioMediaKit.ensureInitialized();
      JustAudioMediaKit.bufferSize = 8 * 1024 * 1024; // 8 MB
      JustAudioMediaKit.title = "Al Quran Audio";
    } catch (e) {
      log("Unable to config JustAudioMediaKit: $e");
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

  await loadMetaSurah();
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

  runApp(
    MyApp(initialLocale: initialLocale),
  );
  platform_services.hideLoadingIndicator();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

TextTheme getTextTheme(Locale locale, bool isDarkMode) {
  final textTheme = isDarkMode
      ? ThemeData.dark().textTheme
      : ThemeData.light().textTheme;
  switch (locale.languageCode) {
    case "ar":
    case "fa":
    case "ug":
      return GoogleFonts.notoSansArabicTextTheme(textTheme);
    case "ur":
      return GoogleFonts.notoNastaliqUrduTextTheme(textTheme);
    case "bn":
      return GoogleFonts.notoSansBengaliTextTheme(textTheme);
    default:
      return GoogleFonts.notoSansTextTheme(textTheme);
  }
}

class MyApp extends StatelessWidget {
  final MyAppLocalization initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    const pageTransitionsTheme = PageTransitionsTheme(
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
        BlocProvider(create: (context) => getIt<SegmentedQuranReciterCubit>()),
        BlocProvider(create: (context) => getIt<PlayerStateCubit>()),
        BlocProvider(create: (context) => getIt<WordPlayingStateCubit>()),
        BlocProvider(create: (context) => getIt<AudioTabReciterCubit>()),
        BlocProvider(create: (context) => getIt<QuranViewCubit>()),
        BlocProvider(
          create: (context) => getIt<LanguageCubit>(param1: initialLocale),
        ),
        BlocProvider(create: (context) => getIt<AudioDownloadCubit>()),
        BlocProvider(create: (context) => getIt<AudioLoopCubit>()),
        BlocProvider(create: (context) => getIt<SleepTimerCubit>()),
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
                onGenerateTitle: (context) => "Al Quran Audio",
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
                    titleSpacing: 16,
                    iconTheme: IconThemeData(color: Colors.grey.shade800),
                  ),
                ),
                darkTheme: ThemeData(brightness: Brightness.dark).copyWith(
                  scaffoldBackgroundColor: const Color(0xFF0F0F0F),
                  cardColor: const Color(0xFF161616),
                  dividerColor: Colors.grey.shade800,
                  pageTransitionsTheme: pageTransitionsTheme,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary,
                    brightness: Brightness.dark,
                  ).copyWith(
                    surface: const Color(0xFF161616),
                  ),
                  dialogTheme: const DialogThemeData(
                    backgroundColor: Color(0xFF1E1E1E),
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
                    backgroundColor: Color(0xFF1E1E1E),
                    surfaceTintColor: Colors.transparent,
                  ),
                  textTheme: getTextTheme(languageState.locale, true),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF0F0F0F),
                    surfaceTintColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    titleSpacing: 16,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                ),
                themeMode: themeState.themeMode,
                home: const AudioMainScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
