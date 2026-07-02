import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/data/repositories/podust_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(ProductLoading());
    print('Products Count: ${products.length}');

    try {
      products = await repository.getProducts();
      emit(ProductLoaded(products));
      print('Products Count: ${products.length}');
    }  catch (e, stackTrace) {
    print('ERROR => $e');
    print(stackTrace);

    emit(ProductError(e.toString()));
  }
  }

  List<ProductModel> get popularProducts {
    final list = List<ProductModel>.from(products);

    list.sort((a, b) => b.ratingCount.compareTo(a.ratingCount));

    return list.take(5).toList();
  }

  List<ProductModel> get bestProducts {
    final list = List<ProductModel>.from(products);

    list.sort((a, b) => b.rating.compareTo(a.rating));

    return list.take(5).toList();
  }

  List<ProductModel> get buyAgainProducts {
    return products.take(5).toList();
  }
}
