import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quram_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quram_script_view_cubit.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

BlocBuilder<QuranViewCubit, QuranViewState> getAyahPreviewWidget() {
  return BlocBuilder<QuranViewCubit, QuranViewState>(
    builder: (context, quranViewState) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Preview", style: TextStyle(color: Colors.grey)),
              TextButton(
                onPressed: () async {
                  await popupJumpToAyah(
                    context: context,
                    isAudioPlayer: false,
                    initAyahKey: quranViewState.ayahKey,
                    onSelectAyah: (ayahKey) {
                      context.read<QuranViewCubit>().changeAyah(ayahKey);
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${SurahInfoModel.fromMap(metaDataSurah[quranViewState.ayahKey.split(":").first]).nameSimple} - $quranViewState",
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
            ],
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(roundedRadius),
            ),
            child: BlocBuilder<QuranViewCubit, QuranViewState>(
              builder: (context, quranViewState) {
                return ScriptProcessor(
                  scriptInfo: ScriptInfo(
                    surahNumber:
                        quranViewState.ayahKey.split(":").first.toInt(),
                    ayahNumber: quranViewState.ayahKey.split(":").last.toInt(),
                    quranScriptType: quranViewState.quranScriptType,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
