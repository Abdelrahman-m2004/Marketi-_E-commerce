import 'package:marketi/features/favscreen/favmodels/productFavModel.dart';

class FavModel {
  final List<productFavModel> favProducts;
  final int currentPage;
  final int totalProducts;

  FavModel({
    required this.favProducts,
    required this.currentPage,
    required this.totalProducts,
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
