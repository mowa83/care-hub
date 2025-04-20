import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:graduation_project/core/utils/colors.dart';

class ResendCodeWidget extends StatefulWidget {
  final Function onResend;
  final int initialCountdown;

  const ResendCodeWidget({
    super.key,
    required this.onResend,
    this.initialCountdown = 40,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResendCodeWidgetState createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  late int _secondsRemaining;
  late Timer _timer;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.initialCountdown;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isButtonEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _secondsRemaining = widget.initialCountdown;
      _isButtonEnabled = false;
    });
    _startTimer();
    widget.onResend();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: AppColors.grey),
        children: [
          TextSpan(text: "Didn't receive code? "),
          _isButtonEnabled
              ? TextSpan(
                  text: "Resend",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _resendCode,
                )
              : TextSpan(
                  text: "Resend ( $_secondsRemaining s )",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }
}
