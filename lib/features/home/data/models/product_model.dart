class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String rating;
  final int ratingCount;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.ratingCount,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '0',
      rating: json['rating']?.toString() ?? '0',
      ratingCount: json['rating_count'] ?? 0,
      imageUrl: json['main_image_url'],
    );
  }
}
