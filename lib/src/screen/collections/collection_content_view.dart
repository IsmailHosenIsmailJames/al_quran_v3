import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/collections/list_of_ayahs_views.dart";
import "package:al_quran_v3/src/screen/collections/models/note_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/note_model.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";

import "../../resources/quran_resources/meta/meta_data_surah.dart";
import "common_function.dart";

class CollectionContentView extends StatefulWidget {
  final NoteCollectionModel? noteCollectionModel;
  final PinnedCollectionModel? pinnedCollectionModel;
  const CollectionContentView({
    super.key,
    this.noteCollectionModel,
    this.pinnedCollectionModel,
  });

  @override
  State<CollectionContentView> createState() => _CollectionContentViewState();
}

class _CollectionContentViewState extends State<CollectionContentView> {
  @override
  void initState() {
    // Assertions are great for development
    assert(
      !(widget.noteCollectionModel == null &&
          widget.pinnedCollectionModel == null),
      "NoteCollectionModel or PinnedCollectionModel must be provided",
    );
    assert(
      !(widget.noteCollectionModel != null &&
          widget.pinnedCollectionModel != null),
      "NoteCollectionModel & PinnedCollectionModel both cannot be provided",
    );
    super.initState();
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FluentIcons.info_24_regular,
              size: 50,
              color: Colors.grey,
            ),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(
    NoteModel noteModel,
    BuildContext context,
    VoidCallback? onMoveUp,
    VoidCallback? onMoveDown,
    VoidCallback onDelete,
  ) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              bottom: 0,
              right: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.note,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Row(
                  children: [
                    if (onMoveUp != null)
                      IconButton(
                        onPressed: onMoveUp,
                        icon: const Icon(
                          FluentIcons.arrow_up_24_regular,
                          size: 20,
                        ),
                      ),
                    if (onMoveDown != null)
                      IconButton(
                        onPressed: onMoveDown,
                        icon: const Icon(
                          FluentIcons.arrow_down_24_regular,
                          size: 20,
                        ),
                      ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        FluentIcons.delete_24_regular,
                        color: Colors.red,
                        size: 20,
                      ),
                      tooltip: l10n.delete,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(4),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(roundedRadius - 4),
            ),
            child: Text(noteModel.text, style: textTheme.bodyMedium),
          ),
          if (noteModel.ayahKey.isNotEmpty) ...[
            const Gap(12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l10n.linkedAyahs,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Gap(4),
            InkWell(
              borderRadius: BorderRadius.circular(roundedRadius - 4),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListOfAyahsViews(ayahsKey: noteModel.ayahKey),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(roundedRadius - 4),
                  // border: Border.all(color: colorScheme.outline) // Optional: add border
                ),
                child: Wrap(
                  spacing: 8.0, // Gap between adjacent chips.
                  runSpacing: 4.0, // Gap between lines.
                  children: noteModel.ayahKey.map((key) {
                    try {
                      SurahInfoModel surahInfo = SurahInfoModel.fromMap(
                        metaDataSurah[key.split(":").first]!,
                      );
                      return Chip(
                        label: Text(
                          "${getSurahName(context, surahInfo.id)} - $key",
                          style: textTheme.labelSmall,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                        backgroundColor: colorScheme.secondaryContainer
                            .withValues(alpha: 0.7),
                        side: BorderSide.none,
                      );
                    } catch (e) {
                      log("Error parsing surah info for key $key: $e");
                      return Chip(label: Text(key)); // Fallback
                    }
                  }).toList(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.noteCollectionModel != null
                  ? FluentIcons.note_24_regular
                  : FluentIcons.pin_24_filled,
            ),
            const Gap(10),
            Expanded(
              // Added Expanded to prevent overflow if name is long
              child: Text(
                widget.noteCollectionModel?.name ??
                    widget.pinnedCollectionModel!.name,
                style: textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          // Use Builder to ensure context is correct for Theme
          if (widget.noteCollectionModel != null) {
            if (widget.noteCollectionModel!.notes.isEmpty) {
              return _buildEmptyState(l10n.emptyNoteCollection);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemCount: widget.noteCollectionModel!.notes.length,
              itemBuilder: (context, index) {
                NoteModel noteModel = widget.noteCollectionModel!.notes[index];
                return Dismissible(
                  key: ValueKey(
                    noteModel.hashCode.toString() + index.toString(),
                  ),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    widget.noteCollectionModel!.notes.removeAt(index);
                    await saveNoteCollectionModelAsMap(
                      widget.noteCollectionModel!,
                    );
                    setState(() {});
                  },
                  child: _buildNoteItem(
                    noteModel,
                    context,
                    index > 0
                        ? () async {
                            final item = widget.noteCollectionModel!.notes
                                .removeAt(index);
                            widget.noteCollectionModel!.notes.insert(
                              index - 1,
                              item,
                            );
                            await saveNoteCollectionModelAsMap(
                              widget.noteCollectionModel!,
                            );
                            setState(() {});
                            Fluttertoast.showToast(msg: l10n.success);
                          }
                        : null,
                    index < widget.noteCollectionModel!.notes.length - 1
                        ? () async {
                            final item = widget.noteCollectionModel!.notes
                                .removeAt(index);
                            widget.noteCollectionModel!.notes.insert(
                              index + 1,
                              item,
                            );
                            await saveNoteCollectionModelAsMap(
                              widget.noteCollectionModel!,
                            );
                            setState(() {});
                            Fluttertoast.showToast(msg: l10n.success);
                          }
                        : null,
                    () async {
                      widget.noteCollectionModel!.notes.removeAt(index);
                      await saveNoteCollectionModelAsMap(
                        widget.noteCollectionModel!,
                      );
                      setState(() {});
                      Fluttertoast.showToast(msg: l10n.success);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Gap(0), // Cards have own margin
            );
          } else if (widget.pinnedCollectionModel != null) {
            if (widget.pinnedCollectionModel!.pinned.isEmpty) {
              return _buildEmptyState(l10n.emptyPinnedCollection);
            }
            return ListView.builder(
              itemCount: widget.pinnedCollectionModel!.pinned.length,
              itemBuilder: (context, index) {
                final pinnedItem = widget.pinnedCollectionModel!.pinned[index];
                final TranslationWithWordByWord? translationData =
                    getTranslationFromCache(pinnedItem.ayahKey);
                Widget cardWidget = translationData != null
                    ? getAyahByAyahCard(
                        ayahKey: pinnedItem.ayahKey,
                        context: context,
                        showFullKey: true,
                        translationListWithInfo:
                            translationData.translationList,
                        wordByWord: translationData.wordByWord ?? [],
                      )
                    : FutureBuilder(
                        future: getTranslationWithWordByWord(
                          pinnedItem.ayahKey,
                        ),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.connectionState !=
                              ConnectionState.done) {
                            return const SizedBox(height: 250);
                          }
                          return getAyahByAyahCard(
                            ayahKey: pinnedItem.ayahKey,
                            context: context,
                            showFullKey: true,
                            translationListWithInfo:
                                asyncSnapshot.data?.translationList ?? [],
                            wordByWord: asyncSnapshot.data?.wordByWord ?? [],
                          );
                        },
                      );

                return Dismissible(
                  key: ValueKey(
                    pinnedItem.hashCode.toString() + index.toString(),
                  ),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      bottom: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    widget.pinnedCollectionModel!.pinned.removeAt(index);
                    await savePinnedCollectionModelAsMap(
                      widget.pinnedCollectionModel!,
                    );
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (index > 0)
                                IconButton(
                                  onPressed: () async {
                                    final item = widget
                                        .pinnedCollectionModel!
                                        .pinned
                                        .removeAt(index);
                                    widget.pinnedCollectionModel!.pinned.insert(
                                      index - 1,
                                      item,
                                    );
                                    await savePinnedCollectionModelAsMap(
                                      widget.pinnedCollectionModel!,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    FluentIcons.arrow_up_24_regular,
                                    size: 20,
                                  ),
                                ),
                              if (index <
                                  widget.pinnedCollectionModel!.pinned.length -
                                      1)
                                IconButton(
                                  onPressed: () async {
                                    final item = widget
                                        .pinnedCollectionModel!
                                        .pinned
                                        .removeAt(index);
                                    widget.pinnedCollectionModel!.pinned.insert(
                                      index + 1,
                                      item,
                                    );
                                    await savePinnedCollectionModelAsMap(
                                      widget.pinnedCollectionModel!,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    FluentIcons.arrow_down_24_regular,
                                    size: 20,
                                  ),
                                ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 0,
                                  ),
                                  minimumSize: const Size(0, 30),
                                ),
                                onPressed: () async {
                                  widget.pinnedCollectionModel!.pinned.removeAt(
                                    index,
                                  );
                                  await savePinnedCollectionModelAsMap(
                                    widget.pinnedCollectionModel!,
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(
                                  FluentIcons.delete_24_regular,
                                  size: 16,
                                ),
                                label: Text(
                                  l10n.delete,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      cardWidget,
                    ],
                  ),
                );
              },
            );
          }
          return _buildEmptyState(
            l10n.noContentAvailable,
          ); // Fallback, should not happen due to asserts
        },
      ),
    );
  }
}
