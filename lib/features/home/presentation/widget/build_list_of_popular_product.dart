import 'package:flutter/material.dart';
import 'package:marketi/core/common/widget/product_item_card.dart';

class BuildListOfPopularProduct extends StatelessWidget {
  const BuildListOfPopularProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 160,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>  ProductItemCard(
              imagePath: 'assets/image/image.png',
              price: '499',
              rating: '4.9',
              productName: 'smart watch',
              addButton: false,
            ), 
      ),
    );
  }
}
