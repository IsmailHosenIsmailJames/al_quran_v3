import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";

class ListOfAyahsViews extends StatefulWidget {
  final List<String> ayahsKey;
  const ListOfAyahsViews({super.key, required this.ayahsKey});

  @override
  State<ListOfAyahsViews> createState() => _ListOfAyahsViewsState();
}

class _ListOfAyahsViewsState extends State<ListOfAyahsViews> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.ayahCount(widget.ayahsKey.length),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: widget.ayahsKey.length,
        itemBuilder: (context, index) {
          final TranslationWithWordByWord? translationData =
              getTranslationFromCache(widget.ayahsKey[index]);
          final Widget card = translationData != null
              ? getAyahByAyahCard(
                ayahKey: widget.ayahsKey[index],
                context: context,
                showFullKey: true,
                translationListWithInfo: translationData.translationList,
                wordByWord: translationData.wordByWord ?? [],
              )
              : FutureBuilder(
                future: getTranslationWithWordByWord(widget.ayahsKey[index]),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState != ConnectionState.done) {
                    return const SizedBox(height: 250);
                  }
                  return getAyahByAyahCard(
                    ayahKey: widget.ayahsKey[index],
                    context: context,
                    showFullKey: true,
                    translationListWithInfo:
                        asyncSnapshot.data?.translationList ?? [],
                    wordByWord: asyncSnapshot.data?.wordByWord ?? [],
                  );
                },
              );

          return card
              .animate(delay: (index * 40).ms)
              .fadeIn(duration: 250.ms)
              .slideY(begin: 0.05, end: 0);
        },
      ),
    );
  }
}
