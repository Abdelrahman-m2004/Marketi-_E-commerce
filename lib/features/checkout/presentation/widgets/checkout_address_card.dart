import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/features/checkout/presentation/widgets/checkout_map_placeholder.dart';

class CheckoutAddressCard extends StatelessWidget {
  const CheckoutAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Light_Blue_700, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map section
          const CheckoutMapPlaceholder(),
          // Address info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.Location_Icon_UIA,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.Dark_Blue_900,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Home',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.Dark_Blue_900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Change',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.Dark_Blue_200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anshas, Al-sharqia, Egypt.',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Mobile: +20 101 840 3043',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
