import 'dart:async';
import 'package:expense_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback onResend;
  final int seconds;

  const OtpTimer({super.key, required this.onResend, this.seconds = 60});

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late int _timeLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = widget.seconds;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft <= 1) {
        timer.cancel();
      }
      setState(() {
        _timeLeft--;
      });
    });
  }

  void _handleResend() {
    widget.onResend();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft > 0) {
      return Text(
        "Resend OTP in ${_timeLeft}s",
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      );
    }

    return GestureDetector(
      onTap: _handleResend,
      child: const Text(
        "Resend OTP",
        style: TextStyle(color: AppColors.blue, fontSize: 16),
      ),
    );
  }
}
