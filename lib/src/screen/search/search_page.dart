import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/screen/search/cubit/search_state.dart";
import "package:al_quran_v3/src/screen/search/models/search_catagory.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";
import "package:al_quran_v3/src/screen/search/search_result_view.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:flex_color_picker/flex_color_picker.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "cubit/search_cubit.dart";

class SearchPage extends StatefulWidget {
  final bool popup;

  const SearchPage({super.key, this.popup = false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ThemeState themeState = context.read<ThemeCubit>().state;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.popup
              ? null
              : AppBar(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(FluentIcons.search_24_filled, size: 30),
                    Gap(15),
                    Text("Quran Search"),
                  ],
                ),
              ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.popup)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quran Search",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            if (widget.popup) const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: themeState.primaryShade300),
              ),

              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(FluentIcons.search_24_filled),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Gap(20),
            const Text(
              "Search In",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Gap(5),
            searchFieldSelector(),
            const Gap(10),

            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.searchFields == SearchFields.translation) {
                  List<TranslationBookModel> downloaded =
                      QuranTranslationFunction.getDownloadedTranslationBooks();

                  return Column(
                    children: List.generate(downloaded.length, (index) {
                      TranslationBookModel current = downloaded[index];
                      bool isSelected = state.selectedTranslationBoxName
                          .contains(
                            QuranTranslationFunction.getTranslationBoxName(
                              translationBook: current,
                            ),
                          );

                      return ListTile(
                        title: Text(current.name),
                        subtitle: Text(current.language),
                        trailing:
                            isSelected
                                ? Icon(
                                  Icons.check_circle,
                                  color: themeState.primary,
                                )
                                : const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey,
                                ),
                        onTap: () {
                          if (isSelected) {
                            context
                                .read<SearchCubit>()
                                .removeTranslationBoxName(current);
                          } else {
                            context.read<SearchCubit>().addTranslationBoxName(
                              current,
                            );
                          }
                        },
                      );
                    }),
                  );
                } else if (state.searchFields == SearchFields.tafsir) {
                  List<TafsirBookModel> downloaded =
                      QuranTafsirFunction.getDownloadedTafsirBooks();

                  return Column(
                    children: List.generate(downloaded.length, (index) {
                      TafsirBookModel current = downloaded[index];

                      bool isSelected = state.selectedTafsirBoxName.contains(
                        QuranTafsirFunction.getTafsirBoxName(
                          tafsirBook: current,
                        ),
                      );

                      return ListTile(
                        title: Text(current.name),
                        subtitle: Text(current.language),
                        trailing:
                            isSelected
                                ? Icon(
                                  Icons.check_circle,
                                  color: themeState.primary,
                                )
                                : const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey,
                                ),
                        onTap: () {
                          if (isSelected) {
                            context.read<SearchCubit>().addTafsirBoxName(
                              current,
                            );
                          } else {
                            context.read<SearchCubit>().addTafsirBoxName(
                              current,
                            );
                          }
                        },
                      );
                    }),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const Gap(10),
            const Text(
              "Search By",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Gap(5),
            getSearchTypeSelectorWidget(),

            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width,

              child: ElevatedButton.icon(
                onPressed: () {
                  dynamic searchRes = context.read<SearchCubit>().search(
                    searchQuery: textEditingController.text.trim(),
                    scriptType:
                        context.read<QuranViewCubit>().state.quranScriptType,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SearchResultView(searchRes: searchRes),
                    ),
                  );
                },
                icon: const Icon(FluentIcons.search_24_filled),
                label: const Text("Search Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSearchTypeSelectorWidget() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List.generate(SearchCatagory.values.length, (index) {
            SearchCatagory currentSearchField = SearchCatagory.values.elementAt(
              index,
            );
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: currentSearchField == state.searchCatagory,
                  onChanged: (value) {
                    context.read<SearchCubit>().changeSearchCatagory(
                      currentSearchField,
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.read<SearchCubit>().changeSearchCatagory(
                      currentSearchField,
                    );
                  },
                  child: Text(currentSearchField.name.capitalize),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget searchFieldSelector() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List.generate(SearchFields.values.length, (index) {
            SearchFields currentSearchField = SearchFields.values.elementAt(
              index,
            );
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Checkbox(
                  value: currentSearchField == state.searchFields,
                  onChanged: (value) {
                    context.read<SearchCubit>().changeSearchField(
                      currentSearchField,
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.read<SearchCubit>().changeSearchField(
                      currentSearchField,
                    );
                  },
                  child: Text(currentSearchField.name.capitalize),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
