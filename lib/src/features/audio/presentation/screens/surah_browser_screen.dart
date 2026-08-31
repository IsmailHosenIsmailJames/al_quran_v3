import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/change_reciter.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/surah_audio_card.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class SurahBrowserScreen extends StatefulWidget {
  const SurahBrowserScreen({super.key});

  @override
  State<SurahBrowserScreen> createState() => _SurahBrowserScreenState();
}

class _SurahBrowserScreenState extends State<SurahBrowserScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SurahInfoModel> _allSurahs = [];
  List<SurahInfoModel> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _loadSurahs();
  }

  void _loadSurahs() {
    if (metaDataSurah.isNotEmpty) {
      _allSurahs = metaDataSurah.entries
          .map((e) => SurahInfoModel.fromMap(e.value))
          .toList()
        ..sort((a, b) => a.id.compareTo(b.id));
      _filteredSurahs = List.from(_allSurahs);
    }
  }

  void _onSearchChanged(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() {
        _filteredSurahs = List.from(_allSurahs);
      });
      return;
    }

    setState(() {
      _filteredSurahs = _allSurahs.where((surah) {
        final idStr = surah.id.toString();
        if (idStr == q) return true;

        final surahName = getSurahName(context, surah.id).toLowerCase();
        final arabicName = getSurahNameArabic(surah.id);
        final meaning = getSurahMeaning(context, surah.id).toLowerCase();

        return idStr.contains(q) ||
            surahName.contains(q) ||
            arabicName.contains(q) ||
            meaning.contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final activeReciter = context.watch<AudioTabReciterCubit>().state;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 700;

    if (_allSurahs.isEmpty) {
      _loadSurahs();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Surahs",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Active Reciter Badge / Switcher
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ActionChip(
              avatar: const Icon(
                FluentIcons.person_voice_20_regular,
                size: 16,
              ),
              label: Text(
                activeReciter.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeReciter(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(roundedRadius),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.grey.shade300,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Search by Surah name, number, or meaning...",
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    FluentIcons.search_20_regular,
                    size: 20,
                    color: themeState.primary,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged("");
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Surahs List / Grid
          Expanded(
            child: _filteredSurahs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FluentIcons.book_question_mark_24_regular,
                          size: 48,
                          color: isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                        const Gap(12),
                        Text(
                          "No Surahs found",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : isTablet
                    ? GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _filteredSurahs.length,
                        itemBuilder: (context, index) {
                          return SurahAudioCard(
                            surah: _filteredSurahs[index],
                            margin: EdgeInsets.zero,
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: _filteredSurahs.length,
                        itemBuilder: (context, index) {
                          return SurahAudioCard(
                            surah: _filteredSurahs[index],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
