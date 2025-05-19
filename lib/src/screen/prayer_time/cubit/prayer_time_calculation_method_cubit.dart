import "package:adhan/adhan.dart";
import "package:bloc/bloc.dart";

class PrayerTimeCalculationMethodCubit extends Cubit<CalculationParameters> {
  PrayerTimeCalculationMethodCubit()
    : super(CalculationMethod.north_america.getParameters());
}
