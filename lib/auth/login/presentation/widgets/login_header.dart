import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Logo_Log_In,
        height: 140,
      ),
    );
  }
}
