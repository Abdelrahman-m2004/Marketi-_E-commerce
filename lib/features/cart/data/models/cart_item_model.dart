class CartItemModel {
  final int itemId;
  final int productId;
  final String imagePath;
  final String name;
  final String subtitle;
  double price;      // mutable — updated when size/quantity changes
  final double rating;
  int quantity;
  bool isFavorite;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.imagePath,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    this.quantity = 1,
    this.isFavorite = false,
  });
}
