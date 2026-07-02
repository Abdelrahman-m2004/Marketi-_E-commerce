import 'package:flutter/material.dart';
import 'package:marketi/auth/congratulations/presentation/widgets/congratulations_content.dart';
import 'package:marketi/auth/congratulations/presentation/widgets/congratulations_illustration.dart';
import 'package:marketi/auth/login/presentation/views/login_view.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';

class CongratulationsView extends StatelessWidget {
  const CongratulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CustomBackButton(),
              const SizedBox(height: 24),
              const CongratulationsIllustration(),
              const SizedBox(height: 28),
              const CongratulationsContent(),
              const SizedBox(height: 32),
              CustomPrimaryAppButton(
                buttonText: 'Log In',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
