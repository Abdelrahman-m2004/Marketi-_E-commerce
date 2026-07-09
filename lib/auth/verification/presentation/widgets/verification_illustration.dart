import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class VerificationIllustration extends StatelessWidget {
  final String imagePath;

  const VerificationIllustration({
    super.key,
    this.imagePath = AppImages.Verification_Code_phone,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        height: 220,
      ),
    );
  }
}
