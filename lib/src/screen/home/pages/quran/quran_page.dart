import 'package:flutter/material.dart';

class QuranPage extends StatefulWidget {
  final PageController pageController;
  const QuranPage({super.key, required this.pageController});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Quran -->  Uner development')));
  }
}
