// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:marketi/core/Network/Api_client.dart' as _i924;
import 'package:marketi/core/service/service_locator.dart' as _i779;
import 'package:marketi/features/brands/data/data_sources/brands_remote_data_source.dart'
    as _i1063;
import 'package:marketi/features/brands/data/repositories/brands_repository_impl.dart'
    as _i56;
import 'package:marketi/features/brands/domain/repositories/brands_repository.dart'
    as _i136;
import 'package:marketi/features/brands/domain/use_cases/get_brands_use_case.dart'
    as _i1049;
import 'package:marketi/features/brands/presentation/cubit/brands_cubit.dart'
    as _i839;
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

    // Brands
    gh.lazySingleton<_i1063.BrandsRemoteDataSource>(
      () => _i1063.BrandsRemoteDataSourceImpl(gh<_i924.ApiClient>()),
    );
    gh.lazySingleton<_i136.BrandsRepository>(
      () => _i56.BrandsRepositoryImpl(gh<_i1063.BrandsRemoteDataSource>()),
    );
    gh.lazySingleton<_i1049.GetBrandsUseCase>(
      () => _i1049.GetBrandsUseCase(gh<_i136.BrandsRepository>()),
    );
    gh.factory<_i839.BrandsCubit>(
      () => _i839.BrandsCubit(gh<_i1049.GetBrandsUseCase>()),
    );

    // Profile
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
