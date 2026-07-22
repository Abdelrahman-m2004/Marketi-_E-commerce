import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class OrderDetailsItemsList extends StatelessWidget {
  final List items;

  const OrderDetailsItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...items
              .whereType<Map>()
              .map(
                (item) => _OrderItemRow(
              item: Map<String, dynamic>.from(item as Map),
            ),
          ),        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final Map<String, dynamic> item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final name = item['product']?['name'] ?? item['name'] ?? '';
    final qty = item['quantity'] ?? 1;
    final price = double.tryParse(item['price']?.toString() ?? '0') ?? 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item['product']?['main_image_url'] != null
                ? Image.network(
                    item['product']['main_image_url'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => _placeholder(),
                  )
                : _placeholder(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.Dark_Blue_900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'x$qty',
                  style: AppFonts.captionBold.copyWith(color: AppColors.light_gray),
                ),
              ],
            ),
          ),
          Text(
            'EGP ${price.toStringAsFixed(2)}',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.Light_Blue_900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image_outlined, color: AppColors.Gray_Scale, size: 24),
    );
  }
}
