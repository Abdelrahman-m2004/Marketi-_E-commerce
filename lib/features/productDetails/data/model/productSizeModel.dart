import 'package:marketi/features/productDetails/domain/entites/productSizeEntity.dart';

class Productsizemodel extends Productsizeentity {
  Productsizemodel({
    required super.product_id,
    required super.size,
    required super.quantity,
    super.price,
  });

  factory Productsizemodel.fromJson(Map<String, dynamic> json) {
    return Productsizemodel(
      product_id: json['product_id'],
      size: json['size'],
      quantity: json['stock_quantity'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
    );
  }
}
