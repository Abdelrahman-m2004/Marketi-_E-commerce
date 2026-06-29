import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIconPath;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIconPath,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppFonts.bodyLarge.copyWith(color: AppColors.Dark_Blue_900),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.bodyLarge.copyWith(color: AppColors.light_gray),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(
            prefixIconPath,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
          ),
        ),
        suffixIcon: suffixIcon,
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
