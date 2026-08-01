import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/auth/congratulations/presentation/views/congratulations_view.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePasswordForm extends StatefulWidget {
  final String phone;
  final String otp;
  final String resetToken;

  const CreatePasswordForm({
    super.key,
    required this.phone,
    required this.otp,
    this.resetToken = '',
  });

  @override
  State<CreatePasswordForm> createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  String? _lastPasswordHash;

  @override
  void initState() {
    super.initState();
    _loadLastPasswordInfo();
  }

  Future<void> _loadLastPasswordInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _lastPasswordHash = prefs.getString('last_pwd_hint_${widget.phone}');
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

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await ApiService().resetPassword(
        phone: widget.phone,
        otp: widget.otp,
        password: _passwordController.text,
        resetToken: widget.resetToken,
      );

      if (!mounted) return;

      if (response['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        final hint =
            '${_passwordController.text.length}_${_passwordController.text[0]}';
        await prefs.setString('last_pwd_hint_${widget.phone}', hint);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CongratulationsView()),
        );
      } else {
        AppSnackbar.showError(
          context,
          response['message'] ?? 'Something went wrong',
        );
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError(context, ErrorHandler.parse(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter a password';
    if (v.contains(' ')) return 'Password cannot contain spaces';
    if (v.length < 8) return 'Password must be at least 8 characters';
    if (!v.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!v.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (_lastPasswordHash != null) {
      final currentHint = '${v.length}_${v[0]}';
      if (currentHint == _lastPasswordHash) {
        return 'New password must be different from your previous password';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignupFieldLabel(label: 'New Password'),
          const SizedBox(height: 6),
          LoginTextField(
            controller: _passwordController,
            hintText: '••••••••••••••',
            prefixIconPath: AppIcons.Password_Icon,
            obscureText: _obscurePassword,
            validator: _validatePassword,
            suffixIcon: _eyeIcon(
              () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 16),
          const SignupFieldLabel(label: 'Confirm New Password'),
          const SizedBox(height: 6),
          LoginTextField(
            controller: _confirmPasswordController,
            hintText: '••••••••••••••',
            prefixIconPath: AppIcons.Password_Icon,
            obscureText: _obscureConfirm,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please confirm your password';
              if (v != _passwordController.text) return 'Passwords do not match';
              return null;
            },
            suffixIcon: _eyeIcon(
              () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          const SizedBox(height: 28),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomPrimaryAppButton(
                  buttonText: 'Save Password',
                  onTap: _resetPassword,
                ),
        ],
      ),
    );
  }
}
