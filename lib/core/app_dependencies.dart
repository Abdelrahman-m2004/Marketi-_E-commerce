import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/features/home/data/data_source/brand_remote_datesource.dart';
import 'package:marketi/features/home/data/data_source/category_remote_datesourse.dart';

// Product
import 'package:marketi/features/home/data/data_source/product_remote_datesourse.dart';
import 'package:marketi/features/home/data/repositories/brand_repositoryImpl.dart';
import 'package:marketi/features/home/data/repositories/category_repository_impl.dart';
import 'package:marketi/features/home/data/repositories/podust_repository_impl.dart';
import 'package:marketi/features/home/domain/usecases/brand_usecase.dart';
import 'package:marketi/features/home/domain/usecases/category_usecase.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:marketi/features/home/presentation/cubit/brand_cubit/brand_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';

class AppDependencies {
  AppDependencies() {
    _initProduct();
    _initCategory();
    _initBrand();
  }

  /// Shared
  final apiServices = ApiServices();

  // ================= Product =================

  late final ProductRemoteDatasource productRemoteDatasource;
  late final ProductRepositoryImpl productRepository;
  late final ProductsUseCase productUseCase;
  late final ProductCubit productCubit;

  void _initProduct() {
    productRemoteDatasource = ProductRemoteDatasource(
      apiServices: apiServices,
    );

    productRepository = ProductRepositoryImpl(
      remoteDatasource: productRemoteDatasource,
    );

    productUseCase = ProductsUseCase(productRepository);

    productCubit = ProductCubit(productUseCase);
  }

  // // ================= Category =================

  late final CategoryRemoteDatesourse categoryRemoteDatasource;
  late final CategoryRepositoryImpl categoryRepository;
  late final CategoryUsecase categoryUseCase;
  late final CategoryCubit categoryCubit;

  void _initCategory() {
    categoryRemoteDatasource = CategoryRemoteDatesourse(
      apiServices: apiServices,
    );

    categoryRepository = CategoryRepositoryImpl(
      categoryRemoteDatesourse: categoryRemoteDatasource
    );

    categoryUseCase = CategoryUsecase(categoryRepository);

    categoryCubit = CategoryCubit(categoryUseCase);
  }

  ////brand
  late final BrandRemoteDatesource brandRemoteDatesource;
  late final BrandRepositoryimpl brandRepository;
  late final BrandUsecase brandUsecase;
  late final BrandCubit brandCubit;

  void _initBrand() {
    brandRemoteDatesource = BrandRemoteDatesource(
      apiServices: apiServices,
    );

    brandRepository = BrandRepositoryimpl(
      apiServices: apiServices
    );

    brandUsecase = BrandUsecase(brandRepository);

    brandCubit = BrandCubit(brandRepository);
  }
}
final appDependencies = AppDependencies();