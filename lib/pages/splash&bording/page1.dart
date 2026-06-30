import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboardingPages extends StatelessWidget {
  final PageController controller;
  final String image;
  final String title;
  final String discrabtion;
  final bool isLastPage;
  const onboardingPages({
    super.key,
    required this.controller,
    required this.image,
    required this.title,
    required this.discrabtion,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Image.asset(image),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.blueAccent,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(title, style: AppFonts.headingLarge),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                discrabtion,
                style: AppFonts.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          CustomPrimaryAppButton(
            buttonText: isLastPage ? 'Get Strat' : 'Next',
            onpressed: () {
              if (isLastPage) {
                Navigator.pushNamed(context, '/categoryList');
              } else {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
