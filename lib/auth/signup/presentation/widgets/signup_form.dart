import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_phone_field.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_navigationbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String _countryCode = '+20';

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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

  Future<void> _onSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Clear any existing token first
      await TokenStorage.clearToken();

      // Register
      final registerResponse = await ApiService().register(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        phone: _phoneController.text.trim(),
        countryPhoneCode: _countryCode,
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final registerToken = registerResponse['data']?['token'];
      if (registerToken != null) {
        await TokenStorage.saveToken(registerToken);
      }

      // Login to get fresh token
      final loginResponse = await ApiService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final loginToken = loginResponse['data']?['token'];
      if (loginToken != null) {
        await TokenStorage.saveToken(loginToken);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignupFieldLabel(label: 'Your Name'),
          LoginTextField(
            controller: _nameController,
            hintText: 'Full Name',
            prefixIconPath: AppIcons.Name_Icon,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your full name';
              if (v.trim().length < 3) return 'Name must be at least 3 characters';
              if (RegExp(r'^[0-9]+$').hasMatch(v.trim())) {
                return 'Name cannot be numbers only';
              }
              if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(v.trim())) {
                return 'Name must contain letters only';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          const SignupFieldLabel(label: 'Username'),
          LoginTextField(
            controller: _usernameController,
            hintText: 'Username',
            prefixIconPath: AppIcons.User_Icon,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter a username';
              if (v.trim().length < 3) return 'Username must be at least 3 characters';
              if (RegExp(r'^[0-9]+$').hasMatch(v.trim())) {
                return 'Username cannot be numbers only';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          const SignupFieldLabel(label: 'Phone Number'),
          SignupPhoneField(
            controller: _phoneController,
            onCountryCodeChanged: (code) => setState(() => _countryCode = code),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your phone number';
              final digits = v.replaceAll(RegExp(r'\D'), '');
              if (digits.length != 11) return 'Phone number must be exactly 11 digits';
              return null;
            },
          ),
          const SizedBox(height: 8),
          const SignupFieldLabel(label: 'Email'),
          LoginTextField(
            controller: _emailController,
            hintText: 'You@gmail.com',
            prefixIconPath: AppIcons.Email_Icon,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your email';
              final emailRegex = RegExp(
                  r'^[a-zA-Z][a-zA-Z0-9._%+\-]*@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(v.trim())) {
                return 'Please enter a valid email (e.g. user@example.com)';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          const SignupFieldLabel(label: 'Password'),
          LoginTextField(
            controller: _passwordController,
            hintText: '••••••••••••••',
            prefixIconPath: AppIcons.Password_Icon,
            obscureText: _obscurePassword,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter a password';
              if (v.contains(' ')) return 'Password cannot contain spaces';
              if (v.length < 8) return 'Password must be at least 8 characters';
              if (!v.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one uppercase letter';
              }
              if (!v.contains(RegExp(r'[0-9]'))) {
                return 'Password must contain at least one number';
              }
              return null;
            },
            suffixIcon: _eyeIcon(
              () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: 8),
          const SignupFieldLabel(label: 'Confirm Password'),
          LoginTextField(
            controller: _confirmPasswordController,
            hintText: '••••••••••••••',
            prefixIconPath: AppIcons.Password_Icon,
            obscureText: _obscureConfirmPassword,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please confirm your password';
              if (v != _passwordController.text) return 'Passwords do not match';
              return null;
            },
            suffixIcon: _eyeIcon(
              () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
          const SizedBox(height: 12),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomPrimaryAppButton(
                  buttonText: 'Sign Up',
                  onTap: _onSignUp,
                ),
        ],
      ),
    );
  }
}
