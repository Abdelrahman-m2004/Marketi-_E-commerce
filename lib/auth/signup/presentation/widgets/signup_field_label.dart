import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class SignupFieldLabel extends StatelessWidget {
  final String label;

  const SignupFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFonts.bodyMedium.copyWith(color: AppColors.Dark_Blue_900),
    );
  }
}
