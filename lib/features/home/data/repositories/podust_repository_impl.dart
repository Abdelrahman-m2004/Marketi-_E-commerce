import 'package:marketi/features/home/data/data_source/product_remote_datesourse.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ProductModel>> getProducts() async {
    return await remoteDatasource.getProducts();
  }
}
