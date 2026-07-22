import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/images.dart';

class CartAppbar extends StatelessWidget {
  const CartAppbar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomBackButton(),
        Text(
          text,
          style: AppFonts.headingLarge.copyWith(
            color: AppColors.Dark_Blue_900,
          ),
        ),
        CustomCircleAvatar(imagePath: AppImages.Ellipse1),
      ],
    );
  }
}
