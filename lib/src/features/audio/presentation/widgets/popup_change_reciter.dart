import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/change_reciter.dart";
import "package:flutter/material.dart";

Future<void> popupChangeReciter(
  BuildContext context,
  ReciterInfoModel initReciter,
  Function(ReciterInfoModel index) onReciterChanged, {
  bool? isWordByWord,
}) async {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final isLargeScreen = width >= 600;

  if (isLargeScreen) {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 540,
              maxHeight: height * 0.85,
            ),
            child: ChangeReciter(
              initReciterIndex: initReciter,
              onReciterChanged: onReciterChanged,
              isWordByWord: isWordByWord,
            ),
          ),
        );
      },
    );
  } else {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: height * 0.85,
          child: ChangeReciter(
            initReciterIndex: initReciter,
            onReciterChanged: onReciterChanged,
            isWordByWord: isWordByWord,
          ),
        );
      },
    );
  }
}
