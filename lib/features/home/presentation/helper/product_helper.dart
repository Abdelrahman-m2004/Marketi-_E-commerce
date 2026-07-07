

import 'package:marketi/features/home/data/models/product_model.dart';

class ProductHelper {
  /// الأكثر مبيعاً
  static List<ProductModel> popular(List<ProductModel> products) {
    final list = List<ProductModel>.from(products);

    list.sort(
      (a, b) => b.ratingCount.compareTo(a.ratingCount),
    );

    return list.take(5).toList();
  }

  /// الأعلى تقييماً
  static List<ProductModel> best(List<ProductModel> products) {
    final list = List<ProductModel>.from(products);

    list.sort(
      (a, b) => b.rating.compareTo(a.rating),
    );

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
      return product.name
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();
  }
}