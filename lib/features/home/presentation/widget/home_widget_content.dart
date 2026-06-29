import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';
import 'package:marketi/features/home/presentation/widget/advertising_card.dart';
import 'package:marketi/features/home/presentation/widget/home_appbar.dart';

class HomeWidgetContent extends StatelessWidget {
  const HomeWidgetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          HomeAppBar(
            imagePath: 'assets/image/avatare.png',
            customerName: 'yousef',
          ),
          SizedBox(),
          AdvertisingCard(),
          SizedBox(),
          // ProductItemCard(
          //   imagePath: 'assets/image/image.png',
          //   price: '499',
          //   rating: '4.9',
          //   productName: 'smart watch',
          // ),
        ],
      ),
    );
  }
}
