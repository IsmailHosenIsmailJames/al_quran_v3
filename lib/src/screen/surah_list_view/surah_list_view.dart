import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/functions/filter/filter_surah.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/components/get_surah_index_widget.dart";
import "package:al_quran_v3/src/widget/quick_access/quick_access_popup.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/controller/theme_cubit.dart";

class SurahListView extends StatefulWidget {
  final List<SurahInfoModel> surahInfoList;

  const SurahListView({super.key, required this.surahInfoList});

  @override
  State<SurahListView> createState() => _SurahListViewState();
}

class _SurahListViewState extends State<SurahListView> {
  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    Brightness brightness = Theme.of(context).brightness;
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    List<SurahInfoModel> filteredSurah = getFilteredSurah(
      context,
      searchController.text.trim(),
    );
    ThemeState themeState = context.read<ThemeCubit>().state;

    return Scrollbar(
      controller: scrollController,
      radius: Radius.circular(roundedRadius),
      thickness: 13,
      interactive: true,

      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: filteredSurah.length + 1,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
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

                          SurahInfoModel surahInfo = SurahInfoModel.fromMap(
                            metaDataSurah[quickAccessModel.surahNumber
                                .toString()],
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
                                              quickAccessModel.scrollIndex !=
                                                      null
                                                  ? "${surahInfo.id}:${quickAccessModel.scrollIndex}"
                                                  : null,
                                        ),
                                  ),
                                );
                              },
                              icon: const Icon(FluentIcons.flash_24_regular),
                              label: Text(
                                getSurahName(context, surahInfo.id) +
                                    ((quickAccessModel.scrollIndex != null &&
                                            quickAccessModel.scrollIndex != 0)
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

                Padding(
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
                      themeState.primaryShade100,
                    ),
                    leading: const Icon(FluentIcons.search_24_filled),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            );
          }
          index--;

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
                    builder:
                        (context) => QuranScriptView(
                          startKey: "${index + 1}:1",
                          endKey:
                              "${index + 1}:${filteredSurah[index].versesCount}",
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
                            color:
                                brightness == Brightness.light
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
                          getSurahNameArabic(filteredSurah[index].id),
                          style: TextStyle(fontSize: 18, color: textColor),
                        ),
                        Text(
                          l10n.ayahsCount(
                            localizedNumber(
                              context,
                              filteredSurah[index].versesCount,
                            ),
                          ),
                          style: TextStyle(
                            color:
                                brightness == Brightness.light
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
      ),
    );
  }
}
