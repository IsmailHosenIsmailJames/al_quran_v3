import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart";
import "package:al_quran_v3/src/features/collections/presentation/helpers/collection_ui_helpers.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:uuid/uuid.dart";

const _uuid = Uuid();

Future<void> showAddNotePopup(BuildContext context, String ayahKey) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: AddNoteWidget(ayahKey: ayahKey),
        ),
      );
    },
  );
}

class AddNoteWidget extends StatefulWidget {
  final String ayahKey;

  const AddNoteWidget({super.key, required this.ayahKey});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  final _noteEditingController = TextEditingController();
  final _newCollectionNameController = TextEditingController();

  bool _selectNoteCollectionStep = false;
  bool _addNewNoteCollectionStep = false;
  String _selectedColorHex = collectionPresetColors.first;

  List<NoteCollectionModel> _availableNoteCollections = [];
  final Set<String> _selectedNoteCollectionIds = {};

  @override
  void initState() {
    super.initState();
    getIt<CollectionsRepository>().fetchNoteCollections().then((value) {
      if (mounted) {
        setState(() {
          _availableNoteCollections = value;
        });
      }
    });
  }

  void _handleSaveNote() {
    if (_noteEditingController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).noteContentCannotBeEmpty),
        ),
      );
      return;
    }

    final now = DateTime.now();
    String newNoteId = _uuid.v4();

    final newNote = NoteModel(
      id: newNoteId,
      ayahKey: [widget.ayahKey],
      text: _noteEditingController.text.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final notesBox = Hive.box(CollectionType.notes.name);
    for (String collectionID in _selectedNoteCollectionIds) {
      NoteCollectionModel collection = NoteCollectionModel.fromJson(
        deepConvertMap(notesBox.get(collectionID) as Map),
      );
      final updatedNotes = List<NoteModel>.from(collection.notes)..add(newNote);
      collection = collection.copyWith(
        updatedAt: now,
        notes: updatedNotes,
      );
      notesBox.put(collectionID, collection.toJson());
    }

    Navigator.pop(context);
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context).noteSavedSuccessfully,
    );
  }

  @override
  void dispose() {
    _noteEditingController.dispose();
    _newCollectionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(12),
        // Handle bar
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Gap(16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      FluentIcons.note_add_24_filled,
                      color: themeState.primary,
                      size: 22,
                    ),
                  ),
                  const Gap(14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectNoteCollectionStep
                            ? l10n.selectCollections
                            : l10n.addNote,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ayah ${widget.ayahKey}",
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (_selectNoteCollectionStep && !_addNewNoteCollectionStep)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeState.primaryShade100,
                        foregroundColor: themeState.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _addNewNoteCollectionStep = true;
                        });
                      },
                      icon: const Icon(FluentIcons.add_24_regular, size: 18),
                      label: Text(
                        l10n.newText,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
              const Gap(16),

              // Step 1: Note Text Area
              if (!_selectNoteCollectionStep)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: TextFormField(
                    controller: _noteEditingController,
                    maxLines: 6,
                    minLines: 4,
                    autofocus: true,
                    autocorrect: true,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                    decoration: InputDecoration(
                      hintText: "Write your reflection or note here...",
                      hintStyle: TextStyle(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.05, end: 0),

              // Step 2: Folder Selection
              if (_selectNoteCollectionStep)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _addNewNoteCollectionStep ? 290 : 230,
                  child: Column(
                    children: [
                      // New collection inline creation bar with color presets
                      if (_addNewNoteCollectionStep)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: themeState.primary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _newCollectionNameController,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: l10n.writeCollectionName,
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 8,
                                            ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: themeState.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      NoteCollectionModel? newCollection =
                                          await getIt<CollectionsRepository>()
                                              .handleAddNewNoteCollection(
                                                _newCollectionNameController
                                                    .text
                                                    .trim(),
                                                l10n,
                                              );
                                      if (newCollection != null) {
                                        newCollection = newCollection.copyWith(
                                          colorHex: _selectedColorHex,
                                        );
                                        await getIt<CollectionsRepository>()
                                            .saveNoteCollectionModelAsMap(
                                              newCollection,
                                            );
                                        setState(() {
                                          _availableNoteCollections.add(
                                            newCollection!,
                                          );
                                          _selectedNoteCollectionIds.add(
                                            newCollection.id,
                                          );
                                          _newCollectionNameController.clear();
                                          _addNewNoteCollectionStep = false;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.done_rounded,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              // Color presets
                              SizedBox(
                                height: 28,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: collectionPresetColors.length,
                                  separatorBuilder:
                                      (context, index) => const Gap(8),
                                  itemBuilder: (context, index) {
                                    final hex = collectionPresetColors[index];
                                    final isSelected =
                                        _selectedColorHex == hex;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColorHex = hex;
                                        });
                                      },
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: safeParseColor(hex),
                                          shape: BoxShape.circle,
                                          border: isSelected
                                              ? Border.all(
                                                color: Colors.white,
                                                width: 2.5,
                                              )
                                              : null,
                                          boxShadow: isSelected
                                              ? [
                                                BoxShadow(
                                                  color: safeParseColor(
                                                    hex,
                                                  ).withValues(alpha: 0.6),
                                                  blurRadius: 6,
                                                ),
                                              ]
                                              : null,
                                        ),
                                        child: isSelected
                                            ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 200.ms),
                      if (_addNewNoteCollectionStep) const Gap(10),
                      Expanded(
                        child: _availableNoteCollections.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FluentIcons.folder_open_24_regular,
                                    size: 40,
                                    color: colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.5),
                                  ),
                                  const Gap(8),
                                  Text(
                                    l10n.noCollectionsYetAddANewOne,
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.separated(
                              itemCount: _availableNoteCollections.length,
                              separatorBuilder:
                                  (context, index) => const Gap(6),
                              itemBuilder: (context, index) {
                                final collection =
                                    _availableNoteCollections[index];
                                final isSelected = _selectedNoteCollectionIds
                                    .contains(collection.id);
                                final folderColor = safeParseColor(
                                  collection.colorHex,
                                );
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? folderColor.withValues(alpha: 0.12)
                                        : colorScheme.surfaceContainerHighest
                                            .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? folderColor
                                          : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 2,
                                    ),
                                    leading: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: folderColor.withValues(
                                          alpha: 0.18,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        FluentIcons.folder_24_filled,
                                        color: folderColor,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      collection.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${collection.notes.length} notes",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    trailing: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? folderColor
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? null
                                            : Border.all(
                                              color: colorScheme.onSurfaceVariant
                                                  .withValues(alpha: 0.4),
                                              width: 2,
                                            ),
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                          : null,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedNoteCollectionIds.remove(
                                            collection.id,
                                          );
                                        } else {
                                          _selectedNoteCollectionIds.add(
                                            collection.id,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),

              const Gap(16),

              // Action Bar (Back / Next / Save Button)
              Row(
                children: [
                  if (_selectNoteCollectionStep)
                    Container(
                      height: 48,
                      width: 48,
                      margin: const EdgeInsets.only(right: 12),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () {
                          setState(() {
                            _selectNoteCollectionStep = false;
                            _addNewNoteCollectionStep = false;
                          });
                        },
                      ),
                    ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeState.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (!_selectNoteCollectionStep) {
                            if (_noteEditingController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l10n.pleaseWriteYourNoteFirst,
                                  ),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _selectNoteCollectionStep = true;
                            });
                          } else {
                            if (_selectedNoteCollectionIds.isEmpty) {
                              Fluttertoast.showToast(
                                msg: l10n.noCollectionSelected,
                              );
                            } else {
                              _handleSaveNote();
                            }
                          }
                        },
                        iconAlignment: _selectNoteCollectionStep
                            ? IconAlignment.start
                            : IconAlignment.end,
                        icon: Icon(
                          _selectNoteCollectionStep
                              ? Icons.done_all_rounded
                              : Icons.arrow_forward_rounded,
                        ),
                        label: Text(
                          _selectNoteCollectionStep
                              ? l10n.saveNote
                              : l10n.nextSelectCollections,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ],
    );
  }
}
