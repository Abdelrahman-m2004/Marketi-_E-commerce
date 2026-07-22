import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/data/models/update_profile_request.dart';
import 'package:marketi/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:marketi/features/profile/domain/use_case/update_profile_use_case.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetProfileUseCase _getProfileUseCase;
  ProfileCubit(this._getProfileUseCase, this._updateProfileUseCase)
    : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await _getProfileUseCase.call();
     if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (userEntity) => emit(ProfileSuccess(userEntity)),
    );
  }

  Future<void> updateProfile(UpdateProfileRequest updateProfile) async {
    emit(UpdateProfileLoading());
    final result = await _updateProfileUseCase.call(updateProfile);
    result.fold(
      (failure) => emit(UpdateProfileFailure(failure.message)),
      (_) => emit(UpdateProfileSuccess()),
    );
  }
}
