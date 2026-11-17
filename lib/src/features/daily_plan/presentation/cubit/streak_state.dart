import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";

abstract class StreakState {
  final StreakEntity streak;
  final DailyPlanEntity plan;

  const StreakState(this.streak, this.plan);
}

class StreakInitial extends StreakState {
  const StreakInitial(super.streak, super.plan);
}

class StreakLoaded extends StreakState {
  const StreakLoaded(super.streak, super.plan);
}

class StreakUpdated extends StreakState {
  final bool didIncrementToday;
  const StreakUpdated(super.streak, super.plan, {this.didIncrementToday = false});
}
