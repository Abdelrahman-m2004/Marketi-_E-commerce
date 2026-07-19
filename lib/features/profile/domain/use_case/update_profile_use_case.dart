import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/profile/data/models/update_profile_request.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@LazySingleton()
class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  Future<Either<Failure, void>> call(UpdateProfileRequest updateProfile) =>
      profileRepository.updateProfile(updateProfile);
}
