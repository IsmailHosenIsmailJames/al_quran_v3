import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_search_bar.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_tab_bar.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/tafsir_resources_tab.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/translation_resources_tab.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/word_by_word_resources_tab.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranResourcesScreen extends StatelessWidget {
  final int initTab;
  const QuranResourcesScreen({super.key, this.initTab = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuranResourcesCubit>(
      create: (context) => getIt<QuranResourcesCubit>(),
      child: _QuranResourcesView(initTab: initTab),
    );
  }
}

class _QuranResourcesView extends StatefulWidget {
  final int initTab;
  const _QuranResourcesView({this.initTab = 0});

  @override
  State<_QuranResourcesView> createState() => _QuranResourcesViewState();
}

class _QuranResourcesViewState extends State<_QuranResourcesView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.initTab,
      length: 3,
      vsync: this,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<QuranResourcesCubit>().changeTab(_tabController.index);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<QuranResourcesCubit>()
          .loadResources(initTab: widget.initTab);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuranResourcesCubit>();
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final isWide = MediaQuery.sizeOf(context).width >= 768;
    final appLocalizations = AppLocalizations.of(context);

    final shortcuts = <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
        _searchFocusNode.requestFocus();
        if (!isWide && !cubit.state.isSearching) {
          cubit.toggleSearching();
        }
      },
      const SingleActivator(LogicalKeyboardKey.keyF, meta: true): () {
        _searchFocusNode.requestFocus();
        if (!isWide && !cubit.state.isSearching) {
          cubit.toggleSearching();
        }
      },
      const SingleActivator(LogicalKeyboardKey.escape): () {
        _searchController.clear();
        _searchFocusNode.unfocus();
        cubit.setSearchQuery('');
        if (!isWide && cubit.state.isSearching) {
          cubit.toggleSearching();
        }
      },
      const SingleActivator(LogicalKeyboardKey.digit1, control: true): () =>
          _tabController.animateTo(0),
      const SingleActivator(LogicalKeyboardKey.digit1, meta: true): () =>
          _tabController.animateTo(0),
      const SingleActivator(LogicalKeyboardKey.digit2, control: true): () =>
          _tabController.animateTo(1),
      const SingleActivator(LogicalKeyboardKey.digit2, meta: true): () =>
          _tabController.animateTo(1),
      const SingleActivator(LogicalKeyboardKey.digit3, control: true): () =>
          _tabController.animateTo(2),
      const SingleActivator(LogicalKeyboardKey.digit3, meta: true): () =>
          _tabController.animateTo(2),
    };

    return CallbackShortcuts(
      bindings: shortcuts,
      child: Scaffold(
        appBar: AppBar(
          title: isWide
              ? Text(
                  appLocalizations.quranResources,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                )
              : ResourceSearchBar(
                  searchController: _searchController,
                  focusNode: _searchFocusNode,
                ),
          actions: [
            if (isWide)
              Center(
                child: Container(
                  width: 340,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color:
                        isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: (val) => cubit.setSearchQuery(val),
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "${appLocalizations.search}...",
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade500,
                      ),
                      prefixIcon: const Icon(Icons.search_rounded, size: 18),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, value, _) {
                          if (value.text.isEmpty) return const SizedBox.shrink();
                          return IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              cubit.setSearchQuery('');
                            },
                          );
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              )
            else
              BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
                buildWhen: (p, c) => p.isSearching != c.isSearching,
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(state.isSearching ? Icons.close : Icons.search),
                    onPressed: () {
                      if (state.isSearching) {
                        _searchController.clear();
                      }
                      cubit.toggleSearching();
                    },
                  );
                },
              ),
          ],
        ),
        body: Column(
          children: [
            ResourceTabBar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const ClampingScrollPhysics(),
                children: const [
                  TranslationResourcesTab(),
                  TafsirResourcesTab(),
                  WordByWordResourcesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
