import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/reset_password/reset_password_screen.dart';
import 'package:graduation_project/screens/reset_password/services/verify_password_services.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_pin_code_field.dart';
import 'package:graduation_project/widgets/app_resend_code.dart';
import 'package:graduation_project/widgets/app_text.dart';

class VerifyPasswordScreen extends StatefulWidget {
  const VerifyPasswordScreen({super.key});

  @override
  State<VerifyPasswordScreen> createState() => _VerifyPasswordScreenState();
}

class _VerifyPasswordScreenState extends State<VerifyPasswordScreen> {
  String _code = '';
  final VerifyPasswordServices _authService = VerifyPasswordServices();

  void _onVerify() async {
    if (_code.length == 4) {
      try {
        final success = await _authService.activateAccount(_code);
        if (success) {
          RouteUtils.push(context,  ResetPasswordScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification failed. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit code.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const HeaderRow(text: 'Verify Your Email'),
          const SizedBox(height: 50),
          Center(
            child: AppText(
              title: 'Enter the code sent to your email',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 60),
          AppPinCodeField(
            onChanged: (value) {
              setState(() {
                _code = value;
              });
            },
          ),
          const SizedBox(height: 40),
          AppButton(
            title: 'Verify',
            onTap: _onVerify,
          ),
          const SizedBox(height: 20),
          // Center(
          //   child: ResendCodeWidget(
          //     initialCountdown: 40,
          //     onResend: () {
              
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
