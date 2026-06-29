import 'package:marketi/features/brands/domain/entities/brand_entity.dart';

abstract class BrandsState {
  const BrandsState();
}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsSuccess extends BrandsState {
  final List<BrandEntity> brands;
  const BrandsSuccess(this.brands);
}

class BrandsEmpty extends BrandsState {}

class BrandsError extends BrandsState {
  final String message;
  const BrandsError(this.message);
}
