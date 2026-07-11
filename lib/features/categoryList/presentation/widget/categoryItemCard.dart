import 'package:flutter/material.dart';
import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';

class CategoryItemCard extends StatelessWidget {
  final Categoryentity categoryModel;

  const CategoryItemCard({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 110,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD6E4FF)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(categoryModel.image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          categoryModel.categoryName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
