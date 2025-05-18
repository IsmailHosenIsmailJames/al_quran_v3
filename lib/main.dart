import 'dart:convert';

import 'package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_state_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart';
import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/audio/resources/quran_com/all_recitations.dart';
import 'package:al_quran_v3/src/screen/home/home_page.dart';
import 'package:al_quran_v3/src/screen/home/pages/location_handler/cubit/location_data_qibla_data_cubit.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart';
import 'package:al_quran_v3/src/screen/setup/cubit/download_progress_cubit_cubit.dart';
import 'package:al_quran_v3/src/screen/setup/setup_page.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await Hive.initFlutter();
  await Hive.openBox('quran_translation');
  await Hive.openBox('user');
  await Hive.openBox('quran_word_by_word');
  await Hive.openBox('segmented_quran_recitation');
  await Hive.openBox('surah_info');
  tajweedScript = jsonDecode(
    await rootBundle.loadString('assets/quran_script/QPC_Hafs_Tajweed.json'),
  );
  uthmaniScript = jsonDecode(
    await rootBundle.loadString('assets/quran_script/Uthmani.json'),
  );
  indopakScript = jsonDecode(
    await rootBundle.loadString('assets/quran_script/Indopak.json'),
  );
  metaDataHizb = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Hizb.json'),
  );
  metaDataJuz = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Juz.json'),
  );
  metaDataManzil = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Manzil.json'),
  );
  metaDataRub = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Rub.json'),
  );
  metaDataRuku = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Ruku.json'),
  );
  metaDataSajda = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Sajda.json'),
  );
  metaDataSurah = jsonDecode(
    await rootBundle.loadString('assets/meta_data/Surah.json'),
  );
  runApp(MyApp(preferences: preferences));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;
  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DownloadProgressCubitCubit()),
        BlocProvider(create: (context) => ThemeCubit(preferences)),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => LocationDataQiblaDataCubit()),
        BlocProvider(create: (context) => SegmentedAudioCubit()),
        BlocProvider(create: (context) => PlayerStateCubit(PlayerState())),
        BlocProvider(create: (context) => WordPlayingStateCubit()),
        BlocProvider(
          create:
              (context) => QuranReciterCubit(
                initReciter: ReciterInfoModel.fromMap(
                  Hive.box('user').get('reciter', defaultValue: null) ??
                      recitationsListOfQuranCom[0],
                ),
              ),
        ),
      ],

      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Al Quran',
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'NotoSans',
            ).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                brightness: Brightness.light,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
              bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'NotoSans',
            ).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                brightness: Brightness.dark,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Color.fromARGB(255, 15, 15, 15),
              ),
            ),

            supportedLocales: [const Locale('en'), const Locale('bn')],
            themeMode: state,
            home:
                Hive.box('user').get('is_setup_complete', defaultValue: false)
                    ? const HomePage()
                    : const AppSetupPage(),
          );
        },
      ),
    );
  }
}
