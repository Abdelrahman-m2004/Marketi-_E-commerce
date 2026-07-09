import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class ForgotPasswordIllustration extends StatelessWidget {
  const ForgotPasswordIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Forgot_Password_phone,
        height: 220,
      ),
    );
  }
}
