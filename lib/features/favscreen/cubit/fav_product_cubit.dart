import 'package:bloc/bloc.dart';
import 'package:marketi/features/favscreen/data/repos/favProductRepo.dart';
import 'package:marketi/features/favscreen/favmodels/FavModel.dart';
import 'package:meta/meta.dart';

part 'fav_product_state.dart';

class FavProductCubit extends Cubit<FavProductState> {
  final Favproductrepo repositorty;
  FavProductCubit(this.repositorty) : super(FavProductInitial());

  Future<void> GetFavProducts() async {
    emit(FavProductLoading());
    try {
      final products = await repositorty.GetAllFavProducts();
      emit(FavProductLoaded(products));
    } catch (e) {
      emit(FavProductError(e.toString()));
    }
  }
}
