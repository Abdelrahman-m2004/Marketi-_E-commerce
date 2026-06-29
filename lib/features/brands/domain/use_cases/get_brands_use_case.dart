import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/brands/domain/entities/brand_entity.dart';
import 'package:marketi/features/brands/domain/repositories/brands_repository.dart';

@lazySingleton
class GetBrandsUseCase {
  final BrandsRepository _repository;

  GetBrandsUseCase(this._repository);

  Future<Either<Failure, List<BrandEntity>>> call() {
    return _repository.getBrands();
  }
}
