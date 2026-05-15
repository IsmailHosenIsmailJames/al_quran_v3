import 'dart:developer' as developer;
import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/api/bookmark_sync_service.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart';
import 'package:al_quran_v3/src/core/bookmark/cubit/bookmark_cubit.dart';
import 'package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart';
import 'package:al_quran_v3/src/screen/collections/models/bookmark_model.dart';
import 'package:al_quran_v3/src/screen/collections/models/sorting_methods_type.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/theme/controller/theme_state.dart';
import 'package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart';
import 'package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final TextEditingController _searchController = TextEditingController();
  SortingMethodsType _sortingMethod = SortingMethodsType.byCreateDateDescending;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BookmarkModel> _getFilteredAndSortedBookmarks(List<BookmarkModel> bookmarks) {
    final query = _searchController.text.toLowerCase();
    
    // Filter out deleted and apply search
    var filtered = bookmarks.where((b) {
      if (b.isDeleted) return false;
      if (query.isEmpty) return true;
      
      final surahName = getSurahName(context, b.surahNumber).toLowerCase();
      final verseKey = b.verseKey.toLowerCase();
      return surahName.contains(query) || verseKey.contains(query);
    }).toList();

    // Sort
    switch (_sortingMethod) {
      case SortingMethodsType.byCreateDateDescending:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case SortingMethodsType.byCreateDateAscending:
        filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case SortingMethodsType.byNameAtoZ:
        filtered.sort((a, b) {
          final nameA = getSurahName(context, a.surahNumber);
          final nameB = getSurahName(context, b.surahNumber);
          int res = nameA.compareTo(nameB);
          if (res == 0) return a.ayahNumber.compareTo(b.ayahNumber);
          return res;
        });
      case SortingMethodsType.byNameZtoA:
        filtered.sort((a, b) {
          final nameA = getSurahName(context, a.surahNumber);
          final nameB = getSurahName(context, b.surahNumber);
          int res = nameB.compareTo(nameA);
          if (res == 0) return b.ayahNumber.compareTo(a.ayahNumber);
          return res;
        });
      default:
        // Default to newest first
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    return filtered;
  }

  Future<void> _handleSync() async {
    if (_isSyncing) return;
    setState(() => _isSyncing = true);
    try {
      await BookmarkSyncService.fullSync();
      context.read<BookmarkCubit>().loadBookmarks();
      Fluttertoast.showToast(msg: 'Bookmarks synced successfully');
    } on QuranApiException catch (e) {
      if (mounted) _showErrorDialog(e.message);
    } catch (e) {
      if (mounted) _showErrorDialog(e.toString());
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sync Error'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        actions: [
          if (_isSyncing)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(FluentIcons.arrow_sync_24_regular),
              onPressed: _handleSync,
              tooltip: 'Sync with cloud',
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search bookmarks...',
                      prefixIcon: const Icon(FluentIcons.search_24_regular),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: themeState.primaryShade100.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                const Gap(8),
                PopupMenuButton<SortingMethodsType>(
                  icon: const Icon(FluentIcons.filter_24_regular),
                  onSelected: (method) => setState(() => _sortingMethod = method),
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: SortingMethodsType.byCreateDateDescending,
                      child: Text(l10n.byCreateDateDescending),
                    ),
                    PopupMenuItem(
                      value: SortingMethodsType.byCreateDateAscending,
                      child: Text(l10n.byCreateDateAscending),
                    ),
                    PopupMenuItem(
                      value: SortingMethodsType.byNameAtoZ,
                      child: Text(l10n.byNameAtoZ),
                    ),
                    PopupMenuItem(
                      value: SortingMethodsType.byNameZtoA,
                      child: Text(l10n.byNameZtoA),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BookmarkCubit, BookmarkState>(
              builder: (context, state) {
                final filtered = _getFilteredAndSortedBookmarks(state.bookmarks);

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FluentIcons.bookmark_24_regular,
                          size: 64,
                          color: themeState.primaryShade300,
                        ),
                        const Gap(16),
                        Text(
                          _searchController.text.isEmpty
                              ? 'No bookmarks yet'
                              : 'No matches found',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (ctx, index) {
                    final bookmark = filtered[index];
                    final TranslationWithWordByWord? translationData =
                        getTranslationFromCache(bookmark.verseKey);

                    return translationData != null
                        ? getAyahByAyahCard(
                            ayahKey: bookmark.verseKey,
                            context: ctx,
                            showFullKey: true,
                            translationListWithInfo: translationData.translationList,
                            wordByWord: translationData.wordByWord ?? [],
                          )
                        : FutureBuilder(
                            future: getTranslationWithWordByWord(bookmark.verseKey),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return const SizedBox(height: 150);
                              }
                              return getAyahByAyahCard(
                                ayahKey: bookmark.verseKey,
                                context: ctx,
                                showFullKey: true,
                                translationListWithInfo: snapshot.data?.translationList ?? [],
                                wordByWord: snapshot.data?.wordByWord ?? [],
                              );
                            },
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
}
