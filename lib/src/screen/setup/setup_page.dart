import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:al_quran_v3/src/api/apis_urls.dart';
import 'package:al_quran_v3/src/functions/encode_decode.dart';
import 'package:al_quran_v3/src/resources/quran_resources/language_code.dart';
import 'package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart';
import 'package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart';
import 'package:al_quran_v3/src/resources/translation/languages.dart';
import 'package:al_quran_v3/src/resources/meta_data/simple_translation.dart';
import 'package:al_quran_v3/src/screen/home/home_page.dart';
import 'package:al_quran_v3/src/screen/setup/cubit/download_progress_cubit_cubit.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/components/get_score_widget.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:al_quran_v3/src/widget/theme_icon_button.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  List<Map>? selectableTranslationBook;
  List<Map>? selectableTafsirBook;

  String? appLanguage;
  String? translationLanguage;
  String? translationBook;
  String? tafsirLanguage;
  String? tafsirBook;

  void changeAppLanguage(String value) {
    appLanguage = value;
    String? languageName = codeToLanguageMap[appLanguage];
    if (simpleTranslation.keys.contains(languageName)) {
      translationLanguage = appLanguage;
      selectableTranslationBook =
          simpleTranslation[codeToLanguageMap[translationLanguage]];
    }
    if (tafsirInformationWithScore.keys.contains(languageName)) {
      tafsirLanguage = appLanguage;
      selectableTafsirBook =
          tafsirInformationWithScore[codeToLanguageMap[tafsirLanguage]];
    }
  }

  void changeTranslationLanguage(String value) {
    translationLanguage = value;
    translationBook = null;
    selectableTranslationBook =
        simpleTranslation[codeToLanguageMap[translationLanguage]];
  }

  void changeTafsirLanguage(String value) {
    tafsirLanguage = value;
    tafsirBook = null;
    selectableTafsirBook =
        tafsirInformationWithScore[codeToLanguageMap[tafsirLanguage]];
  }

  @override
  void initState() {
    if (!kIsWeb) {
      changeAppLanguage(Platform.localeName.split('_')[0].toLowerCase());
    }
    super.initState();
  }

  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: fromKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text('App Language', style: titleStyle),
                            ],
                          ),
                          const Gap(5),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              hintText: 'Select app language...',
                            ),
                            value: appLanguage,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            isExpanded: true,
                            items: getAppLanguageDropdown(),
                            onChanged: (value) {
                              changeAppLanguage(value.toString());
                              setState(() {});
                            },
                          ),

                          const Gap(15),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text(
                                'Quran Translation Language',
                                style: titleStyle,
                              ),
                            ],
                          ),
                          const Gap(5),
                          DropdownButtonFormField(
                            value: translationLanguage,
                            items: getQuranTranslationLanguageDropDownList(),
                            decoration: const InputDecoration(
                              hintText: 'Select translation language...',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            isExpanded: true,
                            onChanged: (value) {
                              changeTranslationLanguage(value.toString());
                              setState(() {});
                            },
                          ),
                          const Gap(15),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text('Quran Translation Book', style: titleStyle),
                            ],
                          ),

                          const Gap(5),
                          DropdownButtonFormField(
                            items: getQuranTranslationBookDropDownList(),
                            decoration: const InputDecoration(
                              hintText: 'Select translation book...',
                            ),
                            value: translationBook,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            isExpanded: true,
                            onChanged: (value) {
                              translationBook = value ?? '';
                              setState(() {});
                            },
                          ),
                          const Gap(15),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text('Quran Tafsir Language', style: titleStyle),
                            ],
                          ),

                          const Gap(5),
                          DropdownButtonFormField(
                            items: getQuranTafsirLanguageDropDownList(),
                            decoration: const InputDecoration(
                              hintText: 'Select tafsir language...',
                            ),
                            value: tafsirLanguage,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,

                            isExpanded: true,
                            onChanged: (value) {
                              changeTafsirLanguage(value.toString());
                              setState(() {});
                            },
                          ),
                          const Gap(15),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text('Quran Tafsir Book', style: titleStyle),
                            ],
                          ),
                          const Gap(5),
                          DropdownButtonFormField(
                            items: getQuranTafsirBookDropDownList(),
                            decoration: const InputDecoration(
                              hintText: 'Select tafsir book...',
                            ),
                            isExpanded: true,
                            value: tafsirBook,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              tafsirBook = value;
                              setState(() {});
                            },
                          ),
                          const Gap(15),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: AppColors.primaryColor,
                                child: const Text(
                                  '6',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Text('Quran Script & Style', style: titleStyle),
                            ],
                          ),
                          const Gap(5),
                          getScriptSelectionSegmentedButtons(),
                          const Gap(5),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.07,
                              ),
                              borderRadius: BorderRadius.circular(
                                roundedRadius,
                              ),
                            ),
                            child: ScriptProcessor(
                              scriptInfo: ScriptInfo(
                                surahNumber: 2,
                                ayahNumber: 2,
                                quranScriptType: selectedScript,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Gap(15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: downloadResources,
                              label: const Text('Save & Download'),
                              icon: const Icon(Icons.download_rounded),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: themeIconButton(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadResources() async {
    if (translationLanguage == null ||
        tafsirLanguage == null ||
        translationBook == null ||
        tafsirBook == null) {
      toastification.show(
        context: context,
        title: const Text('Please select required option'),
        autoCloseDuration: const Duration(seconds: 2),
        type: ToastificationType.error,
      );
    }
    if (fromKey.currentState?.validate() == true) {
      final userBox = Hive.box('user');
      await userBox.put('app_language', appLanguage);
      await userBox.put('translation_language', translationLanguage);
      await userBox.put('translation_book', translationBook);
      await userBox.put('tafsir_language', tafsirLanguage);
      await userBox.put('tafsir_book', tafsirBook);
      await userBox.put('selected_script', selectedScript.name);

      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => Dialog(
              insetPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),

                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                child: BlocBuilder<
                  DownloadProgressCubitCubit,
                  DownloadProgressCubitState
                >(
                  builder: (context, state) {
                    if (state is DownloadProgressCubitLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Just a moment...',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Gap(20),
                          LinearProgressIndicator(
                            value: state.percentage,
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(roundedRadius),
                            minHeight: 8,
                          ),
                          const Gap(10),
                          Text(
                            '${state.processName} ${state.percentage != null ? '${(state.percentage! * 100).toStringAsFixed(2)}%' : ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    } else if (state is DownloadProgressCubitSuccess) {
                      return const Text('Success');
                    } else if (state is DownloadProgressCubitFailure) {
                      return Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      );
                    }
                    return LinearProgressIndicator(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(roundedRadius),
                      minHeight: 8,
                    );
                  },
                ),
              ),
            ),
      );
      bool success1 = await downloadTranslationBook();
      bool success2 = await downloadTafsir();
      if (success1 && success2) {
        userBox.put('is_setup_complete', true);
        // success and route to home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      } else {
        // error and show 'Something went wrong' in cubit
        context.read<DownloadProgressCubitCubit>().failure(
          'Unable to download resources...',
        );
      }
    }
  }

  Future<bool> downloadTranslationBook() async {
    final translationBox = Hive.box('quran_translation');
    Map metaData = translationBox.get('meta_data', defaultValue: {});
    if (metaData['name'] == translationBook &&
        metaData['language'] == translationLanguage) {
      log('Already downloaded');
      return true;
    }
    try {
      String base = ApisUrls.base;
      log(base + translationBook!, name: 'http path');
      context.read<DownloadProgressCubitCubit>().updateProgress(
        null,
        'Downloading Translation',
      );
      dio.Response response = await dio.Dio().get(base + translationBook!);

      log(response.statusCode.toString(), name: 'Status');
      DateTime now = DateTime.now();
      Map data = jsonDecode(decodeBZip2String(response.data));
      for (int i = 0; i < data.length; i++) {
        String key = data.keys.elementAt(i);
        await translationBox.put(key, data[key]);
        context.read<DownloadProgressCubitCubit>().updateProgress(
          i / data.length,
          'Processing Translation',
        );
      }
      await translationBox.put('meta_data', {
        'name': translationBook,
        'language': translationLanguage,
      });
      log(
        now.difference(DateTime.now()).inMilliseconds.abs().toString(),
        name: 'Translation Process Time',
      );
      return true;
    } catch (e) {
      log(e.toString(), name: 'http error');
      return false;
    }
  }

  Future<bool> downloadTafsir() async {
    final tafsirBox = await Hive.openBox('quran_tafsir');
    final metaData = tafsirBox.get('meta_data', defaultValue: {});
    if (metaData['name'] == tafsirBook &&
        metaData['language'] == tafsirLanguage) {
      log('Already downloaded');
      return true;
    }
    try {
      String base = ApisUrls.base;
      log(base + tafsirBook!, name: 'http path');
      context.read<DownloadProgressCubitCubit>().updateProgress(
        null,
        'Downloading Tafsir',
      );
      dio.Response response = await dio.Dio().get(base + translationBook!);
      log(response.statusCode.toString(), name: 'Status');
      DateTime now = DateTime.now();
      Map data = jsonDecode(decodeBZip2String(response.data));
      for (int i = 0; i < data.length; i++) {
        String key = data.keys.elementAt(i);
        await tafsirBox.put(key, jsonEncode(data[key]!));
        context.read<DownloadProgressCubitCubit>().updateProgress(
          i / data.length,
          'Processing Tafsir',
        );
      }
      await tafsirBox.put('meta_data', {
        'name': tafsirBook,
        'language': tafsirLanguage,
      });
      log(
        now.difference(DateTime.now()).inMilliseconds.abs().toString(),
        name: 'Translation Process Time',
      );
      tafsirBox.close();
      return true;
    } catch (e) {
      log(e.toString(), name: 'http error');
      tafsirBox.close();
      return false;
    }
  }

  Row getScriptSelectionSegmentedButtons() {
    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedScript == QuranScriptType.tajweed
                      ? AppColors.primaryColor
                      : Colors.grey.withValues(alpha: 0.2),
              foregroundColor:
                  selectedScript == QuranScriptType.tajweed
                      ? Colors.white
                      : AppColors.primaryColor,
              padding: const EdgeInsets.only(left: 8, right: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(roundedRadius),
                  bottomLeft: Radius.circular(roundedRadius),
                ),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              setState(() {
                selectedScript = QuranScriptType.tajweed;
              });
            },
            label: const Text(
              'Tajweed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon:
                selectedScript == QuranScriptType.tajweed
                    ? const Icon(Icons.done_rounded)
                    : null,
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedScript == QuranScriptType.uthmani
                      ? AppColors.primaryColor
                      : Colors.grey.withValues(alpha: 0.2),
              foregroundColor:
                  selectedScript == QuranScriptType.uthmani
                      ? Colors.white
                      : AppColors.primaryColor,
              padding: const EdgeInsets.only(left: 8, right: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              setState(() {
                selectedScript = QuranScriptType.uthmani;
              });
            },
            label: const Text(
              'Uthmani',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon:
                selectedScript == QuranScriptType.uthmani
                    ? const Icon(Icons.done_rounded)
                    : null,
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedScript == QuranScriptType.indopak
                      ? AppColors.primaryColor
                      : Colors.grey.withValues(alpha: 0.2),
              foregroundColor:
                  selectedScript == QuranScriptType.indopak
                      ? Colors.white
                      : AppColors.primaryColor,
              padding: const EdgeInsets.only(left: 8, right: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(roundedRadius),
                  bottomRight: Radius.circular(roundedRadius),
                ),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              setState(() {
                selectedScript = QuranScriptType.indopak;
              });
            },
            label: const Text(
              'Indopak',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            icon:
                selectedScript == QuranScriptType.indopak
                    ? const Icon(Icons.done_rounded)
                    : null,
          ),
        ),
      ],
    );
  }

  QuranScriptType selectedScript = QuranScriptType.tajweed;

  List<DropdownMenuItem>? getQuranTafsirBookDropDownList() {
    List<DropdownMenuItem> items = [];
    if (selectableTafsirBook?.isEmpty ?? true) return null;
    selectableTafsirBook?.sort(
      (a, b) => (b['score'] as int).compareTo(a['score']),
    );
    for (Map book in selectableTafsirBook ?? []) {
      items.add(
        DropdownMenuItem(
          value: book['full_path'] ?? '',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (tafsirBook == book['full_path'])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                buildScoreIndicator(
                  percentage: (book['score'] as int).toDouble(),
                  size: 20,
                ),
                const Gap(8),
                Text(book['name'] ?? ''),
              ],
            ),
          ),
        ),
      );
    }

    return items;
  }

  List<DropdownMenuItem>? getQuranTafsirLanguageDropDownList() {
    List<DropdownMenuItem> items = [];
    tafsirInformationWithScore.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: languageToCodeMap[key.toLowerCase()],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (tafsirLanguage == languageToCodeMap[key.toLowerCase()])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                Text(languageNativeNames[key.toLowerCase()] ?? ''),
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  List<DropdownMenuItem<String>> getAppLanguageDropdown() {
    return used20LanguageMap.map((e) {
      return DropdownMenuItem(
        value: e['Code'],
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (appLanguage == e['Code'])
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.done_rounded,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                ),
              Text(e['Native'] ?? ''),
              ...getSupportInfoForLanguageWidget(key: e['English'] ?? ''),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem>? getQuranTranslationBookDropDownList() {
    List<DropdownMenuItem> items = [];
    if (selectableTranslationBook?.isEmpty ?? true) return null;
    for (Map book in selectableTranslationBook ?? []) {
      items.add(
        DropdownMenuItem(
          value: book['full_path'] ?? '',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (translationBook == book['full_path'])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                Text(book['name'] ?? ''),
                if (book['type'] == 'translation-with-footnote-tags')
                  footNoteTag,
              ],
            ),
          ),
        ),
      );
    }

    return items;
  }

  List<DropdownMenuItem> getQuranTranslationLanguageDropDownList() {
    List<DropdownMenuItem> items = [];
    simpleTranslation.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: languageToCodeMap[key.toLowerCase()],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (translationLanguage == languageToCodeMap[key.toLowerCase()])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                Text(languageNativeNames[key.toLowerCase()] ?? ''),
                ...getSupportInfoForLanguageWidget(key: key.toLowerCase()),
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  List<Widget> getSupportInfoForLanguageWidget({required String key}) {
    return [
      if (doesHaveFootNote(key.toLowerCase())) footNoteTag,
      if (doesHaveTafsirSupport(key.toLowerCase())) tafsirTag,
      if (doesHaveWordByWordTranslation(key.toLowerCase())) wordByWordTag,
    ];
  }

  Widget footNoteTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(100),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.done_rounded, color: Colors.white, size: 15),
        Gap(5),
        Text('Footnote', style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );

  Widget tafsirTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(100),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.done_rounded, color: Colors.white, size: 15),
        Gap(5),
        Text('Tafsir', style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );

  Widget wordByWordTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(100),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.done_rounded, color: Colors.white, size: 15),
        Gap(5),
        Text(
          'Word by Word',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}

bool doesHaveFootNote(String language) {
  bool doesHaveFootNote = false;
  for (Map map in simpleTranslation[language] ?? []) {
    if (map['type'] == 'translation-with-footnote-tags') {
      doesHaveFootNote = true;
      break;
    }
  }
  return doesHaveFootNote;
}

bool doesHaveWordByWordTranslation(String language) {
  bool doesHaveWordByWordTranslation = false;
  wordByWordTranslation.forEach((lang, value) {
    if (language == lang.toLowerCase()) {
      doesHaveWordByWordTranslation = true;
    }
  });

  return doesHaveWordByWordTranslation;
}

bool doesHaveTafsirSupport(String language) {
  bool doesHaveTafsirSupport = false;
  tafsirInformationWithScore.forEach((key, value) {
    if (language == key.toLowerCase()) {
      doesHaveTafsirSupport = true;
    }
  });
  return doesHaveTafsirSupport;
}
