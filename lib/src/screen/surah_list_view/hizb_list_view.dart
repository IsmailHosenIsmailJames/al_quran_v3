import 'package:al_quran_v3/src/resources/meta_data/meaning_of_surah.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/hizb_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/components/get_surah_index_widget.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class HizbListView extends StatelessWidget {
  final List<HizbModel> hizbInfoList;
  const HizbListView({super.key, required this.hizbInfoList});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );
    ScrollController scrollController = ScrollController();

    return Scrollbar(
      controller: scrollController,
      radius: Radius.circular(roundedRadius),
      thickness: 10,
      interactive: true,

      child: ListView.builder(
        controller: scrollController,
        itemCount: hizbInfoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.05),
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuranScriptView(
                          startKey: hizbInfoList[index].firstVerseKey,
                          endKey: hizbInfoList[index].lastVerseKey,
                        ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 3,
                  bottom: 3,
                ),
                height: 55,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Hizb',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                            const Gap(10),
                            getIndexNumberWidget(
                              context,
                              index + 1,
                              height: 25,
                              width: 25,
                              textColor: textColor,
                            ),
                          ],
                        ),
                        const Gap(2),
                        Text(
                          "${listOfSurahNameEnglish[int.parse(hizbInfoList[index].firstVerseKey.split(':')[0]) - 1]} ${hizbInfoList[index].firstVerseKey}",
                          style: TextStyle(
                            color:
                                brightness == Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: ScriptProcessor(
                          scriptInfo: ScriptInfo(
                            surahNumber: int.parse(
                              hizbInfoList[index].firstVerseKey.split(':')[0],
                            ),
                            ayahNumber: int.parse(
                              hizbInfoList[index].firstVerseKey.split(':')[1],
                            ),
                            quranScriptType: quranScriptType,
                            limitWord: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
