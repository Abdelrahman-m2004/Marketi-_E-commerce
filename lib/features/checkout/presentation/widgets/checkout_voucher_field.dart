import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CheckoutVoucherField extends StatefulWidget {
  const CheckoutVoucherField({super.key});

  @override
  State<CheckoutVoucherField> createState() => _CheckoutVoucherFieldState();
}

class _CheckoutVoucherFieldState extends State<CheckoutVoucherField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: AppFonts.bodyMedium.copyWith(color: AppColors.Dark_Blue_900),
            decoration: InputDecoration(
              hintText: 'Voucher code',
              hintStyle: AppFonts.bodyMedium.copyWith(color: AppColors.light_gray),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.Light_Blue_700, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.Dark_Blue_200, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.Light_Blue_700, width: 1),
            ),
            child: Text(
              'Apply',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.Dark_Blue_200,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
