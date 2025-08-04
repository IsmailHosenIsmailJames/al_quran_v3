import "package:flutter/widgets.dart";
import "package:toastification/toastification.dart";

void showToastNotification(
  BuildContext context, {
  required String msg,
  bool isError = false,
}) {
  toastification.show(
    context: context,
    title: Text(msg),
    type: isError ? ToastificationType.error : ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 3),
  );
}
