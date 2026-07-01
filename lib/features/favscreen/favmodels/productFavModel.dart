class productFavModel {
  final String imagePath;
  final String price;
  final String rating;
  final String productName;

  productFavModel({
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.productName,
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
