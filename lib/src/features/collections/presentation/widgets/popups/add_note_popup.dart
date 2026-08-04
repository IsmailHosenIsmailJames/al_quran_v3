import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:uuid/uuid.dart";

var uuid = const Uuid();

Future<void> showAddNotePopup(BuildContext context, String ayahKey) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: AddNoteWidget(ayahKey: ayahKey),
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

  List<NoteCollectionModel> _availableNoteCollections = [];
  final Set<String> _selectedNoteCollectionIds = {};

  @override
  void initState() {
    super.initState();
    CollectionsLocalDataSource.fetchNoteCollections().then((value) {
      setState(() {
        _availableNoteCollections = value;
      });
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
    String newNoteId = uuid.v4();

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
        Map<String, dynamic>.from(notesBox.get(collectionID)),
      );
      collection.updatedAt = now;
      collection.notes.add(newNote);
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(FluentIcons.note_add_24_regular),
              const Gap(10),
              Text(
                _selectNoteCollectionStep
                    ? l10n.selectCollections
                    : l10n.addNote,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (_selectNoteCollectionStep && !_addNewNoteCollectionStep)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _addNewNoteCollectionStep = true;
                    });
                  },
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(FluentIcons.add_24_regular),
                  label: Text(l10n.newText),
                ),
            ],
          ),
          const Divider(),
          if (_selectNoteCollectionStep)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _addNewNoteCollectionStep ? 270 : 220,
              child: Column(
                children: [
                  if (_addNewNoteCollectionStep)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        height: 45,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: themeState.primaryShade100,
                                  borderRadius: BorderRadius.circular(
                                    roundedRadius,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _newCollectionNameController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: l10n.writeCollectionName,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 60,
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: themeState.primaryShade100,
                                  foregroundColor: themeState.primary,
                                ),
                                onPressed: () async {
                                  NoteCollectionModel? newCollection =
                                      await CollectionsLocalDataSource.handleAddNewNoteCollection(
                                        _newCollectionNameController.text
                                            .trim(),
                                        l10n,
                                      );
                                  if (newCollection != null) {
                                    setState(() {
                                      _availableNoteCollections.add(
                                        newCollection,
                                      );
                                      _selectedNoteCollectionIds.add(
                                        newCollection.id,
                                      );
                                      _newCollectionNameController.clear();
                                      _addNewNoteCollectionStep = false;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.done_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_addNewNoteCollectionStep) const Gap(10),
                  Expanded(
                    child:
                        (_availableNoteCollections.isEmpty &&
                                !_addNewNoteCollectionStep &&
                                _addNewNoteCollectionStep)
                            ? Center(
                              child: Text(l10n.noCollectionsYetAddANewOne),
                            )
                            : ListView.builder(
                              itemCount: _availableNoteCollections.length,
                              itemBuilder: (context, index) {
                                final collection =
                                    _availableNoteCollections[index];
                                final isSelected = _selectedNoteCollectionIds
                                    .contains(collection.id);
                                return ListTile(
                                  minTileHeight: 40,
                                  leading: Icon(
                                    FluentIcons.folder_24_filled,
                                    color: Color(
                                      int.parse("0xFF${collection.colorHex}"),
                                    ),
                                  ),
                                  title: Text(collection.name),
                                  subtitle: Text(
                                    "${collection.notes.length} notes",
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      isSelected
                                          ? Icons.check_box_rounded
                                          : Icons
                                              .check_box_outline_blank_rounded,
                                      color:
                                          isSelected
                                              ? themeState.primary
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
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
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          if (!_selectNoteCollectionStep)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              child: TextFormField(
                controller: _noteEditingController,
                maxLines: 10,
                minLines: 4,
                autofocus: true,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: "Write your note here...",
                  border: InputBorder.none,
                ),
              ),
            ),
          const Gap(10),
          SizedBox(
            height: 45,
            child: Row(
              children: [
                if (_selectNoteCollectionStep)
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: themeState.primaryShade100,
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
                const Gap(10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundedRadius),
                      ),
                    ),
                    onPressed: () {
                      if (!_selectNoteCollectionStep) {
                        if (_noteEditingController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.pleaseWriteYourNoteFirst),
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
                    iconAlignment:
                        _selectNoteCollectionStep
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
