import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            alignment: Alignment.center,
            child: Image.asset(image, fit: BoxFit.contain),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: AppFonts.headingLarge,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Text(
            description,
            style: AppFonts.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
