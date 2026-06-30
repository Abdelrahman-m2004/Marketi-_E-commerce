import 'package:flutter/material.dart';
import 'package:marketi/auth/forgot_password/presentation/views/forgot_password_email_view.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_phone_field.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SignupFieldLabel(label: 'Phone Number'),
        SignupPhoneField(controller: _phoneController),
        const SizedBox(height: 18),
        CustomPrimaryAppButton(
          buttonText: 'Send Code',
          onTap: () {
            // TODO: Handle send code
          },
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordEmailView()),
              );
            },
            child: Text(
              'Try Another Way',
              style: AppFonts.bodyLarge.copyWith(
                color: AppColors.Light_Blue_100,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
