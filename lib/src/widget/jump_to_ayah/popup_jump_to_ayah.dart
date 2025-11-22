import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/jump_to_ayah.dart";
import "package:flutter/material.dart";

Future<void> popupJumpToAyah({
  required BuildContext context,
  String? initAyahKey,
  required bool isAudioPlayer,
  bool? selectMultipleAndShare,
  Function(String ayahKey)? onPlaySelected,
  final Function(String ayahKey)? onSelectAyah,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor.withValues(alpha: 0.8),
        insetPadding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 20,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: JumpToAyahView(
          initAyahKey: initAyahKey,
          isAudioPlayer: isAudioPlayer,
          onPlaySelected: onPlaySelected,
          selectMultipleAndShare: selectMultipleAndShare,
          onSelectAyah: onSelectAyah,
        ),
      );
    },
  );
}
