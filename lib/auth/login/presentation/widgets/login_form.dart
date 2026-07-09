import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/auth/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:marketi/auth/login/presentation/widgets/login_remember_row.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Clear any existing token first
      await TokenStorage.clearToken();

      final response = await ApiService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final token = response['data']?['token'];
      if (token != null) {
        await TokenStorage.saveToken(token);
      }

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CustomNavigationbar()),
        (route) => false,
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
        children: [
          LoginTextField(
            controller: _emailController,
            hintText: 'Username or Email',
            prefixIconPath: AppIcons.Email_Icon,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email or username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          LoginTextField(
            controller: _passwordController,
            hintText: '••••••••••••••',
            prefixIconPath: AppIcons.Password_Icon,
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                AppIcons.mdi_eye_off_Icon,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 1),
          LoginRememberRow(
            rememberMe: _rememberMe,
            onRememberChanged: (val) => setState(() => _rememberMe = val ?? false),
            onForgotPassword: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordView()),
              );
            },
          ),
          const SizedBox(height: 14),
          _isLoading
              ? const CircularProgressIndicator()
              : CustomPrimaryAppButton(
                  buttonText: 'Log In',
                  onTap: _onLogin,
                ),
        ],
      ),
    );
  }
}
