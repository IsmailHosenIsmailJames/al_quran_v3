import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/book_search_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/book_search_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/setup_preview_card.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

class BookSelectBottomSheet extends StatefulWidget {
  final bool isTafsir;

  const BookSelectBottomSheet({super.key, required this.isTafsir});

  @override
  State<BookSelectBottomSheet> createState() => _BookSelectBottomSheetState();
}

class _BookSelectBottomSheetState extends State<BookSelectBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final setupState = context.read<SetupBloc>().state;
      final selectedBook = widget.isTafsir
          ? setupState.config.selectedTafsir
          : setupState.config.selectedTranslation;

      if (selectedBook != null) {
        final searchCubit = context.read<BookSearchCubit>();
        final languages = searchCubit.state.sortedLanguages;
        final index = languages.indexOf(selectedBook.languageCode);
        if (index != -1 && _itemScrollController.isAttached) {
          _itemScrollController.jumpTo(index: index);
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BlocBuilder<SetupBloc, SetupState>(
          builder: (context, setupState) {
            return BlocBuilder<BookSearchCubit, BookSearchState>(
              builder: (context, searchState) {
                return _buildMainUi(
                  context,
                  themeState,
                  appLocalizations,
                  setupState,
                  searchState,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainUi(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    SetupState setupState,
    BookSearchState searchState,
  ) {
    final selectedBook = widget.isTafsir
        ? setupState.config.selectedTafsir
        : setupState.config.selectedTranslation;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final searchBg = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.grey.shade100;
    final searchBorder = isDark
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.grey.shade300;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Drag Handle Indicator
        const Gap(10),
        Center(
          child: Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header Title Row
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isTafsir
                          ? appLocalizations.tafsir
                          : appLocalizations.translation,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      "Select your preferred ${widget.isTafsir ? 'tafsir commentary' : 'translation'}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                tooltip: "Close",
              ),
            ],
          ),
        ),

        // Search Bar Input
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: searchBg,
            border: Border.all(color: searchBorder, width: 1),
          ),
          child: TextFormField(
            controller: _searchController,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black87,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 22,
                color: Theme.of(context).hintColor,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        context.read<BookSearchCubit>().updateQuery("");
                        setState(() {});
                      },
                    )
                  : null,
              hintText: "${appLocalizations.search} language or book...",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              context.read<BookSearchCubit>().updateQuery(value);
              setState(() {});
            },
          ),
        ),

        const Divider(height: 1),

        // List of Grouped Books or Empty State
        Expanded(
          child: searchState.sortedLanguages.isEmpty
              ? _buildEmptyState(context, appLocalizations)
              : ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: searchState.sortedLanguages.length,
                  itemBuilder: (context, index) {
                    String langCode = searchState.sortedLanguages[index];
                    List<ResourceEntity> books =
                        searchState.groupedBooks[langCode]!;
                    final firstBook = books.first;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Language Section Header (Clean left accent line)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: themeState.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const Gap(8),
                              Text(
                                firstBook.languageNative.capitalize(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(6),
                              Text(
                                "(${firstBook.language.capitalize()})",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // List of Books under Language
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(books.length, (i) {
                            var book = books[i];
                            bool isSelected = selectedBook == book;

                            final tileBg = isSelected
                                ? themeState.primary.withValues(
                                    alpha: isDark ? 0.15 : 0.08,
                                  )
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.02)
                                    : Colors.white);

                            final tileBorder = isSelected
                                ? themeState.primary.withValues(alpha: 0.6)
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : Colors.grey.shade200);

                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: Material(
                                color: tileBg,
                                borderRadius: BorderRadius.circular(12),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    if (widget.isTafsir) {
                                      context
                                          .read<SetupBloc>()
                                          .add(SetupTafsirSelected(book));
                                    } else {
                                      context
                                          .read<SetupBloc>()
                                          .add(SetupTranslationSelected(book));
                                    }
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: tileBorder,
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            book.name.capitalize(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isSelected
                                                  ? (isDark
                                                      ? Colors.white
                                                      : Colors.black87)
                                                  : null,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        if (!widget.isTafsir && book.hasFootnote)
                                          getFeaturesMark(
                                            context,
                                            appLocalizations.footnote,
                                            asColumn: true,
                                          ),
                                        const Gap(8),
                                        if (isSelected)
                                          Icon(
                                            Icons.check_circle_rounded,
                                            color: themeState.primary,
                                            size: 20,
                                          )
                                        else
                                          Icon(
                                            Icons.radio_button_unchecked,
                                            color: isDark
                                                ? Colors.grey.shade600
                                                : Colors.grey.shade400,
                                            size: 20,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const Gap(4),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations appLocalizations) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Theme.of(context).hintColor.withValues(alpha: 0.6),
            ),
            const Gap(12),
            Text(
              "No matching ${widget.isTafsir ? 'tafsir' : 'translation'} found",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Gap(4),
            Text(
              "Try searching with a different language or book name",
              style: TextStyle(fontSize: 13, color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            TextButton.icon(
              onPressed: () {
                _searchController.clear();
                context.read<BookSearchCubit>().updateQuery("");
                setState(() {});
              },
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text("Clear Search"),
            ),
          ],
        ),
      ),
    );
  }
}
