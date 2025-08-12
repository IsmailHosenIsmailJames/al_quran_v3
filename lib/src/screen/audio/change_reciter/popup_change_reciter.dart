import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/screen/audio/change_reciter/change_reciter.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";

Future<void> popupChangeReciter(
  BuildContext context,
  ReciterInfoModel initReciter,

  Function(ReciterInfoModel index) onReciterChanged, {
  bool? isWordByWord,
}) async {
  await showDialog(
    context: context,

    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: ChangeReciter(
          initReciterIndex: initReciter,
          onReciterChanged: onReciterChanged,
          isWordByWord: isWordByWord,
        ),
      );
    },
  );
}
