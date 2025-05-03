import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart';
import 'package:al_quran_v3/src/audio/player/audio_player_manager.dart';
import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/screen/tafsir_view/tafsir_view.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AyahByAyahView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;

  const AyahByAyahView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<AyahByAyahView> createState() => _AyahByAyahViewState();
}

List getListOfAyahKey({
  required String startAyahKey,
  required String endAyahKey,
}) {
  List ayahKeysList = [];
  int startSurahNumber = int.parse(startAyahKey.split(':')[0]);
  int startAyahNumber = int.parse(startAyahKey.split(':')[1]);
  int endSurahNumber = int.parse(endAyahKey.split(':')[0]);
  int endAyahNumber = int.parse(endAyahKey.split(':')[1]);

  for (int surah = startSurahNumber; surah <= endSurahNumber; surah++) {
    int startAyah = 1;
    if (surah == startSurahNumber) startAyah = startAyahNumber;
    int endAyah = quranAyahCount[surah - 1];
    if (surah == endSurahNumber) {
      endAyah = endAyahNumber;
    }
    for (int ayah = startAyah; ayah <= endAyah; ayah++) {
      if (ayah == 1) {
        ayahKeysList.add(surah);
      }
      ayahKeysList.add('$surah:$ayah');
    }
  }
  return ayahKeysList;
}

class _AyahByAyahViewState extends State<AyahByAyahView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  double previousPixel = 0.0;
  int? indexToScroll;

  late List ayahKeysList;
  bool supportsWordByWord = false;
  @override
  void initState() {
    ayahKeysList = getListOfAyahKey(
      startAyahKey: widget.startKey,
      endAyahKey: widget.endKey,
    );
    if (ayahKeysList.first.runtimeType == String) {
      ayahKeysList.insert(0, int.parse(widget.startKey.split(':').first));
    }
    for (int i = 0; i < ayahKeysList.length; i++) {
      if (ayahKeysList[i] == widget.toScrollKey) {
        indexToScroll = ayahKeysList.length;
      }
    }
    final metaDataOfWordByWord = Hive.box(
      'quran_word_by_word',
    ).get('meta_data', defaultValue: {});
    if (metaDataOfWordByWord != null && metaDataOfWordByWord.isNotEmpty) {
      supportsWordByWord = true;
    }

    SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah.values.elementAt(
        int.parse(widget.startKey.split(':')[0]) - 1,
      ),
    );
    if (BlocProvider.of<AyahByAyahInScrollInfoCubit>(
          context,
        ).state.surahInfoModel?.nameSimple !=
        surahInfoModel.nameSimple) {
      BlocProvider.of<AyahByAyahInScrollInfoCubit>(
        context,
      ).setData(surahInfoModel);
    }

    if (indexToScroll != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        itemScrollController.scrollTo(
          index: indexToScroll!,
          duration: const Duration(milliseconds: 200),
        );
      });
    }
    itemPositionsListener.itemPositions.addListener(() {
      if (itemPositionsListener.itemPositions.value.isNotEmpty) {
        int firstIndex = itemPositionsListener.itemPositions.value.first.index;
        SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
          metaDataSurah.values.elementAt(
            int.parse(ayahKeysList[firstIndex].toString().split(':')[0]) - 1,
          ),
        );
        if (BlocProvider.of<AyahByAyahInScrollInfoCubit>(
              context,
            ).state.surahInfoModel?.nameSimple !=
            surahInfoModel.nameSimple) {
          BlocProvider.of<AyahByAyahInScrollInfoCubit>(
            context,
          ).setData(surahInfoModel);
        }
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels - previousPixel >
          minScrollUiAudioUpdate) {
        previousPixel = _scrollController.position.pixels;
        context.read<AudioUiCubit>().expand(false);
      } else if (_scrollController.position.pixels - previousPixel <
          -minScrollUiAudioUpdate) {
        previousPixel = _scrollController.position.pixels;
        context.read<AudioUiCubit>().expand(true);
      }
      // Get item index from scroll offset
      int index =
          (_scrollController.offset /
                  (_scrollController.position.maxScrollExtent /
                      (ayahKeysList.length - 1)))
              .round();
      if (index < ayahKeysList.length && index >= 0) {
        SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
          metaDataSurah.values.elementAt(
            int.parse(ayahKeysList[index].toString().split(':')[0]) - 1,
          ),
        );
        if (BlocProvider.of<AyahByAyahInScrollInfoCubit>(
              context,
            ).state.surahInfoModel?.nameSimple !=
            surahInfoModel.nameSimple) {
          BlocProvider.of<AyahByAyahInScrollInfoCubit>(
            context,
          ).setData(surahInfoModel);
        }
      }
    });

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  List<int> expandedForWordByWord = [];

  @override
  Widget build(BuildContext context) {
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );

    if (widget.toScrollKey == null) {
      return Scrollbar(
        controller: _scrollController,
        radius: Radius.circular(roundedRadius),
        thickness: 10,
        interactive: true,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: ayahKeysList.length,

          itemBuilder: (context, index) {
            return getAyahCard(index, quranScriptType, context);
          },
        ),
      );
    }

    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      scrollOffsetController: scrollOffsetController,
      itemPositionsListener: itemPositionsListener,
      scrollOffsetListener: scrollOffsetListener,
      itemCount: ayahKeysList.length,

      itemBuilder: (context, index) {
        // it is actually a surah number
        return getAyahCard(index, quranScriptType, context);
      },
    );
  }

  StatelessWidget getAyahCard(
    int index,
    QuranScriptType quranScriptType,
    BuildContext context,
  ) {
    // it is actually a surah number
    if (ayahKeysList[index].runtimeType == int) {
      SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
        metaDataSurah.values.elementAt((ayahKeysList[index] as int) - 1),
      );
      return SurahInfoHeaderBuilder(surahInfoModel: surahInfoModel);
    }
    int surahNumber = int.parse(ayahKeysList[index].toString().split(':')[0]);
    int ayahNumber = int.parse(ayahKeysList[index].toString().split(':')[1]);
    Map translationMap =
        Hive.box('quran_translation').get(ayahKeysList[index]) ??
        {'t': 'Translation Not Found'};
    String translation = translationMap['t'] ?? 'Translation Not Found';
    translation = translation.replaceAll('>', '> ');
    Map footNote = translationMap['f'] ?? {};
    List wordByWord = [];
    if (supportsWordByWord) {
      wordByWord =
          Hive.box('quran_word_by_word').get(ayahKeysList[index]) ?? [];
    }
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: AppColors.primaryColor.withValues(alpha: 0.05),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  bottom: 3,
                  top: 3,
                ),
                child: Text(ayahNumber.toString()),
              ),
              const Spacer(),

              SizedBox(
                height: 30,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                TafsirView(ayahKey: ayahKeysList[index]),
                      ),
                    );
                  },
                  child: const Text('Tafsir'),
                ),
              ),
              const Gap(5),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {},
                  tooltip: 'Share',
                  icon: const Icon(FluentIcons.share_24_filled, size: 18),
                ),
              ),
              const Gap(5),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {},
                  tooltip: 'Copy',
                  icon: const Icon(FluentIcons.copy_16_filled, size: 18),
                ),
              ),
              const Gap(5),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {},
                  tooltip: 'Add Note',
                  icon: const Icon(FluentIcons.note_add_24_filled, size: 18),
                ),
              ),
              const Gap(5),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {},
                  tooltip: 'Bookmark',
                  icon: const Icon(Icons.bookmark_added, size: 18),
                ),
              ),
              const Gap(5),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {
                    AudioPlayerManager.playSingleAyah(
                      context: context,
                      ayahKey: ayahKeysList[index],
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                ),
              ),
            ],
          ),
          const Gap(10),
          Align(
            alignment: Alignment.centerRight,
            child: ScriptProcessor(
              scriptInfo: ScriptInfo(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                quranScriptType: quranScriptType,
              ),
            ),
          ),
          const Gap(5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Translation:',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
          const Gap(2),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: HtmlWidget(
              capitalizeFirstLatter(translation),
              buildAsync: false,
            ),
          ),
          if (footNote.keys.isNotEmpty) const Gap(8),
          if (footNote.keys.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Foot Note:',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
          const Gap(2),
          if (footNote.keys.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: List.generate(footNote.length, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${index + 1}. '),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: HtmlWidget(
                          buildAsync: false,
                          capitalizeFirstLatter(
                            footNote.values.elementAt(index),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          if (supportsWordByWord)
            GestureDetector(
              onTap: () {
                setState(() {
                  expandedForWordByWord.contains(index)
                      ? expandedForWordByWord.remove(index)
                      : expandedForWordByWord.add(index);
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Word by Word Translation:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    Icon(
                      expandedForWordByWord.contains(index)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_right,
                      size: 24,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ),
          if (supportsWordByWord) const Gap(5),
          if (supportsWordByWord)
            SizedBox(
              height: expandedForWordByWord.contains(index) ? null : 0,

              child:
                  expandedForWordByWord.contains(index)
                      ? Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        textDirection: TextDirection.rtl,
                        children: List.generate(wordByWord.length, (index) {
                          return Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.05,
                              ),
                              borderRadius: BorderRadius.circular(
                                roundedRadius,
                              ),
                            ),
                            child: Column(
                              children: [
                                ScriptProcessor(
                                  scriptInfo: ScriptInfo(
                                    surahNumber: surahNumber,
                                    ayahNumber: ayahNumber,
                                    quranScriptType: quranScriptType,
                                    wordIndex: index,
                                  ),
                                ),
                                const Gap(5),
                                Text(wordByWord[index]),
                              ],
                            ),
                          );
                        }),
                      )
                      : null,
            ),
        ],
      ),
    );
  }
}
