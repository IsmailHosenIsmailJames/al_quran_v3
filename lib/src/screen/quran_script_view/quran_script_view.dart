import 'package:al_quran_v3/src/screen/quran_script_view/ayah_by_ayah_view.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/page_by_page_view.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranScriptView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;

  const QuranScriptView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<QuranScriptView> createState() => _QuranScriptViewState();
}

class _QuranScriptViewState extends State<QuranScriptView> {
  int _pageIndex = 0;
  List<String> pagesName = ['Ayah By Ayah', 'Page By Page'];
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AyahByAyahInScrollInfoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<
            AyahByAyahInScrollInfoCubit,
            AyahByAyahInScrollInfoState
          >(
            builder:
                (context, state) => Text(
                  '${state.surahInfoModel?.nameSimple} ( ${state.surahInfoModel?.nameArabic} )',
                ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: List.generate(2, (index) {
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
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              index == 1
                                  ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    topLeft: Radius.circular(100),
                                  )
                                  : const BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
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
                  AyahByAyahView(
                    startKey: widget.startKey,
                    endKey: widget.endKey,
                    toScrollKey: widget.toScrollKey,
                  ),

                  PageByPageView(
                    startKey: widget.startKey,
                    endKey: widget.endKey,
                    toScrollKey: widget.toScrollKey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
