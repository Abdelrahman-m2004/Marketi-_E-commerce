import 'package:flutter/material.dart';
import 'package:marketi/auth/create_new_password/presentation/views/create_new_password_view.dart';
import 'package:marketi/auth/verification/presentation/widgets/otp_input_field.dart';
import 'package:marketi/auth/verification/presentation/widgets/otp_timer.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:marketi/core/Network/error_handler.dart';
import 'package:marketi/core/common/widget/app_snackbar.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';

class OtpForm extends StatefulWidget {
  final String phone;

  const OtpForm({super.key, required this.phone});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  String get _otpCode => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length < 6) {
      AppSnackbar.showError(context, 'Please enter the 6 digit code');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ApiService().verifyOtp(
        phone: widget.phone,
        otp: _otpCode,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateNewPasswordView(
            phone: widget.phone,
            otp: _otpCode,
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
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OtpInputField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  nextFocus: index < 5 ? _focusNodes[index + 1] : null,
                  prevFocus: index > 0 ? _focusNodes[index - 1] : null,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 18),
        _isLoading
            ? const CircularProgressIndicator()
            : CustomPrimaryAppButton(
                buttonText: 'Verify Code',
                onTap: _verifyOtp,
              ),
        const SizedBox(height: 18),
        OtpTimer(
          onResend: () {
            // TODO: Handle resend code
          },
        ),
      ],
    );
  }
}
