import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/error/failure.dart';
import 'package:marketi/features/profile/data/data_source/local_data_source.dart';
import 'package:marketi/features/profile/data/data_source/remote_data_source.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final LocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<bool> getThemeMode() => _localDataSource.isDarkMode();

  @override
  Future<void> saveThemeMode(bool isDark) =>
      _localDataSource.cacheTheme(isDark);

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final response = await _remoteDataSource.getProfile();
      return Right(response);
    } catch (e) {
      return Left((ServerFailure(e.toString())));
    }
  }
}
