import 'package:al_quran_v3/src/features/about/domain/entities/app_info_entity.dart';
import 'package:al_quran_v3/src/features/about/domain/repositories/i_about_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAppInfoUseCase {
  final IAboutRepository _repository;

  GetAppInfoUseCase(this._repository);

  Future<AppInfoEntity> execute() {
    return _repository.getAppInfo();
  }
}
