import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/auth/login/presentation/widgets/login_text_field.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_field_label.dart';
import 'package:marketi/auth/signup/presentation/widgets/signup_phone_field.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/theming/colors.dart';
import 'package:marketi/core/theming/icons.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/token_storage.dart';
class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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

  Widget _eyeIcon(bool obscure, VoidCallback onTap) {
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
        const SignupFieldLabel(label: 'Your Name'),
        LoginTextField(
          controller: _nameController,
          hintText: 'Full Name',
          prefixIconPath: AppIcons.Name_Icon,
        ),
        const SizedBox(height: 8),
        const SignupFieldLabel(label: 'Username'),
        LoginTextField(
          controller: _usernameController,
          hintText: 'Username',
          prefixIconPath: AppIcons.User_Icon,
        ),
        const SizedBox(height: 8),
        const SignupFieldLabel(label: 'Phone Number'),
        SignupPhoneField(controller: _phoneController),
        const SizedBox(height: 8),
        const SignupFieldLabel(label: 'Email'),
        LoginTextField(
          controller: _emailController,
          hintText: 'You@gmail.com',
          prefixIconPath: AppIcons.Email_Icon,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 8),
        const SignupFieldLabel(label: 'Password'),
        LoginTextField(
          controller: _passwordController,
          hintText: '••••••••••••••',
          prefixIconPath: AppIcons.Password_Icon,
          obscureText: _obscurePassword,
          suffixIcon: _eyeIcon(
            _obscurePassword,
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
          suffixIcon: _eyeIcon(
            _obscureConfirmPassword,
            () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),
        ),
        const SizedBox(height: 12),
        CustomPrimaryAppButton(
          buttonText: 'Sign Up',
          onTap: () async {
            try {
              if (_passwordController.text !=
                  _confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                  ),
                );
                return;
              }

              final response = await ApiService().register(
                name: _nameController.text,
                username: _usernameController.text,
                phone: _phoneController.text,
                countryPhoneCode: '+966',
                email: _emailController.text,
                password: _passwordController.text,
              );

              final token = response['data']['token'];

              await TokenStorage.saveToken(token);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Register Success'),
                ),
              );

              print(await TokenStorage.getToken());

            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
