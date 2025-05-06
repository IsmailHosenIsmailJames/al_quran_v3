import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';

class ShowPopupOfWord extends StatelessWidget {
  final String wordKey;
  final String word;
  final QuranScriptType scriptCategory;
  const ShowPopupOfWord({
    super.key,
    required this.wordKey,
    required this.word,
    required this.scriptCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Text('$wordKey -> $word');
  }
}
