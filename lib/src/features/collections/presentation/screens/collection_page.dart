import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
export "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart" show CollectionType;
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/sorting_methods_type.dart";
import "package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart";
import "package:al_quran_v3/src/features/collections/presentation/helpers/collection_ui_helpers.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_content_view.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:dartx/dartx.dart";
import "package:flex_color_picker/flex_color_picker.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class CollectionPage extends StatefulWidget {
  final CollectionType collectionType;

  const CollectionPage({super.key, required this.collectionType});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late CollectionType _selectedCollectionType;
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
    _selectedCollectionType = widget.collectionType;
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
      if (_selectedCollectionType == CollectionType.notes) {
        _listOfNoteCollection =
            await getIt<CollectionsRepository>().fetchNoteCollections();
        _filteredNoteCollection = List.from(_listOfNoteCollection);
      } else {
        _listOfPinnedCollection =
            await getIt<CollectionsRepository>().fetchPinnedCollections();
        _filteredPinnedCollection = List.from(_listOfPinnedCollection);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = l10n.failedToLoadCollections(e.toString());
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _filterCollections() {
    final query = _searchTextFieldController.text.toLowerCase();
    setState(() {
      if (_selectedCollectionType == CollectionType.notes) {
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

  Widget _buildSegmentedHeader(AppLocalizations l10n) {
    final themeState = context.read<ThemeCubit>().state;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_selectedCollectionType != CollectionType.notes) {
                  setState(() {
                    _selectedCollectionType = CollectionType.notes;
                  });
                  _fetchData();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      _selectedCollectionType == CollectionType.notes
                          ? themeState.primary
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:
                      _selectedCollectionType == CollectionType.notes
                          ? [
                            BoxShadow(
                              color: themeState.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                          : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.note_24_filled,
                      size: 18,
                      color:
                          _selectedCollectionType == CollectionType.notes
                              ? Colors.white
                              : colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text(
                      l10n.notes,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color:
                            _selectedCollectionType == CollectionType.notes
                                ? Colors.white
                                : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_selectedCollectionType != CollectionType.pinned) {
                  setState(() {
                    _selectedCollectionType = CollectionType.pinned;
                  });
                  _fetchData();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      _selectedCollectionType == CollectionType.pinned
                          ? themeState.primary
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:
                      _selectedCollectionType == CollectionType.pinned
                          ? [
                            BoxShadow(
                              color: themeState.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                          : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.pin_24_filled,
                      size: 18,
                      color:
                          _selectedCollectionType == CollectionType.pinned
                              ? Colors.white
                              : colorScheme.onSurfaceVariant,
                    ),
                    const Gap(8),
                    Text(
                      l10n.pinned,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color:
                            _selectedCollectionType == CollectionType.pinned
                                ? Colors.white
                                : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar(Color svgColor, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              child: TextFormField(
                controller: _searchTextFieldController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    FluentIcons.search_24_regular,
                    color: colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  hintText: l10n.searchByCollectionName(
                    StringCapitalizeExtension(
                      _selectedCollectionType.name,
                    ).capitalize(),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const Gap(10),
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
              ),
              icon: SvgPicture.asset(
                "assets/img/adjust-horizontal-settings-svgrepo-com.svg",
                height: 20,
                width: 20,
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
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              const Icon(
                                FluentIcons.arrow_sort_24_filled,
                                size: 20,
                              ),
                              const Gap(10),
                              Text(
                                l10n.sortBy,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Flexible(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: SortingMethodsType.values.length,
                              separatorBuilder:
                                  (context, index) => const Gap(4),
                              itemBuilder: (context, index) {
                                SortingMethodsType current =
                                    SortingMethodsType.values[index];
                                final isSelected = current.name == sortMethod;
                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  tileColor:
                                      isSelected
                                          ? colorScheme.primaryContainer
                                              .withValues(alpha: 0.4)
                                          : null,
                                  onTap: () async {
                                    await Hive.box("user").put(
                                      "selected_sorting_method",
                                      current.name,
                                    );
                                    await _fetchData();
                                    Navigator.pop(context);
                                  },
                                  leading: Icon(
                                    isSelected
                                        ? Icons.radio_button_on
                                        : Icons.radio_button_off,
                                    color:
                                        isSelected
                                            ? context
                                                .read<ThemeCubit>()
                                                .state
                                                .primary
                                            : colorScheme.onSurfaceVariant,
                                  ),
                                  title: Text(
                                    current.toReadableString(l10n),
                                    style: TextStyle(
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/img/empty-folder-svgrepo-com.svg",
                height: 80,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color?.withValues(alpha: 0.5) ??
                      svgColor.withValues(alpha: 0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(20),
            Text(
              l10n.noCollectionAddedYet(_selectedCollectionType.name),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.9, 0.9)),
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
        Theme.brightnessOf(context) == Brightness.dark
            ? Colors.grey.shade100
            : Colors.grey.shade900;

    final bool isNotes = _selectedCollectionType == CollectionType.notes;
    final bool hasItems =
        isNotes
            ? _filteredNoteCollection.isNotEmpty
            : _filteredPinnedCollection.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringCapitalizeExtension(
            _selectedCollectionType.name == "notes" ? l10n.notes : l10n.pinned,
          ).capitalize(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _buildSegmentedHeader(l10n),
          _buildSearchAndFilterBar(svgColor, l10n),
          const Gap(6),
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
                        horizontal: 14.0,
                        vertical: 6.0,
                      ),
                      itemCount:
                          isNotes
                              ? _filteredNoteCollection.length
                              : _filteredPinnedCollection.length,
                      itemBuilder: (BuildContext context, int index) {
                        final widgetItem =
                            isNotes
                                ? _getNoteCollectionWidget(
                                  _filteredNoteCollection[index],
                                  l10n,
                                )
                                : _getPinnedCollectionWidget(
                                  _filteredPinnedCollection[index],
                                  l10n,
                                );
                        return widgetItem
                            .animate(delay: (index * 40).ms)
                            .fadeIn(duration: 250.ms)
                            .slideY(begin: 0.08, end: 0);
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
    final colorScheme = Theme.of(context).colorScheme;
    final folderColor = safeParseColor(pinnedCollectionModel.colorHex);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: folderColor, width: 5)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: folderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                FluentIcons.pin_24_filled,
                color: folderColor,
                size: 22,
              ),
            ),
            title: Text(
              pinnedCollectionModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: folderColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l10n.pinnedItemsCount(pinnedCollectionModel.pinned.length),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: folderColor,
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  formatRelativeDate(pinnedCollectionModel.updatedAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      TextEditingController nameController =
                          TextEditingController(
                            text: pinnedCollectionModel.name,
                          );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    l10n.changeName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(14),
                                  TextFormField(
                                    controller: nameController,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const Gap(18),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 44,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (nameController.text
                                            .trim()
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: l10n.emptyNameNotAllowed,
                                          );
                                          return;
                                        }
                                        final updatedPinnedCollection =
                                            pinnedCollectionModel.copyWith(
                                              name: nameController.text.trim(),
                                            );

                                        await getIt<CollectionsRepository>()
                                            .savePinnedCollectionModelAsMap(
                                              updatedPinnedCollection,
                                            );
                                        await _fetchData();
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: l10n.updatedTo(
                                            updatedPinnedCollection.name,
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
                        const Icon(FluentIcons.edit_24_regular, size: 18),
                        const Gap(10),
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
                      final updatedPinnedCollection = pinnedCollectionModel
                          .copyWith(colorHex: selectedColor.hex);
                      await getIt<CollectionsRepository>()
                          .savePinnedCollectionModelAsMap(
                            updatedPinnedCollection,
                          );
                      await _fetchData();
                      Fluttertoast.showToast(msg: l10n.colorUpdated);
                    },
                    child: Row(
                      children: [
                        const Icon(FluentIcons.color_24_regular, size: 18),
                        const Gap(10),
                        Text(l10n.changeColor),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () async {
                      await getIt<CollectionsRepository>()
                          .deletePinnedCollectionByID(
                            pinnedCollectionModel.id,
                          );
                      await _fetchData();

                      Fluttertoast.showToast(
                        msg: l10n.collectionDeleted(
                          pinnedCollectionModel.name,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FluentIcons.delete_24_regular,
                          color: Colors.red,
                          size: 18,
                        ),
                        const Gap(10),
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
        ),
      ),
    );
  }

  Widget _getNoteCollectionWidget(
    NoteCollectionModel noteCollectionModel,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final folderColor = safeParseColor(noteCollectionModel.colorHex);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: folderColor, width: 5)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: folderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                FluentIcons.folder_24_filled,
                color: folderColor,
                size: 22,
              ),
            ),
            title: Text(
              noteCollectionModel.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: folderColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l10n.notesCount(noteCollectionModel.notes.length),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: folderColor,
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  formatRelativeDate(noteCollectionModel.updatedAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      TextEditingController nameController =
                          TextEditingController(text: noteCollectionModel.name);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    l10n.changeName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(14),
                                  TextFormField(
                                    controller: nameController,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const Gap(18),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 44,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (nameController.text
                                            .trim()
                                            .isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: l10n.emptyNameNotAllowed,
                                          );
                                          return;
                                        }
                                        final updatedNoteCollection =
                                            noteCollectionModel.copyWith(
                                              name: nameController.text.trim(),
                                            );

                                        await getIt<CollectionsRepository>()
                                            .saveNoteCollectionModelAsMap(
                                              updatedNoteCollection,
                                            );
                                        await _fetchData();
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: l10n.updatedTo(
                                            updatedNoteCollection.name,
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
                        const Icon(FluentIcons.edit_24_regular, size: 18),
                        const Gap(10),
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
                      final updatedNoteCollection = noteCollectionModel
                          .copyWith(colorHex: selectedColor.hex);
                      await getIt<CollectionsRepository>()
                          .saveNoteCollectionModelAsMap(updatedNoteCollection);
                      await _fetchData();
                      Fluttertoast.showToast(msg: l10n.colorUpdated);
                    },
                    child: Row(
                      children: [
                        const Icon(FluentIcons.color_24_regular, size: 18),
                        const Gap(10),
                        Text(l10n.changeColor),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () async {
                      await getIt<CollectionsRepository>()
                          .deleteNoteCollectionByID(noteCollectionModel.id);
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
                          size: 18,
                        ),
                        const Gap(10),
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
        ),
      ),
    );
  }
}
