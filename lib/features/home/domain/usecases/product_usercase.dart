import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/repositories/product_repository.dart';

class ProductsUseCase {
  final ProductRepository repository;

  ProductsUseCase(this.repository);

  Future<List<ProductModel>> call() {
    return repository.getProducts();
  }
}
