import 'package:flutter/material.dart';
import 'package:marketi/features/home/data/models/category_model.dart';

class CategoryItemCard extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryItemCard({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use all available height; reserve 22px for text (4 gap + 18 text)
        final imageHeight = constraints.maxHeight - 22;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: imageHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffD6E4FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffD6E4FF),
                    width: 1,
                  ),
                ),
                child: categoryModel.image != null &&
                        categoryModel.image!.isNotEmpty
                    ? Image.network(
                        categoryModel.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Center(
                          child: Icon(Icons.image_not_supported, size: 24),
                        ),
                      )
                    : const Center(child: Icon(Icons.image, size: 24)),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 18,
              width: double.infinity,
              child: Text(
                categoryModel.categoryName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
