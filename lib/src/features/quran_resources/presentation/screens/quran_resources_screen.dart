import "dart:ui";

import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_search_bar.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_tab_bar.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/tafsir_resources_tab.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/translation_resources_tab.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/word_by_word_resources_tab.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final cubit = context.read<QuranResourcesCubit>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: themeState.mutedGray.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900.withValues(alpha: 0.6)
            : Colors.grey.shade100.withValues(alpha: 0.6),
        title: ResourceSearchBar(searchController: _searchController),
        actions: [
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
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            physics: const ClampingScrollPhysics(),
            children: const [
              TranslationResourcesTab(),
              TafsirResourcesTab(),
              WordByWordResourcesTab(),
            ],
          ),
          ResourceTabBar(tabController: _tabController),
        ],
      ),
    );
  }
}
