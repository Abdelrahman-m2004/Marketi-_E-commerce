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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i924.ApiClient>(() => registerModule.apiClient);
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
    return this;
  }
}

class _$RegisterModule extends _i779.RegisterModule {}
