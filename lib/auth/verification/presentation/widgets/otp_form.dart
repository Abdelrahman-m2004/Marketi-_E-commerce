import 'package:flutter/material.dart';
import 'package:marketi/auth/create_new_password/presentation/views/create_new_password_view.dart';
import 'package:marketi/auth/verification/presentation/widgets/otp_input_field.dart';
import 'package:marketi/auth/verification/presentation/widgets/otp_timer.dart';
import 'package:marketi/core/common/widget/custom_primary_app_button.dart';
import 'package:marketi/core/Network/api_service.dart';
import 'package:dio/dio.dart';
class OtpForm extends StatefulWidget {
  final String phone;

  const OtpForm({
    super.key,
    required this.phone,
  });
  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String get otpCode => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
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
        CustomPrimaryAppButton(
          buttonText: 'Verify Code',
          onTap: () async {
            try {
              debugPrint("PHONE: ${widget.phone}");
              debugPrint("OTP: $otpCode");

              final response = await ApiService().verifyOtp(
                phone: widget.phone,
                otp: otpCode,
              );

              debugPrint("VERIFY RESPONSE: $response");

              if (!mounted) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPasswordView(
                    phone: widget.phone,
                    otp: otpCode,
                  ),
                ),
              );
            } catch (e) {
              if (e is DioException) {
                debugPrint("STATUS CODE: ${e.response?.statusCode}");
                debugPrint("RESPONSE: ${e.response?.data}");
              }

              debugPrint("ERROR: $e");

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
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
