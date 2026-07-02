import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CongratulationsContent extends StatelessWidget {
  const CongratulationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Congratulations',
          style: AppFonts.headingLarge.copyWith(
            color: AppColors.Dark_Blue_900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'You have updated the password. please\nlogin again with your latest password',
          textAlign: TextAlign.center,
          style: AppFonts.bodyLarge.copyWith(
            color: AppColors.navy,
          ),
        ),
      ],
    );
  }
}
