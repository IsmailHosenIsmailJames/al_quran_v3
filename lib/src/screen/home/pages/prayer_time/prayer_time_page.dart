import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerTimePage extends StatefulWidget {
  final PageController pageController;
  const PrayerTimePage({super.key, required this.pageController});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      itemScrollController.scrollTo(
        index: 400,
        duration: const Duration(milliseconds: 200),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              itemScrollController.scrollTo(
                index: 0,
                duration: const Duration(milliseconds: 200),
              );
            },
            icon: const Icon(Icons.arrow_circle_up_rounded),
          ),
          IconButton(
            onPressed: () {
              itemScrollController.scrollTo(
                index: 400,
                duration: const Duration(milliseconds: 200),
              );
            },
            icon: const Icon(Icons.arrow_circle_down),
          ),
        ],
      ),
      body: ScrollablePositionedList.builder(
        itemCount: 500,
        itemBuilder:
            (context, index) => Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              color: [Colors.red, Colors.blue, Colors.green][index % 3],
              child: Text('Item $index'),
            ),
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
      ),
    );
  }
}
