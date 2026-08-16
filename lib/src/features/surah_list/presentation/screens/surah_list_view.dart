import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/widgets/get_surah_index_widget.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";

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
    _searchCubit = SurahSearchCubit(context);
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    Brightness brightness = Theme.brightnessOf(context);
    Color textColor = brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return BlocBuilder<SurahSearchCubit, SurahSearchState>(
      bloc: _searchCubit,
      builder: (context, state) {
        final filteredSurah = state.filteredSurahs;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 120),
          itemCount: filteredSurah.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 5,
                  right: 5,
                ),
                child: SearchBar(
                  elevation: WidgetStateProperty.all<double?>(0),
                  hintText: l10n.searchForASurah,
                  controller: searchController,
                  backgroundColor: WidgetStateProperty.all<Color?>(
                    context.read<ThemeCubit>().state.primaryShade100,
                  ),
                  leading: const Icon(FluentIcons.search_24_filled),
                  onChanged: (value) {
                    _searchCubit.onSearchChanged(value);
                  },
                ),
              );
            }
            index = index - 1;
            return Padding(
              padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                  side: BorderSide(
                    color: context.read<ThemeCubit>().state.primaryShade200,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuranScriptView(
                        startKey: "${filteredSurah[index].id}:1",
                        endKey:
                            "${filteredSurah[index].id}:${filteredSurah[index].versesCount}",
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 3,
                    bottom: 3,
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      getIndexNumberWidget(
                        context,
                        filteredSurah[index].id,
                        textColor: textColor,
                        height: 40,
                        width: 40,
                      ),
                      const Gap(15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(
                                  filteredSurah[index].revelationPlace == "makkah"
                                      ? "assets/img/kaaba_10171102.png"
                                      : "assets/img/masjid-al-nabawi_16183907.png",
                                ),
                              ),
                              const Gap(3),
                              Text(
                                getSurahName(context, filteredSurah[index].id),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          Text(
                            getSurahMeaning(context, filteredSurah[index].id),
                            style: TextStyle(
                              color: brightness == Brightness.light
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "surah${filteredSurah[index].id.toString().padLeft(3, '0')}",
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontFamily: "surah-name-v1",
                            ),
                          ),
                          Text(
                            l10n.ayahsCount(
                              localizedNumber(
                                context,
                                filteredSurah[index].versesCount,
                              ),
                            ),
                            style: TextStyle(
                              color: brightness == Brightness.light
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
