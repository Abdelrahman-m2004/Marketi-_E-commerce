import 'package:flutter/material.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/icons.dart';

class ForgotPasswordEmailForm extends StatefulWidget {
  const ForgotPasswordEmailForm({super.key});

  @override
  State<ForgotPasswordEmailForm> createState() => _ForgotPasswordEmailFormState();
}

class _ForgotPasswordEmailFormState extends State<ForgotPasswordEmailForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SignupFieldLabel(label: 'Email'),
        LoginTextField(
          controller: _emailController,
          hintText: 'You@gmail.com',
          prefixIconPath: AppIcons.Email_Icon,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        CustomPrimaryAppButton(
          buttonText: 'Send Code',
          onTap: () {
            // TODO: Handle send code via email
          },
        ),
      ],
    );
  }
}
