import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:flutter/material.dart";

class ListOfAyahsViews extends StatefulWidget {
  final List<String> ayahsKey;
  const ListOfAyahsViews({super.key, required this.ayahsKey});

  @override
  State<ListOfAyahsViews> createState() => _ListOfAyahsViewsState();
}

class _ListOfAyahsViewsState extends State<ListOfAyahsViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.ayahsKey.length} Ayah${widget.ayahsKey.length > 1 ? "s" : ""}",
        ),
      ),
      body: ListView.builder(
        itemCount: widget.ayahsKey.length,
        itemBuilder: (context, index) {
          return getAyahByAyahCard(
            ayahKey: widget.ayahsKey[index],
            context: context,
            showFullKey: true,
          );
        },
      ),
    );
  }
}
