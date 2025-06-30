import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/features/patient/home/presentation/views/home_view.dart';
import 'package:graduation_project/screens/patient/signup/service/verification_service.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_pin_code_field.dart';
import 'package:graduation_project/widgets/app_resend_code.dart';
import 'package:graduation_project/widgets/app_text.dart';

class VerifySignupScreen extends StatefulWidget {
  const VerifySignupScreen({super.key});

  @override
  State<VerifySignupScreen> createState() => _VerifySignupScreenState();
}

class _VerifySignupScreenState extends State<VerifySignupScreen> {
  String _code = '';
  final VerificationService _authService = VerificationService();

  void _onVerify() async {
    if (_code.length == 4) {
      try {
        final success = await _authService.activateAccount(_code);
        if (success) {
          RouteUtils.push(context, HomeView());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit code.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          const HeaderRow(
            text: 'Verify Your Email',
          ),
          SizedBox(height: 50),
          Center(
            child: AppText(
              title: 'Enter your email to receive a ',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          Center(
            child: AppText(
              title: 'verification code',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 60),
          AppPinCodeField(
            onChanged: (value) {
              setState(() {
                _code = value;
              });
            },
          ),
          SizedBox(height: 40),
          AppButton(
            title: 'Verify',
            onTap: _onVerify,
          ),
          SizedBox(height: 20),
          Center(
            child: ResendCodeWidget(
              initialCountdown: 40,
              onResend: () {},
            ),
          ),
        ],
      ),
    );
  }
}