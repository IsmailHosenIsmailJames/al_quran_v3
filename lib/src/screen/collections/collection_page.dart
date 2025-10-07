import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/collections/collection_content_view.dart";
import "package:al_quran_v3/src/screen/collections/common_function.dart";
import "package:al_quran_v3/src/screen/collections/models/note_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/sorting_methods_type.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:flex_color_picker/flex_color_picker.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../theme/controller/theme_cubit.dart";

class CollectionPage extends StatefulWidget {
  final CollectionType collectionType;

  const CollectionPage({super.key, required this.collectionType});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final TextEditingController _searchTextFieldController =
      TextEditingController();
  List<NoteCollectionModel> _listOfNoteCollection = [];
  List<NoteCollectionModel> _filteredNoteCollection = [];
  List<PinnedCollectionModel> _listOfPinnedCollection = [];
  List<PinnedCollectionModel> _filteredPinnedCollection = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchTextFieldController.addListener(_filterCollections);
  }

  @override
  void dispose() {
    _searchTextFieldController.removeListener(_filterCollections);
    _searchTextFieldController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      if (widget.collectionType == CollectionType.notes) {
        _listOfNoteCollection = await fetchNoteCollections();
        _filteredNoteCollection = List.from(_listOfNoteCollection);
      } else {
        _listOfPinnedCollection = await fetchPinnedCollections();
        _filteredPinnedCollection = List.from(_listOfPinnedCollection);
      }
    } catch (e) {
      setState(() {
        _errorMessage = l10n.failedToLoadCollections(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterCollections() {
    final query = _searchTextFieldController.text.toLowerCase();
    setState(() {
      if (widget.collectionType == CollectionType.notes) {
        _filteredNoteCollection =
            _listOfNoteCollection
                .where(
                  (collection) => collection.name.toLowerCase().contains(query),
                )
                .toList();
      } else {
        _filteredPinnedCollection =
            _listOfPinnedCollection
                .where(
                  (collection) => collection.name.toLowerCase().contains(query),
                )
                .toList();
      }
    });
  }

  Widget _buildSearchAndFilterBar(Color svgColor, AppLocalizations l10n) {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              child: TextFormField(
                controller: _searchTextFieldController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(FluentIcons.search_24_regular),
                  hintText: l10n.searchByCollectionName(
                    StringCapitalizeExtension(
                      widget.collectionType.name,
                    ).capitalize(),
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
          SizedBox(
            width: 50,
            height: 45,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
              ),
              icon: SvgPicture.asset(
                "assets/img/adjust-horizontal-settings-svgrepo-com.svg",
                height: 23,
                width: 23,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color ?? svgColor,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                String sortMethod = Hive.box("user").get(
                  "selected_sorting_method",
                  defaultValue: SortingMethodsType.values.first.name,
                );
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 400,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            l10n.sortBy,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Divider(
                            color: context.read<ThemeCubit>().state.mutedGray,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: SortingMethodsType.values.length,
                              itemBuilder: (context, index) {
                                SortingMethodsType current =
                                    SortingMethodsType.values[index];
                                return ListTile(
                                  onTap: () async {
                                    await Hive.box("user").put(
                                      "selected_sorting_method",
                                      current.name,
                                    );
                                    await _fetchData();
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(
                                    current.name == sortMethod
                                        ? Icons.radio_button_on
                                        : Icons.radio_button_off,
                                    color:
                                        current.name == sortMethod
                                            ? context
                                                .read<ThemeCubit>()
                                                .state
                                                .primary
                                            : null,
                                  ),
                                  title: Text(current.toReadableString(l10n)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Color svgColor, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/img/empty-folder-svgrepo-com.svg",
              height: 100,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color?.withValues(alpha: 0.6) ??
                    svgColor.withValues(alpha: 0.6),
                BlendMode.srcIn,
              ),
            ),
            const Gap(20),
            Text(
              l10n.noCollectionAddedYet(widget.collectionType.name),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  late AppLocalizations l10n;

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Color svgColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade100
            : Colors.grey.shade900;

    final bool isNotes = widget.collectionType == CollectionType.notes;
    final bool hasItems =
        isNotes
            ? _filteredNoteCollection.isNotEmpty
            : _filteredPinnedCollection.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringCapitalizeExtension(
            widget.collectionType.name == "notes" ? l10n.notes : l10n.pinned,
          ).capitalize(),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: _fetchData,
        //     icon: const Icon(FluentIcons.arrow_sync_24_regular),
        //     tooltip: "Refresh",
        //   ),
        // ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilterBar(svgColor, l10n),
          Expanded(
            child:
                _isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor:
                            context.read<ThemeCubit>().state.primaryShade100,
                      ),
                    )
                    : _errorMessage != null
                    ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    )
                    : hasItems
                    ? ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      itemCount:
                          isNotes
                              ? _filteredNoteCollection.length
                              : _filteredPinnedCollection.length,
                      itemBuilder: (BuildContext context, int index) {
                        return isNotes
                            ? _getNoteCollectionWidget(
                              _filteredNoteCollection[index],
                              l10n,
                            )
                            : _getPinnedCollectionWidget(
                              _filteredPinnedCollection[index],
                              l10n,
                            );
                      },
                    )
                    : _buildEmptyState(svgColor, l10n),
          ),
        ],
      ),
    );
  }

  Widget _getPinnedCollectionWidget(
    PinnedCollectionModel pinnedCollectionModel,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Icon(
          FluentIcons.pin_24_filled,
          color: safeParseColor(
            pinnedCollectionModel.colorHex,
            defaultColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          pinnedCollectionModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          l10n.pinnedItemsCount(pinnedCollectionModel.pinned.length),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  TextEditingController nameController = TextEditingController(
                    text: pinnedCollectionModel.name,
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                autofocus: true,
                              ),
                              const Gap(15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (nameController.text.trim().isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: l10n.emptyNameNotAllowed,
                                      );
                                      return;
                                    }
                                    pinnedCollectionModel.name =
                                        nameController.text.trim();

                                    await savePinnedCollectionModelAsMap(
                                      pinnedCollectionModel,
                                    );
                                    await _fetchData();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: l10n.updatedTo(
                                        pinnedCollectionModel.name,
                                      ),
                                    );
                                  },
                                  label: Text(l10n.save),
                                  icon: const Icon(Icons.done),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    const Icon(FluentIcons.edit_24_regular),
                    const Gap(8),
                    Text(l10n.changeName),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  Color selectedColor = await showColorPickerDialog(
                    context,
                    safeParseColor(pinnedCollectionModel.colorHex),
                  );
                  pinnedCollectionModel.colorHex = selectedColor.hex;
                  await savePinnedCollectionModelAsMap(pinnedCollectionModel);
                  await _fetchData();
                  Fluttertoast.showToast(msg: l10n.colorUpdated);
                },
                child: Row(
                  children: [
                    const Icon(FluentIcons.color_24_regular),
                    const Gap(8),
                    Text(l10n.changeColor),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  await deleteNoteCollectionByID(pinnedCollectionModel.id);
                  await _fetchData();

                  Fluttertoast.showToast(
                    msg: l10n.collectionDeleted(pinnedCollectionModel.name),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.red,
                    ),
                    const Gap(8),
                    Text(
                      l10n.delete,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CollectionContentView(
                    pinnedCollectionModel: pinnedCollectionModel,
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget _getNoteCollectionWidget(
    NoteCollectionModel noteCollectionModel,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Icon(
          FluentIcons.folder_24_filled,
          size: 45,
          color: safeParseColor(
            noteCollectionModel.colorHex,
            defaultColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          noteCollectionModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(l10n.notesCount(noteCollectionModel.notes.length)),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  TextEditingController nameController = TextEditingController(
                    text: noteCollectionModel.name,
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                autofocus: true,
                              ),
                              const Gap(15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (nameController.text.trim().isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: l10n.emptyNameNotAllowed,
                                      );
                                      return;
                                    }
                                    noteCollectionModel.name =
                                        nameController.text.trim();

                                    await saveNoteCollectionModelAsMap(
                                      noteCollectionModel,
                                    );
                                    await _fetchData();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: l10n.updatedTo(
                                        noteCollectionModel.name,
                                      ),
                                    );
                                  },
                                  label: Text(l10n.save),
                                  icon: const Icon(Icons.done),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    const Icon(FluentIcons.edit_24_regular),
                    const Gap(8),
                    Text(l10n.changeName),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  Color selectedColor = await showColorPickerDialog(
                    context,
                    safeParseColor(noteCollectionModel.colorHex),
                  );
                  noteCollectionModel.colorHex = selectedColor.hex;
                  await saveNoteCollectionModelAsMap(noteCollectionModel);
                  await _fetchData();
                  Fluttertoast.showToast(msg: l10n.colorUpdated);
                },
                child: Row(
                  children: [
                    const Icon(FluentIcons.color_24_regular),
                    const Gap(8),
                    Text(l10n.changeColor),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  await deleteNoteCollectionByID(noteCollectionModel.id);
                  await _fetchData();

                  Fluttertoast.showToast(
                    msg: l10n.collectionDeleted(noteCollectionModel.name),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      FluentIcons.delete_24_regular,
                      color: Colors.red,
                    ),
                    const Gap(8),
                    Text(
                      l10n.delete,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => CollectionContentView(
                    noteCollectionModel: noteCollectionModel,
                  ),
            ),
          );
        },
      ),
    );
  }
}

enum CollectionType { pinned, notes }
