import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.icon,
    this.text,
    this.shoppingcard,
    this.customCircleAvatar, this.ontap,
  });
  final IconData icon;
  final String? text;
  final IconData? shoppingcard;
  final Widget? customCircleAvatar;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: GestureDetector(
            onTap: ontap,
            child: Icon(icon,size: 24,),
            
            ),
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
