import 'dart:convert';
import 'dart:developer';

import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/resources/quran_resources/language_code.dart';
import 'package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart';
import 'package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart';
import 'package:al_quran_v3/src/resources/translation/languages.dart';
import 'package:al_quran_v3/src/resources/quran_resources/simple_translation.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:al_quran_v3/src/widget/theme_icon_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  String? translationLanguage;
  String? translationBook;
  String? tafsirLanguage;
  String? tafsirBook;

  List<Map>? selectableTranslationBook;
  List<Map>? selectableTafsirBook;

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
                              child: Text(
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
                          decoration: InputDecoration(
                            hintText: "Select app language...",
                          ),
                          isExpanded: true,
                          items: getAppLanguageDropdown(),
                          onChanged: (value) {},
                        ),

                        const Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
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
                          decoration: InputDecoration(
                            hintText: "Select translation language...",
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            translationLanguage = value ?? 'English';
                            translationBook = null;
                            selectableTranslationBook =
                                simpleTranslation[value];
                            log(
                              JsonEncoder.withIndent(
                                ' ',
                              ).convert(selectableTranslationBook),
                              name: 'Selectable Translation Book',
                            );
                            setState(() {});
                          },
                        ),
                        const Gap(15),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gap(8),
                            Text('Quran Translation Book', style: titleStyle),
                          ],
                        ),

                        const Gap(5),
                        DropdownButtonFormField(
                          items: getQuranTranslationBookDropDownList(),
                          decoration: InputDecoration(
                            hintText: "Select translation book...",
                          ),
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
                              child: Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gap(8),
                            Text('Quran Tafsir Language', style: titleStyle),
                          ],
                        ),

                        const Gap(5),
                        DropdownButtonFormField(
                          items: getQuranTafsirLanguageDropDownList(),
                          decoration: InputDecoration(
                            hintText: "Select tafsir language...",
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            tafsirLanguage = value ?? '';
                            selectableTafsirBook =
                                tafsirInformationWithScore[value];

                            log(value.toString());
                            setState(() {});
                          },
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gap(8),
                            Text('Quran Tafsir Book', style: titleStyle),
                          ],
                        ),
                        const Gap(5),
                        DropdownButtonFormField(
                          items: getQuranTafsirBookDropDownList(),
                          decoration: InputDecoration(
                            hintText: "Select tafsir book...",
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            translationBook = value ?? '';
                            log(value.toString());
                            setState(() {});
                          },
                        ),
                        Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: AppColors.primaryColor,
                              child: Text(
                                '6',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gap(8),
                            Text('Quran Script & Style', style: titleStyle),
                          ],
                        ),
                        const Gap(5),
                        getScriptSelectionSegmentedButtons(),
                        Gap(15),
                        Center(
                          child: ScriptProcessor(
                            scriptInfo: ScriptInfo(
                              surahNumber: 2,
                              ayahNumber: 2,
                              quranScriptType: selectedScript,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
              padding: EdgeInsets.only(left: 8, right: 8),
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
            label: Text(
              "Tajweed",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon:
                selectedScript == QuranScriptType.tajweed
                    ? Icon(Icons.done_rounded)
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
              padding: EdgeInsets.only(left: 8, right: 8),
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
            label: Text(
              'Uthmani',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon:
                selectedScript == QuranScriptType.uthmani
                    ? Icon(Icons.done_rounded)
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
              padding: EdgeInsets.only(left: 8, right: 8),
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
            label: Text(
              "Indopak",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            icon:
                selectedScript == QuranScriptType.indopak
                    ? Icon(Icons.done_rounded)
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
    for (Map book in selectableTafsirBook ?? []) {
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

  List<DropdownMenuItem>? getQuranTafsirLanguageDropDownList() {
    List<DropdownMenuItem> items = [];
    tafsirInformationWithScore.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: key,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (tafsirLanguage == key.toLowerCase())
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                Text(languageNativeNames[key.toLowerCase()] ?? ""),
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
              // if (languageController.selectedLanguage.value == e['Code'])
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
          value: key,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (translationLanguage == key.toLowerCase())
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          'Footnote',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          'Tafsir',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          'Word by Word',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}

bool doesHaveFootNote(String language) {
  bool doesHaveFootNote = false;
  for (Map map in simpleTranslation[capitalizeFirstLatter(language)] ?? []) {
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
