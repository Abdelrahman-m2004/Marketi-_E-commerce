import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/profile/data/models/update_profile_request.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<bool> getThemeMode();
  Future<void> saveThemeMode(bool isDark);
  Future<Either<Failure, UserEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile(
    UpdateProfileRequest updateProfile,
  );
}
