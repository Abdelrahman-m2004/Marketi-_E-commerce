import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/images.dart';

class CartAppbar extends StatelessWidget {
  final VoidCallback? onBack;
  const CartAppbar({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(
          onTap: () {
            if (onBack != null) {
              // Inside NavigationBar — switch to Home tab
              onBack!();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        Text(
          'Cart',
          style: AppFonts.headingLarge.copyWith(
            color: AppColors.Dark_Blue_900,
          ),
        ),
        CustomCircleAvatar(imagePath: AppImages.Ellipse1),
      ],
    );
  }
}
