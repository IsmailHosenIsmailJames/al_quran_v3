import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/word_by_word_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";

class ShowPopupOfWord extends StatefulWidget {
  final List<String> wordKeys;
  final SurahInfoModel surahInfoModel;
  final int initWordIndex;
  final List wordByWord;

  const ShowPopupOfWord({
    super.key,
    required this.wordKeys,
    required this.surahInfoModel,
    required this.initWordIndex,
    required this.wordByWord,
  });

  @override
  State<ShowPopupOfWord> createState() => _ShowPopupOfWordState();
}

class _ShowPopupOfWordState extends State<ShowPopupOfWord> {
  late final PageController pageController;
  late int currentWordIndex;

  @override
  void initState() {
    super.initState();
    final int maxIdx = widget.wordKeys.isEmpty ? 0 : widget.wordKeys.length - 1;
    currentWordIndex = widget.initWordIndex.clamp(0, maxIdx);
    pageController = PageController(initialPage: currentWordIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wordKeys.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeState themeState = context.read<ThemeCubit>().state;
    final QuranScriptType scriptType =
        context.read<QuranViewCubit>().state.quranScriptType;
    final bool supportsWordByWord =
        WordByWordFunction.getSelectedWordByWordBook() != null;

    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(15),
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 35,
                child: IconButton(
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  padding: EdgeInsets.zero,
                  onPressed: currentWordIndex < widget.wordKeys.length - 1
                      ? () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                ),
              ),
              Text(
                "${getSurahName(context, widget.surahInfoModel.id)} - ${widget.wordKeys[currentWordIndex]}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 50,
                height: 35,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: currentWordIndex > 0
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ),
              ),
            ],
          ),
          const Divider(),
          const Gap(10),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.wordKeys.length,
              onPageChanged: (value) {
                setState(() {
                  currentWordIndex = value;
                });
              },
              reverse: true,
              itemBuilder: (context, index) {
                final parts = widget.wordKeys[index].split(":");
                final int surahNum = int.tryParse(parts[0]) ?? 1;
                final int ayahNum =
                    parts.length > 1 ? (int.tryParse(parts[1]) ?? 1) : 1;
                final int wordNum =
                    parts.length > 2 ? (int.tryParse(parts[2]) ?? 1) : 1;
                final bool hasTranslation =
                    supportsWordByWord && index < widget.wordByWord.length;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ScriptProcessor(
                        scriptInfo: ScriptInfo(
                          surahNumber: surahNum,
                          ayahNumber: ayahNum,
                          wordIndex: (wordNum - 1).clamp(0, 999),
                          quranScriptType: scriptType,
                          textStyle: const TextStyle(fontSize: 40),
                          skipWordTap: true,
                        ),
                        themeState: context.read<ThemeCubit>().state,
                        tajweedColorEnable: scriptType == QuranScriptType.uthmani
                            ? context
                                .read<QuranViewCubit>()
                                .state
                                .useTajweedOnUthmani
                            : context
                                .read<QuranViewCubit>()
                                .state
                                .useTajweedOnIndopak,
                      ),
                      const Gap(10),
                      if (hasTranslation)
                        Html(
                          data: widget.wordByWord[index].toString(),
                          shrinkWrap: true,
                          style: {
                            "*": Style(
                              textAlign: TextAlign.center,
                              fontSize: FontSize(18),
                            ),
                          },
                        ),
                      const Gap(15),
                      BlocBuilder<WordPlayingStateCubit, String?>(
                        builder: (context, playingWordKey) {
                          final isThisPlaying =
                              playingWordKey == widget.wordKeys[index];
                          return OutlinedButton.icon(
                            style: IconButton.styleFrom(
                              backgroundColor: themeState.primary.withValues(
                                alpha: 0.05,
                              ),
                              foregroundColor: themeState.primary,
                            ),
                            onPressed: () {
                              AudioPlayerManager.playWord(widget.wordKeys[index]);
                            },
                            label: Text(AppLocalizations.of(context).playAudio),
                            icon: Icon(
                              isThisPlaying
                                  ? Icons.pause_circle_outline_rounded
                                  : Icons.play_circle_outline_rounded,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
