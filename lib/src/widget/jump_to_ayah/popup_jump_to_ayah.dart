import "package:al_quran_v3/src/widget/jump_to_ayah/jump_to_ayah.dart";
import "package:flutter/material.dart";

void popupJumpToAyah(BuildContext context, String initAyahKey) async {
  await showDialog(
    context: context,

    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: JumpToAyahView(initAyahKey: initAyahKey),
      );
    },
  );
}
