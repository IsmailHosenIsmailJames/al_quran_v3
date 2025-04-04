import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class QuranPage extends StatefulWidget {
  final PageController pageController;
  const QuranPage({super.key, required this.pageController});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<String> pagesName = ['Surah', 'Juz', 'Pages', 'Hizb', 'Ruku'];
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              children: List.generate(pagesName.length, (index) {
                return Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor:
                          _pageIndex == index
                              ? AppColors.primaryColor
                              : Colors.transparent,
                      foregroundColor:
                          _pageIndex == index
                              ? Colors.white
                              : AppColors.primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () async {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    child: Text(
                      pagesName[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              children: [
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
