import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CartEmptyContent extends StatelessWidget {
  const CartEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Cart is Empty',
          style: AppFonts.headingLarge.copyWith(
            color: AppColors.Dark_Blue_900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Check our big offers, fresh products\nand fill your cart with items',
          textAlign: TextAlign.center,
          style: AppFonts.bodyLarge.copyWith(
            color: AppColors.navy,
          ),
        ),
      ],
    );
  }
}
