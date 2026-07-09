import 'package:flutter/material.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_email_form.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_email_illustration.dart';
import 'package:marketi/auth/forgot_password/presentation/widgets/forgot_password_subtitle.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';

class ForgotPasswordEmailView extends StatelessWidget {
  const ForgotPasswordEmailView({super.key});

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
              const ForgotPasswordEmailIllustration(),
              const SizedBox(height: 28),
              const ForgotPasswordSubtitle(
                text: 'Please enter your email address to\nreceive a verification code',
              ),
              const SizedBox(height: 28),
              const ForgotPasswordEmailForm(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
