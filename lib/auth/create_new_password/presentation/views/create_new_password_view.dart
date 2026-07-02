import 'package:flutter/material.dart';
import 'package:marketi/auth/create_new_password/presentation/widgets/create_password_form.dart';
import 'package:marketi/auth/create_new_password/presentation/widgets/create_password_illustration.dart';
import 'package:marketi/auth/create_new_password/presentation/widgets/create_password_subtitle.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';

class CreateNewPasswordView extends StatelessWidget {
  final String phone;

  const CreateNewPasswordView({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const CustomBackButton(),
                  const SizedBox(width: 12),
                  Text(
                    'Create New Password',
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.navy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const CreatePasswordIllustration(),
              const SizedBox(height: 16),
              const Center(child: CreatePasswordSubtitle()),
              const SizedBox(height: 20),

              CreatePasswordForm(
                phone: phone,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}