import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/quran_resources/tafsir_resources_view.dart";
import "package:al_quran_v3/src/screen/quran_resources/translation_resources_view.dart";
import "package:al_quran_v3/src/screen/quran_resources/word_by_word_resources_view.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranResourcesView extends StatefulWidget {
  final int initTab;
  const QuranResourcesView({super.key, this.initTab = 0});

  @override
  State<QuranResourcesView> createState() => _QuranResourcesViewState();
}

class _QuranResourcesViewState extends State<QuranResourcesView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  List<String> pagesName = ["Translation", "Tafsir", "Word By Word"];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: widget.initTab,
      length: pagesName.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    pagesName = [
      appLocalizations.translation,
      appLocalizations.tafsir,
      appLocalizations.wordByWord,
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: themeState.primaryShade100),
          ),
        ),
        title: Text(appLocalizations.quranResources),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            physics: const ClampingScrollPhysics(),
            children: const [
              TranslationResourcesView(),
              TafsirResourcesView(),
              WordByWordResourcesView(),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: TabBar(
                      splashBorderRadius: BorderRadius.circular(100),
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: themeState.primaryShade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,

                      labelColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onSurfaceVariant,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: pagesName.map((name) => Tab(text: name)).toList(),
                      dividerColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
