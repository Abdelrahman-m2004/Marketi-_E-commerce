import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/auth/congratulations/presentation/views/congratulations_view.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:dio/dio.dart';
class CreatePasswordForm extends StatefulWidget {
  final String phone;
  final String otp;

  const CreatePasswordForm({
    super.key,
    required this.phone,
    required this.otp,
  });

  @override
  State<CreatePasswordForm> createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  Future<void> _resetPassword() async {
    try {
      debugPrint('WIDGET PHONE: ${widget.phone}');
      debugPrint('WIDGET OTP: ${widget.otp}');

      final response = await ApiService().resetPassword(
        phone: widget.phone,
        otp: widget.otp,
        password: _passwordController.text,
      );

      debugPrint('RESET RESPONSE: $response');

      if (response['success'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CongratulationsView(),
          ),
        );
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint('STATUS CODE: ${e.response?.statusCode}');
        debugPrint('RESPONSE: ${e.response?.data}');
      }

      debugPrint('RESET PASSWORD ERROR: $e');
    }
  }
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _eyeIcon(VoidCallback onTap) {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.mdi_eye_off_Icon,
        width: 22,
        height: 22,
        colorFilter: ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
      ),
      onPressed: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SignupFieldLabel(label: 'Password'),
        LoginTextField(
          controller: _passwordController,
          hintText: '••••••••••••••',
          prefixIconPath: AppIcons.Password_Icon,
          obscureText: _obscurePassword,
          suffixIcon: _eyeIcon(
            () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),

        const SignupFieldLabel(label: 'Confirm Password'),
        LoginTextField(
          controller: _confirmPasswordController,
          hintText: '••••••••••••••',
          prefixIconPath: AppIcons.Password_Icon,
          obscureText: _obscureConfirm,
          suffixIcon: _eyeIcon(
            () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ),
        const SizedBox(height: 28),
        CustomPrimaryAppButton(
          buttonText: 'Save Password',
          onTap: _resetPassword,
        ),
      ],
    );
  }
}
