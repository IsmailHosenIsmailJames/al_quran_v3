import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/collections/collection_page.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../screen/collections/common_function.dart";
import "../../screen/collections/models/pinned_model.dart.dart";
import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "add_note_popup.dart";

Future<void> showAddToPinnedPopup(BuildContext context, String ayahKey) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        // Pass ayahKey to the AddToPinnedWidget
        child: AddToPinnedWidget(ayahKey: ayahKey),
      );
    },
  );
}

class AddToPinnedWidget extends StatefulWidget {
  final String ayahKey;

  const AddToPinnedWidget({super.key, required this.ayahKey});

  @override
  State<AddToPinnedWidget> createState() => _AddToPinnedWidgetState();
}

class _AddToPinnedWidgetState extends State<AddToPinnedWidget> {
  final _newCollectionNameController = TextEditingController();

  bool _addNewPinnedCollectionStep = false;

  List<PinnedCollectionModel> _availablePinnedCollections = [];
  final Set<String> _selectedPinnedCollectionIds = {};

  @override
  void initState() {
    super.initState();
    fetchPinnedCollections().then((value) {
      setState(() {
        _availablePinnedCollections = value;
      });
    });
  }

  void _handleSavePinned() {
    final now = DateTime.now();
    String newPinnedId = uuid.v4();

    final newPinned = PinnedModel(
      id: newPinnedId,
      ayahKey: widget.ayahKey, // Use the ayahKey from the widget
      createdAt: now,
      updatedAt: now,
    );

    final pinnedBox = Hive.box(CollectionType.pinned.name);
    for (String collectionID in _selectedPinnedCollectionIds) {
      PinnedCollectionModel collection = PinnedCollectionModel.fromJson(
        Map<String, dynamic>.from(pinnedBox.get(collectionID)),
      );
      collection.updatedAt = now;
      collection.pinned.add(newPinned);
      pinnedBox.put(collectionID, collection.toJson());
    }

    Navigator.pop(context); // Close the dialog
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context).pinnedSavedSuccessfully,
    );
  }

  @override
  void dispose() {
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
              const Icon(FluentIcons.pin_24_filled),
              const Gap(10),
              Text(
                l10n.addToPinned,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (!_addNewPinnedCollectionStep)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _addNewPinnedCollectionStep = true;
                    });
                  },
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(FluentIcons.add_24_regular),
                  label: Text(l10n.newText),
                ),
            ],
          ),
          const Divider(),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _addNewPinnedCollectionStep ? 270 : 220, // Adjusted height
            child: Column(
              children: [
                if (_addNewPinnedCollectionStep)
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
                                handleAddNewCollection(
                                  _newCollectionNameController.text.trim(),
                                  AppLocalizations.of(context),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _availablePinnedCollections.add(value);
                                      _selectedPinnedCollectionIds.add(
                                        value.id,
                                      );
                                      _newCollectionNameController.clear();
                                      _addNewPinnedCollectionStep = false;
                                    });
                                  }
                                });
                              },
                              icon: const Icon(Icons.done_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_addNewPinnedCollectionStep) const Gap(10),
                Expanded(
                  child:
                      (_availablePinnedCollections.isEmpty &&
                              !_addNewPinnedCollectionStep)
                          ? Center(child: Text(l10n.noCollectionsYetAddANewOne))
                          : ListView.builder(
                            itemCount: _availablePinnedCollections.length,
                            itemBuilder: (context, index) {
                              final collection =
                                  _availablePinnedCollections[index];
                              final isSelected = _selectedPinnedCollectionIds
                                  .contains(collection.id);
                              return ListTile(
                                minTileHeight: 40,
                                leading: Icon(
                                  FluentIcons.pin_24_filled,
                                  color: Color(
                                    int.parse("0xFF${collection.colorHex}"),
                                  ),
                                ),
                                title: Text(collection.name),
                                subtitle: Text(
                                  "${collection.pinned.length} pinned",
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    isSelected
                                        ? Icons.check_box_rounded
                                        : Icons.check_box_outline_blank_rounded,
                                    color:
                                        isSelected
                                            ? themeState.primary
                                            : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedPinnedCollectionIds.remove(
                                          collection.id,
                                        );
                                      } else {
                                        _selectedPinnedCollectionIds.add(
                                          collection.id,
                                        );
                                      }
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedPinnedCollectionIds.remove(
                                        collection.id,
                                      );
                                    } else {
                                      _selectedPinnedCollectionIds.add(
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
          const Gap(10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
              ),
              onPressed: () {
                if (_selectedPinnedCollectionIds.isEmpty) {
                  Fluttertoast.showToast(msg: l10n.noCollectionSelected);
                } else {
                  _handleSavePinned();
                }
              },
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.done_all_rounded),
              label: Text(l10n.savePinned),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> saveDemoPinnedCollection() async {
  final box = Hive.box(CollectionType.pinned.name);
  if (box.values.isEmpty) {
    List<PinnedCollectionModel> collections = [
      PinnedCollectionModel(
        id: "col1",
        name: "Reflections",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        pinned: [],
      ),
      PinnedCollectionModel(
        id: "col2",
        name: "Favourites",
        colorHex: "FFAB00",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        pinned: [],
      ),
    ];
    for (PinnedCollectionModel model in collections) {
      await box.put(model.id, model.toJson());
    }
  }
}
