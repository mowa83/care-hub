import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/choose_row.dart';
import 'package:graduation_project/views/verify_your_email/view.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import '../../core/route_utils/route_utils.dart';
import '../../core/utils/validator.dart';
import '../../widgets/app_text.dart';
import '../../widgets/app_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            const ChooseRow(
              text: 'Forget Password',
            ),
            SizedBox(
              height: 40,
            ),
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
            SizedBox(height: 80),
            AppHeadLine(photo: 'sms', labal: 'Email'),
            AppTextField(
              hint: 'Enter Your Email',
              validator: Validator.email,
            ),
            SizedBox(height: 40),
            AppButton(
              title: 'Send',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  RouteUtils.push(context, VerifyYourEmailView());
                } else {
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
