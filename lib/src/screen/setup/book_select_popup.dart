import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/utils/filter/search_pattern_in_text.dart";
import "package:al_quran_v3/src/widget/components/get_score_widget.dart";
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
  late final Map<String, List<Map<String, dynamic>>> _allBooks;
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    _allBooks =
        widget.isTafsir ? tafsirInformationWithScore : translationResources;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<ResourcesProgressCubit>().state;
      final selectedBook =
          widget.isTafsir ? state.tafsirBookModel : state.translationBookModel;

      if (selectedBook != null) {
        String? targetLanguage;

        for (final entry in _allBooks.entries) {
          final language = entry.key;
          final books = entry.value;

          final bookFound = books.any((bookMap) {
            final book =
                widget.isTafsir
                    ? TafsirBookModel.fromMap(bookMap)
                    : TranslationBookModel.fromMap(bookMap);
            return book == selectedBook;
          });

          if (bookFound) {
            targetLanguage = language;
            break;
          }
        }

        if (targetLanguage != null) {
          final languages = _allBooks.keys.toList();
          final languageIndex = languages.indexOf(targetLanguage);

          if (languageIndex != -1) {
            _itemScrollController.scrollTo(
              index: languageIndex,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  void _filterBooks(String query) {
    final lowerCaseQuery = query.toLowerCase();

    List<ScoreDetails> scoreDetails = [];

    for (int index = 0; index < _allBooks.length; index++) {
      String language = _allBooks.keys.elementAt(index);
      List<Map<String, dynamic>> books = _allBooks.values.elementAt(index);

      final languageNative = languageNativeNames[language] ?? "";

      for (final bookMap in books) {
        String searchableText =
            widget.isTafsir
                ? TafsirBookModel.fromMap(bookMap).name
                : TranslationBookModel.fromMap(bookMap).name;

        final score = searchPatternInText(
          lowerCaseQuery,
          "$languageNative $language $searchableText",
        );

        scoreDetails.add(ScoreDetails(score: score, data: bookMap));
      }
    }

    scoreDetails.sort((a, b) => b.score.compareTo(a.score));

    String language =
        widget.isTafsir
            ? TafsirBookModel.fromMap(scoreDetails.first.data).language
            : TranslationBookModel.fromMap(scoreDetails.first.data).language;
    int index = _allBooks.keys.toList().indexOf(language.toLowerCase());
    if (index != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 200),
        );
      });
    }
  }

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
        child: BlocBuilder<ResourcesProgressCubit, ResourcesProgressCubitState>(
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
    ResourcesProgressCubitState state,
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
            onEditingComplete: () {
              _filterBooks(_textEditingController.text);
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
              String language = _allBooks.keys.elementAt(index);
              List<Map<String, dynamic>> books = _allBooks.values.elementAt(
                index,
              );
              if (widget.isTafsir) {
                books.sort(
                  (a, b) => (b["score"] as int).compareTo(a["score"] as int),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        (languageNativeNames[language] ?? "").capitalize(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "( ${language.capitalize()} )",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Gap(5),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(books.length, (i) {
                      var book =
                          widget.isTafsir
                              ? TafsirBookModel.fromMap(books[i])
                              : TranslationBookModel.fromMap(books[i]);

                      return InkWell(
                        borderRadius: BorderRadius.circular(roundedRadius),
                        onTap: () {
                          widget.isTafsir
                              ? context
                                  .read<ResourcesProgressCubit>()
                                  .changeTafsirBook(book as TafsirBookModel)
                              : context
                                  .read<ResourcesProgressCubit>()
                                  .changeTranslationBook(
                                    book as TranslationBookModel,
                                  );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                (widget.isTafsir
                                        ? state.tafsirBookModel == book
                                        : state.translationBookModel == book)
                                    ? Border.all(
                                      color: themeState.primaryShade300,
                                    )
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
                                  if (book is TafsirBookModel)
                                    buildScoreIndicator(
                                      percentage: (book).score,
                                      size: 20,
                                    ),
                                  if (book is TafsirBookModel) const Gap(10),
                                  Expanded(
                                    child: Text(
                                      widget.isTafsir
                                          ? (book as TafsirBookModel).name
                                              .capitalize()
                                          : (book as TranslationBookModel).name
                                              .capitalize(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            (widget.isTafsir
                                                    ? book ==
                                                        state.tafsirBookModel
                                                    : state.translationBookModel ==
                                                        book)
                                                ? themeState.primary
                                                : null,
                                        fontWeight:
                                            (widget.isTafsir
                                                    ? book ==
                                                        state.tafsirBookModel
                                                    : state.translationBookModel ==
                                                        book)
                                                ? FontWeight.w600
                                                : null,
                                      ),
                                    ),
                                  ),
                                  if (!widget.isTafsir &&
                                      (book as TranslationBookModel).type ==
                                          TranslationResourcesType
                                              .withFootnoteTags)
                                    getFeaturesMark(
                                      context,
                                      appLocalizations.footnote,
                                      asColumn: true,
                                    ),

                                  (widget.isTafsir
                                          ? book == state.tafsirBookModel
                                          : state.translationBookModel == book)
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
