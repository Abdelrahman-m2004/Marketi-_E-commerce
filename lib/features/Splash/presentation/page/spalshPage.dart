import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/Splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is GoToOnboarding) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }

        if (state is GoToHome) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset('assets/image/Logo_Splash_Screen.png')),
      ),
    );
  }
}
