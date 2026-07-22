import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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

  static const String _rememberMeKey = 'remember_me';

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final remembered = prefs.getBool(_rememberMeKey) ?? false;
    if (remembered) {
      final savedEmail = prefs.getString('saved_email') ?? '';
      setState(() {
        _rememberMe = remembered;
        if (savedEmail.isNotEmpty) _emailController.text = savedEmail;
      });
    }
  }

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
      await TokenStorage.clearToken();

      final response = await ApiService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // تحقق من نجاح الـ response
      final bool success = response['success'] == true;
      if (!success) {
        final msg = response['message']?.toString() ?? 'Login failed. Please try again.';
        if (!mounted) return;
        AppSnackbar.showError(context, msg);
        return;
      }

      // استخرج التوكن من أي مستوى ممكن
      final token = response['data']?['token'] ?? response['token'];
      if (token == null || token.toString().isEmpty) {
        if (!mounted) return;
        AppSnackbar.showError(context, 'Login failed. No token received.');
        return;
      }

      await TokenStorage.saveToken(token.toString());

      // Save remember me preference
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setBool(_rememberMeKey, true);
        await prefs.setString('saved_email', _emailController.text.trim());
      } else {
        await prefs.setBool(_rememberMeKey, false);
        await prefs.remove('saved_email');
        // If not remembered, clear token on next cold start
        await prefs.setBool('session_only', true);
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
              if (value.contains('@')) {
                final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid email address';
                }
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
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one uppercase letter';
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Password must contain at least one number';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                AppIcons.mdi_eye_off_Icon,
                width: 22,
                height: 22,
                colorFilter:
                    ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 1),
          LoginRememberRow(
            rememberMe: _rememberMe,
            onRememberChanged: (val) =>
                setState(() => _rememberMe = val ?? false),
            onForgotPassword: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ForgotPasswordView()),
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
