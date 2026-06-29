import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/brands/domain/entities/brand_entity.dart';

abstract class BrandsRepository {
  Future<Either<Failure, List<BrandEntity>>> getBrands();
}
