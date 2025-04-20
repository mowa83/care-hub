import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/screens/patient/login/chronic_diseases_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/app_pin_code_field.dart';
import 'package:graduation_project/widgets/app_resend_code.dart';
import 'package:graduation_project/widgets/app_text.dart';

class VerifySignupScreen extends StatelessWidget {
  const VerifySignupScreen({super.key});

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
            title: 'Enter your email  to receive a ',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.grey,
          )),
          Center(
              child: AppText(
            title: 'verification code',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.grey,
          )),
          SizedBox(height: 60),
          AppPinCodeField(),
          SizedBox(height: 40),
          AppButton(
            title: 'Verify',
            onTap: () => RouteUtils.push(context, ChronicDiseasesScreen()),
          ),
          SizedBox(
            height: 20,
          ),
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
