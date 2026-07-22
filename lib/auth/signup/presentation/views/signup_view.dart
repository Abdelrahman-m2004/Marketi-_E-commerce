import 'package:flutter/material.dart';
import 'package:marketi/auth/login/presentation/widgets/login_social_buttons.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_form.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_header.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static void _showSocialComingSoon(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Sign In is coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
                onGoogleTap: () => _showSocialComingSoon(context, 'Google'),
                onAppleTap: () => _showSocialComingSoon(context, 'Apple'),
                onFacebookTap: () => _showSocialComingSoon(context, 'Facebook'),
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
