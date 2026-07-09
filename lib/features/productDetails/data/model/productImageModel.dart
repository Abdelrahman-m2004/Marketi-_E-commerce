import 'package:marketi/features/productDetails/domain/entites/productImageEntity.dart';

class Productimagemodel extends Productimageentity {
  Productimagemodel({required super.id, required super.image_Url});

  factory Productimagemodel.fromJson(Map<String, dynamic> json) {
    return Productimagemodel(id: json['id'], image_Url: json['image_url']);
  }
}
