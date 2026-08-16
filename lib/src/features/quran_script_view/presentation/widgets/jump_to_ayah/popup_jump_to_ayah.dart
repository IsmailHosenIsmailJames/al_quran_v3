import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/jump_to_ayah.dart";
import "package:flutter/material.dart";

Future<void> popupJumpToAyah({
  required BuildContext context,
  String? initAyahKey,
  required bool isAudioPlayer,
  bool? selectMultipleAndShare,
  Function(String ayahKey)? onPlaySelected,
  Function(String ayahKey)? onSelectAyah,
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
            borderRadius: BorderRadius.circular(roundedRadius + 6),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560,
              maxHeight: height * 0.82,
            ),
            child: JumpToAyahView(
              initAyahKey: initAyahKey,
              isAudioPlayer: isAudioPlayer,
              onPlaySelected: onPlaySelected,
              selectMultipleAndShare: selectMultipleAndShare,
              onSelectAyah: onSelectAyah,
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
        return Container(
          height: height * 0.82,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(roundedRadius + 6),
            ),
          ),
          clipBehavior: Clip.antiAlias,
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
}
