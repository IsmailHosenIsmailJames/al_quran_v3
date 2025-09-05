import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/utils/filter/search_pattern_in_text.dart";
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

class _BookSelectPopupState extends State<BookSelectPopup> {
  final TextEditingController _textEditingController = TextEditingController();
  late final Map<String, List<Map<String, dynamic>>> _allBooks;
  Map<String, List<Map<String, dynamic>>> _filteredBooks = {};

  @override
  void initState() {
    super.initState();
    _allBooks =
        widget.isTafsir ? tafsirInformationWithScore : translationResources;
    _filteredBooks = _allBooks;
  }

  void _filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBooks = _allBooks;
      });
      return;
    }

    final Map<String, List<Map<String, dynamic>>> tempFiltered = {};
    final lowerCaseQuery = query.toLowerCase();

    _allBooks.forEach((language, books) {
      final List<Map<String, dynamic>> matchedBooks = [];

      final languageNative = languageNativeNames[language] ?? '';
      final langMatchScore = searchPatternInText(
        lowerCaseQuery,
        language.toLowerCase(),
      );
      final langNativeMatchScore = searchPatternInText(
        lowerCaseQuery,
        languageNative.toLowerCase(),
      );

      if (langMatchScore > 70 || langNativeMatchScore > 70) {
        matchedBooks.addAll(books);
      } else {
        for (final bookMap in books) {
          final book =
              widget.isTafsir
                  ? TafsirBookModel.fromMap(bookMap)
                  : TranslationBookModel.fromMap(bookMap);

          final searchableText =
              (widget.isTafsir
                      ? (book as TafsirBookModel).name
                      : (book as TranslationBookModel).name)
                  .toLowerCase();
          final score = searchPatternInText(lowerCaseQuery, searchableText);

          if (score > 40) {
            matchedBooks.add(bookMap);
          }
        }
      }

      if (matchedBooks.isNotEmpty) {
        tempFiltered[language] = matchedBooks;
      }
    });

    setState(() {
      _filteredBooks = tempFiltered;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<
      ResourcesProgressCubitCubit,
      ResourcesProgressCubitState
    >(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: themeState.primaryShade100,
              ),
              child: TextFormField(
                controller: _textEditingController,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(Icons.search),
                  hintText: appLocalizations.search,
                  border: InputBorder.none,
                ),
                onChanged: _filterBooks,
              ),
            ),
            Divider(color: themeState.primaryShade300, height: 1),
            Expanded(
              child: ScrollablePositionedList.builder(
                padding: const EdgeInsets.all(15),
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  String language = _filteredBooks.keys.elementAt(index);
                  List<Map<String, dynamic>> books = _filteredBooks.values
                      .elementAt(index);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            (languageNativeNames[language] ?? "").capitalize(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(10),
                          Text("( ${language.capitalize()} )"),
                        ],
                      ),
                      const Gap(10),
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
                                      .read<ResourcesProgressCubitCubit>()
                                      .changeTafsirBook(book as TafsirBookModel)
                                  : context
                                      .read<ResourcesProgressCubitCubit>()
                                      .changeTranslationBook(
                                        book as TranslationBookModel,
                                      );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    (widget.isTafsir
                                            ? state.tafsirBookModel == book
                                            : state.translationBookModel ==
                                                book)
                                        ? Border.all(
                                          color: themeState.primaryShade300,
                                        )
                                        : null,
                                borderRadius: BorderRadius.circular(
                                  roundedRadius,
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.isTafsir
                                          ? (book as TafsirBookModel).name
                                              .capitalize()
                                          : (book as TranslationBookModel).name
                                              .capitalize(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
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
      },
    );
  }
}
