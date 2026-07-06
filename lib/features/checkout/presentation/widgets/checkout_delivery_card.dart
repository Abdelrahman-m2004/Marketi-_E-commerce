import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class CheckoutDeliveryCard extends StatelessWidget {
  const CheckoutDeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.Delivery_Icon,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(AppColors.Dark_Blue_900, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Text(
            'Within 2 days',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.Dark_Blue_900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
