import "package:injectable/injectable.dart";
import "../../domain/entities/tajweed_rule_entity.dart";
import "../../domain/repositories/tajweed_guide_repository.dart";
import "../datasources/tajweed_guide_local_data_source.dart";

@LazySingleton(as: TajweedGuideRepository)
class TajweedGuideRepositoryImpl implements TajweedGuideRepository {
  final TajweedGuideLocalDataSource localDataSource;

  TajweedGuideRepositoryImpl({required this.localDataSource});

  @override
  List<TajweedRuleEntity> getTajweedRules() {
    return localDataSource.getTajweedRules();
  }
}
