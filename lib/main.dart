import "dart:convert";

import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/screen/audio/audio_page.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/language_cubit.dart"; // Import LanguageCubit
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/functions/theme_functions.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/adapters.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:flutter_localizations/flutter_localizations.dart"; // Added import
import "app_localizations.dart"; // Updated import for generated file

Map<String, dynamic> tajweedScript = {};

Map<String, dynamic> metaDataSurah = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
    androidNotificationChannelName: "Audio playback",
    androidNotificationOngoing: true,
  );
  await Hive.initFlutter();
  await Hive.openBox("user");
  tajweedScript = jsonDecode(
    await rootBundle.loadString("assets/quran_script/QPC_Hafs_Tajweed.json"),
  );

  metaDataSurah = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Surah.json"),
  );

  await ThemeFunctions.initThemeFunction();

  final initialLocale = await LanguageCubit.getInitialLocale(); // Get initial locale

  runApp(MyApp(initialLocale: initialLocale)); // Pass initial locale to MyApp
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Locale initialLocale; // Add initialLocale field
  const MyApp({super.key, required this.initialLocale}); // Update constructor

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
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => PlayerStateCubit(PlayerState())),
        BlocProvider(create: (context) => AudioTabReciterCubit()),
        BlocProvider(create: (context) => QuranViewCubit()),
        BlocProvider(create: (context) => LanguageCubit(initialLocale)), // Provide LanguageCubit
        BlocProvider(
          create:
              (context) => QuranReciterCubit(
                initReciter: ReciterInfoModel.fromMap(
                  Hive.box("user").get("reciter", defaultValue: null) ??
                      recitationsInfoList[0],
                ),
              ),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>( // Listen to LanguageCubit
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) { // Renamed state to themeState
              return MaterialApp(
                navigatorKey: navigatorKey,
                locale: languageState.locale, // Set locale from LanguageCubit
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) {
                  return AppLocalizations.of(context)!.appTitle;
                },
                // title: "Al Quran Audio", // Replaced by onGenerateTitle
                theme: ThemeData(
                  brightness: Brightness.light,
              fontFamily: "NotoSans",
            ).copyWith(
              pageTransitionsTheme: pageTransitionsTheme,
              colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary, // Use themeState
                brightness: Brightness.light,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                      backgroundColor: themeState.primary, // Use themeState
                  foregroundColor: Colors.white,
                  iconColor: Colors.white,
                  elevation: 0,
                ),
              ),
              bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: "NotoSans",
            ).copyWith(
              pageTransitionsTheme: pageTransitionsTheme,
              colorScheme: ColorScheme.fromSeed(
                    seedColor: themeState.primary, // Use themeState
                brightness: Brightness.dark,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                      backgroundColor: themeState.primary, // Use themeState
                  foregroundColor: Colors.white,
                  iconColor: Colors.white,
                  elevation: 0,
                ),
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color.fromARGB(255, 15, 15, 15),
              ),
            ),
            localizationsDelegates: const [ // Added delegates
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [ // Updated locales
              Locale("en"), // English
              Locale("bn"), // Bengali
              Locale("ar"), // Arabic
              Locale("hi"), // Hindi
              Locale("ur"), // Urdu
              Locale("es"), // Spanish
            ],
                themeMode: themeState.themeMode, // Use themeState
            home: const AudioPage(),
          );
        },
      ),
    );
  }
}
