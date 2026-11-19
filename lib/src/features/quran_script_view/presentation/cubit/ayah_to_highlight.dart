import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class AyahToHighlight extends Cubit<String?> {
  AyahToHighlight() : super(null);

  void changeAyah(String? ayah) {
    emit(ayah);
  }

  void clear() {
    emit(null);
  }
}
