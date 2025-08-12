import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/filter/filter_surah.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

void showQuickAccessPopup(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    builder: (context) {
      return const QuickAccessWidget();
    },
  );
}

class QuickAccessWidget extends StatefulWidget {
  const QuickAccessWidget({super.key});

  @override
  State<QuickAccessWidget> createState() => _QuickAccessWidgetState();
}

class _QuickAccessWidgetState extends State<QuickAccessWidget> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    List<SurahInfoModel> filteredSurah = getFilteredSurah(
      context,
      searchController.text.trim(),
    );
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      maxChildSize: 1.0,
      minChildSize: 0.7,
      expand: true,

      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Gap(10),
                  Text(
                    l10n.quickAccess,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 2),

            Expanded(
              child: BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
                builder: (context, listOfQuickAccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    controller: scrollController,
                    itemCount: filteredSurah.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: SearchBar(
                                elevation: WidgetStateProperty.all<double?>(0),
                                hintText: l10n.searchForASurah,
                                controller: searchController,
                                backgroundColor:
                                    WidgetStateProperty.all<Color?>(
                                      themeState.primaryShade100,
                                    ),
                                leading: const Icon(
                                  FluentIcons.search_24_filled,
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                Text(
                                  l10n.surah,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  l10n.initiallyScrollAyah,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                          ],
                        );
                      }
                      index--;
                      QuickAccessModel? matchedQuickAccess = listOfQuickAccess
                          .firstOrNullWhere(
                            (element) =>
                                element.surahNumber == filteredSurah[index].id,
                          );

                      SurahInfoModel surahInfoModel = filteredSurah[index];
                      return GestureDetector(
                        onTap: () {
                          if (matchedQuickAccess != null) {
                            context.read<QuickAccessCubit>().removeQuickAccess(
                              matchedQuickAccess,
                            );
                          } else {
                            context.read<QuickAccessCubit>().addQuickAccess(
                              QuickAccessModel(
                                surahNumber: surahInfoModel.id,
                                scrollIndex: 1,
                                createdAt: DateTime.now(),
                              ),
                            );
                          }
                          setState(() {});
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            Icon(
                              matchedQuickAccess != null
                                  ? Icons.check_circle_outline_outlined
                                  : Icons.circle_outlined,
                              color:
                                  matchedQuickAccess != null
                                      ? themeState.primary
                                      : Colors.grey,
                            ),
                            const Gap(10),
                            Text(
                              "${localizedNumber(context, surahInfoModel.id)}. ${getSurahName(context, surahInfoModel.id)}",
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              child:
                                  matchedQuickAccess != null
                                      ? DropdownButton(
                                        value:
                                            matchedQuickAccess.scrollIndex ?? 1,
                                        underline: const SizedBox(),

                                        items: List.generate(
                                          surahInfoModel.versesCount,
                                          (index) {
                                            index++;
                                            return DropdownMenuItem(
                                              value: index,
                                              child: Text(
                                                localizedNumber(context, index),
                                              ),
                                            );
                                          },
                                        ),
                                        onChanged: (value) {
                                          context
                                              .read<QuickAccessCubit>()
                                              .updateQuickAccess(
                                                QuickAccessModel(
                                                  surahNumber:
                                                      surahInfoModel.id,
                                                  scrollIndex: value,
                                                  createdAt: DateTime.now(),
                                                ),
                                              );
                                        },
                                      )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
