import 'package:bloc/bloc.dart';
import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';
import 'package:marketi/features/categoryList/domain/UseCase/getAllCategory.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final Getallcategory allCategory;
  CategoryCubit(this.allCategory) : super(CategoryInitial());

  Future<void> GetCategories() async {
    emit(categoryLoading());
    try {
      final categories = await allCategory();
      emit(categoryloaded(categories));
    } catch (e) {
      emit(categoryErorr(e.toString()));
    }
  }
}
