import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/platform_services.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:toastification/toastification.dart";

void showToastMessage({
  required BuildContext context,
  required String msg,
  int state = 0,
}) {
  if (!(platformOwn == PlatformOwn.isAndroid ||
      platformOwn == PlatformOwn.isIos ||
      kIsWeb)) {
    toastification.show(
      context: context,

      type:
          state == 0
              ? ToastificationType.info
              : state == 1
              ? ToastificationType.success
              : ToastificationType.error,

      title: Text(
        state == 0
            ? "Information"
            : state == 1
            ? "Successful"
            : "Ops... Error!",
      ),
      description: Text(msg),
    );
  }
}
