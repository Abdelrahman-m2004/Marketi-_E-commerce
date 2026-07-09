import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class ForgotPasswordSubtitle extends StatelessWidget {
  final String text;

  const ForgotPasswordSubtitle({
    super.key,
    this.text = 'Please enter your phone number to\nreceive a verification code',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppFonts.titleMedium.copyWith(
        color: AppColors.navy,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
