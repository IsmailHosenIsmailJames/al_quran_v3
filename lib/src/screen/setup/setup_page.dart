import 'dart:developer';

import 'package:al_quran_v3/src/resources/quran_resources/language_code.dart';
import 'package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart';
import 'package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart';
import 'package:al_quran_v3/src/resources/translation/languages.dart';
import 'package:al_quran_v3/src/resources/quran_resources/simple_translation.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  String? quranTranslationLanguageCode;
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/Quran_Logo_v3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(30),
              const Row(
                children: [
                  Icon(FluentIcons.settings_24_regular),
                  Gap(10),
                  Text(
                    'Setup',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(
                            Icons.translate_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(8),
                        Text('App Language', style: titleStyle),
                      ],
                    ),
                    const Gap(5),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "${'Select a language for app'}...",
                      ),
                      isExpanded: true,
                      items: getAppLanguageDropdown(),
                      onChanged: null,
                    ),

                    const Gap(15),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.primaryColor,
                          child: Image.asset(
                            'assets/img/book_translation.png',
                            fit: BoxFit.cover,
                            height: 20,
                            width: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(8),
                        Text('Quran Translation', style: titleStyle),
                      ],
                    ),
                    const Gap(5),
                    DropdownButtonFormField(
                      value: quranTranslationLanguageCode,
                      items: getQuranTranslationDropDownList(),
                      isExpanded: true,
                      onChanged: (value) {
                        quranTranslationLanguageCode = value ?? 'en';
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              ...getSupportInfoWidget(key: e['English'] ?? ''),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem> getQuranTranslationDropDownList() {
    List<DropdownMenuItem> items = [];
    simpleTranslation.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: languageToCodeMap[key],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (quranTranslationLanguageCode == languageToCodeMap[key])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                Text(languageNativeNames[key] ?? ''),
                ...getSupportInfoWidget(key: key),
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  List<Widget> getSupportInfoWidget({required String key}) {
    return [
      if (doesHaveFootNote(key))
        Container(
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
        ),
      if (doesHaveTafsirSupport(key))
        Container(
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
        ),
      if (doesHaveWordByWordTranslation(key))
        Container(
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
        ),
    ];
  }
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
  wordByWordTranslation.forEach((language, value) {
    if (language == language) {
      doesHaveWordByWordTranslation = true;
    }
  });
  return doesHaveWordByWordTranslation;
}

bool doesHaveTafsirSupport(String language) {
  bool doesHaveTafsirSupport = false;
  tafsirInformationWithScore.forEach((key, value) {
    if (language == key) {
      doesHaveTafsirSupport = true;
    }
  });
  return doesHaveTafsirSupport;
}
