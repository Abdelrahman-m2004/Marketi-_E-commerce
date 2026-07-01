class UpdateProfileRequest {
  final String? name;
  final String? phone;
  final String? city;
  final String? image;
  final String? userName;

  UpdateProfileRequest({
    this.name,
    this.phone,
    this.city,
    this.image,
    this.userName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (city != null) data['city'] = city;
    if (image != null) data['image'] = image;
    if (userName != null) data['username'] = userName;
    return data;
  }
}
