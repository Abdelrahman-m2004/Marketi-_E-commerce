import 'package:marketi/features/productDetails/data/model/productImageModel.dart';
import 'package:marketi/features/productDetails/data/model/productSizeModel.dart';
import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';

class Productdetailsmodel extends Productdetailsentity {
  Productdetailsmodel({
    required super.name,
    required super.descrption,
    required super.image,
    required super.price,
    required super.rating,
    required super.sizes,
    required super.images,
  });
  factory Productdetailsmodel.fromJson(Map<String, dynamic> json) {
    return Productdetailsmodel(
      name: json['name'],
      descrption: json['description'],
      image: json['main_image_url'],
      price: json['price'],
      rating: json['rating'],
      images: (json['images'] as List)
          .map((e) => Productimagemodel.fromJson(e))
          .toList(),
      sizes: (json['sizes'] as List)
          .map((e) => Productsizemodel.fromJson(e))
          .toList(),
    );
  }
}
