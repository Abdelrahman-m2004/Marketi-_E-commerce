import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/data/ApiService/api_services.dart';
import 'package:marketi/features/home/data/repositories/brand_repository.dart';
import 'package:marketi/features/home/data/repositories/category_repository.dart';
import 'package:marketi/features/home/data/repositories/podust_repository.dart';
import 'package:marketi/features/home/presentation/cubit/brand_cubit/brand_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/widget/advertising_card.dart';
import 'package:marketi/features/home/presentation/widget/brand_list.dart';
import 'package:marketi/features/home/presentation/widget/build_list_of_best_for_you.dart';
import 'package:marketi/features/home/presentation/widget/build_list_of_buy_again.dart';

import 'package:marketi/features/home/presentation/widget/build_list_of_popular_product.dart';
import 'package:marketi/features/home/presentation/widget/category_list.dart';
import 'package:marketi/features/home/presentation/widget/home_appbar.dart';
import 'package:marketi/features/home/presentation/widget/super_title_view_all.dart';

class HomeWidgetContent extends StatelessWidget {
  const HomeWidgetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        HomeAppBar(
              imagePath: 'assets/image/avatare.png',
              customerName: 'yousef',
            ),
        Expanded(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    CategoryCubit(CategoryRepository(apiServices: ApiServices()))
                      ..GetCategories(),
              ),
              BlocProvider(
                create: (_) =>
                    BrandCubit(BrandRepository(apiServices: ApiServices()))
                      ..getBrands(),
              ),
              BlocProvider(
                create: (_) =>
                    ProductCubit(ProductRepository(apiServices: ApiServices()))
                      ..getProducts(),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
            
                  AdvertisingCard(),
                  
                  SuperTitleViewAll(superTitleName: 'Popular Product'),
                  SizedBox(height: 5),
                  BuildListOfPopularProduct(),
                  SizedBox(height: 5),
                  SuperTitleViewAll(superTitleName: 'Category'),
                  CategoryList(),
                  SizedBox(height: 5),
                  SuperTitleViewAll(superTitleName: 'Best For You'),
                  BuildListOfBestForYou(),
                  SizedBox(height: 5),
                  SuperTitleViewAll(superTitleName: 'Brand'),
                  BrandList(),
                  SizedBox(height: 5),
                  SuperTitleViewAll(superTitleName: 'Buy Again'),
                  BuildListOfBuyAgain(),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
