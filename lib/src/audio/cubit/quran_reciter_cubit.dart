import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranReciterCubit extends Cubit<ReciterInfoModel> {
  final ReciterInfoModel initReciter;
  QuranReciterCubit({required this.initReciter}) : super(initReciter);
  void changeReciter(ReciterInfoModel reciter) {
    emit(reciter);
  }
}
