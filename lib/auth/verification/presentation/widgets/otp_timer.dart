import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/core/theming/colors.dart';

class OtpTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback onResend;

  const OtpTimer({
    super.key,
    this.seconds = 60,
    required this.onResend,
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _onResendTap() {
    setState(() => _remainingSeconds = widget.seconds);
    _timer?.cancel();
    _startTimer();
    widget.onResend();
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formattedTime,
          style: AppFonts.titleMedium.copyWith(
            color: AppColors.navy,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _remainingSeconds == 0 ? _onResendTap : null,
          child: Text(
            'Resend Code',
            style: AppFonts.titleMedium.copyWith(
              color: _remainingSeconds == 0
                  ? AppColors.navy
                  : AppColors.light_gray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
