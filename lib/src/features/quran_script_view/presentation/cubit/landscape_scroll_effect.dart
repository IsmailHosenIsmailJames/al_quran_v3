import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class LandscapeScrollEffect extends Cubit<bool> {
  LandscapeScrollEffect() : super(false);

  void changeState(bool state) {
    emit(state);
  }
}
