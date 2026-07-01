part of 'fav_product_cubit.dart';

@immutable
sealed class FavProductState {}

final class FavProductInitial extends FavProductState {}

final class FavProductLoading extends FavProductState {}

final class FavProductLoaded extends FavProductState {
  final FavModel FavProducts;
  FavProductLoaded(this.FavProducts);
}

final class FavProductError extends FavProductState {
  final String massages;
  FavProductError(this.massages);
}
