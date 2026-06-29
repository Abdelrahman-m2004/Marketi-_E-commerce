import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class LoginSocialButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const LoginSocialButtons({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Or Continue With',
          style: AppFonts.bodyMedium.copyWith(color: AppColors.light_gray),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIconButton(iconPath: AppIcons.Google_Icon, onTap: onGoogleTap),
            SocialIconButton(iconPath: AppIcons.Apple_Icon, onTap: onAppleTap),
            SocialIconButton(iconPath: AppIcons.Facebok_Icon, onTap: onFacebookTap),
          ],
        ),
      ],
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
