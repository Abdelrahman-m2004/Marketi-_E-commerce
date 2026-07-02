import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class CartEmptyIllustration extends StatelessWidget {
  const CartEmptyIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Cart_Empty,
        height: 280,
      ),
    );
  }
}
