import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

BlocBuilder<QuranViewCubit, QuranViewState> getAyahPreviewWidget({
  bool showHeaderOptions = true,
  bool showOnlyAyah = false,
}) {
  return BlocBuilder<QuranViewCubit, QuranViewState>(
    builder: (context, quranViewState) {
      final TranslationWithWordByWord? translationWithWordByWord =
          getTranslationFromCache(quranViewState.ayahKey);
      return Column(
        children: [
          if (!(showHeaderOptions == false))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).preview,
                  style: const TextStyle(color: Colors.grey),
                ),
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
                        "${getSurahName(context, quranViewState.ayahKey.split(":").first.toInt())} - ${getAyahLocalized(context, quranViewState.ayahKey)}",
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

          translationWithWordByWord != null
              ? getAyahByAyahCard(
                ayahKey: quranViewState.ayahKey,
                context: context,
                showTopOptions: showHeaderOptions,
                keepMargin: false,
                showOnlyAyah: showOnlyAyah,
                translationListWithInfo:
                    translationWithWordByWord.translationList,
                wordByWord: translationWithWordByWord.wordByWord ?? [],
              )
              : FutureBuilder(
                future: getTranslationWithWordByWord(quranViewState.ayahKey),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox(height: 250);
                  }
                  return getAyahByAyahCard(
                    ayahKey: quranViewState.ayahKey,
                    context: context,
                    showTopOptions: showHeaderOptions,
                    keepMargin: false,
                    showOnlyAyah: showOnlyAyah,
                    translationListWithInfo:
                        snapshot.data?.translationList ?? [],
                    wordByWord: snapshot.data?.wordByWord ?? [],
                  );
                },
              ),
        ],
      );
    },
  );
}
