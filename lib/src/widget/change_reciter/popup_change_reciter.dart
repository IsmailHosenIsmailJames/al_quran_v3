import "package:flutter/material.dart";

void popupChangeReciter(BuildContext context, String initAyahKey) async {
  await showDialog(
    context: context,

    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
    },
  );
}
