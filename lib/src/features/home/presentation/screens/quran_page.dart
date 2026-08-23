import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_juz.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_page_shimmer.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/continue_reading_hero_card.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/hadith_companion_card.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_history_carousel.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_quick_access_bar.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_quick_actions_bar.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_tab_bar_header.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/juz_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/screens/hizb_list_view.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/screens/juz_list_view.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/screens/page_list_view.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/screens/ruku_list_view.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/screens/surah_list_view.dart";
import "package:flutter/material.dart";

/// The modernized Home Page Quran Tab.
class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  late final List<SurahInfoModel> _surahInfoList;
  late final List<JuzInfoModel> _juzInfoModelList;
  late final List<PageInfoModel> _pageInfoList;
  late final TabController _tabController;

  bool _isLoaded = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _surahInfoList = metaDataSurah.values
        .map((value) => SurahInfoModel.fromMap(value))
        .toList();
    _juzInfoModelList = metaDataJuz.values
        .map((e) => JuzInfoModel.fromMap(e))
        .toList();
    _pageInfoList = quranPagesInfo
        .map((e) => PageInfoModel.fromMap(e))
        .toList();

    loadMetaSurah().then((_) {
      if (mounted) {
        setState(() {
          _isLoaded = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded) {
      return const QuranPageShimmer();
    }

    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isWideHeader = (width > height && width >= 650) || width >= 850;

    final List<String> tabNames = [
      l10n.surah,
      l10n.juz,
      l10n.pages,
      l10n.hizb,
      l10n.ruku,
    ];

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWideHeader ? 1100 : 800),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // Top Sections: Continue Reading, Quick Actions, History, Shortcuts
                SliverToBoxAdapter(
                  child: isWideHeader
                      ? const Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ContinueReadingHeroCard(),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: QuranQuickActionsBar(),
                                ),
                              ],
                            ),
                            QuranHistoryCarousel(),
                            QuranQuickAccessBar(),
                            HadithCompanionCard(),
                          ],
                        )
                      : const Column(
                          children: [
                            ContinueReadingHeroCard(),
                            QuranQuickActionsBar(),
                            QuranHistoryCarousel(),
                            QuranQuickAccessBar(),
                            HadithCompanionCard(),
                          ],
                        ),
                ),

                // Sticky glassmorphic tab bar header
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: QuranTabBarHeaderDelegate(
                    tabController: _tabController,
                    tabNames: tabNames,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                SurahListView(surahInfoList: _surahInfoList),
                JuzListView(juzInfoList: _juzInfoModelList),
                PageListView(pageInfoList: _pageInfoList),
                const HizbListView(),
                const RukuListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
