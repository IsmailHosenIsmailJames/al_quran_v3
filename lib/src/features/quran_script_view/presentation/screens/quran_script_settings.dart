import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_overview.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/preview/script_selection_segment_button.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/core/theme/widgets/theme_icon_button.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:screenshot/screenshot.dart";

// import "../../../widget/preview_quran_script/ayah_preview_widget.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "downloaded_translations_settings.dart";

class QuranScriptSettings extends StatelessWidget {
  final bool asPage;
  final bool showAudioSpeedController;

  const QuranScriptSettings({
    super.key,
    this.asPage = false,
    this.showAudioSpeedController = true,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
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
            Text(appLocalizations.quranStyle, style: titleStyle),
            const Gap(7),
            getScriptSelectionSegmentedButtons(context),
            const Gap(10),

            getAyahByAyahCard(
              ayahKey: "1:2",
              context: context,
              translationListWithInfo: [],
              showTopOptions: false,
              showOnlyAyah: true,
              removeBorder: true,
              keepMargin: false,
              isCenter: true,
              wordByWord: [],
            ),
            const Gap(10),
            const CircleJojomQuranViewOption(),
            const Gap(10),
            QuranFontSelectionWidget(titleStyle: titleStyle),

            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.quranFontSize, style: titleStyle),
                Text(
                  localizedNumber(context, quranViewState.fontSize),
                  style: titleStyle,
                ),
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
                label: context.read<QuranViewCubit>().state.fontSize.toString(),

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
                Text(
                  appLocalizations.translationAndTafsirFontSize,
                  style: titleStyle,
                ),
                Text(
                  localizedNumber(context, quranViewState.translationFontSize),
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
                label: context
                    .read<QuranViewCubit>()
                    .state
                    .translationFontSize
                    .toString(),
                onChanged: (value) {
                  context.read<QuranViewCubit>().changeTranslationFontSize(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.quranLineHeight, style: titleStyle),
                Text(
                  localizedNumber(context, quranViewState.lineHeight),
                  style: titleStyle,
                ),
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
                label: context
                    .read<QuranViewCubit>()
                    .state
                    .lineHeight
                    .toString(),
                onChanged: (value) {
                  context.read<QuranViewCubit>().changeLineHeight(
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
              title: Text(
                appLocalizations.quranAyah,
                style: const TextStyle(fontWeight: FontWeight.w500),
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
              title: Text(
                appLocalizations.translation,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              value: !quranViewState.hideTranslation,
              onChanged: (value) {
                cubit.setViewOptions(hideTranslation: !value);
              },
            ),
            if (!quranViewState.hideTranslation)
              const DownloadedTranslationsSettings(),
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
              title: Text(
                appLocalizations.wordByWord,
                style: const TextStyle(fontWeight: FontWeight.w500),
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
              title: Text(
                appLocalizations.footnote,
                style: const TextStyle(fontWeight: FontWeight.w500),
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
              title: Text(
                appLocalizations.topToolbar,
                style: const TextStyle(fontWeight: FontWeight.w500),
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
              title: Text(
                appLocalizations.keepOpenWordByWord,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              value: quranViewState.alwaysOpenWordByWord,
              onChanged: (value) {
                cubit.setViewOptions(alwaysOpenWordByWord: value);
              },
            ),

            //  const Gap(5),
            //  getAyahPreviewWidget(showHeaderOptions: true),
            const Gap(10),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(appLocalizations.wordByWordHighlight),
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
            const Gap(10),

            Text(
              appLocalizations.selectReciter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Gap(10),
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
            const Gap(20),
            if (showAudioSpeedController) const PlayBackSpeedWidget(),
            const Gap(10),
            BlocBuilder<QuranViewCubit, QuranViewState>(
              builder: (context, quranViewState) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(appLocalizations.scrollWithRecitation),
                  subtitle: Text(appLocalizations.scrollWithRecitationDesc),
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                    Set<WidgetState> states,
                  ) {
                    return Icon(
                      states.contains(WidgetState.selected)
                          ? Icons.done_rounded
                          : Icons.close_rounded,
                    );
                  }),

                  value: quranViewState.scrollWithRecitation,
                  onChanged: (value) {
                    context.read<QuranViewCubit>().setViewOptions(
                      scrollWithRecitation: value,
                    );
                  },
                );
              },
            ),
            const Gap(10),
          ],
        );
      },
    );

    return asPage
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: context.read<ThemeCubit>().state.mutedGray,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Theme.brightnessOf(context) == Brightness.dark
                  ? Colors.grey.shade900.withValues(alpha: 0.5)
                  : Colors.grey.shade200.withValues(alpha: 0.5),
              title: Text(appLocalizations.quranScriptSettings),
              actions: [themeIconButton(context)],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 60,
              ),
              child: SafeArea(child: bodyWidget),
            ),
          )
        : bodyWidget;
  }

  Widget buildReciterOverViewWidget(
    BuildContext context,
    ReciterInfoModel reciter,
    AyahKeyManagement ayahState,
  ) {
    AppLocalizations l10n = AppLocalizations.of(context);
    return BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
      builder: (context, state) {
        Widget toReturn = getReciterWidget(
          context: context,
          audioTabScreenState: reciter,
          ayahKeyState: ayahState,
          isWordByWord: true,
          onReciterChanged: (reciterInfoModel) async {
            Navigator.pop(context);
            bool isSuccess = await context
                .read<SegmentedQuranReciterCubit>()
                .changeReciter(context, reciterInfoModel);

            if (!isSuccess) {
              Fluttertoast.showToast(msg: l10n.unableToDownloadResources);
              return;
            } else {
              Fluttertoast.showToast(msg: l10n.success);
            }

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
          },
        );
        if (state.isDownloading) {
          return Container(
                decoration: BoxDecoration(
                  color: context.read<ThemeCubit>().state.primaryShade300,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                child: toReturn,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1200.ms, color: const Color(0x80000000))
              .animate()
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad);
        }
        return toReturn;
      },
    );
  }
}

class CircleJojomQuranViewOption extends StatelessWidget {
  const CircleJojomQuranViewOption({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context).circleJojomInQuranScript),
          value: quranViewState.circleJojom,
          thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
            Set<WidgetState> states,
          ) {
            return Icon(
              states.contains(WidgetState.selected)
                  ? Icons.done_rounded
                  : Icons.close_rounded,
            );
          }),
          onChanged: (value) {
            context.read<QuranViewCubit>().changeCircleJojom(value);
          },
        );
      },
    );
  }
}

class QuranFontSelectionWidget extends StatelessWidget {
  const QuranFontSelectionWidget({super.key, required this.titleStyle});

  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.quranScriptType == QuranScriptType.uthmani
                ? l10n.uthmaniFont
                : l10n.indopakFont,
            style: titleStyle,
          ),
          const Gap(10),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(roundedRadius),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.quranScriptType == QuranScriptType.uthmani
                        ? state.uthmaniFontName
                        : state.indopakFontName,
                    isExpanded: false,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),
                    dropdownColor: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(roundedRadius),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    items: state.quranScriptType == QuranScriptType.uthmani
                        ? const [
                            DropdownMenuItem(
                              value: "QPC_Hafs",
                              child: Text("QPC Hafs"),
                            ),
                            DropdownMenuItem(
                              value: "me_quran_volt_newmet",
                              child: Text("Me Quran"),
                            ),
                            DropdownMenuItem(
                              value: "Amiri",
                              child: Text("Amiri"),
                            ),
                            DropdownMenuItem(
                              value: "AlQalamQuranMajeedWeb",
                              child: Text("Al Qalam Quran Majeed"),
                            ),
                            DropdownMenuItem(
                              value: "Lateef",
                              child: Text("Lateef"),
                            ),
                          ]
                        : const [
                            DropdownMenuItem(
                              value: "AlQuranNeov5x1",
                              child: Text("Al Quran Neov5x1"),
                            ),
                            DropdownMenuItem(
                              value: "IndopakNastaleeq",
                              child: Text("Indopak Nastaleeq"),
                            ),
                            DropdownMenuItem(
                              value: "noorehira",
                              child: Text("Noore Hira"),
                            ),
                            DropdownMenuItem(
                              value: "noorehuda",
                              child: Text("Noore Huda"),
                            ),
                          ],
                    onChanged: (value) {
                      if (value == null) return;
                      if (state.quranScriptType == QuranScriptType.uthmani) {
                        context.read<QuranViewCubit>().changeUthmaniFontName(
                          value,
                        );
                      } else {
                        context.read<QuranViewCubit>().changeIndopakFontName(
                          value,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
