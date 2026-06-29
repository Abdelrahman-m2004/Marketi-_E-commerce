import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class SignupPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const SignupPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: AppFonts.bodyLarge.copyWith(color: AppColors.Dark_Blue_900),
      decoration: InputDecoration(
        hintText: '+20 1501142409',
        hintStyle: AppFonts.bodyLarge.copyWith(color: AppColors.light_gray),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppIcons.Phone_Icon,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
              ),
              const SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.Gray_Scale, size: 20),
            ],
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Light_Blue_700, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.Dark_Blue_200, width: 1.5),
        ),
      ),
    );
  }
}
