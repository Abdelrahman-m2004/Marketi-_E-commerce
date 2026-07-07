import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsUseCase productsUseCase;

  ProductCubit(this.productsUseCase) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());

    try {
      final products = await productsUseCase();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  
}




  // List<ProductModel> get popularProducts {
  //   final list = List<ProductModel>.from(products);

  //   list.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));

  //   return list.take(5).toList();
  // }

  // List<ProductModel> get bestProducts {
  //   final list = List<ProductModel>.from(products);

  //   list.sort((a, b) => b.rating.compareTo(a.rating));

  //   return list.take(5).toList();
  // }

  // List<ProductModel> get buyAgainProducts {
  //   return products.take(5).toList();
  // }