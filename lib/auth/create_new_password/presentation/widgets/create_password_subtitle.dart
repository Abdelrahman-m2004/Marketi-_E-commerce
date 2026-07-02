import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CreatePasswordSubtitle extends StatelessWidget {
  const CreatePasswordSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'New password must be\ndifferent from last password',
      textAlign: TextAlign.center,
      style: AppFonts.titleMedium.copyWith(
        color: AppColors.navy,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
