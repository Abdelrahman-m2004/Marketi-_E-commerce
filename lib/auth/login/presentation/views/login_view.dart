import 'package:flutter/material.dart';
import 'package:marketi/auth/login/presentation/widgets/login_footer.dart';
import 'package:marketi/auth/login/presentation/widgets/login_form.dart';
import 'package:marketi/auth/login/presentation/widgets/login_header.dart';
import 'package:marketi/auth/login/presentation/widgets/login_social_buttons.dart';
import 'package:marketi/auth/signup/presentation/views/signup_view.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/theming/colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildSkipButton(context),
              const SizedBox(height: 24),
              const LoginHeader(),
              const SizedBox(height: 40),
              const LoginForm(),
              const SizedBox(height: 16),
              LoginSocialButtons(
                onGoogleTap: () => _showSocialComingSoon(context, 'Google'),
                onAppleTap: () => _showSocialComingSoon(context, 'Apple'),
                onFacebookTap: () => _showSocialComingSoon(context, 'Facebook'),
              ),
              const SizedBox(height: 12),
              LoginFooter(
                onRegisterTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupView()),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static void _showSocialComingSoon(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Sign In is coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const CustomNavigationbar()),
            (route) => false,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.Light_Blue_700, width: 1.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Skip',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.Dark_Blue_200,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
