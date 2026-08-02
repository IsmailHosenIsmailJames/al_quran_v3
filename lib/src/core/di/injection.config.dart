// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:al_quran_v3/src/features/quran_resources/data/datasources/quran_resources_local_datasource.dart'
    as _i150;
import 'package:al_quran_v3/src/features/quran_resources/data/datasources/quran_resources_remote_datasource.dart'
    as _i609;
import 'package:al_quran_v3/src/features/quran_resources/data/repositories/quran_resources_repository_impl.dart'
    as _i456;
import 'package:al_quran_v3/src/features/quran_resources/domain/repositories/i_quran_resources_repository.dart'
    as _i502;
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/delete_quran_resource_usecase.dart'
    as _i925;
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/download_quran_resource_usecase.dart'
    as _i704;
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/get_quran_resources_usecase.dart'
    as _i83;
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/toggle_quran_resource_selection_usecase.dart'
    as _i130;
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart'
    as _i411;
import 'package:al_quran_v3/src/features/setup/data/datasources/setup_local_datasource.dart'
    as _i72;
import 'package:al_quran_v3/src/features/setup/data/repositories/resource_repository_impl.dart'
    as _i865;
import 'package:al_quran_v3/src/features/setup/data/repositories/setup_repository_impl.dart'
    as _i283;
import 'package:al_quran_v3/src/features/setup/domain/repositories/i_resource_repository.dart'
    as _i720;
import 'package:al_quran_v3/src/features/setup/domain/repositories/i_setup_repository.dart'
    as _i670;
import 'package:al_quran_v3/src/features/setup/domain/usecases/download_setup_resources_usecase.dart'
    as _i1025;
import 'package:al_quran_v3/src/features/setup/domain/usecases/get_setup_resources_usecase.dart'
    as _i930;
import 'package:al_quran_v3/src/features/setup/domain/usecases/save_setup_preferences_usecase.dart'
    as _i144;
import 'package:al_quran_v3/src/features/setup/presentation/bloc/download_cubit.dart'
    as _i708;
import 'package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart'
    as _i76;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i150.QuranResourcesLocalDataSource>(
      () => _i150.QuranResourcesLocalDataSource(),
    );
    gh.lazySingleton<_i609.QuranResourcesRemoteDataSource>(
      () => _i609.QuranResourcesRemoteDataSource(),
    );
    gh.lazySingleton<_i72.SetupLocalDataSource>(
      () => _i72.SetupLocalDataSource(),
    );
    gh.lazySingleton<_i720.IResourceRepository>(
      () => _i865.ResourceRepositoryImpl(),
    );
    gh.lazySingleton<_i930.GetSetupResourcesUseCase>(
      () => _i930.GetSetupResourcesUseCase(gh<_i720.IResourceRepository>()),
    );
    gh.lazySingleton<_i670.ISetupRepository>(
      () => _i283.SetupRepositoryImpl(
        localDataSource: gh<_i72.SetupLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i502.IQuranResourcesRepository>(
      () => _i456.QuranResourcesRepositoryImpl(
        gh<_i150.QuranResourcesLocalDataSource>(),
        gh<_i609.QuranResourcesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i925.DeleteQuranResourceUseCase>(
      () => _i925.DeleteQuranResourceUseCase(
        gh<_i502.IQuranResourcesRepository>(),
      ),
    );
    gh.lazySingleton<_i704.DownloadQuranResourceUseCase>(
      () => _i704.DownloadQuranResourceUseCase(
        gh<_i502.IQuranResourcesRepository>(),
      ),
    );
    gh.lazySingleton<_i83.GetQuranResourcesUseCase>(
      () =>
          _i83.GetQuranResourcesUseCase(gh<_i502.IQuranResourcesRepository>()),
    );
    gh.lazySingleton<_i130.ToggleQuranResourceSelectionUseCase>(
      () => _i130.ToggleQuranResourceSelectionUseCase(
        gh<_i502.IQuranResourcesRepository>(),
      ),
    );
    gh.factory<_i411.QuranResourcesCubit>(
      () => _i411.QuranResourcesCubit(
        gh<_i83.GetQuranResourcesUseCase>(),
        gh<_i704.DownloadQuranResourceUseCase>(),
        gh<_i130.ToggleQuranResourceSelectionUseCase>(),
        gh<_i925.DeleteQuranResourceUseCase>(),
      ),
    );
    gh.lazySingleton<_i144.SaveSetupPreferencesUseCase>(
      () => _i144.SaveSetupPreferencesUseCase(gh<_i670.ISetupRepository>()),
    );
    gh.lazySingleton<_i1025.DownloadSetupResourcesUseCase>(
      () => _i1025.DownloadSetupResourcesUseCase(
        resourceRepository: gh<_i720.IResourceRepository>(),
        setupRepository: gh<_i670.ISetupRepository>(),
      ),
    );
    gh.factory<_i76.SetupBloc>(
      () => _i76.SetupBloc(
        getSetupResourcesUseCase: gh<_i930.GetSetupResourcesUseCase>(),
        saveSetupPreferencesUseCase: gh<_i144.SaveSetupPreferencesUseCase>(),
      ),
    );
    gh.factory<_i708.DownloadCubit>(
      () => _i708.DownloadCubit(
        downloadSetupResourcesUseCase:
            gh<_i1025.DownloadSetupResourcesUseCase>(),
      ),
    );
    return this;
  }
}
