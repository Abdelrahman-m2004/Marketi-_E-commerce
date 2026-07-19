import 'package:marketi/features/productDetails/data/model/productImageModel.dart';
import 'package:marketi/features/productDetails/data/model/productSizeModel.dart';
import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';

class Productdetailsmodel extends Productdetailsentity {
  const Productdetailsmodel({
    required super.id,
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
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      descrption: (json['description'] as String?) ?? '',
      image: (json['main_image_url'] as String?) ?? '',
      price: json['price']?.toString() ?? '0',
      rating: json['rating']?.toString() ?? '0',
      images: (json['images'] as List? ?? [])
          .map((e) => Productimagemodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List? ?? [])
          .map((e) => Productsizemodel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
