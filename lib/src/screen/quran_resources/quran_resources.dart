import "package:al_quran_v3/src/screen/quran_resources/tafsir_resources.dart";
import "package:al_quran_v3/src/screen/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/screen/quran_resources/word_by_word_resources.dart";
import "package:flutter/material.dart";

class QuranResources extends StatefulWidget {
  const QuranResources({super.key});

  @override
  State<QuranResources> createState() => _QuranResourcesState();
}

class _QuranResourcesState extends State<QuranResources> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran Resources")),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                const TranslationResources(),
                const TafsirResources(),
                const WordByWordResources(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
