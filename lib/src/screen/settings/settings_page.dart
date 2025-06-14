import "dart:developer";

import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";

import "../../../main.dart";
import "../../widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "../../widget/quran_script/script_processor.dart";
import "../surah_list_view/model/surah_info_model.dart";
import "cubit/quran_script_type_cubit.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedAyahKey = "2:2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getScriptSelectionSegmentedButtons(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await popupJumpToAyah(
                    context: context,
                    isAudioPlayer: false,
                    initAyahKey: selectedAyahKey,
                    onSelectAyah: (ayahKey) {
                      setState(() {
                        selectedAyahKey = ayahKey;
                      });
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${SurahInfoModel.fromMap(metaDataSurah[selectedAyahKey.split(":").first]).nameSimple} - $selectedAyahKey",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(5),
                    const Icon(Icons.arrow_drop_down_rounded, size: 28),
                  ],
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              child: BlocBuilder<QuranScriptTypeCubit, QuranScriptType>(
                builder: (context, quranScriptTypeState) {
                  return ScriptProcessor(
                    scriptInfo: ScriptInfo(
                      surahNumber: selectedAyahKey.split(":").first.toInt(),
                      ayahNumber: selectedAyahKey.split(":").last.toInt(),
                      quranScriptType: quranScriptTypeState,
                      textStyle: const TextStyle(fontSize: 24),
                    ),
                  );
                },
              ),
            ),

            const Gap(15),

            const Gap(30),
            ElevatedButton(
              onPressed: () async {
                final box = Hive.box("segmented_quran_recitation");
                Map metaData = box.get("meta_data");
                Map getFirstAyah = box.get("1:1");
                String name = metaData["name"];
                String baseAudioUrl = getFirstAyah["audio_url"];
                baseAudioUrl = baseAudioUrl.substring(
                  baseAudioUrl.lastIndexOf("/"),
                  baseAudioUrl.length,
                );

                ReciterInfoModel reciterInfoModel = ReciterInfoModel(
                  link: baseAudioUrl,
                  name: name
                      .split("/")
                      .last
                      .replaceAll("ayah-recitation-", "")
                      .replaceAll(".json.txt", "")
                      .replaceAll("-", " "),
                  supportWordSegmentation: true,
                );

                log(reciterInfoModel.toJson());
              },
              child: const Text("Test"),
            ),
          ],
        ),
      ),
    );
  }
}
