import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/khatam_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";

abstract class StreakState {
  final StreakEntity streak;
  final DailyPlanEntity plan;
  final KhatamPlanEntity? khatamPlan;

  const StreakState(this.streak, this.plan, {this.khatamPlan});
}

class StreakInitial extends StreakState {
  const StreakInitial(super.streak, super.plan, {super.khatamPlan});
}

class StreakLoaded extends StreakState {
  const StreakLoaded(super.streak, super.plan, {super.khatamPlan});
}

class StreakUpdated extends StreakState {
  final bool didIncrementToday;
  const StreakUpdated(
    super.streak,
    super.plan, {
    super.khatamPlan,
    this.didIncrementToday = false,
  });
}
