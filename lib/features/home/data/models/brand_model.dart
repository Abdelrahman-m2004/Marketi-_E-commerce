class BrandModel {
  final String? image;
  BrandModel({ this.image});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      image: 'https://marketi.newcinderella.online/storage/${json['logo']}',
    );
  }
}
