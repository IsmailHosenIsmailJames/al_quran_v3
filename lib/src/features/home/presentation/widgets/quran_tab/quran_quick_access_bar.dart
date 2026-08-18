import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quick_access_popup.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A sleek horizontal bar for user-customized Surah shortcuts.
class QuranQuickAccessBar extends StatelessWidget {
  const QuranQuickAccessBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
      builder: (context, quickAccessList) {
        if (quickAccessList.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FluentIcons.flash_24_regular,
                        size: 18,
                        color: themeState.primary,
                      ),
                      const Gap(6),
                      Text(
                        l10n.quickAccess,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => showQuickAccessPopup(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.edit_20_regular,
                            size: 15,
                            color: themeState.primary,
                          ),
                          const Gap(4),
                          Text(
                            l10n.edit,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: themeState.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(6),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: quickAccessList.length,
                separatorBuilder: (context, index) => const Gap(8),
                itemBuilder: (context, index) {
                  final model = quickAccessList[index];
                  final surahData = metaDataSurah[model.surahNumber.toString()];
                  final surahInfo = surahData != null
                      ? SurahInfoModel.fromMap(surahData)
                      : null;
                  final surahName = getSurahName(context, model.surahNumber);

                  final String? scrollTo =
                      ((model.scrollIndex != null) && (model.scrollIndex! > 1))
                          ? "${model.surahNumber}:${model.scrollIndex}"
                          : null;

                  final label = surahName +
                      (scrollTo != null
                          ? " • ${localizedNumber(context, model.scrollIndex)}"
                          : "");

                  return InkWell(
                    onTap: () {
                      final totalVerses = surahInfo?.versesCount ?? 7;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuranScriptView(
                            startKey: "${model.surahNumber}:1",
                            endKey: "${model.surahNumber}:$totalVerses",
                            toScrollKey: scrollTo,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : themeState.primaryShade100.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : themeState.primaryShade200,
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey.shade200
                              : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(10),
          ],
        );
      },
    );
  }
}
