import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class CheckoutMapPlaceholder extends StatelessWidget {
  final String address;
  const CheckoutMapPlaceholder({super.key, this.address = 'Anshas'});

  @override
  Widget build(BuildContext context) {
    // Show first word of address as map label
    final label = address.split(',').first.trim();
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Stack(
          children: [
            // Background
            Container(color: const Color(0xFFE8EFFE)),

            // Road lines
            CustomPaint(
              size: const Size(double.infinity, 190),
              painter: _MapPainter(),
            ),

            // "Bilbeis" label — top right
            Positioned(
              top: 18,
              right: 28,
              child: Text(
                'Bilbeis',
                style: AppFonts.fontMedium.copyWith(
                  color: AppColors.Gray_Scale,
                  fontSize: 11,
                ),
              ),
            ),

            // "Mashtul Al-Suq" label — bottom left
            Positioned(
              bottom: 38,
              left: 24,
              child: Text(
                'Mashtul Al-Suq',
                style: AppFonts.fontMedium.copyWith(
                  color: AppColors.Gray_Scale,
                  fontSize: 10,
                ),
              ),
            ),

            // Pin icon + "Anshas" label — center
            Positioned(
              top: 52,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.Dark_Blue_200,
                    size: 34,
                  ),
                  Text(
                    label,
                    style: AppFonts.fontMedium.copyWith(
                      color: AppColors.Dark_Blue_700,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFB2CCFF)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    // Road 1 — main diagonal from left bottom to right middle
    final road1 = Path()
      ..moveTo(w * 0.0, h * 0.72)
      ..quadraticBezierTo(w * 0.18, h * 0.62, w * 0.35, h * 0.55)
      ..quadraticBezierTo(w * 0.50, h * 0.50, w * 0.65, h * 0.58)
      ..quadraticBezierTo(w * 0.80, h * 0.65, w * 1.0, h * 0.55);
    canvas.drawPath(road1, roadPaint);

    // Road 2 — upper branch from center-left going top-right
    final road2 = Path()
      ..moveTo(w * 0.35, h * 0.55)
      ..quadraticBezierTo(w * 0.42, h * 0.38, w * 0.52, h * 0.48);
    canvas.drawPath(road2, roadPaint);

    // Road 3 — right branch going bottom-right (jagged)
    final road3 = Path()
      ..moveTo(w * 0.52, h * 0.48)
      ..lineTo(w * 0.60, h * 0.44)
      ..lineTo(w * 0.65, h * 0.52)
      ..lineTo(w * 0.72, h * 0.46)
      ..lineTo(w * 0.78, h * 0.56)
      ..lineTo(w * 0.85, h * 0.50)
      ..lineTo(w * 0.92, h * 0.58)
      ..lineTo(w * 1.0, h * 0.52);
    canvas.drawPath(road3, roadPaint);

    // Road 4 — short left curve (river-like)
    final road4 = Paint()
      ..color = const Color(0xFFB2CCFF)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final river = Path()
      ..moveTo(w * 0.0, h * 0.42)
      ..quadraticBezierTo(w * 0.06, h * 0.52, w * 0.10, h * 0.60)
      ..quadraticBezierTo(w * 0.14, h * 0.68, w * 0.20, h * 0.72)
      ..quadraticBezierTo(w * 0.26, h * 0.76, w * 0.28, h * 0.88)
      ..lineTo(w * 0.30, h * 1.0);
    canvas.drawPath(river, road4);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
