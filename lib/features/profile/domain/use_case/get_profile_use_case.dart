import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';
import 'package:marketi/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class GetProfileUseCase {
  final ProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);
  Future<Either<Failure, UserEntity>> call() async {
    return _profileRepository.getProfile();
  }
}
