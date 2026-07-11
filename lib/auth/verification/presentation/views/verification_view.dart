import 'package:flutter/material.dart';
import 'package:marketi/auth/verification/presentation/widgets/otp_form.dart';
import 'package:marketi/auth/verification/presentation/widgets/verification_illustration.dart';
import 'package:marketi/auth/verification/presentation/widgets/verification_subtitle.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_back_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/images.dart';

class VerificationView extends StatelessWidget {
  final String sentTo;
  final String imagePath;

  const VerificationView({
    super.key,
    required this.sentTo,
    this.imagePath = AppImages.Verification_Code_phone,
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
                    'Verification Code',
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.navy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              VerificationIllustration(imagePath: imagePath),
              const SizedBox(height: 28),
              Center(child: VerificationSubtitle(sentTo: sentTo)),
              const SizedBox(height: 16),
              OtpForm(
                phone: sentTo,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
