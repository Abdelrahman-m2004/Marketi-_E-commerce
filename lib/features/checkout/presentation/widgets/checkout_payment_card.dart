import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class CheckoutPaymentCard extends StatelessWidget {
  const CheckoutPaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.Cash_Icon,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  AppColors.Dark_Blue_900,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Cash on delivery',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.Dark_Blue_900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Change',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.Dark_Blue_200,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
