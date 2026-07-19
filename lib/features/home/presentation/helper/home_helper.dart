import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class HomeHelper {
  /// الأكثر مبيعاً
  static List<ProductModel> popular(List<ProductModel> products) {
    final list = List<ProductModel>.from(products);

    list.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));

    return list.take(5).toList();
  }

  /// الأعلى تقييماً
  static List<ProductModel> best(List<ProductModel> products) {
    final list = List<ProductModel>.from(products);
    list.sort((a, b) {
      final ratingA = double.tryParse(a.rating) ?? 0.0;
      final ratingB = double.tryParse(b.rating) ?? 0.0;
      return ratingB.compareTo(ratingA);
    });
    return list.take(5).toList();
  }

  /// اشترِ مرة أخرى
  static List<ProductModel> buyAgain(List<ProductModel> products) {
    return products.take(5).toList();
  }

  /// البحث
  static List<ProductModel> search(
    List<ProductModel> products,
    String keyword,
  ) {
    return products.where((product) {
      return product.name.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }

  static final fakeProducts = List.generate(
    5,
    (_) => ProductModel(
      id: 0,
      name: '',
      description: '',
      price: '',
      rating: '',
      ratingCount: 0,
    ),
  );
  static final fakeCategory = List.generate(
    5,
    (_) => CategoryModel(image: '', categoryName: ''),
  );
  static final fakeBrand = List.generate(
    5,
    (_) => BrandModel(image: '',),
  );
}
