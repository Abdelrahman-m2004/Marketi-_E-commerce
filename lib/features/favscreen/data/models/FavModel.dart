import 'package:marketi/features/favscreen/data/models/productFavModel.dart';
import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';

class FavModel extends Faventity {
  FavModel({
    required super.favProducts,
    required super.currentPage,
    required super.totalProducts,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return FavModel(
      favProducts: (data['data'] as List)
          .map((e) => productFavModel.fromJson(e))
          .toList(),
      currentPage: data['current_page'],
      totalProducts: data['total'],
    );
  }
}
