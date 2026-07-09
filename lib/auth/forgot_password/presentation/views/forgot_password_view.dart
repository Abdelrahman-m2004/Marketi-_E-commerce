import 'package:flutter/material.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_form.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_illustration.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_subtitle.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const CustomBackButton(),
                  const SizedBox(width: 8),
                  Text(
                    'Forgot Password',
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.navy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const ForgotPasswordIllustration(),
              const SizedBox(height: 28),
              const ForgotPasswordSubtitle(),
              const SizedBox(height: 28),
              const ForgotPasswordForm(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
