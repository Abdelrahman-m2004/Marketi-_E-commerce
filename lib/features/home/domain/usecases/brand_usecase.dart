import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/domain/repositories/brand_repository.dart';

class BrandUsecase {
  final BrandRepository repository;

  BrandUsecase(this.repository);

  Future<List<BrandModel>> call() {
    return repository.getBrands();
  }
}
