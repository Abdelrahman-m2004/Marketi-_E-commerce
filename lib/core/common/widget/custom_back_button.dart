import 'package:flutter/material.dart';
import 'package:marketi/core/theming/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.Light_Blue_700, width: 1.2),
          color: Colors.white,
        ),
        child: Icon(
          Icons.chevron_left_rounded,
          color: AppColors.Dark_Blue_900,
          size: 26,
        ),
      ),
    );
  }
}
