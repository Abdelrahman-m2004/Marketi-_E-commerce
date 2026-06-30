import 'package:flutter/material.dart';
import 'package:marketi/pages/splash&bording/page1.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          onboardingPages(
            controller: controller,
            image: 'assets/image/Illustration_Onboarding_1.png',
            title: 'Welcome to Marketi',
            discrabtion:
                'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
            isLastPage: false,
          ),
          onboardingPages(
            controller: controller,
            image: 'assets/image/Illustration_Onboarding_2.png',
            title: 'Easy to Buy',
            discrabtion:
                'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
            isLastPage: false,
          ),
          onboardingPages(
            controller: controller,
            image: 'assets/image/Illustration_Onboarding_3.png',
            title: 'Wonderful User Experience',
            discrabtion:
                'Start exploring now and experience the convenience of online shopping at its best.',
            isLastPage: true,
          ),
        ],
      ),
    );
  }
}
