import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';

abstract class IQuranResourcesRepository {
  Future<List<ResourceGroupEntity>> getTranslationResources({
    String query = '',
  });
  Future<List<ResourceGroupEntity>> getTafsirResources({
    String query = '',
  });
  Future<List<QuranResourceEntity>> getWordByWordResources({
    String query = '',
  });

  Future<bool> downloadResource(
    QuranResourceEntity resource, {
    void Function(double progress, String name)? onProgress,
  });

  Future<void> toggleResourceSelection(QuranResourceEntity resource);
  Future<void> deleteResource(QuranResourceEntity resource);
}
