import 'package:flutter/material.dart';

class BrandItemCard extends StatelessWidget {
  const BrandItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          height: 100,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://gratisography.com/wp-content/uploads/2025/05/gratisography-moon-robot-800x525.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
