// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:marketi/core/Network/Api_client.dart' as _i924;
import 'package:marketi/core/service/service_locator.dart' as _i779;
import 'package:marketi/features/profile/data/data_source/local_data_source.dart'
    as _i681;
import 'package:marketi/features/profile/data/data_source/remote_data_source.dart'
    as _i464;
import 'package:marketi/features/profile/data/repository/profile_repository_impl.dart'
    as _i1052;
import 'package:marketi/features/profile/domain/repository/profile_repository.dart'
    as _i789;
import 'package:marketi/features/profile/domain/use_case/get_profile_use_case.dart'
    as _i957;
import 'package:marketi/features/profile/domain/use_case/get_theme_use_case.dart'
    as _i132;
import 'package:marketi/features/profile/domain/use_case/save_theme_use_case.dart'
    as _i914;
import 'package:marketi/features/profile/domain/use_case/update_profile_use_case.dart'
    as _i40;
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart'
    as _i732;
import 'package:marketi/features/profile/presentation/cubit/theme_cubit/theme_cubit.dart'
    as _i331;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i924.ApiClient>(() => registerModule.apiClient);
    gh.lazySingleton<_i681.LocalDataSource>(
      () => _i681.LocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i464.ProfileRemoteDataSource>(
      () => _i464.ProfileRemoteDataSourceImpl(gh<_i924.ApiClient>()),
    );
    gh.lazySingleton<_i789.ProfileRepository>(
      () => _i1052.ProfileRepositoryImpl(
        gh<_i681.LocalDataSource>(),
        gh<_i464.ProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i957.GetProfileUseCase>(
      () => _i957.GetProfileUseCase(gh<_i789.ProfileRepository>()),
    );
    gh.lazySingleton<_i132.GetThemeUseCase>(
      () => _i132.GetThemeUseCase(repository: gh<_i789.ProfileRepository>()),
    );
    gh.lazySingleton<_i914.SaveThemeUseCase>(
      () => _i914.SaveThemeUseCase(repository: gh<_i789.ProfileRepository>()),
    );
    gh.lazySingleton<_i40.UpdateProfileUseCase>(
      () => _i40.UpdateProfileUseCase(gh<_i789.ProfileRepository>()),
    );
    gh.factory<_i331.ThemeCubit>(
      () => _i331.ThemeCubit(
        gh<_i132.GetThemeUseCase>(),
        gh<_i914.SaveThemeUseCase>(),
      ),
    );
    gh.factory<_i732.ProfileCubit>(
      () => _i732.ProfileCubit(
        gh<_i957.GetProfileUseCase>(),
        gh<_i40.UpdateProfileUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i779.RegisterModule {}
