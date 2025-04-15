import 'package:flutter/material.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prayer Times')),
      body: const Center(child: Text('Prayer Time -> under development')),
    );
  }
}
