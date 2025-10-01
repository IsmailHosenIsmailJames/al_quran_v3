import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

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
      appBar: AppBar(title: Text(l10n.ayahCount(widget.ayahsKey.length))),
      body: ListView.builder(
        itemCount: widget.ayahsKey.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: QuranTranslationFunction.getTranslation(
              widget.ayahsKey[index],
            ),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState != ConnectionState.done) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: getAyahByAyahCard(
                    ayahKey: widget.ayahsKey[index],
                    context: context,
                    showFullKey: true,
                    translationMap: const {},
                  ),
                );
              }
              return getAyahByAyahCard(
                ayahKey: widget.ayahsKey[index],
                context: context,
                showFullKey: true,
                translationMap: asyncSnapshot.data ?? {},
              );
            },
          );
        },
      ),
    );
  }
}
