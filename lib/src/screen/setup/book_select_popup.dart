import "package:al_quran_v3/src/features/setup/presentation/widgets/book_select_bottom_sheet.dart";
import "package:flutter/material.dart";

class BookSelectPopup extends StatelessWidget {
  final bool isTafsir;

  const BookSelectPopup({super.key, required this.isTafsir});

  @override
  Widget build(BuildContext context) {
    return BookSelectBottomSheet(isTafsir: isTafsir);
  }
}
