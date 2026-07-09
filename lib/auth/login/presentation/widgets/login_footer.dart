import 'package:flutter/material.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback onRegisterTap;

  const LoginFooter({super.key, required this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Are you new in Marketi ',
          style: AppFonts.fontMedium.copyWith(color: AppColors.navy),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: Text(
            'register?',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.Dark_Blue_200,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
