import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

class BookSelectPopup extends StatefulWidget {
  final bool isTafsir;
  const BookSelectPopup({super.key, required this.isTafsir});

  @override
  State<BookSelectPopup> createState() => _BookSelectPopupState();
}

class ScoreDetails {
  double score;
  Map<String, dynamic> data;
  ScoreDetails({required this.score, required this.data});
}

class _BookSelectPopupState extends State<BookSelectPopup> {
  final TextEditingController _textEditingController = TextEditingController();
  late final Map<String, List<ResourcesModel>> _allBooks;
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    Map<String, List<ResourcesModel>> allResources = context
        .read<ResourcesProcceessCubit>()
        .state
        .allResources;
    _allBooks = widget.isTafsir
        ? allResources.values
              .expand((element) => element)
              .where((element) => element.type == ResourceType.tafsir)
              .sortedBy((element) => element.englishName)
              .groupBy((element) => element.languageCode)
        : allResources.values
              .expand((element) => element)
              .where(
                (element) =>
                    element.type == ResourceType.simple ||
                    element.type == ResourceType.with_footnote,
              )
              .sortedBy((element) => element.englishName)
              .groupBy((element) => element.languageCode);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<ResourcesProcceessCubit>().state;
      final selectedBook = widget.isTafsir
          ? state.selectedTafsirResources
          : state.selectedTranslationResources;

      if (selectedBook != null) {
        final languages = _allBooks.keys.sorted().toList();
        final languageIndex = languages.indexOf(selectedBook.languageCode);
        if (languageIndex != -1) {
          _itemScrollController.jumpTo(index: languageIndex);
        }
      }
    });
  }

  void _filterBooks(String query) {}

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return ClipRRect(
      borderRadius: const BorderRadiusGeometry.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:
            BlocBuilder<ResourcesProcceessCubit, ResourcesProcceessCubitState>(
              builder: (context, state) {
                return mainUi(context, themeState, appLocalizations, state);
              },
            ),
      ),
    );
  }

  Column mainUi(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    ResourcesProcceessCubitState state,
  ) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_downward_rounded),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: themeState.primaryShade100,
          ),
          child: TextFormField(
            controller: _textEditingController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon: const Icon(Icons.search),
              hintText: appLocalizations.search,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _filterBooks(value);
            },
          ),
        ),
        Divider(color: themeState.primaryShade300, height: 1),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            padding: const EdgeInsets.all(15),
            itemCount: _allBooks.length,
            itemBuilder: (context, index) {
              String language = _allBooks.keys.sorted().elementAt(index);
              List<ResourcesModel> books = _allBooks[language]!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        (books.first.languageNative).capitalize(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "( ${books.first.language.capitalize()} )",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Gap(5),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(books.length, (i) {
                      var book = books[i];

                      return InkWell(
                        borderRadius: BorderRadius.circular(roundedRadius),
                        onTap: () {
                          widget.isTafsir
                              ? context
                                    .read<ResourcesProcceessCubit>()
                                    .changeTafsirBook(book)
                              : context
                                    .read<ResourcesProcceessCubit>()
                                    .changeTranslationBook(book);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                (widget.isTafsir
                                    ? state.selectedTafsirResources == book
                                    : state.selectedTranslationResources ==
                                          book)
                                ? Border.all(color: themeState.primaryShade300)
                                : null,
                            borderRadius: BorderRadius.circular(roundedRadius),
                          ),
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      book.name.capitalize(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            (widget.isTafsir
                                                ? book ==
                                                      state
                                                          .selectedTafsirResources
                                                : state.selectedTranslationResources ==
                                                      book)
                                            ? themeState.primary
                                            : null,
                                        fontWeight:
                                            (widget.isTafsir
                                                ? book ==
                                                      state
                                                          .selectedTafsirResources
                                                : state.selectedTranslationResources ==
                                                      book)
                                            ? FontWeight.w600
                                            : null,
                                      ),
                                    ),
                                  ),
                                  if (!widget.isTafsir &&
                                      book.type == ResourceType.with_footnote)
                                    getFeaturesMark(
                                      context,
                                      appLocalizations.footnote,
                                      asColumn: true,
                                    ),

                                  (widget.isTafsir
                                          ? book ==
                                                state.selectedTafsirResources
                                          : state.selectedTranslationResources ==
                                                book)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: themeState.primary,
                                        )
                                      : const SizedBox(),
                                  const Gap(7),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const Gap(10),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
