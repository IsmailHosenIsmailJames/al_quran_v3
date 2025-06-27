import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
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
      log(value.toString());
      value = value?.toString().replaceAll('"', "");
      if (value?.split(":").first.isInt == true &&
          value?.split(":").last.isInt == true) {
        isLinkedToAnother = true;
        anotherAyahLinkKey = value!;
      } else {
        tafsirDataString = value ?? "";
      }
      log(isLinkedToAnother.toString());
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
                  Center(
                    child: Text("Tafsir will found at : $anotherAyahLinkKey"),
                  ),
                  const Gap(20),
                  Center(
                    child: OutlinedButton(
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
                  ),
                ],
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: 50,
                ),
                child: BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return Html(
                      data: tafsirDataString,
                      style: {
                        "*": Style(
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                          fontSize: FontSize(state.translationFontSize),
                        ),
                      },
                    );
                  },
                ),
              ),
    );
  }
}
