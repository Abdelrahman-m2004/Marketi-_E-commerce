import 'package:marketi/features/favscreen/domain/entites/favProductEntity.dart';

class Faventity {
  final List<Favproductentity> favProducts;
  final int currentPage;
  final int totalProducts;

  Faventity({
    required this.favProducts,
    required this.currentPage,
    required this.totalProducts,
  });
}
