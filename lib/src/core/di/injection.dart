import "package:al_quran_v3/src/core/di/injection.config.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}
