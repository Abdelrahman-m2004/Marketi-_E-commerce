import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketi/core/fonts/AppFonts.dart';

class CustomSearchText extends StatelessWidget {
  final String text;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final TextEditingController? controller;

  const CustomSearchText({
    super.key,
    required this.text,
    this.validator,
    this.textInputAction,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffB2CCFF).withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: const Color(0xff001640)),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              textInputAction: textInputAction,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: text,
                hintStyle: AppFonts.bodyLarge.copyWith(
                  color: const Color(0xFF929BAB),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Icon(Icons.tune, color: const Color(0xFF3F80FF)),
        ],
      ),
    );
  }
}
