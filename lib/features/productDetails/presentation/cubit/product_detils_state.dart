part of 'product_detils_cubit.dart';

@immutable
sealed class ProductDetilsState {}

final class ProductDetilsInitial extends ProductDetilsState {}

final class productDetildLoading extends ProductDetilsState {}

final class productDetailsLoaded extends ProductDetilsState {
  final Productdetailsentity productdetailsentity;

  productDetailsLoaded({required this.productdetailsentity});
}

final class productDetailsErorr extends ProductDetilsState {
  final String message;

  productDetailsErorr({required this.message});
}
