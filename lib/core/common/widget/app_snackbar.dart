import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class AppSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, const Color(0xFF22C55E));
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, const Color(0xFFEF4444));
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppFonts.bodyMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: color,
        // behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 130,
          left: 16,
          right: 16,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
