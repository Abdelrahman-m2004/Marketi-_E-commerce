import 'package:marketi/core/Network/Apiconstant.dart';

class CategoryModel {
  final String image;
  final String categoryName;
  CategoryModel({required this.image, required this.categoryName});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: 'https://marketi.newcinderella.online/storage/${json['image']}',
      categoryName: json['name'],
    );
  }
}