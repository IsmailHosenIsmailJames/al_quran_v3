import "package:flutter_bloc/flutter_bloc.dart";

class AyahToHighlight extends Cubit<String?> {
  AyahToHighlight(super.initialState);

  void changeAyah(String ayah) {
    emit(ayah);
  }
}
