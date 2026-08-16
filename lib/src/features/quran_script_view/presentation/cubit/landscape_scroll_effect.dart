import "package:flutter_bloc/flutter_bloc.dart";

class LandscapeScrollEffect extends Cubit<bool> {
  LandscapeScrollEffect() : super(false);

  void changeState(bool state) {
    emit(state);
  }
}
