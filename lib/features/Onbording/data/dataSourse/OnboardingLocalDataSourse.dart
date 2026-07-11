import 'package:marketi/features/Onbording/data/models/OnboardingModel.dart';

class Onboardinglocaldatasourse {
  Future<List<Onboardingmodel>> GetOnboardingLocalData() async {
    return [
      Onboardingmodel(
        image: 'assets/image/Illustration_Onboarding_1.png',
        title: 'Welcome to Marketi',
        description:
            'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
      ),
      Onboardingmodel(
        image: 'assets/image/Illustration_Onboarding_2.png',
        title: 'Easy to Buy',
        description:
            'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
      ),
      Onboardingmodel(
        image: 'assets/image/Illustration_Onboarding_3.png',
        title: 'Wonderful User Experience',
        description:
            'Start exploring now and experience the convenience of online shopping at its best.',
      ),
    ];
  }
}
