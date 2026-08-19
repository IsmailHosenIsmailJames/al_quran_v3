import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/search/data/datasources/quran_search_datasource.dart";
import "package:al_quran_v3/src/features/search/domain/usecases/search_quran_usecase.dart";
import "package:al_quran_v3/src/features/search/presentation/cubit/quran_search_cubit.dart";
import "package:al_quran_v3/src/features/search/presentation/cubit/quran_search_state.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/direct_jump_card.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_filter_sheet.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_history_view.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_result_card.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_scope_tabs.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// The state-of-the-art Universal Quran Search Screen.
class QuranSearchScreen extends StatelessWidget {
  final String? initialQuery;

  const QuranSearchScreen({super.key, this.initialQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        QuranSearchCubit cubit;
        try {
          cubit = getIt<QuranSearchCubit>();
        } catch (_) {
          final ds = QuranSearchDataSource();
          cubit = QuranSearchCubit(ds, SearchQuranUseCase(ds));
        }
        if (initialQuery != null && initialQuery!.isNotEmpty) {
          cubit.searchImmediate(initialQuery!);
        }
        return cubit;
      },
      child: const _QuranSearchScreenBody(),
    );
  }
}

class _QuranSearchScreenBody extends StatefulWidget {
  const _QuranSearchScreenBody();

  @override
  State<_QuranSearchScreenBody> createState() => _QuranSearchScreenBodyState();
}

class _QuranSearchScreenBodyState extends State<_QuranSearchScreenBody> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<QuranSearchCubit>();
    if (cubit.state.query.isNotEmpty) {
      _searchController.text = cubit.state.query;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    final cubit = context.read<QuranSearchCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SearchFilterSheet(
        initialFilter: cubit.state.filter,
        availableTranslations: cubit.state.availableTranslations,
        availableTafsirs: cubit.state.availableTafsirs,
        onApply: (newFilter) {
          cubit.updateFilter(newFilter);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: _buildSearchTextField(themeState, isDark, l10n),
        actions: [
          _buildFilterIconButton(context, themeState, isDark, l10n),
          const Gap(8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(6),
            // Scope Tabs (All, Translations, Arabic, Tafsir, Surahs)
            BlocBuilder<QuranSearchCubit, QuranSearchState>(
              buildWhen: (p, c) => p.filter.scope != c.filter.scope,
              builder: (context, state) {
                return SearchScopeTabs(
                  activeScope: state.filter.scope,
                  onScopeSelected: (scope) {
                    context.read<QuranSearchCubit>().onScopeChanged(scope);
                  },
                );
              },
            ),

            // Active Filters Bar
            BlocBuilder<QuranSearchCubit, QuranSearchState>(
              buildWhen: (p, c) => p.filter != c.filter,
              builder: (context, state) {
                if (!state.filter.hasCustomFilters) {
                  return const SizedBox.shrink();
                }
                return _buildActiveFilterChips(context, state, themeState, isDark, l10n);
              },
            ),

            Divider(
              height: 14,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.grey.shade200,
            ),

            // Results Body
            Expanded(
              child: BlocConsumer<QuranSearchCubit, QuranSearchState>(
                listener: (context, state) {
                  if (state.query != _searchController.text &&
                      state.status != SearchStatus.loading) {
                    _searchController.text = state.query;
                    _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: state.query.length),
                    );
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case SearchStatus.initial:
                      return SearchHistoryView(
                        history: state.searchHistory,
                        onQuerySelected: (q) {
                          _searchController.text = q;
                          context.read<QuranSearchCubit>().searchImmediate(q);
                        },
                        onDeleteHistoryItem: (q) {
                          context.read<QuranSearchCubit>().deleteHistoryItem(q);
                        },
                        onClearAllHistory: () {
                          context.read<QuranSearchCubit>().clearAllHistory();
                        },
                      );
                    case SearchStatus.loading:
                      return Center(
                        child: CircularProgressIndicator(color: themeState.primary),
                      );
                    case SearchStatus.empty:
                      return _buildEmptyState(state, themeState, isDark, l10n);
                    case SearchStatus.error:
                      return _buildErrorState(state, themeState, isDark);
                    case SearchStatus.success:
                      return _buildResultsList(state, themeState, isDark, l10n);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField(
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade300,
        ),
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        autofocus: true,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          context.read<QuranSearchCubit>().onQueryChanged(value);
        },
        onSubmitted: (value) {
          context.read<QuranSearchCubit>().searchImmediate(value);
        },
        style: TextStyle(
          fontSize: 14.5,
          color: isDark ? Colors.white : Colors.grey.shade900,
        ),
        decoration: InputDecoration(
          hintText: l10n.searchQuranHint,
          hintStyle: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
          ),
          prefixIcon: Icon(
            FluentIcons.search_20_regular,
            size: 18,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(FluentIcons.dismiss_16_filled, size: 16),
                  onPressed: () {
                    _searchController.clear();
                    context.read<QuranSearchCubit>().onQueryChanged("");
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildFilterIconButton(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        final hasFilters = state.filter.hasCustomFilters;

        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              tooltip: l10n.searchFiltersAndOptions,
              style: IconButton.styleFrom(
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              onPressed: () => _showFilterBottomSheet(context),
              icon: Icon(
                FluentIcons.options_20_regular,
                size: 18,
                color: hasFilters
                    ? themeState.primary
                    : (isDark ? Colors.white : Colors.grey.shade800),
              ),
            ),
            if (hasFilters)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: themeState.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildActiveFilterChips(
    BuildContext context,
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final filter = state.filter;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (filter.surahNumber != null) ...[
              _buildFilterChip(
                label: "${l10n.surah}: ${getSurahName(context, filter.surahNumber!)}",
                onDeleted: () {
                  context.read<QuranSearchCubit>().updateFilter(
                    filter.copyWith(clearSurahNumber: true),
                  );
                },
                themeState: themeState,
                isDark: isDark,
              ),
              const Gap(6),
            ],
            if (filter.revelationType != "all") ...[
              _buildFilterChip(
                label: filter.revelationType == "meccan" ? l10n.makki : l10n.madani,
                onDeleted: () {
                  context.read<QuranSearchCubit>().updateFilter(
                    filter.copyWith(revelationType: "all"),
                  );
                },
                themeState: themeState,
                isDark: isDark,
              ),
              const Gap(6),
            ],
            if (filter.matchExactPhrase) ...[
              _buildFilterChip(
                label: l10n.exactPhrase,
                onDeleted: () {
                  context.read<QuranSearchCubit>().updateFilter(
                    filter.copyWith(matchExactPhrase: false),
                  );
                },
                themeState: themeState,
                isDark: isDark,
              ),
              const Gap(6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
    required ThemeState themeState,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 4, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: themeState.primary.withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: themeState.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: themeState.primary,
            ),
          ),
          const Gap(2),
          InkWell(
            onTap: onDeleted,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                FluentIcons.dismiss_12_regular,
                size: 13,
                color: themeState.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final results = state.results!;
    final directJump = results.directJump;
    final surahs = results.surahMatches;
    final ayahs = results.ayahResults;

    return ListView.builder(
      itemCount: 1 + // Header stats banner
          (directJump != null ? 1 : 0) +
          (surahs.isNotEmpty ? 1 : 0) +
          ayahs.length,
      itemBuilder: (context, index) {
        // 1. Result Statistics Banner
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.ayahsFound(results.totalCount),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
                Text(
                  "${results.executionTime.inMilliseconds} ms",
                  style: TextStyle(
                    fontSize: 11.5,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }

        int currentIndex = 1;

        // 2. Direct Ayah Jump Card
        if (directJump != null) {
          if (index == currentIndex) {
            return DirectAyahJumpCard(directJump: directJump);
          }
          currentIndex++;
        }

        // 3. Matching Surahs Carousel / Row
        if (surahs.isNotEmpty) {
          if (index == currentIndex) {
            return _buildSurahsSection(surahs, themeState, isDark, l10n);
          }
          currentIndex++;
        }

        // 4. Ayah Result Cards
        final ayahIndex = index - currentIndex;
        if (ayahIndex >= 0 && ayahIndex < ayahs.length) {
          return SearchResultCard(
            ayahResult: ayahs[ayahIndex],
            query: state.query,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSurahsSection(
    List<SurahInfoModel> surahs,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            l10n.surahsFound(surahs.length),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
            ),
          ),
        ),
        SizedBox(
          height: 76,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: surahs.length,
            separatorBuilder: (context, index) => const Gap(10),
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuranScriptView(
                        startKey: "${surah.id}:1",
                        endKey: "${surah.id}:${surah.versesCount}",
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 175,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade200,
                    ),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Row(
                    children: [
                      QuranIndexBadge(
                        index: surah.id,
                        size: 34,
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getSurahName(context, surah.id),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.grey.shade900,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              "${localizedNumber(context, surah.versesCount)} ${l10n.verses}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Gap(8),
      ],
    );
  }

  Widget _buildEmptyState(
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.search_info_24_regular,
              size: 54,
              color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
            const Gap(14),
            Text(
              l10n.noMatchingSurahs(state.query),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
            ),
            const Gap(8),
            Text(
              l10n.trySearchingFor,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.error_circle_24_regular,
              size: 48,
              color: Colors.red.shade400,
            ),
            const Gap(12),
            Text(
              "Search Error",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
            const Gap(6),
            Text(
              state.errorMessage ?? "An unexpected error occurred while searching.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
