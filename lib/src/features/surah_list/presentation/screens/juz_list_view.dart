import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/navigation_info_model.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/juz_info_model.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class JuzListView extends StatelessWidget {
  final List<JuzInfoModel> juzInfoList;

  const JuzListView({super.key, required this.juzInfoList});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final quranViewState = context.watch<QuranViewCubit>().state;
    final QuranScriptType quranScriptType = quranViewState.quranScriptType;
    final width = MediaQuery.of(context).size.width;
    final isTabletGrid = width >= 700;

    if (isTabletGrid) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).copyWith(bottom: 100),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 94,
          crossAxisSpacing: 12,
          mainAxisSpacing: 8,
        ),
        itemCount: juzInfoList.length,
        itemBuilder: (context, index) {
          return _buildJuzCard(
            context: context,
            index: index,
            l10n: l10n,
            themeState: themeState,
            isDark: isDark,
            quranViewState: quranViewState,
            quranScriptType: quranScriptType,
            margin: EdgeInsets.zero,
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: juzInfoList.length,
      itemBuilder: (context, index) {
        return _buildJuzCard(
          context: context,
          index: index,
          l10n: l10n,
          themeState: themeState,
          isDark: isDark,
          quranViewState: quranViewState,
          quranScriptType: quranScriptType,
        );
      },
    );
  }

  Widget _buildJuzCard({
    required BuildContext context,
    required int index,
    required AppLocalizations l10n,
    required ThemeState themeState,
    required bool isDark,
    required QuranViewState quranViewState,
    required QuranScriptType quranScriptType,
    EdgeInsetsGeometry? margin,
  }) {
    final current = juzInfoList[index];
    final String firstKey = current.firstVerseKey;

    final int surahNumber = firstKey.split(":").first.toInt();
    final int ayahNumber = firstKey.split(":").last.toInt();
    final surahName = getSurahName(context, surahNumber);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.035)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranScriptView(
                  startKey: juzInfoList[index].firstVerseKey,
                  endKey: juzInfoList[index].lastVerseKey,
                  currentIndex: index,
                  getNavigationInfo: (i) {
                    return NavigationInfoModel(
                      previousStartKey: i > 0
                          ? juzInfoList[i - 1].firstVerseKey
                          : null,
                      previousEndKey: i > 0
                          ? juzInfoList[i - 1].lastVerseKey
                          : null,
                      nextStartKey: i < juzInfoList.length - 1
                          ? juzInfoList[i + 1].firstVerseKey
                          : null,
                      nextEndKey: i < juzInfoList.length - 1
                          ? juzInfoList[i + 1].lastVerseKey
                          : null,
                    );
                  },
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                QuranIndexBadge(index: index + 1, size: 40),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${l10n.juz} ${localizedNumber(context, index + 1)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? Colors.white
                              : Colors.grey.shade900,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        "$surahName • ${l10n.ayah} ${localizedNumber(context, ayahNumber)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Flexible(
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: ScriptProcessor(
                      scriptInfo: ScriptInfo(
                        textStyle: const TextStyle(fontSize: 18),
                        surahNumber: surahNumber,
                        ayahNumber: ayahNumber,
                        quranScriptType: quranScriptType,
                        limitWord: 4,
                        skipWordTap: true,
                      ),
                      themeState: themeState,
                      tajweedColorEnable:
                          quranScriptType == QuranScriptType.uthmani
                              ? quranViewState.useTajweedOnUthmani
                              : quranViewState.useTajweedOnIndopak,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
