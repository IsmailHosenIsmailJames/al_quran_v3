import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/collections/list_of_ayahs_views.dart";
import "package:al_quran_v3/src/screen/collections/models/note_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/note_model.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_type_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../widget/quran_script/model/script_info.dart";

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

  Widget _buildNoteItem(NoteModel noteModel, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note:",
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Gap(4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(roundedRadius - 4),
              ),
              child: Text(noteModel.text, style: textTheme.bodyMedium),
            ),
            if (noteModel.ayahKey.isNotEmpty) ...[
              const Gap(12),
              Text(
                "Linked Ayahs:",
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(4),
              InkWell(
                borderRadius: BorderRadius.circular(roundedRadius - 4),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ListOfAyahsViews(ayahsKey: noteModel.ayahKey),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
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
                    children:
                        noteModel.ayahKey.map((key) {
                          try {
                            SurahInfoModel surahInfo = SurahInfoModel.fromMap(
                              metaDataSurah[key.split(":").first],
                            );
                            return Chip(
                              label: Text(
                                "${surahInfo.nameSimple} - $key",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.pinnedCollectionModel.toString()); // Remove for production
    // log(widget.noteCollectionModel.toString()); // Remove for production

    late QuranScriptType quranScriptType =
        context.read<QuranScriptTypeCubit>().state;
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
              return _buildEmptyState(
                "This note collection is empty.\nAdd some notes to see them here.",
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemCount: widget.noteCollectionModel!.notes.length,
              itemBuilder: (context, index) {
                NoteModel noteModel = widget.noteCollectionModel!.notes[index];
                return _buildNoteItem(noteModel, context);
              },
              separatorBuilder:
                  (context, index) => const Gap(0), // Cards have own margin
            );
          } else if (widget.pinnedCollectionModel != null) {
            if (widget.pinnedCollectionModel!.pinned.isEmpty) {
              return _buildEmptyState(
                "No Ayahs pinned to this collection yet.\nPin Ayahs to see them here.",
              );
            }
            return ListView.builder(
              itemCount: widget.pinnedCollectionModel!.pinned.length,
              itemBuilder: (context, index) {
                return getAyahByAyahCard(
                  ayahKey: widget.pinnedCollectionModel!.pinned[index].ayahKey,
                  quranScriptType: quranScriptType,
                  context: context,
                  showFullKey: true,
                );
              },
            );
          }
          return _buildEmptyState(
            "No content available.",
          ); // Fallback, should not happen due to asserts
        },
      ),
    );
  }
}
