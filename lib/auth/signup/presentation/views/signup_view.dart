import 'package:flutter/material.dart';
import 'package:marketi/auth/login/presentation/widgets/login_social_buttons.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_form.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_header.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const CustomBackButton(),
              const SizedBox(height: 12),
              const SignupHeader(),
              const SizedBox(height: 24),
              const SignupForm(),
              const SizedBox(height: 16),
              LoginSocialButtons(
                onGoogleTap: () {},
                onAppleTap: () {},
                onFacebookTap: () {},
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
