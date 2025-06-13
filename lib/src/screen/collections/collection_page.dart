import "package:al_quran_v3/src/screen/collections/collection_content_view.dart";
import "package:al_quran_v3/src/screen/collections/common_function.dart";
import "package:al_quran_v3/src/screen/collections/models/note_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart"; // Assuming roundedRadius is here
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";

class CollectionPage extends StatefulWidget {
  final CollectionType collectionType;
  const CollectionPage({super.key, required this.collectionType});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  TextEditingController _searchTextFieldController = TextEditingController();
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
        _errorMessage = "Failed to load collections: ${e.toString()}";
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

  Color _safeParseColor(String? hexColor, {Color defaultColor = Colors.grey}) {
    if (hexColor == null || hexColor.isEmpty) return defaultColor;
    try {
      return Color(int.parse("0xFF$hexColor"));
    } catch (e) {
      // Log error or handle
      return defaultColor;
    }
  }

  Widget _buildSearchAndFilterBar(Color svgColor) {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // Use theme surface color for better adaptability
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(
                  roundedRadius,
                ), // Consistent radius
              ),
              child: TextFormField(
                controller: _searchTextFieldController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(FluentIcons.search_24_regular),
                  hintText:
                      "Search By ${widget.collectionType.name.capitalize()} Name...",
                ),
              ),
            ),
          ),
          const Gap(10),
          SizedBox(
            width: 50, // Adjusted for better tapability
            height: 45,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
              ),
              onPressed: () {
                // TODO: Implement filter options dialog
              },
              icon: SvgPicture.asset(
                "assets/img/adjust-horizontal-settings-svgrepo-com.svg",
                height: 23,
                width: 23,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color ?? svgColor,
                  BlendMode.srcIn,
                ),
              ),
              tooltip: "Filter",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Color svgColor) {
    return Center(
      // Ensure the empty state is centered
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/img/empty-folder-svgrepo-com.svg", // Consider a more relevant empty state image
              height: 100, // Slightly larger image
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color?.withValues(alpha: 0.6) ??
                    svgColor.withValues(alpha: 0.6),
                BlendMode.srcIn,
              ),
            ),
            const Gap(20),
            Text(
              "No ${widget.collectionType.name} added yet",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            // Text(
            //   "Tap below to create your first ${widget.collectionType.name.toLowerCase()} collection.",
            //   style: Theme.of(context).textTheme.bodySmall,
            //   textAlign: TextAlign.center,
            // ),
            // const Gap(20),
            // ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //     // Use theme primary color
            //     backgroundColor: Theme.of(context).colorScheme.primary,
            //     foregroundColor: Theme.of(context).colorScheme.onPrimary,
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 20,
            //       vertical: 12,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(roundedRadius),
            //     ),
            //   ),
            //   onPressed: () {
            //     // TODO: Implement add new collection functionality (e.g., show dialog)
            //     // For example, if you have a function `_showAddCollectionDialog()`
            //     // _showAddCollectionDialog();
            //   },
            //   icon: const Icon(FluentIcons.add_24_regular),
            //   label: const Text("Add New Collection"),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.collectionType.name.capitalize()),
        actions: [
          IconButton(
            onPressed: _fetchData, // Refresh data
            icon: const Icon(FluentIcons.arrow_sync_24_regular),
            tooltip: "Refresh",
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilterBar(svgColor),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
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
                            )
                            : _getPinnedCollectionWidget(
                              _filteredPinnedCollection[index],
                            );
                      },
                    )
                    : _buildEmptyState(svgColor),
          ),
        ],
      ),
    );
  }

  Widget _getPinnedCollectionWidget(
    PinnedCollectionModel pinnedCollectionModel,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(
          FluentIcons.pin_24_filled,
          color: _safeParseColor(
            pinnedCollectionModel.colorHex,
            defaultColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          pinnedCollectionModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          "${pinnedCollectionModel.pinned.length} pinned items",
        ), // Clarified subtitle
        trailing: IconButton(
          icon: const Icon(
            FluentIcons.edit_24_regular,
            color: Colors.grey,
          ), // Regular for edit action
          onPressed: () {
            // TODO: Implement edit functionality for pinned collection
          },
          tooltip: "Edit Collection",
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

  Widget _getNoteCollectionWidget(NoteCollectionModel noteCollectionModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(
          FluentIcons.folder_24_regular, // Consistent icon family
          color: _safeParseColor(
            noteCollectionModel.colorHex,
            defaultColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          noteCollectionModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text("${noteCollectionModel.notes.length} notes"),
        // trailing: IconButton(
        //   icon: const Icon(FluentIcons.edit_24_regular, color: Colors.grey),
        //   onPressed: () {
        //     // TODO: Implement edit functionality for note collection
        //   },
        //   tooltip: "Edit Collection",
        // ),
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
