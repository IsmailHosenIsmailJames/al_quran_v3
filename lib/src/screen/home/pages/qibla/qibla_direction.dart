import 'package:flutter/material.dart';

class QiblaDirection extends StatefulWidget {
  final PageController pageController;
  const QiblaDirection({super.key, required this.pageController});

  @override
  State<QiblaDirection> createState() => _QiblaDirectionState();
}

class _QiblaDirectionState extends State<QiblaDirection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Qibla Directions -->  Uner development')),
    );
  }
}
