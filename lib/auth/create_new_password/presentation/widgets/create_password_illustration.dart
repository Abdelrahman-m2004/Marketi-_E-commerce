import 'package:flutter/material.dart';
import 'package:marketi/core/theming/images.dart';

class CreatePasswordIllustration extends StatelessWidget {
  const CreatePasswordIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.Create_New_Password,
        height: 220,
      ),
    );
  }
}
