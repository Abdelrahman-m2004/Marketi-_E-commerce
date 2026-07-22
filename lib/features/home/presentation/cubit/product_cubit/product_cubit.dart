import 'package:bloc/bloc.dart';
import 'package:marketi/core/constants/search_type_enum.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:marketi/features/home/presentation/helper/home_helper.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsUseCase productsUseCase;

  ProductCubit(this.productsUseCase) : super(ProductInitial());

  List<ProductModel> _allProducts = [];       // البيانات الخام المجلوبة من الـ API
  List<ProductModel> _categoryProducts = [];  // البيانات المفلترة حسب القسم (popular, best...)

  /// 1️⃣ جلب المنتجات وتطبيق فلتر القسم عليها
  Future<void> getProducts({SearchType searchType = SearchType.general}) async {
    emit(ProductLoading());

    try {
      final products = await productsUseCase();
      _allProducts = products;

      // تحديث قائمة القسم بناءً على الـ searchType
      switch (searchType) {
        case SearchType.popular:
          _categoryProducts = HomeHelper.popular(_allProducts);
          break;
        case SearchType.best:
          _categoryProducts = HomeHelper.best(_allProducts);
          break;
        case SearchType.buyAgain:
          _categoryProducts = HomeHelper.buyAgain(_allProducts);
          break;
        case SearchType.general:
        default:
          _categoryProducts = List.from(_allProducts);
          break;
      }

      emit(ProductLoaded(_categoryProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  /// 2️⃣ البحث يكون داخل قائمة القسم المحدد فقط (_categoryProducts)
  void search(String keyword) {
    if (keyword.trim().isEmpty) {
      // إرجاع قائمة القسم الأصلية عند تفريغ البحث
      emit(ProductLoaded(_categoryProducts));
      return;
    }

    // الفلترة تتم فقط على المنتجات الخاصة بالقسم المختار
    final result = HomeHelper.search(_categoryProducts, keyword);

    emit(ProductLoaded(result));
  }
}
