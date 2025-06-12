import 'dart:developer';

import 'package:al_quran_v3/src/screen/collections/models/note_collection_model.dart';
import 'package:al_quran_v3/src/screen/collections/models/note_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:uuid/uuid.dart'; // For generating unique IDs
// var uuid = Uuid();

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
        // Pass ayahKey to the AddNoteWidget
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

  bool _selectCollectionStep = false;
  bool _addNewCollectionStep = false;

  List<NoteCollectionModel> _availableCollections = [];
  final Set<String> _selectedCollectionIds = {};

  @override
  void initState() {
    super.initState();
    _fetchCollections();
  }

  void _fetchCollections() {
    // TODO: Fetch existing collections from your data source (e.g., Hive)
    // For now, using placeholder data
    setState(() {
      _availableCollections = [
        NoteCollectionModel(
          id: "col1",
          name: "Reflections",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        NoteCollectionModel(
          id: "col2",
          name: "Favourites",
          colorHex: "FFAB00",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    });
  }

  void _handleAddNewCollection() {
    if (_newCollectionNameController.text.trim().isEmpty) {
      // Optionally, show an error if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Collection name cannot be empty.")),
      );
      return;
    }
    final now = DateTime.now();
    // String newId = uuid.v4(); // TODO: Generate Unique ID
    String newId =
        "col_${DateTime.now().millisecondsSinceEpoch}"; // Placeholder ID

    final newCollection = NoteCollectionModel(
      id: newId,
      name: _newCollectionNameController.text.trim(),
      // colorHex: // TODO: Add a color picker or default color logic
      createdAt: now,
      updatedAt: now,
    );

    // TODO: Save the newCollection to your data source (e.g., Hive)
    // For UI update, add to local list and select it
    setState(() {
      _availableCollections.add(newCollection);
      _selectedCollectionIds.add(newCollection.id);
      _newCollectionNameController.clear();
      _addNewCollectionStep = false; // Hide the input field after adding
    });
    log("Added new collection: ${newCollection.toJsonString()}");
  }

  void _handleSaveNote() {
    if (_noteEditingController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Note content cannot be empty.")),
      );
      return;
    }

    final now = DateTime.now();
    // String newNoteId = uuid.v4(); // TODO: Generate Unique ID
    String newNoteId =
        "note_${DateTime.now().millisecondsSinceEpoch}"; // Placeholder ID

    final newNote = NoteModel(
      id: newNoteId,
      ayahKey: widget.ayahKey, // Use the ayahKey from the widget
      text: _noteEditingController.text.trim(),
      collectionIds: _selectedCollectionIds.toList(),
      createdAt: now,
      updatedAt: now,
    );

    // TODO: Save the newNote to your data source (e.g., Hive)
    log("Saving note: ${newNote.toJsonString()}");

    Navigator.pop(context); // Close the dialog
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Note saved successfully!")));
  }

  @override
  void dispose() {
    _noteEditingController.dispose();
    _newCollectionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                _selectCollectionStep ? "Select Collections" : "Add Note",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (_selectCollectionStep && !_addNewCollectionStep)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _addNewCollectionStep = true;
                    });
                  },
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(FluentIcons.add_24_regular),
                  label: const Text("New"),
                ),
            ],
          ),
          const Divider(),
          // Animated visibility for collection selection step
          if (_selectCollectionStep)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _addNewCollectionStep ? 270 : 220, // Adjusted height
              child: Column(
                children: [
                  if (_addNewCollectionStep)
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
                                  color: AppColors.primaryShade100,
                                  borderRadius: BorderRadius.circular(
                                    roundedRadius,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _newCollectionNameController,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    hintText: "Write collection name...",
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
                                  backgroundColor: AppColors.primaryShade100,
                                  foregroundColor: AppColors.primary,
                                ),
                                onPressed: _handleAddNewCollection,
                                icon: const Icon(Icons.done_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_addNewCollectionStep) const Gap(10),
                  Expanded(
                    child:
                        _availableCollections.isEmpty && !_addNewCollectionStep
                            ? const Center(
                              child: Text("No collections yet. Add a new one!"),
                            )
                            : ListView.builder(
                              itemCount: _availableCollections.length,
                              itemBuilder: (context, index) {
                                final collection = _availableCollections[index];
                                final isSelected = _selectedCollectionIds
                                    .contains(collection.id);
                                return ListTile(
                                  minTileHeight: 40,
                                  leading: Icon(
                                    Icons.folder_rounded,
                                    color: Color(
                                      int.parse("0xFF${collection.colorHex}"),
                                    ),
                                  ),
                                  title: Text(collection.name),
                                  // subtitle: Text("${collection.noteCount} notes"), // TODO: Add note count to collection model if needed
                                  trailing: IconButton(
                                    icon: Icon(
                                      isSelected
                                          ? Icons.check_box_rounded
                                          : Icons
                                              .check_box_outline_blank_rounded,
                                      color:
                                          isSelected
                                              ? AppColors.primary
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedCollectionIds.remove(
                                            collection.id,
                                          );
                                        } else {
                                          _selectedCollectionIds.add(
                                            collection.id,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedCollectionIds.remove(
                                          collection.id,
                                        );
                                      } else {
                                        _selectedCollectionIds.add(
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
          if (!_selectCollectionStep)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryShade100,
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
                if (_selectCollectionStep) // Add a back button for the collection step
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primaryShade100,
                      ),
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        setState(() {
                          _selectCollectionStep = false;
                          _addNewCollectionStep =
                              false; // Also reset this if going back
                        });
                      },
                    ),
                  ),
                Gap(10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundedRadius),
                      ),
                    ),
                    onPressed: () {
                      if (!_selectCollectionStep) {
                        if (_noteEditingController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please write your note first."),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _selectCollectionStep = true;
                        });
                      } else {
                        _handleSaveNote();
                      }
                    },
                    iconAlignment:
                        _selectCollectionStep
                            ? IconAlignment.start
                            : IconAlignment.end,
                    icon: Icon(
                      _selectCollectionStep
                          ? Icons.done_all_rounded
                          : Icons.arrow_forward_rounded,
                    ),
                    label: Text(
                      _selectCollectionStep
                          ? "Save Note"
                          : "Next: Select Collections",
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
