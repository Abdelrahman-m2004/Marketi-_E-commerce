import 'package:flutter/material.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class LoginRememberRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onForgotPassword;

  const LoginRememberRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberChanged,
                activeColor: AppColors.Dark_Blue_200,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Remember Me',
              style: AppFonts.fontMedium.copyWith(color: AppColors.navy),
            ),
          ],
        ),
        GestureDetector(
          onTap: onForgotPassword,
          child: Text(
            'Forgot Password?',
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
