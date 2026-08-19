import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Shows a comprehensive jump dialog / bottom sheet for Page, Surah, or Juz selection.
Future<void> showMushafJumpModal({
  required BuildContext context,
  required int currentPage,
  required ValueChanged<int> onPageSelected,
}) async {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final isLargeScreen = width >= 600;

  if (isLargeScreen) {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 540,
              maxHeight: height * 0.85,
            ),
            child: _MushafJumpModalContent(
              currentPage: currentPage,
              onPageSelected: onPageSelected,
            ),
          ),
        );
      },
    );
  } else {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: height * 0.82,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          clipBehavior: Clip.antiAlias,
          child: _MushafJumpModalContent(
            currentPage: currentPage,
            onPageSelected: onPageSelected,
          ),
        );
      },
    );
  }
}

class _MushafJumpModalContent extends StatefulWidget {
  final int currentPage;
  final ValueChanged<int> onPageSelected;

  const _MushafJumpModalContent({
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  State<_MushafJumpModalContent> createState() => _MushafJumpModalContentState();
}

class _MushafJumpModalContentState extends State<_MushafJumpModalContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _pageInputController = TextEditingController();
  final TextEditingController _surahSearchController = TextEditingController();

  List<MushafSurahItem> _allSurahs = [];
  List<MushafSurahItem> _filteredSurahs = [];
  List<MushafJuzItem> _allJuzs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _allSurahs = MushafPageHelper.getAllSurahs();
    _filteredSurahs = _allSurahs;
    _allJuzs = MushafPageHelper.getAllJuzs();

    _pageInputController.text = widget.currentPage.toString();

    _surahSearchController.addListener(() {
      final query = _surahSearchController.text.trim().toLowerCase();
      setState(() {
        if (query.isEmpty) {
          _filteredSurahs = _allSurahs;
        } else {
          _filteredSurahs = _allSurahs.where((s) {
            final matchEng = s.englishName.toLowerCase().contains(query);
            final matchAr = s.arabicName.contains(query);
            final matchNum = s.surahNumber.toString() == query;
            return matchEng || matchAr || matchNum;
          }).toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageInputController.dispose();
    _surahSearchController.dispose();
    super.dispose();
  }

  void _selectAndClose(int page) {
    if (page < 1 || page > MushafPageHelper.totalPages) return;
    widget.onPageSelected(page);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        title: Text(
          l10n.goToPage,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(FluentIcons.dismiss_24_regular),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: themeState.primary,
          indicatorWeight: 3,
          labelColor: themeState.primary,
          unselectedLabelColor:
              isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: [
            Tab(
              icon: const Icon(FluentIcons.book_open_24_regular, size: 20),
              text: l10n.page,
            ),
            Tab(
              icon: const Icon(FluentIcons.document_bullet_list_24_regular,
                  size: 20),
              text: l10n.surah,
            ),
            Tab(
              icon: const Icon(FluentIcons.bookmark_24_regular, size: 20),
              text: l10n.juz,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPageTab(themeState, isDark, l10n),
          _buildSurahTab(themeState, isDark, l10n),
          _buildJuzTab(themeState, isDark, l10n),
        ],
      ),
    );
  }

  Widget _buildPageTab(dynamic themeState, bool isDark, AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.enterPageNumber,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.subtract_circle_24_regular),
                  color: themeState.primary,
                  onPressed: () {
                    final curr = int.tryParse(_pageInputController.text) ?? 1;
                    if (curr > 1) {
                      _pageInputController.text = (curr - 1).toString();
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _pageInputController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "1 - 604",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(FluentIcons.add_circle_24_regular),
                  color: themeState.primary,
                  onPressed: () {
                    final curr = int.tryParse(_pageInputController.text) ?? 1;
                    if (curr < MushafPageHelper.totalPages) {
                      _pageInputController.text = (curr + 1).toString();
                    }
                  },
                ),
              ],
            ),
          ),
          const Gap(16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              final page = int.tryParse(_pageInputController.text);
              if (page != null &&
                  page >= 1 &&
                  page <= MushafPageHelper.totalPages) {
                _selectAndClose(page);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.invalidPage),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Text(
              l10n.goToPage,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(24),
          Text(
            l10n.quickPageJump,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _quickPageChip(1, "${l10n.page} 1 (Al-Fatihah)", themeState, isDark),
              _quickPageChip(2, "${l10n.page} 2 (Al-Baqarah)", themeState, isDark),
              _quickPageChip(293, "${l10n.page} 293 (Al-Kahf)", themeState, isDark),
              _quickPageChip(440, "${l10n.page} 440 (Ya-Sin)", themeState, isDark),
              _quickPageChip(582, "${l10n.page} 582 (${l10n.juz} 30)", themeState, isDark),
              _quickPageChip(604, "${l10n.page} 604 (An-Nas)", themeState, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickPageChip(
      int page, String label, dynamic themeState, bool isDark) {
    return ActionChip(
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
      ),
      backgroundColor: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.grey.shade100,
      side: BorderSide(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.grey.shade300,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () => _selectAndClose(page),
    );
  }

  Widget _buildSurahTab(
      dynamic themeState, bool isDark, AppLocalizations l10n) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _surahSearchController,
            decoration: InputDecoration(
              hintText: l10n.searchSurahHint,
              prefixIcon: const Icon(FluentIcons.search_24_regular, size: 20),
              suffixIcon: _surahSearchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(FluentIcons.dismiss_circle_24_regular,
                          size: 18),
                      onPressed: () => _surahSearchController.clear(),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            itemCount: _filteredSurahs.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final surah = _filteredSurahs[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: themeState.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    surah.surahNumber.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeState.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
                title: Text(
                  surah.englishName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
                subtitle: Text(
                  "${surah.revelationType == 'makkah' ? l10n.makki : l10n.madani} • ${surah.versesCount} ${l10n.verses} • ${l10n.page} ${surah.startPage}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                trailing: Text(
                  surah.arabicName,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
                onTap: () => _selectAndClose(surah.startPage),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJuzTab(dynamic themeState, bool isDark, AppLocalizations l10n) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: _allJuzs.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final juz = _allJuzs[index];
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              juz.juzNumber.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeState.primary,
                fontSize: 13,
              ),
            ),
          ),
          title: Text(
            "${l10n.juz} ${juz.juzNumber}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
          ),
          subtitle: Text(
            "${juz.startSurahName} • ${l10n.verses} ${juz.firstVerseKey} - ${juz.lastVerseKey}",
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              "${l10n.page} ${juz.startPage}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: themeState.primary,
              ),
            ),
          ),
          onTap: () => _selectAndClose(juz.startPage),
        );
      },
    );
  }
}
