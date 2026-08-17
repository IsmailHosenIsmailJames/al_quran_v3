import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class WordPlayingStateCubit extends Cubit<String?> {
  WordPlayingStateCubit() : super(null);
  void changeState(String? s) {
    emit(s);
  }
}
