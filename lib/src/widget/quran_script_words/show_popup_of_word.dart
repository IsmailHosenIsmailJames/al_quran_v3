import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";

class ShowPopupOfWord extends StatefulWidget {
  final List<String> wordKeys;
  final QuranScriptType scriptCategory;
  final SurahInfoModel surahInfoModel;
  final int initWordIndex;
  const ShowPopupOfWord({
    super.key,
    required this.wordKeys,
    required this.scriptCategory,
    required this.surahInfoModel,
    required this.initWordIndex,
  });
  @override
  State<ShowPopupOfWord> createState() => _ShowPopupOfWordState();
}

class _ShowPopupOfWordState extends State<ShowPopupOfWord> {
  late PageController pageController = PageController(
    initialPage: widget.initWordIndex,
  );
  late int currentWordIndex = widget.initWordIndex;
  @override
  Widget build(BuildContext context) {
    List wordByWord = [];
    bool supportsWordByWord = false;
    final metaDataOfWordByWord = Hive.box(
      "quran_word_by_word",
    ).get("meta_data", defaultValue: {});
    if (metaDataOfWordByWord != null && metaDataOfWordByWord.isNotEmpty) {
      supportsWordByWord = true;
    }
    if (supportsWordByWord) {
      wordByWord =
          Hive.box("quran_word_by_word").get(
            "${widget.wordKeys.first.split(":")[0]}:${widget.wordKeys.first.split(":")[1]}",
          ) ??
          [];
    }
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(15),
      height: 300,
      width: double.infinity,
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
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                ),
              ),
              Text(
                "${widget.surahInfoModel.nameSimple} - ${widget.wordKeys[currentWordIndex]}",
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
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
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
              itemCount: widget.wordKeys.length - 1,
              onPageChanged: (value) {
                setState(() {
                  currentWordIndex = value;
                });
              },
              reverse: true,
              itemBuilder:
                  (context, index) => Column(
                    children: [
                      ScriptProcessor(
                        scriptInfo: ScriptInfo(
                          surahNumber: int.parse(
                            widget.wordKeys[index].split(":")[0],
                          ),
                          ayahNumber: int.parse(
                            widget.wordKeys[index].split(":")[1],
                          ),
                          wordIndex:
                              int.parse(widget.wordKeys[index].split(":")[2]) -
                              1,
                          quranScriptType: widget.scriptCategory,
                          textStyle: const TextStyle(fontSize: 40),
                          skipWordTap: true,
                        ),
                      ),
                      const Gap(10),
                      if (supportsWordByWord)
                        Text(
                          wordByWord[index].toString().capitalize(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      const Gap(15),
                      BlocBuilder<WordPlayingStateCubit, String?>(
                        builder: (context, state) {
                          return OutlinedButton.icon(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.05,
                              ),
                              foregroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              context.read<WordPlayingStateCubit>().changeState(
                                widget.wordKeys[index],
                              );
                              AudioPlayerManager.playWord(
                                widget.wordKeys[index],
                              );
                            },
                            label: const Text("Play Audio"),
                            icon: Icon(
                              state == widget.wordKeys[index]
                                  ? Icons.pause_circle_outline_rounded
                                  : Icons.play_circle_outline_rounded,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
