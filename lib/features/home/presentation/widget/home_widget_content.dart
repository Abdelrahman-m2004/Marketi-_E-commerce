import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/advertising_card.dart';
import 'package:marketi/features/home/presentation/widget/brand_item_card.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          HomeAppBar(
            imagePath: 'assets/image/avatare.png',
            customerName: 'yousef',
          ),
          SizedBox(
            height: 10,
          ),
          AdvertisingCard(),
           SizedBox(
            height: 5,
          ),
          SuperTitleViewAll(superTitleName: 'Popular Product'),
           SizedBox(
            height: 5,
          ),
          BuildListOfPopularProduct(),
           SizedBox(
            height: 5,
          ),
          SuperTitleViewAll(superTitleName: 'Category'),
          CategoryList(),
           SizedBox(
            height: 5,
          ),
          SuperTitleViewAll(superTitleName: 'Best For You'),
          BuildListOfBestForYou(),
           SizedBox(
            height: 5,
          ),
          SuperTitleViewAll(superTitleName: 'Brand'),
          BrandList(),
           SizedBox(
            height: 5,
          ),
          SuperTitleViewAll(superTitleName: 'Buy Again'),
          BuildListOfBuyAgain(),
           SizedBox(
            height: 5,
          ),
          
        ],
      ),
    );
  }
}
