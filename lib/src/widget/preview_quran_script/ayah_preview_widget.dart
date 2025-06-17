import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

BlocBuilder<QuranViewCubit, QuranViewState> getAyahPreviewWidget({
  bool showHeaderOptions = true,
  bool showOnlyAyah = false,
}) {
  return BlocBuilder<QuranViewCubit, QuranViewState>(
    builder: (context, quranViewState) {
      return Column(
        children: [
          if (!(showHeaderOptions == false))
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
                        "${SurahInfoModel.fromMap(metaDataSurah[quranViewState.ayahKey.split(":").first]).nameSimple} - ${quranViewState.ayahKey}",
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

          getAyahByAyahCard(
            ayahKey: quranViewState.ayahKey,
            context: context,
            showTopOptions: false,
            showOnlyAyah: showOnlyAyah,
          ),
        ],
      );
    },
  );
}
