class CartItemModel {
  final int itemId;
  final String imagePath;
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  int quantity;
  bool isFavorite;

  CartItemModel({
    required this.itemId,
    required this.imagePath,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    this.quantity = 1,
    this.isFavorite = false,
  });
}