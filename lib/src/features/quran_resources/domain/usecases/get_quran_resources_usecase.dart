import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/repositories/i_quran_resources_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetQuranResourcesUseCase {
  final IQuranResourcesRepository _repository;

  GetQuranResourcesUseCase(this._repository);

  Future<List<ResourceGroupEntity>> getTranslations({String query = ''}) {
    return _repository.getTranslationResources(query: query);
  }

  Future<List<ResourceGroupEntity>> getTafsirs({String query = ''}) {
    return _repository.getTafsirResources(query: query);
  }

  Future<List<QuranResourceEntity>> getWordByWord({String query = ''}) {
    return _repository.getWordByWordResources(query: query);
  }
}
