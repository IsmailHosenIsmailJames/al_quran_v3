import 'dart:convert';

import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class TafsirView extends StatefulWidget {
  final String ayahKey;
  const TafsirView({super.key, required this.ayahKey});

  @override
  State<TafsirView> createState() => _TafsirViewState();
}

class _TafsirViewState extends State<TafsirView> {
  String tafsirDataString = '';
  bool isLinkedToAnother = false;
  String? anotherAyahLinkKey;
  late SurahInfoModel surahInfoModel;
  @override
  void initState() {
    initCallBack().then((value) {
      setState(() {});
    });
    surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[widget.ayahKey.split(':').first],
    );
    super.initState();
  }

  Future<void> initCallBack() async {
    Box box = Hive.box('quran_tafsir');
    final rawData = box.get(widget.ayahKey, defaultValue: null);
    if (rawData != null) {
      try {
        Map data = jsonDecode(rawData);
        String? text = data['text'];
        if (text == null) {
          tafsirDataString = 'Not Found';
        } else if (text.split(':').length == 2) {
          if (int.tryParse(text.split(':')[0]) != null &&
              int.tryParse(text.split(':')[1]) != null) {
            isLinkedToAnother = true;
            anotherAyahLinkKey = text;
          } else {
            tafsirDataString = text;
          }
        } else {
          tafsirDataString = text;
        }
      } catch (e) {
        tafsirDataString = rawData;
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          '${surahInfoModel.nameSimple} ( ${surahInfoModel.nameArabic} ) - ${widget.ayahKey} ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body:
          isLinkedToAnother
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Tafsir will found at : $anotherAyahLinkKey'),
                  const Gap(20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TafsirView(ayahKey: anotherAyahLinkKey!);
                          },
                        ),
                        (route) {
                          return true;
                        },
                      );
                    },
                    child: Text('Jump to $anotherAyahLinkKey'),
                  ),
                ],
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: 100,
                ),
                child: HtmlWidget(tafsirDataString),
              ),
    );
  }
}
