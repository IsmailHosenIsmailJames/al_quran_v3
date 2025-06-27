import "package:al_quran_v3/src/screen/quran_resources/tafsir_resources.dart";
import "package:al_quran_v3/src/screen/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/screen/quran_resources/word_by_word_resources.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranResources extends StatefulWidget {
  const QuranResources({super.key});

  @override
  State<QuranResources> createState() => _QuranResourcesState();
}

class _QuranResourcesState extends State<QuranResources> {
  List<String> pagesName = ["Translation", "Tafsir", "Word By Word"];
  int pageIndex = 0;
  late PageController pageController = PageController(initialPage: pageIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran Resources")),
      body: Column(
        children: [
          Container(
            height: 35,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: context.read<ThemeCubit>().state.primaryShade100,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment([-1, 0, 1][pageIndex].toDouble(), 0),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.read<ThemeCubit>().state.primaryShade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 30,
                    width: (MediaQuery.of(context).size.width - 10) / 3,
                  ),
                ),
                Row(
                  children: List.generate(pagesName.length, (index) {
                    return Expanded(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          pagesName[index],
                          style: TextStyle(
                            fontWeight:
                                pageIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
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
