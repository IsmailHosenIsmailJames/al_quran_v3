import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class DownloadedTranslationsSettings extends StatefulWidget {
  const DownloadedTranslationsSettings({super.key});

  @override
  State<DownloadedTranslationsSettings> createState() =>
      _DownloadedTranslationsSettingsState();
}

class _DownloadedTranslationsSettingsState
    extends State<DownloadedTranslationsSettings> {
  List<ResourcesModel> downloadedTranslations = [];
  List<ResourcesModel> selectedTranslations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final downloaded = QuranTranslationFunction.getDownloadedTranslationBooks();
    final selected =
        await QuranTranslationFunction.getTranslationSelections() ?? [];

    setState(() {
      downloadedTranslations = downloaded;
      selectedTranslations = selected;
    });
  }

  bool _isSelected(ResourcesModel book) {
    return selectedTranslations.any((t) => t.fullPath == book.fullPath);
  }

  Future<void> _toggleSelection(ResourcesModel book, bool? value) async {
    if (value == true) {
      await QuranTranslationFunction.setTranslationSelection(book);
    } else {
      await QuranTranslationFunction.removeTranslationSelection(book);
    }
    _loadData();
  }

  Future<void> _deleteTranslation(ResourcesModel book) async {
    await QuranTranslationFunction.removeFromListAlreadyDownloaded(book);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (downloadedTranslations.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      itemCount: downloadedTranslations.length,
      separatorBuilder: (context, index) => const Gap(6),
      itemBuilder: (context, index) {
        final book = downloadedTranslations[index];
        final isSelected = _isSelected(book);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? themeState.primary.withValues(alpha: isDark ? 0.12 : 0.04)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : Colors.grey.shade50),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? themeState.primary.withValues(alpha: 0.4)
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.grey.shade200),
            ),
          ),
          child: Row(
            children: [
              Checkbox.adaptive(
                value: isSelected,
                activeColor: themeState.primary,
                onChanged: (value) => _toggleSelection(book, value),
              ),
              const Gap(4),
              Expanded(
                child: Text(
                  book.name,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  FluentIcons.delete_20_regular,
                  color: Color(0xFFDC2626),
                  size: 18,
                ),
                onPressed: () => _deleteTranslation(book),
              ),
            ],
          ),
        );
      },
    );
  }
}
