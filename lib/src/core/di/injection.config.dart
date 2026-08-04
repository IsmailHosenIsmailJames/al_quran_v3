// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart'
    as _i169;
import 'package:al_quran_v3/src/features/collections/data/repositories/collections_repository_impl.dart'
    as _i713;
import 'package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart'
    as _i1035;
import 'package:al_quran_v3/src/features/location/data/datasources/location_local_datasource.dart'
    as _i924;
import 'package:al_quran_v3/src/features/location/data/datasources/location_remote_datasource.dart'
    as _i527;
import 'package:al_quran_v3/src/features/location/data/repositories/location_repository_impl.dart'
    as _i1067;
import 'package:al_quran_v3/src/features/location/domain/repositories/location_repository.dart'
    as _i856;
import 'package:al_quran_v3/src/features/location/domain/usecases/get_current_location_usecase.dart'
    as _i642;
import 'package:al_quran_v3/src/features/location/domain/usecases/get_saved_location_usecase.dart'
    as _i168;
import 'package:al_quran_v3/src/features/location/domain/usecases/save_location_usecase.dart'
    as _i22;
import 'package:al_quran_v3/src/features/prayer_time/data/datasources/prayer_time_calculator_datasource.dart'
    as _i104;
import 'package:al_quran_v3/src/features/prayer_time/data/datasources/prayer_time_local_datasource.dart'
    as _i329;
import 'package:al_quran_v3/src/features/prayer_time/data/repositories/prayer_time_repository_impl.dart'
    as _i888;
import 'package:al_quran_v3/src/features/prayer_time/domain/repositories/prayer_time_repository.dart'
    as _i451;
import 'package:al_quran_v3/src/features/prayer_time/domain/usecases/get_prayer_times_usecase.dart'
    as _i556;
import 'package:al_quran_v3/src/features/prayer_time/domain/usecases/save_prayer_settings_usecase.dart'
    as _i347;
import 'package:al_quran_v3/src/features/prayer_time/domain/usecases/schedule_prayer_notifications_usecase.dart'
    as _i903;
import 'package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_time_cubit.dart'
    as _i358;
import 'package:al_quran_v3/src/features/qibla/data/datasources/compass_datasource.dart'
    as _i197;
import 'package:al_quran_v3/src/features/qibla/data/datasources/vibration_datasource.dart'
    as _i1059;
import 'package:al_quran_v3/src/features/qibla/data/repositories/qibla_repository_impl.dart'
    as _i135;
import 'package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart'
    as _i298;
import 'package:al_quran_v3/src/features/qibla/domain/usecases/calculate_qibla_angle_usecase.dart'
    as _i153;
import 'package:al_quran_v3/src/features/qibla/domain/usecases/get_compass_heading_usecase.dart'
    as _i759;
import 'package:al_quran_v3/src/features/qibla/domain/usecases/trigger_alignment_vibration_usecase.dart'
    as _i979;
import 'package:al_quran_v3/src/features/qibla/presentation/cubit/qibla_cubit.dart'
    as _i236;
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
    gh.lazySingleton<_i1059.VibrationDatasource>(
      () => _i1059.VibrationDatasourceImpl(),
    );
    gh.lazySingleton<_i930.GetSetupResourcesUseCase>(
      () => _i930.GetSetupResourcesUseCase(gh<_i720.IResourceRepository>()),
    );
    gh.lazySingleton<_i329.PrayerTimeLocalDataSource>(
      () => _i329.PrayerTimeLocalDataSourceImpl(),
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
    gh.lazySingleton<_i527.LocationRemoteDataSource>(
      () => _i527.LocationRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i924.LocationLocalDataSource>(
      () => _i924.LocationLocalDataSourceImpl(),
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
    gh.lazySingleton<_i104.PrayerTimeCalculatorDataSource>(
      () => _i104.PrayerTimeCalculatorDataSourceImpl(),
    );
    gh.lazySingleton<_i197.CompassDatasource>(
      () => _i197.CompassDatasourceImpl(),
    );
    gh.lazySingleton<_i169.CollectionsLocalDataSource>(
      () => _i169.CollectionsLocalDataSourceImpl(),
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
    gh.lazySingleton<_i856.LocationRepository>(
      () => _i1067.LocationRepositoryImpl(
        gh<_i924.LocationLocalDataSource>(),
        gh<_i527.LocationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1035.CollectionsRepository>(
      () => _i713.CollectionsRepositoryImpl(
        gh<_i169.CollectionsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i451.PrayerTimeRepository>(
      () => _i888.PrayerTimeRepositoryImpl(
        gh<_i104.PrayerTimeCalculatorDataSource>(),
        gh<_i329.PrayerTimeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1025.DownloadSetupResourcesUseCase>(
      () => _i1025.DownloadSetupResourcesUseCase(
        resourceRepository: gh<_i720.IResourceRepository>(),
        setupRepository: gh<_i670.ISetupRepository>(),
      ),
    );
    gh.lazySingleton<_i642.GetCurrentLocationUseCase>(
      () => _i642.GetCurrentLocationUseCase(gh<_i856.LocationRepository>()),
    );
    gh.lazySingleton<_i168.GetSavedLocationUseCase>(
      () => _i168.GetSavedLocationUseCase(gh<_i856.LocationRepository>()),
    );
    gh.lazySingleton<_i22.SaveLocationUseCase>(
      () => _i22.SaveLocationUseCase(gh<_i856.LocationRepository>()),
    );
    gh.lazySingleton<_i298.QiblaRepository>(
      () => _i135.QiblaRepositoryImpl(
        gh<_i197.CompassDatasource>(),
        gh<_i1059.VibrationDatasource>(),
      ),
    );
    gh.lazySingleton<_i556.GetPrayerTimesUseCase>(
      () => _i556.GetPrayerTimesUseCase(gh<_i451.PrayerTimeRepository>()),
    );
    gh.lazySingleton<_i347.SavePrayerSettingsUseCase>(
      () => _i347.SavePrayerSettingsUseCase(gh<_i451.PrayerTimeRepository>()),
    );
    gh.lazySingleton<_i903.SchedulePrayerNotificationsUseCase>(
      () => _i903.SchedulePrayerNotificationsUseCase(
        gh<_i451.PrayerTimeRepository>(),
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
    gh.lazySingleton<_i153.CalculateQiblaAngleUseCase>(
      () => _i153.CalculateQiblaAngleUseCase(gh<_i298.QiblaRepository>()),
    );
    gh.lazySingleton<_i759.GetCompassHeadingUseCase>(
      () => _i759.GetCompassHeadingUseCase(gh<_i298.QiblaRepository>()),
    );
    gh.lazySingleton<_i979.TriggerAlignmentVibrationUseCase>(
      () => _i979.TriggerAlignmentVibrationUseCase(gh<_i298.QiblaRepository>()),
    );
    gh.factory<_i358.PrayerTimeCubit>(
      () => _i358.PrayerTimeCubit(
        gh<_i556.GetPrayerTimesUseCase>(),
        gh<_i347.SavePrayerSettingsUseCase>(),
        gh<_i903.SchedulePrayerNotificationsUseCase>(),
      ),
    );
    gh.factory<_i236.QiblaCubit>(
      () => _i236.QiblaCubit(
        gh<_i759.GetCompassHeadingUseCase>(),
        gh<_i153.CalculateQiblaAngleUseCase>(),
        gh<_i979.TriggerAlignmentVibrationUseCase>(),
      ),
    );
    return this;
  }
}
