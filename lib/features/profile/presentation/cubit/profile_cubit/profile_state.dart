import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity userEntity;
  ProfileSuccess(this.userEntity);
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileFailure extends ProfileState {
  final String message;
  UpdateProfileFailure(this.message);
}
