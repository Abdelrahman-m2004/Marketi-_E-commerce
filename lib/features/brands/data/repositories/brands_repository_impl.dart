import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/brands/data/data_sources/brands_remote_data_source.dart';
import 'package:marketi/features/brands/domain/entities/brand_entity.dart';
import 'package:marketi/features/brands/domain/repositories/brands_repository.dart';

@LazySingleton(as: BrandsRepository)
class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource _remoteDataSource;

  BrandsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands() async {
    try {
      final remoteBrands = await _remoteDataSource.getBrands();
      final entities = remoteBrands.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
