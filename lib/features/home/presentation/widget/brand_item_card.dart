import 'package:flutter/material.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';

class BrandItemCard extends StatelessWidget {
  const BrandItemCard({super.key, required this.brandModel});
  final BrandModel brandModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
        
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              brandModel.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
