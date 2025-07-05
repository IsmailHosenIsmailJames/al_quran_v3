import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
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
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../theme/controller/theme_cubit.dart";
import "../../../../theme/controller/theme_state.dart";

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage>
    with SingleTickerProviderStateMixin {
  List<String> pagesName = [];
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final l10n = AppLocalizations.of(context);
    pagesName = [l10n.surah, l10n.juz, l10n.pages, l10n.hizb, l10n.ruku];
    _tabController = TabController(length: pagesName.length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
    );
  }
}
