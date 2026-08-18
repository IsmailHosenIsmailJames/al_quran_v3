import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/surah_list_card.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SurahListView extends StatefulWidget {
  final List<SurahInfoModel> surahInfoList;

  const SurahListView({super.key, required this.surahInfoList});

  @override
  State<SurahListView> createState() => _SurahListViewState();
}

class _SurahListViewState extends State<SurahListView> {
  final TextEditingController searchController = TextEditingController();
  late final SurahSearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = getIt<SurahSearchCubit>();
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return BlocBuilder<SurahSearchCubit, SurahSearchState>(
      bloc: _searchCubit,
      builder: (context, state) {
        final filteredSurah = state.filteredSurahs;

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: filteredSurah.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : themeState.primaryShade100.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : themeState.primaryShade200.withValues(alpha: 0.6),
                    ),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      _searchCubit.onSearchChanged(
                        value,
                        languageCode:
                            context.read<LanguageCubit>().state.locale.languageCode,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: l10n.searchForASurah,
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                      prefixIcon: Icon(
                        FluentIcons.search_24_regular,
                        size: 20,
                        color: themeState.primary,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                FluentIcons.dismiss_circle_24_filled,
                                size: 18,
                              ),
                              onPressed: () {
                                searchController.clear();
                                _searchCubit.onSearchChanged(
                                  "",
                                  languageCode: context
                                      .read<LanguageCubit>()
                                      .state
                                      .locale
                                      .languageCode,
                                );
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              );
            }

            final surah = filteredSurah[index - 1];
            return SurahListCard(surah: surah);
          },
        );
      },
    );
  }
}
