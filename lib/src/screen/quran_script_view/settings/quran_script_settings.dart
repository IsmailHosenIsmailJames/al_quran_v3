import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/widget/audio/reciter_overview.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:screenshot/screenshot.dart";

import "../../../widget/preview_quran_script/ayah_preview_widget.dart";
import "../../settings/cubit/quran_script_view_cubit.dart";
import "../../settings/cubit/quran_script_view_state.dart";
import "../../setup/setup_page.dart";

class QuranScriptSettings extends StatelessWidget {
  final bool asPage;

  const QuranScriptSettings({super.key, this.asPage = false});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    Widget bodyWidget = BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        final cubit = context.read<QuranViewCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quran Style", style: titleStyle),
            const Gap(7),
            getScriptSelectionSegmentedButtons(context),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quran Font Size", style: titleStyle),
                Text(quranViewState.fontSize.toString(), style: titleStyle),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.fontSize,
                max: 60,
                min: 10,
                divisions: 100,
                onChanged: (value) {
                  context.read<QuranViewCubit>().changeFontSize(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quran Line Height", style: titleStyle),
                Text(quranViewState.lineHeight.toString(), style: titleStyle),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.lineHeight,
                max: 5,
                min: 0.7,
                divisions: 100,

                onChanged: (value) {
                  context.read<QuranViewCubit>().changeLineHeight(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Translation & Tafsir Font Size", style: titleStyle),
                Text(
                  quranViewState.translationFontSize.toString(),
                  style: titleStyle,
                ),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.translationFontSize,
                max: 60,
                min: 8,
                divisions: 100,
                onChanged: (value) {
                  context.read<QuranViewCubit>().changeTranslationFontSize(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(10),
            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Quran Ayah",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideQuranAyah,
              onChanged: (value) {
                cubit.setViewOptions(hideQuranAyah: !value);
              },
            ),
            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Translation",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideTranslation,
              onChanged: (value) {
                cubit.setViewOptions(hideTranslation: !value);
              },
            ),
            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Word By Word",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideWordByWord,
              onChanged: (value) {
                cubit.setViewOptions(hideWordByWord: !value);
              },
            ),
            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Foot Note",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideFootnote,
              onChanged: (value) {
                cubit.setViewOptions(hideFootnote: !value);
              },
            ),
            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Top Toolbar",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideToolbar,
              onChanged: (value) {
                cubit.setViewOptions(hideToolbar: !value);
              },
            ),

            SwitchListTile(
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Keep Open Word By Word",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: quranViewState.alwaysOpenWordByWord,
              onChanged: (value) {
                cubit.setViewOptions(alwaysOpenWordByWord: value);
              },
            ),

            const Gap(5),
            getAyahPreviewWidget(showHeaderOptions: true),

            const Gap(10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Word By Word Highlight"),
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),

              value: quranViewState.enableWordByWordHighlight,
              onChanged: (value) {
                cubit.setViewOptions(enableWordByWordHighlight: value);
              },
            ),
            if (quranViewState.enableWordByWordHighlight)
              BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
                builder: (context, reciter) {
                  return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
                    builder: (context, ayahState) {
                      return buildReciterOverViewWidget(
                        context,
                        reciter,
                        ayahState,
                      );
                    },
                  );
                },
              ),
          ],
        );
      },
    );

    return asPage
        ? Scaffold(
          appBar: AppBar(title: const Text("Quran Script Settings")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 60,
            ),
            child: bodyWidget,
          ),
        )
        : bodyWidget;
  }

  Widget buildReciterOverViewWidget(
    BuildContext context,
    ReciterInfoModel reciter,
    AyahKeyManagement ayahState,
  ) {
    return getReciterWidget(
      context: context,
      audioTabScreenState: reciter,
      ayahKeyState: ayahState,
      isWordByWord: true,
      onReciterChanged: (reciterInfoModel) async {
        context.read<SegmentedQuranReciterCubit>().changeReciter(
          reciterInfoModel,
        );
        if (AudioPlayerManager.audioPlayer.playing) {
          if (AudioPlayerManager.audioPlayer.audioSources.length > 1) {
            await AudioPlayerManager.playMultipleAyahAsPlaylist(
              startAyahKey: ayahState.start,
              endAyahKey: ayahState.end,
              isInsideQuran: true,
              reciterInfoModel: reciterInfoModel,
            );
          } else {
            AudioPlayerManager.playSingleAyah(
              ayahKey: ayahState.current,
              reciterInfoModel: reciterInfoModel,
              isInsideQuran: true,
            );
          }
        }
        Navigator.pop(context);
      },
    );
  }
}
