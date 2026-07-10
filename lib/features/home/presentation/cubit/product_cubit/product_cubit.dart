import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsUseCase productsUseCase;

  ProductCubit(this.productsUseCase) : super(ProductInitial());

  List<ProductModel> _allProducts = [];

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await productsUseCase();

      _allProducts = products;

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void search(String keyword) {
    if (keyword.trim().isEmpty) {
      emit(ProductLoaded(_allProducts));
      return;
    }

    final result = HomeHelper.search(_allProducts, keyword);

    emit(ProductLoaded(result));
  }
}
