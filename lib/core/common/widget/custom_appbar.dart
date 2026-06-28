import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.icon,
    this.text,
    this.shoppingcard,
    this.customCircleAvatar,
  });
  final IconData icon;
  final String? text;
  final IconData? shoppingcard;
  final Widget? customCircleAvatar;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: IconButton(onPressed: () {}, icon: Icon(icon)),
        ),

        Text(
          text ?? '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight(600),
          ),
        ),
        shoppingcard != null
            ? Icon(shoppingcard, color: Colors.blueAccent)
            : customCircleAvatar ?? Container(),
      ],
    );
  }
}
