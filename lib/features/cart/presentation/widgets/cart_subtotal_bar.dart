import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';

class CartSubtotalBar extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final VoidCallback onCheckout;

  const CartSubtotalBar({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suptotal ($itemCount items)',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'EGP ${subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomPrimaryAppButton(
            buttonText: 'Checkout',
            onTap: onCheckout,
          ),
        ],
      ),
    );
  }
}
