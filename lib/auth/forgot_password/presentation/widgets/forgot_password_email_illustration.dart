import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class ForgotPasswordEmailIllustration extends StatelessWidget {
  const ForgotPasswordEmailIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Forgot_Password_email,
        height: 220,
      ),
    );
  }
}
