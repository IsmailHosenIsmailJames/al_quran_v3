import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/hizb_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/juz_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/hizb_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/juz_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/ruku_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/page_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/ruku_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/surah_list_view.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../../../theme/controller/theme_cubit.dart";
import "../../../../theme/controller/theme_state.dart";

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  List<SurahInfoModel> surahInfoList =
      metaDataSurah.values
          .map((value) => SurahInfoModel.fromMap(value))
          .toList();
  List<JuzInfoModel> juzInfoModelList =
      metaDataJuz.values.map((e) => JuzInfoModel.fromMap(e)).toList();
  List<PageInfoModel> pageInfoList =
      quranPagesInfo.map((e) => PageInfoModel.fromMap(e)).toList();
  List<HizbModel> hizbInfoList =
      metaDataHizb.values.map((e) => HizbModel.fromMap(e)).toList();
  List<RukuInfoModel> rukuInfoList =
      metaDataRuku.values.map((e) => RukuInfoModel.fromMap(e)).toList();
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    ThemeState themeState = context.read<ThemeCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Gap(10),
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
                  onPressed: () {},
                  icon: const Icon(Icons.add),
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

                      SurahInfoModel surahInfo = SurahInfoModel.fromMap(
                        metaDataSurah[quickAccessModel.surahNumber.toString()],
                      );

                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => QuranScriptView(
                                      startKey: "${surahInfo.id}:1",
                                      endKey:
                                          "${surahInfo.id}:${surahInfo.versesCount}",
                                      toScrollKey:
                                          quickAccessModel.scrollIndex != null
                                              ? "${surahInfo.id}:${quickAccessModel.scrollIndex}"
                                              : null,
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(FluentIcons.flash_24_regular),
                          label: Text(
                            getSurahName(context, surahInfo.id) +
                                (quickAccessModel.scrollIndex != null
                                    ? " - ${quickAccessModel.scrollIndex}"
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

            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
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
                      labelPadding: EdgeInsets.zero,
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
                );
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const ClampingScrollPhysics(),
                children: [
                  SurahListView(surahInfoList: surahInfoList),
                  JuzListView(juzInfoList: juzInfoModelList),
                  PageListView(pageInfoList: pageInfoList),
                  HizbListView(hizbInfoList: hizbInfoList),
                  RukuListView(rukuInfoList: rukuInfoList),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
