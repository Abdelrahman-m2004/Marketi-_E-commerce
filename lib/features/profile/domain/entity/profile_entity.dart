class UserEntity {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String countryPhoneCode;
  final String role;
  final bool isActive;
  final String? profileImage;
  final ProfileEntity? profile;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.countryPhoneCode,
    required this.role,
    required this.isActive,
    this.profileImage,
    this.profile,
  });
}

class ProfileEntity {
  final int id;
  final String? address;
  final String? city;
  final String? country;

  ProfileEntity({required this.id, this.address, this.city, this.country});
}
