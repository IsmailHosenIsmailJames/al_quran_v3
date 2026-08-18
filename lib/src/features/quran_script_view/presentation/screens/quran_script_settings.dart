import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/theme/widgets/theme_icon_button.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_overview.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/preview/script_selection_segment_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";

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
    final appLocalizations = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;

    Widget bodyWidget = BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        final cubit = context.read<QuranViewCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Script Style & Preview Card
            _buildSectionContainer(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: FluentIcons.book_letter_24_regular,
                    title: appLocalizations.quranStyle,
                    themePrimary: themeState.primary,
                  ),
                  const Gap(12),
                  getScriptSelectionSegmentedButtons(context),
                  const Gap(14),
                  // Live Ayah Preview
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: getAyahByAyahCard(
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
                  ),
                ],
              ),
            ),

            const Gap(14),

            // 2. Typography & Fonts Card
            _buildSectionContainer(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: FluentIcons.text_font_24_regular,
                    title: "Typography & Font Settings",
                    themePrimary: themeState.primary,
                  ),
                  const Gap(14),
                  const QuranFontSelectionWidget(),
                  const Gap(16),

                  // Quran Font Size
                  _buildStepperSlider(
                    context,
                    label: appLocalizations.quranFontSize,
                    value: quranViewState.fontSize,
                    displayValue:
                        "${localizedNumber(context, quranViewState.fontSize.toStringAsFixed(0))} pt",
                    min: 10,
                    max: 60,
                    divisions: 50,
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    onChanged: (val) =>
                        cubit.changeFontSize(double.parse(val.toStringAsFixed(1))),
                  ),

                  const Gap(16),

                  // Quran Line Height
                  _buildStepperSlider(
                    context,
                    label: appLocalizations.quranLineHeight,
                    value: quranViewState.lineHeight,
                    displayValue:
                        "${localizedNumber(context, quranViewState.lineHeight.toStringAsFixed(1))}x",
                    min: 0.8,
                    max: 4.0,
                    divisions: 32,
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    onChanged: (val) =>
                        cubit.changeLineHeight(double.parse(val.toStringAsFixed(1))),
                  ),

                  const Gap(16),

                  // Translation Font Size
                  _buildStepperSlider(
                    context,
                    label: appLocalizations.translationAndTafsirFontSize,
                    value: quranViewState.translationFontSize,
                    displayValue:
                        "${localizedNumber(context, quranViewState.translationFontSize.toStringAsFixed(0))} pt",
                    min: 8,
                    max: 50,
                    divisions: 42,
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    onChanged: (val) =>
                        cubit.changeTranslationFontSize(double.parse(val.toStringAsFixed(1))),
                  ),
                ],
              ),
            ),

            const Gap(14),

            // 3. Display & Content Toggles Card
            _buildSectionContainer(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: FluentIcons.eye_24_regular,
                    title: "Display & Content Options",
                    themePrimary: themeState.primary,
                  ),
                  const Gap(10),

                  _buildSwitchRow(
                    title: appLocalizations.quranAyah,
                    value: !quranViewState.hideQuranAyah,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.setViewOptions(hideQuranAyah: !v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.translation,
                    value: !quranViewState.hideTranslation,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.setViewOptions(hideTranslation: !v),
                  ),

                  if (!quranViewState.hideTranslation) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: DownloadedTranslationsSettings(),
                    ),
                    const Divider(height: 1),
                  ],

                  _buildSwitchRow(
                    title: appLocalizations.wordByWord,
                    value: !quranViewState.hideWordByWord,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.setViewOptions(hideWordByWord: !v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.keepOpenWordByWord,
                    value: quranViewState.alwaysOpenWordByWord,
                    themePrimary: themeState.primary,
                    onChanged: (v) =>
                        cubit.setViewOptions(alwaysOpenWordByWord: v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.wordByWordHighlight,
                    value: quranViewState.enableWordByWordHighlight,
                    themePrimary: themeState.primary,
                    onChanged: (v) =>
                        cubit.setViewOptions(enableWordByWordHighlight: v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.footnote,
                    value: !quranViewState.hideFootnote,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.setViewOptions(hideFootnote: !v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.circleJojomInQuranScript,
                    value: quranViewState.circleJojom,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.changeCircleJojom(v),
                  ),

                  const Divider(height: 1),

                  _buildSwitchRow(
                    title: appLocalizations.topToolbar,
                    value: !quranViewState.hideToolbar,
                    themePrimary: themeState.primary,
                    onChanged: (v) => cubit.setViewOptions(hideToolbar: !v),
                  ),
                ],
              ),
            ),

            const Gap(14),

            // 4. Recitation & Reader Audio Card
            _buildSectionContainer(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    icon: FluentIcons.headphones_24_regular,
                    title: appLocalizations.selectReciter,
                    themePrimary: themeState.primary,
                  ),
                  const Gap(12),
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
                  if (showAudioSpeedController) ...[
                    const Gap(16),
                    const PlayBackSpeedWidget(),
                  ],
                  const Gap(12),
                  _buildSwitchRow(
                    title: appLocalizations.scrollWithRecitation,
                    subtitle: appLocalizations.scrollWithRecitationDesc,
                    value: quranViewState.scrollWithRecitation,
                    themePrimary: themeState.primary,
                    onChanged: (v) =>
                        cubit.setViewOptions(scrollWithRecitation: v),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    return asPage
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                appLocalizations.quranScriptSettings,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [themeIconButton(context)],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SafeArea(child: bodyWidget),
            ),
          )
        : bodyWidget;
  }

  Widget _buildSectionContainer({
    required Widget child,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color themePrimary,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: themePrimary),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStepperSlider(
    BuildContext context, {
    required String label,
    required double value,
    required String displayValue,
    required double min,
    required double max,
    required int divisions,
    required Color themePrimary,
    required bool isDark,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: themePrimary.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                displayValue,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: themePrimary,
                ),
              ),
            ),
          ],
        ),
        const Gap(6),
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: value > min
                  ? () => onChanged(
                      (value - (max - min) / divisions).clamp(min, max),
                    )
                  : null,
              style: IconButton.styleFrom(
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade100,
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(FluentIcons.subtract_16_regular, size: 16),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: themePrimary,
                  thumbColor: themePrimary,
                  inactiveTrackColor: themePrimary.withValues(
                    alpha: isDark ? 0.2 : 0.15,
                  ),
                  trackHeight: 3,
                ),
                child: Slider(
                  value: value.clamp(min, max),
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: onChanged,
                ),
              ),
            ),
            IconButton.filledTonal(
              onPressed: value < max
                  ? () => onChanged(
                      (value + (max - min) / divisions).clamp(min, max),
                    )
                  : null,
              style: IconButton.styleFrom(
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade100,
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(FluentIcons.add_16_regular, size: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchRow({
    required String title,
    String? subtitle,
    required bool value,
    required Color themePrimary,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null && subtitle.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: themePrimary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget buildReciterOverViewWidget(
    BuildContext context,
    ReciterInfoModel reciter,
    AyahKeyManagement ayahState,
  ) {
    final l10n = AppLocalizations.of(context);
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
        return SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(AppLocalizations.of(context).circleJojomInQuranScript),
          value: quranViewState.circleJojom,
          activeTrackColor: context.watch<ThemeCubit>().state.primary,
          onChanged: (value) {
            context.read<QuranViewCubit>().changeCircleJojom(value);
          },
        );
      },
    );
  }
}

class QuranFontSelectionWidget extends StatelessWidget {
  final TextStyle? titleStyle;
  const QuranFontSelectionWidget({super.key, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.quranScriptType == QuranScriptType.uthmani
                ? l10n.uthmaniFont
                : l10n.indopakFont,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade300,
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
                  size: 18,
                ),
                dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.grey.shade900,
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
        ],
      ),
    );
  }
}
