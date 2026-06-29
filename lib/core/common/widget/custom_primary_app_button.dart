import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CustomPrimaryAppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const CustomPrimaryAppButton({
    super.key,
    required this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.Dark_Blue_100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppFonts.buttonLarge.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
