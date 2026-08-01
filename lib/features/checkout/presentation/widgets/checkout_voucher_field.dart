import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/theming/colors.dart';

class CheckoutVoucherField extends StatefulWidget {
  final void Function(double discount)? onVoucherApplied;

  const CheckoutVoucherField({super.key, this.onVoucherApplied});

  @override
  State<CheckoutVoucherField> createState() => _CheckoutVoucherFieldState();
}

class _CheckoutVoucherFieldState extends State<CheckoutVoucherField> {
  final TextEditingController _controller = TextEditingController();
  bool _isApplying = false;
  bool _applied = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _applyVoucher() async {
    final code = _controller.text.trim();
    if (code.isEmpty) {
      AppSnackbar.showError(context, 'Please enter a voucher code');
      return;
    }

    setState(() => _isApplying = true);

    try {
      // TODO: replace with real API call when backend supports vouchers
      // final response = await ApiService().applyVoucher(code: code);
      // For now simulate validation
      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      // Simulate: code 'SAVE10' = 10% discount
      if (code.toUpperCase() == 'SAVE10') {
        setState(() => _applied = true);
        widget.onVoucherApplied?.call(10.0); // 10% discount
        AppSnackbar.showSuccess(context, 'Voucher applied! 10% discount');
      } else {
        AppSnackbar.showError(context, 'Invalid voucher code');
      }
    } finally {
      if (mounted) setState(() => _isApplying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            enabled: !_applied,
            style: AppFonts.bodyMedium.copyWith(color: AppColors.Dark_Blue_900),
            decoration: InputDecoration(
              hintText: 'Voucher code',
              hintStyle:
                  AppFonts.bodyMedium.copyWith(color: AppColors.light_gray),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 13),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: AppColors.Light_Blue_700, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: AppColors.Dark_Blue_200, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: AppColors.Light_Blue_700.withValues(alpha: 0.5),
                    width: 1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _applied || _isApplying ? null : _applyVoucher,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
            decoration: BoxDecoration(
              color: _applied
                  ? const Color(0xff22C55E)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: _applied
                      ? const Color(0xff22C55E)
                      : AppColors.Light_Blue_700,
                  width: 1),
            ),
            child: _isApplying
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _applied ? 'Applied ✓' : 'Apply',
                    style: AppFonts.bodyMedium.copyWith(
                      color: _applied
                          ? Colors.white
                          : AppColors.Dark_Blue_200,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
