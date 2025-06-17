import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/widget/preview_quran_script/ayah_preview_widget.dart";
import "package:flutter/material.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedAyahKey = "2:2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getScriptSelectionSegmentedButtons(),
            getAyahPreviewWidget(),
          ],
        ),
      ),
    );
  }
}
