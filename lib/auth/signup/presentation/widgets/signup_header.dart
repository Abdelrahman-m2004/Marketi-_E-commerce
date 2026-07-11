import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Logo_Sign_Up,
        height: 140,
      ),
    );
  }
}
