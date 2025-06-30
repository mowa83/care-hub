import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/screens/reset_password/services/forget_password_model.dart';
import 'package:graduation_project/screens/reset_password/services/forget_password_service.dart';
import 'package:graduation_project/screens/reset_password/verify_password_screen.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final ForgetPasswordService _service = ForgetPasswordService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            const HeaderRow(text: 'Forget Password'),
            SizedBox(height: 40),
            Center(
              child: AppText(
                title: 'Enter your email  to receive a ',
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
            SizedBox(height: 80),
            AppHeadLine(photo: 'sms', labal: 'Email'),
            AppTextField(
              hint: 'Enter Your Email',
              validator: Validator.email,
              controller: emailController,
            ),
            SizedBox(height: 40),
            AppButton(
              title: 'Send',
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    final request = ForgetPasswordModel(email: emailController.text.trim());
                    await _service.sendResetPasswordEmail(request);
                    RouteUtils.push(context, VerifyPasswordScreen());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

