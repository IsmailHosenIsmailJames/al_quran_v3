import "package:flutter/material.dart";

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({super.key});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prayer Settings")),
      body: const Center(child: Text("TODO: Prayer Settings")),
    );
  }
}
