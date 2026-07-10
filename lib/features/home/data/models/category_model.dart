


class CategoryModel {
  final String? image;
  final String categoryName;
  CategoryModel({this.image, required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: 'https://marketi.newcinderella.online/storage/${json['image']}',
      categoryName: json['name'],
    );
  }
}