import "package:al_quran_v3/src/screen/collections/common_function.dart";
import "package:al_quran_v3/src/screen/collections/models/note_collection_model.dart";
import "package:al_quran_v3/src/screen/collections/models/pinned_collection_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
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
  TextEditingController searchTextFieldController = TextEditingController();
  List<NoteCollectionModel> listOfNoteCollection = [];
  List<PinnedCollectionModel> listOfPinnedCollection = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    listOfNoteCollection = await fetchNoteCollections();
    listOfPinnedCollection = await fetchPinnedCollections();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Color svgColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade100
            : Colors.grey.shade900;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.collectionType.name.capitalize()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.arrow_sync_24_regular),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: SizedBox(
          //     height: 25,
          //     width: 25,
          //     child: SvgPicture.asset(
          //       "assets/img/login-2-svgrepo-com.svg",
          //       colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ((listOfPinnedCollection.isNotEmpty &&
                  widget.collectionType == CollectionType.pinned) ||
              (listOfNoteCollection.isNotEmpty &&
                  widget.collectionType == CollectionType.notes))
            Container(
              height: 45,
              margin: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryShade100,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextFormField(
                        controller: searchTextFieldController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(FluentIcons.search_24_regular),
                          hintText:
                              "Search By ${widget.collectionType.name} Name...",
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 60,
                    height: 45,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primaryShade100,
                      ),
                      onPressed: () {},
                      icon: SizedBox(
                        height: 23,
                        width: 23,
                        child: SvgPicture.asset(
                          "assets/img/adjust-horizontal-settings-svgrepo-com.svg",
                          colorFilter: ColorFilter.mode(
                            svgColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (listOfPinnedCollection.isNotEmpty &&
              widget.collectionType == CollectionType.pinned)
            Expanded(
              child: ListView.builder(
                itemCount: listOfPinnedCollection.length,
                itemBuilder: (BuildContext context, int index) {
                  return getPinnedCollectionWidget(
                    listOfPinnedCollection[index],
                  );
                },
              ),
            ),

          if (listOfNoteCollection.isNotEmpty &&
              widget.collectionType == CollectionType.notes)
            Expanded(
              child: ListView.builder(
                itemCount: listOfNoteCollection.length,
                itemBuilder: (BuildContext context, int index) {
                  return getNoteCollectionWidget(listOfNoteCollection[index]);
                },
              ),
            ),

          if ((listOfPinnedCollection.isEmpty &&
                  widget.collectionType == CollectionType.pinned) ||
              (listOfNoteCollection.isEmpty &&
                  widget.collectionType == CollectionType.notes))
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/img/empty-folder-svgrepo-com.svg",
                    colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
                  ),
                  const Gap(10),
                  Text(
                    "No ${widget.collectionType.name} added yet",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(10),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                    ),
                    onPressed: () {},
                    icon: const Icon(FluentIcons.add_24_regular),
                    label: const Text("Add New Topic"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget getPinnedCollectionWidget(
    PinnedCollectionModel pinnedCollectionModel,
  ) {
    return ListTile(
      minTileHeight: 40,
      leading: Icon(
        FluentIcons.pin_24_filled,
        color: Color(int.parse("0xFF${pinnedCollectionModel.colorHex}")),
      ),
      title: Text(pinnedCollectionModel.name),
      subtitle: Text("${pinnedCollectionModel.pinned.length} pinned"),
      trailing: IconButton(
        icon: IconButton(
          onPressed: () {},
          icon: const Icon(FluentIcons.edit_24_filled, color: Colors.grey),
        ),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }

  Widget getNoteCollectionWidget(NoteCollectionModel noteCollectionModel) {
    return ListTile(
      minTileHeight: 40,
      leading: Icon(
        Icons.folder_rounded,
        color: Color(int.parse("0xFF${noteCollectionModel.colorHex}")),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(FluentIcons.edit_24_filled, color: Colors.grey),
      ),
      title: Text(noteCollectionModel.name),
      subtitle: Text("${noteCollectionModel.notes.length} notes"),
      onTap: () {},
    );
  }
}

enum CollectionType { pinned, notes }
