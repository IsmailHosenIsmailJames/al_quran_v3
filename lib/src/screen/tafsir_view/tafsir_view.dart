import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";

import "../../functions/get_tafsir_from_db.dart";

class TafsirView extends StatefulWidget {
  final String ayahKey;
  const TafsirView({super.key, required this.ayahKey});

  @override
  State<TafsirView> createState() => _TafsirViewState();
}

class _TafsirViewState extends State<TafsirView> {
  String tafsirDataString = "";
  bool isLinkedToAnother = false;
  String anotherAyahLinkKey = "";
  late SurahInfoModel surahInfoModel;
  @override
  void initState() {
    getTafsirFromDb(widget.ayahKey).then((value) {
      if (value?.split(":").first.isInt == true &&
          value?.split(":").last.isInt == true) {
        isLinkedToAnother = true;
        anotherAyahLinkKey = value!;
      } else {
        tafsirDataString = value ?? "";
      }
      setState(() {});
    });
    surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[widget.ayahKey.split(":").first],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "${surahInfoModel.nameSimple} ( ${surahInfoModel.nameArabic} ) - ${widget.ayahKey} ",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body:
          isLinkedToAnother
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Tafsir will found at : $anotherAyahLinkKey"),
                  const Gap(20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TafsirView(ayahKey: anotherAyahLinkKey);
                          },
                        ),
                        (route) {
                          return true;
                        },
                      );
                    },
                    child: Text("Jump to $anotherAyahLinkKey"),
                  ),
                ],
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 5,
                  right: 5,
                  bottom: 50,
                ),
                child: Html(data: tafsirDataString),
              ),
    );
  }
}
