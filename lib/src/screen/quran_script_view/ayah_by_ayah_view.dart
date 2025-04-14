import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:flutter/material.dart';
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

class _AyahByAyahViewState extends State<AyahByAyahView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  late List ayahsList;
  @override
  void initState() {
    int startSurahNumber = int.parse(widget.startKey.split(':')[0]);
    int startAyahNumber = int.parse(widget.startKey.split(':')[1]);
    int endSurahNumber = int.parse(widget.endKey.split(':')[0]);
    int endAyahNumber = int.parse(widget.endKey.split(':')[1]);
    int? indexToScroll;
    ayahsList = [];
    for (int surah = startSurahNumber; surah <= endSurahNumber; surah++) {
      int startAyah = 1;
      if (surah == startSurahNumber) startAyah = startAyahNumber;
      int endAyah = quranAyahCount[surah - 1];
      if (surah == endSurahNumber) {
        endAyah = endAyahNumber;
      }
      for (int ayah = startAyah; ayah <= endAyah; ayah++) {
        if (ayah == 1) {
          ayahsList.add(surah);
        }
        if ('$surah:$ayah' == widget.toScrollKey) {
          indexToScroll = ayahsList.length;
        }
        ayahsList.add('$surah:$ayah');
      }
    }
    if (indexToScroll != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        itemScrollController.scrollTo(
          index: indexToScroll!,
          duration: const Duration(milliseconds: 200),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );

    return Stack(
      children: [
        ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          scrollOffsetController: scrollOffsetController,
          itemPositionsListener: itemPositionsListener,
          scrollOffsetListener: scrollOffsetListener,
          itemCount: ayahsList.length,

          itemBuilder: (context, index) {
            // it is actually a surah number
            if (ayahsList[index].runtimeType == int) {
              return SurahInfoHeaderBuilder(
                surahInfoModel: SurahInfoModel.fromMap(
                  metaDataSurah.values.elementAt((ayahsList[index] as int) - 1),
                ),
              );
            }
            int surahNumber = int.parse(
              ayahsList[index].toString().split(':')[0],
            );
            int ayahNumber = int.parse(
              ayahsList[index].toString().split(':')[1],
            );
            Map translationMap =
                Hive.box('quran_translation').get(ayahsList[index]) ??
                {'t': 'Translation Not Found'};
            String translation = translationMap['t'] ?? 'Translation Not Found';
            translation = translation.replaceAll('>', '> ');
            Map footNote = translationMap['f'];
            return Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(
                left: 5,
                top: 5,
                bottom: 5,
                right: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedRadius),
                color: AppColors.primaryColor.withValues(alpha: 0.05),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

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
                          icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
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
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
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
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
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
                                padding: EdgeInsets.only(bottom: 5),
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
                ],
              ),
            );
          },
        ),

        Align(
          alignment: Alignment.centerRight,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            height: 1000,
            width: 7,
            margin: const EdgeInsets.only(right: 1),

            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(roundedRadius),
            ),
            alignment: Alignment(
              0,
              itemPositionsListener.itemPositions.value.isEmpty
                  ? -1
                  : ((itemPositionsListener.itemPositions.value.first.index /
                              ayahsList.length) *
                          2) -
                      1,
            ),
            child: Container(
              height: 50,
              width: 7,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
