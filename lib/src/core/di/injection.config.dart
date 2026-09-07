// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:al_quran_v3/src/core/localization/language_cubit.dart' as _i178;
import 'package:al_quran_v3/src/core/localization/languages.dart' as _i498;
import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart'
    as _i376;
import 'package:al_quran_v3/src/features/about/data/datasources/about_local_datasource.dart'
    as _i190;
import 'package:al_quran_v3/src/features/about/data/repositories/about_repository_impl.dart'
    as _i294;
import 'package:al_quran_v3/src/features/about/domain/repositories/i_about_repository.dart'
    as _i914;
import 'package:al_quran_v3/src/features/about/domain/usecases/get_app_info_usecase.dart'
    as _i511;
import 'package:al_quran_v3/src/features/audio/data/datasources/audio_local_datasource.dart'
    as _i712;
import 'package:al_quran_v3/src/features/audio/data/repositories/audio_repository_impl.dart'
    as _i588;
import 'package:al_quran_v3/src/features/audio/domain/repositories/i_audio_repository.dart'
    as _i818;
import 'package:al_quran_v3/src/features/audio/domain/usecases/get_recitations_usecase.dart'
    as _i219;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/audio_download_cubit.dart'
    as _i949;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart'
    as _i146;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart'
    as _i587;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart'
    as _i1021;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart'
    as _i966;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart'
    as _i793;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart'
    as _i525;
import 'package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart'
    as _i730;
import 'package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart'
    as _i169;
import 'package:al_quran_v3/src/features/collections/data/repositories/collections_repository_impl.dart'
    as _i713;
import 'package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart'
    as _i1035;
import 'package:al_quran_v3/src/features/home/data/datasources/history_local_datasource.dart'
    as _i151;
import 'package:al_quran_v3/src/features/home/data/repositories/history_repository_impl.dart'
    as _i922;
import 'package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart'
    as _i170;
import 'package:al_quran_v3/src/features/home/domain/usecases/add_history_usecase.dart'
    as _i126;
import 'package:al_quran_v3/src/features/home/domain/usecases/get_history_usecase.dart'
    as _i289;
import 'package:al_quran_v3/src/features/home/presentation/cubit/quick_access_cubit.dart'
    as _i364;
import 'package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart'
    as _i900;
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
import 'package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart'
    as _i945;
import 'package:al_quran_v3/src/features/location/presentation/cubit/manual_location_selection_cubit.dart'
    as _i288;
import 'package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart'
    as _i15;
import 'package:al_quran_v3/src/features/mushaf/data/datasources/mushaf_local_datasource.dart'
    as _i187;
import 'package:al_quran_v3/src/features/mushaf/data/datasources/mushaf_remote_datasource.dart'
    as _i796;
import 'package:al_quran_v3/src/features/mushaf/data/repositories/mushaf_repository_impl.dart'
    as _i594;
import 'package:al_quran_v3/src/features/mushaf/domain/repositories/i_mushaf_repository.dart'
    as _i318;
import 'package:al_quran_v3/src/features/mushaf/domain/usecases/mushaf_usecases.dart'
    as _i1044;
import 'package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_cubit.dart'
    as _i852;
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
import 'package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart'
    as _i601;
import 'package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_time_cubit.dart'
    as _i358;
import 'package:al_quran_v3/src/features/qibla/data/datasources/compass_datasource.dart'
    as _i198;
import 'package:al_quran_v3/src/features/qibla/data/datasources/vibration_datasource.dart'
    as _i1059;
import 'package:al_quran_v3/src/features/qibla/data/repositories/qibla_repository_impl.dart'
    as _i135;
import 'package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart'
    as _i298;
import 'package:al_quran_v3/src/features/qibla/domain/usecases/calculate_qibla_angle_usecase.dart'
    as _i153;
import 'package:al_quran_v3/src/features/qibla/domain/usecases/get_compass_heading_usecase.dart'
    as _i760;
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
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart'
    as _i775;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart'
    as _i277;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/landscape_scroll_effect.dart'
    as _i327;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart'
    as _i81;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart'
    as _i348;
import 'package:al_quran_v3/src/features/search/data/datasources/quran_search_datasource.dart'
    as _i656;
import 'package:al_quran_v3/src/features/search/domain/usecases/search_quran_usecase.dart'
    as _i405;
import 'package:al_quran_v3/src/features/search/presentation/cubit/quran_search_cubit.dart'
    as _i152;
import 'package:al_quran_v3/src/features/settings/data/datasources/settings_local_datasource.dart'
    as _i584;
import 'package:al_quran_v3/src/features/settings/data/repositories/settings_repository_impl.dart'
    as _i197;
import 'package:al_quran_v3/src/features/settings/domain/repositories/i_settings_repository.dart'
    as _i881;
import 'package:al_quran_v3/src/features/settings/domain/usecases/get_settings_usecase.dart'
    as _i70;
import 'package:al_quran_v3/src/features/settings/domain/usecases/save_settings_usecase.dart'
    as _i272;
import 'package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_cubit.dart'
    as _i103;
import 'package:al_quran_v3/src/features/setup/data/datasources/setup_local_datasource.dart'
    as _i72;
import 'package:al_quran_v3/src/features/setup/data/repositories/resource_repository_impl.dart'
    as _i865;
import 'package:al_quran_v3/src/features/setup/data/repositories/setup_repository_impl.dart'
    as _i283;
import 'package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart'
    as _i610;
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
import 'package:al_quran_v3/src/features/setup/presentation/bloc/book_search_cubit.dart'
    as _i998;
import 'package:al_quran_v3/src/features/setup/presentation/bloc/download_cubit.dart'
    as _i708;
import 'package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart'
    as _i76;
import 'package:al_quran_v3/src/features/surah_info/data/datasources/surah_info_local_datasource.dart'
    as _i278;
import 'package:al_quran_v3/src/features/surah_info/data/repositories/surah_info_repository_impl.dart'
    as _i632;
import 'package:al_quran_v3/src/features/surah_info/domain/repositories/i_surah_info_repository.dart'
    as _i723;
import 'package:al_quran_v3/src/features/surah_info/domain/usecases/get_surah_info_usecase.dart'
    as _i570;
import 'package:al_quran_v3/src/features/surah_list/data/datasources/surah_navigation_local_datasource.dart'
    as _i662;
import 'package:al_quran_v3/src/features/surah_list/data/repositories/surah_navigation_repository_impl.dart'
    as _i571;
import 'package:al_quran_v3/src/features/surah_list/domain/repositories/i_surah_navigation_repository.dart'
    as _i31;
import 'package:al_quran_v3/src/features/surah_list/domain/usecases/get_surah_navigation_usecase.dart'
    as _i626;
import 'package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_cubit.dart'
    as _i563;
import 'package:al_quran_v3/src/features/tafsir/data/datasources/tafsir_local_datasource.dart'
    as _i564;
import 'package:al_quran_v3/src/features/tafsir/data/repositories/tafsir_repository_impl.dart'
    as _i880;
import 'package:al_quran_v3/src/features/tafsir/domain/repositories/i_tafsir_repository.dart'
    as _i759;
import 'package:al_quran_v3/src/features/tafsir/domain/usecases/get_tafsir_usecase.dart'
    as _i663;
import 'package:al_quran_v3/src/features/tajweed_guide/data/datasources/tajweed_guide_local_data_source.dart'
    as _i461;
import 'package:al_quran_v3/src/features/tajweed_guide/data/repositories/tajweed_guide_repository_impl.dart'
    as _i1041;
import 'package:al_quran_v3/src/features/tajweed_guide/domain/repositories/tajweed_guide_repository.dart'
    as _i619;
import 'package:al_quran_v3/src/features/tajweed_guide/domain/usecases/get_tajweed_rules_usecase.dart'
    as _i33;
import 'package:al_quran_v3/src/features/tajweed_guide/presentation/cubit/tajweed_guide_cubit.dart'
    as _i462;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i288.ManualLocationSelectionCubit>(
      () => _i288.ManualLocationSelectionCubit(),
    );
    gh.factory<_i601.PrayerReminderCubit>(() => _i601.PrayerReminderCubit());
    gh.factory<_i81.QuranViewCubit>(() => _i81.QuranViewCubit());
    gh.factory<_i563.SurahSearchCubit>(() => _i563.SurahSearchCubit());
    gh.lazySingleton<_i376.ThemeCubit>(() => _i376.ThemeCubit());
    gh.lazySingleton<_i190.AboutLocalDataSource>(
      () => _i190.AboutLocalDataSource(),
    );
    gh.lazySingleton<_i712.AudioLocalDataSource>(
      () => _i712.AudioLocalDataSource(),
    );
    gh.lazySingleton<_i949.AudioDownloadCubit>(
      () => _i949.AudioDownloadCubit(),
    );
    gh.lazySingleton<_i146.AudioLoopCubit>(() => _i146.AudioLoopCubit());
    gh.lazySingleton<_i587.AudioTabReciterCubit>(
      () => _i587.AudioTabReciterCubit(),
    );
    gh.lazySingleton<_i1021.AudioUiCubit>(() => _i1021.AudioUiCubit());
    gh.lazySingleton<_i966.AyahKeyCubit>(() => _i966.AyahKeyCubit());
    gh.lazySingleton<_i793.PlayerPositionCubit>(
      () => _i793.PlayerPositionCubit(),
    );
    gh.lazySingleton<_i525.PlayerStateCubit>(() => _i525.PlayerStateCubit());
    gh.lazySingleton<_i730.SegmentedQuranReciterCubit>(
      () => _i730.SegmentedQuranReciterCubit(),
    );
    gh.lazySingleton<_i151.HistoryLocalDataSource>(
      () => _i151.HistoryLocalDataSource(),
    );
    gh.lazySingleton<_i364.QuickAccessCubit>(() => _i364.QuickAccessCubit());
    gh.lazySingleton<_i187.MushafLocalDataSource>(
      () => _i187.MushafLocalDataSource(),
    );
    gh.lazySingleton<_i796.MushafRemoteDataSource>(
      () => _i796.MushafRemoteDataSource(),
    );
    gh.lazySingleton<_i150.QuranResourcesLocalDataSource>(
      () => _i150.QuranResourcesLocalDataSource(),
    );
    gh.lazySingleton<_i609.QuranResourcesRemoteDataSource>(
      () => _i609.QuranResourcesRemoteDataSource(),
    );
    gh.lazySingleton<_i775.AyahByAyahInScrollInfoCubit>(
      () => _i775.AyahByAyahInScrollInfoCubit(),
    );
    gh.lazySingleton<_i277.AyahToHighlight>(() => _i277.AyahToHighlight());
    gh.lazySingleton<_i327.LandscapeScrollEffect>(
      () => _i327.LandscapeScrollEffect(),
    );
    gh.lazySingleton<_i348.WordPlayingStateCubit>(
      () => _i348.WordPlayingStateCubit(),
    );
    gh.lazySingleton<_i656.QuranSearchDataSource>(
      () => _i656.QuranSearchDataSource(),
    );
    gh.lazySingleton<_i584.SettingsLocalDataSource>(
      () => _i584.SettingsLocalDataSource(),
    );
    gh.lazySingleton<_i72.SetupLocalDataSource>(
      () => _i72.SetupLocalDataSource(),
    );
    gh.lazySingleton<_i278.SurahInfoLocalDataSource>(
      () => _i278.SurahInfoLocalDataSource(),
    );
    gh.lazySingleton<_i662.SurahNavigationLocalDataSource>(
      () => _i662.SurahNavigationLocalDataSource(),
    );
    gh.lazySingleton<_i564.TafsirLocalDataSource>(
      () => _i564.TafsirLocalDataSource(),
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
    gh.lazySingleton<_i881.ISettingsRepository>(
      () => _i197.SettingsRepositoryImpl(gh<_i584.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i329.PrayerTimeLocalDataSource>(
      () => _i329.PrayerTimeLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i670.ISetupRepository>(
      () => _i283.SetupRepositoryImpl(
        localDataSource: gh<_i72.SetupLocalDataSource>(),
      ),
    );
    gh.factory<_i405.SearchQuranUseCase>(
      () => _i405.SearchQuranUseCase(gh<_i656.QuranSearchDataSource>()),
    );
    gh.lazySingleton<_i461.TajweedGuideLocalDataSource>(
      () => _i461.TajweedGuideLocalDataSourceImpl(),
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
    gh.lazySingleton<_i914.IAboutRepository>(
      () => _i294.AboutRepositoryImpl(gh<_i190.AboutLocalDataSource>()),
    );
    gh.factoryParam<
      _i998.BookSearchCubit,
      bool,
      Map<String, List<_i610.ResourceEntity>>
    >(
      (isTafsir, allResources) =>
          _i998.BookSearchCubit(isTafsir: isTafsir, allResources: allResources),
    );
    gh.lazySingleton<_i104.PrayerTimeCalculatorDataSource>(
      () => _i104.PrayerTimeCalculatorDataSourceImpl(),
    );
    gh.factoryParam<_i178.LanguageCubit, _i498.MyAppLocalization?, dynamic>(
      (initialLocale, _) => _i178.LanguageCubit(initialLocale),
    );
    gh.lazySingleton<_i198.CompassDatasource>(
      () => _i198.CompassDatasourceImpl(),
    );
    gh.lazySingleton<_i169.CollectionsLocalDataSource>(
      () => _i169.CollectionsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i759.ITafsirRepository>(
      () => _i880.TafsirRepositoryImpl(gh<_i564.TafsirLocalDataSource>()),
    );
    gh.factory<_i411.QuranResourcesCubit>(
      () => _i411.QuranResourcesCubit(
        gh<_i83.GetQuranResourcesUseCase>(),
        gh<_i704.DownloadQuranResourceUseCase>(),
        gh<_i130.ToggleQuranResourceSelectionUseCase>(),
        gh<_i925.DeleteQuranResourceUseCase>(),
      ),
    );
    gh.lazySingleton<_i663.GetTafsirUseCase>(
      () => _i663.GetTafsirUseCase(gh<_i759.ITafsirRepository>()),
    );
    gh.lazySingleton<_i619.TajweedGuideRepository>(
      () => _i1041.TajweedGuideRepositoryImpl(
        localDataSource: gh<_i461.TajweedGuideLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i144.SaveSetupPreferencesUseCase>(
      () => _i144.SaveSetupPreferencesUseCase(gh<_i670.ISetupRepository>()),
    );
    gh.lazySingleton<_i31.ISurahNavigationRepository>(
      () => _i571.SurahNavigationRepositoryImpl(
        gh<_i662.SurahNavigationLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i856.LocationRepository>(
      () => _i1067.LocationRepositoryImpl(
        gh<_i924.LocationLocalDataSource>(),
        gh<_i527.LocationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i723.ISurahInfoRepository>(
      () => _i632.SurahInfoRepositoryImpl(gh<_i278.SurahInfoLocalDataSource>()),
    );
    gh.lazySingleton<_i818.IAudioRepository>(
      () => _i588.AudioRepositoryImpl(gh<_i712.AudioLocalDataSource>()),
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
    gh.lazySingleton<_i318.IMushafRepository>(
      () => _i594.MushafRepositoryImpl(
        localDataSource: gh<_i187.MushafLocalDataSource>(),
        remoteDataSource: gh<_i796.MushafRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i170.IHistoryRepository>(
      () => _i922.HistoryRepositoryImpl(gh<_i151.HistoryLocalDataSource>()),
    );
    gh.lazySingleton<_i1025.DownloadSetupResourcesUseCase>(
      () => _i1025.DownloadSetupResourcesUseCase(
        resourceRepository: gh<_i720.IResourceRepository>(),
        setupRepository: gh<_i670.ISetupRepository>(),
      ),
    );
    gh.factoryParam<
      _i945.LocationQiblaPrayerDataCubit,
      _i15.LocationQiblaPrayerDataState?,
      dynamic
    >(
      (initState, _) =>
          _i945.LocationQiblaPrayerDataCubit(initState: initState),
    );
    gh.factory<_i152.QuranSearchCubit>(
      () => _i152.QuranSearchCubit(
        gh<_i656.QuranSearchDataSource>(),
        gh<_i405.SearchQuranUseCase>(),
      ),
    );
    gh.lazySingleton<_i511.GetAppInfoUseCase>(
      () => _i511.GetAppInfoUseCase(gh<_i914.IAboutRepository>()),
    );
    gh.lazySingleton<_i1044.CheckMushafDownloadedUseCase>(
      () => _i1044.CheckMushafDownloadedUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i1044.DownloadMushafUseCase>(
      () => _i1044.DownloadMushafUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i1044.DeleteMushafUseCase>(
      () => _i1044.DeleteMushafUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i1044.GetMushafLastPageUseCase>(
      () => _i1044.GetMushafLastPageUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i1044.SaveMushafLastPageUseCase>(
      () => _i1044.SaveMushafLastPageUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i1044.GetMushafBasePathUseCase>(
      () => _i1044.GetMushafBasePathUseCase(gh<_i318.IMushafRepository>()),
    );
    gh.lazySingleton<_i70.GetSettingsUseCase>(
      () => _i70.GetSettingsUseCase(gh<_i881.ISettingsRepository>()),
    );
    gh.lazySingleton<_i272.SaveSettingsUseCase>(
      () => _i272.SaveSettingsUseCase(gh<_i881.ISettingsRepository>()),
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
    gh.factory<_i852.MushafCubit>(
      () => _i852.MushafCubit(
        checkDownloadedUseCase: gh<_i1044.CheckMushafDownloadedUseCase>(),
        downloadUseCase: gh<_i1044.DownloadMushafUseCase>(),
        deleteUseCase: gh<_i1044.DeleteMushafUseCase>(),
        getLastPageUseCase: gh<_i1044.GetMushafLastPageUseCase>(),
        saveLastPageUseCase: gh<_i1044.SaveMushafLastPageUseCase>(),
        getBasePathUseCase: gh<_i1044.GetMushafBasePathUseCase>(),
      ),
    );
    gh.lazySingleton<_i219.GetRecitationsUseCase>(
      () => _i219.GetRecitationsUseCase(gh<_i818.IAudioRepository>()),
    );
    gh.lazySingleton<_i298.QiblaRepository>(
      () => _i135.QiblaRepositoryImpl(
        gh<_i198.CompassDatasource>(),
        gh<_i1059.VibrationDatasource>(),
      ),
    );
    gh.lazySingleton<_i626.GetSurahNavigationUseCase>(
      () => _i626.GetSurahNavigationUseCase(
        gh<_i31.ISurahNavigationRepository>(),
      ),
    );
    gh.lazySingleton<_i570.GetSurahInfoUseCase>(
      () => _i570.GetSurahInfoUseCase(gh<_i723.ISurahInfoRepository>()),
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
    gh.lazySingleton<_i33.GetTajweedRulesUseCase>(
      () => _i33.GetTajweedRulesUseCase(gh<_i619.TajweedGuideRepository>()),
    );
    gh.factory<_i76.SetupBloc>(
      () => _i76.SetupBloc(
        getSetupResourcesUseCase: gh<_i930.GetSetupResourcesUseCase>(),
        saveSetupPreferencesUseCase: gh<_i144.SaveSetupPreferencesUseCase>(),
      ),
    );
    gh.lazySingleton<_i126.AddHistoryUseCase>(
      () => _i126.AddHistoryUseCase(gh<_i170.IHistoryRepository>()),
    );
    gh.lazySingleton<_i289.GetHistoryUseCase>(
      () => _i289.GetHistoryUseCase(gh<_i170.IHistoryRepository>()),
    );
    gh.factory<_i708.DownloadCubit>(
      () => _i708.DownloadCubit(
        downloadSetupResourcesUseCase:
            gh<_i1025.DownloadSetupResourcesUseCase>(),
      ),
    );
    gh.factory<_i103.OthersSettingsCubit>(
      () => _i103.OthersSettingsCubit(
        getSettingsUseCase: gh<_i70.GetSettingsUseCase>(),
        saveSettingsUseCase: gh<_i272.SaveSettingsUseCase>(),
      ),
    );
    gh.lazySingleton<_i153.CalculateQiblaAngleUseCase>(
      () => _i153.CalculateQiblaAngleUseCase(gh<_i298.QiblaRepository>()),
    );
    gh.lazySingleton<_i760.GetCompassHeadingUseCase>(
      () => _i760.GetCompassHeadingUseCase(gh<_i298.QiblaRepository>()),
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
    gh.factory<_i900.QuranHistoryCubit>(
      () => _i900.QuranHistoryCubit(
        getHistoryUseCase: gh<_i289.GetHistoryUseCase>(),
        addHistoryUseCase: gh<_i126.AddHistoryUseCase>(),
      ),
    );
    gh.factory<_i236.QiblaCubit>(
      () => _i236.QiblaCubit(
        gh<_i760.GetCompassHeadingUseCase>(),
        gh<_i153.CalculateQiblaAngleUseCase>(),
        gh<_i979.TriggerAlignmentVibrationUseCase>(),
      ),
    );
    gh.factory<_i462.TajweedGuideCubit>(
      () => _i462.TajweedGuideCubit(
        getTajweedRulesUseCase: gh<_i33.GetTajweedRulesUseCase>(),
      ),
    );
    return this;
  }
}
