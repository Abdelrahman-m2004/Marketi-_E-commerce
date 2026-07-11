import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/core/app_dependencies.dart';
import 'package:marketi/core/constants/app_rout.dart';
import 'package:marketi/features/home/presentation/cubit/brand_cubit/brand_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/widget/advertising_card.dart';
import 'package:marketi/features/home/presentation/widget/brand_list.dart';
import 'package:marketi/features/home/presentation/widget/build_list_of_best_for_you.dart';
import 'package:marketi/features/home/presentation/widget/build_list_of_buy_again.dart';
import 'package:marketi/features/home/presentation/widget/build_list_of_popular_product.dart';
import 'package:marketi/features/home/presentation/widget/category_list.dart';
import 'package:marketi/features/home/presentation/widget/custom_search_button.dart';
import 'package:marketi/features/home/presentation/widget/home_appbar.dart';
import 'package:marketi/features/home/presentation/widget/super_title_view_all.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeWidgetContent extends StatefulWidget {
  const HomeWidgetContent({super.key});

  @override
  State<HomeWidgetContent> createState() => _HomeWidgetContentState();
}

class _HomeWidgetContentState extends State<HomeWidgetContent> {
  bool timer = true;
  late final ProductCubit _productCubit;
  late final CategoryCubit _categoryCubit;
  late final BrandCubit _brandCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = appDependencies.productCubit..getProducts();
    _categoryCubit = appDependencies.categoryCubit..getCategories();
    _brandCubit = appDependencies.brandCubit..getBrands();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => timer = false);
    });
  }

  @override
  void dispose() {
    _productCubit.close();
    _categoryCubit.close();
    _brandCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productCubit),
        BlocProvider.value(value: _categoryCubit),
        BlocProvider.value(value: _brandCubit),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Skeletonizer(
          enabled: timer,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const HomeAppBar(
                imagePath: 'assets/image/avatare.png',
                customerName: 'yousef',
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                    CustomSearchButton(
                      readOnly: true,
                      ontap: () => Navigator.pushNamed(context, AppRoute.search),
                    ),
                    const SizedBox(height: 15),
                    const AdvertisingCard(),
                    const SizedBox(height: 10),
                    const SuperTitleViewAll(superTitleName: 'Popular Product'),
                    const SizedBox(height: 5),
                    const BuildListOfPopularProduct(),
                    const SizedBox(height: 10),
                    const SuperTitleViewAll(superTitleName: 'Category'),
                    const CategoryList(),
                    const SizedBox(height: 7),
                    const SuperTitleViewAll(superTitleName: 'Best For You'),
                    const BuildListOfBestForYou(),
                    const SizedBox(height: 10),
                    const SuperTitleViewAll(superTitleName: 'Brand'),
                    const BrandList(),
                    const SizedBox(height: 7),
                    const SuperTitleViewAll(superTitleName: 'Buy Again'),
                    const BuildListOfBuyAgain(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
