import 'dart:developer';

import 'package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SurahInfoView extends StatelessWidget {
  final String html;
  final SurahInfoModel surahInfoModel;
  const SurahInfoView({
    super.key,
    required this.html,
    required this.surahInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${surahInfoModel.nameSimple} (${surahInfoModel.nameArabic})',
        ),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: html,
          onLinkTap: (url, attributes, element) {
            log(url.toString());
            try {
              url ??= '';
              int countOfSlash = url.characters.count(
                (element) => element == '/',
              );
              int countOfDash = url.characters.count(
                (element) => element == '-',
              );
              log(countOfSlash.toString());
              log(countOfDash.toString());
              if (countOfSlash == 1) {
                int? surahNumber = int.tryParse(url.split('/').last);
                if (surahNumber != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuranScriptView(
                            startKey: '$surahNumber:${1}',
                            endKey: getEndAyahKeyFromSurahNumber(surahNumber),
                          ),
                    ),
                  );
                }
              } else if (countOfSlash == 2) {
                String surahNumber = url.split('/')[1];
                List<String> ayahsRange = url.split('/').last.split('-');
                String startAyahKey = '$surahNumber:${ayahsRange.first}';
                String endAyahKey = '$surahNumber:${ayahsRange.last}';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuranScriptView(
                          startKey: startAyahKey,
                          endKey: endAyahKey,
                        ),
                  ),
                );
              }
            } catch (e) {
              log(e.toString());
            }
          },
        ),
      ),
    );
  }
}
