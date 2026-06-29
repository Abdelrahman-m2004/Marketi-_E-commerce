import 'package:flutter/material.dart';
import 'package:marketi/auth/login/presentation/widgets/login_remember_row.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginTextField(
          controller: _emailController,
          hintText: 'Username or Email',
          prefixIconPath: AppIcons.Email_Icon,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        LoginTextField(
          controller: _passwordController,
          hintText: '••••••••••••••',
          prefixIconPath: AppIcons.Password_Icon,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              AppIcons.mdi_eye_off_Icon,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(AppColors.Gray_Scale, BlendMode.srcIn),
            ),
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
        ),
        const SizedBox(height: 1),
        LoginRememberRow(
          rememberMe: _rememberMe,
          onRememberChanged: (val) => setState(() => _rememberMe = val ?? false),
          onForgotPassword: () {
            // TODO: Navigate to forgot password
          },
        ),
        const SizedBox(height: 14),
        CustomPrimaryAppButton(
          buttonText: 'Log In',
          onTap: () {
            // TODO: Handle login
          },
        ),
      ],
    );
  }
}
