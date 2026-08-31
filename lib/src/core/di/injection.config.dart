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
import 'package:al_quran_v3/src/features/audio/presentation/cubit/sleep_timer_cubit.dart'
    as _i551;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart'
    as _i81;
import 'package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart'
    as _i348;
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
import 'package:al_quran_v3/src/features/surah_list/data/datasources/surah_navigation_local_datasource.dart'
    as _i662;
import 'package:al_quran_v3/src/features/surah_list/data/repositories/surah_navigation_repository_impl.dart'
    as _i571;
import 'package:al_quran_v3/src/features/surah_list/domain/repositories/i_surah_navigation_repository.dart'
    as _i31;
import 'package:al_quran_v3/src/features/surah_list/domain/usecases/get_surah_navigation_usecase.dart'
    as _i626;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i81.QuranViewCubit>(() => _i81.QuranViewCubit());
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
    gh.lazySingleton<_i551.SleepTimerCubit>(() => _i551.SleepTimerCubit());
    gh.lazySingleton<_i348.WordPlayingStateCubit>(
      () => _i348.WordPlayingStateCubit(),
    );
    gh.lazySingleton<_i584.SettingsLocalDataSource>(
      () => _i584.SettingsLocalDataSource(),
    );
    gh.lazySingleton<_i662.SurahNavigationLocalDataSource>(
      () => _i662.SurahNavigationLocalDataSource(),
    );
    gh.lazySingleton<_i881.ISettingsRepository>(
      () => _i197.SettingsRepositoryImpl(gh<_i584.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i914.IAboutRepository>(
      () => _i294.AboutRepositoryImpl(gh<_i190.AboutLocalDataSource>()),
    );
    gh.factoryParam<_i178.LanguageCubit, _i498.MyAppLocalization?, dynamic>(
      (initialLocale, _) => _i178.LanguageCubit(initialLocale),
    );
    gh.lazySingleton<_i31.ISurahNavigationRepository>(
      () => _i571.SurahNavigationRepositoryImpl(
        gh<_i662.SurahNavigationLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i818.IAudioRepository>(
      () => _i588.AudioRepositoryImpl(gh<_i712.AudioLocalDataSource>()),
    );
    gh.lazySingleton<_i511.GetAppInfoUseCase>(
      () => _i511.GetAppInfoUseCase(gh<_i914.IAboutRepository>()),
    );
    gh.lazySingleton<_i70.GetSettingsUseCase>(
      () => _i70.GetSettingsUseCase(gh<_i881.ISettingsRepository>()),
    );
    gh.lazySingleton<_i272.SaveSettingsUseCase>(
      () => _i272.SaveSettingsUseCase(gh<_i881.ISettingsRepository>()),
    );
    gh.lazySingleton<_i219.GetRecitationsUseCase>(
      () => _i219.GetRecitationsUseCase(gh<_i818.IAudioRepository>()),
    );
    gh.lazySingleton<_i626.GetSurahNavigationUseCase>(
      () => _i626.GetSurahNavigationUseCase(
        gh<_i31.ISurahNavigationRepository>(),
      ),
    );
    gh.factory<_i103.OthersSettingsCubit>(
      () => _i103.OthersSettingsCubit(
        getSettingsUseCase: gh<_i70.GetSettingsUseCase>(),
        saveSettingsUseCase: gh<_i272.SaveSettingsUseCase>(),
      ),
    );
    return this;
  }
}
