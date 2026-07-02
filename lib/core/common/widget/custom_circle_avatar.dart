import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imagePath;
  final VoidCallback? ontap;
  const CustomCircleAvatar({super.key, required this.imagePath,  this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
        child: Image.asset(imagePath,
        width: 48,
        height: 48,
        ),
      ),
    );
  }
}