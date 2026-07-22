import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/features/Onbording/presentation/cubit/onboarding_cubit.dart';
import 'package:marketi/features/Onbording/presentation/pages/onboardingwedgit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselSliderController carouselController =
        CarouselSliderController();
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is OnboardingLoaded) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 120),
                Expanded(
                  child: CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        context.read<OnboardingCubit>().changePage(index);
                      },
                    ),
                    items: state.OnboardingList.map((item) {
                      return OnboardingWidget(
                        image: item.image,
                        title: item.title,
                        description: item.description,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedSmoothIndicator(
                  activeIndex: state.CurrentIndex,
                  count: state.OnboardingList.length,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomPrimaryAppButton(
                    buttonText:
                        state.CurrentIndex == state.OnboardingList.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onTap: () {
                      if (state.CurrentIndex ==
                          state.OnboardingList.length - 1) {
                        context.read<OnboardingCubit>().finishOnboarding();
                        Navigator.pushReplacementNamed(context, '/navigationbar');
                      } else {
                        carouselController.nextPage();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        }
        return SizedBox(height: 50);
      },
    );
  }
}
