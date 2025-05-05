import 'dart:convert';
import 'dart:developer';

import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  QuranScriptType selectedScript = QuranScriptType.values.firstWhere(
    (element) => Hive.box('user').get('selected_script') == element.name,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
                    Hive.box(
                      'user',
                    ).put('selected_script', QuranScriptType.tajweed.name);
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
                    Hive.box(
                      'user',
                    ).put('selected_script', QuranScriptType.uthmani.name);

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
                    Hive.box(
                      'user',
                    ).put('selected_script', QuranScriptType.indopak.name);

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
          ),

          Gap(30),
          ElevatedButton(
            onPressed: () async {
              final box = Hive.box('segmented_quran_recitation');
              log(jsonEncode(box.get('1:1')));
            },
            child: const Text('Test'),
          ),
        ],
      ),
    );
  }
}
