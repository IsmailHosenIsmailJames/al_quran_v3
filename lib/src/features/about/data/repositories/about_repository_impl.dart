import 'package:al_quran_v3/src/features/about/data/datasources/about_local_datasource.dart';
import 'package:al_quran_v3/src/features/about/data/models/about_model.dart';
import 'package:al_quran_v3/src/features/about/domain/entities/app_info_entity.dart';
import 'package:al_quran_v3/src/features/about/domain/repositories/i_about_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAboutRepository)
class AboutRepositoryImpl implements IAboutRepository {
  final AboutLocalDataSource _localDataSource;

  AboutRepositoryImpl(this._localDataSource);

  @override
  Future<AppInfoEntity> getAppInfo() async {
    final rawMap = await _localDataSource.getRawAppInfo();
    final model = AboutModel.fromJson(rawMap);
    return model.toEntity();
  }
}
