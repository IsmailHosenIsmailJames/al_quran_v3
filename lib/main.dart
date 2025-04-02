import 'dart:convert';

import 'package:al_quran_v3/src/screen/setup/setup_page.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;
  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ThemeCubit(preferences);
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Al Quran',
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              textTheme: GoogleFonts.notoSansTextTheme(),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              textTheme: GoogleFonts.notoSansTextTheme().apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            ),
            supportedLocales: [Locale('en'), Locale('bn')],
            themeMode: state,
            home: AppSetupPage(),
          );
        },
      ),
    );
  }
}
