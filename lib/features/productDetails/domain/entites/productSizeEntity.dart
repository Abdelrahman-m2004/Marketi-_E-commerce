class Productsizeentity {
  final int product_id;
  final String size;
  final int quantity;
  final double? price;

  Productsizeentity({
    required this.product_id,
    required this.size,
    required this.quantity,
    this.price,
  });
}
