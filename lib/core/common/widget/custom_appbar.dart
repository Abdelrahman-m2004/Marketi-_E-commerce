import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.icon,
    this.text,
    this.shoppingcard,
    this.customCircleAvatar,
    this.onLeadingTap,
  });

  final IconData icon;
  final String? text;
  final IconData? shoppingcard;
  final Widget? customCircleAvatar;
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: IconButton(
                onPressed: onLeadingTap ?? () {},
                icon: Icon(icon),
              ),
            ),

            Text(
              text ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            shoppingcard != null
                ? Icon(shoppingcard, color: Colors.blueAccent)
                : (customCircleAvatar ?? const SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
