import 'package:dartz/dartz.dart';
import 'package:marketi/core/error/failure.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<bool> getThemeMode();
  Future<void> saveThemeMode(bool isDark);
  Future<Either<Failure, UserEntity>> getProfile();
}
