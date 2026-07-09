import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class VerificationSubtitle extends StatelessWidget {
  final String sentTo;

  const VerificationSubtitle({super.key, required this.sentTo});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppFonts.titleMedium.copyWith(color: AppColors.navy),
        children: [
          const TextSpan(text: 'Please enter the 6 digit code\nsent to: '),
          TextSpan(
            text: sentTo,
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.Light_Blue_100,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
