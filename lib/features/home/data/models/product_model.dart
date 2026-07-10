class ProductModel {

  final String name;
  final String description;
  final String price;
  final String rating;
  final int ratingCount;
  final String? imageUrl;

  ProductModel({

    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.ratingCount,
     this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(

      name: json['name'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      ratingCount: json['rating_count'],
      imageUrl: json['main_image_url'],
    );
  }
}