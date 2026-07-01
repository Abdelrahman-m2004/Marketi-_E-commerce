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
