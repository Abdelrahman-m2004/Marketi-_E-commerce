import 'package:flutter/material.dart';
import 'package:marketi/features/home/presentation/widget/category_item_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        padding: EdgeInsets.zero,
         shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
        
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, 
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
      return CategoryItemCard();
        },
      ),
    );
  }
}