import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imagePath;
  final double width;
  final double height;
  final VoidCallback? ontap;

  const CustomCircleAvatar({
    super.key,
    this.imagePath,
    this.width = 40,
    this.height = 40,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width + 4,
        height: height + 4,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 1.5),
        ),
        child: ClipOval(
          child: imagePath != null && imagePath!.isNotEmpty
              ? Image.asset(
                  imagePath!,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 24);
                  },
                )
              : const Icon(Icons.person, size: 24),
        ),
      ),
    );
  }
}
