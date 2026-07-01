import 'package:flutter/material.dart';
import 'package:marketi/core/fonts/AppFonts.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Color(0xff001640)),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppFonts.titleLarge.copyWith(color: Color(0xff001640)),
        ),
      ],
    );
  }
}
