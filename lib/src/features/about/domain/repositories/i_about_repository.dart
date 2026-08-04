import 'package:al_quran_v3/src/features/about/domain/entities/app_info_entity.dart';

abstract class IAboutRepository {
  Future<AppInfoEntity> getAppInfo();
}
