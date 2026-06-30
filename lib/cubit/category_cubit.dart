import 'package:bloc/bloc.dart';
import 'package:marketi/class/Categorymodel.dart';
import 'package:marketi/data/repository/categoryRepository.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final Categoryrepository repository;
  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> GetCategories() async {
    emit(categoryLoading());
    try {
      final categories = await repository.GetAllCategory();
      emit(categoryloaded(categories));
    } catch (e) {
      emit(categoryErorr(e.toString()));
    }
  }
}
