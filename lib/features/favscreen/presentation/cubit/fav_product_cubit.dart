import 'package:bloc/bloc.dart';
import 'package:marketi/features/favscreen/domain/UseCase/getFavProduct.dart';
import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';
import 'package:meta/meta.dart';

part 'fav_product_state.dart';

class FavProductCubit extends Cubit<FavProductState> {
  final Getfavproduct favproduct;
  FavProductCubit(this.favproduct) : super(FavProductInitial());

  Future<void> GetFavProducts() async {
    emit(FavProductLoading());
    try {
      final products = await favproduct();
      emit(FavProductLoaded(products));
    } catch (e) {
      emit(FavProductError(e.toString()));
    }
  }
}
