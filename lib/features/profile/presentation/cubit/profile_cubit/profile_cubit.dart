import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/profile/data/models/update_profile_request.dart';
import 'package:marketi/features/profile/domain/entity/profile_entity.dart';
import 'package:marketi/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:marketi/features/profile/domain/use_case/update_profile_use_case.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit(this._getProfileUseCase, this._updateProfileUseCase)
    : super(ProfileInitial());

  final ImagePicker _picker = ImagePicker();

  UserEntity? user;
  File? profileImage;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await _getProfileUseCase();

    result.fold((failure) => emit(ProfileFailure(failure.message)), (
      userEntity,
    ) {
      user = userEntity;
      emit(ProfileSuccess(userEntity));
    });
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      profileImage = File(image.path);

      // إعادة بناء الـ UI مع الاحتفاظ بالـ user
      if (user != null) {
        emit(ProfileSuccess(user!));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    emit(UpdateProfileLoading());

    final result = await _updateProfileUseCase(
      request.copyWith(image: profileImage),
    );

    result.fold((failure) => emit(UpdateProfileFailure(failure.message)), (
      _,
    ) async {
      // إعادة تحميل البيانات بعد التحديث
      await getProfile();
    });
  }
}
