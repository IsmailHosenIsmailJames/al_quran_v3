import "dart:convert";
import "dart:io";

import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/notification/init_awesome_notification.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/collections/collection_page.dart";
import "package:al_quran_v3/src/screen/home/home_page.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/prayers_time_bg_process.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/search/cubit/search_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/download_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import "package:alarm/alarm.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/adapters.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:window_manager/window_manager.dart";
import "package:workmanager/workmanager.dart";

Map<String, dynamic> tajweedScript = {};
Map<String, dynamic> uthmaniScript = {};
Map<String, dynamic> indopakScript = {};

Map<String, dynamic> metaDataHizb = {};
Map<String, dynamic> metaDataJuz = {};
Map<String, dynamic> metaDataManzil = {};
Map<String, dynamic> metaDataRub = {};
Map<String, dynamic> metaDataRuku = {};
Map<String, dynamic> metaDataSajda = {};
Map<String, dynamic> metaDataSurah = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAwesomeNotification();
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(600, 900),
      maximumSize: Size(1000, 1900),
      minimumSize: Size(400, 700),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  await JustAudioBackground.init(
    androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
    androidNotificationChannelName: "Audio playback",
    androidNotificationOngoing: true,
  );
  await Hive.initFlutter();
  await Hive.openBox("quran_translation");
  await Hive.openBox("user");
  await Hive.openBox("quran_word_by_word");
  await Hive.openBox("segmented_quran_recitation");
  await Hive.openBox("surah_info");
  await Hive.openBox(CollectionType.notes.name);
  await Hive.openBox(CollectionType.pinned.name);
  tajweedScript = jsonDecode(
    await rootBundle.loadString("assets/quran_script/QPC_Hafs_Tajweed.json"),
  );
  uthmaniScript = jsonDecode(
    await rootBundle.loadString("assets/quran_script/Uthmani.json"),
  );
  indopakScript = jsonDecode(
    await rootBundle.loadString("assets/quran_script/Indopak.json"),
  );
  metaDataHizb = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Hizb.json"),
  );
  metaDataJuz = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Juz.json"),
  );
  metaDataManzil = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Manzil.json"),
  );
  metaDataRub = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Rub.json"),
  );
  metaDataRuku = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Ruku.json"),
  );
  metaDataSajda = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Sajda.json"),
  );
  metaDataSurah = jsonDecode(
    await rootBundle.loadString("assets/meta_data/Surah.json"),
  );

  await ThemeFunctions.initThemeFunction();

  if (Platform.isIOS || Platform.isAndroid) {
    await Alarm.init();
    await PrayersTimeFunction.init();
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      "prayer_time_bg",
      "set_prayer_time_reminder",
      frequency: const Duration(hours: 1),
    );
    await setReminderForPrayers();
  }
  getSegmentsSupportedReciters();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DownloadProgressCubitCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => LocationQiblaPrayerDataCubit()),
        BlocProvider(create: (context) => SegmentedQuranReciterCubit()),
        BlocProvider(create: (context) => PlayerStateCubit(PlayerState())),
        BlocProvider(create: (context) => WordPlayingStateCubit()),
        BlocProvider(create: (context) => AudioTabReciterCubit()),
        BlocProvider(create: (context) => AyahByAyahInScrollInfoCubit()),
        BlocProvider(create: (context) => QuranViewCubit()),
        BlocProvider(create: (context) => PrayerReminderCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => OthersSettingsCubit()),
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

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: "Al Quran",
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: "NotoSans",
            ).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.primary,
                brightness: Brightness.light,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.primary,
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
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.primary,
                brightness: Brightness.dark,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.primary,
                  foregroundColor: Colors.white,
                  iconColor: Colors.white,
                  elevation: 0,
                ),
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color.fromARGB(255, 15, 15, 15),
              ),
            ),

            supportedLocales: [const Locale("en"), const Locale("bn")],
            themeMode: state.themeMode,
            home:
                Hive.box("user").get("is_setup_complete", defaultValue: false)
                    ? const HomePage()
                    : const AppSetupPage(),
          );
        },
      ),
    );
  }
}
