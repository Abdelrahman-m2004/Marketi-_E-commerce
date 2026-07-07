import 'package:flutter/material.dart';

import 'package:marketi/features/home/data/models/category_model.dart';

class CategoryItemCard extends StatelessWidget {
  final CategoryModel categoryModel;

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
            child:
                categoryModel.image.isNotEmpty
                ? Image.network(
                    categoryModel.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported),
                      );
                    },
                  )
                : const Center(child: Icon(Icons.image)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          categoryModel.categoryName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
