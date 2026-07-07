import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/domain/usecases/category_usecase.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryUsecase categoryUsecase;
  CategoryCubit(this.categoryUsecase) : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await categoryUsecase();
      emit(Categoryloaded(categories));
    } catch (e) {
      emit(CategoryErorr(e.toString()));
    }
  }
}
