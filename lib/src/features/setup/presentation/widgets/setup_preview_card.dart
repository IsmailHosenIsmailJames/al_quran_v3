import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/preview/script_selection_segment_button.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/book_search_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/book_select_bottom_sheet.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Compact bottom bar for mobile screens: Gives maximum space to the language list
class SetupBottomBar extends StatelessWidget {
  final VoidCallback onDownloadPressed;
  final VoidCallback onCustomizePressed;

  const SetupBottomBar({
    super.key,
    required this.onDownloadPressed,
    required this.onCustomizePressed,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final quranViewState = context.watch<QuranViewCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        final translationName = state.config.selectedTranslation?.name ?? "";
        final scriptTypeName =
            getLocalizedQuranScriptType(context, quranViewState.quranScriptType)
                .capitalize();

        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade200,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Summary & Customize Trigger
                InkWell(
                  onTap: onCustomizePressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(
                              alpha: isDark ? 0.2 : 0.1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            FluentIcons.book_letter_24_regular,
                            size: 16,
                            color: themeState.primary,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$scriptTypeName Script",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                              const Gap(1),
                              Text(
                                translationName.isNotEmpty
                                    ? translationName
                                    : "Default Translation",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(
                              alpha: isDark ? 0.15 : 0.1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.tune_rounded,
                                size: 14,
                                color: themeState.primary,
                              ),
                              const Gap(4),
                              Text(
                                appLocalizations.change,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(8),

                // Primary CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: onDownloadPressed,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: themeState.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      FluentIcons.arrow_download_24_filled,
                      size: 20,
                    ),
                    label: Text(
                      appLocalizations.saveAndDownload,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
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
}

/// Full setup preview & customization card (used inside bottom sheet or landscape panel)
class SetupPreviewCard extends StatelessWidget {
  final VoidCallback onDownloadPressed;
  final bool isSheet;

  const SetupPreviewCard({
    super.key,
    required this.onDownloadPressed,
    this.isSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1B1B1B) : Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(isSheet ? 24 : 0),
            ),
            border: isSheet
                ? Border(
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade200,
                      width: 1,
                    ),
                  )
                : null,
          ),
          padding: EdgeInsets.fromLTRB(16, isSheet ? 10 : 16, 16, 16),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSheet) ...[
                    // Drag handle pill
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.quranStyle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded),
                          tooltip: "Close",
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const Gap(10),
                  ],

                  // 1. Script Selection & Tajweed Toggle
                  getScriptSelectionSegmentedButtons(context),

                  const Gap(8),

                  // 2. Framed Bismillah Ayah Preview
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey.shade200,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: getAyahByAyahCard(
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
                  ),

                  const Gap(8),

                  // 3. Font Selection Row
                  const QuranFontSelectionWidget(
                    titleStyle: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Gap(8),

                  // 4. Translation Tile
                  _buildBookTile(
                    context,
                    icon: FluentIcons.book_letter_24_regular,
                    label: appLocalizations.translation,
                    title: state.config.selectedTranslation?.name ??
                        "Select Translation",
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    onTap: () =>
                        _showBookSelectBottomSheet(context, isTafsir: false),
                  ),

                  const Gap(6),

                  // 5. Tafsir Tile
                  _buildBookTile(
                    context,
                    icon: FluentIcons.reading_list_24_regular,
                    label: appLocalizations.tafsir,
                    title: state.config.selectedTafsir?.name ?? "Select Tafsir",
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    onTap: () =>
                        _showBookSelectBottomSheet(context, isTafsir: true),
                  ),

                  const Gap(14),

                  // 6. Save & Download CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (isSheet) {
                          Navigator.pop(context);
                        }
                        onDownloadPressed();
                      },
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
                        size: 20,
                      ),
                      label: Text(
                        appLocalizations.saveAndDownload,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String title,
    required Color themePrimary,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: themePrimary.withValues(alpha: isDark ? 0.16 : 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: themePrimary),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const Gap(1),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: themePrimary.withValues(alpha: isDark ? 0.14 : 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_vert_rounded,
                    size: 15,
                    color: themePrimary,
                  ),
                  const Gap(4),
                  Text(
                    l10n.change,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: themePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

/// Open the setup preview/customization modal sheet
void showSetupCustomizationSheet(
  BuildContext context, {
  required VoidCallback onDownloadPressed,
}) {
  final setupBloc = context.read<SetupBloc>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    scrollControlDisabledMaxHeightRatio: 0.88,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (sheetContext) {
      return BlocProvider.value(
        value: setupBloc,
        child: SetupPreviewCard(
          isSheet: true,
          onDownloadPressed: onDownloadPressed,
        ),
      );
    },
  );
}

Widget getFeaturesMark(
  BuildContext context,
  String name, {
  bool asColumn = false,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final themeState = context.read<ThemeCubit>().state;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: themeState.primary.withValues(alpha: isDark ? 0.14 : 0.08),
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: themeState.primary.withValues(alpha: isDark ? 0.25 : 0.16),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.check_rounded, size: 11, color: themeState.primary),
        const Gap(3),
        Text(
          name,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade300 : themeState.primary,
          ),
        ),
      ],
    ),
  );
}
