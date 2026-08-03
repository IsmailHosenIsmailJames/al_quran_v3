import "dart:async";

import "package:al_quran_v3/src/features/qibla/domain/entities/qibla_compass_data.dart";
import "package:al_quran_v3/src/features/qibla/domain/usecases/calculate_qibla_angle_usecase.dart";
import "package:al_quran_v3/src/features/qibla/domain/usecases/get_compass_heading_usecase.dart";
import "package:al_quran_v3/src/features/qibla/domain/usecases/trigger_alignment_vibration_usecase.dart";
import "package:al_quran_v3/src/features/qibla/presentation/cubit/qibla_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class QiblaCubit extends Cubit<QiblaState> {
  final GetCompassHeadingUseCase _getCompassHeadingUseCase;
  final CalculateQiblaAngleUseCase _calculateQiblaAngleUseCase;
  final TriggerAlignmentVibrationUseCase _triggerAlignmentVibrationUseCase;

  StreamSubscription<double?>? _compassSubscription;
  bool _vibratedOnce = false;

  QiblaCubit(
    this._getCompassHeadingUseCase,
    this._calculateQiblaAngleUseCase,
    this._triggerAlignmentVibrationUseCase,
  ) : super(const QiblaState());

  void init({double? latitude, double? longitude, double? preCalculatedKaabaAngle}) {
    double? kaabaAngle = preCalculatedKaabaAngle;
    if (kaabaAngle == null && latitude != null && longitude != null) {
      kaabaAngle = _calculateQiblaAngleUseCase(latitude, longitude);
    }
    emit(state.copyWith(kaabaAngle: kaabaAngle));
    _startCompassStream();
  }

  void updateKaabaAngle(double kaabaAngle) {
    emit(state.copyWith(kaabaAngle: kaabaAngle));
  }

  void _startCompassStream() {
    _compassSubscription?.cancel();
    _compassSubscription = _getCompassHeadingUseCase().listen(
      (heading) {
        if (heading == null) {
          emit(state.copyWith(isSensorSupported: false));
          return;
        }

        bool isAligned = false;
        if (state.kaabaAngle != null) {
          isAligned = QiblaCompassData.checkIsAligned(heading, state.kaabaAngle!);
        }

        if (isAligned) {
          if (!_vibratedOnce) {
            _triggerAlignmentVibrationUseCase();
            _vibratedOnce = true;
          }
        } else {
          _vibratedOnce = false;
        }

        emit(state.copyWith(
          compassHeading: heading,
          isAligned: isAligned,
          isSensorSupported: true,
          hasError: false,
        ));
      },
      onError: (_) {
        emit(state.copyWith(hasError: true));
      },
    );
  }

  @override
  Future<void> close() {
    _compassSubscription?.cancel();
    return super.close();
  }
}
