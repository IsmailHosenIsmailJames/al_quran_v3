import "dart:convert";

import "package:al_quran_v3/src/screen/mushaf/font_loader.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

class MushafScreen extends StatefulWidget {
  const MushafScreen({super.key});

  @override
  State<MushafScreen> createState() => _MushafScreenState();
}

class _MushafScreenState extends State<MushafScreen> {
  bool isLoading = true;
  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  List<String> surahFatiha = []; // 7 ayah
  Future<void> loadInitialData() async {
    Map jsonQuranScript = jsonDecode(
      await rootBundle.loadString(
        "assets/quran_script/qpc-v4.json.simplified.json",
      ),
    );
    List wordFatiha = Map<String, List>.from(
      jsonQuranScript["1"],
    ).values.toList();
    for (List ayahWord in wordFatiha) {
      surahFatiha.add(List<String>.from(ayahWord).join(" "));
    }
    await DynamicFontLoader.loadFontForPage(1);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mushaf")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: surahFatiha.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                String ayah = surahFatiha[index];
                return Text(
                  ayah,
                  style: const TextStyle(
                    fontFamily: "Page1",
                    fontSize: 24,
                    height: 2,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                );
              },
            ),
    );
  }
}
