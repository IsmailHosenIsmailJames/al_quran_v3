import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final PageController pageController;
  const SettingsPage({super.key, required this.pageController});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Settings -->  Uner development')),
    );
  }
}
