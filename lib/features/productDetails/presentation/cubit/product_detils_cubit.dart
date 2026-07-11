import 'package:bloc/bloc.dart';
import 'package:marketi/features/productDetails/domain/entites/productDetailsEntity.dart';
import 'package:marketi/features/productDetails/domain/useCase/getAllProuductDet.dart';
import 'package:meta/meta.dart';

part 'product_detils_state.dart';

class ProductDetilsCubit extends Cubit<ProductDetilsState> {
  final Getallprouductdet prosuctDetails;
  ProductDetilsCubit(this.prosuctDetails) : super(ProductDetilsInitial());

  Future<void> getProductDetails(int id) async {
    emit(productDetildLoading());
    try {
      final productDetails = await prosuctDetails(id);
      emit(productDetailsLoaded(productdetailsentity: productDetails));
    } catch (e) {
      emit(productDetailsErorr(message: e.toString()));
    }
  }
}
