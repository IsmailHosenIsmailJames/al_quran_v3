import "package:al_quran_v3/src/screen/audio/change_reciter/change_reciter.dart";
import "package:flutter/material.dart";

Future<void> popupChangeReciter(
  BuildContext context,
  int initReciterIndex,
  Function(int index) onReciterChanged,
) async {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ChangeReciter(
          initReciterIndex: initReciterIndex,
          onReciterChanged: onReciterChanged,
        ),
      );
    },
  );
}
