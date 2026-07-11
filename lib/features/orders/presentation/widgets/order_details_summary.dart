import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class OrderDetailsSummary extends StatelessWidget {
  final double total;

  const OrderDetailsSummary({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'EGP ${total.toStringAsFixed(2)}',
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.Dark_Blue_200,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
