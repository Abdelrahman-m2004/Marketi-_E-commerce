import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/data/repositories/category_repository.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit_state.dart';



class CategoryCubit extends Cubit<CategoryState> {
  final  CategoryRepository repository;
  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> GetCategories() async {
    emit(categoryLoading());
    try {
      final categories = await repository.getCategories();
      emit(categoryloaded(categories));
    } catch (e) {
      emit(categoryErorr(e.toString()));
    }
  }
}