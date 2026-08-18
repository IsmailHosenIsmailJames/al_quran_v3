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
import "package:gap/gap.dart";

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
    final langCode = context.watch<LanguageCubit>().state.locale.languageCode;

    return BlocBuilder<SurahSearchCubit, SurahSearchState>(
      bloc: _searchCubit,
      builder: (context, state) {
        final filteredSurah = state.filteredSurahs;
        final hasQuery = state.query.isNotEmpty;

        if (hasQuery && filteredSurah.isEmpty) {
          return ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            children: [
              _buildSearchBar(l10n, isDark, langCode),
              const Gap(48),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.grey.shade100,
                        ),
                        child: Icon(
                          FluentIcons.search_info_24_regular,
                          size: 38,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        l10n.noMatchingSurahs(state.query),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        l10n.trySearchingFor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                      const Gap(16),
                      TextButton.icon(
                        onPressed: () {
                          searchController.clear();
                          _searchCubit.onSearchChanged("", languageCode: langCode);
                        },
                        icon: const Icon(Icons.clear_rounded, size: 16),
                        label: Text(
                          l10n.noResultsFound,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: themeState.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 100),
          itemCount: filteredSurah.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildSearchBar(l10n, isDark, langCode);
            }

            final surah = filteredSurah[index - 1];
            return SurahListCard(surah: surah);
          },
        );
      },
    );
  }

  Widget _buildSearchBar(AppLocalizations l10n, bool isDark, String langCode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade300,
          ),
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            _searchCubit.onSearchChanged(
              value,
              languageCode: langCode,
            );
          },
          decoration: InputDecoration(
            hintText: l10n.searchForASurah,
            hintStyle: TextStyle(
              fontSize: 13.5,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
            ),
            prefixIcon: Icon(
              FluentIcons.search_24_regular,
              size: 20,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
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
                        languageCode: langCode,
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
}

