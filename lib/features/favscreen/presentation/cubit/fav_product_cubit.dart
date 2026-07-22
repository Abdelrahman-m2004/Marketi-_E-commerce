import 'package:bloc/bloc.dart';
import 'package:marketi/features/favscreen/domain/UseCase/getFavProduct.dart';
import 'package:marketi/features/favscreen/domain/entites/FavEntity.dart';
import 'package:meta/meta.dart';

part 'fav_product_state.dart';

class FavProductCubit extends Cubit<FavProductState> {
  final Getfavproduct favproduct;
  Faventity? allData;
  FavProductCubit(this.favproduct) : super(FavProductInitial());

  void search(String text) {
    if (allData == null) return;
    final filtered = allData!.favProducts.where((product) {
      return product.productName.toLowerCase().contains(text.toLowerCase());
    }).toList();

    emit(
      FavProductLoaded(
        Faventity(
          favProducts: filtered,
          currentPage: allData!.currentPage,
          totalProducts: filtered.length,
        ),
      ),
    );
  }

  Future<void> GetFavProducts() async {
    emit(FavProductLoading());
    try {
      final products = await favproduct();
      allData = products;
      emit(FavProductLoaded(products));
    } catch (e) {
      emit(FavProductError(e.toString()));
    }
  }
}
