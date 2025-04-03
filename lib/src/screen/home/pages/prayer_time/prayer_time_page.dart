import 'package:flutter/material.dart';

class PrayerTimePage extends StatefulWidget {
  final PageController pageController;
  const PrayerTimePage({super.key, required this.pageController});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Prayer Times -->  Uner development')),
    );
  }
}
