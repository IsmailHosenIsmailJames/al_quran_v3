import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  late List ayahsList;
  @override
  void initState() {
    int startSurahNumber = int.parse(widget.startKey.split(':')[0]);
    int startAyahNumber = int.parse(widget.startKey.split(':')[1]);
    int endSurahNumber = int.parse(widget.endKey.split(':')[0]);
    int endAyahNumber = int.parse(widget.endKey.split(':')[1]);
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
        ayahsList.add('$surah:$ayah');
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );

    return ListView.builder(
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
        int surahNumber = int.parse(ayahsList[index].toString().split(':')[0]);
        int ayahNumber = int.parse(ayahsList[index].toString().split(':')[1]);
        return Align(
          alignment: Alignment.centerRight,
          child: ScriptProcessor(
            scriptInfo: ScriptInfo(
              surahNumber: surahNumber,
              ayahNumber: ayahNumber,
              quranScriptType: quranScriptType,
              limitWord: 4,
            ),
          ),
        );
      },
    );
  }
}
