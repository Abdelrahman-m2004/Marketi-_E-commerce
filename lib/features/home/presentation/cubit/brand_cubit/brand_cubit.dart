import 'package:bloc/bloc.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/repositories/brand_repository.dart';
import 'package:meta/meta.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
    final BrandRepository repository;

  BrandCubit(this.repository) : super(BrandInitial());

  Future<void> getBrands() async {
    emit(BrandLoading());

    try {
      final brands = await repository.getBrands();
      emit(BrandLoaded(brands));
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }

}
