import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/features/brands/domain/use_cases/get_brands_use_case.dart';
import 'brands_state.dart';

@injectable
class BrandsCubit extends Cubit<BrandsState> {
  final GetBrandsUseCase _getBrandsUseCase;

  BrandsCubit(this._getBrandsUseCase) : super(BrandsInitial());

  Future<void> fetchBrands() async {
    emit(BrandsLoading());
    final result = await _getBrandsUseCase.call();
    result.fold(
      (failure) => emit(BrandsError(failure.message)),
      (brands) {
        if (brands.isEmpty) {
          emit(BrandsEmpty());
        } else {
          emit(BrandsSuccess(brands));
        }
      },
    );
  }
}
