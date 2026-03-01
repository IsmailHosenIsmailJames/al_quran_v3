import 'package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadedTranslationsSettings extends StatefulWidget {
  const DownloadedTranslationsSettings({super.key});

  @override
  State<DownloadedTranslationsSettings> createState() =>
      _DownloadedTranslationsSettingsState();
}

class _DownloadedTranslationsSettingsState
    extends State<DownloadedTranslationsSettings> {
  List<TranslationBookModel> downloadedTranslations = [];
  List<TranslationBookModel> selectedTranslations = [];

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

  bool _isSelected(TranslationBookModel book) {
    return selectedTranslations.any((t) => t.fullPath == book.fullPath);
  }

  Future<void> _toggleSelection(TranslationBookModel book, bool? value) async {
    if (value == true) {
      await QuranTranslationFunction.setTranslationSelection(book);
    } else {
      await QuranTranslationFunction.removeTranslationSelection(book);
    }
    _loadData();
  }

  Future<void> _deleteTranslation(TranslationBookModel book) async {
    await QuranTranslationFunction.removeFromListAlreadyDownloaded(book);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.watch<ThemeCubit>().state.primary;

    if (downloadedTranslations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: downloadedTranslations.length,
        itemBuilder: (context, index) {
          final book = downloadedTranslations[index];
          final isSelected = _isSelected(book);

          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: primaryColor,
            title: Text(book.name, style: const TextStyle(fontSize: 14)),
            value: isSelected,
            onChanged: (value) => _toggleSelection(book, value),
            secondary: IconButton(
              icon: const Icon(
                FluentIcons.delete_24_regular,
                color: Colors.red,
              ),
              onPressed: () => _deleteTranslation(book),
            ),
          );
        },
      ),
    );
  }
}
