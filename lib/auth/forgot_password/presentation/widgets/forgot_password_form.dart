import 'package:flutter/material.dart';
import 'package:marketi/auth/forgot_password/presentation/views/forgot_password_email_view.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_phone_field.dart';
import 'package:marketi/auth/verification/presentation/views/verification_view.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/images.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String _countryCode = '+20';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onSend() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final rawPhone = _phoneController.text.trim();
      final phone = '$_countryCode$rawPhone';

      final response = await ApiService().sendOtp(phone: phone);

      if (!mounted) return;

      if (response['success'] != true) {
        AppSnackbar.showError(
          context,
          response['message'] ?? 'Failed to send OTP. Please try again.',
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerificationView(
            sentTo: phone,
            imagePath: AppImages.Verification_Code_phone,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignupFieldLabel(label: 'Phone Number'),
          SignupPhoneField(
            controller: _phoneController,
            onCountryCodeChanged: (code) => setState(() => _countryCode = code),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              final digits = v.replaceAll(RegExp(r'\D'), '');
              if (digits.length != 11) {
                return 'Phone number must be exactly 11 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomPrimaryAppButton(
                  buttonText: 'Send Code',
                  onTap: _onSend,
                ),
          const SizedBox(height: 14),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ForgotPasswordEmailView()),
              ),
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
      ),
    );
  }
}
