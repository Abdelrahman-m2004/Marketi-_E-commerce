import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/core/app_dependencies.dart';
import 'package:marketi/core/constants/app_rout.dart';

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

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        timer = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => appDependencies.productCubit..getProducts(),
        ),
        BlocProvider(
          create: (_) => appDependencies.categoryCubit..getCategories(),
        ),
        BlocProvider(create: (_) => appDependencies.brandCubit..getBrands()),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Skeletonizer(
          enabled: timer,
          child: Column(
            children: [
              SizedBox(height: 50),

              HomeAppBar(
                imagePath: 'assets/image/avatare.png',
                customerName: 'yousef',
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 10),
                    CustomSearchButton(
                      readOnly: true,
                      ontap: () =>
                          Navigator.pushNamed(context, AppRoute.search),
                    ),
                    SizedBox(height: 15),
                    AdvertisingCard(),
                    SizedBox(height: 10),
                    SuperTitleViewAll(superTitleName: 'Popular Product'),
                    SizedBox(height: 5),
                    BuildListOfPopularProduct(),
                    SizedBox(height: 10),
                    SuperTitleViewAll(superTitleName: 'Category'),
                    CategoryList(),
                    SizedBox(height: 7),
                    SuperTitleViewAll(superTitleName: 'Best For You'),
                    BuildListOfBestForYou(),
                    SizedBox(height: 10),
                    SuperTitleViewAll(superTitleName: 'Brand'),
                    BrandList(),
                    SizedBox(height: 7),
                    SuperTitleViewAll(superTitleName: 'Buy Again'),
                    BuildListOfBuyAgain(),
                    SizedBox(height: 10),
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
