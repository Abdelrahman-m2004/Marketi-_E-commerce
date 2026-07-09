import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class CongratulationsIllustration extends StatelessWidget {
  const CongratulationsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Congratulations,
        height: 260,
      ),
    );
  }
}
