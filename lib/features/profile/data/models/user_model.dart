import 'package:marketi/features/profile/domain/entity/profile_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.countryPhoneCode,
    required super.role,
    required super.isActive,
    super.profileImage,
    super.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      countryPhoneCode: json['country_phone_code'],
      role: json['role'],
      isActive: json['is_active'],
      profileImage: json['profile_image'],
      profile: json['profile'] != null
          ? ProfileModel.fromJson(json['profile'])
          : null,
    );
  }
}

class ProfileModel extends ProfileEntity {
  ProfileModel({required super.id, super.address, super.city, super.country});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }
}
