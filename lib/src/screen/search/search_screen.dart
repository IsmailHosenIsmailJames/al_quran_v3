import "dart:async";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/api/quran_search_api.dart";
import "package:al_quran_v3/src/api/quran_notes_api.dart"; // For QuranApiException
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _searchResults;
  String? _error;

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _searchResults = null;
      _error = null;
    });

    try {
      final results = await QuranSearchApi.search(query: query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } on QuranApiException catch (e) {
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "An unexpected error occurred: $e";
        _isLoading = false;
      });
    }
  }

  void _navigateToResult(dynamic item) {
    final type = item['result_type'];
    final key = item['key'].toString();

    if (type == 'surah') {
      final surahNumber = key;
      final totalAyah = metaDataSurah[surahNumber]!['vc'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuranScriptView(
            startKey: "$surahNumber:1",
            endKey: "$surahNumber:$totalAyah",
          ),
        ),
      );
    } else if (type == 'ayah') {
      final parts = key.split(':');
      final surahNumber = parts[0];
      final totalAyah = metaDataSurah[surahNumber]!['vc'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuranScriptView(
            startKey: "$surahNumber:1",
            endKey: "$surahNumber:$totalAyah",
            toScrollKey: key,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.read<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.search)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              controller: _textController,
              hintText: l10n.searchHint,
              onSubmitted: _performSearch,
              leading: const Icon(FluentIcons.search_24_regular),
              trailing: [
                if (_textController.text.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _searchResults = null;
                      });
                    },
                    icon: const Icon(FluentIcons.dismiss_24_regular),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator())),
          if (_error != null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          if (_searchResults != null)
            Expanded(child: _buildResultsList(themeState)),
        ],
      ),
    );
  }

  Widget _buildResultsList(ThemeState themeState) {
    final result = _searchResults!['result'];
    final navigation = result['navigation'] as List? ?? [];
    final verses = result['verses'] as List? ?? [];

    if (navigation.isEmpty && verses.isEmpty) {
      return const Center(child: Text("No results found."));
    }

    return ListView(
      children: [
        if (navigation.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Navigation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: themeState.primary,
              ),
            ),
          ),
          ...navigation.map(
            (item) => ListTile(
              title: Text(item['name']),
              subtitle: Text(item['result_type'].toString().toUpperCase()),
              onTap: () => _navigateToResult(item),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeState.primaryShade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FluentIcons.navigation_24_regular,
                  color: themeState.primary,
                  size: 20,
                ),
              ),
            ),
          ),
          const Divider(),
        ],
        if (verses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Verses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: themeState.primary,
              ),
            ),
          ),
          ...verses.map(
            (item) => ListTile(
              title: Text(
                item['name'],
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text("Ayah ${item['key']}"),
              onTap: () => _navigateToResult(item),
            ),
          ),
        ],
        const Gap(100), // Spacing for bottom
      ],
    );
  }
}
