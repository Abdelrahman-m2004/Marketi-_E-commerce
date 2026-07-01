import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/brand_item_card.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [BrandItemCard(), BrandItemCard(), BrandItemCard()]);
  }
}
