import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_model.dart";
import "package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart";
import "package:al_quran_v3/src/features/collections/presentation/helpers/collection_ui_helpers.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/list_of_ayahs_views.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";

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
  late NoteCollectionModel? _noteCollectionModel;
  late PinnedCollectionModel? _pinnedCollectionModel;

  @override
  void initState() {
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
    _noteCollectionModel = widget.noteCollectionModel;
    _pinnedCollectionModel = widget.pinnedCollectionModel;
  }

  Widget _buildEmptyState(String message) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                FluentIcons.info_24_regular,
                size: 48,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.9, 0.9)),
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    FluentIcons.note_24_filled,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                ),
                const Gap(8),
                Text(
                  formatRelativeDate(noteModel.updatedAt),
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
                const Spacer(),
                if (onMoveUp != null)
                  IconButton(
                    onPressed: onMoveUp,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      FluentIcons.arrow_up_24_regular,
                      size: 18,
                    ),
                  ),
                if (onMoveDown != null)
                  IconButton(
                    onPressed: onMoveDown,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      FluentIcons.arrow_down_24_regular,
                      size: 18,
                    ),
                  ),
                IconButton(
                  onPressed: onDelete,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    FluentIcons.delete_24_regular,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  tooltip: l10n.delete,
                ),
              ],
            ),
            const Gap(10),

            // Note Content Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                noteModel.text,
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                  fontSize: 14.5,
                ),
              ),
            ),

            // Linked Ayahs Chips
            if (noteModel.ayahKey.isNotEmpty) ...[
              const Gap(12),
              InkWell(
                borderRadius: BorderRadius.circular(12),
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.book_open_24_regular,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 4.0,
                          children: noteModel.ayahKey.map((key) {
                            try {
                              SurahInfoModel surahInfo = SurahInfoModel.fromMap(
                                metaDataSurah[key.split(":").first]!,
                              );
                              return Chip(
                                label: Text(
                                  "${getSurahName(context, surahInfo.id)} $key",
                                  style: textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: colorScheme.primaryContainer,
                                side: BorderSide.none,
                              );
                            } catch (e) {
                              log("Error parsing surah info for key $key: $e");
                              return Chip(label: Text(key));
                            }
                          }).toList(),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isNoteCollection = _noteCollectionModel != null;
    final folderHex = isNoteCollection
        ? _noteCollectionModel!.colorHex
        : _pinnedCollectionModel!.colorHex;
    final folderColor = safeParseColor(folderHex);
    final folderName = isNoteCollection
        ? _noteCollectionModel!.name
        : _pinnedCollectionModel!.name;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: folderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isNoteCollection
                    ? FluentIcons.folder_24_filled
                    : FluentIcons.pin_24_filled,
                color: folderColor,
                size: 20,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Text(
                folderName,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          if (isNoteCollection) {
            if (_noteCollectionModel!.notes.isEmpty) {
              return _buildEmptyState(l10n.emptyNoteCollection);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(14.0),
              itemCount: _noteCollectionModel!.notes.length,
              itemBuilder: (context, index) {
                NoteModel noteModel = _noteCollectionModel!.notes[index];
                return Dismissible(
                  key: ValueKey(
                    noteModel.id + index.toString(),
                  ),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    final updatedNotes = List<NoteModel>.from(_noteCollectionModel!.notes)
                      ..removeAt(index);
                    _noteCollectionModel = _noteCollectionModel!.copyWith(
                      notes: updatedNotes,
                    );
                    await getIt<CollectionsRepository>().saveNoteCollectionModelAsMap(
                      _noteCollectionModel!,
                    );
                    setState(() {});
                  },
                  child: _buildNoteItem(
                    noteModel,
                    context,
                    index > 0
                        ? () async {
                            final updatedNotes = List<NoteModel>.from(_noteCollectionModel!.notes);
                            final item = updatedNotes.removeAt(index);
                            updatedNotes.insert(index - 1, item);
                            _noteCollectionModel = _noteCollectionModel!.copyWith(
                              notes: updatedNotes,
                            );
                            await getIt<CollectionsRepository>().saveNoteCollectionModelAsMap(
                              _noteCollectionModel!,
                            );
                            setState(() {});
                            Fluttertoast.showToast(msg: l10n.success);
                          }
                        : null,
                    index < _noteCollectionModel!.notes.length - 1
                        ? () async {
                            final updatedNotes = List<NoteModel>.from(_noteCollectionModel!.notes);
                            final item = updatedNotes.removeAt(index);
                            updatedNotes.insert(index + 1, item);
                            _noteCollectionModel = _noteCollectionModel!.copyWith(
                              notes: updatedNotes,
                            );
                            await getIt<CollectionsRepository>().saveNoteCollectionModelAsMap(
                              _noteCollectionModel!,
                            );
                            setState(() {});
                            Fluttertoast.showToast(msg: l10n.success);
                          }
                        : null,
                    () async {
                      final updatedNotes = List<NoteModel>.from(_noteCollectionModel!.notes)
                        ..removeAt(index);
                      _noteCollectionModel = _noteCollectionModel!.copyWith(
                        notes: updatedNotes,
                      );
                      await getIt<CollectionsRepository>().saveNoteCollectionModelAsMap(
                        _noteCollectionModel!,
                      );
                      setState(() {});
                      Fluttertoast.showToast(msg: l10n.success);
                    },
                  ).animate(delay: (index * 30).ms).fadeIn().slideY(begin: 0.05, end: 0),
                );
              },
            );
          } else if (_pinnedCollectionModel != null) {
            if (_pinnedCollectionModel!.pinned.isEmpty) {
              return _buildEmptyState(l10n.emptyPinnedCollection);
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              itemCount: _pinnedCollectionModel!.pinned.length,
              itemBuilder: (context, index) {
                final pinnedItem = _pinnedCollectionModel!.pinned[index];
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
                    pinnedItem.id + index.toString(),
                  ),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    final updatedPinned = List<PinnedModel>.from(_pinnedCollectionModel!.pinned)
                      ..removeAt(index);
                    _pinnedCollectionModel = _pinnedCollectionModel!.copyWith(
                      pinned: updatedPinned,
                    );
                    await getIt<CollectionsRepository>().savePinnedCollectionModelAsMap(
                      _pinnedCollectionModel!,
                    );
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                        child: Row(
                          children: [
                            const Gap(8),
                            Text(
                              formatRelativeDate(pinnedItem.updatedAt),
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Spacer(),
                            if (index > 0)
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  final updatedPinned = List<PinnedModel>.from(_pinnedCollectionModel!.pinned);
                                  final item = updatedPinned.removeAt(index);
                                  updatedPinned.insert(index - 1, item);
                                  _pinnedCollectionModel = _pinnedCollectionModel!.copyWith(
                                    pinned: updatedPinned,
                                  );
                                  await getIt<CollectionsRepository>().savePinnedCollectionModelAsMap(
                                    _pinnedCollectionModel!,
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(
                                  FluentIcons.arrow_up_24_regular,
                                  size: 18,
                                ),
                              ),
                            if (index <
                                _pinnedCollectionModel!.pinned.length - 1)
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  final updatedPinned = List<PinnedModel>.from(_pinnedCollectionModel!.pinned);
                                  final item = updatedPinned.removeAt(index);
                                  updatedPinned.insert(index + 1, item);
                                  _pinnedCollectionModel = _pinnedCollectionModel!.copyWith(
                                    pinned: updatedPinned,
                                  );
                                  await getIt<CollectionsRepository>().savePinnedCollectionModelAsMap(
                                    _pinnedCollectionModel!,
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(
                                  FluentIcons.arrow_down_24_regular,
                                  size: 18,
                                ),
                              ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () async {
                                final updatedPinned = List<PinnedModel>.from(_pinnedCollectionModel!.pinned)
                                  ..removeAt(index);
                                _pinnedCollectionModel = _pinnedCollectionModel!.copyWith(
                                  pinned: updatedPinned,
                                );
                                await getIt<CollectionsRepository>().savePinnedCollectionModelAsMap(
                                  _pinnedCollectionModel!,
                                );
                                setState(() {});
                              },
                              icon: const Icon(
                                FluentIcons.delete_24_regular,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      cardWidget,
                    ],
                  ).animate(delay: (index * 30).ms).fadeIn().slideY(begin: 0.05, end: 0),
                );
              },
            );
          }
          return _buildEmptyState(l10n.noContentAvailable);
        },
      ),
    );
  }
}
