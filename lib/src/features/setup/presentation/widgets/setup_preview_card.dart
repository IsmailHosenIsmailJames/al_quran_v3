import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/book_search_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/book_select_bottom_sheet.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/preview/script_selection_segment_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class SetupPreviewCard extends StatelessWidget {
  final VoidCallback onDownloadPressed;

  const SetupPreviewCard({super.key, required this.onDownloadPressed});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final boxBg = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.grey.shade100;
    final boxBorder = isDark
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.black.withValues(alpha: 0.08);

    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        return Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                  blurRadius: 16,
                  spreadRadius: 1,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getScriptSelectionSegmentedButtons(context),
                getAyahByAyahCard(
                ayahKey: "1:1",
                context: context,
                translationListWithInfo: [],
                showTopOptions: false,
                showOnlyAyah: true,
                removeBorder: true,
                keepMargin: false,
                isCenter: true,
                wordByWord: [],
                showBottomsheetOnTap: false,
              ),
              const Gap(10),
              const QuranFontSelectionWidget(
                titleStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(10),

              // Translation Selection Box
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: boxBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: boxBorder, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.translation,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            state.config.selectedTranslation?.name ??
                                "Select Translation",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _showBookSelectBottomSheet(context, isTafsir: false);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: themeState.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.swap_vert_rounded, size: 18),
                      label: Text(
                        appLocalizations.change,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),

              // Tafsir Selection Box
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: boxBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: boxBorder, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.tafsir,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            state.config.selectedTafsir?.name ??
                                "Select Tafsir",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _showBookSelectBottomSheet(context, isTafsir: true);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: themeState.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.swap_vert_rounded, size: 18),
                      label: Text(
                        appLocalizations.change,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(14),

              // CTA Button
              SafeArea(
                bottom: true,
                left: false,
                right: false,
                top: false,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: onDownloadPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: themeState.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(
                      FluentIcons.arrow_download_24_filled,
                      size: 22,
                    ),
                    label: Text(
                      appLocalizations.saveAndDownload,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void _showBookSelectBottomSheet(
    BuildContext context, {
    required bool isTafsir,
  }) {
    final setupBloc = context.read<SetupBloc>();
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: 0.85,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: setupBloc),
            BlocProvider(
              create: (context) => BookSearchCubit(
                isTafsir: isTafsir,
                allResources: setupBloc.state.allResources,
              ),
            ),
          ],
          child: BookSelectBottomSheet(isTafsir: isTafsir),
        );
      },
    );
  }
}

Widget getFeaturesMark(
  BuildContext context,
  String name, {
  bool asColumn = false,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final themeState = context.read<ThemeCubit>().state;
  final bg = isDark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black.withValues(alpha: 0.05);
  final fg = isDark ? Colors.grey.shade300 : Colors.grey.shade800;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.08),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.check_rounded, size: 13, color: themeState.primary),
        const Gap(4),
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ],
    ),
  );
}
