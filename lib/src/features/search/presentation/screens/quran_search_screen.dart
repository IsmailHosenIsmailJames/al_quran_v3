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
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// The state-of-the-art Universal Quran Search Screen with adaptive responsiveness
/// for Mobile, Tablet, and Desktop screens.
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
  bool? _isSidebarOpen;

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

  void _handleFilterAction({
    required BuildContext context,
    required bool isDesktop,
    required bool isTablet,
    required bool currentSidebarOpen,
  }) {
    if (isDesktop) {
      setState(() {
        _isSidebarOpen = !currentSidebarOpen;
      });
      return;
    }

    final cubit = context.read<QuranSearchCubit>();

    if (isTablet) {
      SearchFilterSheet.showAsDialog(
        context: context,
        initialFilter: cubit.state.filter,
        availableTranslations: cubit.state.availableTranslations,
        availableTafsirs: cubit.state.availableTafsirs,
        onApply: (newFilter) {
          cubit.updateFilter(newFilter);
        },
      );
      return;
    }

    // Mobile Bottom Sheet
    SearchFilterSheet.showAsBottomSheet(
      context: context,
      initialFilter: cubit.state.filter,
      availableTranslations: cubit.state.availableTranslations,
      availableTafsirs: cubit.state.availableTafsirs,
      onApply: (newFilter) {
        cubit.updateFilter(newFilter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 700 && screenWidth < 980;
    final isDesktop = screenWidth >= 980;
    final showSidebar = isDesktop && (_isSidebarOpen ?? (screenWidth >= 1100));

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (_searchController.text.isNotEmpty) {
            _searchController.clear();
            context.read<QuranSearchCubit>().onQueryChanged("");
          } else {
            Navigator.maybePop(context);
          }
        },
      },
      child: Focus(
        autofocus: false,
        child: Scaffold(
          backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
          appBar: AppBar(
            leading: const BackButton(),
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: isTablet || isDesktop
                ? Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: _buildSearchTextField(themeState, isDark, l10n, isDesktop),
                    ),
                  )
                : _buildSearchTextField(themeState, isDark, l10n, false),
            actions: [
              _buildFilterIconButton(
                context: context,
                themeState: themeState,
                isDark: isDark,
                l10n: l10n,
                isDesktop: isDesktop,
                isTablet: isTablet,
                isSidebarOpen: showSidebar,
              ),
              const Gap(8),
            ],
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Primary Search View (Scopes, Active Filters, Results / History)
                Expanded(
                  child: _buildMainSearchContent(
                    context: context,
                    themeState: themeState,
                    isDark: isDark,
                    l10n: l10n,
                    isTablet: isTablet,
                    isDesktop: isDesktop,
                  ),
                ),

                // Desktop Collapsible Filter Sidebar
                if (showSidebar) ...[
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                  ),
                  SizedBox(
                    width: 330,
                    child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
                      builder: (context, state) {
                        return SearchFilterSheet(
                          mode: SearchFilterLayoutMode.sidebar,
                          initialFilter: state.filter,
                          availableTranslations: state.availableTranslations,
                          availableTafsirs: state.availableTafsirs,
                          onApply: (newFilter) {
                            context.read<QuranSearchCubit>().updateFilter(newFilter);
                          },
                          onClose: () {
                            setState(() => _isSidebarOpen = false);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainSearchContent({
    required BuildContext context,
    required ThemeState themeState,
    required bool isDark,
    required AppLocalizations l10n,
    required bool isTablet,
    required bool isDesktop,
  }) {
    return Column(
      children: [
        const Gap(6),
        // Scope Tabs (All, Translations, Arabic, Tafsir, Surahs)
        Align(
          alignment: isTablet || isDesktop ? Alignment.center : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
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
          ),
        ),

        // Active Filters Bar
        Align(
          alignment: isTablet || isDesktop ? Alignment.center : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: BlocBuilder<QuranSearchCubit, QuranSearchState>(
              buildWhen: (p, c) => p.filter != c.filter,
              builder: (context, state) {
                if (!state.filter.hasCustomFilters) {
                  return const SizedBox.shrink();
                }
                return _buildActiveFilterChips(context, state, themeState, isDark, l10n);
              },
            ),
          ),
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
                  if (state.results != null &&
                      (state.results!.ayahResults.isNotEmpty ||
                          state.results!.surahMatches.isNotEmpty ||
                          state.results!.directJump != null)) {
                    return Stack(
                      children: [
                        _buildResultsList(state, themeState, isDark, l10n, isTablet, isDesktop),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            color: themeState.primary,
                            backgroundColor: Colors.transparent,
                            minHeight: 2.5,
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: themeState.primary),
                  );
                case SearchStatus.empty:
                  return _buildEmptyState(state, themeState, isDark, l10n);
                case SearchStatus.error:
                  return _buildErrorState(state, themeState, isDark);
                case SearchStatus.success:
                  return _buildResultsList(state, themeState, isDark, l10n, isTablet, isDesktop);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchTextField(
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
    bool isDesktop,
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
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  if (value.text.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    tooltip: "Clear",
                    icon: const Icon(FluentIcons.dismiss_16_filled, size: 16),
                    onPressed: () {
                      _searchController.clear();
                      context.read<QuranSearchCubit>().onQueryChanged("");
                    },
                  );
                },
              ),
              if (isDesktop) ...[
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    "Esc",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildFilterIconButton({
    required BuildContext context,
    required ThemeState themeState,
    required bool isDark,
    required AppLocalizations l10n,
    required bool isDesktop,
    required bool isTablet,
    required bool isSidebarOpen,
  }) {
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        final hasFilters = state.filter.hasCustomFilters;

        String tooltip = l10n.searchFiltersAndOptions;
        if (isDesktop) {
          tooltip = isSidebarOpen ? "Hide Filters Panel" : "Show Filters Panel";
        }

        return Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              tooltip: tooltip,
              style: IconButton.styleFrom(
                backgroundColor: (isDesktop && isSidebarOpen)
                    ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.12)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.shade100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: (isDesktop && isSidebarOpen)
                        ? themeState.primary.withValues(alpha: 0.5)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade300),
                  ),
                ),
              ),
              onPressed: () => _handleFilterAction(
                context: context,
                isDesktop: isDesktop,
                isTablet: isTablet,
                currentSidebarOpen: isSidebarOpen,
              ),
              icon: Icon(
                isDesktop
                    ? (isSidebarOpen
                        ? FluentIcons.panel_right_contract_20_filled
                        : FluentIcons.panel_right_expand_20_regular)
                    : FluentIcons.options_20_regular,
                size: 18,
                color: (hasFilters || (isDesktop && isSidebarOpen))
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
    bool isTablet,
    bool isDesktop,
  ) {
    final results = state.results!;
    final directJump = results.directJump;
    final surahs = results.surahMatches;
    final ayahs = results.ayahResults;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: ListView.builder(
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
                return DirectAyahJumpCard(
                  directJump: directJump,
                  onResultSelected: () {
                    context.read<QuranSearchCubit>().saveQueryToHistory(state.query);
                  },
                );
              }
              currentIndex++;
            }

            // 3. Matching Surahs Carousel / Grid
            if (surahs.isNotEmpty) {
              if (index == currentIndex) {
                return _buildSurahsSection(
                  surahs: surahs,
                  themeState: themeState,
                  isDark: isDark,
                  l10n: l10n,
                  activeQuery: state.query,
                  isTablet: isTablet,
                  isDesktop: isDesktop,
                );
              }
              currentIndex++;
            }

            // 4. Ayah Result Cards
            final ayahIndex = index - currentIndex;
            if (ayahIndex >= 0 && ayahIndex < ayahs.length) {
              return SearchResultCard(
                ayahResult: ayahs[ayahIndex],
                query: state.query,
                onResultSelected: () {
                  context.read<QuranSearchCubit>().saveQueryToHistory(state.query);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSurahsSection({
    required List<SurahInfoModel> surahs,
    required ThemeState themeState,
    required bool isDark,
    required AppLocalizations l10n,
    required String activeQuery,
    required bool isTablet,
    required bool isDesktop,
  }) {
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
        if (isTablet || isDesktop) ...[
          // Responsive Multi-column Grid on Tablet & Desktop
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 2,
                mainAxisExtent: 72,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surah = surahs[index];
                return _buildSurahCard(
                  surah: surah,
                  themeState: themeState,
                  isDark: isDark,
                  l10n: l10n,
                  activeQuery: activeQuery,
                );
              },
            ),
          ),
        ] else ...[
          // Horizontal ListView on Mobile
          SizedBox(
            height: 76,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: surahs.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                final surah = surahs[index];
                return SizedBox(
                  width: 175,
                  child: _buildSurahCard(
                    surah: surah,
                    themeState: themeState,
                    isDark: isDark,
                    l10n: l10n,
                    activeQuery: activeQuery,
                  ),
                );
              },
            ),
          ),
        ],
        const Gap(8),
      ],
    );
  }

  Widget _buildSurahCard({
    required SurahInfoModel surah,
    required ThemeState themeState,
    required bool isDark,
    required AppLocalizations l10n,
    required String activeQuery,
  }) {
    return InkWell(
      onTap: () {
        context.read<QuranSearchCubit>().saveQueryToHistory(activeQuery);
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
      mouseCursor: SystemMouseCursors.click,
      hoverColor: themeState.primary.withValues(alpha: isDark ? 0.08 : 0.04),
      child: Container(
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
  }

  Widget _buildEmptyState(
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
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
      ),
    );
  }

  Widget _buildErrorState(
    QuranSearchState state,
    ThemeState themeState,
    bool isDark,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
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
      ),
    );
  }
}
