import 'package:marketi/features/favscreen/domain/entites/favProductEntity.dart';

class productFavModel extends Favproductentity {
  productFavModel({
    required super.imagePath,
    required super.price,
    required super.rating,
    required super.productName,
  });

  factory productFavModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'];
    return productFavModel(
      imagePath: product['main_image_url'],
      price: product['price'],
      rating: product['rating'],
      productName: product['name'],
    );
  }
}
