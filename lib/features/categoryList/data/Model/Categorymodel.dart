import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';

class CategoryModel extends Categoryentity {
  CategoryModel({required super.image, required super.categoryName});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: 'https://marketi.newcinderella.online/storage/${json['image']}',
      categoryName: json['name'],
    );
  }
}
