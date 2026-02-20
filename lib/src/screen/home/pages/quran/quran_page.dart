import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_juz.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/widget/quran_page_shimmer.dart";
import "package:al_quran_v3/src/screen/surah_list_view/hizb_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/juz_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/juz_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/page_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/ruku_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/surah_list_view.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/widget/history/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/widget/history/cubit/quran_history_state.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/cubit/quick_access_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:gap/gap.dart";
import "package:al_quran_v3/src/widget/quick_access/quick_access_popup.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../theme/controller/theme_cubit.dart";

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  List<SurahInfoModel> surahInfoList = metaDataSurah.values
      .map((value) => SurahInfoModel.fromMap(value))
      .toList();
  List<JuzInfoModel> juzInfoModelList = metaDataJuz.values
      .map((e) => JuzInfoModel.fromMap(e))
      .toList();
  List<PageInfoModel> pageInfoList = quranPagesInfo
      .map((e) => PageInfoModel.fromMap(e))
      .toList();

  late final TabController _tabController;

  bool isLoaded = true;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    loadMetaSurah().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoaded = false;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    List<String> pagesName = [
      l10n.surah,
      l10n.juz,
      l10n.pages,
      l10n.hizb,
      l10n.ruku,
    ];

    final themeState = context.watch<ThemeCubit>().state;

    return isLoaded
        ? const QuranPageShimmer()
        : NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: GridView(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.9,
                              ),
                          children: [
                            QuickOption(
                              themeState: themeState,
                              label: "Settings",
                              onClick: () {},
                              child: const Icon(
                                FluentIcons.settings_24_regular,
                                size: 30,
                              ),
                            ),
                            QuickOption(
                              themeState: themeState,
                              label: "Library",
                              onClick: () {},
                              child: const Icon(
                                FluentIcons.library_24_regular,
                                size: 30,
                              ),
                            ),
                            QuickOption(
                              themeState: themeState,
                              label: "Settings",
                              onClick: () {},
                              child: const Icon(
                                FluentIcons.settings_24_regular,
                                size: 30,
                              ),
                            ),
                            QuickOption(
                              themeState: themeState,
                              label: "Settings",
                              onClick: () {},
                              child: const Icon(
                                FluentIcons.settings_24_regular,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      BlocBuilder<QuranHistoryCubit, QuranHistoryState>(
                        builder: (context, history) {
                          return history.history.isEmpty
                              ? Container()
                              : Column(
                                  children: [
                                    const Gap(10),
                                    Row(
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          FluentIcons.history_24_regular,
                                        ),
                                        const Gap(5),
                                        Text(
                                          l10n.history,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),

                                    const Gap(5),

                                    SizedBox(
                                      height: 40,
                                      child: getHistoryWidget(history, l10n),
                                    ),
                                    const Gap(10),
                                  ],
                                );
                        },
                      ),

                      Row(
                        children: [
                          const Gap(10),
                          const Icon(FluentIcons.flash_24_regular),
                          const Gap(5),
                          Text(
                            l10n.quickAccess,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Gap(10),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: themeState.primaryShade100,
                              foregroundColor: themeState.primary,
                            ),
                            onPressed: () {
                              showQuickAccessPopup(context);
                            },
                            icon: const Icon(FluentIcons.edit_24_regular),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
                          builder: (context, quickAccessList) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: quickAccessList.length,
                              itemBuilder: (context, index) {
                                QuickAccessModel quickAccessModel =
                                    quickAccessList[index];

                                SurahInfoModel surahInfo =
                                    SurahInfoModel.fromMap(
                                      metaDataSurah[quickAccessModel.surahNumber
                                          .toString()]!,
                                    );
                                String? scrollTo =
                                    ((quickAccessModel.scrollIndex != null) &&
                                        (quickAccessModel.scrollIndex! > 1))
                                    ? "${surahInfo.id}:${quickAccessModel.scrollIndex}"
                                    : null;

                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: context
                                          .read<ThemeCubit>()
                                          .state
                                          .primaryShade100,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuranScriptView(
                                            startKey: "${surahInfo.id}:1",
                                            endKey:
                                                "${surahInfo.id}:${surahInfo.versesCount}",
                                            toScrollKey: scrollTo,
                                          ),
                                        ),
                                      );
                                    },
                                    label: Text(
                                      getSurahName(context, surahInfo.id) +
                                          (scrollTo != null
                                              ? " - ${localizedNumber(context, quickAccessModel.scrollIndex)}"
                                              : ""),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: _QuranHeaderDelegate(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            height: 46,
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
                              labelPadding: EdgeInsets.zero,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              unselectedLabelColor: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              tabs: pagesName
                                  .map((name) => Tab(text: name))
                                  .toList(),
                              dividerColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              // physics: const ClampingScrollPhysics(), // NestedScrollView handles physics usually
              children: [
                SurahListView(surahInfoList: surahInfoList),
                JuzListView(juzInfoList: juzInfoModelList),
                PageListView(pageInfoList: pageInfoList),
                const HizbListView(),
                const RukuListView(),
              ],
            ),
          );
  }

  Widget getHistoryWidget(QuranHistoryState history, AppLocalizations l10n) {
    return ListView.builder(
      itemCount: history.history.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        HistoryElement historyModel = history.history.reversed.toList()[index];
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: context.read<ThemeCubit>().state.primaryShade100,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuranScriptView(
                    startKey: "${historyModel.surahNumber}:1",
                    endKey: getEndAyahKeyFromSurahNumber(
                      historyModel.surahNumber,
                    ),
                    toScrollKey:
                        "${historyModel.surahNumber}:${historyModel.ayahNumber}",
                  ),
                ),
              );
            },
            label: Text(
              "${getSurahName(context, historyModel.surahNumber)} - ${historyModel.pageNumber != null ? "${l10n.page} ${localizedNumber(context, historyModel.pageNumber)}" : localizedNumber(context, historyModel.ayahNumber ?? historyModel.pageNumber ?? 0)} ",
            ),
          ),
        );
      },
    );
  }
}

class QuickOption extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback onClick;
  const QuickOption({
    super.key,
    required this.themeState,
    required this.child,
    required this.label,
    required this.onClick,
  });

  final ThemeState themeState;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(2.0).copyWith(top: 8),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: child,
            ),
            const Gap(4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuranHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _QuranHeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
