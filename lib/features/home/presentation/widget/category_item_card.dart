import 'package:flutter/material.dart';


class CategoryItemCard extends StatelessWidget {
  // final CategoryModel categoryModel;

  const CategoryItemCard({super.key, });

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
            child: Image.network('https://gratisography.com/wp-content/uploads/2025/05/gratisography-moon-robot-800x525.jpg', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'watch',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}