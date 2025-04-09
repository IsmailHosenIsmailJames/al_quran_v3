import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:flutter/material.dart';

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahInfoModel surahInfoModel;
  const SurahInfoHeaderBuilder({super.key, required this.surahInfoModel});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(surahInfoModel.toJson()));
  }
}
